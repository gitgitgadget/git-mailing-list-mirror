From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Typo fixes.
Date: Sat, 15 Oct 2005 00:59:24 -0400
Message-ID: <1129352364.16454.1.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 15 07:00:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQe9B-0001OR-QJ
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 06:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVJOE71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 00:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVJOE71
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 00:59:27 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:59323 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751078AbVJOE71
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 00:59:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EQe8j-0004Xc-QM
	for git@vger.kernel.org; Sat, 15 Oct 2005 00:59:26 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EQe8i-0004Hi-Qh; Sat, 15 Oct 2005 00:59:24 -0400
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10126>

Signed-off-by: Pavel Roskin <proski@gnu.org>


---

 Documentation/make-cogito-asciidoc |    2 +-
 README.osx                         |    2 +-
 cg-commit                          |    2 +-
 cg-help                            |    2 +-
 cg-merge                           |    6 +++---
 cg-mkpatch                         |    4 ++--
 cg-restore                         |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

applies-to: a216c765a79537dd95d3ef4ac619e5968496bfb9
5324919b894f5a39436b3bdb163037c3a76a41cb
diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
index fc8111e..3a0d337 100755
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -119,7 +119,7 @@ LOCATION::
 
 COMMIT_ID, FROM_ID, TO_ID, BASE_COMMIT::
 	Indicates an ID resolving to a commit. The following expressions can
-	be used interchangably as IDs:
+	be used interchangeably as IDs:
 	- empty string, 'this' or 'HEAD' (current HEAD)
 	- branch name (as registered with $(man 1 cg-branch-add))
 	- tag name (as registered with $(man 1 cg-tag))
diff --git a/README.osx b/README.osx
index 8385cde..e82ef79 100644
--- a/README.osx
+++ b/README.osx
@@ -26,6 +26,6 @@ Recommendations:
 The gnu versions of "stat" and "date" are preferred over their BSD
 variants.
 
-"patch", "diff", "merge", "curl" and "rysnc" are required.  OS X.4
+"patch", "diff", "merge", "curl" and "rsync" are required.  OS X.4
 includes recent versions of these tools.  If you are not running X.4,
 you may wish to check this.
diff --git a/cg-commit b/cg-commit
index 4345bd5..83dcbe8 100755
--- a/cg-commit
+++ b/cg-commit
@@ -42,7 +42,7 @@
 # -f::
 #	Force the commit even when there's "nothing to commit", that is
 #	the tree is the same as the last time you committed, no changes
-#	happenned.
+#	happened.
 #
 # -N::
 #	Don't add the files to the object database, just update the caches
diff --git a/cg-help b/cg-help
index 62fb112..83b1a3f 100755
--- a/cg-help
+++ b/cg-help
@@ -97,7 +97,7 @@ $(print_command_listing $REGULAR_COMMAND
 Advanced (low-level or dangerous) commands:
 $(print_command_listing $ADVANCED_COMMANDS)
 
-These expressions can be used interchangably as "ID"s:
+These expressions can be used interchangeably as "ID"s:
 	empty string, "this" or "HEAD" (current HEAD)
 	branch name (as registered with cg-branch-add)
 	tag name (as registered with cg-tag)
diff --git a/cg-merge b/cg-merge
index 2770a9d..ee92651 100755
--- a/cg-merge
+++ b/cg-merge
@@ -40,7 +40,7 @@
 #
 # -c::
 #	Parameter specifies that you want to have tree merge never
-#	autocomitted, but want to review and commit it manually. This will
+#	autocommitted, but want to review and commit it manually. This will
 #	basically make cg-merge always behave like there were conflicts
 #	during the merge.
 #
@@ -52,7 +52,7 @@
 #	arguments:
 #		BRANCHNAME BASE CURHEAD MERGEDHEAD MERGETYPE
 #	MERGETYPE is either "forward" or "tree". The merge is
-#	cancelled if the script returns non-zero exit code.
+#	canceled if the script returns non-zero exit code.
 #
 # $GIT_DIR/hooks/merge-post::
 #	If the file exists and is executable it will be executed after
@@ -71,7 +71,7 @@ _git_requires_root=1
 prehook()
 {
 	if [ -x $_git/hooks/merge-pre ]; then
-		$_git/hooks/merge-pre "$branchname" "$base" "$head" "$branch" "$@" || die "merge cancelled by hook"
+		$_git/hooks/merge-pre "$branchname" "$base" "$head" "$branch" "$@" || die "merge canceled by hook"
 	fi
 }
 
diff --git a/cg-mkpatch b/cg-mkpatch
index 0cd136f..42a5125 100755
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -10,13 +10,13 @@
 # -d DIRNAME::
 #	Split the patches to separate files with their names in the
 #	format "%02d.patch", created in directory DIRNAME (will be
-#	created if non-existant). Note that this makes sense only
+#	created if non-existent). Note that this makes sense only
 #	when generating patch series, that is when you use the -r
 #	argument.
 #
 # -f FORMAT::
 #	Format string used for generating the patch filename when
-#	outputting the splitted-out patches (that is, passed the -d
+#	outputting the split-out patches (that is, passed the -d
 #	option). This is by default "%s/%02d-%s.patch". The first %s
 #	represents the directory name and %d represents the patch
 #	sequence number. The last %s is mangled first line of the
diff --git a/cg-restore b/cg-restore
index d4d49e9..8e61c92 100755
--- a/cg-restore
+++ b/cg-restore
@@ -14,7 +14,7 @@
 # This command is complementary to the `cg-reset` command, which
 # forcefully abandons all the changes in the working tree and
 # restores everything to a proper state (including unseeking,
-# cancelling merge in progress and rebuilding indexes).
+# canceling merge in progress and rebuilding indexes).
 #
 # OPTIONS
 # -------
---
0.99.8.GIT

-- 
Regards,
Pavel Roskin
