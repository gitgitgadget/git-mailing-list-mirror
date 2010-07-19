From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH 1/2] Documentation spelling fixes.
Date: Tue, 20 Jul 2010 00:17:17 +0300
Message-ID: <1279574238-16649-1-git-send-email-ville.skytta@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 23:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxiK-0001K9-HB
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966817Ab0GSVRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 17:17:22 -0400
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:40525 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966812Ab0GSVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 17:17:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri1.pp.htv.fi (Postfix) with ESMTP id B985321B01C
	for <git@vger.kernel.org>; Tue, 20 Jul 2010 00:17:19 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
	with ESMTP id mCqotRAMtuSa for <git@vger.kernel.org>;
	Tue, 20 Jul 2010 00:17:19 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs181085020.pp.htv.fi [82.181.85.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp5.welho.com (Postfix) with ESMTPS id 2E2F45BC002
	for <git@vger.kernel.org>; Tue, 20 Jul 2010 00:17:19 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151286>

---
 Documentation/config.txt               |   10 +++++-----
 Documentation/git-bisect-lk2009.txt    |    2 +-
 Documentation/git-commit.txt           |    4 ++--
 Documentation/git-cvsimport.txt        |    4 ++--
 Documentation/git-cvsserver.txt        |    4 ++--
 Documentation/git-hash-object.txt      |    2 +-
 Documentation/git-reset.txt            |    2 +-
 Documentation/gitrepository-layout.txt |    2 +-
 Documentation/urls.txt                 |    2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e75434b..e7e505d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -128,7 +128,7 @@ advice.*::
 		when writing commit messages. Default: true.
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
-		merge to avoid overwritting local changes.
+		merge to avoid overwriting local changes.
 		Default: true.
 	resolveConflict::
 		Advices shown by various commands when conflicts
@@ -418,7 +418,7 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.deltaBaseCacheLimit::
 	Maximum number of bytes to reserve for caching base objects
-	that multiple deltafied objects reference.  By storing the
+	that multiple deltified objects reference.  By storing the
 	entire decompressed base objects in a cache Git is able
 	to avoid unpacking and decompressing frequently used base
 	objects multiple times.
@@ -563,7 +563,7 @@ not necessarily be the current directory.
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
 	with parameter '--keep-cr'. In this case git-mailsplit will
-	not remove `\r` from lines ending with `\r\n`. Can be overrriden
+	not remove `\r` from lines ending with `\r\n`. Can be overridden
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
@@ -1002,7 +1002,7 @@ gitcvs.usecrlfattr::
 	If true, the server will look up the end-of-line conversion
 	attributes for files to determine the '-k' modes to use. If
 	the attributes force git to treat a file as text,
-	the '-k' mode will be left blank so cvs clients will
+	the '-k' mode will be left blank so CVS clients will
 	treat it as text. If they suppress text conversion, the file
 	will be set with '-kb' mode, which suppresses any newline munging
 	the client might otherwise do. If the attributes do not allow
@@ -1275,7 +1275,7 @@ instaweb.local::
 	be bound to the local IP (127.0.0.1).
 
 instaweb.modulepath::
-	The module path for an apache httpd used by linkgit:git-instaweb[1].
+	The module path for an Apache httpd used by linkgit:git-instaweb[1].
 
 instaweb.port::
 	The port number to bind the gitweb httpd to. See
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 86b3015..efbe379 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -971,7 +971,7 @@ logical change in each commit.
 The smaller the changes in your commit, the most effective "git
 bisect" will be. And you will probably need "git bisect" less in the
 first place, as small changes are easier to review even if they are
-only reviewed by the commiter.
+only reviewed by the committer.
 
 Another good idea is to have good commit messages. They can be very
 helpful to understand why some changes were made.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c28603e..42fb1f5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -130,11 +130,11 @@ OPTIONS
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
 	from making such a commit.  This option bypasses the safety, and
-	is primarily for use by foreign scm interface scripts.
+	is primarily for use by foreign SCM interface scripts.
 
 --allow-empty-message::
        Like --allow-empty this command is primarily for use by foreign
-       scm interface scripts. It allows you to create a commit with an
+       SCM interface scripts. It allows you to create a commit with an
        empty commit message without using plumbing commands like
        linkgit:git-commit-tree[1].
 
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 8bcd875..608cd63 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -188,7 +188,7 @@ ISSUES
 ------
 Problems related to timestamps:
 
- * If timestamps of commits in the cvs repository are not stable enough
+ * If timestamps of commits in the CVS repository are not stable enough
    to be used for ordering commits changes may show up in the wrong
    order.
  * If any files were ever "cvs import"ed more than once (e.g., import of
@@ -201,7 +201,7 @@ Problems related to branches:
 
  * Branches on which no commits have been made are not imported.
  * All files from the branching point are added to a branch even if
-   never added in cvs.
+   never added in CVS.
  * This applies to files added to the source branch *after* a daughter
    branch was created: if previously no commit was made on the daughter
    branch they will erroneously be added to the daughter branch in git.
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 7004dd2..5ee9f69 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -366,8 +366,8 @@ CRLF Line Ending Conversions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 By default the server leaves the '-k' mode blank for all files,
-which causes the cvs client to treat them as a text files, subject
-to crlf conversion on some platforms.
+which causes the CVS client to treat them as a text files, subject
+to CRLF conversion on some platforms.
 
 You can make the server use the end-of-line conversion attributes to
 set the '-k' modes for files by setting the `gitcvs.usecrlfattr`
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 6904739..11bf251 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -49,7 +49,7 @@ OPTIONS
 
 --no-filters::
 	Hash the contents as is, ignoring any input filter that would
-	have been chosen by the attributes mechanism, including crlf
+	have been chosen by the attributes mechanism, including CRLF
 	conversion. If the file is read from standard input then this
 	is always implied, unless the --path option is given.
 
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 645f0c1..a9d287f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -355,7 +355,7 @@ Keep changes in working tree while discarding some previous commits::
 Suppose you are working on something and you commit it, and then you
 continue working a bit more, but now you think that what you have in
 your working tree should be in another branch that has nothing to do
-with what you commited previously. You can start a new branch and
+with what you committed previously. You can start a new branch and
 reset it while keeping the changes in your work tree.
 +
 ------------
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 3cd32d6..eb3d040 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -16,7 +16,7 @@ You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
 `<project>.git` directory for a public 'bare' repository. It is
 also possible to have a working tree where `.git` is a plain
-ascii file containing `gitdir: <path>`, i.e. the path to the
+ASCII file containing `gitdir: <path>`, i.e. the path to the
 real git repository).
 
 objects::
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 1dcd1e7..2890194 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -25,7 +25,7 @@ The ssh and git protocols additionally support ~username expansion:
 - git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
 - {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
 
-For local respositories, also supported by git natively, the following
+For local repositories, also supported by git natively, the following
 syntaxes may be used:
 
 - /path/to/repo.git/
-- 
1.7.1.1
