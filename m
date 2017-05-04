Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D81207D6
	for <e@80x24.org>; Thu,  4 May 2017 15:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbdEDPPZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 11:15:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35205 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbdEDPPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 11:15:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so2678089pgd.2;
        Thu, 04 May 2017 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b6c6usb/ydQL8DSYx2ySogBko78/5p3m/TUC8zXoO8w=;
        b=Nf2lhM7HHCBsPngXBMVeiaR36JL7xwIw3dIVTjj7KWuLcbqUuPJxR7jXcIIzln/SRU
         5ptV/JP97ILe7EHL5hEZw+Mmfv6QEWvHwIdYtRgInfzg7/KyGi2tTceDn1+F3swG2tsr
         HRsmTqad3ySVlId1nyx1oRZZK/JIYjB8bDg42KGvWiK3GzXvitYHm3qMRJaEoVu4FdfF
         /DbECCYLnVVJviF5QcyRb1bQ/9rH3eR3CzDZdyaeNpI3Mp8ysIwi9sNcQU3dfRt/s6W/
         E7MvVmTL92Wkbl2Z4f0uv/sWQaN9r5tPwUzp+VkysHWshubgdbuMZGryJCVK38uB9gAS
         EoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b6c6usb/ydQL8DSYx2ySogBko78/5p3m/TUC8zXoO8w=;
        b=EjEwOwmgz7JZWastBeljPImIc2kT9mq3qexqzoGmwWKJMIeZSQsiX0KRMhc7mdbQAU
         qvi9yaQtcf7Tn0DcYoKy0rqhOuV4zYL20t+LyRA6xVRdlGdUSI1Ue2mjStnBqqXSjUm9
         Els8hRtCCPthSK6+u0Apyyr6mRkMooYb39xA2TUaWDijsaGh9GopSLT/9TxZZVU/3IdI
         p7IC4yLgmDedEbub5/gOxJhuBc8FPq64IwLEZlN0K2N4lnt+bxtc7MrMH27CQSX75usG
         XRK1M9egMoCNGP4Bz1SYWqnFrcqMSEZsezRuWT90Y17v4Jk6BwUka3Pmcg7piTeT52d4
         xXVQ==
X-Gm-Message-State: AN3rC/7sSJLhT79tsYvF2lZqBhr6ErtFc2p9AA4+qxv9w2MCurb1tT3h
        yQjI6Ng1/59Vew==
X-Received: by 10.99.164.26 with SMTP id c26mr46310343pgf.89.1493910913401;
        Thu, 04 May 2017 08:15:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id n7sm6356534pfn.0.2017.05.04.08.15.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 May 2017 08:15:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.13.0-rc2
Date:   Thu, 04 May 2017 08:15:11 -0700
Message-ID: <xmqq1ss4ac1s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.13.0-rc2 is now available for testing
at the usual places.  It is comprised of 699 non-merge commits
since v2.12.0, contributed by 59 people, 15 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.13.0-rc2' tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.12.0 are as follows.
Welcome to the Git development community!

  Allan Xavier, Andreas Heiduk, Devin J. Pohly, Devin Lehmacher,
  Hiroshi Shirosaki, Johan Hovold, Maxim Moseychuk, Mostyn
  Bramley-Moore, Prathamesh Chavan, Quentin Pradet, René Genz,
  Segev Finer, Sergey Ryazanov, Stephen Hicks, and Valery Tolstov.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alex Henrie, Brandon Williams,
  brian m. carlson, Christian Couder, Cornelius Weig, David
  Aguilar, David Turner, Eric Wong, Giuseppe Bilotta, Jacob Keller,
  Jean-Noel Avila, Jeff Hostetler, Jeff King, Johannes Schindelin,
  Jonathan Nieder, Jonathan Tan, Junio C Hamano, Karthik Nayak,
  Kevin Willford, Kyle Meyer, Lars Schneider, Linus Torvalds,
  Luke Diamand, Matt McCutchen, Michael Haggerty, Michael J Gruber,
  Michael Rappazzo, Mike Hommey, Nguyễn Thái Ngọc Duy, Patrick
  Steinhardt, Peter Krefting, Ralf Thielow, Ramsay Jones, René
  Scharfe, Ross Lagerwall, Santiago Torres, Sebastian Schuberth,
  Simon Ruderich, Stefan Beller, SZEDER Gábor, Thomas Gummerer,
  Torsten Bögershausen, and Vegard Nossum.

----------------------------------------------------------------

Git 2.13 Release Notes (draft)
==============================

Backward compatibility notes.

 * Use of an empty string as a pathspec element that is used for
   'everything matches' is still warned and Git asks users to use a
   more explicit '.' for that instead.  The hope is that existing
   users will not mind this change, and eventually the warning can be
   turned into a hard error, upgrading the deprecation into removal of
   this (mis)feature.  That is not scheduled to happen in the upcoming
   release (yet).

 * The historical argument order "git merge <msg> HEAD <commit>..."
   has been deprecated for quite some time, and is now removed.

 * The default location "~/.git-credential-cache/socket" for the
   socket used to communicate with the credential-cache daemon has
   been moved to "~/.cache/git/credential/socket".

 * Git now avoids blindly falling back to ".git" when the setup
   sequence said we are _not_ in Git repository.  A corner case that
   happens to work right now may be broken by a call to die("BUG").
   We've tried hard to locate such cases and fixed them, but there
   might still be cases that need to be addressed--bug reports are
   greatly appreciated.


Updates since v2.12
-------------------

UI, Workflows & Features

 * "git describe" and "git name-rev" have been taught to take more
   than one refname patterns to restrict the set of refs to base their
   naming output on, and also learned to take negative patterns to
   name refs not to be used for naming via their "--exclude" option.

 * Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
   once there no longer is any other branch whose name begins with
   "foo/", but we didn't do so so far.  Now we do.

 * When "git merge" detects a path that is renamed in one history
   while the other history deleted (or modified) it, it now reports
   both paths to help the user understand what is going on in the two
   histories being merged.

 * The <url> part in "http.<url>.<variable>" configuration variable
   can now be spelled with '*' that serves as wildcard.
   E.g. "http.https://*.example.com.proxy" can be used to specify the
   proxy used for https://a.example.com, https://b.example.com, etc.,
   i.e. any host in the example.com domain.

 * "git tag" did not leave useful message when adding a new entry to
   reflog; this was left unnoticed for a long time because refs/tags/*
   doesn't keep reflog by default.

 * The "negative" pathspec feature was somewhat more cumbersome to use
   than necessary in that its short-hand used "!" which needed to be
   escaped from shells, and it required "exclude from what?" specified.

 * The command line options for ssh invocation needs to be tweaked for
   some implementations of SSH (e.g. PuTTY plink wants "-P <port>"
   while OpenSSH wants "-p <port>" to specify port to connect to), and
   the variant was guessed when GIT_SSH environment variable is used
   to specify it.  The logic to guess now applies to the command
   specified by the newer GIT_SSH_COMMAND and also core.sshcommand
   configuration variable, and comes with an escape hatch for users to
   deal with misdetected cases.

 * The "--git-path", "--git-common-dir", and "--shared-index-path"
   options of "git rev-parse" did not produce usable output.  They are
   now updated to show the path to the correct file, relative to where
   the caller is.

 * "git diff -W" has been taught to handle the case where a new
   function is added at the end of the file better.

 * "git update-ref -d" and other operations to delete references did
   not leave any entry in HEAD's reflog when the reference being
   deleted was the current branch.  This is not a problem in practice
   because you do not want to delete the branch you are currently on,
   but caused renaming of the current branch to something else not to
   be logged in a useful way.

 * "Cc:" on the trailer part does not have to conform to RFC strictly,
   unlike in the e-mail header.  "git send-email" has been updated to
   ignore anything after '>' when picking addresses, to allow non-address
   cruft like " # stable 4.4" after the address.

 * When "git submodule init" decides that the submodule in the working
   tree is its upstream, it now gives a warning as it is not a very
   common setup.

 * "git stash push" takes a pathspec so that the local changes can be
   stashed away only partially.

 * Documentation for "git ls-files" did not refer to core.quotePath.

 * The experimental "split index" feature has gained a few
   configuration variables to make it easier to use.

 * From a working tree of a repository, a new option of "rev-parse"
   lets you ask if the repository is used as a submodule of another
   project, and where the root level of the working tree of that
   project (i.e. your superproject) is.

 * The pathspec mechanism learned to further limit the paths that
   match the pattern to those that have specified attributes attached
   via the gitattributes mechanism.

 * Our source code has used the SHA1_HEADER cpp macro after "#include"
   in the C code to switch among the SHA-1 implementations. Instead,
   list the exact header file names and switch among implementations
   using "#ifdef BLK_SHA1/#include "block-sha1/sha1.h"/.../#endif";
   this helps some IDE tools.

 * The start-up sequence of "git" needs to figure out some configured
   settings before it finds and set itself up in the location of the
   repository and was quite messy due to its "chicken-and-egg" nature.
   The code has been restructured.

 * The command line prompt (in contrib/) learned a new 'tag' style
   that can be specified with GIT_PS1_DESCRIBE_STYLE, to describe a
   detached HEAD with "git describe --tags".

 * The configuration file learned a new "includeIf.<condition>.path"
   that includes the contents of the given path only when the
   condition holds.  This allows you to say "include this work-related
   bit only in the repositories under my ~/work/ directory".

 * Recent update to "rebase -i" started showing a message that is not
   a warning with "warning:" prefix by mistake.  This has been fixed.

 * Recently we started passing the "--push-options" through the
   external remote helper interface; now the "smart HTTP" remote
   helper understands what to do with the passed information.

 * "git describe --dirty" dies when it cannot be determined if the
   state in the working tree matches that of HEAD (e.g. broken
   repository or broken submodule).  The command learned a new option
   "git describe --broken" to give "$name-broken" (where $name is the
   description of HEAD) in such a case.

 * "git checkout" is taught the "--recurse-submodules" option.

 * Recent enhancement to "git stash push" command to support pathspec
   to allow only a subset of working tree changes to be stashed away
   was found to be too chatty and exposed the internal implementation
   detail (e.g. when it uses reset to match the index to HEAD before
   doing other things, output from reset seeped out).  These, and
   other chattyness has been fixed.

 * "git merge <message> HEAD <commit>" syntax that has been deprecated
   since October 2007 has been removed.

 * The refs completion for large number of refs has been sped up,
   partly by giving up disambiguating ambiguous refs and partly by
   eliminating most of the shell processing between 'git for-each-ref'
   and 'ls-remote' and Bash's completion facility.

 * On many keyboards, typing "@{" involves holding down SHIFT key and
   one can easily end up with "@{Up..." when typing "@{upstream}".  As
   the upstream/push keywords do not appear anywhere else in the syntax,
   we can safely accept them case insensitively without introducing
   ambiguity or confusion to solve this.

 * "git tag/branch/for-each-ref" family of commands long allowed to
   filter the refs by "--contains X" (show only the refs that are
   descendants of X), "--merged X" (show only the refs that are
   ancestors of X), "--no-merged X" (show only the refs that are not
   ancestors of X).  One curious omission, "--no-contains X" (show
   only the refs that are not descendants of X) has been added to
   them.

 * The default behaviour of "git log" in an interactive session has
   been changed to enable "--decorate".

 * The output from "git status --short" has been extended to show
   various kinds of dirtyness in submodules differently; instead of to
   "M" for modified, 'm' and '?' can be shown to signal changes only
   to the working tree of the submodule but not the commit that is
   checked out.

 * Allow the http.postbuffer configuration variable to be set to a
   size that can be expressed in size_t, which can be larger than
   ulong on some platforms.

 * "git rebase" learns "--signoff" option.

 * The completion script (in contrib/) learned to complete "git push
   --delete b<TAB>" to complete branch name to be deleted.

 * "git worktree add --lock" allows to lock a worktree immediately
   after it's created. This helps prevent a race between "git worktree
   add; git worktree lock" and "git worktree prune".

 * Completion for "git checkout <branch>" that auto-creates the branch
   out of a remote tracking branch can now be disabled, as this
   completion often gets in the way when completing to checkout an
   existing local branch that happens to share the same prefix with
   bunch of remote tracking branches.


Performance, Internal Implementation, Development Support etc.

 * The code to list branches in "git branch" has been consolidated
   with the more generic ref-filter API.

 * Resource usage while enumerating refs from alternate object store
   has been optimized to help receiving end of "push" that hosts a
   repository with many "forks".

 * The gitattributes machinery is being taught to work better in a
   multi-threaded environment.

 * "git rebase -i" starts using the recently updated "sequencer" code.

 * Code and design clean-up for the refs API.

 * The preload-index code has been taught not to bother with the index
   entries that are paths that are not checked out by "sparse checkout".

 * Some warning() messages from "git clean" were updated to show the
   errno from failed system calls.

 * The "parse_config_key()" API function has been cleaned up.

 * A test that creates a confusing branch whose name is HEAD has been
   corrected not to do so.

 * The code that parses header fields in the commit object has been
   updated for (micro)performance and code hygiene.

 * An helper function to make it easier to append the result from
   real_path() to a strbuf has been added.

 * Reduce authentication round-trip over HTTP when the server supports
   just a single authentication method.  This also improves the
   behaviour when Git is misconfigured to enable http.emptyAuth
   against a server that does not authenticate without a username
   (i.e. not using Kerberos etc., which makes http.emptyAuth
   pointless).

 * Windows port wants to use OpenSSL's implementation of SHA-1
   routines, so let them.

 * The t/perf performance test suite was not prepared to test not so
   old versions of Git, but now it covers versions of Git that are not
   so ancient.

 * Add 32-bit Linux variant to the set of platforms to be tested with
   Travis CI.

 * "git branch --list" takes the "--abbrev" and "--no-abbrev" options
   to control the output of the object name in its "-v"(erbose)
   output, but a recent update started ignoring them; fix it before
   the breakage reaches to any released version.

 * Picking two versions of Git and running tests to make sure the
   older one and the newer one interoperate happily has now become
   possible.

 * "git tag --contains" used to (ab)use the object bits to keep track
   of the state of object reachability without clearing them after
   use; this has been cleaned up and made to use the newer commit-slab
   facility.

 * The "debug" helper used in the test framework learned to run
   a command under "gdb" interactively.

 * The "detect attempt to create collisions" variant of SHA-1
   implementation by Marc Stevens (CWI) and Dan Shumow (Microsoft)
   has been integrated and made the default.

 * The test framework learned to detect unterminated here documents.

 * The name-hash used for detecting paths that are different only in
   cases (which matter on case insensitive filesystems) has been
   optimized to take advantage of multi-threading when it makes sense.

 * An earlier version of sha1dc/sha1.c that was merged to 'master'
   compiled incorrectly on Windows, which has been fixed.

 * "what URL do we want to update this submodule?" and "are we
   interested in this submodule?" are split into two distinct
   concepts, and then the way used to express the latter got extended,
   paving a way to make it easier to manage a project with many
   submodules and make it possible to later extend use of multiple
   worktrees for a project with submodules.

 * Some debugging output from "git describe" were marked for l10n,
   but some weren't.  Mark missing ones for l10n.

 * Define a new task in .travis.yml that triggers a test session on
   Windows run elsewhere.

 * Conversion from uchar[20] to struct object_id continues.

 * The "submodule" specific field in the ref_store structure is
   replaced with a more generic "gitdir" that can later be used also
   when dealing with ref_store that represents the set of refs visible
   from the other worktrees.

 * The string-list API used a custom reallocation strategy that was
   very inefficient, instead of using the usual ALLOC_GROW() macro,
   which has been fixed.
   (merge 950a234cbd jh/string-list-micro-optim later to maint).

 * In a 2- and 3-way merge of trees, more than one source trees often
   end up sharing an identical subtree; optimize by not reading the
   same tree multiple times in such a case.
   (merge d12a8cf0af jh/unpack-trees-micro-optim later to maint).

 * The index file has a trailing SHA-1 checksum to detect file
   corruption, and historically we checked it every time the index
   file is used.  Omit the validation during normal use, and instead
   verify only in "git fsck".

 * Having a git command on the upstream side of a pipe in a test
   script will hide the exit status from the command, which may cause
   us to fail to notice a breakage; rewrite tests in a script to avoid
   this issue.

 * Travis CI learns to run coccicheck.

 * "git checkout" that handles a lot of paths has been optimized by
   reducing the number of unnecessary checks of paths in the
   has_dir_name() function.

 * The internals of the refs API around the cached refs has been
   streamlined.

 * Output from perf tests have been updated to align their titles.

Also contains various documentation updates and code clean-ups.


Fixes since v2.12
-----------------

Unless otherwise noted, all the fixes since v2.12 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git repack --depth=<n>" for a long time busted the specified depth
   when reusing delta from existing packs.  This has been corrected.

 * The code to parse the command line "git grep <patterns>... <rev>
   [[--] <pathspec>...]" has been cleaned up, and a handful of bugs
   have been fixed (e.g. we used to check "--" if it is a rev).

 * "git ls-remote" and "git archive --remote" are designed to work
   without being in a directory under Git's control.  However, recent
   updates revealed that we randomly look into a directory called
   .git/ without actually doing necessary set-up when working in a
   repository.  Stop doing so.

 * "git show-branch" expected there were only very short branch names
   in the repository and used a fixed-length buffer to hold them
   without checking for overflow.

 * A caller of tempfile API that uses stdio interface to write to
   files may ignore errors while writing, which is detected when
   tempfile is closed (with a call to ferror()).  By that time, the
   original errno that may have told us what went wrong is likely to
   be long gone and was overwritten by an irrelevant value.
   close_tempfile() now resets errno to EIO to make errno at least
   predictable.

 * "git remote rm X", when a branch has remote X configured as the
   value of its branch.*.remote, tried to remove branch.*.remote and
   branch.*.merge and failed if either is unset.

 * A "gc.log" file left by a backgrounded "gc --auto" disables further
   automatic gc; it has been taught to run at least once a day (by
   default) by ignoring a stale "gc.log" file that is too old.

 * The code to parse "git -c VAR=VAL cmd" and set configuration
   variable for the duration of cmd had two small bugs, which have
   been fixed.

 * user.email that consists of only cruft chars should consistently
   error out, but didn't.

 * "git upload-pack", which is a counter-part of "git fetch", did not
   report a request for a ref that was not advertised as invalid.
   This is generally not a problem (because "git fetch" will stop
   before making such a request), but is the right thing to do.

 * A leak in a codepath to read from a packed object in (rare) cases
   has been plugged.

 * When a redirected http transport gets an error during the
   redirected request, we ignored the error we got from the server,
   and ended up giving a not-so-useful error message.

 * The patch subcommand of "git add -i" was meant to have paths
   selection prompt just like other subcommand, unlike "git add -p"
   directly jumps to hunk selection.  Recently, this was broken and
   "add -i" lost the paths selection dialog, but it now has been
   fixed.

 * Git v2.12 was shipped with an embarrassing breakage where various
   operations that verify paths given from the user stopped dying when
   seeing an issue, and instead later triggering segfault.

 * There is no need for Python only to give a few messages to the
   standard error stream, but we somehow did.

 * The code to parse "git log -L..." command line was buggy when there
   are many ranges specified with -L; overrun of the allocated buffer
   has been fixed.

 * The command-line parsing of "git log -L" copied internal data
   structures using incorrect size on ILP32 systems.

 * "git diff --quiet" relies on the size field in diff_filespec to be
   correctly populated, but diff_populate_filespec() helper function
   made an incorrect short-cut when asked only to populate the size
   field for paths that need to go through convert_to_git() (e.g. CRLF
   conversion).

 * A few tests were run conditionally under (rare) conditions where
   they cannot be run (like running cvs tests under 'root' account).

 * "git branch @" created refs/heads/@ as a branch, and in general the
   code that handled @{-1} and @{upstream} was a bit too loose in
   disambiguating.

 * "git fetch" that requests a commit by object name, when the other
   side does not allow such an request, failed without much
   explanation.

 * "git filter-branch --prune-empty" drops a single-parent commit that
   becomes a no-op, but did not drop a root commit whose tree is empty.

 * Recent versions of Git treats http alternates (used in dumb http
   transport) just like HTTP redirects and requires the client to
   enable following it, due to security concerns.  But we forgot to
   give a warning when we decide not to honor the alternates.

 * "git push" had a handful of codepaths that could lead to a deadlock
   when unexpected error happened, which has been fixed.

 * "Dumb http" transport used to misparse a nonsense http-alternates
   response, which has been fixed.

 * "git add -p <pathspec>" unnecessarily expanded the pathspec to a
   list of individual files that matches the pathspec by running "git
   ls-files <pathspec>", before feeding it to "git diff-index" to see
   which paths have changes, because historically the pathspec
   language supported by "diff-index" was weaker.  These days they are
   equivalent and there is no reason to internally expand it.  This
   helps both performance and avoids command line argument limit on
   some platforms.
   (merge 7288e12cce jk/add-i-use-pathspecs later to maint).

 * "git status --porcelain" is supposed to give a stable output, but a
   few strings were left as translatable by mistake.

 * "git revert -m 0 $merge_commit" complained that reverting a merge
   needs to say relative to which parent the reversion needs to
   happen, as if "-m 0" weren't given.  The correct diagnosis is that
   "-m 0" does not refer to the first parent ("-m 1" does).  This has
   been fixed.

 * Code to read submodule.<name>.ignore config did not state the
   variable name correctly when giving an error message diagnosing
   misconfiguration.

 * Fix for NO_PTHREADS build.

 * Fix for potential segv introduced in v2.11.0 and later (also
   v2.10.2) to "git log --pickaxe-regex -S".

 * A few unterminated here documents in tests were fixed, which in
   turn revealed incorrect expectations the tests make. These tests
   have been updated.

 * Fix for NO_PTHREADS option.
   (merge 2225e1ea20 bw/grep-recurse-submodules later to maint).

 * Git now avoids blindly falling back to ".git" when the setup
   sequence said we are _not_ in Git repository.  A corner case that
   happens to work right now may be broken by a call to die("BUG").
   (merge b1ef400eec jk/no-looking-at-dotgit-outside-repo-final later to maint).

 * A few commands that recently learned the "--recurse-submodule"
   option misbehaved when started from a subdirectory of the
   superproject.
   (merge b2dfeb7c00 bw/recurse-submodules-relative-fix later to maint).

 * FreeBSD implementation of getcwd(3) behaved differently when an
   intermediate directory is unreadable/unsearchable depending on the
   length of the buffer provided, which our strbuf_getcwd() was not
   aware of.  strbuf_getcwd() has been taught to cope with it better.
   (merge a54e938e5b rs/freebsd-getcwd-workaround later to maint).

 * A recent update to "rebase -i" stopped running hooks for the "git
   commit" command during "reword" action, which has been fixed.

 * Removing an entry from a notes tree and then looking another note
   entry from the resulting tree using the internal notes API
   functions did not work as expected.  No in-tree users of the API
   has such access pattern, but it still is worth fixing.

 * "git receive-pack" could have been forced to die by attempting
   allocate an unreasonably large amount of memory with a crafted push
   certificate; this has been fixed.
   (merge f2214dede9 bc/push-cert-receive-fix later to maint).

 * Update error handling for codepath that deals with corrupt loose
   objects.
   (merge 51054177b3 jk/loose-object-info-report-error later to maint).

 * "git diff --submodule=diff" learned to work better in a project
   with a submodule that in turn has its own submodules.
   (merge 17b254cda6 sb/show-diff-for-submodule-in-diff-fix later to maint).

 * Update the build dependency so that an update to /usr/bin/perl
   etc. result in recomputation of perl.mak file.
   (merge c59c4939c2 ab/regen-perl-mak-with-different-perl later to maint).

 * "git push --recurse-submodules --push-option=<string>" learned to
   propagate the push option recursively down to pushes in submodules.

 * If a patch e-mail had its first paragraph after an in-body header
   indented (even after a blank line after the in-body header line),
   the indented line was mistook as a continuation of the in-body
   header.  This has been fixed.
   (merge fd1062e52e lt/mailinfo-in-body-header-continuation later to maint).

 * Clean up fallouts from recent tightening of the set-up sequence,
   where Git barfs when repository information is accessed without
   first ensuring that it was started in a repository.
   (merge bccb22cbb1 jk/no-looking-at-dotgit-outside-repo later to maint).

 * "git p4" used "name-rev HEAD" when it wants to learn what branch is
   checked out; it should use "symbolic-ref HEAD".
   (merge eff451101d ld/p4-current-branch-fix later to maint).

 * "http.proxy" set to an empty string is used to disable the usage of
   proxy.  We broke this early last year.
   (merge ae51d91105 sr/http-proxy-configuration-fix later to maint).

 * $GIT_DIR may in some cases be normalized with all symlinks resolved
   while "gitdir" path expansion in the pattern does not receive the
   same treatment, leading to incorrect mismatch.  This has been fixed.

 * "git submodule" script does not work well with strange pathnames.
   Protect it from a path with slashes in them, at least.

 * "git fetch-pack" was not prepared to accept ERR packet that the
   upload-pack can send with a human-readable error message.  It
   showed the packet contents with ERR prefix, so there was no data
   loss, but it was redundant to say "ERR" in an error message.
   (merge 8e2c7bef03 jt/fetch-pack-error-reporting later to maint).

 * "ls-files --recurse-submodules" did not quite work well in a
   project with nested submodules.

 * gethostname(2) may not NUL terminate the buffer if hostname does
   not fit; unfortunately there is no easy way to see if our buffer
   was too small, but at least this will make sure we will not end up
   using garbage past the end of the buffer.
   (merge 5781a9a270 dt/xgethostname-nul-termination later to maint).

 * A recent update broke "git add -p ../foo" from a subdirectory.

 * While handy, "git_path()" is a dangerous function to use as a
   callsite that uses it safely one day can be broken by changes
   to other code that calls it.  Reduction of its use continues.
   (merge 16d2676c9e jk/war-on-git-path later to maint).

 * The split-index code configuration code used an unsafe git_path()
   function without copying its result out.

 * Many stale HTTP(s) links have been updated in our documentation.
   (merge 613416f0be jk/update-links-in-docs later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge df2a6e38b7 jk/pager-in-use later to maint).
   (merge 75ec4a6cb0 ab/branch-list-doc later to maint).
   (merge 3e5b36c637 sg/skip-prefix-in-prettify-refname later to maint).
   (merge 2c5e2865cc jk/fast-import-cleanup later to maint).
   (merge 4473060bc2 ab/test-readme-updates later to maint).
   (merge 48a96972fd ab/doc-submitting later to maint).
   (merge f5c2bc2b96 jk/make-coccicheck-detect-errors later to maint).
   (merge c105f563d1 cc/untracked later to maint).
   (merge 8668976b53 jc/unused-symbols later to maint).
   (merge fba275dc93 jc/bs-t-is-not-a-tab-for-sed later to maint).
   (merge be6ed145de mm/ls-files-s-doc later to maint).
   (merge 60b091c679 qp/bisect-docfix later to maint).
   (merge 47242cd103 ah/diff-files-ours-theirs-doc later to maint).
   (merge 35ad44cbd8 sb/submodule-rm-absorb later to maint).
   (merge 0301f1fd92 va/i18n-perl-scripts later to maint).
   (merge 733e064d98 vn/revision-shorthand-for-side-branch-log later to maint).
   (merge 85999743e7 tb/doc-eol-normalization later to maint).
   (merge 0747fb49fd jk/loose-object-fsck later to maint).
   (merge d8f4481c4f jk/quarantine-received-objects later to maint).
   (merge 7ba1ceef95 xy/format-patch-base later to maint).
   (merge fa1912c89a rs/misc-cppcheck-fixes later to maint).
   (merge f17d642d3b ab/push-cas-doc-n-test later to maint).
   (merge 61e282425a ss/gitmodules-ignore-doc later to maint).
   (merge 8d3047cd5b ss/submodule-shallow-doc later to maint).
   (merge 1f9e18b772 jk/prio-queue-avoid-swap-with-self later to maint).
   (merge 627fde1025 jk/submodule-init-segv-fix later to maint).
   (merge d395745d81 rg/doc-pull-typofix later to maint).
   (merge 01e60a9a22 rg/doc-submittingpatches-wordfix later to maint).
   (merge 501d3cd7b8 sr/hooks-cwd-doc later to maint).

----------------------------------------------------------------

Changes since v2.12.0 are as follows:

Alex Henrie (1):
      log: if --decorate is not given, default to --decorate=auto

Allan Xavier (1):
      line-log.c: prevent crash during union of too many ranges

Andreas Heiduk (2):
      Documentation: improve description for core.quotePath
      diff-files: document --ours etc.

Brandon Williams (37):
      attr: pass struct attr_check to collect_some_attrs
      attr: use hashmap for attribute dictionary
      attr: eliminate global check_all_attr array
      attr: remove maybe-real, maybe-macro from git_attr
      attr: tighten const correctness with git_attr and match_attr
      attr: store attribute stack in attr_check structure
      attr: push the bare repo check into read_attr()
      attr: reformat git_attr_set_direction() function
      pathspec: allow querying for attributes
      pathspec: allow escaped query values
      submodule--helper: add is-active subcommand
      submodule status: use submodule--helper is-active
      submodule sync: skip work for inactive submodules
      submodule sync: use submodule--helper is-active
      submodule--helper clone: check for configured submodules using helper
      grep: fix help text typo
      setup: allow for prefix to be passed to git commands
      grep: fix bug when recursing with relative pathspec
      ls-files: fix typo in variable name
      ls-files: fix bug when recursing with relative pathspec
      grep: set default output method
      submodule: decouple url and submodule interest
      submodule init: initialize active submodules
      clone: teach --recurse-submodules to optionally take a pathspec
      submodule--helper init: set submodule.<name>.active
      submodule add: respect submodule.active and submodule.<name>.active
      grep: fix builds with with no thread support
      send-pack: send push options correctly in stateless-rpc case
      remote-curl: allow push options
      sequencer: fix missing newline
      push: unmark a local variable as static
      push: propagate push-options with --recurse-submodules
      remote: expose parse_push_refspec function
      submodule--helper: add push-check subcommand
      push: propagate remote and refspec with --recurse-submodules
      pathspec: fix segfault in clear_pathspec
      submodule: prevent backslash expantion in submodule names

Christian Couder (25):
      config: mark an error message up for translation
      t1700: change here document style
      config: add git_config_get_split_index()
      split-index: add {add,remove}_split_index() functions
      read-cache: add and then use tweak_split_index()
      update-index: warn in case of split-index incoherency
      t1700: add tests for core.splitIndex
      Documentation/config: add information for core.splitIndex
      Documentation/git-update-index: talk about core.splitIndex config var
      config: add git_config_get_max_percent_split_change()
      read-cache: regenerate shared index if necessary
      t1700: add tests for splitIndex.maxPercentChange
      Documentation/config: add splitIndex.maxPercentChange
      sha1_file: make check_and_freshen_file() non static
      read-cache: touch shared index files when used
      config: add git_config_get_expiry() from gc.c
      read-cache: unlink old sharedindex files
      t1700: test shared index file expiration
      read-cache: refactor read_index_from()
      read-cache: use freshen_shared_index() in read_index_from()
      Documentation/config: add splitIndex.sharedIndexExpire
      Documentation/git-update-index: explain splitIndex.*
      update-index: fix xgetcwd() related memory leak
      p0004: make perf test executable
      read-cache: avoid using git_path() in freshen_shared_index()

Cornelius Weig (1):
      tag: generate useful reflog message

David Aguilar (3):
      t7800: remove whitespace before redirect
      t7800: cleanup cruft left behind by tests
      difftool: handle modified symlinks in dir-diff mode

David Turner (3):
      gc: ignore old gc.log files
      http.postbuffer: allow full range of ssize_t values
      xgethostname: handle long hostnames

Devin J. Pohly (4):
      t7003: ensure --prune-empty can prune root commit
      t7003: ensure --prune-empty removes entire branch when applicable
      filter-branch: fix --prune-empty on parentless commits
      p7000: add test for filter-branch with --prune-empty

Devin Lehmacher (3):
      path.c: add xdg_cache_home
      credential-cache: use XDG_CACHE_HOME for socket
      credential-cache: add tests for XDG functionality

Eric Wong (3):
      README: create HTTP/HTTPS links from URLs in Markdown
      http: inform about alternates-as-redirects behavior
      http: release strbuf on disabled alternates

Giuseppe Bilotta (4):
      builtin/am: honor --signoff also when --rebasing
      builtin/am: fold am_signoff() into am_append_signoff()
      doc: trivial typo in git-format-patch.txt
      rebase: pass --[no-]signoff option to git am

Hiroshi Shirosaki (1):
      git svn: fix authentication with 'branch'

Jacob Keller (7):
      doc: add documentation for OPT_STRING_LIST
      name-rev: extend --refs to accept multiple patterns
      name-rev: add support to exclude refs by pattern match
      describe: teach --match to accept multiple patterns
      describe: teach describe negative pattern matches
      ls-files: fix recurse-submodules with nested submodules
      ls-files: fix path used when recursing into submodules

Jean-Noel Avila (1):
      i18n: remove i18n from tag reflog message

Jeff Hostetler (18):
      mingw: use OpenSSL's SHA-1 routines
      preload-index: avoid lstat for skip-worktree items
      name-hash: specify initial size for istate.dir_hash table
      hashmap: allow memihash computation to be continued
      hashmap: add disallow_rehash setting
      hashmap: document memihash_cont, hashmap_disallow_rehash api
      name-hash: perf improvement for lazy_init_name_hash
      name-hash: add test-lazy-init-name-hash
      name-hash: add perf test for lazy_init_name_hash
      test-online-cpus: helper to return cpu count
      read-cache: force_verify_index_checksum
      string-list: use ALLOC_GROW macro when reallocing string_list
      read-cache: add strcmp_offset function
      unpack-trees: avoid duplicate ODB lookups during checkout
      p0006-read-tree-checkout: perf test to time read-tree
      read-cache: speed up add_index_entry during checkout
      read-cache: speed up has_dir_name (part 1)
      read-cache: speed up has_dir_name (part 2)

Jeff King (131):
      setup_git_env: avoid blind fall-back to ".git"
      pack-objects: enforce --depth limit in reused deltas
      pack-objects: convert recursion to iteration in break_delta_chain()
      for_each_alternate_ref: handle failure from real_pathdup()
      for_each_alternate_ref: stop trimming trailing slashes
      for_each_alternate_ref: use strbuf for path allocation
      for_each_alternate_ref: pass name/oid instead of ref struct
      for_each_alternate_ref: replace transport code with for-each-ref
      fetch-pack: cache results of for_each_alternate_ref
      add oidset API
      receive-pack: use oidset to de-duplicate .have lines
      receive-pack: fix misleading namespace/.have comment
      receive-pack: treat namespace .have lines like alternates
      receive-pack: avoid duplicates between our refs and alternates
      grep: move thread initialization a little lower
      grep: re-order rev-parsing loop
      grep: fix "--" rev/pathspec disambiguation
      grep: avoid resolving revision names in --no-index case
      grep: do not diagnose misspelt revs with --no-index
      show-branch: drop head_len variable
      show-branch: store resolved head in heap buffer
      remote: avoid reading $GIT_DIR config in non-repo
      grep: treat revs the same for --untracked as for --no-index
      show-branch: use skip_prefix to drop magic numbers
      tempfile: set errno to a known value before calling ferror()
      http: restrict auth methods to what the server advertises
      ident: mark error messages for translation
      ident: handle NULL email when complaining of empty name
      ident: reject all-crud ident name
      ident: do not ignore empty config name/email
      parse_config_key: use skip_prefix instead of starts_with
      parse_config_key: allow matching single-level config
      parse_hide_refs_config: tell parse_config_key we don't want a subsection
      http: add an "auto" mode for http.emptyauth
      t6300: avoid creating refs/heads/HEAD
      add--interactive: fix missing file prompt for patch mode with "-i"
      interpret_branch_name(): handle auto-namelen for @{-1}
      interpret_branch_name: move docstring to header file
      strbuf_branchname: drop return value
      strbuf_branchname: add docstring
      interpret_branch_name: allow callers to restrict expansions
      t3204: test git-branch @-expansion corner cases
      branch: restrict @-expansions when deleting
      strbuf_check_ref_format(): expand only local branches
      checkout: restrict @-expansions when finding branch
      t/perf: use $MODERN_GIT for all repo-copying steps
      t/perf: add fallback for pre-bin-wrappers versions of git
      ewah: fix eword_t/uint64_t confusion
      receive-pack: fix deadlock when we cannot create tmpdir
      send-pack: extract parsing of "unpack" response
      send-pack: use skip_prefix for parsing unpack status
      send-pack: improve unpack-status error messages
      send-pack: read "unpack" status even on pack-objects failure
      send-pack: report signal death of pack-objects
      ref-filter: move ref_cbdata definition into ref-filter.c
      ref-filter: use contains_result enum consistently
      ref-filter: die on parse_commit errors
      ref-filter: use separate cache for contains_tag_algo
      t: add an interoperability test harness
      t/interop: add test of old clients against modern git-daemon
      http-walker: fix buffer underflow processing remote alternates
      add--interactive: do not expand pathspecs with ls-files
      cherry-pick: detect bogus arguments to --mainline
      rev-parse: use skip_prefix when parsing options
      rev-parse: add helper for parsing "--foo/--foo="
      rev-parse: simplify parsing of ref options
      move odb_* declarations out of git-compat-util.h
      sha1_file.c: make pack-name helper globally accessible
      odb_pack_keep(): stop generating keepfile name
      replace snprintf with odb_pack_name()
      index-pack: make pointer-alias fallbacks safer
      sha1dc: add collision-detecting sha1 implementation
      sha1dc: adjust header includes for git
      sha1dc: disable safe_hash feature
      sequencer: drop "warning:" when stopping for edit
      Makefile: add DC_SHA1 knob
      t0013: add a basic sha1 collision detection test
      run-command: fix segfault when cleaning forked async process
      hash-object: fix buffer reuse with --path in a subdirectory
      prefix_filename: move docstring to header file
      prefix_filename: drop length parameter
      prefix_filename: return newly allocated string
      prefix_filename: simplify windows #ifdef
      bundle: use prefix_filename with bundle path
      pager_in_use: use git_env_bool()
      fast-import: use xsnprintf for writing sha1s
      fast-import: use xsnprintf for formatting headers
      encode_in_pack_object_header: respect output buffer length
      pack.h: define largest possible encoded object size
      do not check odb_mkstemp return value for errors
      odb_mkstemp: write filename into strbuf
      odb_mkstemp: use git_path_buf
      Makefile: detect errors in running spatch
      difftool: avoid strcpy
      diff: avoid fixed-size buffer for patch-ids
      tag: use strbuf to format tag header
      fetch: use heap buffer to format reflog
      avoid using fixed PATH_MAX buffers for refs
      avoid using mksnpath for refs
      create_branch: move msg setup closer to point of use
      create_branch: use xstrfmt for reflog message
      name-rev: replace static buffer with strbuf
      receive-pack: print --pack-header directly into argv array
      replace unchecked snprintf calls with heap buffers
      combine-diff: replace malloc/snprintf with xstrfmt
      convert unchecked snprintf into xsnprintf
      transport-helper: replace checked snprintf with xsnprintf
      gc: replace local buffer with git_path
      daemon: use an argv_array to exec children
      sha1_loose_object_info: return error for corrupted objects
      index-pack: detect local corruption in collision check
      connect.c: handle errors from split_cmdline
      receive-pack: drop tmp_objdir_env from run_update_hook
      receive-pack: document user-visible quarantine effects
      refs: reject ref updates while GIT_QUARANTINE_PATH is set
      bisect: add git_path_bisect_terms helper
      branch: add edit_description() helper
      use git_path_* helper functions
      replace xstrdup(git_path(...)) with git_pathdup(...)
      replace strbuf_addstr(git_path()) with git_path_buf()
      am: drop "dir" parameter from am_state_init
      connect.c: fix leak in handle_ssh_variant
      doc: use https links to avoid http redirect
      doc: replace or.cz gitwiki link with git.wiki.kernel.org
      gitcore-tutorial: update broken link
      docs/archimport: quote sourcecontrol.net reference
      docs/bisect-lk2009: update nist report link
      docs/bisect-lk2009: update java code conventions link
      completion: optionally disable checkout DWIM
      submodule_init: die cleanly on submodules without url defined
      prio_queue_reverse: don't swap elements with themselves

Johan Hovold (1):
      send-email: only allow one address per body tag

Johannes Schindelin (23):
      git_connect(): factor out SSH variant handling
      rebase--helper: add a builtin helper for interactive rebases
      rebase -i: use the rebase--helper builtin
      rev-parse: fix several options when running in a subdirectory
      t7006: replace dubious test
      Travis: also test on 32-bit Linux
      setup_git_directory(): use is_dir_sep() helper
      t1501: demonstrate NULL pointer access with invalid GIT_WORK_TREE
      real_pathdup(): fix callsites that wanted it to die on error
      setup: prepare setup_discovered_git_dir() for the root directory
      setup_git_directory_1(): avoid changing global state
      setup: introduce the discover_git_directory() function
      setup: make read_early_config() reusable
      read_early_config(): avoid .git/config hack when unneeded
      read_early_config(): really discover .git/
      t1309: test read_early_config()
      setup_git_directory_gently_1(): avoid die()ing
      t1309: document cases where we would want early config not to die()
      setup.c: mention unresolved problems
      t7504: document regression: reword no longer calls commit-msg
      sequencer: make commit options more extensible
      sequencer: allow the commit-msg hooks to run during a `reword`
      difftool: fix use-after-free

Jonathan Nieder (2):
      remote helpers: avoid blind fall-back to ".git" when setting GIT_DIR
      has_sha1_file: don't bother if we are not in a repository

Jonathan Tan (5):
      grep: do not unnecessarily query repo for "--"
      upload-pack: report "not our ref" to client
      http: attempt updating base URL only if no error
      t/perf: export variable used in other blocks
      fetch-pack: show clearer error message upon ERR

Junio C Hamano (56):
      merge: drop 'git merge <message> HEAD <commit>' syntax
      connect: rename tortoiseplink and putty variables
      commit.c: use strchrnul() to scan for one line
      attr.c: use strchrnul() to scan for one line
      attr.c: update a stale comment on "struct match_attr"
      attr.c: explain the lack of attr-name syntax check in parse_attr()
      attr.c: complete a sentence in a comment
      attr.c: mark where #if DEBUG ends more clearly
      attr.c: simplify macroexpand_one()
      attr.c: tighten constness around "git_attr" structure
      attr.c: plug small leak in parse_attr_line()
      attr.c: add push_stack() helper
      attr.c: outline the future plans by heavily commenting
      attr: rename function and struct related to checking attributes
      attr: (re)introduce git_check_attr() and struct attr_check
      attr: convert git_all_attrs() to use "struct attr_check"
      attr: convert git_check_attrs() callers to use the new API
      attr: retire git_check_attrs() API
      attr: change validity check for attribute names to use positive logic
      ref-filter: resurrect "strip" as a synonym to "lstrip"
      connect.c: stop conflating ssh command names and overrides
      config: move a few helper functions up
      config: use git_config_parse_key() in git_config_parse_parameter()
      First batch after 2.12
      diff: do not short-cut CHECK_SIZE_ONLY check in diff_populate_filespec()
      branch: honor --abbrev/--no-abbrev in --list mode
      Second batch after 2.12
      Third batch after 2.12
      Fourth batch after 2.12
      Preparing for 2.12.1
      Makefile: make DC_SHA1 the default
      Fifth batch for 2.13
      Git 2.12.1
      Prepare for 2.12.2
      Sixth batch for 2.13
      t5615: fix a here-doc syntax error
      t7406: correct test case for submodule-update initial population
      tests: lint for run-away here-doc
      branch doc: update description for `--list`
      Git 2.12.2
      Seventh batch for 2.13
      sha1dc: avoid CPP macro collisions
      Eighth batch for 2.13
      Prepare for 2.12.3
      Ninth batch for 2.13
      Tenth batch for 2.13
      remote.[ch]: parse_push_cas_option() can be static
      contrib/git-resurrect.sh: do not write \t for HT in sed scripts
      Eleventh batch for 2.13
      Twelfth batch for 2.13
      replace: plug a memory leak
      Git 2.13-rc0
      Getting ready for -rc1
      Git 2.13-rc1
      Merging a handful of topics before -rc2
      Git 2.13-rc2

Karthik Nayak (20):
      ref-filter: implement %(if), %(then), and %(else) atoms
      ref-filter: include reference to 'used_atom' within 'atom_value'
      ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
      ref-filter: modify "%(objectname:short)" to take length
      ref-filter: move get_head_description() from branch.c
      ref-filter: introduce format_ref_array_item()
      ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
      ref-filter: add support for %(upstream:track,nobracket)
      ref-filter: make "%(symref)" atom work with the ':short' modifier
      ref-filter: introduce refname_atom_parser_internal()
      ref-filter: introduce refname_atom_parser()
      ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
      ref-filter: rename the 'strip' option to 'lstrip'
      ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
      ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
      ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
      ref-filter: allow porcelain to translate messages in the output
      branch, tag: use porcelain output
      branch: use ref-filter printing APIs
      branch: implement '--format' option

Kevin Willford (2):
      name-hash: fix buffer overrun
      t3008: skip lazy-init test on a single-core box

Kyle Meyer (12):
      delete_ref: accept a reflog message argument
      update-ref: pass reflog message to delete_ref()
      rename_ref: replace empty message in HEAD's log
      branch: record creation of renamed branch in HEAD's log
      t1400: rename test descriptions to be unique
      t1400: set core.logAllRefUpdates in "logged by touch" tests
      t1400: use test_path_is_* helpers
      t1400: remove a set of unused output files
      t1400: use test_when_finished for cleanup
      doc/config: grammar fixes for core.{editor,commentChar}
      doc/revisions: remove brackets from rev^-n shorthand
      t1400: use consistent style for test_expect_success calls

Lars Schneider (4):
      travis-ci: build and test Git on Windows
      travis-ci: add static analysis build job to run coccicheck
      travis-ci: printf $STATUS as string
      travis-ci: set DEVELOPER knob for Linux32 build

Linus Torvalds (3):
      pathspec magic: add '^' as alias for '!'
      pathspec: don't error out on all-exclusionary pathspec patterns
      mailinfo: fix in-body header continuations

Luke Diamand (3):
      git-p4: add failing test for name-rev rather than symbolic-ref
      git-p4: add read_pipe_text() internal function
      git-p4: don't use name-rev to get current branch

Matt McCutchen (4):
      merge-recursive: make "CONFLICT (rename/delete)" message show both paths
      fetch-pack: move code to report unmatched refs to a function
      fetch_refs_via_pack: call report_unmatched_refs
      fetch-pack: add specific error for fetching an unadvertised object

Maxim Moseychuk (2):
      stop_progress_msg: convert xsnprintf to xstrfmt
      bisect_next_all: convert xsnprintf to xstrfmt

Michael Haggerty (52):
      files_rename_ref(): tidy up whitespace
      refname_is_safe(): correct docstring
      t5505: use "for-each-ref" to test for the non-existence of references
      safe_create_leading_directories_const(): preserve errno
      safe_create_leading_directories(): set errno on SCLD_EXISTS
      raceproof_create_file(): new function
      lock_ref_sha1_basic(): inline constant
      lock_ref_sha1_basic(): use raceproof_create_file()
      rename_tmp_log(): use raceproof_create_file()
      rename_tmp_log(): improve error reporting
      log_ref_write(): inline function
      log_ref_setup(): separate code for create vs non-create
      log_ref_setup(): improve robustness against races
      log_ref_setup(): pass the open file descriptor back to the caller
      log_ref_write_1(): don't depend on logfile argument
      log_ref_setup(): manage the name of the reflog file internally
      log_ref_write_1(): inline function
      delete_ref_loose(): derive loose reference path from lock
      delete_ref_loose(): inline function
      try_remove_empty_parents(): rename parameter "name" -> "refname"
      try_remove_empty_parents(): don't trash argument contents
      try_remove_empty_parents(): teach to remove parents of reflogs, too
      files_transaction_commit(): clean up empty directories
      refs: reorder some function definitions
      refs: make some ref_store lookup functions private
      refs: remove some unnecessary handling of submodule == ""
      register_ref_store(): new function
      refs: store submodule ref stores in a hashmap
      refs: push the submodule attribute down
      base_ref_store_init(): remove submodule argument
      files_ref_store::submodule: use NULL for the main repository
      read_loose_refs(): read refs using resolve_ref_recursively()
      get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
      refs_read_raw_ref(): new function
      refs_ref_iterator_begin(): new function
      refs_verify_refname_available(): implement once for all backends
      refs_verify_refname_available(): use function in more places
      ref-cache: rename `add_ref()` to `add_ref_entry()`
      ref-cache: rename `find_ref()` to `find_ref_entry()`
      ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
      refs: split `ref_cache` code into separate files
      ref-cache: introduce a new type, ref_cache
      refs: record the ref_store in ref_cache, not ref_dir
      ref-cache: use a callback function to fill the cache
      refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
      do_for_each_entry_in_dir(): eliminate `offset` argument
      get_loose_ref_dir(): function renamed from get_loose_refs()
      get_loose_ref_cache(): new function
      cache_ref_iterator_begin(): make function smarter
      commit_packed_refs(): use reference iteration
      files_pack_refs(): use reference iteration
      do_for_each_entry_in_dir(): delete function

Michael J Gruber (5):
      git-status: make porcelain more robust
      git-prompt: add a describe style for any tags
      mailmap: use Michael J Gruber's new address
      describe: localize debug output fully
      l10n: de: translate describe debug terms

Michael Rappazzo (1):
      rev-parse tests: add tests executed from a subdirectory

Mike Hommey (1):
      notes: do not break note_tree structure in note_tree_consolidate()

Mostyn Bramley-Moore (1):
      Documentation: document elements in "ls-files -s" output in order

Nguyễn Thái Ngọc Duy (40):
      attr: support quoting pathname patterns in C style
      clean: use warning_errno() when appropriate
      config.txt: clarify multiple key values in include.path
      config.txt: reflow the second include.path paragraph
      config: add conditional include
      refs.h: add forward declaration for structs used in this file
      git-commit.txt: list post-rewrite in HOOKS section
      files-backend: make files_log_ref_write() static
      files-backend.c: delete dead code in files_ref_iterator_begin()
      files-backend: delete dead code in files_init_db()
      files-backend: add and use files_packed_refs_path()
      files-backend: make sure files_rename_ref() always reach the end
      files-backend: convert git_path() to strbuf_git_path()
      files-backend: move "logs/" out of TMP_RENAMED_LOG
      files-backend: add and use files_reflog_path()
      files-backend: add and use files_ref_path()
      files-backend: remove the use of git_path()
      refs.c: introduce get_main_ref_store()
      refs: rename lookup_ref_store() to lookup_submodule_ref_store()
      refs.c: flatten get_ref_store() a bit
      refs.c: kill register_ref_store(), add register_submodule_ref_store()
      refs.c: make get_main_ref_store() public and use it
      path.c: move some code out of strbuf_git_path_submodule()
      refs: move submodule code out of files-backend.c
      files-backend: replace submodule_allowed check in files_downcast()
      refs: rename get_ref_store() to get_submodule_ref_store() and make it public
      refs: add new ref-store api
      refs: new transaction related ref-store api
      files-backend: avoid ref api targeting main ref store
      refs: delete pack_refs() in favor of refs_pack_refs()
      t/helper: add test-ref-store to test ref-store functions
      t1405: some basic tests on main ref store
      t1406: new tests for submodule ref store
      refs.h: add a note about sorting order of for_each_ref_*
      path.c: and an option to call real_path() in expand_user_path()
      config: resolve symlinks in conditional include's patterns
      config: prepare to pass more info in git_config_with_options()
      config: handle conditional include when $GIT_DIR is not set up
      config: correct file reading order in read_early_config()
      worktree add: add --lock option

Patrick Steinhardt (8):
      mailmap: add Patrick Steinhardt's work address
      urlmatch: enable normalization of URLs with globs
      urlmatch: split host and port fields in `struct url_info`
      urlmatch: include host in urlmatch ranking
      urlmatch: allow globbing for the URL host part
      docs/diffcore: fix grammar in diffcore-rename header
      docs/diffcore: unquote "Complete Rewrites" in headers
      pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty prefix

Peter Krefting (1):
      i18n: read-cache: typofix

Prathamesh Chavan (1):
      t2027: avoid using pipes

Quentin Pradet (1):
      git-bisect.txt: add missing word

Ralf Thielow (2):
      submodule.c: add missing ' in error messages
      git-add--interactive.perl: add missing dot in a message

Ramsay Jones (3):
      wrapper.c: remove unused git_mkstemp() function
      wrapper.c: remove unused gitmkstemps() function
      name-hash: add test-lazy-init-name-hash to .gitignore

René Genz (3):
      doc: update SubmittingPatches
      fix minor typos
      doc: git-pull.txt use US spelling, fix minor typo

René Scharfe (18):
      sha1_file: release fallback base's memory in unpack_entry()
      cocci: use ALLOC_ARRAY
      strbuf: add strbuf_add_real_path()
      commit: be more precise when searching for headers
      commit: don't check for space twice when looking for header
      log-tree: factor out fmt_output_email_subject()
      pretty: use fmt_output_email_subject()
      blame: move blame_entry duplication to add_blame_entry()
      receive-pack: simplify run_update_post_hook()
      http-push: don't check return value of lookup_unknown_object()
      revision: remove declaration of path_name()
      shortlog: don't set after_subject to an empty string
      strbuf: support long paths w/o read rights in strbuf_getcwd() on FreeBSD
      test-read-cache: setup git dir
      am: close stream on error, but not stdin
      files_for_each_reflog_ent_reverse(): close stream and free strbuf on error
      server-info: avoid calling fclose(3) twice in update_info_file()
      use HOST_NAME_MAX to size buffers for gethostname(2)

Ross Lagerwall (1):
      remote: ignore failure to remove missing branch.<name>.merge

SZEDER Gábor (44):
      completion: improve __git_refs()'s in-code documentation
      completion tests: don't add test cruft to the test repository
      completion tests: make the $cur variable local to the test helper functions
      completion tests: consolidate getting path of current working directory
      completion tests: check __gitdir()'s output in the error cases
      completion tests: add tests for the __git_refs() helper function
      completion: ensure that the repository path given on the command line exists
      completion: fix most spots not respecting 'git --git-dir=<path>'
      completion: respect 'git --git-dir=<path>' when listing remote refs
      completion: list refs from remote when remote's name matches a directory
      completion: don't list 'HEAD' when trying refs completion outside of a repo
      completion: list short refs from a remote given as a URL
      completion: don't offer commands when 'git --opt' needs an argument
      completion: fix completion after 'git -C <path>'
      rev-parse: add '--absolute-git-dir' option
      completion: respect 'git -C <path>'
      completion: don't use __gitdir() for git commands
      completion: consolidate silencing errors from git commands
      completion: don't guard git executions with __gitdir()
      completion: extract repository discovery from __gitdir()
      completion: cache the path to the repository
      completion: restore removed line continuating backslash
      completion: remove redundant __gitcomp_nl() options from _git_commit()
      tests: create an interactive gdb session with the 'debug' helper
      tests: make the 'test_pause' helper work in non-verbose mode
      pickaxe: fix segfault with '-S<...> --pickaxe-regex'
      completion: wrap __git_refs() for better option parsing
      completion: support completing full refs after '--option=refs/<TAB>'
      completion: support completing fully qualified non-fast-forward refspecs
      completion: support excluding full refs
      completion: don't disambiguate tags and branches
      completion: don't disambiguate short refs
      completion: let 'for-each-ref' and 'ls-remote' filter matching refs
      completion: let 'for-each-ref' strip the remote name from remote branches
      completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
      completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
      completion: fill COMPREPLY directly when completing refs
      completion: fill COMPREPLY directly when completing fetch refspecs
      completion: speed up branch and tag completion
      refs.c: use skip_prefix() in prettify_refname()
      completion: put matching ctags symbol names directly into COMPREPLY
      completion: extract completing ctags symbol names into helper function
      completion: offer ctags symbol names for 'git log -S', '-G' and '-L:'
      t6500: wait for detached auto gc at the end of the test script

Santiago Torres (1):
      t7004, t7030: fix here-doc syntax errors

Sebastian Schuberth (5):
      contrib: git-remote-{bzr,hg} placeholders don't need Python
      sha1_file: remove an used fd variable
      submodule: remove a superfluous second check for the "new" variable
      gitmodules: clarify what history depth a shallow clone has
      gitmodules: clarify the ignore option values

Segev Finer (2):
      connect: handle putty/plink also in GIT_SSH_COMMAND
      connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config

Sergey Ryazanov (2):
      http: honor empty http.proxy option to bypass proxy
      http: fix the silent ignoring of proxy misconfiguraion

Simon Ruderich (1):
      githooks.txt: clarify push hooks are always executed in $GIT_DIR

Stefan Beller (36):
      Documentation: fix a typo
      refs: parse_hide_refs_config to use parse_config_key
      submodule init: warn about falling back to a local path
      rev-parse: add --show-superproject-working-tree
      submodule-config: correct error reporting for invalid ignore value
      connect_work_tree_and_git_dir: safely create leading directories
      lib-submodule-update.sh: reorder create_lib_submodule_repo
      lib-submodule-update.sh: do not use ./. as submodule remote
      lib-submodule-update: teach test_submodule_content the -C <dir> flag
      lib-submodule-update.sh: replace sha1 by hash
      lib-submodule-update.sh: define tests for recursing into submodules
      make is_submodule_populated gently
      update submodules: add submodule config parsing
      update submodules: add a config option to determine if submodules are updated
      submodules: introduce check to see whether to touch a submodule
      update submodules: move up prepare_submodule_repo_env
      submodule.c: get_super_prefix_or_empty
      update submodules: add submodule_move_head
      unpack-trees: pass old oid to verify_clean_submodule
      unpack-trees: check if we can perform the operation for submodules
      entry.c: create submodules when interesting
      builtin/checkout: add --recurse-submodules switch
      builtin/read-tree: add --recurse-submodules switch
      wt-status: simplify by using for_each_string_list_item
      t3600: rename test to describe its functionality
      builtin/describe: introduce --broken flag
      submodule.c: use argv_array in is_submodule_modified
      submodule.c: factor out early loop termination in is_submodule_modified
      submodule.c: convert is_submodule_modified to use strbuf_getwholeline
      submodule.c: port is_submodule_modified to use porcelain 2
      submodule.c: stricter checking for submodules in is_submodule_modified
      short status: improve reporting for submodule changes
      unpack-trees.c: align submodule error message to the other error messages
      submodule.c: correctly handle nested submodules in is_submodule_modified
      diff: submodule inline diff to initialize env array.
      submodule--helper: fix typo in is_active error message

Stephen Hicks (1):
      rebase -i: reread the todo list if `exec` touched it

Thomas Gummerer (9):
      stash: introduce push verb
      stash: add test for the create command line arguments
      stash: refactor stash_create
      stash: teach 'push' (and 'create_stash') to honor pathspec
      stash: use stash_push for no verb form
      stash: allow pathspecs in the no verb form
      stash: don't show internal implementation details
      stash: pass the pathspec argument to git reset
      stash: keep untracked files intact in stash -k

Torsten Bögershausen (1):
      gitattributes.txt: document how to normalize the line endings

Valery Tolstov (1):
      submodule--helper.c: remove duplicate code

Vegard Nossum (2):
      xdiff -W: relax end-of-file function detection
      line-log: use COPY_ARRAY to fix mis-sized memcpy

brian m. carlson (41):
      hex: introduce parse_oid_hex
      builtin/commit: convert to struct object_id
      builtin/diff-tree: convert to struct object_id
      builtin/describe: convert to struct object_id
      builtin/fast-export: convert to struct object_id
      builtin/fmt-merge-message: convert to struct object_id
      builtin/grep: convert to struct object_id
      builtin/branch: convert to struct object_id
      builtin/clone: convert to struct object_id
      builtin/merge: convert to struct object_id
      Convert remaining callers of resolve_refdup to object_id
      builtin/replace: convert to struct object_id
      reflog-walk: convert struct reflog_info to struct object_id
      refs: convert each_reflog_ent_fn to struct object_id
      refs: simplify parsing of reflog entries
      sha1_file: introduce an nth_packed_object_oid function
      Convert object iteration callbacks to struct object_id
      builtin/merge-base: convert to struct object_id
      wt-status: convert to struct object_id
      hash.h: move SHA-1 implementation selection into a header file
      Define new hash-size constants for allocating memory
      Convert GIT_SHA1_HEXSZ used for allocation to GIT_MAX_HEXSZ
      Convert GIT_SHA1_RAWSZ used for allocation to GIT_MAX_RAWSZ
      builtin/diff: convert to struct object_id
      builtin/pull: convert portions to struct object_id
      builtin/receive-pack: fix incorrect pointer arithmetic
      builtin/receive-pack: convert portions to struct object_id
      fsck: convert init_skiplist to struct object_id
      parse-options-cb: convert sha1_array_append caller to struct object_id
      test-sha1-array: convert most code to struct object_id
      sha1_name: convert struct disambiguate_state to object_id
      sha1_name: convert disambiguate_hint_fn to take object_id
      submodule: convert check_for_new_submodule_commits to object_id
      builtin/pull: convert to struct object_id
      sha1-array: convert internal storage for struct sha1_array to object_id
      Make sha1_array_append take a struct object_id *
      Convert remaining callers of sha1_array_lookup to object_id
      Convert sha1_array_lookup to take struct object_id
      Convert sha1_array_for_each_unique and for_each_abbrev to object_id
      Rename sha1_array to oid_array
      Documentation: update and rename api-sha1-array.txt

Ævar Arnfjörð Bjarmason (33):
      cvs tests: skip tests that call "cvs commit" when running as root
      gitweb tests: change confusing "skip_all" phrasing
      gitweb tests: skip tests when we don't have Time::HiRes
      doc: change erroneous --[no]-whatever into --[no-]whatever
      push: mention "push.default=tracking" in the documentation
      tag doc: move the description of --[no-]merged earlier
      tag doc: split up the --[no-]merged documentation
      tag doc: reword --[no-]merged to talk about commits, not tips
      ref-filter: make combining --merged & --no-merged an error
      doc/SubmittingPatches: clarify the casing convention for "area: change..."
      t/README: link to metacpan.org, not search.cpan.org
      t/README: change "Inside <X> part" to "Inside the <X> part"
      ref-filter: add test for --contains on a non-commit
      tag: remove a TODO item from the test suite
      tag tests: fix a typo in a test description
      for-each-ref: partly change <object> to <commit> in help
      branch doc: change `git branch <pattern>` to use `<branchname>`
      tag: add more incompatibles mode tests
      parse-options: add OPT_NONEG to the "contains" option
      tag: change misleading --list <pattern> documentation
      tag: implicitly supply --list given another list-like option
      tag: change --point-at to default to HEAD
      ref-filter: add --no-contains option to tag/branch/for-each-ref
      ref-filter: reflow recently changed branch/tag/for-each-ref docs
      tag: add tests for --with and --without
      t/README: clarify the test_have_prereq documentation
      doc/SubmittingPatches: show how to get a CLI commit summary
      rev-parse: match @{upstream}, @{u} and @{push} case-insensitively
      perl: regenerate perl.mak if perl -V changes
      grep: plug a trivial memory leak
      push: document & test --force-with-lease with multiple remotes
      completion: expand "push --delete <remote> <ref>" for refs on that <remote>
      t/perf: correctly align non-ASCII descriptions in output

