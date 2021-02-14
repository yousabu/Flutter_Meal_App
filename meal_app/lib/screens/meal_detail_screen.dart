import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data%20(1).dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_detail';
  final Function toggleFavorites;
  final Function isfavoritemeal;

  const MealDetailScreen(this.toggleFavorites, this.isfavoritemeal);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectMeal.ingredients[index]),
                ),
              ),
              itemCount: selectMeal.ingredients.length,
            )),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}"),
                      ),
                      title: Text(selectMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorites(mealId),
        child: Icon(
          isfavoritemeal(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
