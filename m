From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] Refer users to git-rev-parse for revision specification syntax.
Date: Wed, 17 Jan 2007 21:08:09 -0500
Message-ID: <20070118020809.GB23488@spearce.org>
References: <834ec15f66b9f03b36643cac1c924dcf9bf92f41.1169086075.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 03:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7MhT-0000Us-77
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 03:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXARCIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 21:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXARCIO
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 21:08:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57660 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbXARCIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 21:08:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7Mh5-00012C-RY; Wed, 17 Jan 2007 21:08:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C46AB20FBAE; Wed, 17 Jan 2007 21:08:09 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <834ec15f66b9f03b36643cac1c924dcf9bf92f41.1169086075.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37058>

The revision specification syntax (sometimes referred to as
SHA1-expressions) is accepted almost everywhere in Git by
almost every tool.  Unfortunately it is only documented in
git-rev-parse.txt, and most users don't know to look there.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-cherry-pick.txt  |    2 ++
 Documentation/git-diff.txt         |    3 +++
 Documentation/git-format-patch.txt |    4 +++-
 Documentation/git-log.txt          |    3 +++
 Documentation/git-revert.txt       |    2 ++
 Documentation/git-show.txt         |    2 ++
 Documentation/gitk.txt             |    2 ++
 7 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 875edb6..3149d08 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -19,6 +19,8 @@ OPTIONS
 -------
 <commit>::
 	Commit to cherry-pick.
+	For a more complete list of ways to spell commits, see
+	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
 -e|--edit::
 	With this option, `git-cherry-pick` will let you edit the commit
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 8977877..6a098df 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -47,6 +47,9 @@ Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description can be
 any <tree-ish>.
 
+For a more complete list of ways to spell <commit>, see
+"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
+
 
 OPTIONS
 -------
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 23acb47..574cf76 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,9 @@ DESCRIPTION
 Prepare each commit between <since> and <until> with its patch in
 one file per commit, formatted to resemble UNIX mailbox format.
 If ..<until> is not specified, the head of the current working
-tree is implied.
+tree is implied.  For a more complete list of ways to spell
+<since> and <until>, see "SPECIFYING REVISIONS" section in
+gitlink:git-rev-parse[1].
 
 The output of this command is convenient for e-mail submission or
 for use with gitlink:git-am[1].
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 60610f9..b802946 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -34,6 +34,9 @@ include::pretty-formats.txt[]
 	Show only commits between the named two commits.  When
 	either <since> or <until> is omitted, it defaults to
 	`HEAD`, i.e. the tip of the current branch.
+	For a more complete list of ways to spell <since>
+	and <until>, see "SPECIFYING REVISIONS" section in
+	gitlink:git-rev-parse[1].
 
 -p::
 	Show the change the commit introduces in a patch form.
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 71f7815..8081bba 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -19,6 +19,8 @@ OPTIONS
 -------
 <commit>::
 	Commit to revert.
+	For a more complete list of ways to spell commit names, see
+	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
 -e|--edit::
 	With this option, `git-revert` will let you edit the commit
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index c210b9a..9051951 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -32,6 +32,8 @@ OPTIONS
 -------
 <object>::
 	The name of the object to show.
+	For a more complete list of ways to spell object names, see
+	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
 include::pretty-formats.txt[]
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index f1aeb07..6e2a878 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -47,6 +47,8 @@ frequently used options.
 	meaning show from the given revision and back, or it can be a range in
 	the form "'<from>'..'<to>'" to show all revisions between '<from>' and
 	back to '<to>'. Note, more advanced revision selection can be applied.
+	For a more complete list of ways to spell object names, see
+	"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
 
 <path>::
 
-- 
1.5.0.rc1.g556b
