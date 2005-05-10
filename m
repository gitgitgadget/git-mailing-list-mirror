From: David Greaves <david@dgreaves.com>
Subject: [PATCH 2/4] split core-git.txt and update
Date: Tue, 10 May 2005 22:32:37 +0100
Message-ID: <E1DVcLF-0004bq-Ec@ash.dgreaves.com>
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 23:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVch1-000374-BI
	for gcvg-git@gmane.org; Tue, 10 May 2005 23:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVEJWAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVEJV77
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 17:59:59 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:31668 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261810AbVEJVco (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 17:32:44 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 7593BE6DF2; Tue, 10 May 2005 22:31:33 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21829-07; Tue, 10 May 2005 22:31:33 +0100 (BST)
Received: from oak.dgreaves.com (modem-825.lion.dialup.pol.co.uk [217.135.163.57])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 9F68AE6DEF; Tue, 10 May 2005 22:31:29 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVcLF-0001NF-Ax; Tue, 10 May 2005 22:32:37 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DVcLF-0004bq-Ec; Tue, 10 May 2005 22:32:37 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rearrange commands in git.txt

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit ce5e04ff2f337c625ab070315b4f4f9d309f635e
tree 879e10daf0b047f9457cf6ba1d4183bbe1ba370c
parent 63ee9d429cd688ad364969b9f73aebc2377e6a05
author David Greaves <david@dgreaves.com> Tue, 10 May 2005 22:19:30 +0100
committer David Greaves <david@dgreaves.com> Tue, 10 May 2005 22:19:30 +0100

 Documentation/git.txt |   84 ++++++++++++++++++++++++++++----------------------
 1 files changed, 48 insertions(+), 36 deletions(-)

Index: Documentation/git.txt
===================================================================
--- b5f4b1411f20986abae0d2ff57cb15caa35fe947/Documentation/git.txt  (mode:100644)
+++ 879e10daf0b047f9457cf6ba1d4183bbe1ba370c/Documentation/git.txt  (mode:100644)
@@ -32,56 +32,30 @@
 the repository, the cache and the working fileset and those that
 interrogate and compare them.
 
+There are also some ancilliary programs that can be viewed as useful
+aids for using the core commands but which are unlikely to be used by
+SCMs layered over git.
+
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
-link:git-apply-patch-script.html[git-apply-patch-script]::
-	Sample script to apply the diffs from git-diff-*
-
 link:git-checkout-cache.html[git-checkout-cache]::
 	Copy files from the cache to the working directory
 
 link:git-commit-tree.html[git-commit-tree]::
 	Creates a new commit object
 
-link:git-convert-cache.html[git-convert-cache]::
-	Converts old-style GIT repository
-
-link:git-http-pull.html[git-http-pull]::
-	Downloads a remote GIT repository via HTTP
-
 link:git-init-db.html[git-init-db]::
 	Creates an empty git object database
 
-link:git-local-pull.html[git-local-pull]::
-	Duplicates another GIT repository on a local system
-
 link:git-merge-base.html[git-merge-base]::
 	Finds as good a common ancestor as possible for a merge
 
-link:git-merge-one-file-script.html[git-merge-one-file-script]::
-	The standard helper program to use with "git-merge-cache"
-
 link:git-mktag.html[git-mktag]::
 	Creates a tag object
 
-link:git-prune-script.html[git-prune-script]::
-	Prunes all unreachable objects from the object database
-
-link:git-pull-script.html[git-pull-script]::
-	Script used by Linus to pull and merge a remote repository
-
 link:git-read-tree.html[git-read-tree]::
 	Reads tree information into the directory cache
 
-link:git-resolve-script.html[git-resolve-script]::
-	Script used to merge two trees
-
-link:git-rpull.html[git-rpull]::
-	Pulls from a remote repository over ssh connection
-
-link:git-tag-script.html[git-tag-script]::
-	An example script to create a tag object signed with GPG
-
 link:git-update-cache.html[git-update-cache]::
 	Modifies the index or directory cache
 
@@ -108,9 +82,6 @@
 link:git-diff-tree.html[git-diff-tree]::
 	Compares the content and mode of blobs found via two tree objects
 
-link:git-diff-tree-helper.html[git-diff-tree-helper]::
-	Generates patch format output for git-diff-*
-
 link:git-export.html[git-export]::
 	Exports each commit and a diff against each of its parents
 
@@ -132,9 +103,6 @@
 link:git-rev-tree.html[git-rev-tree]::
 	Provides the revision tree for one or more commits
 
-link:git-rpush.html[git-rpush]::
-	Helper "server-side" program used by git-rpull
-
 link:git-tar-tree.html[git-tar-tree]::
 	Creates a tar archive of the files in the named tree
 
@@ -145,6 +113,50 @@
 touch the working file set - but in general they don't
 
 
+Ancilliary Commands
+-------------------
+Manipulators:
+
+link:git-apply-patch-script.html[git-apply-patch-script]::
+	Sample script to apply the diffs from git-diff-*
+
+link:git-convert-cache.html[git-convert-cache]::
+	Converts old-style GIT repository
+
+link:git-http-pull.html[git-http-pull]::
+	Downloads a remote GIT repository via HTTP
+
+link:git-local-pull.html[git-local-pull]::
+	Duplicates another GIT repository on a local system
+
+link:git-merge-one-file-script.html[git-merge-one-file-script]::
+	The standard helper program to use with "git-merge-cache"
+
+link:git-pull-script.html[git-pull-script]::
+	Script used by Linus to pull and merge a remote repository
+
+link:git-prune-script.html[git-prune-script]::
+	Prunes all unreachable objects from the object database
+
+link:git-resolve-script.html[git-resolve-script]::
+	Script used to merge two trees
+
+link:git-tag-script.html[git-tag-script]::
+	An example script to create a tag object signed with GPG
+
+link:git-rpull.html[git-rpull]::
+	Pulls from a remote repository over ssh connection
+
+Interogators:
+
+link:git-diff-tree-helper.html[git-diff-tree-helper]::
+	Generates patch format output for git-diff-*
+
+link:git-rpush.html[git-rpush]::
+	Helper "server-side" program used by git-rpull
+
+
+
 Terminology
 -----------
 see README for description



!-------------------------------------------------------------flip-


