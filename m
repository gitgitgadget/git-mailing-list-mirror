From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/7] user-manual: remove some git-foo usage
Date: Sat,  4 Apr 2009 12:38:23 +0300
Message-ID: <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:41:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2N6-00020I-B1
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbZDDJiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbZDDJiv
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:38:51 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:47067 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbZDDJio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:44 -0400
Received: by bwz17 with SMTP id 17so1248812bwz.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0ufCEQLGK66Sc+ZHi0+UvxYG5+Rcd/FMffLNy1zZhCo=;
        b=VJlg9fkQaJ475Ozf7LYbkE8En4yd4qYm2gwAfZgasN0pMClXNWixLUtTPBQ1fwjKru
         xFW5ebQn4QdDIC1OAj9Pe14FpLaGQACx0hdg35cSc/PLRfGDv6Y5yXQ4HhvieZq4J8Wx
         zNbgNVCayfNBkM2U2YVrU6IFwDlru7Kmq3w9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZehwjRGP8Bl/j8SKogE5MN+RMghK5FgqmK41OdlprVl5R2D8WtcQvns1os1Bok4A95
         WDTjJIlZul0PVaEXdQQM3qR773n+1rzIgO8Khdlswc2D0YJkCzG+YSxRWje48tKKTWmf
         eTRBeRObCZSm2Jlz954cYaOZsQZTOyErzRjrI=
Received: by 10.204.62.68 with SMTP id w4mr757575bkh.122.1238837920758;
        Sat, 04 Apr 2009 02:38:40 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm1224081fks.5.2009.04.04.02.38.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
In-Reply-To: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115576>

Also, use `git foo` when it make sense.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |  148 ++++++++++++++++++++--------------------
 1 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e33b29b..e1bc955 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -188,7 +188,7 @@ As you can see, a commit shows who made the latest change, what they
 did, and why.
 
 Every commit has a 40-hexdigit id, sometimes called the "object name" or the
-"SHA1 id", shown on the first line of the "git-show" output.  You can usually
+"SHA1 id", shown on the first line of the "git show" output.  You can usually
 refer to a commit by a shorter name, such as a tag or a branch name, but this
 longer name can also be useful.  Most importantly, it is a globally unique
 name for this commit: so if you tell somebody else the object name (for
@@ -307,7 +307,7 @@ ref: refs/heads/master
 Examining an old version without creating a new branch
 ------------------------------------------------------
 
-The git-checkout command normally expects a branch head, but will also
+The `git checkout` command normally expects a branch head, but will also
 accept an arbitrary commit; for example, you can check out the commit
 referenced by a tag:
 
@@ -400,7 +400,7 @@ references with the same shorthand name, see the "SPECIFYING
 REVISIONS" section of linkgit:git-rev-parse[1].
 
 [[Updating-a-repository-With-git-fetch]]
-Updating a repository with git-fetch
+Updating a repository with git fetch
 ------------------------------------
 
 Eventually the developer cloned from will do additional work in her
@@ -427,7 +427,7 @@ $ git fetch linux-nfs
 -------------------------------------------------
 
 New remote-tracking branches will be stored under the shorthand name
-that you gave "git-remote add", in this case linux-nfs:
+that you gave "git remote add", in this case linux-nfs:
 
 -------------------------------------------------
 $ git branch -r
@@ -516,7 +516,7 @@ $ git bisect reset
 
 to return you to the branch you were on before.
 
-Note that the version which git-bisect checks out for you at each
+Note that the version which `git bisect` checks out for you at each
 point is just a suggestion, and you're free to try a different
 version if you think it would be a good idea.  For example,
 occasionally you may land on a commit that broke something unrelated;
@@ -592,11 +592,11 @@ In addition to HEAD, there are several other special names for
 commits:
 
 Merges (to be discussed later), as well as operations such as
-git-reset, which change the currently checked-out commit, generally
+`git reset`, which change the currently checked-out commit, generally
 set ORIG_HEAD to the value HEAD had before the current operation.
 
-The git-fetch operation always stores the head of the last fetched
-branch in FETCH_HEAD.  For example, if you run git fetch without
+The `git fetch` operation always stores the head of the last fetched
+branch in FETCH_HEAD.  For example, if you run `git fetch` without
 specifying a local branch as the target of the operation
 
 -------------------------------------------------
@@ -1073,9 +1073,9 @@ $ git diff
 
 shows the difference between the working tree and the index file.
 
-Note that "git-add" always adds just the current contents of a file
+Note that "git add" always adds just the current contents of a file
 to the index; further changes to the same file will be ignored unless
-you run git-add on the file again.
+you run `git add` on the file again.
 
 When you're ready, just run
 
@@ -1136,7 +1136,7 @@ Ignoring files
 A project will often generate files that you do 'not' want to track with git.
 This typically includes files generated by a build process or temporary
 backup files made by your editor. Of course, 'not' tracking files with git
-is just a matter of 'not' calling `git-add` on them. But it quickly becomes
+is just a matter of 'not' calling `git add` on them. But it quickly becomes
 annoying to have these untracked files lying around; e.g. they make
 `git add .` practically useless, and they keep showing up in the output of
 `git status`.
@@ -1349,7 +1349,7 @@ $ git add file.txt
 -------------------------------------------------
 
 the different stages of that file will be "collapsed", after which
-git-diff will (by default) no longer show diffs for that file.
+`git diff` will (by default) no longer show diffs for that file.
 
 [[undoing-a-merge]]
 Undoing a merge
@@ -1446,7 +1446,7 @@ Fixing a mistake by rewriting history
 
 If the problematic commit is the most recent commit, and you have not
 yet made that commit public, then you may just
-<<undoing-a-merge,destroy it using git-reset>>.
+<<undoing-a-merge,destroy it using `git reset`>>.
 
 Alternatively, you
 can edit the working directory and update the index to fix your
@@ -1474,7 +1474,7 @@ Checking out an old version of a file
 
 In the process of undoing a previous bad change, you may find it
 useful to check out an older version of a particular file using
-linkgit:git-checkout[1].  We've used git-checkout before to switch
+linkgit:git-checkout[1].  We've used `git checkout` before to switch
 branches, but it has quite different behavior if it is given a path
 name: the command
 
@@ -1542,7 +1542,7 @@ $ git gc
 -------------------------------------------------
 
 to recompress the archive.  This can be very time-consuming, so
-you may prefer to run git-gc when you are not doing other work.
+you may prefer to run `git gc` when you are not doing other work.
 
 
 [[ensuring-reliability]]
@@ -1634,7 +1634,7 @@ In some situations the reflog may not be able to save you.  For example,
 suppose you delete a branch, then realize you need the history it
 contained.  The reflog is also deleted; however, if you have not yet
 pruned the repository, then you may still be able to find the lost
-commits in the dangling objects that git-fsck reports.  See
+commits in the dangling objects that `git fsck` reports.  See
 <<dangling-objects>> for the details.
 
 -------------------------------------------------
@@ -1676,7 +1676,7 @@ Sharing development with others
 ===============================
 
 [[getting-updates-With-git-pull]]
-Getting updates with git-pull
+Getting updates with git pull
 -----------------------------
 
 After you clone a repository and make a few changes of your own, you
@@ -1722,7 +1722,7 @@ repository that you pulled from.
 <<fast-forwards,fast forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
-The git-pull command can also be given "." as the "remote" repository,
+The `git pull` command can also be given "." as the "remote" repository,
 in which case it just merges in a branch from the current repository; so
 the commands
 
@@ -1795,7 +1795,7 @@ Public git repositories
 Another way to submit changes to a project is to tell the maintainer
 of that project to pull the changes from your repository using
 linkgit:git-pull[1].  In the section "<<getting-updates-With-git-pull,
-Getting updates with git-pull>>" we described this as a way to get
+Getting updates with `git pull`>>" we described this as a way to get
 updates from the "main" repository, but it works just as well in the
 other direction.
 
@@ -1847,7 +1847,7 @@ Setting up a public repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Assume your personal repository is in the directory ~/proj.  We
-first create a new clone of the repository and tell git-daemon that it
+first create a new clone of the repository and tell `git daemon` that it
 is meant to be public:
 
 -------------------------------------------------
@@ -1878,10 +1878,10 @@ repository>>", below.
 Otherwise, all you need to do is start linkgit:git-daemon[1]; it will
 listen on port 9418.  By default, it will allow access to any directory
 that looks like a git directory and contains the magic file
-git-daemon-export-ok.  Passing some directory paths as git-daemon
+git-daemon-export-ok.  Passing some directory paths as `git daemon`
 arguments will further restrict the exports to those paths.
 
-You can also run git-daemon as an inetd service; see the
+You can also run `git daemon` as an inetd service; see the
 linkgit:git-daemon[1] man page for details.  (See especially the
 examples section.)
 
@@ -1942,7 +1942,7 @@ or just
 $ git push ssh://yourserver.com/~you/proj.git master
 -------------------------------------------------
 
-As with git-fetch, git-push will complain if this does not result in a
+As with `git fetch`, `git push` will complain if this does not result in a
 <<fast-forwards,fast forward>>; see the following section for details on
 handling this case.
 
@@ -1952,7 +1952,7 @@ repository that has a checked-out working tree, but the working tree
 will not be updated by the push.  This may lead to unexpected results if
 the branch you push to is the currently checked-out branch!
 
-As with git-fetch, you may also set up configuration options to
+As with `git fetch`, you may also set up configuration options to
 save typing; so, for example, after
 
 -------------------------------------------------
@@ -1988,13 +1988,13 @@ error: failed to push to 'ssh://yourserver.com/~you/proj.git'
 
 This can happen, for example, if you:
 
-	- use `git-reset --hard` to remove already-published commits, or
-	- use `git-commit --amend` to replace already-published commits
+	- use `git reset --hard` to remove already-published commits, or
+	- use `git commit --amend` to replace already-published commits
 	  (as in <<fixing-a-mistake-by-rewriting-history>>), or
-	- use `git-rebase` to rebase any already-published commits (as
+	- use `git rebase` to rebase any already-published commits (as
 	  in <<using-git-rebase>>).
 
-You may force git-push to perform the update anyway by preceding the
+You may force `git push` to perform the update anyway by preceding the
 branch name with a plus sign:
 
 -------------------------------------------------
@@ -2036,7 +2036,7 @@ advantages over the central shared repository:
 
 	- Git's ability to quickly import and merge patches allows a
 	  single maintainer to process incoming changes even at very
-	  high rates.  And when that becomes too much, git-pull provides
+	  high rates.  And when that becomes too much, `git pull` provides
 	  an easy way for that maintainer to delegate this job to other
 	  maintainers while still allowing optional review of incoming
 	  changes.
@@ -2404,7 +2404,7 @@ use them, and then explain some of the problems that can arise because
 you are rewriting history.
 
 [[using-git-rebase]]
-Keeping a patch series up to date using git-rebase
+Keeping a patch series up to date using git rebase
 --------------------------------------------------
 
 Suppose that you create a branch "mywork" on a remote-tracking branch
@@ -2468,9 +2468,9 @@ patches to the new mywork.  The result will look like:
 ................................................
 
 In the process, it may discover conflicts.  In that case it will stop
-and allow you to fix the conflicts; after fixing conflicts, use "git-add"
+and allow you to fix the conflicts; after fixing conflicts, use `git add`
 to update the index with those contents, and then, instead of
-running git-commit, just run
+running `git commit`, just run
 
 -------------------------------------------------
 $ git rebase --continue
@@ -2508,7 +2508,7 @@ with
 $ git tag bad mywork~5
 -------------------------------------------------
 
-(Either gitk or git-log may be useful for finding the commit.)
+(Either gitk or `git log` may be useful for finding the commit.)
 
 Then check out that commit, edit it, and rebase the rest of the series
 on top of it (note that we could check out the commit on a temporary
@@ -2549,12 +2549,12 @@ $ gitk origin..mywork &
 
 and browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
-cherry-pick, and possibly modifying them as you go using `commit --amend`.
+cherry-pick, and possibly modifying them as you go using `git commit --amend`.
 The linkgit:git-gui[1] command may also help as it allows you to
 individually select diff hunks for inclusion in the index (by
 right-clicking on the diff hunk and choosing "Stage Hunk for Commit").
 
-Another technique is to use git-format-patch to create a series of
+Another technique is to use `git format-patch` to create a series of
 patches, then reset the state to before the patches:
 
 -------------------------------------------------
@@ -2662,7 +2662,7 @@ you know is that D is bad, that Z is good, and that
 linkgit:git-bisect[1] identifies C as the culprit, how will you
 figure out that the problem is due to this change in semantics?
 
-When the result of a git-bisect is a non-merge commit, you should
+When the result of a `git bisect` is a non-merge commit, you should
 normally be able to discover the problem by examining just that commit.
 Developers can make this easy by breaking their changes into small
 self-contained commits.  That won't help in the case above, however,
@@ -2725,7 +2725,7 @@ master branch.  In more detail:
 git fetch and fast-forwards
 ---------------------------
 
-In the previous example, when updating an existing branch, "git-fetch"
+In the previous example, when updating an existing branch, "git fetch"
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
@@ -2751,7 +2751,7 @@ resulting in a situation like:
             o--o--o <-- new head of the branch
 ................................................
 
-In this case, "git-fetch" will fail, and print out a warning.
+In this case, "git fetch" will fail, and print out a warning.
 
 In that case, you can still force git to update to the new head, as
 described in the following section.  However, note that in the
@@ -2760,7 +2760,7 @@ unless you've already created a reference of your own pointing to
 them.
 
 [[forcing-fetch]]
-Forcing git-fetch to do non-fast-forward updates
+Forcing git fetch to do non-fast-forward updates
 ------------------------------------------------
 
 If git fetch fails because the new head of a branch is not a
@@ -3131,7 +3131,7 @@ $ git prune
 
 to remove any of the "loose" objects that are now contained in the
 pack.  This will also remove any unreferenced objects (which may be
-created when, for example, you use "git-reset" to remove a commit).
+created when, for example, you use "git reset" to remove a commit).
 You can verify that the loose objects are gone by looking at the
 .git/objects directory or by running
 
@@ -3160,7 +3160,7 @@ branch still exists, as does everything it pointed to. The branch
 pointer itself just doesn't, since you replaced it with another one.
 
 There are also other situations that cause dangling objects. For
-example, a "dangling blob" may arise because you did a "git-add" of a
+example, a "dangling blob" may arise because you did a "git add" of a
 file, but then, before you actually committed it and made it part of the
 bigger picture, you changed something else in that file and committed
 that *updated* thing--the old state that you added originally ends up
@@ -3210,7 +3210,7 @@ Usually, dangling blobs and trees aren't very interesting. They're
 almost always the result of either being a half-way mergebase (the blob
 will often even have the conflict markers from a merge in it, if you
 have had conflicting merges that you fixed up by hand), or simply
-because you interrupted a "git-fetch" with ^C or something like that,
+because you interrupted a "git fetch" with ^C or something like that,
 leaving _some_ of the new objects in the object database, but just
 dangling and useless.
 
@@ -3225,9 +3225,9 @@ and they'll be gone. But you should only run "git prune" on a quiescent
 repository--it's kind of like doing a filesystem fsck recovery: you
 don't want to do that while the filesystem is mounted.
 
-(The same is true of "git-fsck" itself, btw, but since
-git-fsck never actually *changes* the repository, it just reports
-on what it found, git-fsck itself is never "dangerous" to run.
+(The same is true of "git fsck" itself, btw, but since
+`git fsck` never actually *changes* the repository, it just reports
+on what it found, `git fsck` itself is never 'dangerous' to run.
 Running it while somebody is actually changing the repository can cause
 confusing and scary messages, but it won't actually do anything bad. In
 contrast, running "git prune" while somebody is actively changing the
@@ -3489,14 +3489,14 @@ done
 
 NOTE: Do not use local URLs here if you plan to publish your superproject!
 
-See what files `git-submodule` created:
+See what files `git submodule` created:
 
 -------------------------------------------------
 $ ls -a
 .  ..  .git  .gitmodules  a  b  c  d
 -------------------------------------------------
 
-The `git-submodule add <repo> <path>` command does a couple of things:
+The `git submodule add <repo> <path>` command does a couple of things:
 
 - It clones the submodule from <repo> to the given <path> under the
   current directory and by default checks out the master branch.
@@ -3542,7 +3542,7 @@ init` to add the submodule repository URLs to `.git/config`:
 $ git submodule init
 -------------------------------------------------
 
-Now use `git-submodule update` to clone the repositories and check out the
+Now use `git submodule update` to clone the repositories and check out the
 commits specified in the superproject:
 
 -------------------------------------------------
@@ -3552,8 +3552,8 @@ $ ls -a
 .  ..  .git  a.txt
 -------------------------------------------------
 
-One major difference between `git-submodule update` and `git-submodule add` is
-that `git-submodule update` checks out a specific commit, rather than the tip
+One major difference between `git submodule update` and `git submodule add` is
+that `git submodule update` checks out a specific commit, rather than the tip
 of a branch. It's like checking out a tag: the head is detached, so you're not
 working on a branch.
 
@@ -3769,7 +3769,7 @@ You update your working directory from the index by "checking out"
 files. This is not a very common operation, since normally you'd just
 keep your files updated, and rather than write to your working
 directory, you'd tell the index files about the changes in your
-working directory (i.e. `git-update-index`).
+working directory (i.e. `git update-index`).
 
 However, if you decide to jump to a new version, or check out somebody
 else's version, or just restore a previous tree, you'd populate your
@@ -3782,7 +3782,7 @@ $ git checkout-index filename
 
 or, if you want to check out all of the index, use `-a`.
 
-NOTE! git-checkout-index normally refuses to overwrite old files, so
+NOTE! `git checkout-index` normally refuses to overwrite old files, so
 if you have an old version of the tree already checked out, you will
 need to use the "-f" flag ('before' the "-a" flag or the filename) to
 'force' the checkout.
@@ -3820,7 +3820,7 @@ $ git commit-tree <tree> -p <parent> [-p <parent2> ..]
 and then giving the reason for the commit on stdin (either through
 redirection from a pipe or file, or by just typing it at the tty).
 
-git-commit-tree will return the name of the object that represents
+`git commit-tree` will return the name of the object that represents
 that commit, and you should save it away for later use. Normally,
 you'd commit a new `HEAD` state, and while git doesn't care where you
 save the note about that state, in practice we tend to just write the
@@ -3889,7 +3889,7 @@ $ git cat-file blob|tree|commit|tag <objectname>
 
 to show its contents. NOTE! Trees have binary content, and as a result
 there is a special helper for showing that content, called
-`git-ls-tree`, which turns the binary content into a more easily
+`git ls-tree`, which turns the binary content into a more easily
 readable form.
 
 It's especially instructive to look at "commit" objects, since those
@@ -3984,7 +3984,7 @@ came from: stage 1 corresponds to `$orig` tree, stage 2 `HEAD`
 tree, and stage3 `$target` tree.
 
 Earlier we said that trivial merges are done inside
-`git-read-tree -m`.  For example, if the file did not change
+`git read-tree -m`.  For example, if the file did not change
 from `$orig` to `HEAD` nor `$target`, or if the file changed
 from `$orig` to `HEAD` and `$orig` to `$target` the same way,
 obviously the final outcome is what is in `HEAD`.  What the
@@ -4011,20 +4011,20 @@ $ mv -f hello.c~2 hello.c
 $ git update-index hello.c
 -------------------------------------------------
 
-When a path is in the "unmerged" state, running `git-update-index` for
+When a path is in the "unmerged" state, running `git update-index` for
 that path tells git to mark the path resolved.
 
 The above is the description of a git merge at the lowest level,
 to help you understand what conceptually happens under the hood.
-In practice, nobody, not even git itself, runs `git-cat-file` three times
-for this.  There is a `git-merge-index` program that extracts the
+In practice, nobody, not even git itself, runs `git cat-file` three times
+for this.  There is a `git merge-index` program that extracts the
 stages to temporary files and calls a "merge" script on it:
 
 -------------------------------------------------
 $ git merge-index git-merge-one-file hello.c
 -------------------------------------------------
 
-and that is what higher level `git-merge -s resolve` is implemented with.
+and that is what higher level `git merge -s resolve` is implemented with.
 
 [[hacking-git]]
 Hacking git
@@ -4061,7 +4061,7 @@ size> {plus} <byte\0> {plus} <binary object data>.
 
 The structured objects can further have their structure and
 connectivity to other objects verified. This is generally done with
-the `git-fsck` program, which generates a full dependency graph
+the `git fsck` program, which generates a full dependency graph
 of all objects, and verifies their internal consistency (in addition
 to just verifying their superficial consistency through the hash).
 
@@ -4120,7 +4120,7 @@ functions like `get_sha1_basic()` or the likes.
 This is just to get you into the groove for the most libified part of Git:
 the revision walker.
 
-Basically, the initial version of `git-log` was a shell script:
+Basically, the initial version of `git log` was a shell script:
 
 ----------------------------------------------------------------
 $ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
@@ -4129,20 +4129,20 @@ $ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
 
 What does this mean?
 
-`git-rev-list` is the original version of the revision walker, which
+`git rev-list` is the original version of the revision walker, which
 _always_ printed a list of revisions to stdout.  It is still functional,
 and needs to, since most new Git programs start out as scripts using
-`git-rev-list`.
+`git rev-list`.
 
-`git-rev-parse` is not as important any more; it was only used to filter out
+`git rev-parse` is not as important any more; it was only used to filter out
 options that were relevant for the different plumbing commands that were
 called by the script.
 
-Most of what `git-rev-list` did is contained in `revision.c` and
+Most of what `git rev-list` did is contained in `revision.c` and
 `revision.h`.  It wraps the options in a struct named `rev_info`, which
 controls how and what revisions are walked, and more.
 
-The original job of `git-rev-parse` is now taken by the function
+The original job of `git rev-parse` is now taken by the function
 `setup_revisions()`, which parses the revisions and the common command line
 options for the revision walker. This information is stored in the struct
 `rev_info` for later consumption. You can do your own command line option
@@ -4155,7 +4155,7 @@ just have a look at the first implementation of `cmd_log()`; call
 `git show v1.3.0{tilde}155^2{tilde}4` and scroll down to that function (note that you
 no longer need to call `setup_pager()` directly).
 
-Nowadays, `git-log` is a builtin, which means that it is _contained_ in the
+Nowadays, `git log` is a builtin, which means that it is _contained_ in the
 command `git`.  The source side of a builtin is
 
 - a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c`,
@@ -4171,7 +4171,7 @@ since they share quite a bit of code.  In that case, the commands which are
 _not_ named like the `.c` file in which they live have to be listed in
 `BUILT_INS` in the `Makefile`.
 
-`git-log` looks more complicated in C than it does in the original script,
+`git log` looks more complicated in C than it does in the original script,
 but that allows for a much greater flexibility and performance.
 
 Here again it is a good point to take a pause.
@@ -4182,9 +4182,9 @@ the organization of Git (after you know the basic concepts).
 So, think about something which you are interested in, say, "how can I
 access a blob just knowing the object name of it?".  The first step is to
 find a Git command with which you can do it.  In this example, it is either
-`git-show` or `git-cat-file`.
+`git show` or `git cat-file`.
 
-For the sake of clarity, let's stay with `git-cat-file`, because it
+For the sake of clarity, let's stay with `git cat-file`, because it
 
 - is plumbing, and
 
@@ -4198,7 +4198,7 @@ it does.
 ------------------------------------------------------------------
         git_config(git_default_config);
         if (argc != 3)
-                usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
+                usage("git cat-file [-t|-s|-e|-p|<type>] <sha1>");
         if (get_sha1(argv[2], sha1))
                 die("Not a valid object name %s", argv[2]);
 ------------------------------------------------------------------
@@ -4243,10 +4243,10 @@ To find out how the result can be used, just read on in `cmd_cat_file()`:
 -----------------------------------
 
 Sometimes, you do not know where to look for a feature.  In many such cases,
-it helps to search through the output of `git log`, and then `git-show` the
+it helps to search through the output of `git log`, and then `git show` the
 corresponding commit.
 
-Example: If you know that there was some test case for `git-bundle`, but
+Example: If you know that there was some test case for `git bundle`, but
 do not remember where it was (yes, you _could_ `git grep bundle t/`, but that
 does not illustrate the point!):
 
@@ -4530,7 +4530,7 @@ The basic requirements:
 - Whenever possible, section headings should clearly describe the task
   they explain how to do, in language that requires no more knowledge
   than necessary: for example, "importing patches into a project" rather
-  than "the git-am command"
+  than "the `git am` command"
 
 Think about how to create a clear chapter dependency graph that will
 allow people to get to important topics without necessarily reading
-- 
1.6.2.2.404.ge96f3
