Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699971FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbcF1Llg (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:41:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42732 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbcF1Lle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:41:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeRka028921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 13:40:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeHF9019214;
	Tue, 28 Jun 2016 13:40:29 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 7/7] doc: typeset HEAD and variants as literal
Date:	Tue, 28 Jun 2016 13:40:15 +0200
Message-Id: <20160628114015.25828-8-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160628114015.25828-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160628114015.25828-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 13:40:28 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SBeRka028921
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467718828.87916@zwVJoZwSPhiQu35lWcED7A
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an application of the newly added CodingGuidelines to HEAD and
variants like FETCH_HEAD. It was obtained with:

  perl -pi -e "s/'([A-Z_]*HEAD)'/\`\$1\`/g" *.txt

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt        |  2 +-
 Documentation/git-branch.txt        |  4 ++--
 Documentation/git-cvsimport.txt     |  6 +++---
 Documentation/git-cvsserver.txt     |  2 +-
 Documentation/git-daemon.txt        |  2 +-
 Documentation/git-gui.txt           |  2 +-
 Documentation/git-ls-tree.txt       |  4 ++--
 Documentation/git-p4.txt            |  2 +-
 Documentation/git-tag.txt           |  2 +-
 Documentation/gitremote-helpers.txt |  2 +-
 Documentation/revisions.txt         | 24 ++++++++++++------------
 11 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index d9f960b..2bb9a57 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -358,7 +358,7 @@ OPTIONS
 --no-checkout::
 +
 Do not checkout the new working tree at each iteration of the bisection
-process. Instead just update a special reference named 'BISECT_HEAD' to make
+process. Instead just update a special reference named `BISECT_HEAD` to make
 it point to the commit that should be tested.
 +
 This option may be useful when the test you would perform in each step
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 123144f..1fe7344 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -39,10 +39,10 @@ named commit).  With `--merged`, only branches merged into the named
 commit (i.e. the branches whose tip commits are reachable from the named
 commit) will be listed.  With `--no-merged` only branches not merged into
 the named commit will be listed.  If the <commit> argument is missing it
-defaults to 'HEAD' (i.e. the tip of the current branch).
+defaults to `HEAD` (i.e. the tip of the current branch).
 
 The command's second form creates a new branch head named <branchname>
-which points to the current 'HEAD', or <start-point> if given.
+which points to the current `HEAD`, or <start-point> if given.
 
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index bbf1c2b..41207a2 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -74,10 +74,10 @@ OPTIONS
 	akin to the way 'git clone' uses 'origin' by default.
 
 -o <branch-for-HEAD>::
-	When no remote is specified (via -r) the 'HEAD' branch
+	When no remote is specified (via -r) the `HEAD` branch
 	from CVS is imported to the 'origin' branch within the Git
-	repository, as 'HEAD' already has a special meaning for Git.
-	When a remote is specified the 'HEAD' branch is named
+	repository, as `HEAD` already has a special meaning for Git.
+	When a remote is specified the `HEAD` branch is named
 	remotes/<remote>/master mirroring 'git clone' behaviour.
 	Use this option if you want to import into a different
 	branch.
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index a1a5234..a336ae5 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -332,7 +332,7 @@ To get a checkout with the Eclipse CVS client:
 3. Browse the 'modules' available. It will give you a list of the heads in
    the repository. You will not be able to browse the tree from there. Only
    the heads.
-4. Pick 'HEAD' when it asks what branch/tag to check out. Untick the
+4. Pick `HEAD` when it asks what branch/tag to check out. Untick the
    "launch commit wizard" to avoid committing the .project file.
 
 Protocol notes: If you are using anonymous access via pserver, just select that.
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 7901c54..3c91db7 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -296,7 +296,7 @@ they correspond to these IP addresses.
 selectively enable/disable services per repository::
 	To enable 'git archive --remote' and disable 'git fetch' against
 	a repository, have the following in the configuration file in the
-	repository (that is the file 'config' next to 'HEAD', 'refs' and
+	repository (that is the file 'config' next to `HEAD`, 'refs' and
 	'objects').
 +
 ----------------------------------------------------------------
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 8144527..c1a3e8b 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -35,7 +35,7 @@ blame::
 
 browser::
 	Start a tree browser showing all files in the specified
-	commit (or 'HEAD' by default).  Files selected through the
+	commit (or `HEAD` by default).  Files selected through the
 	browser are opened in the blame viewer.
 
 citool::
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index a9f1909..dbc91f9 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -27,9 +27,9 @@ in the current working directory.  Note that:
    taken as relative to the current working directory.  E.g. when you are
    in a directory 'sub' that has a directory 'dir', you can run 'git
    ls-tree -r HEAD dir' to list the contents of the tree (that is
-   'sub/dir' in 'HEAD').  You don't want to give a tree that is not at the
+   'sub/dir' in `HEAD`).  You don't want to give a tree that is not at the
    root level (e.g. `git ls-tree -r HEAD:sub dir`) in this case, as that
-   would result in asking for 'sub/sub/dir' in the 'HEAD' commit.
+   would result in asking for 'sub/sub/dir' in the `HEAD` commit.
    However, the current working directory can be ignored by passing
    --full-tree option.
 
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 21c7af2..c83aaf3 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -275,7 +275,7 @@ These options can be used to modify 'git p4 submit' behavior.
 --origin <commit>::
 	Upstream location from which commits are identified to submit to
 	p4.  By default, this is the most recent p4 commit reachable
-	from 'HEAD'.
+	from `HEAD`.
 
 -M::
 	Detect renames.  See linkgit:git-diff[1].  Renames will be
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3225d0e..7ecca8e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -167,7 +167,7 @@ This option is only applicable when listing tags without annotation lines.
 
 --[no-]merged [<commit>]::
 	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit ('HEAD'
+	if `--no-merged` is used, from the specified commit (`HEAD`
 	if not specified).
 
 CONFIGURATION
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 53ce1d0..a4de50a 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -298,7 +298,7 @@ Supported if the helper has the "fetch" capability.
 	is followed by a blank line). For example, the following would
 	be two batches of 'push', the first asking the remote-helper
 	to push the local ref 'master' to the remote ref 'master' and
-	the local 'HEAD' to the remote 'branch', and the second
+	the local `HEAD` to the remote 'branch', and the second
 	asking to push ref 'foo' to ref 'bar' (forced update requested
 	by the '+').
 +
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 15879b3..abae363 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -28,8 +28,8 @@ blobs contained in a commit.
   first match in the following rules:
 
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
-    useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
-    and 'CHERRY_PICK_HEAD');
+    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
+    and `CHERRY_PICK_HEAD`);
 
   . otherwise, 'refs/<refname>' if it exists;
 
@@ -41,16 +41,16 @@ blobs contained in a commit.
 
   . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
 +
-'HEAD' names the commit on which you based the changes in the working tree.
-'FETCH_HEAD' records the branch which you fetched from a remote repository
+`HEAD` names the commit on which you based the changes in the working tree.
+`FETCH_HEAD` records the branch which you fetched from a remote repository
 with your last `git fetch` invocation.
-'ORIG_HEAD' is created by commands that move your 'HEAD' in a drastic
-way, to record the position of the 'HEAD' before their operation, so that
+`ORIG_HEAD` is created by commands that move your `HEAD` in a drastic
+way, to record the position of the `HEAD` before their operation, so that
 you can easily change the tip of the branch back to the state before you ran
 them.
-'MERGE_HEAD' records the commit(s) which you are merging into your branch
+`MERGE_HEAD` records the commit(s) which you are merging into your branch
 when you run `git merge`.
-'CHERRY_PICK_HEAD' records the commit which you are cherry-picking
+`CHERRY_PICK_HEAD` records the commit which you are cherry-picking
 when you run `git cherry-pick`.
 +
 Note that any of the 'refs/*' cases above may come either from
@@ -59,7 +59,7 @@ While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
 '@'::
-  '@' alone is a shortcut for 'HEAD'.
+  '@' alone is a shortcut for `HEAD`.
 
 '<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
   A ref followed by the suffix '@' with a date specification
@@ -101,7 +101,7 @@ some output processing may assume ref names in UTF-8.
 '<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
-  'HEAD' if no branchname is specified). Since our push destination is
+  `HEAD` if no branchname is specified). Since our push destination is
   in a remote repository, of course, we report the local tracking branch
   that corresponds to that branch (i.e., something in 'refs/remotes/').
 +
@@ -283,12 +283,12 @@ To summarize:
 '<rev1>..<rev2>'::
 	Include commits that are reachable from <rev2> but exclude
 	those that are reachable from <rev1>.  When either <rev1> or
-	<rev2> is omitted, it defaults to 'HEAD'.
+	<rev2> is omitted, it defaults to `HEAD`.
 
 '<rev1>\...<rev2>'::
 	Include commits that are reachable from either <rev1> or
 	<rev2> but exclude those that are reachable from both.  When
-	either <rev1> or <rev2> is omitted, it defaults to 'HEAD'.
+	either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
 
 '<rev>{caret}@', e.g. 'HEAD{caret}@'::
   A suffix '{caret}' followed by an at sign is the same as listing
-- 
2.8.2.397.gbe91ebf.dirty

