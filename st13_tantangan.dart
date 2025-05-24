import 'dart:collection';

class Node {
  int data;
  Node? left, right;
  Node(this.data);
}

class BinaryTree {
  Node? root;

  void insertLevelOrder(int data) {
    var newNode = Node(data);
    if (root == null) {
      root = newNode;
      return;
    }
    var queue = Queue<Node>()..add(root!);
    while (queue.isNotEmpty) {
      var curr = queue.removeFirst();
      if (curr.left == null) {
        curr.left = newNode;
        return;
      } else if (curr.right == null) {
        curr.right = newNode;
        return;
      } else {
        queue..add(curr.left!)..add(curr.right!);
      }
    }
  }

  void insertAfterTarget(int target, int data) {
    if (root == null) return;
    var queue = Queue<Node>()..add(root!);
    while (queue.isNotEmpty) {
      var curr = queue.removeFirst();
      if (curr.data == target) {
        var newNode = Node(data);
        if (curr.left == null) curr.left = newNode;
        else if (curr.right == null) curr.right = newNode;
        return;
      }
      if (curr.left != null) queue.add(curr.left!);
      if (curr.right != null) queue.add(curr.right!);
    }
  }

  List<int> inorder() {
    var result = <int>[], stack = <Node>[];
    var curr = root;
    while (curr != null || stack.isNotEmpty) {
      while (curr != null) {
        stack.add(curr);
        curr = curr.left;
      }
      curr = stack.removeLast();
      result.add(curr.data);
      curr = curr.right;
    }
    return result;
  }

  List<int> preorder() {
    if (root == null) return [];
    var result = <int>[], stack = <Node>[root!];
    while (stack.isNotEmpty) {
      var node = stack.removeLast();
      result.add(node.data);
      if (node.right != null) stack.add(node.right!);
      if (node.left != null) stack.add(node.left!);
    }
    return result;
  }

  List<int> postorder() {
    if (root == null) return [];
    var result = <int>[], s1 = <Node>[root!], s2 = <Node>[];
    while (s1.isNotEmpty) {
      var node = s1.removeLast();
      s2.add(node);
      if (node.left != null) s1.add(node.left!);
      if (node.right != null) s1.add(node.right!);
    }
    while (s2.isNotEmpty) {
      result.add(s2.removeLast().data);
    }
    return result;
  }
}
void main() {
  var tree = BinaryTree();
  tree.insertLevelOrder(6);
  tree.insertLevelOrder(7);
  tree.insertLevelOrder(8);
  tree.insertAfterTarget(6, 7);

  print("InOrder: ${tree.inorder()}");
  print("PreOrder: ${tree.preorder()}");
  print("PostOrder: ${tree.postorder()}");
}
