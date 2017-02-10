Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DA21FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdBJVaG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:30:06 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34128 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdBJVaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:30:03 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so2194518pfb.1;
        Fri, 10 Feb 2017 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aPBypIOVK8KVCn35DXipeLI2v9/DGDLmKxhHYpkoWDg=;
        b=ViQo7lfyVXY7PS9oRnQ+cqXzRQ3x+VvdC6WFoHK2rtcBkHOPIjuhR7RaqjlOzdt/Sy
         JcJP2E9/pz/d+zlr9iCH2RJPPo8MTb2SlA/MTWCfHvpRiYRAcH1RqXeoLIlAxx8WALVt
         Nw9qdCJTrAH3JUh537b/c1Hj1cGNvkXLjtGmhBy6sRH5PXHwUgPYsmyiqHvPYWPPHHZn
         iaTb7nEPwgKP9uh7YJPbggy+q0i9I+tEzAozmVAyPsiTQLWj+7bcxmlkJjKRYmFeUiRo
         feCQdhk9Ix8VIxw7O33PoXqq9NUK+g0GoSSYpSk3R4Z1gTQHA+sJrjKcTPo6Zf2tk99D
         K/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aPBypIOVK8KVCn35DXipeLI2v9/DGDLmKxhHYpkoWDg=;
        b=kP9ogIxh//nooFVc97GnwGB9vpn4u8KAJj8tx12jQ9CFNlDgCWK25niNUjaqaiZPZn
         exasFAJYu64MI4tveb5/EvjGtA8m75rAREa0rhPFqQdJzSlwYr8BPNpL2ZSc1LtmziwI
         RDWUuSBTw1FpCCSDZodIMHkOlFuL7JqbuBrEtNOWznL/LSN2c1OaUPA1XWb89ZtCAr5p
         Xj2Ci5maBpMbFjfKH3o5+NwUyROL9ML/l6sn1zLLJa56UJNkRtkFOvMima+P0+DpDgOu
         Cs/K3JZH8Bw2UDQvaL3+3soEvPJie9kMKxbpkMZ8TERsu1a5XC2BA1ff12wrH0Soxgru
         4e/A==
X-Gm-Message-State: AMke39kcnytVmtp0xR/3lyb/whS9PJWOLAdn1Dm8w2s4Kp8gr6KBjsZoZn56uVrmyjrVYQ==
X-Received: by 10.84.241.10 with SMTP id a10mr14170922pll.47.1486762201435;
        Fri, 10 Feb 2017 13:30:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id m6sm1064384pfg.126.2017.02.10.13.29.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 13:30:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.12.0-rc1
Date:   Fri, 10 Feb 2017 13:29:59 -0800
Message-ID: <xmqqbmu9ka3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.12.0-rc1 is now available for testing
at the usual places.  It is comprised of 455 non-merge commits
since v2.11.0, contributed by 65 people, 20 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.12.0-rc1' tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.11.0 are as follows.
Welcome to the Git development community!

  Alan Davies, Andreas Krey, Cornelius Weig, Denton Liu, George
  Vanburgh, Igor Kushnir, Jack Bates, Kristoffer Haugsbakk, Kyle
  Meyer, Luis Ressel, Lukas Puehringer, Markus Hitter, Peter Law,
  Rasmus Villemoes, Rogier Goossens, Stefan Dotterweich, Steven
  Penny, Vinicius Kursancew, Vladimir Panteleev, and Wolfram Sang.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  마누엘, Alex Henrie, Beat Bolli, Brandon Williams, brian
  m. carlson, Chris Packham, Christian Couder, David Aguilar, David
  Turner, Dennis Kaarsemaker, Dimitriy Ryazantcev, Elia Pinto,
  Eric Wong, Heiko Voigt, Jacob Keller, Jeff Hostetler, Jeff King,
  Johannes Schindelin, Johannes Sixt, Jonathan Tan, Junio C Hamano,
  Kyle J. McKay, Lars Schneider, Linus Torvalds, Luke Diamand, Matt
  McCutchen, Max Kirillov, Mike Hommey, Nguyễn Thái Ngọc Duy,
  Patrick Steinhardt, Paul Mackerras, Philip Oakley, Pranit Bauva,
  Ramsay Jones, René Scharfe, Richard Hansen, Santiago Torres,
  Satoshi Yasushima, Stefan Beller, Stephan Beyer, SZEDER Gábor,
  Torsten Bögershausen, Vasco Almeida, Vegard Nossum, and Vitaly
  "_Vi" Shukela.

----------------------------------------------------------------

Git 2.12 Release Notes (draft)
==============================

Backward compatibility notes.

 * Use of an empty string that is used for 'everything matches' is
   still warned and Git asks users to use a more explicit '.' for that
   instead.  The hope is that existing users will not mind this
   change, and eventually the warning can be turned into a hard error,
   upgrading the deprecation into removal of this (mis)feature.  That
   is not scheduled to happen in the upcoming release (yet).

 * The historical argument order "git merge <msg> HEAD <commit>..."
   has been deprecated for quite some time, and will be removed in a
   future release.

 * An ancient script "git relink" has been removed.


Updates since v2.11
-------------------

UI, Workflows & Features

 * Various updates to "git p4".

 * "git p4" didn't interact with the internal of .git directory
   correctly in the modern "git-worktree"-enabled world.

 * "git branch --list" and friends learned "--ignore-case" option to
   optionally sort branches and tags case insensitively.

 * In addition to %(subject), %(body), "log --pretty=format:..."
   learned a new placeholder %(trailers).

 * "git rebase" learned "--quit" option, which allows a user to
   remove the metadata left by an earlier "git rebase" that was
   manually aborted without using "git rebase --abort".

 * "git clone --reference $there --recurse-submodules $super" has been
   taught to guess repositories usable as references for submodules of
   $super that are embedded in $there while making a clone of the
   superproject borrow objects from $there; extend the mechanism to
   also allow submodules of these submodules to borrow repositories
   embedded in these clones of the submodules embedded in the clone of
   the superproject.

 * Porcelain scripts written in Perl are getting internationalized.

 * "git merge --continue" has been added as a synonym to "git commit"
   to conclude a merge that has stopped due to conflicts.

 * Finer-grained control of what protocols are allowed for transports
   during clone/fetch/push have been enabled via a new configuration
   mechanism.

 * "git shortlog" learned "--committer" option to group commits by
   committer, instead of author.

 * GitLFS integration with "git p4" has been updated.

 * The isatty() emulation for Windows has been updated to eradicate
   the previous hack that depended on internals of (older) MSVC
   runtime.

 * Some platforms no longer understand "latin-1" that is still seen in
   the wild in e-mail headers; replace them with "iso-8859-1" that is
   more widely known when conversion fails from/to it.

 * "git grep" has been taught to optionally recurse into submodules.

 * "git rm" used to refuse to remove a submodule when it has its own
   git repository embedded in its working tree.  It learned to move
   the repository away to $GIT_DIR/modules/ of the superproject
   instead, and allow the submodule to be deleted (as long as there
   will be no loss of local modifications, that is).

 * A recent updates to "git p4" was not usable for older p4 but it
   could be made to work with minimum changes.  Do so.

 * "git diff" learned diff.interHunkContext configuration variable
   that gives the default value for its --inter-hunk-context option.

 * The prereleaseSuffix feature of version comparison that is used in
   "git tag -l" did not correctly when two or more prereleases for the
   same release were present (e.g. when 2.0, 2.0-beta1, and 2.0-beta2
   are there and the code needs to compare 2.0-beta1 and 2.0-beta2).

 * "git submodule push" learned "--recurse-submodules=only option to
   push submodules out without pushing the top-level superproject.

 * "git tag" and "git verify-tag" learned to put GPG verification
   status in their "--format=<placeholders>" output format.

 * An ancient repository conversion tool left in contrib/ has been
   removed.

 * "git show-ref HEAD" used with "--verify" because the user is not
   interested in seeing refs/remotes/origin/HEAD, and used with
   "--head" because the user does not want HEAD to be filtered out,
   i.e. "git show-ref --head --verify HEAD", did not work as expected.

 * "git submodule add" used to be confused and refused to add a
   locally created repository; users can now use "--force" option
   to add them.
   (merge 619acfc78c sb/submodule-add-force later to maint).

 * Some people feel the default set of colors used by "git log --graph"
   rather limiting.  A mechanism to customize the set of colors has
   been introduced.

 * "git read-tree" and its underlying unpack_trees() machinery learned
   to report problematic paths prefixed with the --super-prefix option.

 * When a submodule "A", which has another submodule "B" nested within
   it, is "absorbed" into the top-level superproject, the inner
   submodule "B" used to be left in a strange state.  The logic to
   adjust the .git pointers in these submodules has been corrected.

 * The user can specify a custom update method that is run when
   "submodule update" updates an already checked out submodule.  This
   was ignored when checking the submodule out for the first time and
   we instead always just checked out the commit that is bound to the
   path in the superproject's index.

 * The command line completion (in contrib/) learned that
   "git diff --submodule=" can take "diff" as a recently added option.

 * The "core.logAllRefUpdates" that used to be boolean has been
   enhanced to take 'always' as well, to record ref updates to refs
   other than the ones that are expected to be updated (i.e. branches,
   remote-tracking branches and notes).


Performance, Internal Implementation, Development Support etc.

 * Commands that operate on a log message and add lines to the trailer
   blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
   "commit -s", have been taught to use the logic of and share the
   code with "git interpret-trailer".

 * The default Travis-CI configuration specifies newer P4 and GitLFS.

 * The "fast hash" that had disastrous performance issues in some
   corner cases has been retired from the internal diff.

 * The character width table has been updated to match Unicode 9.0

 * Update the procedure to generate "tags" for developer support.

 * The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
   opens has been simplified.

 * "git diff" and its family had two experimental heuristics to shift
   the contents of a hunk to make the patch easier to read.  One of
   them turns out to be better than the other, so leave only the
   "--indent-heuristic" option and remove the other one.

 * A new submodule helper "git submodule embedgitdirs" to make it
   easier to move embedded .git/ directory for submodules in a
   superproject to .git/modules/ (and point the latter with the former
   that is turned into a "gitdir:" file) has been added.

 * "git push \\server\share\dir" has recently regressed and then
   fixed.  A test has retroactively been added for this breakage.

 * Build updates for Cygwin.

 * The implementation of "real_path()" was to go there with chdir(2)
   and call getcwd(3), but this obviously wouldn't be usable in a
   threaded environment.  Rewrite it to manually resolve relative
   paths including symbolic links in path components.

 * Adjust documentation to help AsciiDoctor render better while not
   breaking the rendering done by AsciiDoc.

 * The sequencer machinery has been further enhanced so that a later
   set of patches can start using it to reimplement "rebase -i".

 * Update the definition of the MacOSX test environment used by
   TravisCI.

 * Rewrite a scripted porcelain "git difftool" in C.

 * "make -C t failed" will now run only the tests that failed in the
   previous run.  This is usable only when prove is not use, and gives
   a useless error message when run after "make clean", but otherwise
   is serviceable.

 * "uchar [40]" to "struct object_id" conversion continues.


Also contains various documentation updates and code clean-ups.

Fixes since v2.10
-----------------

Unless otherwise noted, all the fixes since v2.9 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * We often decide if a session is interactive by checking if the
   standard I/O streams are connected to a TTY, but isatty() that
   comes with Windows incorrectly returned true if it is used on NUL
   (i.e. an equivalent to /dev/null).  This has been fixed.

 * "git svn" did not work well with path components that are "0", and
   some configuration variable it uses were not documented.

 * "git rev-parse --symbolic" failed with a more recent notation like
   "HEAD^-1" and "HEAD^!".

 * An empty directory in a working tree that can simply be nuked used
   to interfere while merging or cherry-picking a change to create a
   submodule directory there, which has been fixed..

 * The code in "git push" to compute if any commit being pushed in the
   superproject binds a commit in a submodule that hasn't been pushed
   out was overly inefficient, making it unusable even for a small
   project that does not have any submodule but have a reasonable
   number of refs.

 * "git push --dry-run --recurse-submodule=on-demand" wasn't
   "--dry-run" in the submodules.

 * The output from "git worktree list" was made in readdir() order,
   and was unstable.

 * mergetool.<tool>.trustExitCode configuration variable did not apply
   to built-in tools, but now it does.

 * "git p4" LFS support was broken when LFS stores an empty blob.

 * A corner case in merge-recursive regression that crept in
   during 2.10 development cycle has been fixed.

 * Transport with dumb http can be fooled into following foreign URLs
   that the end user does not intend to, especially with the server
   side redirects and http-alternates mechanism, which can lead to
   security issues.  Tighten the redirection and make it more obvious
   to the end user when it happens.

 * Update the error messages from the dumb-http client when it fails
   to obtain loose objects; we used to give sensible error message
   only upon 404 but we now forbid unexpected redirects that needs to
   be reported with something sensible.

 * When diff.renames configuration is on (and with Git 2.9 and later,
   it is enabled by default, which made it worse), "git stash"
   misbehaved if a file is removed and another file with a very
   similar content is added.

 * "git diff --no-index" did not take "--no-abbrev" option.

 * "git difftool --dir-diff" had a minor regression when started from
   a subdirectory, which has been fixed.

 * "git commit --allow-empty --only" (no pathspec) with dirty index
   ought to be an acceptable way to create a new commit that does not
   change any paths, but it was forbidden, perhaps because nobody
   needed it so far.

 * Git 2.11 had a minor regression in "merge --ff-only" that competed
   with another process that simultanously attempted to update the
   index. We used to explain what went wrong with an error message,
   but the new code silently failed.  The error message has been
   resurrected.

 * A pathname that begins with "//" or "\\" on Windows is special but
   path normalization logic was unaware of it.

 * "git pull --rebase", when there is no new commits on our side since
   we forked from the upstream, should be able to fast-forward without
   invoking "git rebase", but it didn't.

 * The way to specify hotkeys to "xxdiff" that is used by "git
   mergetool" has been modernized to match recent versions of xxdiff.

 * Unlike "git am --abort", "git cherry-pick --abort" moved HEAD back
   to where cherry-pick started while picking multiple changes, when
   the cherry-pick stopped to ask for help from the user, and the user
   did "git reset --hard" to a different commit in order to re-attempt
   the operation.

 * Code cleanup in shallow boundary computation.

 * A recent update to receive-pack to make it easier to drop garbage
   objects made it clear that GIT_ALTERNATE_OBJECT_DIRECTORIES cannot
   have a pathname with a colon in it (no surprise!), and this in turn
   made it impossible to push into a repository at such a path.  This
   has been fixed by introducing a quoting mechanism used when
   appending such a path to the colon-separated list.

 * The function usage_msg_opt() has been updated to say "fatal:"
   before the custom message programs give, when they want to die
   with a message about wrong command line options followed by the
   standard usage string.

 * "git index-pack --stdin" needs an access to an existing repository,
   but "git index-pack file.pack" to generate an .idx file that
   corresponds to a packfile does not.

 * Fix for NDEBUG builds.

 * A lazy "git push" without refspec did not internally use a fully
   specified refspec to perform 'current', 'simple', or 'upstream'
   push, causing unnecessary "ambiguous ref" errors.

 * "git p4" misbehaved when swapping a directory and a symbolic link.

 * Even though an fix was attempted in Git 2.9.3 days, but running
   "git difftool --dir-diff" from a subdirectory never worked. This
   has been fixed.

 * "git p4" that tracks multile p4 paths imported a single changelist
   that touches files in these multiple paths as one commit, followed
   by many empty commits.  This has been fixed.

 * A potential but unlikely buffer overflow in Windows port has been
   fixed.

 * When the http server gives an incomplete response to a smart-http
   rpc call, it could lead to client waiting for a full response that
   will never come.  Teach the client side to notice this condition
   and abort the transfer.

 * Compression setting for producing packfiles were spread across
   three codepaths, one of which did not honor any configuration.
   Unify these so that all of them honor core.compression and
   pack.compression variables the same way.

 * "git fast-import" sometimes mishandled while rebalancing notes
   tree, which has been fixed.

 * Recent update to the default abbreviation length that auto-scales
   lacked documentation update, which has been corrected.

 * Leakage of lockfiles in the config subsystem has been fixed.

 * It is natural that "git gc --auto" may not attempt to pack
   everything into a single pack, and there is no point in warning
   when the user has configured the system to use the pack bitmap,
   leading to disabling further "gc".

 * "git archive" did not read the standard configuration files, and
   failed to notice a file that is marked as binary via the userdiff
   driver configuration.

 * "git blame --porcelain" misidentified the "previous" <commit, path>
   pair (aka "source") when contents came from two or more files.

 * "git rebase -i" with a recent update started showing an incorrect
   count when squashing more than 10 commits.

 * "git <cmd> @{push}" on a detached HEAD used to segfault; it has
   been corrected to error out with a message.

 * Running "git add a/b" when "a" is a submodule correctly errored
   out, but without a meaningful error message.
   (merge 2d81c48fa7 sb/pathspec-errors later to maint).

 * Typing ^C to pager, which usually does not kill it, killed Git and
   took the pager down as a collateral damage in certain process-tree
   structure.  This has been fixed.

 * "git mergetool" without any pathspec on the command line that is
   run from a subdirectory became no-op in Git v2.11 by mistake, which
   has been fixed.

 * Retire long unused/unmaintained gitview from the contrib/ area.
   (merge 3120925c25 sb/remove-gitview later to maint).

 * Tighten a test to avoid mistaking an extended ERE regexp engine as
   a PRE regexp engine.

 * An error message with an ASCII control character like '\r' in it
   can alter the message to hide its early part, which is problematic
   when a remote side gives such an error message that the local side
   will relay with a "remote: " prefix.
   (merge f290089879 jk/vreport-sanitize later to maint).

 * "git fsck" inspects loose objects more carefully now.
   (merge cce044df7f jk/loose-object-fsck later to maint).

 * A crashing bug introduced in v2.11 timeframe has been found (it is
   triggerable only in fast-import) and fixed.
   (merge abd5a00268 jk/clear-delta-base-cache-fix later to maint).

 * With an anticipatory tweak for remotes defined in ~/.gitconfig
   (e.g. "remote.origin.prune" set to true, even though there may or
   may not actually be "origin" remote defined in a particular Git
   repository), "git remote rename" and other commands misinterpreted
   and behaved as if such a non-existing remote actually existed.
   (merge e459b073fb js/remote-rename-with-half-configured-remote later to maint).

 * A few codepaths had to rely on a global variable when sorting
   elements of an array because sort(3) API does not allow extra data
   to be passed to the comparison function.  Use qsort_s() when
   natively available, and a fallback implementation of it when not,
   to eliminate the need, which is a prerequisite for making the
   codepath reentrant.

 * "git fsck --connectivity-check" was not working at all.
   (merge a2b22854bd jk/fsck-connectivity-check-fix later to maint).

 * After starting "git rebase -i", which first opens the user's editor
   to edit the series of patches to apply, but before saving the
   contents of that file, "git status" failed to show the current
   state (i.e. you are in an interactive rebase session, but you have
   applied no steps yet) correctly.
   (merge df9ded4984 js/status-pre-rebase-i later to maint).

 * Test tweak for FreeBSD where /usr/bin/unzip is unsuitable to run
   our tests but /usr/local/bin/unzip is usable.
   (merge d98b2c5fce js/unzip-in-usr-bin-workaround later to maint).

 * "git p4" did not work well with multiple git-p4.mapUser entries on
   Windows.
   (merge c3c2b05776 gv/mingw-p4-mapuser later to maint).

 * "git help" enumerates executable files in $PATH; the implementation
   of "is this file executable?" on Windows has been optimized.
   (merge c755015f79 hv/mingw-help-is-executable later to maint).

 * Test tweaks for those who have default ACL in their git source tree
   that interfere with the umask test.
   (merge d549d21307 mm/reset-facl-before-umask-test later to maint).

 * Names of the various hook scripts must be spelled exactly, but on
   Windows, an .exe binary must be named with .exe suffix; notice
   $GIT_DIR/hooks/<hookname>.exe as a valid <hookname> hook.
   (merge 235be51fbe js/mingw-hooks-with-exe-suffix later to maint).

 * Asciidoctor, an alternative reimplementation of AsciiDoc, still
   needs some changes to work with documents meant to be formatted
   with AsciiDoc.  "make USE_ASCIIDOCTOR=YesPlease" to use it out of
   the box to document our pages is getting closer to reality.

 * Correct command line completion (in contrib/) on "git svn"
   (merge 2cbad17642 ew/complete-svn-authorship-options later to maint).

 * Incorrect usage help message for "git worktree prune" has been fixed.
   (merge 2488dcab22 ps/worktree-prune-help-fix later to maint).

 * Adjust a perf test to new world order where commands that do
   require a repository are really strict about having a repository.
   (merge c86000c1a7 rs/p5302-create-repositories-before-tests later to maint).

 * "git log --graph" did not work well with "--name-only", even though
   other forms of "diff" output were handled correctly.
   (merge f5022b5fed jk/log-graph-name-only later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge f2627d9b19 sb/submodule-config-cleanup later to maint).
   (merge 384f1a167b sb/unpack-trees-cleanup later to maint).
   (merge 874444b704 rh/diff-orderfile-doc later to maint).
   (merge eafd5d9483 cw/doc-sign-off later to maint).
   (merge 0aaad415bc rs/absolute-pathdup later to maint).
   (merge 4432dd6b5b rs/receive-pack-cleanup later to maint).
   (merge 540a398e9c sg/mailmap-self later to maint).
   (merge 209df269a6 nd/rev-list-all-includes-HEAD-doc later to maint).

----------------------------------------------------------------

Changes since v2.11.0 are as follows:

Alan Davies (1):
      mingw: fix colourization on Cygwin pseudo terminals

Alex Henrie (3):
      bisect: improve English grammar of not-ancestors message
      receive-pack: improve English grammar of denyCurrentBranch message
      clone,fetch: explain the shallow-clone option a little more clearly

Andreas Krey (2):
      commit: make --only --allow-empty work without paths
      commit: remove 'Clever' message for --only --amend

Beat Bolli (6):
      update_unicode.sh: move it into contrib/update-unicode
      update_unicode.sh: remove an unnecessary subshell level
      update_unicode.sh: pin the uniset repo to a known good commit
      update_unicode.sh: automatically download newer definition files
      update_unicode.sh: remove the plane filter
      unicode_width.h: update the width tables to Unicode 9.0

Brandon Williams (40):
      push: --dry-run updates submodules when --recurse-submodules=on-demand
      push: fix --dry-run to not push submodules
      real_path: resolve symlinks by hand
      real_path: convert real_path_internal to strbuf_realpath
      real_path: create real_pathdup
      real_path: have callers use real_pathdup and strbuf_realpath
      lib-proto-disable: variable name fix
      http: always warn if libcurl version is too old
      transport: add protocol policy config option
      http: create function to get curl allowed protocols
      transport: add from_user parameter to is_transport_allowed
      transport: reformat flag #defines to be more readable
      submodules: add RECURSE_SUBMODULES_ONLY value
      push: add option to push only submodules
      submodules: add helper to determine if a submodule is populated
      submodules: add helper to determine if a submodule is initialized
      submodules: load gitmodules file from commit sha1
      grep: add submodules as a grep source type
      grep: optionally recurse into submodules
      grep: enable recurse-submodules to work on <tree> objects
      grep: search history of moved submodules
      mv: remove use of deprecated 'get_pathspec()'
      dir: remove struct path_simplify
      dir: convert fill_directory to use the pathspec struct interface
      ls-tree: convert show_recursive to use the pathspec struct interface
      pathspec: remove the deprecated get_pathspec function
      pathspec: copy and free owned memory
      pathspec: remove unused variable from unsupported_magic
      pathspec: always show mnemonic and name in unsupported_magic
      pathspec: simpler logic to prefix original pathspec elements
      pathspec: factor global magic into its own function
      pathspec: create parse_short_magic function
      pathspec: create parse_long_magic function
      pathspec: create parse_element_magic helper
      pathspec: create strip submodule slash helpers
      pathspec: small readability changes
      pathspec: rename prefix_pathspec to init_pathspec_item
      real_path: prevent redefinition of MAXSYMLINKS
      real_path: set errno when max number of symlinks is exceeded
      index: improve constness for reading blob data

Chris Packham (3):
      merge: add '--continue' option as a synonym for 'git commit'
      completion: add --continue option for merge
      merge: ensure '--abort' option takes no arguments

Christian Couder (1):
      Documentation/bisect: improve on (bad|new) and (good|bad)

Cornelius Weig (7):
      doc: clarify distinction between sign-off and pgp-signing
      config: add markup to core.logAllRefUpdates doc
      refs: add option core.logAllRefUpdates = always
      update-ref: add test cases for bare repository
      doc: add doc for git-push --recurse-submodules=only
      completion: add completion for --recurse-submodules=only
      doc: add note about ignoring '--no-create-reflog'

David Aguilar (12):
      mergetool: honor mergetool.$tool.trustExitCode for built-in tools
      mergetools/vimdiff: trust Vim's exit code
      difftool: fix dir-diff index creation when in a subdirectory
      difftool: fix dir-diff index creation when in a subdirectory
      difftool: sanitize $workdir as early as possible
      difftool: chdir as early as possible
      difftool: rename variables for consistency
      mergetools: fix xxdiff hotkeys
      gitk: Remove translated message from comments
      difftool: fix bug when printing usage
      t7800: simplify basic usage test
      t7800: replace "wc -l" with test_line_count

David Turner (5):
      submodules: allow empty working-tree dirs in merge/cherry-pick
      remote-curl: don't hang when a server dies before any output
      upload-pack: optionally allow fetching any sha1
      auto gc: don't write bitmaps for incremental repacks
      repack: die on incremental + write-bitmap-index

Dennis Kaarsemaker (1):
      push: test pushing ambiguously named branches

Denton Liu (1):
      Document the --no-gui option in difftool

Dimitriy Ryazantcev (1):
      gitk: ru.po: Update Russian translation

Elia Pinto (2):
      builtin/commit.c: remove the PATH_MAX limitation via dynamic allocation
      builtin/commit.c: switch to strbuf, instead of snprintf()

Eric Wong (3):
      git-svn: allow "0" in SVN path components
      git-svn: document useLogAuthor and addAuthorFrom config keys
      completion: fix git svn authorship switches

George Vanburgh (2):
      git-p4: fix multi-path changelist empty commits
      git-p4: fix git-p4.mapUser on Windows

Heiko Voigt (5):
      serialize collection of changed submodules
      serialize collection of refs that contain submodule changes
      batch check whether submodule needs pushing into one call
      submodule_needs_pushing(): explain the behaviour when we cannot answer
      help: improve is_executable() on Windows

Igor Kushnir (1):
      git-p4: do not pass '-r 0' to p4 commands

Jack Bates (1):
      diff: handle --no-abbrev in no-index case

Jacob Keller (3):
      pretty: add %(trailers) format for displaying trailers of a commit message
      ref-filter: add support to display trailers as part of contents
      reset: add an example of how to split a commit into two

Jeff Hostetler (1):
      mingw: replace isatty() hack

Jeff King (58):
      rev-parse: fix parent shorthands with --symbolic
      t7610: clean up foo.XXXXXX tmpdir
      http: simplify update_url_from_redirect
      http: always update the base URL for redirects
      remote-curl: rename shadowed options variable
      http: make redirects more obvious
      http: treat http-alternates like redirects
      http-walker: complain about non-404 loose object errors
      xdiff: drop XDL_FAST_HASH
      stash: prefer plumbing over git-diff
      alternates: accept double-quoted paths
      tmp-objdir: quote paths we add to alternates
      Makefile: reformat FIND_SOURCE_FILES
      Makefile: exclude test cruft from FIND_SOURCE_FILES
      Makefile: match shell scripts in FIND_SOURCE_FILES
      Makefile: exclude contrib from FIND_SOURCE_FILES
      parse-options: print "fatal:" before usage_msg_opt()
      http: respect protocol.*.allow=user for http-alternates
      README: replace gmane link with public-inbox
      merge: mark usage error strings for translation
      t5000: extract nongit function to test-lib-functions.sh
      index-pack: complain when --stdin is used outside of a repo
      t: use nongit() function where applicable
      shortlog: test and document --committer option
      index-pack: skip collision check when not in repository
      archive-zip: load userdiff config
      rebase--interactive: count squash commits above 10 correctly
      blame: fix alignment with --abbrev=40
      blame: handle --no-abbrev
      blame: output porcelain "previous" header for each file
      git_exec_path: do not return the result of getenv()
      execv_dashed_external: use child_process struct
      execv_dashed_external: stop exiting with negative code
      execv_dashed_external: wait for child on signal death
      t7810: avoid assumption about invalid regex syntax
      Revert "vreportf: avoid intermediate buffer"
      vreport: sanitize ASCII control chars
      t1450: refactor loose-object removal
      sha1_file: fix error message for alternate objects
      t1450: test fsck of packed objects
      sha1_file: add read_loose_object() function
      fsck: parse loose object paths directly
      fsck: detect trailing garbage in all object types
      t1450: clean up sub-objects in duplicate-entry test
      fsck: report trees as dangling
      fsck: prepare dummy objects for --connectivity-check
      fsck: tighten error-checks of "git fsck <head>"
      fsck: do not fallback "git fsck <bogus>" to "git fsck"
      fsck: check HAS_OBJ more consistently
      CodingGuidelines: clarify multi-line brace style
      clear_delta_base_cache(): don't modify hashmap while iterating
      t1450: use "mv -f" within loose object directory
      difftool: hack around -Wzero-length-format warning
      fsck: move typename() printing to its own function
      fsck: lazily load types under --connectivity-only
      color_parse_mem: allow empty color spec
      document behavior of empty color name
      diff: print line prefix for --name-only output

Johannes Schindelin (56):
      cherry-pick: demonstrate a segmentation fault
      merge-recursive: handle NULL in add_cacheinfo() correctly
      mingw: intercept isatty() to handle /dev/null as Git expects it
      mingw: adjust is_console() to work with stdin
      mingw: add a regression test for pushing to UNC paths
      giteveryday: unbreak rendering with AsciiDoctor
      git_exec_path: avoid Coverity warning about unfree()d result
      sequencer: avoid unnecessary curly braces
      sequencer: move "else" keyword onto the same line as preceding brace
      sequencer: use a helper to find the commit message
      sequencer: support a new action: 'interactive rebase'
      sequencer (rebase -i): implement the 'noop' command
      sequencer (rebase -i): implement the 'edit' command
      sequencer (rebase -i): implement the 'exec' command
      sequencer (rebase -i): learn about the 'verbose' mode
      sequencer (rebase -i): write the 'done' file
      sequencer (rebase -i): add support for the 'fixup' and 'squash' commands
      sequencer (rebase -i): implement the short commands
      sequencer (rebase -i): write an author-script file
      sequencer (rebase -i): allow continuing with staged changes
      sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
      sequencer (rebase -i): skip some revert/cherry-pick specific code path
      sequencer (rebase -i): the todo can be empty when continuing
      sequencer (rebase -i): update refs after a successful rebase
      sequencer (rebase -i): leave a patch upon error
      sequencer (rebase -i): implement the 'reword' command
      sequencer (rebase -i): allow fast-forwarding for edit/reword
      sequencer (rebase -i): refactor setting the reflog message
      sequencer (rebase -i): set the reflog message consistently
      sequencer (rebase -i): copy commit notes at end
      sequencer (rebase -i): record interrupted commits in rewritten, too
      sequencer (rebase -i): run the post-rewrite hook, if needed
      sequencer (rebase -i): respect the rebase.autostash setting
      sequencer (rebase -i): respect strategy/strategy_opts settings
      sequencer (rebase -i): allow rescheduling commands
      sequencer (rebase -i): implement the 'drop' command
      sequencer (rebase -i): differentiate between comments and 'noop'
      difftool: add a skeleton for the upcoming builtin
      sequencer: update reading author-script
      sequencer: use run_command() directly
      sequencer (rebase -i): show only failed `git commit`'s output
      sequencer (rebase -i): show only failed cherry-picks' output
      sequencer (rebase -i): suggest --edit-todo upon unknown command
      sequencer (rebase -i): show the progress
      sequencer (rebase -i): write the progress into files
      sequencer (rebase -i): write out the final message
      mingw: follow-up to "replace isatty() hack"
      difftool: implement the functionality in the builtin
      difftool: retire the scripted version
      remote rename: demonstrate a bogus "remote exists" bug
      remote rename: more carefully determine whether a remote is configured
      relink: retire the command
      status: be prepared for not-yet-started interactive rebase
      t/Makefile: add a rule to re-run previously-failed tests
      test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/
      mingw: allow hooks to be .exe files

Johannes Sixt (4):
      t5547-push-quarantine: run the path separator test on Windows, too
      normalize_path_copy(): fix pushing to //server/share/dir on Windows
      t5615-alternate-env: double-quotes in file names do not work on Windows
      real_path: canonicalize directory separators in root parts

Jonathan Tan (6):
      fetch: do not redundantly calculate tag refmap
      trailer: be stricter in parsing separators
      commit: make ignore_non_trailer take buf/len
      trailer: avoid unnecessary splitting on lines
      trailer: have function to describe trailer layout
      sequencer: use trailer's trailer layout

Junio C Hamano (37):
      utf8: refactor code to decide fallback encoding
      utf8: accept "latin-1" as ISO-8859-1
      git_open(): untangle possible NOATIME and CLOEXEC interactions
      push: do not use potentially ambiguous default refspec
      git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
      sha1_file: stop opening files with O_NOATIME
      compression: unify pack.compression configuration parsing
      pull: fast-forward "pull --rebase=true"
      preparing for 2.10.3
      Start post 2.11 cycle
      wt-status: implement opportunisitc index update correctly
      hold_locked_index(): align error handling with hold_lockfile_for_update()
      lockfile: LOCK_REPORT_ON_ERROR
      Early fixes for 2.11.x series
      Revert "sequencer: remove useless get_dir() function"
      First batch for 2.12
      Second batch for 2.12
      i18n: fix misconversion in shell scripts
      t4201: make tests work with and without the MINGW prerequiste
      Third batch for 2.12
      config.abbrev: document the new default that auto-scales
      diff: retire "compaction" heuristics
      lockfile: move REPORT_ON_ERROR bit elsewhere
      Fourth batch for 2.12
      Fifth batch 2.12
      Almost ready for 2.11.1
      RelNotes: drop merge-later comments for maint
      Sixth batch for 2.12
      Seventh batch for 2.12
      show-ref: remove a stale comment
      relink: really remove the command
      Eighth batch for 2.12
      Ready for 2.11.1
      Git 2.11.1
      Ninth batch for 2.12; almost ready for -rc0
      Git 2.12-rc0
      Git 2.12-rc1

Kristoffer Haugsbakk (4):
      doc: add articles (grammar)
      doc: add verb in front of command to run
      doc: make the intent of sentence clearer
      doc: omit needless "for"

Kyle J. McKay (1):
      mailinfo.c: move side-effects outside of assert

Kyle Meyer (1):
      branch_get_push: do not segfault when HEAD is detached

Lars Schneider (8):
      git-p4: add config to retry p4 commands; retry 3 times by default
      travis-ci: update P4 to 16.2 and GitLFS to 1.5.2 in Linux build
      git-p4: fix empty file processing for large file system backend GitLFS
      t0021: minor filter process test cleanup
      docs: warn about possible '=' in clean/smudge filter process values
      t0021: fix flaky test
      git-p4: add diff/merge properties to .gitattributes for GitLFS files
      travis-ci: fix Perforce install on macOS

Linus Torvalds (1):
      shortlog: group by committer information

Luis Ressel (1):
      date-formats.txt: Typo fix

Lukas Puehringer (3):
      gpg-interface, tag: add GPG_VERIFY_OMIT_STATUS flag
      ref-filter: add function to print single ref_array_item
      builtin/tag: add --format argument for tag -v

Luke Diamand (3):
      git-p4: support updating an existing shelved changelist
      git-p4: support git worktrees
      git-p4: avoid crash adding symlinked directory

Markus Hitter (3):
      gitk: Turn off undo manager in the text widget
      gitk: Remove closed file descriptors from $blobdifffd
      gitk: Clear array 'commitinfo' on reload

Matt McCutchen (3):
      doc: mention transfer data leaks in more places
      git-gc.txt: expand discussion of races with other processes
      t0001: don't let a default ACL interfere with the umask test

Max Kirillov (1):
      mingw: consider that UNICODE_STRING::Length counts bytes

Mike Hommey (1):
      fast-import: properly fanout notes when tree is imported

Nguyễn Thái Ngọc Duy (19):
      worktree.c: zero new 'struct worktree' on allocation
      worktree: reorder an if statement
      get_worktrees() must return main worktree as first item even on error
      worktree.c: get_worktrees() takes a new flag argument
      worktree list: keep the list sorted
      merge-recursive.c: use string_list_sort instead of qsort
      tag, branch, for-each-ref: add --ignore-case for sorting and filtering
      shallow.c: rename fields in paint_info to better express their purposes
      shallow.c: stop abusing COMMIT_SLAB_SIZE for paint_info's memory pools
      shallow.c: make paint_alloc slightly more robust
      shallow.c: remove useless code
      rebase: add --quit to cleanup rebase, leave everything else untouched
      config.c: handle error case for fstat() calls
      config.c: rename label unlock_and_out
      config.c: handle lock file in error case in git_config_rename_...
      color.c: fix color_parse_mem() with value_len == 0
      color.c: trim leading spaces in color_parse_mem()
      log --graph: customize the graph lines with config log.graphColors
      rev-list-options.txt: update --all about HEAD

Patrick Steinhardt (1):
      worktree: fix option descriptions for `prune`

Paul Mackerras (2):
      gitk: Use explicit RGB green instead of "lime"
      gitk: Update copyright notice to 2016

Peter Law (1):
      Completion: Add support for --submodule=diff

Philip Oakley (3):
      doc: gitk: remove gitview reference
      doc: gitk: add the upstream repo location
      doc: git-gui browser does not default to HEAD

Pranit Bauva (2):
      don't use test_must_fail with grep
      t9813: avoid using pipes

Ramsay Jones (1):
      GIT-VERSION-GEN: do not force abbreviation length used by 'describe'

Rasmus Villemoes (2):
      shallow.c: avoid theoretical pointer wrap-around
      shallow.c: bit manipulation tweaks

René Scharfe (13):
      compat: add qsort_s()
      add QSORT_S
      perf: add basic sort performance test
      string-list: use QSORT_S in string_list_sort()
      ref-filter: use QSORT_S in ref_array_sort()
      abspath: add absolute_pathdup()
      use absolute_pathdup()
      use oid_to_hex_r() for converting struct object_id hashes to hex strings
      use oidcpy() for copying hashes between instances of struct object_id
      checkout: convert post_checkout_hook() to struct object_id
      receive-pack: call string_list_clear() unconditionally
      p5302: create repositories for index-pack results explicitly
      dir: avoid allocation in fill_directory()

Richard Hansen (16):
      .mailmap: record canonical email for Richard Hansen
      rev-parse doc: pass "--" to rev-parse in the --prefix example
      t7610: update branch names to match test number
      t7610: move setup code to the 'setup' test case
      t7610: use test_when_finished for cleanup tasks
      t7610: don't rely on state from previous test
      t7610: run 'git reset --hard' after each test to clean up
      t7610: delete some now-unnecessary 'git reset --hard' lines
      t7610: always work on a test-specific branch
      t7610: don't assume the checked-out commit
      t7610: spell 'git reset --hard' consistently
      t7610: add test case for rerere+mergetool+subdir bug
      mergetool: take the "-O" out of $orderfile
      mergetool: fix running in subdir when rerere enabled
      diff: document behavior of relative diff.orderFile
      diff: document the format of the -O (diff.orderFile) file

Rogier Goossens (3):
      gitk: Add a 'rename' option to the branch context menu
      gitk: Allow checking out a remote branch
      gitk: Include commit title in branch dialog

SZEDER Gábor (9):
      t7004-tag: delete unnecessary tags with test_when_finished
      t7004-tag: use test_config helper
      t7004-tag: add version sort tests to show prerelease reordering issues
      versioncmp: pass full tagnames to swap_prereleases()
      versioncmp: cope with common part overlapping with prerelease suffix
      versioncmp: use earliest-longest contained suffix to determine sorting order
      versioncmp: factor out helper for suffix matching
      versioncmp: generalize version sort suffix reordering
      .mailmap: update Gábor Szeder's email address

Santiago Torres (3):
      builtin/verify-tag: add --format to verify-tag
      t/t7030-verify-tag: Add --format specifier tests
      t/t7004-tag: Add --format specifier tests

Satoshi Yasushima (1):
      gitk: Fix Japanese translation for "marked commit"

Stefan Beller (42):
      submodule config: inline config_from_{name, path}
      submodule-config: rename commit_sha1 to treeish_name
      submodule-config: clarify parsing of null_sha1 element
      submodule add: extend force flag to add existing repos
      unpack-trees: fix grammar for untracked files in directories
      t3600: remove useless redirect
      submodule: use absolute path for computing relative path connecting
      submodule helper: support super prefix
      test-lib-functions.sh: teach test_commit -C <dir>
      worktree: check if a submodule uses worktrees
      move connect_work_tree_and_git_dir to dir.h
      submodule: add absorb-git-dir function
      t3600: slightly modernize style
      worktree: initialize return value for submodule_uses_worktrees
      submodule.h: add extern keyword to functions
      submodule: modernize ok_to_remove_submodule to use argv_array
      submodule: rename and add flags to ok_to_remove_submodule
      rm: absorb a submodules git dir before deletion
      submodule.c: use GIT_DIR_ENVIRONMENT consistently
      contrib: remove gitview
      pathspec: give better message for submodule related pathspec error
      unpack-trees: move checkout state into check_updates
      unpack-trees: remove unneeded continue
      unpack-trees: factor progress setup out of check_updates
      read-tree: use OPT_BOOL instead of OPT_SET_INT
      t1000: modernize style
      t1001: modernize style
      submodule absorbgitdirs: mention in docstring help
      t7411: quote URLs
      t7411: test lookup of uninitialized submodules
      submodule update --init: display correct path from submodule
      lib-submodule-update.sh: reduce use of subshell by using "git -C"
      cache.h: document index_name_pos
      cache.h: document remove_index_entry_at
      cache.h: document add_[file_]to_index
      documentation: retire unfinished documentation
      contrib: remove git-convert-objects
      unpack-trees: support super-prefix option
      setup: add gentle version of resolve_git_dir
      cache.h: expose the dying procedure for reading gitlinks
      submodule absorbing: fix worktree/gitdir pointers recursively for non-moves
      submodule update: run custom update script for initial populating as well

Stefan Dotterweich (1):
      gitk: Fix missing commits when using -S or -G

Stephan Beyer (5):
      am: fix filename in safe_to_abort() error message
      am: change safe_to_abort()'s not rewinding error into a warning
      t3510: test that cherry-pick --abort does not unsafely change HEAD
      sequencer: make sequencer abort safer
      sequencer: remove useless get_dir() function

Steven Penny (2):
      Makefile: POSIX windres
      Makefile: put LIBS after LDFLAGS for imap-send

Torsten Bögershausen (1):
      convert: git cherry-pick -Xrenormalize did not work

Vasco Almeida (18):
      gitk: Makefile: create install bin directory
      gitk: Add Portuguese translation
      Git.pm: add subroutines for commenting lines
      i18n: add--interactive: mark strings for translation
      i18n: add--interactive: mark simple here-documents for translation
      i18n: add--interactive: mark strings with interpolation for translation
      i18n: clean.c: match string with git-add--interactive.perl
      i18n: add--interactive: mark plural strings
      i18n: add--interactive: mark patch prompt for translation
      i18n: add--interactive: i18n of help_patch_cmd
      i18n: add--interactive: mark edit_hunk_manually message for translation
      i18n: add--interactive: remove %patch_modes entries
      i18n: add--interactive: mark status words for translation
      i18n: send-email: mark strings for translation
      i18n: send-email: mark warnings and errors for translation
      i18n: send-email: mark string with interpolation for translation
      i18n: send-email: mark composing message for translation
      i18n: difftool: mark warnings for translation

Vegard Nossum (1):
      diff: add interhunk context config option

Vinicius Kursancew (1):
      git-p4: allow submit to create shelved changelists.

Vitaly "_Vi" Shukela (1):
      submodule--helper: set alternateLocation for cloned submodules

Vladimir Panteleev (5):
      show-ref: accept HEAD with --verify
      show-ref: allow -d to work with --verify
      show-ref: move --quiet handling into show_one()
      show-ref: detect dangling refs under --verify as well
      show-ref: remove dead `if (verify)' check

Wolfram Sang (1):
      request-pull: drop old USAGE stuff

brian m. carlson (8):
      Documentation: fix warning in cat-texi.perl
      Documentation: modernize cat-texi.perl
      Documentation: remove unneeded argument in cat-texi.perl
      Documentation: sort sources for gitman.texi
      Documentation: add XSLT to fix DocBook for Texinfo
      Documentation: move dblatex arguments into variable
      Makefile: add a knob to enable the use of Asciidoctor
      Documentation: implement linkgit macro for Asciidoctor

마누엘 (1):
      asciidoctor: fix user-manual to be built by `asciidoctor`

