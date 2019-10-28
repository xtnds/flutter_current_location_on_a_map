import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationOnMap(title: 'Current Location on Map'),
    );
  }

  
}

class LocationOnMap extends StatefulWidget {
  LocationOnMap({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LocationOnMapState createState() => _LocationOnMapState();
}




class _LocationOnMapState extends State<LocationOnMap> {

  static LatLng latLng;

  @override
  void initState(){
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position _position) {
          if (_position != null) {
            setState(() {
              latLng = LatLng(_position.latitude, _position.longitude,);
            });}});
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new FlutterMap(
        options: new MapOptions(

          center: new  LatLng(latLng.latitude,latLng.longitude),
          zoom: 7.0
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a','b','c']
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 100.0,
                height: 100.0,
                point: latLng, //_getCurrentLocation(),
                builder: (context)=> new Container(
                  child: Icon(Icons.location_on),

                )
              )

            ]
          )
        ],

      ),
    );
  }
}
