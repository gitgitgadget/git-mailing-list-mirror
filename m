From: David Greaves <david@dgreaves.com>
Subject: [PATCH 3/5] Docs - include README in git.txt
Date: Sun, 22 May 2005 18:44:16 +0100
Message-ID: <E1DZuUq-0008Gc-O2@ash.dgreaves.com>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 19:44:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZuUD-0003o6-RI
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEVRou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVEVRou
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:44:50 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:35814 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261213AbVEVRoY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 13:44:24 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id E3940E6DBC; Sun, 22 May 2005 18:43:37 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10517-17; Sun, 22 May 2005 18:43:37 +0100 (BST)
Received: from oak.dgreaves.com (modem-1750.lemur.dialup.pol.co.uk [217.135.134.214])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 00D89E6D6F; Sun, 22 May 2005 18:43:35 +0100 (BST)
Received: from [10.0.0.90] (helo=ash.dgreaves.com)
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DZuUv-00016I-7j; Sun, 22 May 2005 18:44:21 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DZuUq-0008Gc-O2; Sun, 22 May 2005 18:44:16 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Include the README in the git.txt

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit e6d7c5341942fdd07d966efe36fde653167e84f0
tree 03ae742170ebaef9040fa8234e1d6752bad140ab
parent 6f657e57d7a5b941ed401365e23d78ff77f5ebcf
author David Greaves <david@dgreaves.com> Sat, 21 May 2005 21:27:41 +0100
committer David Greaves <david@dgreaves.com> Sat, 21 May 2005 21:27:41 +0100

 Documentation/git.txt |   46 +++++++++++++++++++++-------------------------
 1 files changed, 21 insertions(+), 25 deletions(-)

Index: Documentation/git.txt
===================================================================
--- c081754f951815c43bdd973ddc7e23365793e75e/Documentation/git.txt  (mode:100644)
+++ 03ae742170ebaef9040fa8234e1d6752bad140ab/Documentation/git.txt  (mode:100644)
@@ -1,6 +1,6 @@
 git(7)
 ======
-v0.1, May 2005
+May 2005
 
 NAME
 ----
@@ -16,9 +16,10 @@
 
 This is reference information for the core git commands.
 
-The link:README[] contains much useful definition and clarification
-info - read that first.  And of the commands, I suggest reading
-'git-update-cache' and 'git-read-tree' first - I wish I had!
+The Discussion section below contains much useful definition and
+clarification info - read that first.  And of the commands, I suggest
+reading link:git-update-cache.html[git-update-cache] and
+link:git-read-tree.html[git-read-tree] first - I wish I had!
 
 David Greaves <david@dgreaves.com>
 08/05/05
@@ -157,14 +158,10 @@
 
 
 
-Terminology
------------
-see README for description
-
-Identifier terminology
+Identifier Terminology
 ----------------------
 <object>::
-	Indicates any object sha1 identifier
+	Indicates the sha1 identifier for any type of object
 
 <blob>::
 	Indicates a blob object sha1 identifier
@@ -176,11 +173,10 @@
 	Indicates a commit object sha1 identifier
 
 <tree-ish>::
-	Indicates a tree, commit or tag object sha1 identifier.
-	A command that takes a <tree-ish> argument ultimately
-	wants to operate on a <tree> object but automatically
-	dereferences <commit> and <tag> that points at a
-	<tree>.
+	Indicates a tree, commit or tag object sha1 identifier.  A
+	command that takes a <tree-ish> argument ultimately wants to
+	operate on a <tree> object but automatically dereferences
+	<commit> and <tag> objects that point at a <tree>.
 
 <type>::
 	Indicates that an object type is required.
@@ -192,10 +188,12 @@
 
 Symbolic Identifiers
 --------------------
-Any git comand accepting any <object> can also use the following symbolic notation:
+Any git comand accepting any <object> can also use the following
+symbolic notation:
 
 HEAD::
-	indicates the head of the repository (ie the contents of `$GIT_DIR/HEAD`)
+	indicates the head of the repository (ie the contents of
+	`$GIT_DIR/HEAD`)
 <tag>::
 	a valid tag 'name'+
 	(ie the contents of `$GIT_DIR/refs/tags/<tag>`)
@@ -230,18 +228,12 @@
 
 Terminology
 -----------
-Each line contains terms used interchangeably
+Each line contains terms which you may see used interchangeably
 
  object database, .git directory
  directory cache, index
  id, sha1, sha1-id, sha1 hash
  type, tag
- blob, blob object
- tree, tree object
- commit, commit object
- parent
- root object
- changeset
 
 
 Environment Variables
@@ -295,9 +287,13 @@
 	link:git-diff-files.html[git-diff-files];
 	link:git-diff-tree.html[git-diff-tree]
 
+Discussion
+----------
+include::../README[]
+
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Linus Torvalds <torvalds@osdl.org> and the git-list <git@vger.kernel.org>.
 
 Documentation
 --------------
