From: Francis Daly <francis@daoine.org>
Subject: [PATCH] Some doc typo fixes
Date: Wed, 7 Jun 2006 13:56:45 +0100
Message-ID: <20060607125644.GT29682@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 07 14:57:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnxai-0004ba-O5
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 14:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFGM4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFGM4s
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 08:56:48 -0400
Received: from craic.sysops.org ([217.75.2.2]:31975 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1750761AbWFGM4s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 08:56:48 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k57Cuj7C030148
	for <git@vger.kernel.org>; Wed, 7 Jun 2006 13:56:45 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/1517/Wed Jun  7 01:05:07 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.5
X-Spam-Checker-Version: SpamAssassin 3.0.5 (2005-11-28) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21435>


All should be clear enough, except perhaps committish / commitish.
I just kept the more-used one within the current docs.

Signed-off-by: Francis Daly <francis@daoine.org>


---

271f459c2fec6898d913bbc040a71be067e0d009
 Documentation/config.txt               |    6 +++---
 Documentation/cvs-migration.txt        |    2 +-
 Documentation/everyday.txt             |    2 +-
 Documentation/git-check-ref-format.txt |    2 +-
 Documentation/git-describe.txt         |    2 +-
 Documentation/git-name-rev.txt         |    2 +-
 Documentation/git-p4import.txt         |    2 +-
 Documentation/git-read-tree.txt        |    2 +-
 Documentation/hooks.txt                |    2 +-
 Documentation/tutorial.txt             |    2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

271f459c2fec6898d913bbc040a71be067e0d009
diff --git a/Documentation/config.txt b/Documentation/config.txt
index c861c6c..4ce7867 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -113,12 +113,12 @@ gitcvs.logfile::
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
-	over HTTPS. Can be overriden by the 'GIT_SSL_NO_VERIFY' environment
+	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
 	variable.
 
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
-	over HTTPS. Can be overriden by the 'GIT_SSL_CERT' environment
+	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
 	variable.
 
 http.sslKey::
@@ -133,7 +133,7 @@ http.sslCAInfo::
 
 http.sslCAPath::
 	Path containing files with the CA certificates to verify the peer
-	with when fetching or pushing over HTTPS. Can be overriden
+	with when fetching or pushing over HTTPS. Can be overridden
 	by the 'GIT_SSL_CAPATH' environment variable.
 
 http.maxRequests::
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 826d089..1fbca83 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -106,7 +106,7 @@ Make sure committers have a umask of at 
 they create are writable and searchable by other group members.
 
 Suppose this repository is now set up in /pub/repo.git on the host
-foo.com.  Then as an individual commiter you can clone the shared
+foo.com.  Then as an individual committer you can clone the shared
 repository:
 
 ------------------------------------------------
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 6745ab5..b935c18 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -45,7 +45,7 @@ Everybody uses these commands to feed an
 
   * gitlink:git-fsck-objects[1] to validate the repository.
 
-  * gitlink:git-prune[1] to garbage collect crufts in the
+  * gitlink:git-prune[1] to garbage collect cruft in the
     repository.
 
   * gitlink:git-repack[1] to pack loose objects for efficiency.
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 3ea720d..cb9c162 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -20,7 +20,7 @@ a tag is stored under `$GIT_DIR/refs/tag
 imposes the following rules on how refs are named:
 
 . It could be named hierarchically (i.e. separated with slash
-  `/`), but each of its component cannot begin with a dot `.`;
+  `/`), but each of its components cannot begin with a dot `.`;
 
 . It cannot have two consecutive dots `..` anywhere;
 
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 7a253ea..7cc14b7 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -21,7 +21,7 @@ object name of the commit.
 OPTIONS
 -------
 <committish>::
-	The object name of the comittish. 
+	The object name of the committish. 
 
 --all::
 	Instead of using only the annotated tags, use any ref
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ffaa004..39a1434 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -8,7 +8,7 @@ git-name-rev - Find symbolic names for g
 
 SYNOPSIS
 --------
-'git-name-rev' [--tags] ( --all | --stdin | <commitish>... )
+'git-name-rev' [--tags] ( --all | --stdin | <committish>... )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
index b8ff1e9..c198ff2 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -128,7 +128,7 @@ Therefore after the import you can use g
 Perforce number, eg. git show p4/327.
 
 The tag associated with the HEAD commit is also how `git-p4import`
-determines if their are new changes to incrementally import from the
+determines if there are new changes to incrementally import from the
 Perforce repository.
 
 If you import from a repository with many thousands of changes
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 02c7e99..d894f53 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -257,7 +257,7 @@ file that does not match stage 2.
 This is done to prevent you from losing your work-in-progress
 changes, and mixing your random changes in an unrelated merge
 commit.  To illustrate, suppose you start from what has been
-commited last to your repository:
+committed last to your repository:
 
 ----------------
 $ JC=`git-rev-parse --verify "HEAD^0"`
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index e3dde39..898b4aa 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -100,7 +100,7 @@ update
 This hook is invoked by `git-receive-pack` on the remote repository,
 which is happens when a `git push` is done on a local repository.
 Just before updating the ref on the remote repository, the update hook
-is invoked.  It's exit status determines the success or failure of
+is invoked.  Its exit status determines the success or failure of
 the ref update.
 
 The hook executes once for each ref to be updated, and takes
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index db56312..554ee0a 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -357,7 +357,7 @@ names.  For example:
 $ git branch stable v2.5 # start a new branch named "stable" based
 			 # at v2.5
 $ git reset --hard HEAD^ # reset your current branch and working
-			 # directory its state at HEAD^
+			 # directory to its state at HEAD^
 -------------------------------------
 
 Be careful with that last command: in addition to losing any changes
-- 
1.3.3.g63df-dirty

-- 
Francis Daly        francis@daoine.org
