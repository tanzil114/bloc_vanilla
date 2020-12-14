import 'dart:async';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  // State Stream Controller
  StreamController _counterStateController = StreamController<int>();
  // Private Sink
  StreamSink<int> get _inCounter => _counterStateController.sink;
  // Public stream
  Stream<int> get counter => _counterStateController.stream;

  // Event Stream Controller
  StreamController _counterEventController = StreamController<CounterEvent>();
  // Public Sink
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
