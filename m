Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B1E1FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 02:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbcICCRO (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 22:17:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64884 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751917AbcICCRK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 22:17:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AADAA3C2DD;
        Fri,  2 Sep 2016 22:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=U7W5s34l+pz0fkoiicfj/w4lP
        /8=; b=lEDmXENKewQS4ZeAE6rxVSEIqVC39VweyW1wDJi7IqbTSAtJ9+/y66nDz
        dxOZb3qRtQOi2g40jBKQ2unEGmIMeblt0iP2Ka4MUsM0q4uZHV/tm/kLmVysN+rU
        QE5Yjmp7HTwKvFXJN3nY0cy9Ww/HrC/NFaSH3VWO7kfbAn0s00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=bWME8Otg8m++aOCLa6o
        HEdVYutKyQ3bpogkqj8nS0eU3RPj4OlyvWAGtXkUAzS//bFrtJ6LhzJGU31LpdAg
        cnI9xRR5AfPlhC9KJs0hXyERqTJwRUe+VkKNI5dY25rs0WMSFuvWRtUGLvDQKlW+
        o40W0KJA2Xk92LgA9IIvAhMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2DC63C2DC;
        Fri,  2 Sep 2016 22:17:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C35723C2DB;
        Fri,  2 Sep 2016 22:17:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.10.0
Date:   Fri, 02 Sep 2016 19:17:05 -0700
Message-ID: <xmqqtwdxsp5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8389FEA0-717C-11E6-A4F3-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.10.0 is now available at the
usual places.  It is comprised of 639 non-merge commits since
v2.9.0, contributed by 76 people, 22 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.10.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.9.0 are as follows.
Welcome to the Git development community!

  Alexander Hirsch, Andreas Brauchli, Andrew Oakley, Antoine Queru,
  Ben Wijen, Christopher Layne, Dave Nicolson, David Glasser, Ed
  Maste, Heiko Becker, Ingo Br=C3=BCckl, Jonathan Tan, Jordan DE GEA,
  Josef Kufner, Keith McGuigan, Kevin Willford, LE Manh Cuong,
  Michael Stahl, Parker Moore, Peter Colberg, Tom Russello,
  and William Duclot.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alex Henrie, Alfred Perlstein, Armin Kunaschik, brian m. carlson,
  Changwoo Ryu, Charles Bailey, Chris Packham, Christian Couder,
  David A. Greene, David Aguilar, David Kastrup, David Turner,
  Edward Thomson, Elia Pinto, Eric Sunshine, Eric Wong, Heiko
  Voigt, Jacob Keller, Jean-Noel Avila, Jeff King, Jiang Xin,
  Joey Hess, Johannes Schindelin, Johannes Sixt, John Keeping,
  Jonathan Nieder, Josh Triplett, Junio C Hamano, Lars Schneider,
  Lars Vogel, Linus Torvalds, Lukas Fleischer, Matthieu Moy,
  Mehul Jain, Michael Haggerty, Michael J Gruber, Mike Hommey,
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Nicolas Pitre, Orgad Shaneh,=
 Patrick
  Steinhardt, Peter Krefting, Pranit Bauva, Ramsay Jones, Ren=C3=A9
  Scharfe, Ronald Wampler, Stefan Beller, SZEDER G=C3=A1bor, Thomas
  Braun, Thomas Gummerer, Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=
=8Dc
  Qu=C3=A2n, Vasco Almeida, and Ville Skytt=C3=A4.

----------------------------------------------------------------

Git 2.10 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

Updates since v2.9
------------------

UI, Workflows & Features

 * "git pull --rebase --verify-signature" learned to warn the user
   that "--verify-signature" is a no-op when rebasing.

 * An upstream project can make a recommendation to shallowly clone
   some submodules in the .gitmodules file it ships.

 * "git worktree add" learned that '-' can be used as a short-hand for
   "@{-1}", the previous branch.

 * Update the funcname definition to support css files.

 * The completion script (in contrib/) learned to complete "git
   status" options.

 * Messages that are generated by auto gc during "git push" on the
   receiving end are now passed back to the sending end in such a way
   that they are shown with "remote: " prefix to avoid confusing the
   users.

 * "git add -i/-p" learned to honor diff.compactionHeuristic
   experimental knob, so that the user can work on the same hunk split
   as "git diff" output.

 * "upload-pack" allows a custom "git pack-objects" replacement when
   responding to "fetch/clone" via the uploadpack.packObjectsHook.
   (merge b738396 jk/upload-pack-hook later to maint).

 * Teach format-patch and mailsplit (hence "am") how a line that
   happens to begin with "From " in the e-mail message is quoted with
   ">", so that these lines can be restored to their original shape.
   (merge d9925d1 ew/mboxrd-format-am later to maint).

 * "git repack" learned the "--keep-unreachable" option, which sends
   loose unreachable objects to a pack instead of leaving them loose.
   This helps heuristics based on the number of loose objects
   (e.g. "gc --auto").
   (merge e26a8c4 jk/repack-keep-unreachable later to maint).

 * "log --graph --format=3D" learned that "%>|(N)" specifies the width
   relative to the terminal's left edge, not relative to the area to
   draw text that is to the right of the ancestry-graph section.  It
   also now accepts negative N that means the column limit is relative
   to the right border.

 * A careless invocation of "git send-email directory/" after editing
   0001-change.patch with an editor often ends up sending both
   0001-change.patch and its backup file, 0001-change.patch~, causing
   embarrassment and a minor confusion.  Detect such an input and
   offer to skip the backup files when sending the patches out.
   (merge 531220b jc/send-email-skip-backup later to maint).

 * "git submodule update" that drives many "git clone" could
   eventually hit flaky servers/network conditions on one of the
   submodules; the command learned to retry the attempt.

 * The output coloring scheme learned two new attributes, italic and
   strike, in addition to existing bold, reverse, etc.

 * "git log" learns log.showSignature configuration variable, and a
   command line option "--no-show-signature" to countermand it.
   (merge fce04c3 mj/log-show-signature-conf later to maint).

 * More markings of messages for i18n, with updates to various tests
   to pass GETTEXT_POISON tests.

 * "git archive" learned to handle files that are larger than 8GB and
   commits far in the future than expressible by the traditional US-TAR
   format.
   (merge 560b0e8 jk/big-and-future-archive-tar later to maint).


 * A new configuration variable core.sshCommand has been added to
   specify what value for GIT_SSH_COMMAND to use per repository.

 * "git worktree prune" protected worktrees that are marked as
   "locked" by creating a file in a known location.  "git worktree"
   command learned a dedicated command pair to create and remove such
   a file, so that the users do not have to do this with editor.

 * A handful of "git svn" updates.

 * "git push" learned to accept and pass extra options to the
   receiving end so that hooks can read and react to them.

 * "git status" learned to suggest "merge --abort" during a conflicted
   merge, just like it already suggests "rebase --abort" during a
   conflicted rebase.

 * "git jump" script (in contrib/) has been updated a bit.
   (merge a91e692 jk/git-jump later to maint).

 * "git push" and "git clone" learned to give better progress meters
   to the end user who is waiting on the terminal.

 * An entry "git log --decorate" for the tip of the current branch is
   shown as "HEAD -> name" (where "name" is the name of the branch);
   the arrow is now painted in the same color as "HEAD", not in the
   color for commits.

 * "git format-patch" learned format.from configuration variable to
   specify the default settings for its "--from" option.

 * "git am -3" calls "git merge-recursive" when it needs to fall back
   to a three-way merge; this call has been turned into an internal
   subroutine call instead of spawning a separate subprocess.

 * The command line completion scripts (in contrib/) now knows about
   "git branch --delete/--move [--remote]".
   (merge 2703c22 vs/completion-branch-fully-spelled-d-m-r later to maint=
).

 * "git rev-parse --git-path hooks/<hook>" learned to take
   core.hooksPath configuration variable (introduced during 2.9 cycle)
   into account.
   (merge 9445b49 ab/hooks later to maint).

 * "git log --show-signature" and other commands that display the
   verification status of PGP signature now shows the longer key-id,
   as 32-bit key-id is so last century.


Performance, Internal Implementation, Development Support etc.

 * "git fast-import" learned the same performance trick to avoid
   creating too small a packfile as "git fetch" and "git push" have,
   using *.unpackLimit configuration.

 * When "git daemon" is run without --[init-]timeout specified, a
   connection from a client that silently goes offline can hang around
   for a long time, wasting resources.  The socket-level KEEPALIVE has
   been enabled to allow the OS to notice such failed connections.

 * "git upload-pack" command has been updated to use the parse-options
   API.

 * The "git apply" standalone program is being libified; the first
   step to move many state variables into a structure that can be
   explicitly (re)initialized to make the machinery callable more
   than once has been merged.

 * HTTP transport gained an option to produce more detailed debugging
   trace.
   (merge 73e57aa ep/http-curl-trace later to maint).

 * Instead of taking advantage of the fact that a struct string_list
   that is allocated with all NULs happens to be the INIT_NODUP kind,
   the users of string_list structures are taught to initialize them
   explicitly as such, to document their behaviour better.
   (merge 2721ce2 jk/string-list-static-init later to maint).

 * HTTPd tests learned to show the server error log to help diagnosing
   a failing tests.
   (merge 44f243d nd/test-lib-httpd-show-error-log-in-verbose later to ma=
int).

 * The ownership rule for the piece of memory that hold references to
   be fetched in "git fetch" was screwy, which has been cleaned up.

 * "git bisect" makes an internal call to "git diff-tree" when
   bisection finds the culprit, but this call did not initialize the
   data structure to pass to the diff-tree API correctly.

 * Further preparatory clean-up for "worktree" feature continues.
   (merge 0409e0b nd/worktree-cleanup-post-head-protection later to maint=
).

 * Formats of the various data (and how to validate them) where we use
   GPG signature have been documented.

 * A new run-command API function pipe_command() is introduced to
   sanely feed data to the standard input while capturing data from
   the standard output and the standard error of an external process,
   which is cumbersome to hand-roll correctly without deadlocking.

 * The codepath to sign data in a prepared buffer with GPG has been
   updated to use this API to read from the status-fd to check for
   errors (instead of relying on GPG's exit status).
   (merge efee955 jk/gpg-interface-cleanup later to maint).

 * Allow t/perf framework to use the features from the most recent
   version of Git even when testing an older installed version.

 * The commands in the "log/diff" family have had an FILE* pointer in the
   data structure they pass around for a long time, but some codepaths
   used to always write to the standard output.  As a preparatory step
   to make "git format-patch" available to the internal callers, these
   codepaths have been updated to consistently write into that FILE*
   instead.

 * Conversion from unsigned char sha1[20] to struct object_id
   continues.

 * Improve the look of the way "git fetch" reports what happened to
   each ref that was fetched.

 * The .c/.h sources are marked as such in our .gitattributes file so
   that "git diff -W" and friends would work better.

 * Code clean-up to avoid using a variable string that compilers may
   feel untrustable as printf-style format given to write_file()
   helper function.

 * "git p4" used a location outside $GIT_DIR/refs/ to place its
   temporary branches, which has been moved to refs/git-p4-tmp/.

 * Existing autoconf generated test for the need to link with pthread
   library did not check all the functions from pthread libraries;
   recent FreeBSD has some functions in libc but not others, and we
   mistakenly thought linking with libc is enough when it is not.

 * When "git fsck" reports a broken link (e.g. a tree object contains
   a blob that does not exist), both containing object and the object
   that is referred to were reported with their 40-hex object names.
   The command learned the "--name-objects" option to show the path to
   the containing object from existing refs (e.g. "HEAD~24^2:file.txt").

 * Allow http daemon tests in Travis CI tests.

 * Makefile assumed that -lrt is always available on platforms that
   want to use clock_gettime() and CLOCK_MONOTONIC, which is not a
   case for recent Mac OS X.  The necessary symbols are often found in
   libc on many modern systems and having -lrt on the command line, as
   long as the library exists, had no effect, but when the platform
   removes librt.a that is a different matter--having -lrt will break
   the linkage.

   This change could be seen as a regression for those who do need to
   specify -lrt, as they now specifically ask for NEEDS_LIBRT when
   building. Hopefully they are in the minority these days.

 * Further preparatory work on the refs API before the pluggable
   backend series can land.

 * Error handling in the codepaths that updates refs has been
   improved.

 * The API to iterate over all the refs (i.e. for_each_ref(), etc.)
   has been revamped.

 * The handling of the "text=3Dauto" attribute has been corrected.
   $ echo "* text=3Dauto eol=3Dcrlf" >.gitattributes
   used to have the same effect as
   $ echo "* text eol=3Dcrlf" >.gitattributes
   i.e. declaring all files are text (ignoring "auto").  The
   combination has been fixed to be equivalent to doing
   $ git config core.autocrlf true

 * Documentation has been updated to show better example usage
   of the updated "text=3Dauto" attribute.

 * A few tests that specifically target "git rebase -i" have been
   added.

 * Dumb http transport on the client side has been optimized.
   (merge ecba195 ew/http-walker later to maint).

 * Users of the parse_options_concat() API function need to allocate
   extra slots in advance and fill them with OPT_END() when they want
   to decide the set of supported options dynamically, which makes the
   code error-prone and hard to read.  This has been corrected by tweakin=
g
   the API to allocate and return a new copy of "struct option" array.

 * "git fetch" exchanges batched have/ack messages between the sender
   and the receiver, initially doubling every time and then falling
   back to enlarge the window size linearly.  The "smart http"
   transport, being an half-duplex protocol, outgrows the preset limit
   too quickly and becomes inefficient when interacting with a large
   repository.  The internal mechanism learned to grow the window size
   more aggressively when working with the "smart http" transport.

 * Tests for "git svn" have been taught to reuse the lib-httpd test
   infrastructure when testing the subversion integration that
   interacts with subversion repositories served over the http://
   protocol.
   (merge a8a5d25 ew/git-svn-http-tests later to maint).

 * "git pack-objects" has a few options that tell it not to pack
   objects found in certain packfiles, which require it to scan .idx
   files of all available packs.  The codepaths involved in these
   operations have been optimized for a common case of not having any
   non-local pack and/or any .kept pack.

 * The t3700 test about "add --chmod=3D-x" have been made a bit more
   robust and generally cleaned up.
   (merge 766cdc4 ib/t3700-add-chmod-x-updates later to maint).

 * The build procedure learned PAGER_ENV knob that lists what default
   environment variable settings to export for popular pagers.  This
   mechanism is used to tweak the default settings to MORE on FreeBSD.
   (merge 995bc22 ew/build-time-pager-tweaks later to maint).

 * The http-backend (the server-side component of smart-http
   transport) used to trickle the HTTP header one at a time.  Now
   these write(2)s are batched.
   (merge b36045c ew/http-backend-batch-headers later to maint).

 * When "git rebase" tries to compare set of changes on the updated
   upstream and our own branch, it computes patch-id for all of these
   changes and attempts to find matches. This has been optimized by
   lazily computing the full patch-id (which is expensive) to be
   compared only for changes that touch the same set of paths.
   (merge ba67504 kw/patch-ids-optim later to maint).

 * A handful of tests that were broken under gettext-poison build have
   been fixed.

 * The recent i18n patch we added during this cycle did a bit too much
   refactoring of the messages to avoid word-legos; the repetition has
   been reduced to help translators.


Also contains various documentation updates and code clean-ups.


Fixes since v2.9
----------------

Unless otherwise noted, all the fixes since v2.8 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * The commands in `git log` family take %C(auto) in a custom format
   string.  This unconditionally turned the color on, ignoring
   --no-color or with --color=3Dauto when the output is not connected to
   a tty; this was corrected to make the format truly behave as
   "auto".

 * "git rev-list --count" whose walk-length is limited with "-n"
   option did not work well with the counting optimized to look at the
   bitmap index.

 * "git show -W" (extend hunks to cover the entire function, delimited
   by lines that match the "funcname" pattern) used to show the entire
   file when a change added an entire function at the end of the file,
   which has been fixed.

 * The documentation set has been updated so that literal commands,
   configuration variables and environment variables are consistently
   typeset in fixed-width font and bold in manpages.

 * "git svn propset" subcommand that was added in 2.3 days is
   documented now.

 * The documentation tries to consistently spell "GPG"; when
   referring to the specific program name, "gpg" is used.

 * "git reflog" stopped upon seeing an entry that denotes a branch
   creation event (aka "unborn"), which made it appear as if the
   reflog was truncated.

 * The git-prompt scriptlet (in contrib/) was not friendly with those
   who uses "set -u", which has been fixed.

 * compat/regex code did not cleanly compile.

 * A codepath that used alloca(3) to place an unbounded amount of data
   on the stack has been updated to avoid doing so.

 * "git update-index --add --chmod=3D+x file" may be usable as an escape
   hatch, but not a friendly thing to force for people who do need to
   use it regularly.  "git add --chmod=3D+x file" can be used instead.

 * Build improvements for gnome-keyring (in contrib/)

 * "git status" used to say "working directory" when it meant "working
   tree".

 * Comments about misbehaving FreeBSD shells have been clarified with
   the version number (9.x and before are broken, newer ones are OK).

 * "git cherry-pick A" worked on an unborn branch, but "git
   cherry-pick A..B" didn't.

 * Fix an unintended regression in v2.9 that breaks "clone --depth"
   that recurses down to submodules by forcing the submodules to also
   be cloned shallowly, which many server instances that host upstream
   of the submodules are not prepared for.

 * Fix unnecessarily waste in the idiomatic use of ': ${VAR=3Ddefault}'
   to set the default value, without enclosing it in double quotes.

 * Some platform-specific code had non-ANSI strict declarations of C
   functions that do not take any parameters, which has been
   corrected.

 * The internal code used to show local timezone offset is not
   prepared to handle timestamps beyond year 2100, and gave a
   bogus offset value to the caller.  Use a more benign looking
   +0000 instead and let "git log" going in such a case, instead
   of aborting.

 * One among four invocations of readlink(1) in our test suite has
   been rewritten so that the test can run on systems without the
   command (others are in valgrind test framework and t9802).

 * t/perf needs /usr/bin/time with GNU extension; the invocation of it
   is updated to "gtime" on Darwin.

 * A bug, which caused "git p4" while running under verbose mode to
   report paths that are omitted due to branch prefix incorrectly, has
   been fixed; the command said "Ignoring file outside of prefix" for
   paths that are _inside_.

 * The top level documentation "git help git" still pointed at the
   documentation set hosted at now-defunct google-code repository.
   Update it to point to https://git.github.io/htmldocs/git.html
   instead.

 * A helper function that takes the contents of a commit object and
   finds its subject line did not ignore leading blank lines, as is
   commonly done by other codepaths.  Make it ignore leading blank
   lines to match.

 * For a long time, we carried an in-code comment that said our
   colored output would work only when we use fprintf/fputs on
   Windows, which no longer is the case for the past few years.

 * "gc.autoPackLimit" when set to 1 should not trigger a repacking
   when there is only one pack, but the code counted poorly and did
   so.

 * Add a test to specify the desired behaviour that currently is not
   available in "git rebase -Xsubtree=3D...".

 * More mark-up updates to typeset strings that are expected to
   literally typed by the end user in fixed-width font.

 * "git commit --amend --allow-empty-message -S" for a commit without
   any message body could have misidentified where the header of the
   commit object ends.

 * "git rebase -i --autostash" did not restore the auto-stashed change
   when the operation was aborted.

 * Git does not know what the contents in the index should be for a
   path added with "git add -N" yet, so "git grep --cached" should not
   show hits (or show lack of hits, with -L) in such a path, but that
   logic does not apply to "git grep", i.e. searching in the working
   tree files.  But we did so by mistake, which has been corrected.

 * "git blame -M" missed a single line that was moved within the file.

 * Fix recently introduced codepaths that are involved in parallel
   submodule operations, which gave up on reading too early, and
   could have wasted CPU while attempting to write under a corner
   case condition.

 * "git grep -i" has been taught to fold case in non-ascii locales
   correctly.

 * A test that unconditionally used "mktemp" learned that the command
   is not necessarily available everywhere.

 * There are certain house-keeping tasks that need to be performed at
   the very beginning of any Git program, and programs that are not
   built-in commands had to do them exactly the same way as "git"
   potty does.  It was easy to make mistakes in one-off standalone
   programs (like test helpers).  A common "main()" function that
   calls cmd_main() of individual program has been introduced to
   make it harder to make mistakes.
   (merge de61ceb jk/common-main later to maint).

 * The test framework learned a new helper test_match_signal to
   check an exit code from getting killed by an expected signal.

 * General code clean-up around a helper function to write a
   single-liner to a file.
   (merge 7eb6e10 jk/write-file later to maint).

 * One part of "git am" had an oddball helper function that called
   stuff from outside "his" as opposed to calling what we have "ours",
   which was not gender-neutral and also inconsistent with the rest of
   the system where outside stuff is usuall called "theirs" in
   contrast to "ours".

 * "git blame file" allowed the lineage of lines in the uncommitted,
   unadded contents of "file" to be inspected, but it refused when
   "file" did not appear in the current commit.  When "file" was
   created by renaming an existing file (but the change has not been
   committed), this restriction was unnecessarily tight.

 * "git add -N dir/file && git write-tree" produced an incorrect tree
   when there are other paths in the same directory that sorts after
   "file".

 * "git fetch http://user:pass@host/repo..." scrubbed the userinfo
   part, but "git push" didn't.

 * "git merge" with renormalization did not work well with
   merge-recursive, due to "safer crlf" conversion kicking in when it
   shouldn't.
   (merge 1335d76 jc/renormalize-merge-kill-safer-crlf later to maint).

 * The use of strbuf in "git rm" to build filename to remove was a bit
   suboptimal, which has been fixed.

 * An age old bug that caused "git diff --ignore-space-at-eol"
   misbehave has been fixed.

 * "git notes merge" had a code to see if a path exists (and fails if
   it does) and then open the path for writing (when it doesn't).
   Replace it with open with O_EXCL.

 * "git pack-objects" and "git index-pack" mostly operate with off_t
   when talking about the offset of objects in a packfile, but there
   were a handful of places that used "unsigned long" to hold that
   value, leading to an unintended truncation.

 * Recent update to "git daemon" tries to enable the socket-level
   KEEPALIVE, but when it is spawned via inetd, the standard input
   file descriptor may not necessarily be connected to a socket.
   Suppress an ENOTSOCK error from setsockopt().

 * Recent FreeBSD stopped making perl available at /usr/bin/perl;
   switch the default the built-in path to /usr/local/bin/perl on not
   too ancient FreeBSD releases.

 * "git commit --help" said "--no-verify" is only about skipping the
   pre-commit hook, and failed to say that it also skipped the
   commit-msg hook.

 * "git merge" in Git v2.9 was taught to forbid merging an unrelated
   lines of history by default, but that is exactly the kind of thing
   the "--rejoin" mode of "git subtree" (in contrib/) wants to do.
   "git subtree" has been taught to use the "--allow-unrelated-histories"
   option to override the default.

 * The build procedure for "git persistent-https" helper (in contrib/)
   has been updated so that it can be built with more recent versions
   of Go.

 * There is an optimization used in "git diff $treeA $treeB" to borrow
   an already checked-out copy in the working tree when it is known to
   be the same as the blob being compared, expecting that open/mmap of
   such a file is faster than reading it from the object store, which
   involves inflating and applying delta.  This however kicked in even
   when the checked-out copy needs to go through the convert-to-git
   conversion (including the clean filter), which defeats the whole
   point of the optimization.  The optimization has been disabled when
   the conversion is necessary.

 * "git -c grep.patternType=3Dextended log --basic-regexp" misbehaved
   because the internal API to access the grep machinery was not
   designed well.

 * Windows port was failing some tests in t4130, due to the lack of
   inum in the returned values by its lstat(2) emulation.

 * The reflog output format is documented better, and a new format
   --date=3Dunix to report the seconds-since-epoch (without timezone)
   has been added.
   (merge 442f6fd jk/reflog-date later to maint).

 * "git difftool <paths>..." started in a subdirectory failed to
   interpret the paths relative to that directory, which has been
   fixed.

 * The characters in the label shown for tags/refs for commits in
   "gitweb" output are now properly escaped for proper HTML output.

 * FreeBSD can lie when asked mtime of a directory, which made the
   untracked cache code to fall back to a slow-path, which in turn
   caused tests in t7063 to fail because it wanted to verify the
   behaviour of the fast-path.

 * Squelch compiler warnings for nedmalloc (in compat/) library.

 * A small memory leak in the command line parsing of "git blame"
   has been plugged.

 * The API documentation for hashmap was unclear if hashmap_entry
   can be safely discarded without any other consideration.  State
   that it is safe to do so.

 * Not-so-recent rewrite of "git am" that started making internal
   calls into the commit machinery had an unintended regression, in
   that no matter how many seconds it took to apply many patches, the
   resulting committer timestamp for the resulting commits were all
   the same.

 * "git push --force-with-lease" already had enough logic to allow
   ensuring that such a push results in creation of a ref (i.e. the
   receiving end did not have another push from sideways that would be
   discarded by our force-pushing), but didn't expose this possibility
   to the users.  It does so now.
   (merge 9eed4f3 jk/push-force-with-lease-creation later to maint).

 * The mechanism to limit the pack window memory size, when packing is
   done using multiple threads (which is the default), is per-thread,
   but this was not documented clearly.
   (merge 954176c ms/document-pack-window-memory-is-per-thread later to m=
aint).

 * "import-tars" fast-import script (in contrib/) used to ignore a
   hardlink target and replaced it with an empty file, which has been
   corrected to record the same blob as the other file the hardlink is
   shared with.
   (merge 04e0869 js/import-tars-hardlinks later to maint).

 * "git mv dir non-existing-dir/" did not work in some environments
   the same way as existing mainstream platforms.  The code now moves
   "dir" to "non-existing-dir", without relying on rename("A", "B/")
   that strips the trailing slash of '/'.
   (merge 189d035 js/mv-dir-to-new-directory later to maint).

 * The "t/" hierarchy is prone to get an unusual pathname; "make test"
   has been taught to make sure they do not contain paths that cannot
   be checked out on Windows (and the mechanism can be reusable to
   catch pathnames that are not portable to other platforms as need
   arises).
   (merge c2cafd3 js/test-lint-pathname later to maint).

 * When "git merge-recursive" works on history with many criss-cross
   merges in "verbose" mode, the names the command assigns to the
   virtual merge bases could have overwritten each other by unintended
   reuse of the same piece of memory.
   (merge 5447a76 rs/pull-signed-tag later to maint).

 * "git checkout --detach <branch>" used to give the same advice
   message as that is issued when "git checkout <tag>" (or anything
   that is not a branch name) is given, but asking with "--detach" is
   an explicit enough sign that the user knows what is going on.  The
   advice message has been squelched in this case.
   (merge 779b88a sb/checkout-explit-detach-no-advice later to maint).

 * "git difftool" by default ignores the error exit from the backend
   commands it spawns, because often they signal that they found
   differences by exiting with a non-zero status code just like "diff"
   does; the exit status codes 126 and above however are special in
   that they are used to signal that the command is not executable,
   does not exist, or killed by a signal.  "git difftool" has been
   taught to notice these exit status codes.
   (merge 45a4f5d jk/difftool-command-not-found later to maint).

 * On Windows, help.browser configuration variable used to be ignored,
   which has been corrected.
   (merge 6db5967 js/no-html-bypass-on-windows later to maint).

 * The "git -c var[=3Dval] cmd" facility to append a configuration
   variable definition at the end of the search order was described in
   git(1) manual page, but not in git-config(1), which was more likely
   place for people to look for when they ask "can I make a one-shot
   override, and if so how?"
   (merge ae1f709 dg/document-git-c-in-git-config-doc later to maint).

 * The tempfile (hence its user lockfile) API lets the caller to open
   a file descriptor to a temporary file, write into it and then
   finalize it by first closing the filehandle and then either
   removing or renaming the temporary file.  When the process spawns a
   subprocess after obtaining the file descriptor, and if the
   subprocess has not exited when the attempt to remove or rename is
   made, the last step fails on Windows, because the subprocess has
   the file descriptor still open.  Open tempfile with O_CLOEXEC flag
   to avoid this (on Windows, this is mapped to O_NOINHERIT).
   (merge 05d1ed6 bw/mingw-avoid-inheriting-fd-to-lockfile later to maint=
).

 * Correct an age-old calco (is that a typo-like word for calc)
   in the documentation.
   (merge 7841c48 ls/packet-line-protocol-doc-fix later to maint).

 * Other minor clean-ups and documentation updates
   (merge 02a8cfa rs/merge-add-strategies-simplification later to maint).
   (merge af4941d rs/merge-recursive-string-list-init later to maint).
   (merge 1eb47f1 rs/use-strbuf-add-unique-abbrev later to maint).
   (merge ddd0bfa jk/tighten-alloc later to maint).
   (merge ecf30b2 rs/mailinfo-lib later to maint).
   (merge 0eb75ce sg/reflog-past-root later to maint).
   (merge 4369523 hv/doc-commit-reference-style later to maint).

----------------------------------------------------------------

Changes since v2.9.0 are as follows:

Alex Henrie (2):
      unpack-trees: fix English grammar in do-this-before-that messages
      l10n: ca.po: update translation

Alexander Hirsch (1):
      pull: warn on --verify-signatures with --rebase

Alfred Perlstein (1):
      git-svn: document the 'git svn propset' command

Andreas Brauchli (1):
      gitweb: escape link body in format_ref_marker

Andrew Oakley (1):
      git-p4: correct hasBranchPrefix verbose output

Antoine Queru (1):
      upload-pack.c: use parse-options API

Armin Kunaschik (2):
      t7800: readlink may not be available
      t7610: test for mktemp before test execution

Ben Wijen (2):
      t6026-merge-attr: child processes must not inherit index.lock handl=
es
      mingw: ensure temporary file handles are not inherited by child pro=
cesses

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Charles Bailey (4):
      t7810: fix duplicated test title
      t7810-grep.sh: fix duplicated test name
      t7810-grep.sh: fix a whitespace inconsistency
      grep: fix grepping for "intent to add" files

Chris Packham (1):
      completion: add option '--recurse-submodules' to 'git clone'

Christian Couder (50):
      builtin/apply: make gitdiff_verify_name() return void
      builtin/apply: avoid parameter shadowing 'p_value' global
      builtin/apply: avoid parameter shadowing 'linenr' global
      builtin/apply: avoid local variable shadowing 'len' parameter
      builtin/apply: extract line_by_line_fuzzy_match() from match_fragme=
nt()
      builtin/apply: move 'options' variable into cmd_apply()
      builtin/apply: move 'read_stdin' global into cmd_apply()
      builtin/apply: introduce 'struct apply_state' to start libifying
      builtin/apply: move 'state' init into init_apply_state()
      builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
      builtin/apply: move 'check' global into 'struct apply_state'
      builtin/apply: move 'check_index' global into 'struct apply_state'
      builtin/apply: move 'apply_in_reverse' global into 'struct apply_st=
ate'
      builtin/apply: move 'apply_with_reject' global into 'struct apply_s=
tate'
      builtin/apply: move 'apply_verbosely' global into 'struct apply_sta=
te'
      builtin/apply: move 'update_index' global into 'struct apply_state'
      builtin/apply: move 'allow_overlap' global into 'struct apply_state=
'
      builtin/apply: move 'cached' global into 'struct apply_state'
      builtin/apply: move 'diffstat' global into 'struct apply_state'
      builtin/apply: move 'numstat' global into 'struct apply_state'
      builtin/apply: move 'summary' global into 'struct apply_state'
      builtin/apply: move 'threeway' global into 'struct apply_state'
      builtin/apply: move 'no_add' global into 'struct apply_state'
      builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
      builtin/apply: move 'line_termination' global into 'struct apply_st=
ate'
      builtin/apply: move 'fake_ancestor' global into 'struct apply_state=
'
      builtin/apply: move 'p_context' global into 'struct apply_state'
      builtin/apply: move 'apply' global into 'struct apply_state'
      builtin/apply: move 'patch_input_file' global into 'struct apply_st=
ate'
      builtin/apply: move 'limit_by_name' global into 'struct apply_state=
'
      builtin/apply: move 'has_include' global into 'struct apply_state'
      builtin/apply: move 'p_value' global into 'struct apply_state'
      builtin/apply: move 'p_value_known' global into 'struct apply_state=
'
      builtin/apply: move 'root' global into 'struct apply_state'
      builtin/apply: move 'whitespace_error' global into 'struct apply_st=
ate'
      builtin/apply: move 'whitespace_option' into 'struct apply_state'
      builtin/apply: remove whitespace_option arg from set_default_whites=
pace_mode()
      builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_=
state'
      builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_st=
ate'
      builtin/apply: move 'ws_error_action' into 'struct apply_state'
      builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
      builtin/apply: move 'max_change' and 'max_len' into 'struct apply_s=
tate'
      builtin/apply: move 'state_linenr' global into 'struct apply_state'
      builtin/apply: move 'fn_table' global into 'struct apply_state'
      builtin/apply: move 'symlink_changes' global into 'struct apply_sta=
te'
      builtin/apply: move 'state' check into check_apply_state()
      builtin/apply: move applying patches into apply_all_patches()
      builtin/apply: add 'lock_file' pointer into 'struct apply_state'
      builtin/apply: move 'newfd' global into 'struct apply_state'
      .mailmap: use Christian Couder's Tuxfamily address

Christopher Layne (1):
      git-svn: clone: Fail on missing url argument

Dave Nicolson (1):
      Documentation: GPG capitalization

David A. Greene (1):
      contrib/subtree: Add a test for subtree rebase that loses commits

David Aguilar (6):
      t7900-subtree.sh: fix quoting and broken && chains
      subtree: fix "git subtree split --rejoin"
      subtree: adjust style to match CodingGuidelines
      subtree: adjust function definitions to match CodingGuidelines
      difftool: avoid $GIT_DIR and $GIT_WORK_TREE
      difftool: use Git::* functions instead of passing around state

David Glasser (1):
      doc: mention `git -c` in git-config(1)

David Kastrup (1):
      blame: require 0 context lines while finding moved lines with -M

David Turner (3):
      refs: allow log-only updates
      refs: don't dereference on rename
      mailmap: use main email address for dturner

Ed Maste (1):
      rebase: update comment about FreeBSD /bin/sh

Edward Thomson (2):
      format_commit_message: honor `color=3Dauto` for `%C(auto)`
      add: add --chmod=3D+x / --chmod=3D-x options

Elia Pinto (2):
      http.c: implement the GIT_TRACE_CURL environment variable
      imap-send.c: introduce the GIT_TRACE_CURL enviroment variable

Eric Sunshine (1):
      blame: drop strdup of string literal

Eric Wong (24):
      fast-import: implement unpack limit
      daemon: enable SO_KEEPALIVE for all sockets
      fast-import: invalidate pack_id references after loosening
      pretty: support "mboxrd" output format
      mailsplit: support unescaping mboxrd messages
      am: support --patch-format=3Dmboxrd
      git-svn: skip mergeinfo handling with --no-follow-parent
      gc: fix off-by-one error with gc.autoPackLimit
      xread: retry after poll on EAGAIN/EWOULDBLOCK
      xwrite: poll on non-blocking FDs
      git-svn: warn instead of dying when commit data is missing
      hoist out handle_nonblock function for xread and xwrite
      config.mak.uname: define NEEDS_LIBRT under Linux, for now
      http-walker: remove unused parameter from fetch_object
      http: avoid disconnecting on 404s for loose objects
      http-walker: reduce O(n) ops with doubly-linked list
      list: avoid incompatibility with *BSD sys/queue.h
      daemon: ignore ENOTSOCK from setsockopt
      configure.ac: stronger test for pthread linkage
      git-svn: document svn.authorsProg in config
      git-svn: allow --version to work anywhere
      git svn: migrate tests to use lib-httpd
      pager: move pager-specific setup into the build
      http-backend: buffer headers before sending

Heiko Becker (1):
      gnome-keyring: Don't hard-code pkg-config executable

Heiko Voigt (4):
      submodule-config: passing name reference for .gitmodule blobs
      submodule-config: combine early return code into one goto
      submodule-config: fix test binary crashing when no arguments given
      SubmittingPatches: document how to reference previous commits

Ingo Br=C3=BCckl (3):
      t3700: remove unwanted leftover files before running new tests
      t3700: merge two tests into one
      t3700: add a test_mode_in_index helper function

Jacob Keller (1):
      completion: add completion for --submodule=3D* diff option

Jean-Noel Avila (4):
      i18n: fix typos for translation
      i18n: fix git rebase interactive commit messages
      i18n: simplify numeric error reporting
      l10n: fr.po v2.10.0-rc2

Jeff King (107):
      git_config_with_options: drop "found" counting
      git_config_parse_parameter: refactor cleanup code
      config: set up config_source for command-line config
      config: return configset value for current_config_ functions
      config: add a notion of "scope"
      upload-pack: provide a hook for running pack-objects
      rev-list: "adjust" results of "--count --use-bitmap-index -n"
      rev-list: disable bitmaps when "-n" is used with listing objects
      tree-diff: avoid alloca for large allocations
      send-pack: use buffered I/O to talk to pack-objects
      parse_opt_string_list: stop allocating new strings
      interpret-trailers: don't duplicate option strings
      blame,shortlog: don't make local option variables static
      use string_list initializer consistently
      fetch: document that pruning happens before fetching
      repack: document --unpack-unreachable option
      repack: add --keep-unreachable option
      repack: extend --keep-unreachable to loose objects
      add--interactive: respect diff.compactionHeuristic
      bisect: always call setup_revisions after init_revisions
      gpg-interface: use child_process.args
      verify_signed_buffer: drop pbuf variable
      verify_signed_buffer: use tempfile object
      run-command: add pipe_command helper
      verify_signed_buffer: use pipe_command
      sign_buffer: use pipe_command
      t0006: rename test-date's "show" to "relative"
      t0006: test various date formats
      local_tzoffset: detect errors from tm_to_time_t
      t/perf: fix regression in testing older versions of git
      p4211: explicitly disable renames in no-rename test
      color: fix max-size comment
      doc: refactor description of color format
      add skip_prefix_mem helper
      color: refactor parse_attr
      color: allow "no-" for negating attributes
      color: support "italic" attribute
      color: support strike-through attribute
      t9300: factor out portable "head -c" replacement
      t5000: test tar files that overflow ustar headers
      archive-tar: write extended headers for file sizes >=3D 8GB
      archive-tar: write extended headers for far-future mtime
      archive-tar: drop return value
      add an extra level of indirection to main()
      common-main: call git_extract_argv0_path()
      common-main: call sanitize_stdfds()
      common-main: call restore_sigpipe_to_default()
      common-main: call git_setup_gettext()
      tests: factor portable signal check out of t0005
      t0005: use test_match_signal as appropriate
      test_must_fail: use test_match_signal
      t/lib-git-daemon: use test_match_signal
      parse_options: allocate a new array when concatenating
      Makefile: drop extra dependencies for test helpers
      Makefile: use VCSSVN_LIB to refer to svn library
      config: fix bogus fd check when setting up default config
      branch: use non-gentle write_file for branch description
      write_file: drop "gently" form
      write_file: use xopen
      write_file: add pointer+len variant
      write_file: add format attribute
      use write_file_buf where applicable
      branch: use write_file_buf instead of write_file
      walker: let walker_say take arbitrary formats
      avoid using sha1_to_hex output as printf format
      push: anonymize URL in status output
      t0006: skip "far in the future" test when unsigned long is not long=
 enough
      check_everything_connected: always pass --quiet to rev-list
      rev-list: add optional progress reporting
      check_everything_connected: convert to argv_array
      check_everything_connected: use a struct with named options
      check_connected: relay errors to alternate descriptor
      check_connected: add progress flag
      clone: use a real progress meter for connectivity check
      index-pack: add flag for showing delta-resolution progress
      receive-pack: turn on index-pack resolving progress
      receive-pack: relay connectivity errors to sideband
      receive-pack: turn on connectivity progress
      receive-pack: send keepalives during quiet periods
      t5541: fix url scrubbing test when GPG is not set
      diff: do not reuse worktree files that need "clean" conversion
      contrib/git-jump: fix greedy regex when matching hunks
      contrib/git-jump: add whitespace-checking mode
      contrib/git-jump: fix typo in README
      doc/rev-list-options: clarify "commit@{Nth}" for "-g" option
      doc/rev-list-options: explain "-g" output formats
      doc/pretty-formats: describe index/time formats for %gd
      doc/pretty-formats: explain shortening of %gd
      t4205: drop top-level &&-chaining
      t4205: indent here documents
      date: document and test "raw-local" mode
      date: add "unix" format
      t/perf: add tests for many-pack scenarios
      sha1_file: drop free_pack_by_name
      add generic most-recently-used list
      find_pack_entry: replace last_found_pack with MRU cache
      pack-objects: break out of want_object loop early
      pack-objects: compute local/ignore_pack_keep early
      am: reset cached ident date for each patch
      trace: handle NULL argument in trace_disable()
      trace: stop using write_or_whine_pipe()
      trace: use warning() for printing trace errors
      trace: cosmetic fixes for error messages
      trace: correct variable name in write() error message
      trace: disable key after write error
      write_or_die: drop write_or_whine_pipe()
      trace: do not fall back to stderr

Jiang Xin (3):
      l10n: git.pot: v2.10.0 round 1 (248 new, 56 removed)
      l10n: git.pot: v2.10.0 round 2 (12 new, 44 removed)
      l10n: zh_CN: for git v2.10.0 l10n round 2

Joey Hess (1):
      clarify %f documentation

Johannes Schindelin (59):
      mingw: let the build succeed with DEVELOPER=3D1
      perf: accommodate for MacOSX
      pretty: make the skip_blank_lines() function public
      commit.c: make find_commit_subject() more robust
      t2300: "git --exec-path" is not usable in $PATH on Windows as-is
      log: prepare log/log-tree to reuse the diffopt.close_file attribute
      log-tree: respect diffopt's configured output file stream
      line-log: respect diffopt's configured output file stream
      graph: respect the diffopt.file setting
      shortlog: support outputting to streams other than stdout
      format-patch: explicitly switch off color when writing to files
      format-patch: avoid freopen()
      format-patch: use stdout directly
      shortlog: respect the --output=3D<file> setting
      t4211: ensure that log respects --output=3D<file>
      color.h: remove obsolete comment about limitations on Windows
      diff: do not color output when --color=3Dauto and --output=3D<file>=
 is given
      t3404: fix a grammo (commands are ran -> commands are run)
      commit -C: skip blank lines at the beginning of the message
      sequencer: use skip_blank_lines() to find the commit subject
      reset --hard: skip blank lines when reporting the commit subject
      commit -S: avoid invalid pointer with empty message
      mingw: declare main()'s argv as const
      t3404: add a test for the --gpg-sign option
      rebase -i: demonstrate a bug with --autosquash
      rebase -i: we allow extra spaces after fixup!/squash!
      am: counteract gender bias
      diff: demonstrate a bug with --patience and --ignore-space-at-eol
      diff: fix a double off-by-one with --ignore-space-at-eol
      t/test-lib.sh: fix running tests with --valgrind
      mingw: fix the shortlog --output=3D<file> test
      mingw: fix regression in t1308-config-set
      fsck: refactor how to describe objects
      fsck_walk(): optionally name objects on the go
      fsck: give the error function a chance to see the fsck_options
      fsck: optionally show more helpful info for broken links
      t5520: verify that `pull --rebase` shows the helpful advice when fa=
iling
      die("bug"): report bugs consistently
      die(_("BUG")): avoid translating bug messages
      merge-recursive: clarify code in was_tracked()
      prepare the builtins for a libified merge_recursive()
      merge_recursive: abort properly upon errors
      merge-recursive: avoid returning a wholesale struct
      merge-recursive: allow write_tree_from_memory() to error out
      merge-recursive: handle return values indicating errors
      merge-recursive: switch to returning errors instead of dying
      am -3: use merge_recursive() directly again
      merge-recursive: flush output buffer before printing error messages
      merge-recursive: write the commit title in one go
      merge-recursive: offer an option to retain the output in 'obuf'
      merge_trees(): ensure that the callers release output buffer
      merge-recursive: flush output buffer even when erroring out
      import-tars: support hard links
      t5533: make it pass on case-sensitive filesystems
      nedmalloc: fix misleading indentation
      git mv: do not keep slash in `git mv dir non-existing-dir/`
      t/Makefile: ensure that paths are valid on platforms we care
      rev-parse: respect core.hooksPath in --git-path
      Revert "display HTML in default browser using Windows' shell API"

Johannes Sixt (7):
      Windows: add missing definition of ENOTSOCK
      git-submodule: forward exit code of git-submodule--helper more fait=
hfully
      submodule-helper: fix indexing in clone retry error reporting path
      rebase-interactive: trim leading whitespace from progress count
      t4130: work around Windows limitation
      config.c: avoid duplicated global static variables
      commit-slab.h: avoid duplicated global static variables

John Keeping (5):
      difftool: fix argument handling in subdirs
      Documentation/git-push: fix placeholder formatting
      push: add shorthand for --force-with-lease branch creation
      push: allow pushing new branches with --force-with-lease
      difftool: always honor fatal error exit codes

Jonathan Nieder (1):
      doc: git-htmldocs.googlecode.com is no more

Jonathan Tan (1):
      fetch-pack: grow stateless RPC windows exponentially

Jordan DE GEA (1):
      worktree: allow "-" short-hand for @{-1} in add command

Josef Kufner (1):
      pretty: pass graph width to pretty formatting for use in '%>|(N)'

Josh Triplett (1):
      format-patch: format.from gives the default for --from

Junio C Hamano (44):
      send-email: detect and offer to skip backup files
      pathspec: rename free_pathspec() to clear_pathspec()
      t1308: do not get fooled by symbolic links to the source tree
      builtin/apply: remove misleading comment on lock_file field
      blame, line-log: do not loop around deref_tag()
      Start the post-2.9 cycle
      clone: do not let --depth imply --shallow-submodules
      Start preparing for 2.9.1
      Second batch of topics for 2.10
      More fixes for 2.9.1
      Third batch of topics for 2.10
      commit.c: remove print_commit_list()
      Fourth batch of topics for 2.10
      Git 2.9.1
      merge: avoid "safer crlf" during recording of merge results
      Fifth batch of topics for 2.10
      diff: document diff-filter exclusion
      Git 2.9.2
      archive-tar: huge offset and future timestamps would not work on 32=
-bit
      Sixth batch of topics for 2.10
      grep: further simplify setting the pattern type
      Seventh batch of topics for 2.10
      date: clarify --date=3Draw description
      Some fixes for 2.9.3
      t9100: portability fix
      Eighth batch of topics for 2.10
      hashmap: clarify that hashmap_entry can safely be discarded
      Ninth batch of topics for 2.10
      Tenth batch for 2.10
      Hopefully final batch for 2.9.3
      Eleventh batch for 2.10
      Yet another batch for 2.9.3
      Twelfth batch for 2.10
      Git 2.9.3
      Final batch before 2.10-rc0
      Git 2.10-rc0
      Relnotes: decribe the updates to the "text=3Dauto" attribute
      relnotes: redo the description of text=3Dauto fix
      RelNotes: final batch of topics before -rc1
      Git 2.10-rc1
      Prepare for 2.10.0-rc2
      Git 2.10-rc2
      A few more fixes before the final 2.10
      Git 2.10

Keith McGuigan (1):
      builtin/fetch.c: don't free remote->name after fetch

Kevin Willford (4):
      patch-ids: stop using a hand-rolled hashmap implementation
      patch-ids: replace the seen indicator with a commit pointer
      patch-ids: add flag to create the diff patch id using header only d=
ata
      rebase: avoid computing unnecessary patch IDs

LE Manh Cuong (1):
      sh-setup: enclose setting of ${VAR=3Ddefault} in double-quotes

Lars Schneider (3):
      git-p4: place temporary refs used for branch import under refs/git-=
p4-tmp
      travis-ci: enable web server tests t55xx on Linux
      pack-protocol: fix maximum pkt-line size

Lars Vogel (1):
      Use "working tree" instead of "working directory" for git status

Linus Torvalds (1):
      gpg-interface: prefer "long" key format output when verifying pgp s=
ignatures

Lukas Fleischer (4):
      receive-pack: send auto-gc output over sideband 2
      sideband.c: make send_sideband() return void
      upload-pack.c: make send_client_data() return void
      sideband.c: refactor recv_sideband()

Matthieu Moy (9):
      Documentation/git-mv.txt: fix whitespace indentation
      doc: typeset short command-line options as literal
      doc: typeset long command-line options as literal
      doc: typeset '--' as literal
      doc: typeset long options with argument as literal
      CodingGuidelines: formatting HEAD in documentation
      doc: typeset HEAD and variants as literal
      status: suggest 'git merge --abort' when appropriate
      git-multimail: update to release 1.4.0

Mehul Jain (3):
      t4202: refactor test
      log: add "--no-show-signature" command line option
      log: add log.showSignature configuration variable

Michael Haggerty (50):
      t1404: demonstrate a bug resolving references
      commit_ref(): if there is an empty dir in the way, delete it
      read_raw_ref(): don't get confused by an empty directory
      safe_create_leading_directories(): improve docstring
      remove_dir_recursively(): add docstring
      refname_is_safe(): use skip_prefix()
      refname_is_safe(): don't allow the empty string
      refname_is_safe(): insist that the refname already be normalized
      commit_ref_update(): write error message to *err, not stderr
      rename_ref(): remove unneeded local variable
      ref_transaction_commit(): remove local variables n and updates
      read_raw_ref(): rename flags argument to type
      read_raw_ref(): clear *type at start of function
      read_raw_ref(): rename symref argument to referent
      read_raw_ref(): improve docstring
      read_raw_ref(): move docstring to header file
      lock_ref_sha1_basic(): remove unneeded local variable
      refs: make error messages more consistent
      ref_transaction_create(): disallow recursive pruning
      ref_transaction_commit(): correctly report close_ref() failure
      delete_branches(): use resolve_refdup()
      verify_refname_available(): adjust constness in declaration
      add_update(): initialize the whole ref_update
      lock_ref_for_update(): new function
      unlock_ref(): move definition higher in the file
      ref_transaction_update(): check refname_is_safe() at a minimum
      refs: resolve symbolic refs first
      lock_ref_for_update(): don't re-read non-symbolic references
      lock_ref_for_update(): don't resolve symrefs
      commit_ref_update(): remove the flags parameter
      lock_ref_sha1_basic(): only handle REF_NODEREF mode
      refs: remove unnecessary "extern" keywords
      do_for_each_ref(): move docstring to the header file
      refs: use name "prefix" consistently
      delete_refs(): add a flags argument
      remote rm: handle symbolic refs correctly
      get_ref_cache(): only create an instance if there is a submodule
      entry_resolves_to_object(): rename function from ref_resolves_to_ob=
ject()
      ref_resolves_to_object(): new function
      refs: introduce an iterator interface
      do_for_each_ref(): reimplement using reference iteration
      for_each_reflog(): don't abort for bad references
      dir_iterator: new API for iterating over a directory tree
      for_each_reflog(): reimplement using iterators
      t1404: rename file to t1404-update-ref-errors.sh
      t1404: remove "prefix" argument to test_update_rejected
      t1404: document function test_update_rejected
      t1404: add more tests of update-ref error handling
      lock_ref_for_update(): make error handling more uniform
      lock_ref_for_update(): avoid a symref resolution

Michael J Gruber (7):
      cherry-pick: allow to pick to unborn branches
      Documentation/technical: describe signature formats
      Documentation/technical: signed tag format
      Documentation/technical: signed commit format
      Documentation/technical: signed merge tag format
      gpg-interface: check gpg signature creation status
      t/t91*: do not say how to avoid the tests

Michael Stahl (1):
      document git-repack interaction of pack.threads and pack.windowMemo=
ry

Mike Hommey (2):
      blame: allow to blame paths freshly added to the index
      t/t8003-blame-corner-cases.sh: Use here documents

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (47):
      completion: support git-worktree
      worktree.c: rewrite mark_current_worktree() to avoid strbuf
      git-worktree.txt: keep subcommand listing in alphabetical order
      worktree.c: use is_dot_or_dotdot()
      worktree: avoid 0{40}, too many zeroes, hard to read
      worktree: simplify prefixing paths
      worktree.c: add find_worktree()
      worktree.c: add is_main_worktree()
      lib-httpd.sh: print error.log on error
      worktree.c: add is_worktree_locked()
      pretty.c: support <direction>|(<negative number>) forms
      new-command.txt: correct the command description file
      grep: break down an "if" stmt in preparation for next changes
      test-regex: isolate the bug test code
      test-regex: expose full regcomp() to the command line
      grep/icase: avoid kwsset on literal non-ascii strings
      git-fetch.txt: document fetch output
      fetch: refactor ref update status formatting code
      fetch: change flag code for displaying tag update and deleted ref
      grep/icase: avoid kwsset when -F is specified
      grep: rewrite an if/else condition to avoid duplicate expression
      grep/pcre: prepare locale-dependent tables for icase matching
      gettext: add is_utf8_locale()
      grep/pcre: support utf-8
      diffcore-pickaxe: Add regcomp_or_die()
      diffcore-pickaxe: support case insensitive match on non-ascii
      grep.c: reuse "icase" variable
      fetch: align all "remote -> local" output
      fetch: reduce duplicate in ref update status lines with placeholder
      connect: read $GIT_SSH_COMMAND from config file
      worktree: add "lock" command
      worktree: add "unlock" command
      worktree.c: find_worktree() search by path suffix
      pack-objects: pass length to check_pack_crc() without truncation
      log: decorate HEAD -> branch with the same color for arrow and HEAD
      sha1_file.c: use type off_t* for object_info->disk_sizep
      index-pack: correct "len" type in unpack_data()
      index-pack: report correct bad object offsets even if they are larg=
e
      index-pack: correct "offset" type in unpack_entry_data()
      pack-objects: do not truncate result in-pack object size on 32-bit =
systems
      fsck: use streaming interface for large blobs in pack
      test-lib.sh: introduce and use $EMPTY_TREE
      test-lib.sh: introduce and use $EMPTY_BLOB
      cache-tree.c: fix i-t-a entry skipping directory updates sometimes
      cache-tree: do not generate empty trees as a result of all i-t-a su=
bentries
      config.mak.uname: correct perl path on FreeBSD
      t7063: work around FreeBSD's lazy mtime update feature

Nicolas Pitre (1):
      sideband.c: small optimization of strbuf usage

Orgad Shaneh (1):
      commit: describe that --no-verify skips the commit-msg hook in the =
help text

Parker Moore (2):
      contrib/persistent-https: update ldflags syntax for Go 1.7+
      contrib/persistent-https: use Git version for build label

Patrick Steinhardt (1):
      rebase -i: restore autostash on abort

Peter Colberg (2):
      refs.h: fix misspelt "occurred" in a comment
      config.c: fix misspelt "occurred" in an error message

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2757t0f0u)

Pranit Bauva (2):
      builtin/commit.c: memoize git-path for COMMIT_EDITMSG
      strbuf: describe the return value of strbuf_read_file

Ramsay Jones (2):
      regex: fix a SIZE_MAX macro redefinition warning
      write_or_die: remove the unused write_or_whine() function

Ren=C3=A9 Scharfe (34):
      t4051: rewrite, add more tests
      xdiff: factor out match_func_rec()
      xdiff: handle appended chunks better with -W
      xdiff: ignore empty lines before added functions with -W
      xdiff: -W: don't include common trailing empty lines in context
      xdiff: don't trim common tail with -W
      t7810: add test for grep -W and trailing empty context lines
      grep: -W: don't extend context to trailing empty lines
      xdiff: fix merging of appended hunk with -W
      .gitattributes: set file type for C files
      notes-merge: use O_EXCL to avoid overwriting existing files
      am: ignore return value of write_file()
      rm: reuse strbuf for all remove_dir_recursively() calls
      worktree: use strbuf_add_absolute_path() directly
      use strbuf_addbuf() for appending a strbuf to another
      submodule-config: use explicit empty string instead of strbuf in co=
nfig_from()
      strbuf: avoid calling strbuf_grow() twice in strbuf_addbuf()
      use strbuf_addstr() for adding constant strings to a strbuf
      pass constants as first argument to st_mult()
      use strbuf_addstr() instead of strbuf_addf() with "%s"
      use CHILD_PROCESS_INIT to initialize automatic variables
      merge-recursive: use STRING_LIST_INIT_NODUP
      merge: use string_list_split() in add_strategies()
      nedmalloc: work around overzealous GCC 6 warning
      archive-tar: make write_extended_header() void
      use strbuf_add_unique_abbrev() for adding short hashes
      correct FLEXPTR_* example in comment
      mailinfo: recycle strbuf in check_header()
      commit: use xstrdup() in get_merge_parent()
      commit: factor out set_merge_remote_desc()
      merge-recursive: fix verbose output for multiple base trees
      commit: use FLEX_ARRAY in struct merge_remote_desc
      receive-pack: use FLEX_ALLOC_MEM in queue_command()
      p3400: make test script executable

Ronald Wampler (1):
      Makefile: add NEEDS_LIBRT to optionally link with librt

SZEDER G=C3=A1bor (2):
      reflog: continue walking the reflog past root commits
      t1410: remove superfluous 'git reflog' from the 'walk past root' te=
st

Stefan Beller (23):
      submodule update: make use of the existing fetch_in_submodule funct=
ion
      submodule-config: keep shallow recommendation around
      submodule update: learn `--[no-]recommend-shallow` option
      submodule--helper: initial clone learns retry logic
      submodule update: continue when a clone fails
      t5614: don't use subshells
      push options: {pre,post}-receive hook learns about push options
      receive-pack: implement advertising and receiving push options
      push: accept push options
      add a test for push options
      Documentation: pack-protocol correct NAK response
      submodule deinit: remove outdated comment
      t7406: future proof tests with hard coded depth
      submodule update: respect depth in subsequent fetches
      submodule update: narrow scope of local variable
      submodule--helper: fix usage string for relative-path
      submodule-config: keep configured branch around
      gitmodules: document shallow recommendation
      submodule--helper: add remote-branch helper
      submodule update: allow '.' for branch value
      submodule--helper: use parallel processor correctly
      t7406: fix breakage on OSX
      checkout: do not mention detach advice for explicit --detach option

Thomas Braun (3):
      completion: factor out untracked file modes into a variable
      completion: add __git_get_option_value helper
      completion: add git status

Thomas Gummerer (1):
      blame: fix segfault on untracked files

Tom Russello (4):
      doc: clearer rule about formatting literals
      doc: change environment variables format
      doc: more consistency in environment variables format
      doc: change configuration variables format

Torsten B=C3=B6gershausen (4):
      convert: unify the "auto" handling of CRLF
      convert: Correct NNO tests and missing `LF will be replaced by CRLF=
`
      git ls-files: text=3Dauto eol=3Dlf is supported in Git 2.10
      gitattributes: Document the unified "auto" handling

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: Updated Vietnamese translation for v2.10.0 (2789t)
      l10n: Updated Vietnamese translation for v2.10.0-rc2 (2757t)

Vasco Almeida (49):
      i18n: builtin/remote.c: fix mark for translation
      i18n: advice: mark string about detached head for translation
      i18n: advice: internationalize message for conflicts
      i18n: transport: mark strings for translation
      i18n: sequencer: mark entire sentences for translation
      i18n: rebase-interactive: mark here-doc strings for translation
      i18n: sequencer: mark string for translation
      i18n: rebase-interactive: mark comments of squash for translation
      i18n: merge-octopus: mark messages for translation
      i18n: setup: mark strings for translation
      merge-octopus: use die shell function from git-sh-setup.sh
      tests: use test_i18n* functions to suppress false positives
      i18n: rebase: fix marked string to use eval_gettext variant
      tests: unpack-trees: update to use test_i18n* functions
      i18n: rebase: mark placeholder for translation
      t9003: become resilient to GETTEXT_POISON
      i18n: bisect: simplify error message for i18n
      t4153: fix negated test_i18ngrep call
      t6030: update to use test_i18ncmp
      t5523: use test_i18ngrep for negation
      i18n: git-sh-setup.sh: mark strings for translation
      i18n: bisect: mark strings for translation
      i18n: rebase-interactive: mark strings for translation
      i18n: transport-helper.c: change N_() call to _()
      i18n: notes: mark strings for translation
      i18n: notes: mark options for translation
      i18n: merge: mark messages for translation
      i18n: merge: change command option help to lowercase
      i18n: sequencer: add period to error message
      i18n: standardise messages
      i18n: remote: mark URL fallback text for translation
      i18n: remote: allow translations to reorder message
      i18n: init-db: join message pieces
      i18n: submodule: join strings marked for translation
      i18n: submodule: escape shell variables inside eval_gettext
      i18n: unmark die messages for translation
      i18n: branch: mark comment when editing branch description for tran=
slation
      t5541: become resilient to GETTEXT_POISON
      t5510: skip tests under GETTEXT_POISON build
      i18n: notes: mark comment for translation
      i18n: config: unfold error messages marked for translation
      i18n: setup: mark error messages for translation
      i18n: archive: mark errors for translation
      i18n: git-stash: mark messages for translation
      t3404: become resilient to GETTEXT_POISON
      t5520: become resilient to GETTEXT_POISON
      t7411: become resilient to GETTEXT_POISON
      l10n: pt_PT: merge git.pot
      l10n: pt_PT: update Portuguese translation

Ville Skytt=C3=A4 (3):
      git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha
      completion: complete --delete, --move, and --remotes for git branch
      Spelling fixes

William Duclot (1):
      userdiff: add built-in pattern for CSS

brian m. carlson (11):
      hex: add oid_to_hex_r()
      contrib/coccinelle: add basic Coccinelle transforms
      coccinelle: convert hashcpy() with null_sha1 to hashclr()
      coccinelle: apply object_id Coccinelle transformations
      diff: convert struct diff_filespec to struct object_id
      diff: rename struct diff_filespec's sha1_valid member
      merge-recursive: convert struct stage_data to use object_id
      merge-recursive: convert struct merge_file_info to object_id
      merge-recursive: convert leaf functions to use struct object_id
      merge-recursive: convert merge_recursive_generic() to object_id
      diff: convert prep_temp_blob() to struct object_id

