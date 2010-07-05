From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 3/3] Documentation: link to gitrevisions rather than git-rev-parse
Date: Mon,  5 Jul 2010 18:11:41 +0200
Message-ID: <38f9aae74cdb07aad5b65fd3c05e8ddaf91b943c.1278346173.git.git@drmicha.warpmail.net>
References: <cover.1278346173.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 18:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVoHy-0006e5-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 18:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab0GEQMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 12:12:42 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38986 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754521Ab0GEQMj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 12:12:39 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D98061185B6
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 12:12:38 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 05 Jul 2010 12:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=81/C3bUYXgytR3Amqgag8vIjY78=; b=hX3+dBHD2/OckpS6xDSWaAgpc3zclmjDfEao/TWM0I0l8BvIroO0BKCWg5uv98YoN3e2J3Eo4vxiOzOZ8sjCS8oxs8kWmivCPOt5Lwwqm9GQPr8xUwEnI5zZpBY6Tn5E15mj2Uj2B5Dx7HoYalWfeNt9lHFv/Qrmqh9p02ghfKE=
X-Sasl-enc: oDTAW7qNXFmRUib11M32pkfB9kNZNc8942smjh1AUfBi 1278346357
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EF7C74D9FC2;
	Mon,  5 Jul 2010 12:12:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <cover.1278346173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150277>

Currently, whenever we need documentation for revisions and ranges, we
link to the git-rev-parse man page, i.e. a plumbing man page, which has
this along with the documentation of all rev-parse modes.

Link to the new gitrevisions man page instead in all cases except
- when the actual git-rev-parse command is referred to or
- in very technical context (git-send-pack).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-cat-file.txt         |    2 +-
 Documentation/git-check-ref-format.txt |    2 +-
 Documentation/git-cherry-pick.txt      |    4 ++--
 Documentation/git-diff.txt             |    4 ++--
 Documentation/git-fast-import.txt      |    2 +-
 Documentation/git-format-patch.txt     |    2 +-
 Documentation/git-log.txt              |    3 +--
 Documentation/git-push.txt             |    2 +-
 Documentation/git-reflog.txt           |    2 +-
 Documentation/git-revert.txt           |    2 +-
 Documentation/git-show-branch.txt      |    2 +-
 Documentation/git-show.txt             |    2 +-
 Documentation/git.txt                  |    2 +-
 Documentation/gitcore-tutorial.txt     |    2 +-
 Documentation/gitk.txt                 |    2 +-
 Documentation/user-manual.txt          |    8 ++++----
 16 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 9ebbe94..a3f56b0 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -27,7 +27,7 @@ OPTIONS
 <object>::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
-	the "SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	the "SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
 
 -t::
 	Instead of the content, show the object type identified by
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 379eee6..f5c2e06 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -49,7 +49,7 @@ git imposes the following rules on how references are named:
 These rules make it easy for shell script based tools to parse
 reference names, pathname expansion by the shell when a reference name is used
 unquoted (by mistake), and also avoids ambiguities in certain
-reference name expressions (see linkgit:git-rev-parse[1]):
+reference name expressions (see linkgit:gitrevisions[1]):
 
 . A double-dot `..` is often used as in `ref1..ref2`, and in some
   contexts this notation means `{caret}ref1 ref2` (i.e. not in
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index ca485db..2cef579 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -20,8 +20,8 @@ OPTIONS
 -------
 <commit>...::
 	Commits to cherry-pick.
-	For a more complete list of ways to spell commits, see the
-	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	For a more complete list of ways to spell commits, see
+	linkgit:gitrevisions[1].
 	Sets of commits can be passed but no traversal is done by
 	default, as if the '--no-walk' option was specified, see
 	linkgit:git-rev-list[1].
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 723a648..08fd409 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -68,11 +68,11 @@ for the last two forms that use ".." notations, can be any
 <tree-ish>.
 
 For a more complete list of ways to spell <commit>, see
-"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
 However, "diff" is about comparing two _endpoints_, not ranges,
 and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
-"SPECIFYING RANGES" section in linkgit:git-rev-parse[1].
+"SPECIFYING RANGES" section in linkgit:gitrevisions[1].
 
 OPTIONS
 -------
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 19082b0..77a0a24 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -439,7 +439,7 @@ Marks must be declared (via `mark`) before they can be used.
 * A complete 40 byte or abbreviated commit SHA-1 in hex.
 
 * Any valid Git SHA-1 expression that resolves to a commit.  See
-  ``SPECIFYING REVISIONS'' in linkgit:git-rev-parse[1] for details.
+  ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[1] for details.
 
 The special case of restarting an incremental import from the
 current branch value should be written as:
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c8c81e8..4b3f5ba 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -39,7 +39,7 @@ There are two ways to specify which commits to operate on.
    that leads to the <since> to be output.
 
 2. Generic <revision range> expression (see "SPECIFYING
-   REVISIONS" section in linkgit:git-rev-parse[1]) means the
+   REVISIONS" section in linkgit:gitrevisions[1]) means the
    commits in the specified range.
 
 The first rule takes precedence in the case of a single <commit>.  To
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e6ff31..8a69647 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -34,8 +34,7 @@ include::diff-options.txt[]
 	either <since> or <until> is omitted, it defaults to
 	`HEAD`, i.e. the tip of the current branch.
 	For a more complete list of ways to spell <since>
-	and <until>, see "SPECIFYING REVISIONS" section in
-	linkgit:git-rev-parse[1].
+	and <until>, see linkgit:gitrevisions[1].
 
 --no-decorate::
 --decorate[=short|full|no]::
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4857024..b68abff 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -41,7 +41,7 @@ OPTIONS[[OPTIONS]]
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:git-rev-parse[1]).
+`HEAD` (see linkgit:gitrevisions[1]).
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 4eaa62b..5a0451a 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -40,7 +40,7 @@ see linkgit:git-log[1].
 The reflog is useful in various git commands, to specify the old value
 of a reference. For example, `HEAD@\{2\}` means "where HEAD used to be
 two moves ago", `master@\{one.week.ago\}` means "where master used to
-point to one week ago", and so on. See linkgit:git-rev-parse[1] for
+point to one week ago", and so on. See linkgit:gitrevisions[1] for
 more details.
 
 To delete single entries from the reflog, use the subcommand "delete"
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index dea4f53..b7d9ef7 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -31,7 +31,7 @@ OPTIONS
 <commit>...::
 	Commits to revert.
 	For a more complete list of ways to spell commit names, see
-	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	linkgit:gitrevisions[1].
 	Sets of commits can also be given but no traversal is done by
 	default, see linkgit:git-rev-list[1] and its '--no-walk'
 	option.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index f1499bb..81ba296 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -32,7 +32,7 @@ no <rev> nor <glob> is given on the command line.
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:git-rev-parse[1])
+	Arbitrary extended SHA1 expression (see linkgit:gitrevisions[1])
 	that typically names a branch head or a tag.
 
 <glob>::
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 55e687a..0002bfb 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -36,7 +36,7 @@ OPTIONS
 <object>...::
 	The names of objects to show.
 	For a more complete list of ways to spell object names, see
-	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
 
 include::pretty-options.txt[]
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8f0dd7f..12066ab 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -479,7 +479,7 @@ HEAD::
 	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
 
 For a more complete list of ways to spell object names, see
-"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+"SPECIFYING REVISIONS" section in linkgit:gitrevisions[1].
 
 
 File/Directory Structure
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f7815e9..ed3ddc9 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -971,7 +971,7 @@ commits from the master branch.  The string inside brackets
 before the commit log message is a short name you can use to
 name the commit.  In the above example, 'master' and 'mybranch'
 are branch heads.  'master^' is the first parent of 'master'
-branch head.  Please see linkgit:git-rev-parse[1] if you want to
+branch head.  Please see linkgit:gitrevisions[1] if you want to
 see more complex cases.
 
 [NOTE]
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 99baa24..05ac1c7 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -69,7 +69,7 @@ frequently used options.
 	the form "'<from>'..'<to>'" to show all revisions between '<from>' and
 	back to '<to>'. Note, more advanced revision selection can be applied.
 	For a more complete list of ways to spell object names, see
-	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	linkgit:gitrevisions[1].
 
 <path>...::
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fe6fb72..22aee34 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -397,7 +397,7 @@ is usually a shortcut for the HEAD branch in the repository "origin".
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
 references with the same shorthand name, see the "SPECIFYING
-REVISIONS" section of linkgit:git-rev-parse[1].
+REVISIONS" section of linkgit:gitrevisions[1].
 
 [[Updating-a-repository-With-git-fetch]]
 Updating a repository with git fetch
@@ -568,7 +568,7 @@ We have seen several ways of naming commits already:
 	- HEAD: refers to the head of the current branch
 
 There are many more; see the "SPECIFYING REVISIONS" section of the
-linkgit:git-rev-parse[1] man page for the complete list of ways to
+linkgit:gitrevisions[1] man page for the complete list of ways to
 name revisions.  Some examples:
 
 -------------------------------------------------
@@ -909,7 +909,7 @@ commits reachable from some head but not from any tag in the repository:
 $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 -------------------------------------------------
 
-(See linkgit:git-rev-parse[1] for explanations of commit-selecting
+(See linkgit:gitrevisions[1] for explanations of commit-selecting
 syntax such as `--not`.)
 
 [[making-a-release]]
@@ -1635,7 +1635,7 @@ you've checked out.
 The reflogs are kept by default for 30 days, after which they may be
 pruned.  See linkgit:git-reflog[1] and linkgit:git-gc[1] to learn
 how to control this pruning, and see the "SPECIFYING REVISIONS"
-section of linkgit:git-rev-parse[1] for details.
+section of linkgit:gitrevisions[1] for details.
 
 Note that the reflog history is very different from normal git history.
 While normal history is shared by every repository that works on the
-- 
1.7.1.621.g01d76
