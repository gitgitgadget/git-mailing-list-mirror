From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 3/6] convert doc links for non-dashed git commands
Date: Fri, 12 Sep 2008 12:55:23 +0200
Message-ID: <1221216926-20435-5-git-send-email-git@drmicha.warpmail.net>
References: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-2-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-3-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-4-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 12:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6L4-0003pN-52
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbYILK4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYILK4O
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:56:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46564 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752863AbYILK4H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 06:56:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 92B9915EF0F
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:56:06 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 12 Sep 2008 06:56:06 -0400
X-Sasl-enc: nEaz9COtrDOtcwiZXxCo/4XI+iLy2sc+k6YC0VZP2hiN 1221216964
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B73EACFD3;
	Fri, 12 Sep 2008 06:56:04 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
In-Reply-To: <1221216926-20435-4-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95704>

This converts all links for git commands whose names do not begin
with "git-". We use the "linkgitasis" macro for them which preserves the name.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt                 |   10 +++++-----
 Documentation/diff-options.txt           |    4 ++--
 Documentation/git-add.txt                |    4 ++--
 Documentation/git-am.txt                 |    2 +-
 Documentation/git-annotate.txt           |    2 +-
 Documentation/git-apply.txt              |    2 +-
 Documentation/git-archimport.txt         |    2 +-
 Documentation/git-archive.txt            |    2 +-
 Documentation/git-bisect.txt             |    2 +-
 Documentation/git-blame.txt              |    2 +-
 Documentation/git-branch.txt             |    2 +-
 Documentation/git-bundle.txt             |    2 +-
 Documentation/git-cat-file.txt           |    2 +-
 Documentation/git-check-attr.txt         |    4 ++--
 Documentation/git-check-ref-format.txt   |    2 +-
 Documentation/git-checkout-index.txt     |    2 +-
 Documentation/git-checkout.txt           |    2 +-
 Documentation/git-cherry-pick.txt        |    2 +-
 Documentation/git-cherry.txt             |    2 +-
 Documentation/git-citool.txt             |    2 +-
 Documentation/git-clean.txt              |    2 +-
 Documentation/git-clone.txt              |    2 +-
 Documentation/git-commit-tree.txt        |    2 +-
 Documentation/git-commit.txt             |    6 +++---
 Documentation/git-config.txt             |    2 +-
 Documentation/git-count-objects.txt      |    2 +-
 Documentation/git-cvsexportcommit.txt    |    2 +-
 Documentation/git-cvsimport.txt          |    4 ++--
 Documentation/git-cvsserver.txt          |    6 +++---
 Documentation/git-daemon.txt             |    2 +-
 Documentation/git-describe.txt           |    2 +-
 Documentation/git-diff-files.txt         |    2 +-
 Documentation/git-diff-index.txt         |    2 +-
 Documentation/git-diff-tree.txt          |    2 +-
 Documentation/git-diff.txt               |    2 +-
 Documentation/git-fast-export.txt        |    2 +-
 Documentation/git-fast-import.txt        |    2 +-
 Documentation/git-fetch-pack.txt         |    2 +-
 Documentation/git-fetch.txt              |    2 +-
 Documentation/git-filter-branch.txt      |    2 +-
 Documentation/git-fmt-merge-msg.txt      |    2 +-
 Documentation/git-format-patch.txt       |    2 +-
 Documentation/git-fsck.txt               |    2 +-
 Documentation/git-gc.txt                 |    2 +-
 Documentation/git-get-tar-commit-id.txt  |    2 +-
 Documentation/git-grep.txt               |    2 +-
 Documentation/git-gui.txt                |    4 ++--
 Documentation/git-hash-object.txt        |    2 +-
 Documentation/git-help.txt               |    4 ++--
 Documentation/git-http-fetch.txt         |    2 +-
 Documentation/git-http-push.txt          |    2 +-
 Documentation/git-imap-send.txt          |    2 +-
 Documentation/git-index-pack.txt         |    2 +-
 Documentation/git-init.txt               |    2 +-
 Documentation/git-instaweb.txt           |    2 +-
 Documentation/git-log.txt                |    2 +-
 Documentation/git-lost-found.txt         |    2 +-
 Documentation/git-ls-files.txt           |    6 +++---
 Documentation/git-ls-remote.txt          |    2 +-
 Documentation/git-ls-tree.txt            |    2 +-
 Documentation/git-mailinfo.txt           |    2 +-
 Documentation/git-mailsplit.txt          |    2 +-
 Documentation/git-merge-base.txt         |    2 +-
 Documentation/git-merge-file.txt         |    4 ++--
 Documentation/git-merge-index.txt        |    2 +-
 Documentation/git-merge-one-file.txt     |    2 +-
 Documentation/git-merge-tree.txt         |    2 +-
 Documentation/git-merge.txt              |    4 ++--
 Documentation/git-mergetool.txt          |    2 +-
 Documentation/git-mktag.txt              |    2 +-
 Documentation/git-mktree.txt             |    2 +-
 Documentation/git-mv.txt                 |    2 +-
 Documentation/git-name-rev.txt           |    2 +-
 Documentation/git-pack-objects.txt       |    2 +-
 Documentation/git-pack-redundant.txt     |    2 +-
 Documentation/git-pack-refs.txt          |    2 +-
 Documentation/git-parse-remote.txt       |    2 +-
 Documentation/git-patch-id.txt           |    2 +-
 Documentation/git-peek-remote.txt        |    2 +-
 Documentation/git-prune-packed.txt       |    2 +-
 Documentation/git-prune.txt              |    2 +-
 Documentation/git-pull.txt               |    2 +-
 Documentation/git-push.txt               |    2 +-
 Documentation/git-quiltimport.txt        |    2 +-
 Documentation/git-read-tree.txt          |    4 ++--
 Documentation/git-rebase.txt             |    2 +-
 Documentation/git-receive-pack.txt       |    2 +-
 Documentation/git-reflog.txt             |    2 +-
 Documentation/git-relink.txt             |    2 +-
 Documentation/git-remote.txt             |    2 +-
 Documentation/git-repack.txt             |    2 +-
 Documentation/git-request-pull.txt       |    2 +-
 Documentation/git-rerere.txt             |    2 +-
 Documentation/git-reset.txt              |    2 +-
 Documentation/git-rev-list.txt           |    2 +-
 Documentation/git-rev-parse.txt          |    4 ++--
 Documentation/git-revert.txt             |    2 +-
 Documentation/git-rm.txt                 |    2 +-
 Documentation/git-send-email.txt         |    2 +-
 Documentation/git-send-pack.txt          |    2 +-
 Documentation/git-sh-setup.txt           |    2 +-
 Documentation/git-shell.txt              |    2 +-
 Documentation/git-shortlog.txt           |    2 +-
 Documentation/git-show-branch.txt        |    2 +-
 Documentation/git-show-index.txt         |    2 +-
 Documentation/git-show-ref.txt           |    2 +-
 Documentation/git-show.txt               |    2 +-
 Documentation/git-stash.txt              |    2 +-
 Documentation/git-status.txt             |    6 +++---
 Documentation/git-stripspace.txt         |    2 +-
 Documentation/git-submodule.txt          |    4 ++--
 Documentation/git-symbolic-ref.txt       |    2 +-
 Documentation/git-tag.txt                |    2 +-
 Documentation/git-tar-tree.txt           |    2 +-
 Documentation/git-unpack-file.txt        |    2 +-
 Documentation/git-unpack-objects.txt     |    2 +-
 Documentation/git-update-index.txt       |    2 +-
 Documentation/git-update-ref.txt         |    2 +-
 Documentation/git-update-server-info.txt |    4 ++--
 Documentation/git-upload-archive.txt     |    2 +-
 Documentation/git-upload-pack.txt        |    2 +-
 Documentation/git-var.txt                |    2 +-
 Documentation/git-verify-pack.txt        |    2 +-
 Documentation/git-verify-tag.txt         |    2 +-
 Documentation/git-web--browse.txt        |    2 +-
 Documentation/git-whatchanged.txt        |    2 +-
 Documentation/git-write-tree.txt         |    2 +-
 Documentation/git.txt                    |   24 ++++++++++++------------
 Documentation/gitattributes.txt          |    4 ++--
 Documentation/gitcli.txt                 |    2 +-
 Documentation/gitcore-tutorial.txt       |   12 ++++++------
 Documentation/gitcvs-migration.txt       |   18 +++++++++---------
 Documentation/gitdiffcore.txt            |    4 ++--
 Documentation/gitglossary.txt            |    6 +++---
 Documentation/githooks.txt               |    2 +-
 Documentation/gitignore.txt              |    2 +-
 Documentation/gitk.txt                   |    2 +-
 Documentation/gitmodules.txt             |    2 +-
 Documentation/gitrepository-layout.txt   |    8 ++++----
 Documentation/gittutorial-2.txt          |   20 ++++++++++----------
 Documentation/gittutorial.txt            |   16 ++++++++--------
 Documentation/merge-config.txt           |    6 +++---
 Documentation/user-manual.txt            |   18 +++++++++---------
 143 files changed, 224 insertions(+), 224 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 98ca1a1..fe71aba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -347,7 +347,7 @@ core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
 	of files which are not meant to be tracked.  See
-	linkgit:gitignore[5].
+	linkgitasis:gitignore[5].
 
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
@@ -394,7 +394,7 @@ journalling (traditional UNIX filesystems) or that only journal metadata
 and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
 
 alias.*::
-	Command aliases for the linkgit:git[1] command wrapper - e.g.
+	Command aliases for the linkgitasis:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
 	"git last" is equivalent to "git cat-file commit HEAD". To avoid
 	confusion and troubles with script usage, aliases that
@@ -581,9 +581,9 @@ diff.external::
 	performed using the internal diff machinery, but using the
 	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
 	environment variable.  The command is called with parameters
-	as described under "git Diffs" in linkgit:git[1].  Note: if
+	as described under "git Diffs" in linkgitasis:git[1].  Note: if
 	you want to use an external diff program only on a subset of
-	your files, you	might want to use linkgit:gitattributes[5] instead.
+	your files, you	might want to use linkgitasis:gitattributes[5] instead.
 
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
@@ -704,7 +704,7 @@ gitcvs.usecrlfattr::
 	treat it as text. If `crlf` is explicitly unset, the file
 	will be set with '-kb' mode, which suppresses any newline munging
 	the client might otherwise do. If `crlf` is not specified,
-	then 'gitcvs.allbinary' is used. See linkgit:gitattributes[5].
+	then 'gitcvs.allbinary' is used. See linkgitasis:gitattributes[5].
 
 gitcvs.allbinary::
 	This is used if 'gitcvs.usecrlfattr' does not resolve
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6e26832..cf26153 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -221,7 +221,7 @@ endif::git-format-patch[]
 
 --ext-diff::
 	Allow an external diff helper to be executed. If you set an
-	external diff driver with linkgit:gitattributes[5], you need
+	external diff driver with linkgitasis:gitattributes[5], you need
 	to use this option with linkgit:git-log[1] and friends.
 
 --no-ext-diff::
@@ -240,4 +240,4 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
 
 For more detailed explanation on these common options, see also
-linkgit:gitdiffcore[7].
+linkgitasis:gitdiffcore[7].
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 2b6d6c8..2f7109a 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -113,7 +113,7 @@ Configuration
 The optional configuration variable 'core.excludesfile' indicates a path to a
 file containing patterns of file names to exclude from git-add, similar to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See linkgit:gitrepository-layout[5].
+those in info/exclude.  See linkgitasis:gitrepository-layout[5].
 
 
 EXAMPLES
@@ -280,4 +280,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index b9c6fac..a7a2cd5 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -165,4 +165,4 @@ Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.o
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 0aba022..809048f 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -33,4 +33,4 @@ Written by Ryan Anderson <ryan@michonline.com>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index feb51f1..976c7c7 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -222,4 +222,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index c7a6e3e..6809ba2 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -117,4 +117,4 @@ Documentation by Junio C Hamano, Martin Langhoff and the git-list <git@vger.kern
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..efd1ffd 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -120,4 +120,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c7981ef..a1f3902 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -282,4 +282,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index fba374d..e12d099 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -194,4 +194,4 @@ Written by Junio C Hamano <gitster@pobox.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6103d62..12a9dd8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -213,4 +213,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..de4ceed 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -170,4 +170,4 @@ Written by Mark Levedahl <mdl123@verizon.net>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 668f697..bc29b81 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -104,4 +104,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 2b821f2..35234e6 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -25,7 +25,7 @@ OPTIONS
 
 SEE ALSO
 --------
-linkgit:gitattributes[5].
+linkgitasis:gitattributes[5].
 
 
 Author
@@ -38,4 +38,4 @@ Documentation by James Bowes.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 034223c..2bcfba2 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -52,4 +52,4 @@ refname expressions (see linkgit:git-rev-parse[1]).  Namely:
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 62d8483..6159925 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -186,4 +186,4 @@ Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index be54a02..7049060 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -231,4 +231,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 837fb08..eab114d 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -82,4 +82,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 74d14c4..35370aa 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -72,4 +72,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.txt
index 670cb02..e7ba3e3 100644
--- a/Documentation/git-citool.txt
+++ b/Documentation/git-citool.txt
@@ -29,4 +29,4 @@ Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 8a11450..f56d615 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -56,4 +56,4 @@ Written by Pavel Roskin <proski@gnu.org>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0e14e73..720bd9f 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -207,4 +207,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index b8834ba..5e7f2fe 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -103,4 +103,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index eb05b0f..94d0abc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -99,7 +99,7 @@ OPTIONS
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
-	See also linkgit:githooks[5].
+	See also linkgitasis:githooks[5].
 
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
@@ -318,7 +318,7 @@ order).
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
-and `post-commit` hooks.  See linkgit:githooks[5] for more
+and `post-commit` hooks.  See linkgitasis:githooks[5] for more
 information.
 
 
@@ -338,4 +338,4 @@ Junio C Hamano <gitster@pobox.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28e1861..38516c3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -328,4 +328,4 @@ Documentation by Johannes Schindelin, Petr Baudis and the git-list <git@vger.ker
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 6bc1c21..64d143f 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -36,4 +36,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 2da8588..e8e9445 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -118,4 +118,4 @@ Documentation by Martin Langhoff <martin@catalyst.net.nz> and others.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 91d51a4..51c8f77 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -35,7 +35,7 @@ If you intend to set up a shared public repository that all developers can
 read/write, or if you want to use linkgitasis:git-cvsserver[1], then you
 probably want to make a bare clone of the imported repository,
 and use the clone as the shared repository.
-See linkgit:gitcvs-migration[7].
+See linkgitasis:gitcvs-migration[7].
 
 
 OPTIONS
@@ -176,4 +176,4 @@ Documentation by Matthias Urlichs <smurf@smurf.noris.de>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 72fb93f..4c9813d 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -134,7 +134,7 @@ write access to the log file and to the database (see
 SSH, the users of course also need write access to the git repository itself.
 
 You also need to ensure that each repository is "bare" (without a git index
-file) for `cvs commit` to work. See linkgit:gitcvs-migration[7].
+file) for `cvs commit` to work. See linkgitasis:gitcvs-migration[7].
 
 [[configaccessmethod]]
 All configuration variables can also be overridden for a specific method of
@@ -319,7 +319,7 @@ for files by setting the `gitcvs.usecrlfattr` config variable.
 In this case, if `crlf` is explicitly unset ('-crlf'), then the
 server will set '-kb' mode for binary files. If `crlf` is set,
 then the '-k' mode will explicitly be left blank.  See
-also linkgit:gitattributes[5] for more information about the `crlf`
+also linkgitasis:gitattributes[5] for more information about the `crlf`
 attribute.
 
 Alternatively, if `gitcvs.usecrlfattr` config is not enabled
@@ -357,4 +357,4 @@ Documentation by Martyn Smith <martyn@catalyst.net.nz>, Martin Langhoff <martin@
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index b08a08c..b60eb0f 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -281,4 +281,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c4dbc2a..c82c0d4 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -145,4 +145,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 5c8c1d9..1c49fff 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -55,4 +55,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 26920d4..cd3a6aa 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -129,4 +129,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 5d48664..ebdd221 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -174,4 +174,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index c53eba5..fe87e94 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -168,4 +168,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index b974e21..8ea292f 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -109,4 +109,4 @@ Documentation by Johannes E. Schindelin <johannes.schindelin@gmx.de>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..70d0434 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1122,4 +1122,4 @@ Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 47448da..11f0ebf 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -101,4 +101,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d3164c5..babe2d6 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -53,4 +53,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b0e710d..0ae7de3 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -329,4 +329,4 @@ Documentation by Petr Baudis and the git list.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 1c24796..d340960 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -69,4 +69,4 @@ Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.o
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index adb4ea7..b77269a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -243,4 +243,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index d5a7647..dc86493 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -151,4 +151,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 7086eea..98c2f82 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -132,4 +132,4 @@ Written by Shawn O. Pearce <spearce@spearce.org>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 84f23ee..c44c5d2 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -33,4 +33,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fa4d133..b220f36 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -162,4 +162,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 0e650f4..072c18f 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -81,7 +81,7 @@ git gui browser maint::
 
 SEE ALSO
 --------
-linkgit:gitk[1]::
+linkgitasis:gitk[1]::
 	The git repository browser.  Shows branches, commit history
 	and file differences.  gitk is the utility started by
 	'git-gui''s Repository Visualize actions.
@@ -112,4 +112,4 @@ Documentation by Shawn O. Pearce <spearce@spearce.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 0af40cf..114f287 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -63,4 +63,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index d9b9c34..e41ab5e 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -178,10 +178,10 @@ Written by Junio C Hamano <gitster@pobox.com> and the git-list
 
 Documentation
 -------------
-Initial documentation was part of the linkgit:git[1] man page.
+Initial documentation was part of the linkgitasis:git[1] man page.
 Christian Couder <chriscool@tuxfamily.org> extracted and rewrote it a
 little. Maintenance is done by the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index e7c7961..d440201 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -53,4 +53,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index aef383e..ad40099 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -102,4 +102,4 @@ Documentation by Nick Hengeveld
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index bd49a0a..2af25d9 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -113,4 +113,4 @@ Documentation by Mike McCormack
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 4b5c743..5556562 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -100,4 +100,4 @@ Documentation by Sergey Vlasov
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..f243990 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -123,4 +123,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 22da21a..b5fca66 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -91,4 +91,4 @@ Documentation by Eric Wong <normalperson@yhbt.net>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0446bad..c4042ab 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -112,4 +112,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index 602b8d5..7a06d03 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -78,4 +78,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 9f85d60..3167775 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -162,7 +162,7 @@ Exclude Patterns
 
 'git-ls-files' can use a list of "exclude patterns" when
 traversing the directory tree and finding files to show when the
-flags --others or --ignored are specified.  linkgit:gitignore[5]
+flags --others or --ignored are specified.  linkgitasis:gitignore[5]
 specifies the format of exclude patterns.
 
 These exclude patterns come from these places, in order:
@@ -189,7 +189,7 @@ pattern file appears in.
 
 SEE ALSO
 --------
-linkgit:git-read-tree[1], linkgit:gitignore[5]
+linkgit:git-read-tree[1], linkgitasis:gitignore[5]
 
 
 Author
@@ -202,4 +202,4 @@ Documentation by David Greaves, Junio C Hamano, Josh Triplett, and the git-list
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index abe7bf9..c76542e 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -73,4 +73,4 @@ Written by Junio C Hamano <gitster@pobox.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 4c7262f..8417693 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -101,4 +101,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 31eccea..3930503 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -69,4 +69,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 5cc94ec..7a3909b 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -55,4 +55,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2f0c525..8cf62b3 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -94,4 +94,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 024ec01..2f462a0 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -41,7 +41,7 @@ conflicts otherwise. If the merge was clean, the exit value is 0.
 
 'git-merge-file' is designed to be a minimal clone of RCS 'merge'; that is, it
 implements all of RCS 'merge''s functionality which is needed by
-linkgit:git[1].
+linkgitasis:git[1].
 
 
 OPTIONS
@@ -89,4 +89,4 @@ with parts copied from the original documentation of RCS 'merge'.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index ff088c5..65e0fae 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -84,4 +84,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index dc8a96a..98a16cb 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -26,4 +26,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index dbb0c18..2957724 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -33,4 +33,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 685e1fe..4e618e9 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -149,7 +149,7 @@ You can work through the conflict with a number of tools:
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
-linkgit:gitattributes[5],
+linkgitasis:gitattributes[5],
 linkgit:git-reset[1],
 linkgit:git-diff[1], linkgit:git-ls-files[1],
 linkgit:git-add[1], linkgit:git-rm[1],
@@ -166,4 +166,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e0b2703..33e79db 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -70,4 +70,4 @@ Documentation by Theodore Y Ts'o.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 8bcc114..8482b15 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -43,4 +43,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index af19f06..47b780d 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -31,4 +31,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 9c56602..7d6f2a5 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -51,4 +51,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 7ca8a7b..bfb46d5 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -81,4 +81,4 @@ Documentation by Johannes Schindelin.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8c354bd..3e31cf5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -209,4 +209,4 @@ linkgit:git-prune-packed[1]
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index 5f9435e..d0b2b00 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -54,4 +54,4 @@ linkgit:git-prune-packed[1]
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index a5244d3..84b5db5 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -63,4 +63,4 @@ Written by Linus Torvalds <torvalds@osdl.org>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index cd43069..885be81 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -47,4 +47,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 477785e..f9ee3ba 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -39,4 +39,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index 8282a5e..0693da9 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -47,4 +47,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index b5f26ce..16a0de2 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -49,4 +49,4 @@ linkgit:git-repack[1]
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 54f1dab..1fd834b 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -83,4 +83,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7578623..dac87d3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -203,4 +203,4 @@ Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 213e05f..03ef7ef 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -205,4 +205,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index d4037de..7ff55d1 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -59,4 +59,4 @@ Documentation by Eric Biederman <ebiederm@lnxi.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 6f4b9b0..761be76 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -351,7 +351,7 @@ have finished your work-in-progress), attempt the merge again.
 SEE ALSO
 --------
 linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
-linkgit:gitignore[5]
+linkgitasis:gitignore[5]
 
 
 Author
@@ -364,4 +364,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..29cbfb5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -407,4 +407,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 6b2f8c4..b5f7af1 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -162,4 +162,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index d99236e..ac6890c 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -102,4 +102,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 25ff8f9..5d8d9af 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -34,4 +34,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index bb99810..565b816 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -153,4 +153,4 @@ Documentation by J. Bruce Fields and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 38ac609..88b31c1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -131,4 +131,4 @@ linkgit:git-prune-packed[1]
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 19335fd..c8718ed 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -36,4 +36,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 64715c1..f87a042 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -208,4 +208,4 @@ Written by Junio C Hamano <gitster@pobox.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6abaeac..6b76784 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -203,4 +203,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index fd1de92..6ccce2b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -109,4 +109,4 @@ and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2921da3..c5f58fb 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -367,7 +367,7 @@ Each line of options has this format:
 
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
-	  documented in linkgit:gitcli[7].
+	  documented in linkgitasis:gitcli[7].
 
 	* Use `!` to not make the corresponding negated long option available.
 
@@ -435,4 +435,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index caa0729..e8d2924 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -78,4 +78,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 5afb1e7..8325c01 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -110,4 +110,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3c3e1b0..55f69b0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -256,4 +256,4 @@ Documentation by Ryan Anderson
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 3998218..f50d027 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -125,4 +125,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 18f14b5..764cac1 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -77,4 +77,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index ff420f8..b8f4319 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -31,4 +31,4 @@ Documentation by Petr Baudis and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 7ccf31c..daa94f6 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -69,4 +69,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index d3f2588..6c9ef27 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -192,4 +192,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index e3285aa..7c11c4e 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -31,4 +31,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2f173ff..c35cbf1 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -176,4 +176,4 @@ Man page by Jonas Fonseca <fonseca@diku.dk>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 48b612e..f92065e 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -81,4 +81,4 @@ Documentation by David Greaves, Petr Baudis and the git-list <git@vger.kernel.or
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 051f94d..41cf8b8 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -227,4 +227,4 @@ Written by Nanako Shiraishi <nanako3@bluebottle.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 84f60f3..68e2f59 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 Displays paths that have differences between the index file and the
 current HEAD commit, paths that have differences between the working
 tree and the index file, and paths in the working tree that are not
-tracked by git (and are not ignored by linkgit:gitignore[5]). The first
+tracked by git (and are not ignored by linkgitasis:gitignore[5]). The first
 are what you _would_ commit by running `git commit`; the second and
 third are what you _could_ commit by running 'git-add' before running
 `git commit`.
@@ -59,7 +59,7 @@ option of linkgit:git-submodule[1]).
 
 SEE ALSO
 --------
-linkgit:gitignore[5]
+linkgitasis:gitignore[5]
 
 Author
 ------
@@ -72,4 +72,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 7508c0e..dfcd237 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -33,4 +33,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index babaa9b..e8bbba8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -182,7 +182,7 @@ FILES
 When initializing submodules, a .gitmodules file in the top-level directory
 of the containing repository is used to find the url of each submodule.
 This file should be formatted in the same way as `$GIT_DIR/config`. The key
-to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
+to each submodule url is "submodule.$name.url".  See linkgitasis:gitmodules[5]
 for details.
 
 
@@ -192,4 +192,4 @@ Written by Lars Hjemli <hjemli@gmail.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 210fde0..096d13d 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -59,4 +59,4 @@ Written by Junio C Hamano <gitster@pobox.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 046ab35..460b2c2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -256,4 +256,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index a5d9558..543d1a0 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -86,4 +86,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 995db9f..a564168 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -32,4 +32,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 36d1038..009f88f 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -54,4 +54,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1d9d81a..c3a3aba 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -345,4 +345,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9639f70..e8a0c15 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -90,4 +90,4 @@ Written by Linus Torvalds <torvalds@osdl.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 35d27b0..51b149b 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -31,7 +31,7 @@ OUTPUT
 ------
 
 Currently the command updates the following files.  Please see
-linkgit:gitrepository-layout[5] for description of
+linkgitasis:gitrepository-layout[5] for description of
 what they are for:
 
 * objects/info/packs
@@ -55,4 +55,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index bbd7617..dd9fda2 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -34,4 +34,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index b8e49dc..044a93a 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -43,4 +43,4 @@ Documentation by Junio C Hamano.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index e2f4c09..e7a48ed 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -61,4 +61,4 @@ Documentation by Eric Biederman and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index c861163..cca95e2 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -50,4 +50,4 @@ Documentation by Junio C Hamano
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 84e70a0..fcfdd82 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -28,4 +28,4 @@ Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 36afad8..de67530 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -121,4 +121,4 @@ git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index cadfbd9..6ec43c2 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -76,4 +76,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index 26d3850..bd862a1 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -46,4 +46,4 @@ Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index e178fb5..e9f1124 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -20,10 +20,10 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See linkgit:gittutorial[7] to get started, then see
+See linkgitasis:gittutorial[7] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of commands, and
 "man git-commandname" for documentation of each command.  CVS users may
-also want to read linkgit:gitcvs-migration[7].  See
+also want to read linkgitasis:gitcvs-migration[7].  See
 the link:user-manual.html[Git User's Manual] for a more in-depth
 introduction.
 
@@ -192,7 +192,7 @@ See the references above to get started using git.  The following is
 probably more detail than necessary for a first-time user.
 
 The link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7] both provide
+user-manual] and linkgitasis:gitcore-tutorial[7] both provide
 introductions to the underlying git architecture.
 
 See also the link:howto-index.html[howto] documents for some useful
@@ -383,9 +383,9 @@ For a more complete list of ways to spell object names, see
 File/Directory Structure
 ------------------------
 
-Please see the linkgit:gitrepository-layout[5] document.
+Please see the linkgitasis:gitrepository-layout[5] document.
 
-Read linkgit:githooks[5] for more details about each hook.
+Read linkgitasis:githooks[5] for more details about each hook.
 
 Higher level SCMs may provide and manage additional information in the
 `$GIT_DIR`.
@@ -393,7 +393,7 @@ Higher level SCMs may provide and manage additional information in the
 
 Terminology
 -----------
-Please see linkgit:gitglossary[7].
+Please see linkgitasis:gitglossary[7].
 
 
 Environment Variables
@@ -546,7 +546,7 @@ Discussion[[Discussion]]
 
 More detail on the following is available from the
 link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7].
+user-manual] and linkgitasis:gitcore-tutorial[7].
 
 A git project normally consists of a working directory with a ".git"
 subdirectory at the top level.  The .git directory contains, among other
@@ -609,11 +609,11 @@ contributors on the git-list <git@vger.kernel.org>.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
-linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual]
+linkgitasis:gittutorial[7], linkgitasis:gittutorial-2[7],
+link:everyday.html[Everyday Git], linkgitasis:gitcvs-migration[7],
+linkgitasis:gitglossary[7], linkgitasis:gitcore-tutorial[7],
+linkgitasis:gitcli[7], link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 75124d2..9aee2bb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -264,7 +264,7 @@ When git needs to show you a diff for the path with `diff`
 attribute set to `jcdiff`, it calls the command you specified
 with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
-See linkgit:git[1] for details.
+See linkgitasis:git[1] for details.
 
 
 Defining a custom hunk-header
@@ -574,4 +574,4 @@ frotz	unspecified
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 29e5929..d594078 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -175,4 +175,4 @@ Documentation by Pierre Habouzit and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index a417e59..579e2b2 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -16,7 +16,7 @@ This tutorial explains how to use the "core" git programs to set up and
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
-to start with "A Tutorial Introduction to GIT" (linkgit:gittutorial[7]) or
+to start with "A Tutorial Introduction to GIT" (linkgitasis:gittutorial[7]) or
 link:user-manual.html[the GIT User Manual].
 
 However, an understanding of these low-level tools can be helpful if
@@ -108,7 +108,7 @@ references in these `refs` subdirectories when you actually start
 populating your tree.
 
 [NOTE]
-An advanced user may want to take a look at linkgit:gitrepository-layout[5]
+An advanced user may want to take a look at linkgitasis:gitrepository-layout[5]
 after finishing this tutorial.
 
 You have now created your first git repository. Of course, since it's
@@ -1589,7 +1589,7 @@ suggested in the previous section may be new to you. You do not
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-See linkgit:gitcvs-migration[7] for the details.
+See linkgitasis:gitcvs-migration[7] for the details.
 
 Bundling your work together
 ---------------------------
@@ -1690,10 +1690,10 @@ to follow, not easier.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:everyday[7], linkgit:gitcvs-migration[7],
+linkgitasis:gittutorial[7], linkgitasis:gittutorial-2[7],
+linkgit:everyday[7], linkgitasis:gitcvs-migration[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 221b5d0..7749d17 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -19,8 +19,8 @@ designating a single shared repository which people can synchronize with;
 this document explains how to do that.
 
 Some basic familiarity with git is required. Having gone through
-linkgit:gittutorial[7] and
-linkgit:gitglossary[7] should be sufficient.
+linkgitasis:gittutorial[7] and
+linkgitasis:gitglossary[7] should be sufficient.
 
 Developing against a shared repository
 --------------------------------------
@@ -82,7 +82,7 @@ Setting Up a Shared Repository
 
 We assume you have already created a git repository for your project,
 possibly created from scratch or from a tarball (see
-linkgit:gittutorial[7]), or imported from an already existing CVS
+linkgitasis:gittutorial[7]), or imported from an already existing CVS
 repository (see the next section).
 
 Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
@@ -153,7 +153,7 @@ Advanced Shared Repository Management
 
 Git allows you to specify scripts called "hooks" to be run at certain
 points.  You can use these, for example, to send all commits to the shared
-repository to a mailing list.  See linkgit:githooks[5].
+repository to a mailing list.  See linkgitasis:githooks[5].
 
 You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
@@ -189,13 +189,13 @@ repositories without the need for a central maintainer.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgitasis:gittutorial[7],
+linkgitasis:gittutorial-2[7],
+linkgitasis:gitcore-tutorial[7],
+linkgitasis:gitglossary[7],
 link:everyday.html[Everyday Git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 2bdbc3d..d89b042 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -284,9 +284,9 @@ linkgit:git-diff-index[1],
 linkgit:git-diff-tree[1],
 linkgit:git-format-patch[1],
 linkgit:git-log[1],
-linkgit:gitglossary[7],
+linkgitasis:gitglossary[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index 565719e..14c13fa 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -16,10 +16,10 @@ include::glossary-content.txt[]
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:everyday[7], linkgit:gitcvs-migration[7],
+linkgitasis:gittutorial[7], linkgitasis:gittutorial-2[7],
+linkgit:everyday[7], linkgitasis:gitcvs-migration[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 046a2a7..6bd5a18 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -301,4 +301,4 @@ to abort.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 59321a2..037bee7 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -143,4 +143,4 @@ Frank Lichtenheld, and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index ae29a00..d9eeaa5 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -118,4 +118,4 @@ Documentation by Junio C Hamano, Jonas Fonseca, and the git-list
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d1a17e2..dd71690 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -59,4 +59,4 @@ Documentation by Lars Hjemli <hjemli@gmail.com>
 
 GIT
 ---
-Part of the linkgit:git[1] suite
+Part of the linkgitasis:git[1] suite
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index a969b3f..9055fdc 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -135,7 +135,7 @@ hooks::
 	commands.  A handful of sample hooks are installed when
 	'git-init' is run, but all of them are disabled by
 	default.  To enable, they need to be made executable.
-	Read linkgit:githooks[5] for more details about
+	Read linkgitasis:githooks[5] for more details about
 	each hook.
 
 index::
@@ -169,7 +169,7 @@ info/exclude::
 	exclude pattern list. `.gitignore` is the per-directory
 	ignore file.  'git-status', 'git-add', 'git-rm' and
 	'git-clean' look at it but the core git commands do not look
-	at it.  See also: linkgit:gitignore[5].
+	at it.  See also: linkgitasis:gitignore[5].
 
 remotes::
 	Stores shorthands to be used to give URL and default
@@ -200,9 +200,9 @@ linkgit:git-fetch[1],
 linkgit:git-pack-refs[1],
 linkgit:git-gc[1],
 linkgit:git-checkout[1],
-linkgit:gitglossary[7],
+linkgitasis:gitglossary[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 6609046..e06c993 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -12,7 +12,7 @@ git *
 DESCRIPTION
 -----------
 
-You should work through linkgit:gittutorial[7] before reading this tutorial.
+You should work through linkgitasis:gittutorial[7] before reading this tutorial.
 
 The goal of this tutorial is to introduce two fundamental pieces of
 git's architecture--the object database and the index file--and to
@@ -389,7 +389,7 @@ in the index file is identical to the one in the working directory.
 In addition to being the staging area for new commits, the index file
 is also populated from the object database when checking out a
 branch, and is used to hold the trees involved in a merge operation.
-See linkgit:gitcore-tutorial[7] and the relevant man
+See linkgitasis:gitcore-tutorial[7] and the relevant man
 pages for details.
 
 What next?
@@ -398,31 +398,31 @@ What next?
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
 with the commands mentioned in link:everyday.html[Everyday git].  You
-should be able to find any unknown jargon in linkgit:gitglossary[7].
+should be able to find any unknown jargon in linkgitasis:gitglossary[7].
 
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
 
-linkgit:gitcvs-migration[7] explains how to
+linkgitasis:gitcvs-migration[7] explains how to
 import a CVS repository into git, and shows how to use git in a
 CVS-like way.
 
 For some interesting examples of git use, see the
 link:howto-index.html[howtos].
 
-For git developers, linkgit:gitcore-tutorial[7] goes
+For git developers, linkgitasis:gitcore-tutorial[7] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgitasis:gittutorial[7],
+linkgitasis:gitcvs-migration[7],
+linkgitasis:gitcore-tutorial[7],
+linkgitasis:gitglossary[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 384972c..6cc27aa 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -445,7 +445,7 @@ see linkgit:git-pull[1] for details.
 
 Git can also be used in a CVS-like mode, with a central repository
 that various users push changes to; see linkgit:git-push[1] and
-linkgit:gitcvs-migration[7].
+linkgitasis:gitcvs-migration[7].
 
 Exploring history
 -----------------
@@ -626,7 +626,7 @@ is based:
 
 Part two of this tutorial explains the object
 database, the index file, and a few other odds and ends that you'll
-need to make the most of git. You can find it at linkgit:gittutorial-2[7].
+need to make the most of git. You can find it at linkgitasis:gittutorial-2[7].
 
 If you don't want to continue with that right away, a few other
 digressions that may be interesting at this point are:
@@ -645,17 +645,17 @@ digressions that may be interesting at this point are:
 
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
-  * linkgit:gitcvs-migration[7]: Git for CVS users.
+  * linkgitasis:gitcvs-migration[7]: Git for CVS users.
 
 SEE ALSO
 --------
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgitasis:gittutorial-2[7],
+linkgitasis:gitcvs-migration[7],
+linkgitasis:gitcore-tutorial[7],
+linkgitasis:gitglossary[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgitasis:git[1] suite.
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 00277e0..8547340 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -28,13 +28,13 @@ merge.verbosity::
 
 merge.<driver>.name::
 	Defines a human readable name for a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
+	merge driver.  See linkgitasis:gitattributes[5] for details.
 
 merge.<driver>.driver::
 	Defines the command that implements a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
+	merge driver.  See linkgitasis:gitattributes[5] for details.
 
 merge.<driver>.recursive::
 	Names a low-level merge driver to be used when
 	performing an internal merge between common ancestors.
-	See linkgit:gitattributes[5] for details.
+	See linkgitasis:gitattributes[5] for details.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 26525f4..3344a76 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -208,7 +208,7 @@ representing a merge can therefore have more than one parent, with
 each parent representing the most recent commit on one of the lines
 of development leading to that point.
 
-The best way to see how this works is using the linkgit:gitk[1]
+The best way to see how this works is using the linkgitasis:gitk[1]
 command; running gitk now on a git repository and looking for merge
 commits will help understand how the git organizes history.
 
@@ -1146,7 +1146,7 @@ foo.txt
 *.[oa]
 -------------------------------------------------
 
-See linkgit:gitignore[5] for a detailed explanation of the syntax.  You can
+See linkgitasis:gitignore[5] for a detailed explanation of the syntax.  You can
 also place .gitignore files in other directories in your working tree, and they
 will apply to those directories and their subdirectories.  The `.gitignore`
 files can be added to your repository like any other files (just run `git add
@@ -1159,7 +1159,7 @@ If you wish the exclude patterns to affect only certain repositories
 them in a file in your repository named .git/info/exclude, or in any file
 specified by the `core.excludesfile` configuration variable.  Some git
 commands can also take exclude patterns directly on the command line.
-See linkgit:gitignore[5] for the details.
+See linkgitasis:gitignore[5] for the details.
 
 [[how-to-merge]]
 How to merge
@@ -1318,7 +1318,7 @@ $ git diff -3 file.txt		# diff against stage 3
 $ git diff --theirs file.txt	# same as the above.
 -------------------------------------------------
 
-The linkgit:git-log[1] and linkgit:gitk[1] commands also provide special help
+The linkgit:git-log[1] and linkgitasis:gitk[1] commands also provide special help
 for merges:
 
 -------------------------------------------------
@@ -1894,7 +1894,7 @@ $ mv hooks/post-update.sample hooks/post-update
 -------------------------------------------------
 
 (For an explanation of the last two lines, see
-linkgit:git-update-server-info[1] and linkgit:githooks[5].)
+linkgit:git-update-server-info[1] and linkgitasis:githooks[5].)
 
 Advertise the URL of proj.git.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
@@ -2006,7 +2006,7 @@ the right to push to the same repository.  In that case, the correct
 solution is to retry the push after first updating your work: either by a
 pull, or by a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
-linkgit:gitcvs-migration[7] for more.
+linkgitasis:gitcvs-migration[7] for more.
 
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
@@ -2015,7 +2015,7 @@ Setting up a shared repository
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
 all push to and pull from a single shared repository.  See
-linkgit:gitcvs-migration[7] for instructions on how to
+linkgitasis:gitcvs-migration[7] for instructions on how to
 set this up.
 
 However, while there is nothing wrong with git's support for shared
@@ -3490,7 +3490,7 @@ The `git-submodule add <repo> <path>` command does a couple of things:
 
 - It clones the submodule from <repo> to the given <path> under the
   current directory and by default checks out the master branch.
-- It adds the submodule's clone path to the linkgit:gitmodules[5] file and
+- It adds the submodule's clone path to the linkgitasis:gitmodules[5] file and
   adds this file to the index, ready to be committed.
 - It adds the submodule's current commit ID to the index, ready to be
   committed.
@@ -4529,7 +4529,7 @@ Scan Documentation/ for other stuff left out; in particular:
 - howto's
 - some of technical/?
 - hooks
-- list of commands in linkgit:git[1]
+- list of commands in linkgitasis:git[1]
 
 Scan email archives for other stuff left out
 
-- 
1.6.0.1.308.gede4c
