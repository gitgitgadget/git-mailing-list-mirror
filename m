From: David Greaves <david@dgreaves.com>
Subject: [PATCH 3/4] split core-git.txt and update
Date: Tue, 10 May 2005 22:32:38 +0100
Message-ID: <E1DVcLG-0004g5-Ax@ash.dgreaves.com>
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 23:54:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVcfo-0002wZ-2K
	for gcvg-git@gmane.org; Tue, 10 May 2005 23:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVEJWAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVEJV7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 17:59:24 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:35508 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261816AbVEJVc4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 17:32:56 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 09A0EE6DEF; Tue, 10 May 2005 22:31:42 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22028-16; Tue, 10 May 2005 22:31:41 +0100 (BST)
Received: from oak.dgreaves.com (modem-825.lion.dialup.pol.co.uk [217.135.163.57])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 14EFAE6DEA; Tue, 10 May 2005 22:31:37 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVcLG-0001NK-7I; Tue, 10 May 2005 22:32:38 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DVcLG-0004g5-Ax; Tue, 10 May 2005 22:32:38 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update git environment variable docs
Update first section of command docs (Manipulation commands section)

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit 6cec96ce19223f1852a12632ad44007822e2a3de
tree 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c
parent ce5e04ff2f337c625ab070315b4f4f9d309f635e
author David Greaves <david@dgreaves.com> Tue, 10 May 2005 22:19:50 +0100
committer David Greaves <david@dgreaves.com> Tue, 10 May 2005 22:19:50 +0100

 Documentation/git-check-files.txt      |    4 +
 Documentation/git-commit-tree.txt      |    9 ++-
 Documentation/git-diff-tree-helper.txt |    4 +
 Documentation/git-init-db.txt          |    3 +
 Documentation/git-ls-files.txt         |    4 +
 Documentation/git-mktag.txt            |   23 ++++++-
 Documentation/git-read-tree.txt        |    6 +-
 Documentation/git.txt                  |   95 +++++++++++++++++++++++++++++----
 8 files changed, 128 insertions(+), 20 deletions(-)

Index: Documentation/git-check-files.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-check-files.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-check-files.txt  (mode:100644)
@@ -31,7 +31,9 @@
 Exits with a status code indicating success if all files are
 up-to-date.
 
-see also: link:git-update-cache.html[git-update-cache]
+See Also
+--------
+link:git-update-cache.html[git-update-cache]
 
 
 Author
Index: Documentation/git-commit-tree.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-commit-tree.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-commit-tree.txt  (mode:100644)
@@ -64,7 +64,14 @@
 entry is not provided via '<' redirection, "git-commit-tree" will just wait
 for one to be entered and terminated with ^D
 
-see also: link:git-write-tree.html[git-write-tree]
+Diagnostics
+-----------
+You don't exist. Go away!::
+    The passwd(5) gecos field couldn't be read
+
+See Also
+--------
+link:git-write-tree.html[git-write-tree]
 
 
 Author
Index: Documentation/git-diff-tree-helper.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-diff-tree-helper.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-diff-tree-helper.txt  (mode:100644)
@@ -30,7 +30,9 @@
 +
 would show a diff to bring the working file back to what is in the <tree>.
 
-See also the section on generating patches in link:git-diff-cache.html[git-diff-cache]
+See Also
+--------
+The section on generating patches in link:git-diff-cache.html[git-diff-cache]
 
 
 Author
Index: Documentation/git-init-db.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-init-db.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-init-db.txt  (mode:100644)
@@ -16,6 +16,9 @@
 This simply creates an empty git object database - basically a `.git`
 directory and `.git/object/??/` directories.
 
+If the 'GIT_DIR' environment variable is set then it specifies a path
+to use instead of `./.git` for the base of the repository.
+
 If the object storage directory is specified via the 'GIT_OBJECT_DIRECTORY'
 environment variable then the sha1 directories are created underneath -
 otherwise the default `.git/objects` directory is used.
Index: Documentation/git-ls-files.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-ls-files.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-ls-files.txt  (mode:100644)
@@ -83,7 +83,9 @@
 the user (or Cogito) to see what should eventually be recorded at the
 path. (see read-cache for more information on state)
 
-see also: link:read-cache.html[read-cache]
+See Also
+--------
+link:read-cache.html[read-cache]
 
 
 Author
Index: Documentation/git-mktag.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-mktag.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-mktag.txt  (mode:100644)
@@ -9,12 +9,29 @@
 
 SYNOPSIS
 --------
-'git-mktag'
+'git-mktag' < signature_file
 
 DESCRIPTION
 -----------
-Reads a tag contents from its standard input and creates a tag object.
-The input must be a well formed tag object.
+Reads a tag contents on standard input and creates a tag object
+that can also be used to sign other objects.
+
+The output is the new tag's <object> identifier.
+
+Tag Format
+----------
+A tag signature file has a very simple fixed format: three lines of
+
+  object <sha1>
+  type <typename>
+  tag <tagname>
+
+followed by some 'optional' free-form signature that git itself
+doesn't care about, but that can be verified with gpg or similar.
+
+The size of the full object is artificially limited to 8kB.  (Just
+because I'm a lazy bastard, and if you can't fit a signature in that
+size, you're doing something wrong)
 
 
 Author
Index: Documentation/git-read-tree.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git-read-tree.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git-read-tree.txt  (mode:100644)
@@ -14,7 +14,7 @@
 DESCRIPTION
 -----------
 Reads the tree information given by <tree> into the directory cache,
-but does not actually _update_ any of the files it "caches". (see:
+but does not actually *update* any of the files it "caches". (see:
 git-checkout-cache)
 
 Optionally, it can merge a tree into the cache or perform a 3-way
@@ -133,7 +133,9 @@
 worry about what is in the working directory, since it is never shown
 and never used.
 
-see also: link:git-write-tree.html[git-write-tree], link:git-ls-files.html[git-ls-files]
+See Also
+--------
+link:git-write-tree.html[git-write-tree]; link:git-ls-files.html[git-ls-files]
 
 
 Author
Index: Documentation/git.txt
===================================================================
--- 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git.txt  (mode:100644)
+++ 0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c/Documentation/git.txt  (mode:100644)
@@ -190,6 +190,44 @@
 	Indicates a filename - always relative to the root of
 	the tree structure GIT_INDEX_FILE describes.
 
+Symbolic Identifiers
+--------------------
+Any git comand accepting any <object> can also use the following symbolic notation:
+
+HEAD::
+	indicates the head of the repository (ie the contents of `$GIT_DIR/HEAD`)
+<tag>::
+	a valid tag 'name'+
+	(ie the contents of `$GIT_DIR/refs/tags/<tag>`)
+<head>::
+	a valid head 'name'+
+	(ie the contents of `$GIT_DIR/refs/heads/<head>`)
+<snap>::
+	a valid snapshot 'name'+
+	(ie the contents of `$GIT_DIR/refs/snap/<snap>`)
+
+
+File/Directory Structure
+------------------------
+The git-core manipulates the following areas in the directory:
+
+ .git/	       The base (overridden with $GIT_DIR)
+   objects/    The object base (overridden with $GIT_OBJECT_DIRECTORY)
+     ??/       'First 2 chars of object' directories
+
+It can interrogate (but never updates) the following areas:
+
+   refs/       Directories containing symbolic names for objects
+	       (each file contains the hex SHA1 + newline)
+     heads/    Commits which are heads of various sorts
+     tags/     Tags, by the tag name (or some local renaming of it)
+     snap/     ????
+   ...         Everything else isn't shared
+   HEAD        Symlink to refs/heads/<something>
+
+Higher level SCMs may provide and manage additional information in the
+GIT_DIR.
+
 Terminology
 -----------
 Each line contains terms used interchangeably
@@ -210,17 +248,52 @@
 ---------------------
 Various git commands use the following environment variables:
 
-- 'GIT_AUTHOR_NAME'
-- 'GIT_AUTHOR_EMAIL'
-- 'GIT_AUTHOR_DATE'
-- 'GIT_COMMITTER_NAME'
-- 'GIT_COMMITTER_EMAIL'
-- 'GIT_DIFF_OPTS'
-- 'GIT_EXTERNAL_DIFF'
-- 'GIT_INDEX_FILE'
-- 'GIT_OBJECT_DIRECTORY'
-- 'GIT_ALTERNATE_OBJECT_DIRECTORIES'
-
+The git Repository
+~~~~~~~~~~~~~~~~~~
+These environment variables apply to 'all' core git commands. Nb: it
+is worth noting that they may be used/overridden by SCMS sitting above
+git so take care if using Cogito etc
+
+'GIT_INDEX_FILE'::
+	This environment allows the specification of an alternate
+	cache/index file. If not specified, the default of
+	`$GIT_DIR/index` is used.
+
+'GIT_OBJECT_DIRECTORY'::
+	If the object storage directory is specified via this
+	environment variable then the sha1 directories are created
+	underneath - otherwise the default `$GIT_DIR/objects`
+	directory is used.
+
+'GIT_ALTERNATE_OBJECT_DIRECTORIES'::
+	Due to the immutable nature of git objects, old objects can be
+	archived into shared, read-only directories. This variable
+	specifies a ":" seperated list of git object directories which
+	can be used to search for git objects. New objects will not be
+	written to these directories.
+
+'GIT_DIR'::
+	If the 'GIT_DIR' environment variable is set then it specifies
+	a path to use instead of `./.git` for the base of the
+	repository.
+
+git Commits
+~~~~~~~~~~~
+'GIT_AUTHOR_NAME'::
+'GIT_AUTHOR_EMAIL'::
+'GIT_AUTHOR_DATE'::
+'GIT_COMMITTER_NAME'::
+'GIT_COMMITTER_EMAIL'::
+	see link:git-commit-tree.html[git-commit-tree]
+
+git Diffs
+~~~~~~~~~
+GIT_DIFF_OPTS::
+GIT_EXTERNAL_DIFF::
+	see the "generating patches" section in :
+	link:git-diff-cache.html[git-diff-cache];
+	link:git-diff-files.html[git-diff-files];
+	link:git-diff-tree.html[git-diff-tree]
 
 Author
 ------



!-------------------------------------------------------------flip-


