import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Text Detection',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: MyHomePage(title: 'Real Time Text Detection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';

  bool isInitialized = false;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitialized = true;
    });
    super.initState();
  }

  _scan()async{
    _counter = '';
    List<OcrText> list = List();
    try {
      list = await FlutterMobileVision.read(
        waitTap: true,
        fps: 5,
        multiple: true,
      );
      
      for(OcrText text in list){
        setState(() {
        _counter += text.value + '\n';
      });
      }
    }catch(e){

    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
            ),
              
            Text(
              _counter,
              style: Theme.of(context).textTheme.headline4,
            ),
              
          ],
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scan,
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ), 
    );
  }
}
