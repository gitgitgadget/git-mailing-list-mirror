Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C921F513
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758613AbeD0RFY (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:24 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39078 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758565AbeD0RFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:22 -0400
Received: by mail-wm0-f41.google.com with SMTP id b21so4129428wme.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lJehS2iIy+tYzUmEOqqn5/DYtwuAvUWnt/DO3hZav0w=;
        b=ETtp4LSQZU5GoJMnIHk4V4+PiPOKrssGqURNEjofupJzaCshwfdZLu5yYv6JDD0DgL
         jr4p+v0ji3/FTl0uir1rvhUnyX8owKbOVRKeFbQZ5CRpTASgai+Krlr7j7Nt0NeONuvp
         55BIbIdVzILyw2vxKRnv3jQC9Kd1jIb30nJImoWxo6Ad05YfxyQ4X+MKduFrkOjlY8zH
         s1Yl+MhxnAUPTFq9Mrz/Ghm6P4nnbvpSUVkm9fCLS1Xl81scmP1z9fr2f8As/PGG2b3z
         gKmimSbbWIGzZQ+Rl9YE8ZfB1W+veYoZ660b+iIvwxE+r2tXd+D2GgZNkr13WUVU0fci
         Z14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lJehS2iIy+tYzUmEOqqn5/DYtwuAvUWnt/DO3hZav0w=;
        b=Z3UxCutSbDFqOJLb35STfjx9IXmW0Az6KT1AdSLoDdcFqZ0nYpZOoyvRppINoJq+nI
         n8/vTxtREdme+TSKOqnjucIf2C48dZxQNJbsspDpKH1DrEwLnwR/EloPUEbPKd8fXeCj
         2Yhu7GReLspspHdjpC0xU7wVes5hKY8PJPVykMmSSqyI5nbtnrC3iEeFXhvAD9ld1fXs
         gCBm/BAGU+B1e8Z8/yFDNHBNf40bQhdkkdbvg5zoLafat0cIps8DNrEQyWE9zrRXcYXp
         wYpwYGzZpAboe6laWLjuA/BJzzcDbH3YRC6e03Ns5IrsjQc0QL+7Ok5HoeefW3xGqHjh
         LPoQ==
X-Gm-Message-State: ALQs6tAg++2m1tETjwUshlTk6i0e+D+MlzFrb8rC2D2DfPMBLYJ+Fnd3
        oE7rFWApqwzOUzw/7yTys2NuUrBl
X-Google-Smtp-Source: AB8JxZrtpIFWhRnngl0fKmtI07g0LPkOWl8zuWZjFnFsamSPjLDJ+SDH8V4vfloD6LAfU7wDwn2+MQ==
X-Received: by 10.28.85.201 with SMTP id j192mr2204866wmb.160.1524848720007;
        Fri, 27 Apr 2018 10:05:20 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:19 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 1/6] doc: improve formatting in githooks.txt
Date:   Fri, 27 Apr 2018 19:04:35 +0200
Message-Id: <20180427170440.30418-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typeset commands and similar things with as `git foo` instead of
'git foo' or 'git-foo' and add linkgit to the commands which run
the hooks.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Reviewed-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/githooks.txt | 115 +++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f877f7b7cd..e3c283a174 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -31,7 +31,7 @@ Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
 details.
 
-'git init' may copy hooks to the new repository, depending on its
+`git init` may copy hooks to the new repository, depending on its
 configuration. See the "TEMPLATE DIRECTORY" section in
 linkgit:git-init[1] for details. When the rest of this document refers
 to "default hooks" it's talking about the default template shipped
@@ -45,9 +45,9 @@ HOOKS
 applypatch-msg
 ~~~~~~~~~~~~~~
 
-This hook is invoked by 'git am'.  It takes a single
+This hook is invoked by linkgit:git-am[1].  It takes a single
 parameter, the name of the file that holds the proposed commit
-log message.  Exiting with a non-zero status causes 'git am' to abort
+log message.  Exiting with a non-zero status causes `git am` to abort
 before applying the patch.
 
 The hook is allowed to edit the message file in place, and can
@@ -61,7 +61,7 @@ The default 'applypatch-msg' hook, when enabled, runs the
 pre-applypatch
 ~~~~~~~~~~~~~~
 
-This hook is invoked by 'git am'.  It takes no parameter, and is
+This hook is invoked by linkgit:git-am[1].  It takes no parameter, and is
 invoked after the patch is applied, but before a commit is made.
 
 If it exits with non-zero status, then the working tree will not be
@@ -76,33 +76,33 @@ The default 'pre-applypatch' hook, when enabled, runs the
 post-applypatch
 ~~~~~~~~~~~~~~~
 
-This hook is invoked by 'git am'.  It takes no parameter,
+This hook is invoked by linkgit:git-am[1].  It takes no parameter,
 and is invoked after the patch is applied and a commit is made.
 
 This hook is meant primarily for notification, and cannot affect
-the outcome of 'git am'.
+the outcome of `git am`.
 
 pre-commit
 ~~~~~~~~~~
 
-This hook is invoked by 'git commit', and can be bypassed
+This hook is invoked by linkgit:git-commit[1], and can be bypassed
 with the `--no-verify` option.  It takes no parameters, and is
 invoked before obtaining the proposed commit log message and
 making a commit.  Exiting with a non-zero status from this script
-causes the 'git commit' command to abort before creating a commit.
+causes the `git commit` command to abort before creating a commit.
 
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
 such a line is found.
 
-All the 'git commit' hooks are invoked with the environment
+All the `git commit` hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
-This hook is invoked by 'git commit' right after preparing the
+This hook is invoked by linkgit:git-commit[1] right after preparing the
 default log message, and before the editor is started.
 
 It takes one to three parameters.  The first is the name of the file
@@ -114,7 +114,7 @@ commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
 a commit SHA-1 (if a `-c`, `-C` or `--amend` option was given).
 
-If the exit status is non-zero, 'git commit' will abort.
+If the exit status is non-zero, `git commit` will abort.
 
 The purpose of the hook is to edit the message file in place, and
 it is not suppressed by the `--no-verify` option.  A non-zero exit
@@ -127,7 +127,7 @@ help message found in the commented portion of the commit template.
 commit-msg
 ~~~~~~~~~~
 
-This hook is invoked by 'git commit' and 'git merge', and can be
+This hook is invoked by linkgit:git-commit[1] and linkgit:git-merge[1], and can be
 bypassed with the `--no-verify` option.  It takes a single parameter,
 the name of the file that holds the proposed commit log message.
 Exiting with a non-zero status causes the command to abort.
@@ -143,16 +143,16 @@ The default 'commit-msg' hook, when enabled, detects duplicate
 post-commit
 ~~~~~~~~~~~
 
-This hook is invoked by 'git commit'. It takes no parameters, and is
+This hook is invoked by linkgit:git-commit[1]. It takes no parameters, and is
 invoked after a commit is made.
 
 This hook is meant primarily for notification, and cannot affect
-the outcome of 'git commit'.
+the outcome of `git commit`.
 
 pre-rebase
 ~~~~~~~~~~
 
-This hook is called by 'git rebase' and can be used to prevent a
+This hook is called by linkgit:git-rebase[1] and can be used to prevent a
 branch from getting rebased.  The hook may be called with one or
 two parameters.  The first parameter is the upstream from which
 the series was forked.  The second parameter is the branch being
@@ -161,17 +161,17 @@ rebased, and is not set when rebasing the current branch.
 post-checkout
 ~~~~~~~~~~~~~
 
-This hook is invoked when a 'git checkout' is run after having updated the
+This hook is invoked when a linkgit:git-checkout[1] is run after having updated the
 worktree.  The hook is given three parameters: the ref of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of 'git checkout'.
+This hook cannot affect the outcome of `git checkout`.
 
-It is also run after 'git clone', unless the --no-checkout (-n) option is
+It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
 used. The first parameter given to the hook is the null-ref, the second the
-ref of the new HEAD and the flag is always 1. Likewise for 'git worktree add'
-unless --no-checkout is used.
+ref of the new HEAD and the flag is always 1. Likewise for `git worktree add`
+unless `--no-checkout` is used.
 
 This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
@@ -180,10 +180,10 @@ properties.
 post-merge
 ~~~~~~~~~~
 
-This hook is invoked by 'git merge', which happens when a 'git pull'
+This hook is invoked by linkgit:git-merge[1], which happens when a `git pull`
 is done on a local repository.  The hook takes a single parameter, a status
 flag specifying whether or not the merge being done was a squash merge.
-This hook cannot affect the outcome of 'git merge' and is not executed,
+This hook cannot affect the outcome of `git merge` and is not executed,
 if the merge failed due to conflicts.
 
 This hook can be used in conjunction with a corresponding pre-commit hook to
@@ -194,10 +194,10 @@ for an example of how to do this.
 pre-push
 ~~~~~~~~
 
-This hook is called by 'git push' and can be used to prevent a push from taking
-place.  The hook is called with two parameters which provide the name and
-location of the destination remote, if a named remote is not being used both
-values will be the same.
+This hook is called by linkgit:git-push[1] and can be used to prevent
+a push from taking place.  The hook is called with two parameters
+which provide the name and location of the destination remote, if a
+named remote is not being used both values will be the same.
 
 Information about what is to be pushed is provided on the hook's standard
 input with lines of the form:
@@ -216,7 +216,7 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
 than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
 supplied as it was originally given.
 
-If this hook exits with a non-zero status, 'git push' will abort without
+If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
@@ -224,8 +224,8 @@ to the user by writing to standard error.
 pre-receive
 ~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' when it reacts to
-'git push' and updates reference(s) in its repository.
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
 Just before starting to update refs on the remote repository, the
 pre-receive hook is invoked.  Its exit status determines the success
 or failure of the update.
@@ -246,7 +246,7 @@ updated. If the hook exits with zero, updating of individual refs can
 still be prevented by the <<update,'update'>> hook.
 
 Both standard output and standard error output are forwarded to
-'git send-pack' on the other end, so you can simply `echo` messages
+`git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
 The number of push options given on the command line of
@@ -265,8 +265,8 @@ linkgit:git-receive-pack[1] for some caveats.
 update
 ~~~~~~
 
-This hook is invoked by 'git-receive-pack' when it reacts to
-'git push' and updates reference(s) in its repository.
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
 Just before updating the ref on the remote repository, the update hook
 is invoked.  Its exit status determines the success or failure of
 the ref update.
@@ -279,7 +279,7 @@ three parameters:
  - and the new object name to be stored in the ref.
 
 A zero exit from the update hook allows the ref to be updated.
-Exiting with a non-zero status prevents 'git-receive-pack'
+Exiting with a non-zero status prevents `git receive-pack`
 from updating that ref.
 
 This hook can be used to prevent 'forced' update on certain refs by
@@ -299,7 +299,7 @@ membership. See linkgit:git-shell[1] for how you might use the login
 shell to restrict the user's access to only git commands.
 
 Both standard output and standard error output are forwarded to
-'git send-pack' on the other end, so you can simply `echo` messages
+`git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
 The default 'update' hook, when enabled--and with
@@ -310,8 +310,8 @@ unannotated tags to be pushed.
 post-receive
 ~~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' when it reacts to
-'git push' and updates reference(s) in its repository.
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
 It executes on the remote repository once after all the refs have
 been updated.
 
@@ -320,7 +320,7 @@ arguments, but gets the same information as the
 <<pre-receive,'pre-receive'>>
 hook does on its standard input.
 
-This hook does not affect the outcome of 'git-receive-pack', as it
+This hook does not affect the outcome of `git receive-pack`, as it
 is called after the real work is done.
 
 This supersedes the <<post-update,'post-update'>> hook in that it gets
@@ -328,7 +328,7 @@ both old and new values of all the refs in addition to their
 names.
 
 Both standard output and standard error output are forwarded to
-'git send-pack' on the other end, so you can simply `echo` messages
+`git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
 The default 'post-receive' hook is empty, but there is
@@ -349,8 +349,8 @@ will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 post-update
 ~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' when it reacts to
-'git push' and updates reference(s) in its repository.
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository.
 It executes on the remote repository once after all the refs have
 been updated.
 
@@ -358,7 +358,7 @@ It takes a variable number of parameters, each of which is the
 name of ref that was actually updated.
 
 This hook is meant primarily for notification, and cannot affect
-the outcome of 'git-receive-pack'.
+the outcome of `git receive-pack`.
 
 The 'post-update' hook can tell what are the heads that were pushed,
 but it does not know what their original and updated values are,
@@ -368,20 +368,20 @@ updated values of the refs. You might consider it instead if you need
 them.
 
 When enabled, the default 'post-update' hook runs
-'git update-server-info' to keep the information used by dumb
+`git update-server-info` to keep the information used by dumb
 transports (e.g., HTTP) up to date.  If you are publishing
 a Git repository that is accessible via HTTP, you should
 probably enable this hook.
 
 Both standard output and standard error output are forwarded to
-'git send-pack' on the other end, so you can simply `echo` messages
+`git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' when it reacts to
-'git push' and updates reference(s) in its repository, and when
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository, and when
 the push tries to update the branch that is currently checked out
 and the `receive.denyCurrentBranch` configuration variable is set to
 `updateInstead`.  Such a push by default is refused if the working
@@ -400,8 +400,8 @@ when the tip of the current branch is updated to the new commit, and
 exit with a zero status.
 
 For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
-in order to emulate 'git fetch' that is run in the reverse direction
-with `git push`, as the two-tree form of `read-tree -u -m` is
+in order to emulate `git fetch` that is run in the reverse direction
+with `git push`, as the two-tree form of `git read-tree -u -m` is
 essentially the same as `git checkout` that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
@@ -410,15 +410,16 @@ with the difference between the branches.
 pre-auto-gc
 ~~~~~~~~~~~
 
-This hook is invoked by 'git gc --auto'. It takes no parameter, and
-exiting with non-zero status from this script causes the 'git gc --auto'
-to abort.
+This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
+takes no parameter, and exiting with non-zero status from this script
+causes the `git gc --auto` to abort.
 
 post-rewrite
 ~~~~~~~~~~~~
 
-This hook is invoked by commands that rewrite commits (`git commit
---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
+This hook is invoked by commands that rewrite commits
+(linkgit:git-commit[1] when called with `--amend` and
+linkgit:git-rebase[1]; currently `git filter-branch` does 'not' call
 it!).  Its first argument denotes the command it was invoked by:
 currently one of `amend` or `rebase`.  Further command-dependent
 arguments may be passed in the future.
@@ -450,16 +451,16 @@ processed by rebase.
 sendemail-validate
 ~~~~~~~~~~~~~~~~~~
 
-This hook is invoked by 'git send-email'.  It takes a single parameter,
+This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
 the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes 'git send-email' to abort before sending any
+non-zero status causes `git send-email` to abort before sending any
 e-mails.
 
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
-This hook is invoked when the configuration option core.fsmonitor is
-set to .git/hooks/fsmonitor-watchman.  It takes two arguments, a version
+This hook is invoked when the configuration option `core.fsmonitor` is
+set to `.git/hooks/fsmonitor-watchman`.  It takes two arguments, a version
 (currently 1) and the time in elapsed nanoseconds since midnight,
 January 1, 1970.
 
@@ -478,7 +479,7 @@ directories are checked for untracked files based on the path names
 given.
 
 An optimized way to tell git "all files have changed" is to return
-the filename '/'.
+the filename `/`.
 
 The exit status determines whether git will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
-- 
2.16.2

