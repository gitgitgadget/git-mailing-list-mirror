From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Use 'fast-forward' all over the place
Date: Sat, 24 Oct 2009 11:31:32 +0300
Message-ID: <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 10:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1c2p-0007TS-HP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 10:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZJXIbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 04:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbZJXIbo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 04:31:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:57408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZJXIbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 04:31:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so521503fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C66RyZc08YhOcgOE5KgyRGcOEuYQG46od2kv3/uuLRs=;
        b=kiaMizrP9MZDxI0Itu4ZhgFlpulrEXYHgU05cdLRlu/NlsDuXZU3oYoEG+NSi5Jg0+
         QT4im7g7JeKOu4LbV9u9iFW7cYohMSZKek9zrrzPNk1/FW5+IBALOdfkvUmNc5a01m1k
         S13nWmyW9JJGK6PqbXJ7bQfWLwGm5rSvbK3gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nQHqEwLa/HW32E39eVKjJG6NESfDq1KNcJQqF23dovT7L/Jxoib4ZctFsAshn3bTCH
         suujf0YtS7xQB9/X7r5MEdo6lZJTLsrcAwogmbDp/7SHASIH/nhtGL4kfYl60toS0idr
         yn8uHfejK7ESJTlUpuAI6E0VLwDf+AquYAkng=
Received: by 10.86.187.27 with SMTP id k27mr6599264fgf.11.1256373103652;
        Sat, 24 Oct 2009 01:31:43 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l19sm2297270fgb.26.2009.10.24.01.31.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 01:31:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131147>

It's a compound word.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt                     |    2 +-
 Documentation/git-http-push.txt              |    4 ++--
 Documentation/git-push.txt                   |   14 +++++++-------
 Documentation/git-read-tree.txt              |    2 +-
 Documentation/git-receive-pack.txt           |    2 +-
 Documentation/git-reset.txt                  |    4 ++--
 Documentation/git-send-pack.txt              |    4 ++--
 Documentation/gitcore-tutorial.txt           |    4 ++--
 Documentation/githooks.txt                   |    2 +-
 Documentation/glossary-content.txt           |    4 ++--
 Documentation/howto/maintain-git.txt         |    2 +-
 Documentation/howto/revert-branch-rebase.txt |    4 ++--
 Documentation/howto/update-hook-example.txt  |    2 +-
 Documentation/pull-fetch-param.txt           |    4 ++--
 Documentation/user-manual.txt                |   14 +++++++-------
 builtin-fetch--tool.c                        |    8 ++++----
 builtin-fetch.c                              |    4 ++--
 builtin-merge.c                              |    8 ++++----
 builtin-push.c                               |    2 +-
 builtin-receive-pack.c                       |    4 ++--
 builtin-remote.c                             |    2 +-
 builtin-send-pack.c                          |    2 +-
 contrib/examples/git-merge.sh                |    8 ++++----
 contrib/examples/git-resolve.sh              |    2 +-
 contrib/hooks/post-receive-email             |    6 +++---
 git-gui/lib/branch_create.tcl                |    2 +-
 git-merge-octopus.sh                         |    2 +-
 git-pull.sh                                  |    2 +-
 git-rebase--interactive.sh                   |    6 +++---
 git-rebase.sh                                |    2 +-
 t/t1001-read-tree-m-2way.sh                  |    6 +++---
 t/t5505-remote.sh                            |    2 +-
 t/t5518-fetch-exit-status.sh                 |    2 +-
 t/t6028-merge-up-to-date.sh                  |    2 +-
 transport.c                                  |    2 +-
 unpack-trees.c                               |    2 +-
 36 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd17814..52bbafb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1351,7 +1351,7 @@ receive.denyCurrentBranch::
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
-	not a fast forward. Use this to prevent such an update via a push,
+	not a fast-forward. Use this to prevent such an update via a push,
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index aef383e..ddf7a18 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -82,11 +82,11 @@ destination side.
 
 Without '--force', the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
-ancestor) of <src>.  This check, known as "fast forward check",
+ancestor) of <src>.  This check, known as "fast-forward check",
 is performed in order to avoid accidentally overwriting the
 remote ref and lose other peoples' commits from there.
 
-With '--force', the fast forward check is disabled for all refs.
+With '--force', the fast-forward check is disabled for all refs.
 
 Optionally, a <ref> parameter can be prefixed with a plus '+' sign
 to disable the fast-forward check only on that ref.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ba6a8a2..1a9d886 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -50,9 +50,9 @@ updated.
 +
 The object referenced by <src> is used to update the <dst> reference
 on the remote side, but by default this is only allowed if the
-update can fast forward <dst>.  By having the optional leading `{plus}`,
+update can fast-forward <dst>.  By having the optional leading `{plus}`,
 you can tell git to update the <dst> ref even when the update is not a
-fast forward.  This does *not* attempt to merge <src> into <dst>.  See
+fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
 EXAMPLES below for details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
@@ -60,7 +60,7 @@ EXAMPLES below for details.
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
-The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
+The special refspec `:` (or `{plus}:` to allow non-fast-forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
@@ -171,10 +171,10 @@ summary::
 	For a successfully pushed ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
-	`<old>...<new>` for forced non-fast forward updates). For a
+	`<old>...<new>` for forced non-fast-forward updates). For a
 	failed update, more details are given for the failure.
 	The string `rejected` indicates that git did not try to send the
-	ref at all (typically because it is not a fast forward). The
+	ref at all (typically because it is not a fast-forward). The
 	string `remote rejected` indicates that the remote end refused
 	the update; this rejection is typically caused by a hook on the
 	remote side. The string `remote failure` indicates that the
@@ -342,9 +342,9 @@ git push origin :experimental::
 
 git push origin {plus}dev:master::
 	Update the origin repository's master branch with the dev branch,
-	allowing non-fast forward updates.  *This can leave unreferenced
+	allowing non-fast-forward updates.  *This can leave unreferenced
 	commits dangling in the origin repository.*  Consider the
-	following situation, where a fast forward is not possible:
+	following situation, where a fast-forward is not possible:
 +
 ----
 	    o---o---o---A---B  origin/master
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 4a932b0..a10ce4b 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -144,7 +144,7 @@ Two Tree Merge
 Typically, this is invoked as `git read-tree -m $H $M`, where $H
 is the head commit of the current repository, and $M is the head
 of a foreign tree, which is simply ahead of $H (i.e. we are in a
-fast forward situation).
+fast-forward situation).
 
 When two trees are specified, the user is telling 'git-read-tree'
 the following:
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 514f03c..cb5f405 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -20,7 +20,7 @@ The UI for the protocol is on the 'git-send-pack' side, and the
 program pair is meant to be used to push updates to remote
 repository.  For pull operations, see linkgit:git-fetch-pack[1].
 
-The command allows for creation and fast forwarding of sha1 refs
+The command allows for creation and fast-forwarding of sha1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end 'git-receive-pack' runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 469cf6d..2d27e40 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -150,7 +150,7 @@ Automatic merge failed; fix conflicts and then commit the result.
 $ git reset --hard                 <2>
 $ git pull . topic/branch          <3>
 Updating from 41223... to 13134...
-Fast forward
+Fast-forward
 $ git reset --hard ORIG_HEAD       <4>
 ------------
 +
@@ -161,7 +161,7 @@ right now, so you decide to do that later.
 which is a synonym for "git reset --hard HEAD" clears the mess
 from the index file and the working tree.
 <3> Merge a topic branch into the current branch, which resulted
-in a fast forward.
+in a fast-forward.
 <4> But you decided that the topic branch is not ready for public
 consumption yet.  "pull" or "merge" always leaves the original
 tip of the current branch in ORIG_HEAD, so resetting hard to it
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 3998218..5a04c6e 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -105,11 +105,11 @@ name. See linkgit:git-rev-parse[1].
 
 Without '--force', the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
-ancestor) of <src>.  This check, known as "fast forward check",
+ancestor) of <src>.  This check, known as "fast-forward check",
 is performed in order to avoid accidentally overwriting the
 remote ref and lose other peoples' commits from there.
 
-With '--force', the fast forward check is disabled for all refs.
+With '--force', the fast-forward check is disabled for all refs.
 
 Optionally, a <ref> parameter can be prefixed with a plus '+' sign
 to disable the fast-forward check only on that ref.
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index b3640c4..253ef62 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -993,7 +993,7 @@ would be different)
 
 ----------------
 Updating from ae3a2da... to a80b4aa....
-Fast forward (no commit created; -m option ignored)
+Fast-forward (no commit created; -m option ignored)
  example |    1 +
  hello   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
@@ -1003,7 +1003,7 @@ Because your branch did not contain anything more than what had
 already been merged into the `master` branch, the merge operation did
 not actually do a merge. Instead, it just updated the top of
 the tree of your branch to that of the `master` branch. This is
-often called 'fast forward' merge.
+often called 'fast-forward' merge.
 
 You can run `gitk \--all` again to see how the commit ancestry
 looks like, or run 'show-branch', which tells you this.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 06e0f31..4cc3d13 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -229,7 +229,7 @@ from updating that ref.
 This hook can be used to prevent 'forced' update on certain refs by
 making sure that the object name is a commit object that is a
 descendant of the commit object named by the old object name.
-That is, to enforce a "fast forward only" policy.
+That is, to enforce a "fast-forward only" policy.
 
 It could also be used to log the old..new status.  However, it
 does not know the entire set of branches, so it would end up
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 43d84d1..1f029f8 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -124,7 +124,7 @@ to point at the new commit.
 	An evil merge is a <<def_merge,merge>> that introduces changes that
 	do not appear in any <<def_parent,parent>>.
 
-[[def_fast_forward]]fast forward::
+[[def_fast_forward]]fast-forward::
 	A fast-forward is a special type of <<def_merge,merge>> where you have a
 	<<def_revision,revision>> and you are "merging" another
 	<<def_branch,branch>>'s changes that happen to be a descendant of what
@@ -220,7 +220,7 @@ to point at the new commit.
 	conflict, manual intervention may be required to complete the
 	merge.
 +
-As a noun: unless it is a <<def_fast_forward,fast forward>>, a
+As a noun: unless it is a <<def_fast_forward,fast-forward>>, a
 successful merge results in the creation of a new <<def_commit,commit>>
 representing the result of the merge, and having as
 <<def_parent,parents>> the tips of the merged <<def_branch,branches>>.
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 4357e26..d527b30 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -59,7 +59,7 @@ The policy.
    not yet pass the criteria set for 'next'.
 
  - The tips of 'master', 'maint' and 'next' branches will always
-   fast forward, to allow people to build their own
+   fast-forward, to allow people to build their own
    customization on top of them.
 
  - Usually 'master' contains all of 'maint', 'next' contains all
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index e70d8a3..8c32da6 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -85,7 +85,7 @@ Fortunately I did not have to; what I have in the current branch
 
 ------------------------------------------------
 $ git checkout master
-$ git merge revert-c99 ;# this should be a fast forward
+$ git merge revert-c99 ;# this should be a fast-forward
 Updating from 10d781b9caa4f71495c7b34963bef137216f86a8 to e3a693c...
  cache.h        |    8 ++++----
  commit.c       |    2 +-
@@ -95,7 +95,7 @@ Updating from 10d781b9caa4f71495c7b34963bef137216f86a8 to e3a693c...
  5 files changed, 8 insertions(+), 8 deletions(-)
 ------------------------------------------------
 
-There is no need to redo the test at this point.  We fast forwarded
+There is no need to redo the test at this point.  We fast-forwarded
 and we know 'master' matches 'revert-c99' exactly.  In fact:
 
 ------------------------------------------------
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index 697d918..b7f8d41 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -76,7 +76,7 @@ case "$1" in
     if expr "$2" : '0*$' >/dev/null; then
       info "The branch '$1' is new..."
     else
-      # updating -- make sure it is a fast forward
+      # updating -- make sure it is a fast-forward
       mb=$(git-merge-base "$2" "$3")
       case "$mb,$2" in
         "$2,$mb") info "Update is fast-forward" ;;
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index f9811f2..44d9363 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -11,9 +11,9 @@
 +
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
-ref that matches it is fast forwarded using <src>.
+ref that matches it is fast-forwarded using <src>.
 If the optional plus `+` is used, the local ref
-is updated even if it does not result in a fast forward
+is updated even if it does not result in a fast-forward
 update.
 +
 [NOTE]
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 67ebffa..42d92fd 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1384,7 +1384,7 @@ were merged.
 
 However, if the current branch is a descendant of the other--so every
 commit present in the one is already contained in the other--then git
-just performs a "fast forward"; the head of the current branch is moved
+just performs a "fast-forward"; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
 
@@ -1719,7 +1719,7 @@ producing a default commit message documenting the branch and
 repository that you pulled from.
 
 (But note that no such commit will be created in the case of a
-<<fast-forwards,fast forward>>; instead, your branch will just be
+<<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
 The `git pull` command can also be given "." as the "remote" repository,
@@ -1943,7 +1943,7 @@ $ git push ssh://yourserver.com/~you/proj.git master
 -------------------------------------------------
 
 As with `git fetch`, `git push` will complain if this does not result in a
-<<fast-forwards,fast forward>>; see the following section for details on
+<<fast-forwards,fast-forward>>; see the following section for details on
 handling this case.
 
 Note that the target of a "push" is normally a
@@ -1976,7 +1976,7 @@ details.
 What to do when a push fails
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If a push would not result in a <<fast-forwards,fast forward>> of the
+If a push would not result in a <<fast-forwards,fast-forward>> of the
 remote branch, then it will fail with an error like:
 
 -------------------------------------------------
@@ -2115,7 +2115,7 @@ $ git checkout release && git pull
 
 Important note!  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a "Fast forward" merge).  Many people dislike
+changes git will simply do a fast-forward merge).  Many people dislike
 the "noise" that this creates in the Linux history, so you should avoid
 doing this capriciously in the "release" branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
@@ -2729,9 +2729,9 @@ In the previous example, when updating an existing branch, "git fetch"
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
-commit.  Git calls this process a <<fast-forwards,fast forward>>.
+commit.  Git calls this process a <<fast-forwards,fast-forward>>.
 
-A fast forward looks something like this:
+A fast-forward looks something like this:
 
 ................................................
  o--o--o--o <-- old head of the branch
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 3dbdf7a..cd10dbc 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -97,21 +97,21 @@ static int update_local_ref(const char *name,
 	strcpy(newh, find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
 
 	if (in_merge_bases(current, &updated, 1)) {
-		fprintf(stderr, "* %s: fast forward to %s\n",
+		fprintf(stderr, "* %s: fast-forward to %s\n",
 			name, note);
 		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
-		return update_ref_env("fast forward", name, sha1_new, sha1_old);
+		return update_ref_env("fast-forward", name, sha1_new, sha1_old);
 	}
 	if (!force) {
 		fprintf(stderr,
-			"* %s: not updating to non-fast forward %s\n",
+			"* %s: not updating to non-fast-forward %s\n",
 			name, note);
 		fprintf(stderr,
 			"  old...new: %s...%s\n", oldh, newh);
 		return 1;
 	}
 	fprintf(stderr,
-		"* %s: forcing update to non-fast forward %s\n",
+		"* %s: forcing update to non-fast-forward %s\n",
 		name, note);
 	fprintf(stderr, "  old...new: %s...%s\n", oldh, newh);
 	return update_ref_env("forced-update", name, sha1_new, sha1_old);
diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..89cedc8 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -269,7 +269,7 @@ static int update_local_ref(struct ref *ref,
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "..");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-		r = s_update_ref("fast forward", ref, 1);
+		r = s_update_ref("fast-forward", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : ' ',
 			SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
 			pretty_ref, r ? "  (unable to update local ref)" : "");
@@ -287,7 +287,7 @@ static int update_local_ref(struct ref *ref,
 			r ? "unable to update local ref" : "forced update");
 		return r;
 	} else {
-		sprintf(display, "! %-*s %-*s -> %s  (non fast forward)",
+		sprintf(display, "! %-*s %-*s -> %s  (non fast-forward)",
 			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
 			pretty_ref);
 		return 1;
diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..a595b8b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -166,7 +166,7 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
-		"allow fast forward (default)"),
+		"allow fast-forward (default)"),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
@@ -1013,7 +1013,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				hex,
 				find_unique_abbrev(remoteheads->item->object.sha1,
 				DEFAULT_ABBREV));
-		strbuf_addstr(&msg, "Fast forward");
+		strbuf_addstr(&msg, "Fast-forward");
 		if (have_message)
 			strbuf_addstr(&msg,
 				" (no commit created; -m option ignored)");
@@ -1031,12 +1031,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	} else if (!remoteheads->next && common->next)
 		;
 		/*
-		 * We are not doing octopus and not fast forward.  Need
+		 * We are not doing octopus and not fast-forward.  Need
 		 * a real merge.
 		 */
 	else if (!remoteheads->next && !common->next && option_commit) {
 		/*
-		 * We are not doing octopus, not fast forward, and have
+		 * We are not doing octopus, not fast-forward, and have
 		 * only one common.
 		 */
 		refresh_cache(REFRESH_QUIET);
diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..e883574 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -159,7 +159,7 @@ static int do_push(const char *repo, int flags)
 		error("failed to push some refs to '%s'", url[i]);
 		if (nonfastforward && advice_push_nonfastforward) {
 			printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
-			       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
+			       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
 			       "section of 'git push --help' for details.\n");
 		}
 		errs++;
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..fea8fcd 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -329,9 +329,9 @@ static const char *update(struct command *cmd)
 				break;
 		free_commit_list(bases);
 		if (!ent) {
-			error("denying non-fast forward %s"
+			error("denying non-fast-forward %s"
 			      " (you should pull first)", name);
-			return "non-fast forward";
+			return "non-fast-forward";
 		}
 	}
 	if (run_update_hook(cmd)) {
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..9aafc19 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -953,7 +953,7 @@ static int show_push_info_item(struct string_list_item *item, void *cb_data)
 		status = "up to date";
 		break;
 	case PUSH_STATUS_FASTFORWARD:
-		status = "fast forwardable";
+		status = "fast-forwardable";
 		break;
 	case PUSH_STATUS_OUTOFDATE:
 		status = "local out of date";
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 37e528e..37acad5 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -246,7 +246,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count)
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				"non-fast forward");
+				"non-fast-forward");
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index e9588ee..500635f 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -14,7 +14,7 @@ summary              (synonym to --stat)
 log                  add list of one-line log to merge commit message
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge succeeds (default)
-ff                   allow fast forward (default)
+ff                   allow fast-forward (default)
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
 "
@@ -353,7 +353,7 @@ t,1,"$head",*)
 	# Again the most common case of merging one remote.
 	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $1)"
 	git update-index --refresh 2>/dev/null
-	msg="Fast forward"
+	msg="Fast-forward"
 	if test -n "$have_message"
 	then
 		msg="$msg (no commit created; -m option ignored)"
@@ -365,11 +365,11 @@ t,1,"$head",*)
 	exit 0
 	;;
 ?,1,?*"$LF"?*,*)
-	# We are not doing octopus and not fast forward.  Need a
+	# We are not doing octopus and not fast-forward.  Need a
 	# real merge.
 	;;
 ?,1,*,)
-	# We are not doing octopus, not fast forward, and have only
+	# We are not doing octopus, not fast-forward, and have only
 	# one common.
 	git update-index --refresh 2>/dev/null
 	case "$allow_trivial_merge" in
diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resolve.sh
index 0ee1bd8..8f98142 100755
--- a/contrib/examples/git-resolve.sh
+++ b/contrib/examples/git-resolve.sh
@@ -48,7 +48,7 @@ case "$common" in
 "$head")
 	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $merge)"
 	git read-tree -u -m $head $merge || exit 1
-	git update-ref -m "resolve $merge_name: Fast forward" \
+	git update-ref -m "resolve $merge_name: Fast-forward" \
 		HEAD "$merge" "$head"
 	git diff-tree -p $head $merge | git apply --stat
 	dropheads
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2a66063..3b075ad 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -315,8 +315,8 @@ generate_update_branch_email()
 	# "remotes/" will be ignored as well.
 
 	# List all of the revisions that were removed by this update, in a
-	# fast forward update, this list will be empty, because rev-list O
-	# ^N is empty.  For a non fast forward, O ^N is the list of removed
+	# fast-forward update, this list will be empty, because rev-list O
+	# ^N is empty.  For a non fast-forward, O ^N is the list of removed
 	# revisions
 	fast_forward=""
 	rev=""
@@ -411,7 +411,7 @@ generate_update_branch_email()
 	# revision because the base is effectively a random revision at this
 	# point - the user will be interested in what this revision changed
 	# - including the undoing of previous revisions in the case of
-	# non-fast forward updates.
+	# non-fast-forward updates.
 	echo ""
 	echo "Summary of changes:"
 	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
diff --git a/git-gui/lib/branch_create.tcl b/git-gui/lib/branch_create.tcl
index 3817771..f1235c7 100644
--- a/git-gui/lib/branch_create.tcl
+++ b/git-gui/lib/branch_create.tcl
@@ -77,7 +77,7 @@ constructor dialog {} {
 		-variable @opt_merge
 	pack $w.options.merge.no -side left
 	radiobutton $w.options.merge.ff \
-		-text [mc "Fast Forward Only"] \
+		-text [mc "Fast-forward Only"] \
 		-value ff \
 		-variable @opt_merge
 	pack $w.options.merge.ff -side left
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 1dadbb4..825c52c 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -81,7 +81,7 @@ do
 		# tree as the intermediate result of the merge.
 		# We still need to count this as part of the parent set.
 
-		echo "Fast forwarding to: $SHA1"
+		echo "Fast-forwarding to: $SHA1"
 		git read-tree -u -m $head $SHA1 || exit
 		MRC=$SHA1 MRT=$(git write-tree)
 		continue
diff --git a/git-pull.sh b/git-pull.sh
index fc78592..f36eb3e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -171,7 +171,7 @@ then
 	# First update the working tree to match $curr_head.
 
 	echo >&2 "Warning: fetch updated the current branch head."
-	echo >&2 "Warning: fast forwarding your working tree from"
+	echo >&2 "Warning: fast-forwarding your working tree from"
 	echo >&2 "Warning: commit $orig_head."
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..c898788 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -168,7 +168,7 @@ pick_one () {
 		output git reset --hard $sha1
 		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
-		output warn Fast forward to $sha1
+		output warn Fast-forward to $sha1
 	else
 		output git cherry-pick "$@"
 	fi
@@ -248,9 +248,9 @@ pick_one_preserving_merges () {
 	done
 	case $fast_forward in
 	t)
-		output warn "Fast forward to $sha1"
+		output warn "Fast-forward to $sha1"
 		output git reset --hard $sha1 ||
-			die "Cannot fast forward to $sha1"
+			die "Cannot fast-forward to $sha1"
 		;;
 	f)
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
diff --git a/git-rebase.sh b/git-rebase.sh
index 6ec155c..6830e16 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -496,7 +496,7 @@ then
 fi
 
 # If the $onto is a proper descendant of the tip of the branch, then
-# we just fast forwarded.
+# we just fast-forwarded.
 if test "$mb" = "$branch"
 then
 	say "Fast-forwarded $branch_name to $onto_name."
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 271bc4e..c2d408b 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -5,7 +5,7 @@
 
 test_description='Two way merge with read-tree -m $H $M
 
-This test tries two-way merge (aka fast forward with carry forward).
+This test tries two-way merge (aka fast-forward with carry forward).
 
 There is the head (called H) and another commit (called M), which is
 simply ahead of H.  The index and the work tree contains a state that
@@ -51,7 +51,7 @@ check_cache_at () {
 }
 
 cat >bozbar-old <<\EOF
-This is a sample file used in two-way fast forward merge
+This is a sample file used in two-way fast-forward merge
 tests.  Its second line ends with a magic word bozbar
 which will be modified by the merged head to gnusto.
 It has some extra lines so that external tools can
@@ -300,7 +300,7 @@ test_expect_success \
      echo gnusto gnusto >bozbar &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
-# This fails with straight two-way fast forward.
+# This fails with straight two-way fast-forward.
 test_expect_success \
     '22 - local change cache updated.' \
     'rm -f .git/index &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 852ccb5..220b6a3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -158,7 +158,7 @@ cat > test/expect << EOF
     another
     master
   Local refs configured for 'git push':
-    ahead  forces to master  (fast forwardable)
+    ahead  forces to master  (fast-forwardable)
     master pushes to another (up to date)
 EOF
 
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index c6bc65f..c2060bb 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -22,7 +22,7 @@ test_expect_success setup '
 	git commit -a -m next
 '
 
-test_expect_success 'non fast forward fetch' '
+test_expect_success 'non-fast-forward fetch' '
 
 	test_must_fail git fetch . master:side
 
diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
index f8f3e3f..a91644e 100755
--- a/t/t6028-merge-up-to-date.sh
+++ b/t/t6028-merge-up-to-date.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='merge fast forward and up to date'
+test_description='merge fast-forward and up to date'
 
 . ./test-lib.sh
 
diff --git a/transport.c b/transport.c
index 644a30a..d81a42a 100644
--- a/transport.c
+++ b/transport.c
@@ -668,7 +668,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "non-fast forward", porcelain);
+						 "non-fast-forward", porcelain);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..157d5d0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -895,7 +895,7 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
  * Two-way merge.
  *
  * The rule is to "carry forward" what is in the index without losing
- * information across a "fast forward", favoring a successful merge
+ * information across a "fast-forward", favoring a successful merge
  * over a merge failure when it makes sense.  For details of the
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
-- 
1.6.5.1
