From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Typo fixes and minor cleanups for the big "index"/"staging area patch
Date: Sat, 24 Apr 2010 01:59:59 -0400
Message-ID: <1272088799-22618-1-git-send-email-esr@thyrsus.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 08:00:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5YPZ-0003uY-Gu
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 08:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab0DXGAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 02:00:09 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54901
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab0DXGAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 02:00:08 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 33004479E92; Sat, 24 Apr 2010 02:00:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc2.12.gf7bd8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145657>

Should probably be merged with my last for commit purposes.

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 Documentation/config.txt               |    4 ++--
 Documentation/git-add.txt              |    4 ++--
 Documentation/git-checkout-index.txt   |    3 ++-
 Documentation/git-diff-index.txt       |    4 ++++
 Documentation/git-grep.txt             |    2 +-
 Documentation/git-merge.txt            |    4 ++--
 Documentation/git-read-tree.txt        |    4 ++--
 Documentation/gitcore-tutorial.txt     |   12 ++++++------
 Documentation/gitrepository-layout.txt |    2 +-
 9 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6abd34b..0b59592 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -283,7 +283,7 @@ proxy use, while defaulting to a common proxy for external domains.
 
 core.ignoreStat::
 	If true, commands which modify both the working tree and
-	thestaging area will mark the updated paths with the "assume
+	the staging area will mark the updated paths with the "assume
 	unchanged" bit in the staging area. These marked files are
 	then assumed to stay unchanged in the working copy, until you
 	mark them otherwise manually - Git will not detect the file
@@ -1437,7 +1437,7 @@ pack.threads::
 
 pack.indexVersion::
 	Specify the default pack index version (the "index" is the data
-        structure representing the staging area).  Valid values are 1 for
+	structure representing the staging area).  Valid values are 1 for
 	legacy pack index used by Git versions prior to 1.5.2, and 2 for
 	the new pack index with capabilities for packs larger than 4 GB
 	as well as proper protection against the repacking of corrupted
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index db0c9d9..2d150aa 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -28,7 +28,7 @@ the commit command, you must use the `add` command to add any new or
 modified files to the staging area.
 
 (Some git command names and options refer to the staging area as "the
-index", which is actually the way the staging are is implemented in
+index", which is actually the way the staging area is implemented in
 git plumbing.)
 
 This command can be performed multiple times before a commit.  It only
@@ -214,7 +214,7 @@ status::
 +
 It shows that foo.png has differences from HEAD (but that is
 binary so line count cannot be shown) and there is no
-difference between the staged0 copy and the working tree
+difference between the staged copy and the working tree
 version (if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
 other file, git-add--interactive.perl, has 403 lines added
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 24e70ff..2583c8a 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -21,7 +21,8 @@ Will copy all files listed from the staging area to the working directory
 (not overwriting existing files).
 
 The name of this command reflects the older terminology "index" for
-what is now called the staging area.
+what is now called the staging area. The "index file" is where the
+staging-area content is actually stored.
 
 OPTIONS
 -------
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 37ed959..53c3947 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -18,6 +18,10 @@ ignoring the stat state of the file on disk.  When paths are
 specified, compares only those named paths.  Otherwise all
 entries in the staging area are compared.
 
+The name of this command reflects the older terminology "index" for
+what is now called the staging area. The "index file" is where the
+staging-area content is actually stored.
+
 OPTIONS
 -------
 include::diff-options.txt[]
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0d2d688..e5d05e2 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -36,7 +36,7 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the staging area.  (This option name
 	reflects the fact that in the far past the staging area was
-        known as the "cache".)
+	known as the "cache".)
 
 --no-index::
 	Search files in the current directory, not just those tracked by git.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 85a87ad..d1c1173 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -123,9 +123,9 @@ happens:
 
 1. The `HEAD` pointer stays the same.
 2. The `MERGE_HEAD` ref is set to point to the other branch head.
-3. Paths that merged cleanly are updated both in the staging area file and
+3. Paths that merged cleanly are updated both in the staging area and
    in your working tree.
-4. For conflicting paths, the undex file representing the staging area 
+4. For conflicting paths, the index file representing the staging area 
    records up to three versions: stage 1 stores the version from the 
    common ancestor, stage 2 from `HEAD`, and stage 3 from `MERGE_HEAD` (you
    can inspect the stages with `git ls-files -u`).  The working
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index debc97b..9fdb6f9 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Reads the tree information given by <tree-ish> into the staging area,
-but does not actually *update* any of the files it "caches". (see:
+but does not actually *update* any of the files it stages. (see:
 linkgit:git-checkout-index[1])
 
 Optionally, it can merge a tree into the staging area, perform a
@@ -65,7 +65,7 @@ OPTIONS
 --aggressive::
 	Usually a three-way merge by 'git read-tree' resolves
 	the merge for really trivial cases and leaves other
-	cases unresolved in the staging area, so that Porcelains can
+	cases unresolved in the staging area, so that porcelains can
 	implement different merge policies.  This flag makes the
 	command to resolve a few more cases internally:
 +
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 2485a2c..2ba714c 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -371,8 +371,8 @@ have committed something, we can also learn to use a new command:
 'git diff-index'.
 
 Unlike 'git diff-files', which showed the difference between the
-staging area file and the working tree, 'git diff-index' shows the differences
-between a committed *tree* and either the staging area file or the working
+staging area and the working tree, 'git diff-index' shows the differences
+between a committed *tree* and either the staging area or the working
 tree. In other words, 'git diff-index' wants a tree to be diffed
 against, and before we did the commit, we couldn't do that, because we
 didn't have anything to diff against.
@@ -513,10 +513,10 @@ various diff-\* commands compare things.
                       |    |  diff-index --cached
                       |    |
           diff-index  |    V
-                      |  +--------------+
-                      |  | Staging area |
-                      |  |    "cache"   |
-                      |  +--------------+
+                      |  +---------+
+                      |  | Staging |
+                      |  |   Area  |
+                      |  +---------+  
                       |    ^
                       |    |
                       |    |  diff-files
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index a511e2c..abfca02 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -167,7 +167,7 @@ info/grafts::
 	by a space and terminated by a newline.
 
 info/exclude::
-	This file, by convention among Porcelains, stores the
+	This file, by convention among porcelains, stores the
 	exclude pattern list. `.gitignore` is the per-directory
 	ignore file.  'git status', 'git add', 'git rm' and
 	'git clean' look at it but the core git commands do not look
-- 
1.7.1.rc2.12.gf7bd8
