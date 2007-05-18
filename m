From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Documentation: Reformatted SYNOPSIS for several commands
Date: Fri, 18 May 2007 15:39:34 +0200
Message-ID: <11794955744178-git-send-email-matthias@spinlock.ch>
References: <11794955741820-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri May 18 15:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp2yA-0003co-I5
	for gcvg-git@gmane.org; Fri, 18 May 2007 15:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbXERN6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 09:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbXERN6E
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 09:58:04 -0400
Received: from mail15.bluewin.ch ([195.186.18.63]:38403 "EHLO
	mail15.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbXERN6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 09:58:03 -0400
Received: from spinlock.ch (83.79.82.183) by mail15.bluewin.ch (Bluewin 7.3.121)
        id 46499CAF000DF8A3; Fri, 18 May 2007 13:39:35 +0000
Received: (nullmailer pid 9696 invoked by uid 1000);
	Fri, 18 May 2007 13:39:34 -0000
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
In-Reply-To: <11794955741820-git-send-email-matthias@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47609>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Documentation/git-for-each-ref.txt |    5 ++++-
 Documentation/git-index-pack.txt   |    4 +++-
 Documentation/git-instaweb.txt     |    5 +++--
 Documentation/git-local-fetch.txt  |    4 +++-
 Documentation/git-p4import.txt     |    6 +++---
 Documentation/git-push.txt         |    4 +++-
 6 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f49b0d9..6df8e85 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -7,7 +7,10 @@ git-for-each-ref - Output information on each ref
 
 SYNOPSIS
 --------
-'git-for-each-ref' [--count=<count>]\* [--shell|--perl|--python|--tcl] [--sort=<key>]\* [--format=<format>] [<pattern>]
+[verse]
+'git-for-each-ref' [--count=<count>]\*
+                   [--shell|--perl|--python|--tcl]
+                   [--sort=<key>]\* [--format=<format>] [<pattern>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index b7a49b9..2269269 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -8,8 +8,10 @@ git-index-pack - Build pack index file for an existing packed archive
 
 SYNOPSIS
 --------
+[verse]
 'git-index-pack' [-v] [-o <index-file>] <pack-file>
-'git-index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>] [<pack-file>]
+'git-index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
+                 [<pack-file>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 52a6aa6..9df0ab2 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -7,8 +7,9 @@ git-instaweb - Instantly browse your working repository in gitweb
 
 SYNOPSIS
 --------
-'git-instaweb' [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
-
+[verse]
+'git-instaweb' [--local] [--httpd=<httpd>] [--port=<port>]
+               [--browser=<browser>]
 'git-instaweb' [--start] [--stop] [--restart]
 
 DESCRIPTION
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
index dd9e238..51389ef 100644
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -8,7 +8,9 @@ git-local-fetch - Duplicate another git repository on a local system
 
 SYNOPSIS
 --------
-'git-local-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path
+[verse]
+'git-local-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n]
+                  commit-id path
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
index 6edb9f1..714abbe 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -8,10 +8,10 @@ git-p4import - Import a Perforce repository into git
 
 SYNOPSIS
 --------
-`git-p4import` [-q|-v] [--notags] [--authors <file>] [-t <timezone>] <//p4repo/path> <branch>
-
+[verse]
+`git-p4import` [-q|-v] [--notags] [--authors <file>] [-t <timezone>]
+               <//p4repo/path> <branch>
 `git-p4import` --stitch <//p4repo/path>
-
 `git-p4import`
 
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f8cc2b5..e9ad106 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,9 @@ git-push - Update remote refs along with associated objects
 
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
+[verse]
+'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>]
+           [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
 
 DESCRIPTION
 -----------
-- 
1.5.2.rc3.50.gfdcb7
