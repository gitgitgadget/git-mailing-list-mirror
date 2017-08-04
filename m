Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C662047F
	for <e@80x24.org>; Fri,  4 Aug 2017 16:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbdHDQye (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 12:54:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64206 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752786AbdHDQy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 12:54:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F32F99576;
        Fri,  4 Aug 2017 12:54:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mZpccnIEABmC/qkZJBRKoxGXp
        hs=; b=Nw5l9PFn9pVstXEvzFO/I3g2TR4o2Yd3miJUJcMOCW4QR4xLCiZW22IB2
        LSGGK9w0/vxV0CQUYzv1Lwrd8IXdhMBc1glBwHoh88dA3Av/Wdv4VOFgKdcagFzi
        DqEatyOnX7IOOPLhz4aYUYocHMOAqnEkBz85CFw9AwKjsMITWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=JFYVcgGQUhPOYrolf6d
        8kVSo3vVSmGsYxsGCpL0iTX9Q6WdSnqDIo09u/VaQwS/DJMr3wZ3cp8Ycs16LpOr
        exoI/eJgsC+Pd1Yd2h+9qCDshrsli/q0r7UU1YoRbLmYv9R1KisEO61Ddly66tJL
        dNT2uKa9G2QloszUlvJUk1MU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0583C99575;
        Fri,  4 Aug 2017 12:54:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 213C399574;
        Fri,  4 Aug 2017 12:54:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.14.0
Date:   Fri, 04 Aug 2017 09:54:18 -0700
Message-ID: <xmqqbmnvuvd1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F3DFEBA-7935-11E7-B6A0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.14.0 is now available at the
usual places.  It is comprised of 727 non-merge commits since
v2.13.0, contributed by 66 people, 18 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

when kernel.org mirrors catch up.

The following public repositories all have a copy of the 'v2.14.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.13.0 are as follows.
Welcome to the Git development community!

  Anthony Sottile, A. Wilcox, Ben Peart, Brian Malehorn, Hugues
  Peccatte, James Clarke, Jeff Smith, Kaartic Sivaraam, Liam
  Beguin, Louis, Phillip Wood, Rikard Falkeborn, Sahil Dua,
  Samuel Lijin, Stephen Kent, Sylvestre Ledru, Tyler Brazier,
  and xiaoqiang zhao.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alejandro R. Se=
de=C3=B1o,
  Alexander Shopov, Andreas Heiduk, Beat Bolli, Brandon Williams,
  brian m. carlson, Changwoo Ryu, Christian Couder, David Aguilar,
  David Turner, Dennis Kaarsemaker, Dimitriy Ryazantcev, Eric
  Wong, Hartmut Henkel, Jean-Noel Avila, Jeff Hostetler, Jeff
  King, Jiang Xin, Johannes Schindelin, Johannes Sixt, Jonathan
  Nieder, Jonathan Tan, Jordi Mas, Junio C Hamano, Kyle J. McKay,
  Kyle Meyer, Lars Schneider, Marc Branchaud, Michael Haggerty,
  Miguel Torroja, Mike Hommey, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy,=
 Patrick
  Steinhardt, Peter Krefting, Prathamesh Chavan, Ralf Thielow,
  Ramsay Jones, Ren=C3=A9 Scharfe, Stefan Beller, =C5=A0t=C4=9Bp=C3=A1n N=
=C4=9Bmec,
  Sven Strickroth, SZEDER G=C3=A1bor, Thomas Gummerer, Torsten
  B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n, and Ville Skytt=
=C3=A4.

----------------------------------------------------------------

Git 2.14 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility notes and other notable changes.

 * Use of an empty string as a pathspec element that is used for
   'everything matches' is still warned and Git asks users to use a
   more explicit '.' for that instead.  The hope is that existing
   users will not mind this change, and eventually the warning can be
   turned into a hard error, upgrading the deprecation into removal of
   this (mis)feature.  That is not scheduled to happen in the upcoming
   release (yet).

 * Git now avoids blindly falling back to ".git" when the setup
   sequence said we are _not_ in Git repository.  A corner case that
   happens to work right now may be broken by a call to die("BUG").
   We've tried hard to locate such cases and fixed them, but there
   might still be cases that need to be addressed--bug reports are
   greatly appreciated.

 * The experiment to improve the hunk-boundary selection of textual
   diff output has finished, and the "indent heuristics" has now
   become the default.

 * Git can now be built with PCRE v2 instead of v1 of the PCRE
   library. Replace USE_LIBPCRE=3DYesPlease with USE_LIBPCRE2=3DYesPlease
   in existing build scripts to build against the new version.  As the
   upstream PCRE maintainer has abandoned v1 maintenance for all but
   the most critical bug fixes, use of v2 is recommended.


Updates since v2.13
-------------------

UI, Workflows & Features

 * The colors in which "git status --short --branch" showed the names
   of the current branch and its remote-tracking branch are now
   configurable.

 * "git clone" learned the "--no-tags" option not to fetch all tags
   initially, and also set up the tagopt not to follow any tags in
   subsequent fetches.

 * "git archive --format=3Dzip" learned to use zip64 extension when
   necessary to go beyond the 4GB limit.

 * "git reset" learned "--recurse-submodules" option.

 * "git diff --submodule=3Ddiff" now recurses into nested submodules.

 * "git repack" learned to accept the --threads=3D<n> option and pass it
   to pack-objects.

 * "git send-email" learned to run sendemail-validate hook to inspect
   and reject a message before sending it out.

 * There is no good reason why "git fetch $there $sha1" should fail
   when the $sha1 names an object at the tip of an advertised ref,
   even when the other side hasn't enabled allowTipSHA1InWant.

 * The "[includeIf "gitdir:$dir"] path=3D..." mechanism introduced in
   2.13.0 would canonicalize the path of the gitdir being matched,
   and did not match e.g. "gitdir:~/work/*" against a repo in
   "~/work/main" if "~/work" was a symlink to "/mnt/storage/work".
   Now we match both the resolved canonical path and what "pwd" would
   show. The include will happen if either one matches.

 * The "indent" heuristics is now the default in "diff". The
   diff.indentHeuristic configuration variable can be set to "false"
   for those who do not want it.

 * Many commands learned to pay attention to submodule.recurse
   configuration.

 * The convention for a command line is to follow "git cmdname
   --options" with revisions followed by an optional "--"
   disambiguator and then finally pathspecs.  When "--" is not there,
   we make sure early ones are all interpretable as revs (and do not
   look like paths) and later ones are the other way around.  A
   pathspec with "magic" (e.g. ":/p/a/t/h" that matches p/a/t/h from
   the top-level of the working tree, no matter what subdirectory you
   are working from) are conservatively judged as "not a path", which
   required disambiguation more often.  The command line parser
   learned to say "it's a pathspec" a bit more often when the syntax
   looks like so.

 * Update "perl-compatible regular expression" support to enable JIT
   and also allow linking with the newer PCRE v2 library.

 * "filter-branch" learned a pseudo filter "--setup" that can be used
   to define common functions/variables that can be used by other
   filters.

 * Using "git add d/i/r" when d/i/r is the top of the working tree of
   a separate repository would create a gitlink in the index, which
   would appear as a not-quite-initialized submodule to others.  We
   learned to give warnings when this happens.

 * "git status" learned to optionally give how many stash entries there
   are in its output.

 * "git status" has long shown essentially the same message as "git
   commit"; the message it gives while preparing for the root commit,
   i.e. "Initial commit", was hard to understand for some new users.
   Now it says "No commits yet" to stress more on the current status
   (rather than the commit the user is preparing for, which is more in
   line with the focus of "git commit").

 * "git send-email" now has --batch-size and --relogin-delay options
    which can be used to overcome limitations on SMTP servers that
    restrict on how many of e-mails can be sent in a single session.

 * An old message shown in the commit log template was removed, as it
   has outlived its usefulness.

 * "git pull --rebase --recurse-submodules" learns to rebase the
   branch in the submodules to an updated base.

 * "git log" learned -P as a synonym for --perl-regexp, "git grep"
   already had such a synonym.

 * "git log" didn't understand --regexp-ignore-case when combined with
   --perl-regexp. This has been fixed.

Performance, Internal Implementation, Development Support etc.

 * The default packed-git limit value has been raised on larger
   platforms to save "git fetch" from a (recoverable) failure while
   "gc" is running in parallel.

 * Code to update the cache-tree has been tightened so that we won't
   accidentally write out any 0{40} entry in the tree object.

 * Attempt to allow us notice "fishy" situation where we fail to
   remove the temporary directory used during the test.

 * Travis CI gained a task to format the documentation with both
   AsciiDoc and AsciiDoctor.

 * Some platforms have ulong that is smaller than time_t, and our
   historical use of ulong for timestamp would mean they cannot
   represent some timestamp that the platform allows.  Invent a
   separate and dedicated timestamp_t (so that we can distingiuish
   timestamps and a vanilla ulongs, which along is already a good
   move), and then declare uintmax_t is the type to be used as the
   timestamp_t.

 * We can trigger Windows auto-build tester (credits: Dscho &
   Microsoft) from our existing Travis CI tester now.

 * Conversion from uchar[20] to struct object_id continues.

 * Simplify parse_pathspec() codepath and stop it from looking at the
   default in-core index.

 * Add perf-test for wildmatch.

 * Code from "conversion using external process" codepath has been
   extracted to a separate sub-process.[ch] module.

 * When "git checkout", "git merge", etc. manipulates the in-core
   index, various pieces of information in the index extensions are
   discarded from the original state, as it is usually not the case
   that they are kept up-to-date and in-sync with the operation on the
   main index.  The untracked cache extension is copied across these
   operations now, which would speed up "git status" (as long as the
   cache is properly invalidated).

 * The internal implementation of "git grep" has seen some clean-up.

 * Update the C style recommendation for notes for translators, as
   recent versions of gettext tools can work with our style of
   multi-line comments.

 * The implementation of "ref" API around the "packed refs" have been
   cleaned up, in preparation for further changes.

 * The internal logic used in "git blame" has been libified to make it
   easier to use by cgit.

 * Our code often opens a path to an optional file, to work on its
   contents when we can successfully open it.  We can ignore a failure
   to open if such an optional file does not exist, but we do want to
   report a failure in opening for other reasons (e.g. we got an I/O
   error, or the file is there, but we lack the permission to open).

   The exact errors we need to ignore are ENOENT (obviously) and
   ENOTDIR (less obvious).  Instead of repeating comparison of errno
   with these two constants, introduce a helper function to do so.

 * We often try to open a file for reading whose existence is
   optional, and silently ignore errors from open/fopen; report such
   errors if they are not due to missing files.

 * When an existing repository is used for t/perf testing, we first
   create bit-for-bit copy of it, which may grab a transient state of
   the repository and freeze it into the repository used for testing,
   which then may cause Git operations to fail.  Single out "the index
   being locked" case and forcibly drop the lock from the copy.

 * Three instances of the same helper function have been consolidated
   to one.

 * "fast-import" uses a default pack chain depth that is consistent
   with other parts of the system.

 * A new test to show the interaction between the pattern [^a-z]
   (which matches '/') and a slash in a path has been added.  The
   pattern should not match the slash with "pathmatch", but should
   with "wildmatch".

 * The 'diff-highlight' program (in contrib/) has been restructured
   for easier reuse by an external project 'diff-so-fancy'.

 * A common pattern to free a piece of memory and assign NULL to the
   pointer that used to point at it has been replaced with a new
   FREE_AND_NULL() macro.

 * Traditionally, the default die() routine had a code to prevent it
   from getting called multiple times, which interacted badly when a
   threaded program used it (one downside is that the real error may
   be hidden and instead the only error message given to the user may
   end up being "die recursion detected", which is not very useful).

 * Introduce a "repository" object to eventually make it easier to
   work in multiple repositories (the primary focus is to work with
   the superproject and its submodules) in a single process.

 * Optimize "what are the object names already taken in an alternate
   object database?" query that is used to derive the length of prefix
   an object name is uniquely abbreviated to.

 * The hashmap API has been updated so that data to customize the
   behaviour of the comparison function can be specified at the time a
   hashmap is initialized.

 * The "collision detecting" SHA-1 implementation shipped with 2.13 is
   now integrated into git.git as a submodule (the first submodule to
   ship with git.git). Clone git.git with --recurse-submodules to get
   it. For now a non-submodule copy of the same code is also shipped
   as part of the tree.

 * A recent update made it easier to use "-fsanitize=3D" option while
   compiling but supported only one sanitize option.  Allow more than
   one to be combined, joined with a comma, like "make SANITIZE=3Dfoo,bar=
".

 * Use "p4 -G" to make "p4 changes" output more Python-friendly
   to parse.

 * We started using "%" PRItime, imitating "%" PRIuMAX and friends, as
   a way to format the internal timestamp value, but this does not
   play well with gettext(1) i18n framework, and causes "make pot"
   that is run by the l10n coordinator to create a broken po/git.pot
   file.  This is a possible workaround for that problem.

 * It turns out that Cygwin also needs the fopen() wrapper that
   returns failure when a directory is opened for reading.

Also contains various documentation updates and code clean-ups.


Fixes since v2.13
-----------------

Unless otherwise noted, all the fixes since v2.13 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git gc" did not interact well with "git worktree"-managed
   per-worktree refs.

 * "git cherry-pick" and other uses of the sequencer machinery
   mishandled a trailer block whose last line is an incomplete line.
   This has been fixed so that an additional sign-off etc. are added
   after completing the existing incomplete line.

 * The codepath in "git am" that is used when running "git rebase"
   leaked memory held for the log message of the commits being rebased.

 * "git clone --config var=3Dval" is a way to populate the
   per-repository configuration file of the new repository, but it did
   not work well when val is an empty string.  This has been fixed.

 * Setting "log.decorate=3Dfalse" in the configuration file did not take
   effect in v2.13, which has been corrected.

 * A few codepaths in "checkout" and "am" working on an unborn branch
   tried to access an uninitialized piece of memory.

 * The Web interface to gmane news archive is long gone, even though
   the articles are still accessible via NTTP.  Replace the links with
   ones to public-inbox.org.  Because their message identification is
   based on the actual message-id, it is likely that it will be easier
   to migrate away from it if/when necessary.

 * The receive-pack program now makes sure that the push certificate
   records the same set of push options used for pushing.

 * Tests have been updated to pass under GETTEXT_POISON (a mechanism
   to ensure that output strings that should not be translated are
   not translated by mistake), and TravisCI is told to run them.

 * "git checkout --recurse-submodules" did not quite work with a
   submodule that itself has submodules.

 * "pack-objects" can stream a slice of an existing packfile out when
   the pack bitmap can tell that the reachable objects are all needed
   in the output, without inspecting individual objects.  This
   strategy however would not work well when "--local" and other
   options are in use, and need to be disabled.

 * Fix memory leaks pointed out by Coverity (and people).

 * "git read-tree -m" (no tree-ish) gave a nonsense suggestion "use
   --empty if you want to clear the index".  With "-m", such a request
   will still fail anyway, as you'd need to name at least one tree-ish
   to be merged.

 * Make sure our tests would pass when the sources are checked out
   with "platform native" line ending convention by default on
   Windows.  Some "text" files out tests use and the test scripts
   themselves that are meant to be run with /bin/sh, ought to be
   checked out with eol=3DLF even on Windows.

 * Introduce the BUG() macro to improve die("BUG: ...").

 * Clarify documentation for include.path and includeIf.<condition>.path
   configuration variables.

 * Git sometimes gives an advice in a rhetorical question that does
   not require an answer, which can confuse new users and non native
   speakers.  Attempt to rephrase them.

 * A few http:// links that are redirected to https:// in the
   documentation have been updated to https:// links.

 * "git for-each-ref --format=3D..." with %(HEAD) in the format used to
   resolve the HEAD symref as many times as it had processed refs,
   which was wasteful, and "git branch" shared the same problem.

 * Regression fix to topic recently merged to 'master'.

 * The shell completion script (in contrib/) learned "git stash" has
   a new "push" subcommand.

 * "git interpret-trailers", when used as GIT_EDITOR for "git commit
   -v", looked for and appended to a trailer block at the very end,
   i.e. at the end of the "diff" output.  The command has been
   corrected to pay attention to the cut-mark line "commit -v" adds to
   the buffer---the real trailer block should appear just before it.

 * A test allowed both "git push" and "git receive-pack" on the other
   end write their traces into the same file.  This is OK on platforms
   that allows atomically appending to a file opened with O_APPEND,
   but on other platforms led to a mangled output, causing
   intermittent test failures.  This has been fixed by disabling
   traces from "receive-pack" in the test.

 * Tag objects, which are not reachable from any ref, that point at
   missing objects were mishandled by "git gc" and friends (they
   should silently be ignored instead)

 * "git describe --contains" penalized light-weight tags so much that
   they were almost never considered.  Instead, give them about the
   same chance to be considered as an annotated tag that is the same
   age as the underlying commit would.

 * The "run-command" API implementation has been made more robust
   against dead-locking in a threaded environment.

 * A recent update to t5545-push-options.sh started skipping all the
   tests in the script when a web server testing is disabled or
   unavailable, not just the ones that require a web server.  Non HTTP
   tests have been salvaged to always run in this script.

 * "git send-email" now uses Net::SMTP::SSL, which is obsolete, only
   when needed.  Recent versions of Net::SMTP can do TLS natively.

 * "foo\bar\baz" in "git fetch foo\bar\baz", even though there is no
   slashes in it, cannot be a nickname for a remote on Windows, as
   that is likely to be a pathname on a local filesystem.

 * "git clean -d" used to clean directories that has ignored files,
   even though the command should not lose ignored ones without "-x".
   "git status --ignored"  did not list ignored and untracked files
   without "-uall".  These have been corrected.

 * The result from "git diff" that compares two blobs, e.g. "git diff
   $commit1:$path $commit2:$path", used to be shown with the full
   object name as given on the command line, but it is more natural to
   use the $path in the output and use it to look up .gitattributes.

 * The "collision detecting" SHA-1 implementation shipped with 2.13
   was quite broken on some big-endian platforms and/or platforms that
   do not like unaligned fetches.  Update to the upstream code which
   has already fixed these issues.

 * "git am -h" triggered a BUG().

 * The interaction of "url.*.insteadOf" and custom URL scheme's
   whitelisting is now documented better.

 * The timestamp of the index file is now taken after the file is
   closed, to help Windows, on which a stale timestamp is reported by
   fstat() on a file that is opened for writing and data was written
   but not yet closed.

 * "git pull --rebase --autostash" didn't auto-stash when the local histo=
ry
   fast-forwards to the upstream.

 * A flaky test has been corrected.

 * "git $cmd -h" for builtin commands calls the implementation of the
   command (i.e. cmd_$cmd() function) without doing any repository
   set-up, and the commands that expect RUN_SETUP is done by the Git
   potty needs to be prepared to show the help text without barfing.
   (merge d691551192 jk/consistent-h later to maint).

 * Help contributors that visit us at GitHub.

 * "git stash push <pathspec>" did not work from a subdirectory at all.
   Bugfix for a topic in v2.13

 * As there is no portable way to pass timezone information to
   strftime, some output format from "git log" and friends are
   impossible to produce.  Teach our own strbuf_addftime to replace %z
   and %Z with caller-supplied values to help working around this.
   (merge 6eced3ec5e rs/strbuf-addftime-zZ later to maint).

 * "git mergetool" learned to work around a wrapper MacOS X adds
   around underlying meld.

 * An example in documentation that does not work in multi worktree
   configuration has been corrected.

 * The pretty-format specifiers like '%h', '%t', etc. had an
   optimization that no longer works correctly.  In preparation/hope
   of getting it correctly implemented, first discard the optimization
   that is broken.

 * The code to pick up and execute command alias definition from the
   configuration used to switch to the top of the working tree and
   then come back when the expanded alias was executed, which was
   unnecessarilyl complex.  Attempt to simplify the logic by using the
   early-config mechanism that does not chdir around.

 * Fix configuration codepath to pay proper attention to commondir
   that is used in multi-worktree situation, and isolate config API
   into its own header file.
   (merge dc8441fdb4 bw/config-h later to maint).

 * "git add -p" were updated in 2.12 timeframe to cope with custom
   core.commentchar but the implementation was buggy and a
   metacharacter like $ and * did not work.

 * A recent regression in "git rebase -i" has been fixed and tests
   that would have caught it and others have been added.

 * An unaligned 32-bit access in pack-bitmap code has been corrected.

 * Tighten error checks for invalid "git apply" input.

 * The split index code did not honor core.sharedRepository setting
   correctly.

 * The Makefile rule in contrib/subtree for building documentation
   learned to honour USE_ASCIIDOCTOR just like the main documentation
   set does.

 * Code clean-up to fix possible buffer over-reading.

 * A few tests that tried to verify the contents of push certificates
   did not use 'git rev-parse' to formulate the line to look for in
   the certificate correctly.

 * Update the character width tables.

 * After "git branch --move" of the currently checked out branch, the
   code to walk the reflog of HEAD via "log -g" and friends
   incorrectly stopped at the reflog entry that records the renaming
   of the branch.

 * The rewrite of "git branch --list" using for-each-ref's internals
   that happened in v2.13 regressed its handling of color.branch.local;
   this has been fixed.

 * The build procedure has been improved to allow building and testing
   Git with address sanitizer more easily.
   (merge 425ca6710b jk/build-with-asan later to maint).

 * On Cygwin, similar to Windows, "git push //server/share/repository"
   ought to mean a repository on a network share that can be accessed
   locally, but this did not work correctly due to stripping the double
   slashes at the beginning.

 * The progress meter did not give a useful output when we haven't had
   0.5 seconds to measure the throughput during the interval.  Instead
   show the overall throughput rate at the end, which is a much more
   useful number.

 * Code clean-up, that makes us in sync with Debian by one patch.

 * We run an early part of "git gc" that deals with refs before
   daemonising (and not under lock) even when running a background
   auto-gc, which caused multiple gc processes attempting to run the
   early part at the same time.  This is now prevented by running the
   early part also under the GC lock.

 * A recent update broke an alias that contained an uppercase letter.

 * Other minor doc, test and build updates and code cleanups.
   (merge 5053313562 rs/urlmatch-cleanup later to maint).
   (merge 42c78a216e rs/use-div-round-up later to maint).
   (merge 5e8d2729ae rs/wt-status-cleanup later to maint).
   (merge bc9b7e207f as/diff-options-grammofix later to maint).
   (merge ac05222b31 ah/patch-id-doc later to maint).

----------------------------------------------------------------

Changes since v2.13.0 are as follows:

A. Wilcox (1):
      subtree: honour USE_ASCIIDOCTOR when set

Adam Dinwoodie (1):
      docs: fix formatting and grammar

Alejandro R. Sede=C3=B1o (1):
      ref-filter.c: drop return from void function

Alexander Shopov (2):
      l10n: bg.po: Updated Bulgarian translation (3206t)
      l10n: bg.po: Updated Bulgarian translation (3213t)

Andreas Heiduk (11):
      Documentation: fix reference to ifExists for interpret-trailers
      Documentation: fix formatting typo in pretty-formats.txt
      doc: filter-branch does not require re-export of vars
      doc: rewrite description for rev-parse --short
      doc: describe git svn init --ignore-refs
      filter-branch: add `--setup` step
      filter-branch: add [--] to usage
      git-svn: document special options for commit-diff
      doc: do not use `rm .git/index` when normalizing line endings
      doc: clarify syntax for %C(auto,...) in pretty formats
      doc: remove unsupported parameter from patch-id

Anthony Sottile (1):
      diff-options doc: grammar fix

Beat Bolli (1):
      unicode: update the width tables to Unicode 10

Ben Peart (10):
      convert: remove erroneous tests for errno =3D=3D EPIPE
      pkt-line: fix packet_read_line() to handle len < 0 errors
      pkt-line: add packet_read_line_gently()
      convert: move packet_write_line() into pkt-line as packet_writel()
      convert: split start_multi_file_filter() into two separate function=
s
      convert: separate generic structures and variables from the filter =
specific ones
      convert: update generic functions to only use generic data structur=
es
      convert: rename reusable sub-process functions
      sub-process: move sub-process functions into separate files
      convert: update subprocess_read_status() to not die on EOF

Brandon Williams (107):
      t5550: use write_script to generate post-update hook
      t0061: run_command executes scripts without a #! line
      run-command: prepare command before forking
      run-command: use the async-signal-safe execv instead of execvp
      string-list: add string_list_remove function
      run-command: prepare child environment before forking
      run-command: don't die in child when duping /dev/null
      run-command: eliminate calls to error handling functions in child
      run-command: handle dup2 and close errors in child
      run-command: add note about forking and threading
      run-command: expose is_executable function
      run-command: restrict PATH search to executable files
      submodule: rename add_sha1_to_array()
      submodule: rename free_submodules_sha1s()
      submodule: remove add_oid_to_argv()
      submodule: change string_list changed_submodule_paths
      submodule: improve submodule_has_commits()
      submodule: refactor logic to determine changed submodules
      dir: stop using the index compatibility macros
      dir: convert read_skip_worktree_file_from_index to take an index
      dir: convert directory_exists_in_index to take index
      dir: convert get_dtype to take index
      dir: convert dir_add* to take an index
      dir: convert last_exclude_matching_from_list to take an index
      dir: convert is_excluded_from_list to take an index
      dir: convert add_excludes to take an index
      dir: convert prep_exclude to take an index
      dir: convert is_excluded to take an index
      dir: convert open_cached_dir to take an index
      dir: convert read_directory_recursive to take an index
      dir: convert read_directory to take an index
      dir: convert fill_directory to take an index
      pathspec: provide a more descriptive die message
      submodule: add die_in_unpopulated_submodule function
      pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
      ls-files: prevent prune_cache from overeagerly pruning submodules
      pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
      pathspec: convert find_pathspecs_matching_against_index to take an =
index
      grep: convert to struct object_id
      diff: convert get_stat_data to struct object_id
      diff: convert diff_index_show_file to struct object_id
      diff: convert diff_addremove to struct object_id
      diff: convert run_diff_files to struct object_id
      diff: convert diff_change to struct object_id
      diff: convert fill_filespec to struct object_id
      diff: convert reuse_worktree_file to struct object_id
      diff: finish conversion for prepare_temp_file to struct object_id
      patch-ids: convert to struct object_id
      diff: convert diff_flush_patch_id to struct object_id
      combine-diff: convert diff_tree_combined to struct object_id
      combine-diff: convert find_paths_* to struct object_id
      tree-diff: convert diff_root_tree_sha1 to struct object_id
      notes-merge: convert notes_merge* to struct object_id
      notes-merge: convert merge_from_diffs to struct object_id
      notes-merge: convert find_notes_merge_pair_ps to struct object_id
      notes-merge: convert verify_notes_filepair to struct object_id
      notes-merge: convert write_note_to_worktree to struct object_id
      diff-tree: convert diff_tree_sha1 to struct object_id
      builtin/diff-tree: cleanup references to sha1
      tree-diff: convert try_to_follow_renames to struct object_id
      tree-diff: convert diff_tree_paths to struct object_id
      tree-diff: convert path_appendnew to object_id
      diffcore-rename: use is_empty_blob_oid
      diff: rename diff_fill_sha1_info to diff_fill_oid_info
      convert: convert get_cached_convert_stats_ascii to take an index
      convert: convert crlf_to_git to take an index
      convert: convert convert_to_git_filter_fd to take an index
      convert: convert convert_to_git to take an index
      convert: convert renormalize_buffer to take an index
      tree: convert read_tree to take an index parameter
      ls-files: convert overlay_tree_on_cache to take an index
      ls-files: convert write_eolinfo to take an index
      ls-files: convert show_killed_files to take an index
      ls-files: convert show_other_files to take an index
      ls-files: convert show_ru_info to take an index
      ls-files: convert ce_excluded to take an index
      ls-files: convert prune_cache to take an index
      ls-files: convert show_ce_entry to take an index
      ls-files: convert show_files to take an index
      ls-files: factor out debug info into a function
      ls-files: factor out tag calculation
      config: create config.h
      config: remove git_config_iter
      config: don't include config.h by default
      setup: teach discover_git_directory to respect the commondir
      config: respect commondir
      config: don't implicitly use gitdir or commondir
      setup: don't perform lazy initialization of repository state
      setup: add comment indicating a hack
      environment: remove namespace_len variable
      repository: introduce the repository object
      environment: place key repository state in the_repository
      environment: store worktree in the_repository
      path: create path.h
      path: always pass in commondir to update_common_dir
      path: convert strbuf_git_common_path to take a 'struct repository'
      path: convert do_git_path to take a 'struct repository'
      path: worktree_git_path() should not use file relocation
      path: add repo_git_path and strbuf_repo_git_path
      path: add repo_worktree_path and strbuf_repo_worktree_path
      config: read config from a repository object
      repository: add index_state to struct repo
      submodule-config: store the_submodule_cache in the_repository
      submodule: add repo_read_gitmodules
      submodule: convert is_submodule_initialized to work on a repository
      repository: enable initialization of submodules
      ls-files: use repository object

Brian Malehorn (1):
      interpret-trailers: honor the cut line

Changwoo Ryu (2):
      l10n: ko.po: Update Korean translation
      l10n: ko.po: Update Korean translation

Christian Couder (5):
      p3400: add perf tests for rebasing many changes
      sub-process: correct path to API docs in a comment
      read-cache: use shared perms when writing shared index
      t1301: move modebits() to test-lib-functions.sh
      t1700: make sure split-index respects core.sharedrepository

David Aguilar (1):
      mergetools/meld: improve compatibiilty with Meld on macOS X

David Turner (2):
      Increase core.packedGitLimit
      unpack-trees: preserve index extensions

Dennis Kaarsemaker (1):
      send-email: Net::SMTP::SSL is obsolete, use only when necessary

Dimitriy Ryazantcev (2):
      l10n: ru.po: update Russian translation
      l10n: ru.po: update Russian translation

Eric Wong (2):
      run-command: block signals between fork and execve
      set FD_CLOEXEC properly when O_CLOEXEC is not supported

Hartmut Henkel (1):
      l10n: de.po: various fixes in German translation

Hugues Peccatte (1):
      l10n: fr.po Fix some translations

James Clarke (1):
      pack-bitmap: don't perform unaligned memory access

Jean-Noel Avila (4):
      usability: don't ask questions if no reply is required
      read-tree -m: make error message for merging 0 trees less smart ale=
ck
      git-filter-branch: be more direct in an error message
      l10n: fr.po v2.14.0 rnd 2

Jeff Hostetler (1):
      read-cache: close index.lock in do_write_index

Jeff King (78):
      cache-tree: reject entries with null sha1
      am: fix commit buffer leak in get_commit_info()
      am: simplify allocations in get_commit_info()
      am: shorten ident_split variable name in get_commit_info()
      status: fix missing newline when comment chars are disabled
      pack-objects: disable pack reuse for object-selection options
      t5310: fix "; do" style
      add--interactive: drop diff.indentHeuristic handling
      docs/config: clarify include/includeIf relationship
      docs/config: give a relative includeIf example
      docs/config: avoid the term "expand" for includes
      docs/config: consistify include.path examples
      usage.c: add BUG() function
      setup_git_env: convert die("BUG") to BUG()
      config: complain about --local outside of a git repo
      usage.c: drop set_error_handle()
      pkt-line: annotate packet_writel with LAST_ARG_MUST_BE_NULL
      t5400: avoid concurrent writes into a trace file
      ref-filter: resolve HEAD when parsing %(HEAD) atom
      revision.c: ignore broken tags with ignore_missing_links
      ref-filter: limit traversal to prefix
      handle_revision_arg: reset "dotdot" consistently
      handle_revision_arg: simplify commit reference lookups
      handle_revision_arg: stop using "dotdot" as a generic pointer
      handle_revision_arg: hoist ".." check out of range parsing
      handle_revision_arg: add handle_dotdot() helper
      sha1_name: consistently refer to object_context as "oc"
      get_sha1_with_context: always initialize oc->symlink_path
      get_sha1_with_context: dynamically allocate oc->path
      t4063: add tests of direct blob diffs
      handle_revision_arg: record modes for "a..b" endpoints
      handle_revision_arg: record paths for pending objects
      diff: pass whole pending entry in blobinfo
      diff: use the word "path" instead of "name" for blobs
      diff: use pending "path" if it is available
      diff: use blob path for blob/file diffs
      connect.c: fix leak in parse_one_symref_info()
      t4208: add check for ":/" without matching file
      check_filename(): refactor ":/" handling
      check_filename(): use skip_prefix
      check_filename(): handle ":^" path magic
      verify_filename(): treat ":(magic)" as a pathspec
      verify_filename(): flip order of checks
      am: handle "-h" argument earlier
      credential: handle invalid arguments earlier
      upload-archive: handle "-h" option early
      remote-{ext,fd}: print usage message on invalid arguments
      submodule--helper: show usage for "-h"
      remote: drop free_refspecs() function
      docs/config: mention protocol implications of url.insteadOf
      version: convert to parse-options
      git: add hidden --list-builtins option
      t0012: test "-h" with builtins
      t5313: make extended-table test more deterministic
      sha1dc: ignore indent-with-non-tab whitespace violations
      add: warn when adding an embedded repository
      t: move "git add submodule" into test blocks
      diff-highlight: split code into module
      configure.ac: loosen FREAD_READS_DIRECTORIES test program
      t0006: check --date=3Dformat zone offsets
      date: use localtime() for "-local" time formats
      docs: update 64-bit core.packedGitLimit default
      add--interactive: handle EOF in prompt_yesno
      add--interactive: quote commentChar regex
      reflog-walk: skip over double-null oid due to HEAD rename
      reflog-walk: duplicate strings in complete_reflogs list
      reflog-walk: don't free reflogs added to cache
      reflog-walk: include all fields when freeing complete_reflogs
      branch: only perform HEAD check for local branches
      branch: use BRANCH_COLOR_LOCAL in ref-filter format
      branch: set remote color in ref-filter branch immediately
      test-lib: set ASAN_OPTIONS variable before we run git
      test-lib: turn on ASan abort_on_error by default
      Makefile: add helper for compiling with -fsanitize
      Makefile: turn off -fomit-frame-pointer with sanitizers
      Makefile: disable unaligned loads with UBSan
      gc: run pre-detach operations under lock
      t: handle EOF in test_copy_bytes()

Jeff Smith (29):
      blame: remove unneeded dependency on blob.h
      blame: move textconv_object with related functions
      blame: remove unused parameters
      blame: rename origin structure to blame_origin
      blame: rename scoreboard structure to blame_scoreboard
      blame: rename origin-related functions
      blame: rename coalesce function
      blame: rename ent_score function
      blame: rename nth_line function
      blame: move stat counters to scoreboard
      blame: move copy/move thresholds to scoreboard
      blame: move contents_from to scoreboard
      blame: move reverse flag to scoreboard
      blame: move show_root flag to scoreboard
      blame: move xdl_opts flags to scoreboard
      blame: move no_whole_file_rename flag to scoreboard
      blame: make sanity_check use a callback in scoreboard
      blame: move progress updates to a scoreboard callback
      blame: wrap blame_sort and compare_blame_final
      blame: rework methods that determine 'final' commit
      blame: create scoreboard init function
      blame: create scoreboard setup function
      blame: create entry prepend function
      blame: move core structures to header
      blame: move origin-related methods to libgit
      blame: move fake-commit-related methods to libgit
      blame: move scoreboard-related methods to libgit
      blame: move scoreboard setup to libgit
      blame: move entry prepend to libgit

Jiang Xin (4):
      l10n: git.pot: v2.14.0 round 1 (34 new, 23 removed)
      l10n: git.pot: v2.14.0 round 2 (9 new, 2 removed)
      l10n: zh_CN: for git v2.14.0 l10n round 2
      l10n: zh_CN: review for git v2.14.0 l10n

Johannes Schindelin (50):
      ref-filter: avoid using `unsigned long` for catch-all data type
      t0006 & t5000: prepare for 64-bit timestamps
      t0006 & t5000: skip "far in the future" test when time_t is too lim=
ited
      parse_timestamp(): specify explicitly where we parse timestamps
      PRItime: introduce a new "printf format" for timestamps
      timestamp_t: a new data type for timestamps
      date.c: abort if the system time cannot handle one of our timestamp=
s
      use uintmax_t for timestamps
      mingw: avoid memory leak when splitting PATH
      winansi: avoid use of uninitialized value
      winansi: avoid buffer overrun
      add_commit_patch_id(): avoid allocating memory unnecessarily
      git_config_rename_section_in_file(): avoid resource leak
      get_mail_commit_oid(): avoid resource leak
      difftool: address a couple of resource/memory leaks
      status: close file descriptor after reading git-rebase-todo
      mailinfo & mailsplit: check for EOF while parsing
      cat-file: fix memory leak
      checkout: fix memory leak
      split_commit_in_progress(): simplify & fix memory leak
      setup_bare_git_dir(): help static analysis
      setup_discovered_git_dir(): plug memory leak
      pack-redundant: plug memory leak
      mktree: plug memory leaks reported by Coverity
      fast-export: avoid leaking memory in handle_tag()
      receive-pack: plug memory leak in update()
      line-log: avoid memory leak
      shallow: avoid memory leak
      add_reflog_for_walk: avoid memory leak
      remote: plug memory leak in match_explicit()
      name-rev: avoid leaking memory in the `deref` case
      show_worktree(): plug memory leak
      submodule_uses_worktrees(): plug memory leak
      Fix build with core.autocrlf=3Dtrue
      git-new-workdir: mark script as LF-only
      completion: mark bash script as LF-only
      t3901: move supporting files into t/t3901/
      Fix the remaining tests that failed with core.autocrlf=3Dtrue
      t4051: mark supporting files as requiring LF-only line endings
      mingw: verify that paths are not mistaken for remote nicknames
      discover_git_directory(): avoid setting invalid git_dir
      config: report correct line number upon error
      help: use early config when autocorrecting aliases
      t1308: relax the test verifying that empty alias values are disallo=
wed
      t7006: demonstrate a problem with aliases in subdirectories
      alias: use the early config machinery to expand aliases
      sequencer: print autostash messages to stderr
      t5534: fix misleading grep invocation
      t1300: demonstrate that CamelCased aliases regressed
      alias: compare alias name *case-insensitively*

Johannes Sixt (3):
      mingw.h: permit arguments with side effects for is_dir_sep
      Windows: do not treat a path with backslashes as a remote's nick na=
me
      mingw_fopen: report ENOENT for invalid file names

Jonathan Nieder (4):
      credential doc: make multiple-helper behavior more prominent
      clone: handle empty config values in -c
      send-email: Net::SMTP::starttls was introduced in v2.34
      pre-rebase hook: capture documentation in a <<here document

Jonathan Tan (14):
      sequencer: add newline before adding footers
      docs: correct receive.advertisePushOptions default
      receive-pack: verify push options in cert
      fetch-pack: always allow fetching of literal SHA1s
      send-email: support validate hook
      send-email: check for repo before invoking hook
      sha1_file: teach packed_object_info about typename
      sha1_file: rename LOOKUP_UNKNOWN_OBJECT
      sha1_file: rename LOOKUP_REPLACE_OBJECT
      sha1_file: move delta base cache code up
      sha1_file: refactor read_object
      sha1_file: teach sha1_object_info_extended more flags
      sha1_file: do not access pack if unneeded
      sha1_file: refactor has_sha1_file_with_flags

Jordi Mas (3):
      l10n: Fixes to Catalan translation
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Junio C Hamano (54):
      name-rev: refactor logic to see if a new candidate is a better name
      name-rev: favor describing with tags and use committer date to tieb=
reak
      test-lib.sh: do not barf under --debug at the end of the test
      test-lib: retire $remove_trash variable
      repack: accept --threads=3D<n> and pass it down to pack-objects
      apply.c: fix whitespace-only mismerge
      checkout: fix memory leak
      doc: replace more gmane links
      read-tree: "read-tree -m --empty" does not make sense
      Start post 2.13 cycle
      test: allow skipping the remainder
      name-rev: change a "long" variable to timestamp_t
      Second batch for 2.14
      config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
      Third batch for 2.14
      compat-util: is_missing_file_error()
      treewide: use is_missing_file_error() where ENOENT and ENOTDIR are =
checked
      Fourth batch for 2.14
      diff-tree: update stale in-code comments
      Fifth batch for 2.14
      Sixth batch for 2.14
      Prepare for 2.13.1; more topics to follow
      Git 2.13.1
      Seventh batch for 2.14
      diff- and log- family: handle "git cmd -h" early
      Prepare for 2.13.2
      Eighth batch for 2.14
      Ninth batch for 2.14
      Tenth batch for 2.14
      t3420: fix under GETTEXT_POISON build
      Revert "split-index: add and use unshare_split_index()"
      Eleventh batch for 2.14
      Git 2.13.2
      Twelfth batch for 2.14
      t1450: use egrep for regexp "alternation"
      submodule--helper: do not call utf8_fprintf() unnecessarily
      Thirteenth batch for 2.14
      sha1collisiondetection: automatically enable when submodule is popu=
lated
      Fourteenth batch for 2.14
      Fifteenth batch for 2.14
      Sixteenth batch for 2.14
      Prepare for 2.13.3
      Hopefully the last batch before -rc0
      Git 2.13.3
      Git 2.14-rc0
      A few more topics before 2.14-rc1
      Makefile: help gettext tools to cope with our custom PRItime format
      A few more topics while waiting for the po/PRItime resolution
      Hopefully the final last-minute fix before -rc1
      fixes from 'master' for 2.13.4
      Git 2.14-rc1
      Preparation for 2.13.4 continues
      Git 2.13.4
      Git 2.14

Kaartic Sivaraam (9):
      t7508: fix a broken indentation
      status: contextually notify user about an initial commit
      Documentation/git-submodule: cleanup "add" section
      commit-template: remove outdated notice about explicit paths
      commit-template: distinguish status information unconditionally
      builtin/commit.c: fix a typo in the comment
      doc: correct a mistake in an illustration
      doc: camelCase the i18n config variables to improve readability
      doc: reformat the paragraph containing the 'cut-line'

Kyle J. McKay (1):
      t5100: add some more mailinfo tests

Kyle Meyer (1):
      config.txt: add an entry for log.showSignature

Lars Schneider (9):
      travis-ci: build documentation with AsciiDoc and Asciidoctor
      travis-ci: parallelize documentation build
      travis-ci: unset compiler for jobs that do not need one
      travis-ci: check AsciiDoc/AsciiDoctor stderr output
      travis-ci: handle Git for Windows CI status "failed" explicitly
      travis-ci: retry if Git for Windows CI returns HTTP error 502 or 50=
3
      travis-ci: setup "prove cache" in "script" step
      travis-ci: add job to run tests with GETTEXT_POISON
      Configure Git contribution guidelines for github.com

Liam Beguin (3):
      stash: update documentation to use 'stash entry'
      status: add optional stash count information
      glossary: define 'stash entry'

Louis (1):
      l10n: fr.po Fix typo

Marc Branchaud (3):
      diff: make the indent heuristic part of diff's basic configuration
      diff: have the diff-* builtins configure diff before initializing r=
evisions
      auto-correct: tweak phrasing

Michael Haggerty (26):
      t3600: clean up permissions test properly
      refs.h: clarify docstring for the ref_transaction_update()-related =
fns
      ref_iterator_begin_fn(): fix docstring
      files-backend: use `die("BUG: ...")`, not `die("internal error: ...=
")`
      prefix_ref_iterator: don't trim too much
      refs_ref_iterator_begin(): don't check prefixes redundantly
      refs: use `size_t` indexes when iterating over ref transaction upda=
tes
      ref_store: take a `msg` parameter when deleting references
      lockfile: add a new method, is_lock_file_locked()
      files-backend: move `lock` member to `files_ref_store`
      files_ref_store: put the packed files lock directly in this struct
      files_transaction_cleanup(): new helper function
      ref_transaction_commit(): check for valid `transaction->state`
      ref_transaction_prepare(): new optional step for reference updates
      ref_update_reject_duplicates(): expose function to whole refs modul=
e
      ref_update_reject_duplicates(): use `size_t` rather than `int`
      ref_update_reject_duplicates(): add a sanity check
      should_pack_ref(): new function, extracted from `files_pack_refs()`
      get_packed_ref_cache(): assume "packed-refs" won't change while loc=
ked
      read_packed_refs(): do more of the work of reading packed refs
      read_packed_refs(): report unexpected fopen() failures
      refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
      create_ref_entry(): remove `check_name` option
      cache_ref_iterator_begin(): avoid priming unneeded directories
      lock_packed_refs(): fix cache validity check
      for_each_bisect_ref(): don't trim refnames

Miguel Torroja (3):
      git-p4: git-p4 tests with p4 triggers
      git-p4: parse marshal output "p4 -G" in p4 changes
      git-p4: filter for {'code':'info'} in p4CmdList

Mike Hommey (1):
      fast-import: increase the default pack depth to 50

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (16):
      environment.c: fix potential segfault by get_git_common_dir()
      refs.c: make submodule ref store hashmap generic
      refs: add REFS_STORE_ALL_CAPS
      refs: introduce get_worktree_ref_store()
      worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
      refs: kill set_worktree_head_symref()
      split-index: add and use unshare_split_index()
      use xfopen() in more places
      clone: use xfopen() instead of fopen()
      config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
      wrapper.c: add and use warn_on_fopen_errors()
      wrapper.c: add and use fopen_or_warn()
      wrapper.c: make warn_on_inaccessible() static
      print errno when reporting a system call error
      rerere.c: move error_errno() closer to the source system call
      log: fix memory leak in open_next_file()

Patrick Steinhardt (1):
      git-stash: fix pushing stash with pathspec from subdir

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (3206t0f0u)

Phillip Wood (10):
      rebase -i: fix reflog message
      rebase -i: silence stash apply
      rebase -i: add missing newline to end of message
      rebase -i: add test for reflog message
      rebase: add regression tests for console output
      rebase: add more regression tests for console output
      add -i: move unquote_path() to Git.pm
      Git::unquote_path(): handle '\a'
      Git::unquote_path(): throw an exception on bad path
      t9700: add tests for Git::unquote_path()

Prathamesh Chavan (1):
      dir: create function count_slashes()

Ralf Thielow (2):
      l10n: de.po: fix typo
      l10n: de.po: update German translation

Ramsay Jones (5):
      t7400: add !CYGWIN prerequisite to 'add with \\ in path'
      archive-tar: fix a sparse 'constant too large' warning
      usage: add NORETURN to BUG() function definitions
      git_fopen: fix a sparse 'not declared' warning
      config.mak.uname: set FREAD_READS_DIRECTORIES for cygwin

Ren=C3=A9 Scharfe (32):
      archive-zip: add tests for big ZIP archives
      archive-zip: use strbuf for ZIP directory
      archive-zip: write ZIP dir entry directly to strbuf
      archive-zip: support archives bigger than 4GB
      archive-zip: support files bigger than 4GB
      archive-zip: set version field for big files correctly
      t5004: require 64-bit support for big ZIP tests
      checkout: check return value of resolve_refdup before using hash
      am: check return value of resolve_refdup before using hash
      p0004: simplify calls of test-lazy-init-name-hash
      p0004: avoid using pipes
      p0004: use test_perf
      p0004: don't abort if multi-threaded is too slow
      p0004: don't error out if test repo is too small
      mingw: simplify PATH handling
      pretty: recalculate duplicate short hashes
      strbuf: let strbuf_addftime handle %z and %Z itself
      sha1_name: cache readdir(3) results in find_short_object_filename()
      p4205: add perf test script for pretty log formats
      sha1_file: let for_each_file_in_obj_subdir() handle subdir names
      sha1_file: guard against invalid loose subdirectory numbers
      apply: check git diffs for missing old filenames
      apply: check git diffs for invalid file modes
      apply: check git diffs for mutually exclusive header lines
      coccinelle: polish FREE_AND_NULL rules
      apply: use starts_with() in gitdiff_verify_name()
      apply: use strcmp(3) for comparing strings in gitdiff_verify_name()
      urlmatch: use hex2chr() in append_normalized_escapes()
      progress: show overall rate in last update
      wt-status: use separate variable for result of shorten_unambiguous_=
ref
      use DIV_ROUND_UP
      Makefile: allow combining UBSan with other sanitizers

Rikard Falkeborn (7):
      completion: add completions for git config commit
      completion: add git config gc completions
      completion: add git config core completions
      completion: add git config am.threeWay completion
      completion: add git config advice completions
      completion: add git config credential completions
      completion: add git config credentialCache.ignoreSIGHUP

SZEDER G=C3=A1bor (9):
      test-lib: abort when can't remove trash directory
      docs/config.txt: fix indefinite article in core.fileMode descriptio=
n
      revision.h: turn rev_info.early_output back into an unsigned int
      revision.c: stricter parsing of '--no-{min,max}-parents'
      revision.c: stricter parsing of '--early-output'
      revision.c: use skip_prefix() in handle_revision_opt()
      revision.c: use skip_prefix() in handle_revision_pseudo_opt()
      docs/pretty-formats: stress that %- removes all preceding line-feed=
s
      blame: fix memory corruption scrambling revision name in error mess=
age

Sahil Dua (2):
      branch test: fix invalid config key access
      t3200: add test for single parameter passed to -m option

Samuel Lijin (6):
      t7300: clean -d should skip dirs with ignored files
      t7061: status --ignored should search untracked dirs
      dir: recurse into untracked dirs for ignored files
      dir: hide untracked contents of untracked dirs
      dir: expose cmp_name() and check_contains()
      clean: teach clean -d to preserve ignored paths

Stefan Beller (30):
      entry.c: submodule recursing: respect force flag correctly
      submodule.c: uninitialized submodules are ignored in recursive comm=
ands
      submodule.c: submodule_move_head works with broken submodules
      builtin/reset: add --recurse-submodules switch
      submodule_move_head: reuse child_process structure for futher comma=
nds
      submodule: avoid auto-discovery in new working tree manipulator cod=
e
      submodule: properly recurse for read-tree and checkout
      diff: recurse into nested submodules for inline diff
      diff: enable indent heuristic by default
      t5545: enhance test coverage when no http server is installed
      t5531: fix test description
      submodule recursing: do not write a config variable twice
      submodule test invocation: only pass additional arguments
      reset/checkout/read-tree: unify config callback for submodule recur=
sion
      submodule loading: separate code path for .gitmodules and config ov=
erlay
      Introduce 'submodule.recurse' option for worktree manipulators
      builtin/grep.c: respect 'submodule.recurse' option
      builtin/push.c: respect 'submodule.recurse' option
      builtin/fetch.c: respect 'submodule.recurse' option
      Documentation/git-rm: correct submodule description
      t4005: modernize style and drop hard coded sha1
      submodules: overhaul documentation
      builtin/fetch: factor submodule recurse parsing out to submodule co=
nfig
      builtin/fetch: parse recurse-submodules-default at default options =
parsing
      pull: optionally rebase submodules (remote submodule changes only)
      builtin/fetch cleanup: always set default value for submodule recur=
sing
      merge-recursive: use DIFF_XDL_SET macro
      hashmap.h: compare function has access to a data field
      patch-ids.c: use hashmap correctly
      hashmap: migrate documentation from Documentation/technical into he=
ader

Stephen Kent (1):
      status: add color config slots for branch info in "--short --branch=
"

Sven Strickroth (1):
      doc: use https links to Wikipedia to avoid http redirects

Sylvestre Ledru (1):
      l10n: fr.po Fix some french typos

Thomas Gummerer (1):
      completion: add git stash push

Torsten B=C3=B6gershausen (2):
      t0027: tests are not expensive; remove t0025
      cygwin: allow pushing to UNC paths

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po(3206t): Update Vietnamese translation
      l10n: vi.po (3213t): Updated 9 new strings

Tyler Brazier (1):
      pull: ff --rebase --autostash works in dirty repo

Ville Skytt=C3=A4 (1):
      Spelling fixes

brian m. carlson (61):
      fetch-pack: convert to struct object_id
      Clean up outstanding object_id transforms.
      Convert struct cache_tree to use struct object_id
      builtin/name-rev: convert to struct object_id
      builtin/prune: convert to struct object_id
      bundle: convert to struct object_id
      branch: convert to struct object_id
      builtin/blame: convert static function to struct object_id
      builtin/rev-parse: convert to struct object_id
      fast-import: convert internal structs to struct object_id
      fast-import: convert to struct object_id
      submodule: convert merge_submodule to use struct object_id
      notes-cache: convert to struct object_id
      parse-options-cb: convert to struct object_id
      reflog_expire: convert to struct object_id
      builtin/verify-commit: convert to struct object_id
      tag: convert parse_tag_buffer to struct object_id
      http-push: convert some static functions to struct object_id
      notes-utils: convert internals to struct object_id
      revision: convert prepare_show_merge to struct object_id
      shallow: convert shallow registration functions to object_id
      sequencer: convert some functions to struct object_id
      builtin/tag: convert to struct object_id
      Convert remaining callers of lookup_commit_reference* to object_id
      Convert lookup_commit* to struct object_id
      pack: convert struct pack_idx_entry to struct object_id
      builtin/unpack-objects: convert to struct object_id
      Convert remaining callers of lookup_blob to object_id
      Convert lookup_blob to struct object_id
      tree: convert read_tree_1 to use struct object_id internally
      builtin/reflog: convert tree_is_complete to take struct object_id
      Convert lookup_tree to struct object_id
      log-tree: convert to struct object_id
      Convert lookup_tag to struct object_id
      Convert the verify_pack callback to struct object_id
      Convert struct ref_array_item to struct object_id
      ref-filter: convert some static functions to struct object_id
      refs: convert struct ref_update to use struct object_id
      refs/files-backend: convert many internals to struct object_id
      http-push: convert process_ls_object and descendants to object_id
      revision: rename add_pending_sha1 to add_pending_oid
      revision: convert remaining parse_object callers to object_id
      upload-pack: convert remaining parse_object callers to object_id
      sha1_name: convert internals of peel_onion to object_id
      builtin/read-tree: convert to struct object_id
      builtin/ls-files: convert overlay_tree_on_cache to object_id
      sequencer: convert fast_forward_to to struct object_id
      merge: convert checkout_fast_forward to struct object_id
      builtin/ls-tree: convert to struct object_id
      diff-lib: convert do_diff_cache to struct object_id
      sequencer: convert do_recursive_merge to struct object_id
      tree: convert parse_tree_indirect to struct object_id
      object: convert parse_object* to take struct object_id
      builtin/log: honor log.decorate
      notes: convert internal structures to struct object_id
      notes: convert internal parts to struct object_id
      notes: convert for_each_note to struct object_id
      notes: make get_note return pointer to struct object_id
      notes: convert format_display_notes to struct object_id
      builtin/notes: convert to struct object_id
      notes: convert some accessor functions to struct object_id

xiaoqiang zhao (1):
      send-email: --batch-size to work around some SMTP server limit

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (77):
      tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
      clone: add a --no-tags option to clone without tags
      tests: rename a test having to do with shallow submodules
      config.mak.uname: set NO_REGEX=3DNeedsStartEnd on AIX
      doc: replace a couple of broken gmane links
      tests: fix tests broken under GETTEXT_POISON=3DYesPlease
      perf: add function to setup a fresh test repo
      perf: add test showing exponential growth in path globbing
      config: match both symlink & realpath versions in IncludeIf.gitdir:=
*
      Makefile & configure: reword inaccurate comment about PCRE
      grep & rev-list doc: stop promising libpcre for --perl-regexp
      test-lib: rename the LIBPCRE prerequisite to PCRE
      log: add exhaustive tests for pattern style options & config
      log: make --regexp-ignore-case work with --perl-regexp
      grep: add a test asserting that --perl-regexp dies when !PCRE
      grep: add a test for backreferences in PCRE patterns
      grep: change non-ASCII -i test to stop using --debug
      grep: add tests for --threads=3DN and grep.threads
      grep: amend submodule recursion test for regex engine testing
      grep: add tests for grep pattern types being passed to submodules
      grep: add a test helper function for less verbose -f \0 tests
      grep: prepare for testing binary regexes containing rx metacharacte=
rs
      grep: add tests to fix blind spots with \0 patterns
      perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
      perf: emit progress output when unpacking & building
      sha1dc: update from upstream
      tag: duplicate mention of --contains should mention --no-contains
      perf: add a comparison test of grep regex engines
      perf: add a comparison test of grep regex engines with -F
      perf: add a comparison test of log --grep regex engines
      perf: add a comparison test of log --grep regex engines with -F
      grep: catch a missing enum in switch statement
      grep: remove redundant regflags assignments
      grep: factor test for \0 in grep patterns into a function
      grep: change the internal PCRE macro names to be PCRE1
      grep: change internal *pcre* variable & function names to be *pcre1=
*
      grep: move is_fixed() earlier to avoid forward declaration
      test-lib: add a PTHREADS prerequisite
      pack-objects & index-pack: add test for --threads warning
      pack-objects: fix buggy warning about threads
      grep: given --threads with NO_PTHREADS=3DYesPlease, warn
      grep: assert that threading is enabled when calling grep_{lock,unlo=
ck}
      grep: don't redundantly compile throwaway patterns under threading
      grep: skip pthreads overhead when using one thread
      log: add -P as a synonym for --perl-regexp
      grep: add support for the PCRE v1 JIT API
      grep: un-break building with PCRE < 8.32
      grep: un-break building with PCRE < 8.20
      wildmatch test: remove redundant duplicate test
      C style: use standard style for "TRANSLATORS" comments
      grep: un-break building with PCRE >=3D 8.32 without --enable-jit
      grep: add support for PCRE v2
      perf: work around the tested repo having an index.lock
      sha1dc: update from upstream
      git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); pt=
r =3D NULL
      wildmatch test: cover a blind spot in "/" matching
      coccinelle: add a rule to make "type" code use FREE_AND_NULL()
      coccinelle: make use of the "type" FREE_AND_NULL() rule
      coccinelle: add a rule to make "expression" code use FREE_AND_NULL(=
)
      coccinelle: make use of the "expression" FREE_AND_NULL() rule
      *.[ch] refactoring: make use of the FREE_AND_NULL() macro
      grep: fix erroneously copy/pasted variable in check/assert pattern
      die(): stop hiding errors due to overzealous recursion guard
      wildmatch: remove unused wildopts parameter
      strbuf.h comment: discuss strbuf_addftime() arguments in order
      grep: remove redundant double assignment to 0
      grep: adjust a redundant grep pattern type assignment
      grep: remove redundant "fixed" field re-assignment to 0
      grep: remove redundant and verbose re-assignments to 0
      grep: remove regflags from the public grep_opt API
      grep: remove redundant REG_NEWLINE when compiling fixed regex
      strbuf: change an always NULL/"" strbuf_addftime() param to bool
      sha1dc: update from upstream
      sha1dc: optionally use sha1collisiondetection as a submodule
      RelNotes: mention "log: add -P as a synonym for --perl-regexp"
      RelNotes: mention "log: make --regexp-ignore-case work with --perl-=
regexp"
      RelNotes: mention "sha1dc: optionally use sha1collisiondetection as=
 a submodule"

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (1):
      doc: git-reset: fix a trivial typo

