From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Documentation: Added [verse] to SYNOPSIS where necessary
Date: Fri, 18 May 2007 15:39:33 +0200
Message-ID: <11794955741820-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri May 18 15:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp2m0-0000WH-BP
	for gcvg-git@gmane.org; Fri, 18 May 2007 15:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbXERNp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 09:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbXERNp3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 09:45:29 -0400
Received: from mail19.bluewin.ch ([195.186.18.65]:57035 "EHLO
	mail19.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbXERNp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 09:45:29 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 May 2007 09:45:28 EDT
Received: from spinlock.ch (83.79.82.183) by mail19.bluewin.ch (Bluewin 7.3.121)
        id 4649A0C0000CDC32; Fri, 18 May 2007 13:39:34 +0000
Received: (nullmailer pid 9693 invoked by uid 1000);
	Fri, 18 May 2007 13:39:34 -0000
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47608>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Documentation/git-archive.txt       |    1 +
 Documentation/git-bundle.txt        |    1 +
 Documentation/git-fmt-merge-msg.txt |    1 +
 Documentation/git-name-rev.txt      |    1 +
 Documentation/git-rebase.txt        |    2 +-
 5 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index d3ca9a9..721e035 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -8,6 +8,7 @@ git-archive - Creates an archive of files from a named tree
 
 SYNOPSIS
 --------
+[verse]
 'git-archive' --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
 	      [--remote=<repo>] <tree-ish> [path...]
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 92e7a68..5051e2b 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -8,6 +8,7 @@ git-bundle - Move objects and refs by archive
 
 SYNOPSIS
 --------
+[verse]
 'git-bundle' create <file> [git-rev-list args]
 'git-bundle' verify <file>
 'git-bundle' list-heads <file> [refname...]
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index e560b30..4913c25 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -8,6 +8,7 @@ git-fmt-merge-msg - Produce a merge commit message
 
 SYNOPSIS
 --------
+[verse]
 git-fmt-merge-msg [--summary | --no-summary] <$GIT_DIR/FETCH_HEAD
 git-fmt-merge-msg [--summary | --no-summray] -F <file>
 
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5b5c4c8..d6c8bf8 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -8,6 +8,7 @@ git-name-rev - Find symbolic names for given revs
 
 SYNOPSIS
 --------
+[verse]
 'git-name-rev' [--tags] [--refs=<pattern>]
 	       ( --all | --stdin | <committish>... )
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2f417a8..753b275 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -7,8 +7,8 @@ git-rebase - Forward-port local commits to the updated upstream head
 
 SYNOPSIS
 --------
+[verse]
 'git-rebase' [-v] [--merge] [-C<n>] [--onto <newbase>] <upstream> [<branch>]
-
 'git-rebase' --continue | --skip | --abort
 
 DESCRIPTION
-- 
1.5.2.rc3.50.gfdcb7
