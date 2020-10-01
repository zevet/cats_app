import 'package:cat_app/stores/cat_api_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';

class Favorites extends StatelessWidget {
  final catApiStore = GetIt.instance.get<CatApiStore>();

  Favorites() {
    catApiStore.loadFavoriteImages();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text('Favoritos', style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),),
        ),
        SizedBox(height: 20,),
        Observer(
          builder: (_) => catApiStore.favoriteImages != null ? new StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            physics: ScrollPhysics(),
            padding: EdgeInsets.only(top: 40),
            itemCount: catApiStore.favoriteImages.length,
            itemBuilder: (BuildContext context, int index) => Image.network(catApiStore.favoriteImages[index].image.url),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ) : Center(
            child: CircularProgressIndicator(),
          ),
        )
    ],
    );
  }
}
