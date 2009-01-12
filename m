From: Jon Loeliger <jdl@freescale.com>
Subject: [PATCH] Fix Dcoumentation typos surrounding the word 'handful'.
Date: Mon, 12 Jan 2009 14:02:07 -0600
Message-ID: <1231790527-7515-1-git-send-email-jdl@freescale.com>
Cc: Jon Loeliger <jdl@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 21:03:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMT0Y-0001YB-GQ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 21:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbZALUCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 15:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbZALUCN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 15:02:13 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:57154 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbZALUCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 15:02:12 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n0CK28Ym010902
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 13:02:11 -0700 (MST)
Received: from ld0161-tx32.am.freescale.net (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0CK27U6001967
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 14:02:07 -0600 (CST)
Received: by ld0161-tx32.am.freescale.net (Postfix, from userid 12040105)
	id 1E7353007C; Mon, 12 Jan 2009 14:02:07 -0600 (CST)
X-Mailer: git-send-email 1.6.0.4.761.g47577
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some instances replaced by "handful of", others use
the word "few", a couple get a slight rewording.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Junio,

I wasn't sure that fixing the release notes was important.
I can hit those too if you would like.

jdl


 Documentation/diff-options.txt                     |    2 +-
 Documentation/git-describe.txt                     |    2 +-
 Documentation/git-ls-files.txt                     |    2 +-
 Documentation/git-ls-tree.txt                      |    2 +-
 Documentation/gitcore-tutorial.txt                 |    8 ++++----
 Documentation/githooks.txt                         |    2 +-
 .../howto/rebase-from-internal-branch.txt          |    2 +-
 Documentation/pretty-options.txt                   |    2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 671f533..43793d7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -116,7 +116,7 @@ endif::git-format-patch[]
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-	lines, show only handful hexdigits prefix.  This is
+	lines, show only a partial prefix.  This is
 	independent of --full-index option above, which controls
 	the diff-patch output format.  Non default number of
 	digits can be specified with --abbrev=<n>.
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 3d79f05..a99b4ef 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -87,7 +87,7 @@ With something like git.git current tree, I get:
 	v1.0.4-14-g2414721
 
 i.e. the current head of my "parent" branch is based on v1.0.4,
-but since it has a handful commits on top of that,
+but since it has a few commits on top of that,
 describe has added the number of additional commits ("14") and
 an abbreviated object name for the commit itself ("2414721")
 at the end.
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 9f85d60..057a021 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -126,7 +126,7 @@ OPTIONS
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
-	lines, show only handful hexdigits prefix.
+	lines, show only a partial prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
 
 \--::
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 4c7262f..b345f4d 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -59,7 +59,7 @@ OPTIONS
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
-	lines, show only handful hexdigits prefix.
+	lines, show only a partal prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
 
 --full-name::
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index e4dd551..7ba5e58 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1243,10 +1243,10 @@ $ git ls-files --stage
 ------------
 
 In our example of only two files, we did not have unchanged
-files so only 'example' resulted in collapsing, but in real-life
-large projects, only small number of files change in one commit,
-and this 'collapsing' tends to trivially merge most of the paths
-fairly quickly, leaving only a handful the real changes in non-zero
+files so only 'example' resulted in collapsing.  But in real-life
+large projects, when only a small number of files change in one commit,
+this 'collapsing' tends to trivially merge most of the paths
+fairly quickly, leaving only a handful of real changes in non-zero
 stages.
 
 To look at only non-zero stages, use `\--unmerged` flag:
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index cfdae1e..e4d61d5 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 
 Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
-'git-init' is run, a handful example hooks are copied in the
+'git-init' is run, a handful of example hooks are copied into the
 `hooks` directory of the new repository, but by default they are
 all disabled.  To enable a hook, rename it by removing its `.sample`
 suffix.
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index d214d4b..74a1c0c 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -27,7 +27,7 @@ the kind of task StGIT is designed to do.
 I just have done a simpler one, this time using only the core
 GIT tools.
 
-I had a handful commits that were ahead of master in pu, and I
+I had a handful of commits that were ahead of master in pu, and I
 wanted to add some documentation bypassing my usual habit of
 placing new things in pu first.  At the beginning, the commit
 ancestry graph looked like this:
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 6d66c74..5f21efe 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -10,7 +10,7 @@ configuration (see linkgit:git-config[1]).
 
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
-	name, show only handful hexdigits prefix.  Non default number of
+	name, show only a partial prefix.  Non default number of
 	digits can be specified with "--abbrev=<n>" (which also modifies
 	diff output, if it is displayed).
 +
-- 
1.6.0.4.761.g47577
