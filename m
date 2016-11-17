Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAEE41FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbcKQWYL (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:24:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52356 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752173AbcKQWYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:24:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37014517A3;
        Thu, 17 Nov 2016 17:24:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=j4CA4CJkMC4Yh0ZqHh3ClDPSa
        R4=; b=N7BZD7+4mIbwdHM5FoekSnjlgCaFKgw2rQtZ4OlV9l5PbypuLqY5UpyGK
        +2xz4MFMRRM2Ag91WryOpKQcVvlZgA+qDNPls38A9pNpG4HJvt5u3pyB3W2qtpUa
        brOAF/MqcDLvk1ObXZDERowfXSP6RwJ56RrpTPBuw93tApMgPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=TmwS6Ub82Rr5DnozcNy
        SOOtTVAx/TNDQWrQtvlPPodYWkPyeZKmRP4mthaOgLssqVy84nl2YmgetXEGNRIS
        MPzC09LJSSmhvl/lYnpB/8G27LaHDkt+bUCRIcbQaV8qkib9v76cAmXzDmPvlAsM
        KMzPVnMj4RCkG2E8OIPeIIj8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F1D1517A2;
        Thu, 17 Nov 2016 17:24:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49A9C517A1;
        Thu, 17 Nov 2016 17:24:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.11.0-rc2
Date:   Thu, 17 Nov 2016 14:24:04 -0800
Message-ID: <xmqq4m35oid7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CB7D9CE-AD14-11E6-90AD-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.11.0-rc2 is now available for testing
at the usual places.  It is comprised of 646 non-merge commits
since v2.10.0, contributed by 68 people, 14 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.11.0-rc2' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.10.0 are as follows.
Welcome to the Git development community!

  Aaron M Watson, Brandon Williams, Brian Henderson, Emily Xie,
  Gavin Lambert, Ian Kelling, Jeff Hostetler, Mantas Mikul=C4=97nas,
  Petr Stodulka, Satoshi Yasushima, Stefan Christ, Vegard Nossum,
  yaras, and Younes Khoudli.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alexander Shopov, Alex Henrie,
  Alex Riesen, Anders Kaseorg, Andreas Schwab, Beat Bolli, Ben
  North, brian m. carlson, Chris Packham, Christian Couder, David
  Aguilar, David Turner, Dennis Kaarsemaker, Dimitriy Ryazantcev,
  Elia Pinto, Eric Wong, Jacob Keller, Jakub Nar=C4=99bski, Jean-No=C3=AB=
l
  AVILA, Jeff King, Jiang Xin, Johannes Schindelin, Johannes Sixt,
  Jonathan Nieder, Jonathan Tan, Josh Triplett, Junio C Hamano,
  Karsten Blees, Kevin Daudt, Kirill Smelkov, Lars Schneider,
  Linus Torvalds, Matthieu Moy, Michael Haggerty, Michael J Gruber,
  Mike Ralphson, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, Olaf Hering, =
Orgad
  Shaneh, Patrick Steinhardt, Pat Thoyts, Philip Oakley, Pranit
  Bauva, Ralf Thielow, Ray Chen, Ren=C3=A9 Scharfe, Ronnie Sahlberg,
  Stefan Beller, SZEDER G=C3=A1bor, Thomas Gummerer, Tobias Klauser,
  Vasco Almeida, and =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=
=B0=D1=83=D0=B7=D0=BE=D0=B2.

----------------------------------------------------------------

Git 2.11 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backward compatibility notes.

 * An empty string used as a pathspec element has always meant
   'everything matches', but it is too easy to write a script that
   finds a path to remove in $path and run 'git rm "$paht"' by
   mistake (when the user meant to give "$path"), which ends up
   removing everything.  This release starts warning about the
   use of an empty string that is used for 'everything matches' and
   asks users to use a more explicit '.' for that instead.

   The hope is that existing users will not mind this change, and
   eventually the warning can be turned into a hard error, upgrading
   the deprecation into removal of this (mis)feature.

 * The historical argument order "git merge <msg> HEAD <commit>..."
   has been deprecated for quite some time, and will be removed in the
   next release (not this one).

 * The default abbreviation length, which has historically been 7, now
   scales as the repository grows, using the approximate number of
   objects in the repository and a bit of math around the birthday
   paradox.  The logic suggests to use 12 hexdigits for the Linux
   kernel, and 9 to 10 for Git itself.


Updates since v2.10
-------------------

UI, Workflows & Features

 * Comes with new version of git-gui, now at its 0.21.0 tag.

 * "git format-patch --cover-letter HEAD^" to format a single patch
   with a separate cover letter now numbers the output as [PATCH 0/1]
   and [PATCH 1/1] by default.

 * An incoming "git push" that attempts to push too many bytes can now
   be rejected by setting a new configuration variable at the receiving
   end.

 * "git nosuchcommand --help" said "No manual entry for gitnosuchcommand"=
,
   which was not intuitive, given that "git nosuchcommand" said "git:
   'nosuchcommand' is not a git command".

 * "git clone --recurse-submodules --reference $path $URL" is a way to
   reduce network transfer cost by borrowing objects in an existing
   $path repository when cloning the superproject from $URL; it
   learned to also peek into $path for presence of corresponding
   repositories of submodules and borrow objects from there when able.

 * The "git diff --submodule=3D{short,log}" mechanism has been enhanced
   to allow "--submodule=3Ddiff" to show the patch between the submodule
   commits bound to the superproject.

 * Even though "git hash-objects", which is a tool to take an
   on-filesystem data stream and put it into the Git object store,
   allowed to perform the "outside-world-to-Git" conversions (e.g.
   end-of-line conversions and application of the clean-filter), and
   it had the feature on by default from very early days, its reverse
   operation "git cat-file", which takes an object from the Git object
   store and externalize for the consumption by the outside world,
   lacked an equivalent mechanism to run the "Git-to-outside-world"
   conversion.  The command learned the "--filters" option to do so.

 * Output from "git diff" can be made easier to read by selecting
   which lines are common and which lines are added/deleted
   intelligently when the lines before and after the changed section
   are the same.  A command line option is added to help with the
   experiment to find a good heuristics.

 * In some projects, it is common to use "[RFC PATCH]" as the subject
   prefix for a patch meant for discussion rather than application.  A
   new option "--rfc" is a short-hand for "--subject-prefix=3DRFC PATCH"
   to help the participants of such projects.

 * "git add --chmod=3D+x <pathspec>" added recently only toggled the
   executable bit for paths that are either new or modified. This has
   been corrected to flip the executable bit for all paths that match
   the given pathspec.

 * When "git format-patch --stdout" output is placed as an in-body
   header and it uses the RFC2822 header folding, "git am" failed to
   put the header line back into a single logical line.  The
   underlying "git mailinfo" was taught to handle this properly.

 * "gitweb" can spawn "highlight" to show blob contents with
   (programming) language-specific syntax highlighting, but only
   when the language is known.  "highlight" can however be told
   to make the guess itself by giving it "--force" option, which
   has been enabled.

 * "git gui" l10n to Portuguese.

 * When given an abbreviated object name that is not (or more
   realistically, "no longer") unique, we gave a fatal error
   "ambiguous argument".  This error is now accompanied by a hint that
   lists the objects beginning with the given prefix.  During the
   course of development of this new feature, numerous minor bugs were
   uncovered and corrected, the most notable one of which is that we
   gave "short SHA1 xxxx is ambiguous." twice without good reason.

 * "git log rev^..rev" is an often-used revision range specification
   to show what was done on a side branch merged at rev.  This has
   gained a short-hand "rev^-1".  In general "rev^-$n" is the same as
   "^rev^$n rev", i.e. what has happened on other branches while the
   history leading to nth parent was looking the other way.

 * In recent versions of cURL, GSSAPI credential delegation is
   disabled by default due to CVE-2011-2192; introduce a configuration
   to selectively allow enabling this.
   (merge 26a7b23429 ps/http-gssapi-cred-delegation later to maint).

 * "git mergetool" learned to honor "-O<orderfile>" to control the
   order of paths to present to the end user.

 * "git diff/log --ws-error-highlight=3D<kind>" lacked the corresponding
   configuration variable to set it by default.

 * "git ls-files" learned "--recurse-submodules" option that can be
   used to get a listing of tracked files across submodules (i.e. this
   only works with "--cached" option, not for listing untracked or
   ignored files).  This would be a useful tool to sit on the upstream
   side of a pipe that is read with xargs to work on all working tree
   files from the top-level superproject.

 * A new credential helper that talks via "libsecret" with
   implementations of XDG Secret Service API has been added to
   contrib/credential/.

 * The GPG verification status shown in "%G?" pretty format specifier
   was not rich enough to differentiate a signature made by an expired
   key, a signature made by a revoked key, etc.  New output letters
   have been assigned to express them.

 * In addition to purely abbreviated commit object names, "gitweb"
   learned to turn "git describe" output (e.g. v2.9.3-599-g2376d31787)
   into clickable links in its output.

 * When new paths were added by "git add -N" to the index, it was
   enough to circumvent the check by "git commit" to refrain from
   making an empty commit without "--allow-empty".  The same logic
   prevented "git status" to show such a path as "new file" in the
   "Changes not staged for commit" section.

 * The smudge/clean filter API expect an external process is spawned
   to filter the contents for each path that has a filter defined.  A
   new type of "process" filter API has been added to allow the first
   request to run the filter for a path to spawn a single process, and
   all filtering need is served by this single process for multiple
   paths, reducing the process creation overhead.

 * The user always has to say "stash@{$N}" when naming a single
   element in the default location of the stash, i.e. reflogs in
   refs/stash.  The "git stash" command learned to accept "git stash
   apply 4" as a short-hand for "git stash apply stash@{4}".


Performance, Internal Implementation, Development Support etc.

 * The delta-base-cache mechanism has been a key to the performance in
   a repository with a tightly packed packfile, but it did not scale
   well even with a larger value of core.deltaBaseCacheLimit.

 * Enhance "git status --porcelain" output by collecting more data on
   the state of the index and the working tree files, which may
   further be used to teach git-prompt (in contrib/) to make fewer
   calls to git.

 * Extract a small helper out of the function that reads the authors
   script file "git am" internally uses.
   (merge a77598e jc/am-read-author-file later to maint).

 * Lifts calls to exit(2) and die() higher in the callchain in
   sequencer.c files so that more helper functions in it can be used
   by callers that want to handle error conditions themselves.

 * "git am" has been taught to make an internal call to "git apply"'s
   innards without spawning the latter as a separate process.

 * The ref-store abstraction was introduced to the refs API so that we
   can plug in different backends to store references.

 * The "unsigned char sha1[20]" to "struct object_id" conversion
   continues.  Notable changes in this round includes that ce->sha1,
   i.e. the object name recorded in the cache_entry, turns into an
   object_id.

 * JGit can show a fake ref "capabilities^{}" to "git fetch" when it
   does not advertise any refs, but "git fetch" was not prepared to
   see such an advertisement.  When the other side disconnects without
   giving any ref advertisement, we used to say "there may not be a
   repository at that URL", but we may have seen other advertisement
   like "shallow" and ".have" in which case we definitely know that a
   repository is there.  The code to detect this case has also been
   updated.

 * Some codepaths in "git pack-objects" were not ready to use an
   existing pack bitmap; now they are and as the result they have
   become faster.

 * The codepath in "git fsck" to detect malformed tree objects has
   been updated not to die but keep going after detecting them.

 * We call "qsort(array, nelem, sizeof(array[0]), fn)", and most of
   the time third parameter is redundant.  A new QSORT() macro lets us
   omit it.

 * "git pack-objects" in a repository with many packfiles used to
   spend a lot of time looking for/at objects in them; the accesses to
   the packfiles are now optimized by checking the most-recently-used
   packfile first.
   (merge c9af708b1a jk/pack-objects-optim-mru later to maint).

 * Codepaths involved in interacting alternate object store have
   been cleaned up.

 * In order for the receiving end of "git push" to inspect the
   received history and decide to reject the push, the objects sent
   from the sending end need to be made available to the hook and
   the mechanism for the connectivity check, and this was done
   traditionally by storing the objects in the receiving repository
   and letting "git gc" to expire it.  Instead, store the newly
   received objects in a temporary area, and make them available by
   reusing the alternate object store mechanism to them only while we
   decide if we accept the check, and once we decide, either migrate
   them to the repository or purge them immediately.

 * The require_clean_work_tree() helper was recreated in C when "git
   pull" was rewritten from shell; the helper is now made available to
   other callers in preparation for upcoming "rebase -i" work.

 * "git upload-pack" had its code cleaned-up and performance improved
   by reducing use of timestamp-ordered commit-list, which was
   replaced with a priority queue.

 * "git diff --no-index" codepath has been updated not to try to peek
   into .git/ directory that happens to be under the current
   directory, when we know we are operating outside any repository.

 * Update of the sequencer codebase to make it reusable to reimplement
   "rebase -i" continues.

 * Git generally does not explicitly close file descriptors that were
   open in the parent process when spawning a child process, but most
   of the time the child does not want to access them. As Windows does
   not allow removing or renaming a file that has a file descriptor
   open, a slow-to-exit child can even break the parent process by
   holding onto them.  Use O_CLOEXEC flag to open files in various
   codepaths.

 * Update "interpret-trailers" machinery and teaches it that people in
   real world write all sorts of crufts in the "trailer" that was
   originally designed to have the neat-o "Mail-Header: like thing"
   and nothing else.


Also contains various documentation updates and code clean-ups.


Fixes since v2.10
-----------------

Unless otherwise noted, all the fixes since v2.9 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * Clarify various ways to specify the "revision ranges" in the
   documentation.

 * "diff-highlight" script (in contrib/) learned to work better with
   "git log -p --graph" output.

 * The test framework left the number of tests and success/failure
   count in the t/test-results directory, keyed by the name of the
   test script plus the process ID.  The latter however turned out not
   to serve any useful purpose.  The process ID part of the filename
   has been removed.

 * Having a submodule whose ".git" repository is somehow corrupt
   caused a few commands that recurse into submodules loop forever.

 * "git symbolic-ref -d HEAD" happily removes the symbolic ref, but
   the resulting repository becomes an invalid one.  Teach the command
   to forbid removal of HEAD.

 * A test spawned a short-lived background process, which sometimes
   prevented the test directory from getting removed at the end of the
   script on some platforms.

 * Update a few tests that used to use GIT_CURL_VERBOSE to use the
   newer GIT_TRACE_CURL.

 * "git pack-objects --include-tag" was taught that when we know that
   we are sending an object C, we want a tag B that directly points at
   C but also a tag A that points at the tag B.  We used to miss the
   intermediate tag B in some cases.

 * Update Japanese translation for "git-gui".

 * "git fetch http::/site/path" did not die correctly and segfaulted
   instead.

 * "git commit-tree" stopped reading commit.gpgsign configuration
   variable that was meant for Porcelain "git commit" in Git 2.9; we
   forgot to update "git gui" to look at the configuration to match
   this change.

 * "git add --chmod=3D+x" added recently lacked documentation, which has
   been corrected.

 * "git log --cherry-pick" used to include merge commits as candidates
   to be matched up with other commits, resulting a lot of wasted time.
   The patch-id generation logic has been updated to ignore merges to
   avoid the wastage.

 * The http transport (with curl-multi option, which is the default
   these days) failed to remove curl-easy handle from a curlm session,
   which led to unnecessary API failures.

 * There were numerous corner cases in which the configuration files
   are read and used or not read at all depending on the directory a
   Git command was run, leading to inconsistent behaviour.  The code
   to set-up repository access at the beginning of a Git process has
   been updated to fix them.
   (merge 4d0efa1 jk/setup-sequence-update later to maint).

 * "git diff -W" output needs to extend the context backward to
   include the header line of the current function and also forward to
   include the body of the entire current function up to the header
   line of the next one.  This process may have to merge two adjacent
   hunks, but the code forgot to do so in some cases.

 * Performance tests done via "t/perf" did not use the same set of
   build configuration if the user relied on autoconf generated
   configuration.

 * "git format-patch --base=3D..." feature that was recently added
   showed the base commit information after "-- " e-mail signature
   line, which turned out to be inconvenient.  The base information
   has been moved above the signature line.

 * More i18n.

 * Even when "git pull --rebase=3Dpreserve" (and the underlying "git
   rebase --preserve") can complete without creating any new commit
   (i.e. fast-forwards), it still insisted on having a usable ident
   information (read: user.email is set correctly), which was less
   than nice.  As the underlying commands used inside "git rebase"
   would fail with a more meaningful error message and advice text
   when the bogus ident matters, this extra check was removed.

 * "git gc --aggressive" used to limit the delta-chain length to 250,
   which is way too deep for gaining additional space savings and is
   detrimental for runtime performance.  The limit has been reduced to
   50.

 * Documentation for individual configuration variables to control use
   of color (like `color.grep`) said that their default value is
   'false', instead of saying their default is taken from `color.ui`.
   When we updated the default value for color.ui from 'false' to
   'auto' quite a while ago, all of them broke.  This has been
   corrected.

 * The pretty-format specifier "%C(auto)" used by the "log" family of
   commands to enable coloring of the output is taught to also issue a
   color-reset sequence to the output.

 * A shell script example in check-ref-format documentation has been
   fixed.

 * "git checkout <word>" does not follow the usual disambiguation
   rules when the <word> can be both a rev and a path, to allow
   checking out a branch 'foo' in a project that happens to have a
   file 'foo' in the working tree without having to disambiguate.
   This was poorly documented and the check was incorrect when the
   command was run from a subdirectory.

 * Some codepaths in "git diff" used regexec(3) on a buffer that was
   mmap(2)ed, which may not have a terminating NUL, leading to a read
   beyond the end of the mapped region.  This was fixed by introducing
   a regexec_buf() helper that takes a <ptr,len> pair with REG_STARTEND
   extension.

 * The procedure to build Git on Mac OS X for Travis CI hardcoded the
   internal directory structure we assumed HomeBrew uses, which was a
   no-no.  The procedure has been updated to ask HomeBrew things we
   need to know to fix this.

 * When "git rebase -i" is given a broken instruction, it told the
   user to fix it with "--edit-todo", but didn't say what the step
   after that was (i.e. "--continue").

 * Documentation around tools to import from CVS was fairly outdated.

 * "git clone --recurse-submodules" lost the progress eye-candy in
   recent update, which has been corrected.

 * A low-level function verify_packfile() was meant to show errors
   that were detected without dying itself, but under some conditions
   it didn't and died instead, which has been fixed.

 * When "git fetch" tries to find where the history of the repository
   it runs in has diverged from what the other side has, it has a
   mechanism to avoid digging too deep into irrelevant side branches.
   This however did not work well over the "smart-http" transport due
   to a design bug, which has been fixed.

 * In the codepath that comes up with the hostname to be used in an
   e-mail when the user didn't tell us, we looked at ai_canonname
   field in struct addrinfo without making sure it is not NULL first.

 * "git worktree", even though it used the default_abbrev setting that
   ought to be affected by core.abbrev configuration variable, ignored
   the variable setting.  The command has been taught to read the
   default set of configuration variables to correct this.

 * "git init" tried to record core.worktree in the repository's
   'config' file when GIT_WORK_TREE environment variable was set and
   it was different from where GIT_DIR appears as ".git" at its top,
   but the logic was faulty when .git is a "gitdir:" file that points
   at the real place, causing trouble in working trees that are
   managed by "git worktree".  This has been corrected.

 * Codepaths that read from an on-disk loose object were too loose in
   validating what they are reading is a proper object file and
   sometimes read past the data they read from the disk, which has
   been corrected.  H/t to Gustavo Grieco for reporting.

 * The original command line syntax for "git merge", which was "git
   merge <msg> HEAD <parent>...", has been deprecated for quite some
   time, and "git gui" was the last in-tree user of the syntax.  This
   is finally fixed, so that we can move forward with the deprecation.

 * An author name, that spelled a backslash-quoted double quote in the
   human readable part "My \"double quoted\" name", was not unquoted
   correctly while applying a patch from a piece of e-mail.

 * Doc update to clarify what "log -3 --reverse" does.

 * Almost everybody uses DEFAULT_ABBREV to refer to the default
   setting for the abbreviation, but "git blame" peeked into
   underlying variable bypassing the macro for no good reason.

 * The "graph" API used in "git log --graph" miscounted the number of
   output columns consumed so far when drawing a padding line, which
   has been fixed; this did not affect any existing code as nobody
   tried to write anything after the padding on such a line, though.

 * The code that parses the format parameter of for-each-ref command
   has seen a micro-optimization.

 * When we started cURL to talk to imap server when a new enough
   version of cURL library is available, we forgot to explicitly add
   imap(s):// before the destination.  To some folks, that didn't work
   and the library tried to make HTTP(s) requests instead.

 * The ./configure script generated from configure.ac was taught how
   to detect support of SSL by libcurl better.

 * The command-line completion script (in contrib/) learned to
   complete "git cmd ^mas<HT>" to complete the negative end of
   reference to "git cmd ^master".
   (merge 49416ad22a cp/completion-negative-refs later to maint).

 * The existing "git fetch --depth=3D<n>" option was hard to use
   correctly when making the history of an existing shallow clone
   deeper.  A new option, "--deepen=3D<n>", has been added to make this
   easier to use.  "git clone" also learned "--shallow-since=3D<date>"
   and "--shallow-exclude=3D<tag>" options to make it easier to specify
   "I am interested only in the recent N months worth of history" and
   "Give me only the history since that version".
   (merge cccf74e2da nd/shallow-deepen later to maint).

 * It is a common mistake to say "git blame --reverse OLD path",
   expecting that the command line is dwimmed as if asking how lines
   in path in an old revision OLD have survived up to the current
   commit.
   (merge e1d09701a4 jc/blame-reverse later to maint).

 * http.emptyauth configuration is a way to allow an empty username to
   pass when attempting to authenticate using mechanisms like
   Kerberos.  We took an unspecified (NULL) username and sent ":"
   (i.e. no username, no password) to CURLOPT_USERPWD, but did not do
   the same when the username is explicitly set to an empty string.

 * "git clone" of a local repository can be done at the filesystem
   level, but the codepath did not check errors while copying and
   adjusting the file that lists alternate object stores.

 * Documentation for "git commit" was updated to clarify that "commit
   -p <paths>" adds to the current contents of the index to come up
   with what to commit.

 * A stray symbolic link in $GIT_DIR/refs/ directory could make name
   resolution loop forever, which has been corrected.

 * The "submodule.<name>.path" stored in .gitmodules is never copied
   to .git/config and such a key in .git/config has no meaning, but
   the documentation described it and submodule.<name>.url next to
   each other as if both belong to .git/config.  This has been fixed.

 * In a worktree connected to a repository elsewhere, created via "git
   worktree", "git checkout" attempts to protect users from confusion
   by refusing to check out a branch that is already checked out in
   another worktree.  However, this also prevented checking out a
   branch, which is designated as the primary branch of a bare
   reopsitory, in a worktree that is connected to the bare
   repository.  The check has been corrected to allow it.

 * "git rebase" immediately after "git clone" failed to find the fork
   point from the upstream.

 * When fetching from a remote that has many tags that are irrelevant
   to branches we are following, we used to waste way too many cycles
   when checking if the object pointed at by a tag (that we are not
   going to fetch!) exists in our repository too carefully.

 * Protect our code from over-eager compilers.

 * Recent git allows submodule.<name>.branch to use a special token
   "." instead of the branch name; the documentation has been updated
   to describe it.

 * A hot-fix for a test added by a recent topic that went to both
   'master' and 'maint' already.

 * "git send-email" attempts to pick up valid e-mails from the
   trailers, but people in real world write non-addresses there, like
   "Cc: Stable <add@re.ss> # 4.8+", which broke the output depending
   on the availability and vintage of Mail::Address perl module.
   (merge dcfafc5214 mm/send-email-cc-cruft-after-address later to maint)=
.

 * The Travis CI configuration we ship ran the tests with --verbose
   option but this risks non-TAP output that happens to be "ok" to be
   misinterpreted as TAP signalling a test that passed.  This resulted
   in unnecessary failure.  This has been corrected by introducing a
   new mode to run our tests in the test harness to send the verbose
   output separately to the log file.

 * Some AsciiDoc formatter mishandles a displayed illustration with
   tabs in it.  Adjust a few of them in merge-base documentation to
   work around them.

 * A minor regression fix for "git submodule" that was introduced
   when more helper functions were reimplemented in C.
   (merge 77b63ac31e sb/submodule-ignore-trailing-slash later to maint).

 * The code that we have used for the past 10+ years to cycle
   4-element ring buffers turns out to be not quite portable in
   theoretical world.
   (merge bb84735c80 rs/ring-buffer-wraparound later to maint).

 * "git daemon" used fixed-length buffers to turn URL to the
   repository the client asked for into the server side directory
   path, using snprintf() to avoid overflowing these buffers, but
   allowed possibly truncated paths to the directory.  This has been
   tightened to reject such a request that causes overlong path to be
   required to serve.
   (merge 6bdb0083be jk/daemon-path-ok-check-truncation later to maint).

 * Recent update to git-sh-setup (a library of shell functions that
   are used by our in-tree scripted Porcelain commands) included
   another shell library git-sh-i18n without specifying where it is,
   relying on the $PATH.  This has been fixed to be more explicit by
   prefixing $(git --exec-path) output in front.
   (merge 1073094f30 ak/sh-setup-dot-source-i18n-fix later to maint).

 * Fix for a racy false-positive test failure.
   (merge fdf4f6c79b as/merge-attr-sleep later to maint).

 * Portability update and workaround for builds on recent Mac OS X.
   (merge a296bc0132 ls/macos-update later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge 5c238e29a8 jk/common-main later to maint).
   (merge 5a5749e45b ak/pre-receive-hook-template-modefix later to maint)=
.
   (merge 6d834ac8f1 jk/rebase-config-insn-fmt-docfix later to maint).
   (merge de9f7fa3b0 rs/commit-pptr-simplify later to maint).
   (merge 4259d693fc sc/fmt-merge-msg-doc-markup-fix later to maint).
   (merge 28fab7b23d nd/test-helpers later to maint).
   (merge c2bb0c1d1e rs/cocci later to maint).
   (merge 3285b7badb ps/common-info-doc later to maint).
   (merge 2b090822e8 nd/worktree-lock later to maint).
   (merge 4bd488ea7c jk/create-branch-remove-unused-param later to maint)=
.
   (merge 974e0044d6 tk/diffcore-delta-remove-unused later to maint).

----------------------------------------------------------------

Changes since v2.10.0 are as follows:

Aaron M Watson (1):
      stash: allow stashes to be referenced by index only

Alex Henrie (5):
      am: put spaces around pipe in usage string
      cat-file: put spaces around pipes in usage string
      git-rebase--interactive: fix English grammar
      git-merge-octopus: do not capitalize "octopus"
      unpack-trees: do not capitalize "working"

Alex Riesen (2):
      git-gui: support for $FILENAMES in tool definitions
      git-gui: ensure the file in the diff pane is in the list of selecte=
d files

Alexander Shopov (2):
      git-gui i18n: Updated Bulgarian translation (565,0f,0u)
      git-gui: Mark 'All' in remote.tcl for translation

Anders Kaseorg (3):
      imap-send: Tell cURL to use imap:// or imaps://
      pre-receive.sample: mark it executable
      git-sh-setup: be explicit where to dot-source git-sh-i18n from.

Andreas Schwab (2):
      t6026-merge-attr: don't fail if sleep exits early
      t6026-merge-attr: ensure that the merge driver was called

Beat Bolli (1):
      SubmittingPatches: use gitk's "Copy commit summary" format

Ben North (1):
      git-worktree.txt: fix typo "to"/"two", and add comma

Brandon Williams (6):
      pathspec: remove unnecessary function prototypes
      git: make super-prefix option
      ls-files: optionally recurse into submodules
      ls-files: pass through safe options for --recurse-submodules
      ls-files: add pathspec matching for submodules
      submodules doc: update documentation for "." used for submodule bra=
nches

Brian Henderson (3):
      diff-highlight: add some tests
      diff-highlight: add failing test for handling --graph output
      diff-highlight: add support for --graph output

Chris Packham (1):
      completion: support excluding refs

Christian Couder (43):
      apply: make some names more specific
      apply: move 'struct apply_state' to apply.h
      builtin/apply: make apply_patch() return -1 or -128 instead of die(=
)ing
      builtin/apply: read_patch_file() return -1 instead of die()ing
      builtin/apply: make find_header() return -128 instead of die()ing
      builtin/apply: make parse_chunk() return a negative integer on erro=
r
      builtin/apply: make parse_single_patch() return -1 on error
      builtin/apply: make parse_whitespace_option() return -1 instead of =
die()ing
      builtin/apply: make parse_ignorewhitespace_option() return -1 inste=
ad of die()ing
      builtin/apply: move init_apply_state() to apply.c
      apply: make init_apply_state() return -1 instead of exit()ing
      builtin/apply: make check_apply_state() return -1 instead of die()i=
ng
      builtin/apply: move check_apply_state() to apply.c
      builtin/apply: make apply_all_patches() return 128 or 1 on error
      builtin/apply: make parse_traditional_patch() return -1 on error
      builtin/apply: make gitdiff_*() return 1 at end of header
      builtin/apply: make gitdiff_*() return -1 on error
      builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
      builtin/apply: make build_fake_ancestor() return -1 on error
      builtin/apply: make remove_file() return -1 on error
      builtin/apply: make add_conflicted_stages_file() return -1 on error
      builtin/apply: make add_index_file() return -1 on error
      builtin/apply: make create_file() return -1 on error
      builtin/apply: make write_out_one_result() return -1 on error
      builtin/apply: make write_out_results() return -1 on error
      unpack-objects: add --max-input-size=3D<size> option
      builtin/apply: make try_create_file() return -1 on error
      builtin/apply: make create_one_file() return -1 on error
      builtin/apply: rename option parsing functions
      apply: rename and move opt constants to apply.h
      apply: move libified code from builtin/apply.c to apply.{c,h}
      apply: make some parsing functions static again
      apply: use error_errno() where possible
      apply: make it possible to silently apply
      apply: don't print on stdout in verbosity_silent mode
      usage: add set_warn_routine()
      usage: add get_error_routine() and get_warn_routine()
      apply: change error_routine when silent
      apply: refactor `git apply` option parsing
      apply: pass apply state to build_fake_ancestor()
      apply: learn to use a different index file
      builtin/am: use apply API in run_apply()
      split-index: s/eith/with/ typo fix

David Aguilar (4):
      mergetool: add copyright
      mergetool: move main program flow into a main() function
      mergetool: honor diff.orderFile
      mergetool: honor -O<orderfile>

David Turner (11):
      rename_ref_available(): add docstring
      refs: add methods for reflog
      refs: add method for initial ref transaction commit
      refs: make delete_refs() virtual
      refs: add methods to init refs db
      refs: add method to rename refs
      refs: make lock generic
      refs: implement iteration over only per-worktree refs
      add David Turner's Two Sigma address
      fsck: handle bad trees like other errors
      http: http.emptyauth should allow empty (not just NULL) usernames

Dennis Kaarsemaker (1):
      worktree: allow the main brach of a bare repository to be checked o=
ut

Dimitriy Ryazantcev (2):
      l10n: ru.po: update Russian translation
      git-gui: Update Russian translation

Elia Pinto (6):
      t5541-http-push-smart.sh: use the GIT_TRACE_CURL environment var
      test-lib.sh: preserve GIT_TRACE_CURL from the environment
      t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
      t5551-http-fetch-smart.sh: use the GIT_TRACE_CURL environment var
      git-check-ref-format.txt: fixup documentation
      git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for c=
ommand substitution

Emily Xie (1):
      pathspec: warn on empty strings as pathspec

Eric Wong (5):
      http: warn on curl_multi_add_handle failures
      http: consolidate #ifdefs for curl_multi_remove_handle
      http: always remove curl easy from curlm session on release
      git-svn: reduce scope of input record separator change
      git-svn: "git worktree" awareness

Gavin Lambert (1):
      git-svn: do not reuse caches memoized for a different architecture

Ian Kelling (2):
      gitweb: remove unused guess_file_syntax() parameter
      gitweb: use highlight's shebang detection

Jacob Keller (9):
      format-patch: show 0/1 and 1/1 for singleton patch with cover lette=
r
      cache: add empty_tree_oid object and helper function
      graph: add support for --line-prefix on all graph-aware output
      diff: prepare for additional submodule formats
      allow do_submodule_path to work even if submodule isn't checked out
      submodule: convert show_submodule_summary to use struct object_id *
      submodule: refactor show_submodule_summary with helper function
      diff: teach diff to display submodule difference with an inline dif=
f
      rev-list: use hdr_termination instead of a always using a newline

Jakub Nar=C4=99bski (1):
      configure.ac: improve description of NO_REGEX test

Jean-No=C3=ABl AVILA (1):
      i18n: i18n: diff: mark die messages for translation

Jeff Hostetler (9):
      status: rename long-format print routines
      status: cleanup API to wt_status_print
      status: support --porcelain[=3D<version>]
      status: collect per-file data for --porcelain=3Dv2
      status: print per-file porcelain v2 status data
      status: print branch info with --porcelain=3Dv2 --branch
      git-status.txt: describe --porcelain=3Dv2 format
      test-lib-functions.sh: add lf_to_nul helper
      status: unit tests for --porcelain=3Dv2

Jeff King (116):
      rebase-interactive: drop early check for valid ident
      provide an initializer for "struct object_info"
      sha1_file: make packed_object_info public
      pack-objects: break delta cycles before delta-search phase
      pack-objects: use mru list when iterating over packs
      gc: default aggressive depth to 50
      cache_or_unpack_entry: drop keep_cache parameter
      clear_delta_base_cache_entry: use a more descriptive name
      release_delta_base_cache: reuse existing detach function
      delta_base_cache: use list.h for LRU
      delta_base_cache: drop special treatment of blobs
      delta_base_cache: use hashmap.h
      t/perf: add basic perf tests for delta base cache
      index-pack: add --max-input-size=3D<size> option
      receive-pack: allow a maximum input size to be specified
      test-lib: drop PID from test-results/*.count
      diff-highlight: ignore test cruft
      diff-highlight: add multi-byte tests
      diff-highlight: avoid highlighting combined diffs
      error_errno: use constant return similar to error()
      color_parse_mem: initialize "struct color" temporary
      t5305: move cleanup into test block
      t5305: drop "dry-run" of unpack-objects
      t5305: use "git -C"
      t5305: simplify packname handling
      pack-objects: walk tag chains for --include-tag
      remote-curl: handle URLs without protocol
      patch-ids: turn off rename detection
      add_delta_base_cache: use list_for_each_safe
      patch-ids: refuse to compute patch-id for merge commit
      hash-object: always try to set up the git repository
      patch-id: use RUN_SETUP_GENTLY
      diff: skip implicit no-index check when given --no-index
      diff: handle --no-index prefixes consistently
      diff: always try to set up the repository
      pager: remove obsolete comment
      pager: stop loading git_default_config()
      pager: make pager_program a file-local static
      pager: use callbacks instead of configset
      pager: handle early config
      t1302: use "git -C"
      test-config: setup git directory
      config: only read .git/config from configured repos
      init: expand comments explaining config trickery
      init: reset cached config when entering new repo
      t1007: factor out repeated setup
      verify_packfile: check pack validity before accessing data
      clone: pass --progress decision to recursive submodules
      docs/cvsimport: prefer cvs-fast-export to parsecvs
      docs/cvs-migration: update link to cvsps homepage
      docs/cvs-migration: mention cvsimport caveats
      ident: handle NULL ai_canonname
      get_sha1: detect buggy calls with multiple disambiguators
      get_sha1: avoid repeating ourselves via ONLY_TO_DIE
      get_sha1: propagate flags to child functions
      get_short_sha1: parse tags when looking for treeish
      get_short_sha1: refactor init of disambiguation code
      get_short_sha1: NUL-terminate hex prefix
      get_short_sha1: mark ambiguity error for translation
      sha1_array: let callbacks interrupt iteration
      for_each_abbrev: drop duplicate objects
      get_short_sha1: list ambiguous objects on error
      xdiff: rename "struct group" to "struct xdlgroup"
      get_short_sha1: make default disambiguation configurable
      tree-walk: be more specific about corrupt tree errors
      graph: fix extra spaces in graph_padding_line
      t5613: drop reachable_via function
      t5613: drop test_valid_repo function
      t5613: use test_must_fail
      t5613: whitespace/style cleanups
      t5613: do not chdir in main process
      find_unique_abbrev: move logic out of get_short_sha1()
      clone: detect errors in normalize_path_copy
      files_read_raw_ref: avoid infinite loop on broken symlinks
      files_read_raw_ref: prevent infinite retry loops in general
      t5613: clarify "too deep" recursion tests
      link_alt_odb_entry: handle normalize_path errors
      link_alt_odb_entry: refactor string handling
      alternates: provide helper for adding to alternates list
      alternates: provide helper for allocating alternate
      alternates: encapsulate alt->base munging
      alternates: use a separate scratch space
      fill_sha1_file: write "boring" characters
      alternates: store scratch buffer as strbuf
      fill_sha1_file: write into a strbuf
      count-objects: report alternates via verbose mode
      sha1_file: always allow relative paths to alternates
      alternates: use fspathcmp to detect duplicates
      check_connected: accept an env argument
      tmp-objdir: introduce API for temporary object directories
      receive-pack: quarantine objects until pre-receive accepts
      tmp-objdir: put quarantine information in the environment
      tmp-objdir: do not migrate files starting with '.'
      upload-pack: use priority queue in reachable() check
      merge-base: handle --fork-point without reflog
      fetch: use "quick" has_sha1_file for tag following
      test-lib: handle TEST_OUTPUT_DIRECTORY with spaces
      test-lib: add --verbose-log option
      travis: use --verbose-log test option
      test-lib: bail out when "-v" used under "prove"
      daemon: detect and reject too-long paths
      read info/{attributes,exclude} only when in repository
      test-*-cache-tree: setup git dir
      find_unique_abbrev: use 4-buffer ring
      diff_unique_abbrev: rename to diff_aligned_abbrev
      diff_aligned_abbrev: use "struct oid"
      diff: handle sha1 abbreviations outside of repository
      git-compat-util: move content inside ifdef/endif guards
      doc: fix missing "::" in config list
      t0021: use write_script to create rot13 shell script
      t0021: put $TEST_ROOT in $PATH
      t0021: use $PERL_PATH for rot13-filter.pl
      t0021: fix filehandle usage on older perl
      alternates: re-allow relative paths from environment
      sequencer: silence -Wtautological-constant-out-of-range-compare
      create_branch: drop unused "head" parameter

Jiang Xin (1):
      l10n: zh_CN: fixed some typos for git 2.10.0

Johannes Schindelin (60):
      cat-file: fix a grammo in the man page
      sequencer: lib'ify sequencer_pick_revisions()
      sequencer: do not die() in do_pick_commit()
      sequencer: lib'ify write_message()
      sequencer: lib'ify do_recursive_merge()
      sequencer: lib'ify do_pick_commit()
      sequencer: lib'ify walk_revs_populate_todo()
      sequencer: lib'ify prepare_revs()
      sequencer: lib'ify read_and_refresh_cache()
      sequencer: lib'ify read_populate_todo()
      sequencer: lib'ify read_populate_opts()
      sequencer: lib'ify create_seq_dir()
      sequencer: lib'ify save_head()
      sequencer: lib'ify save_todo()
      sequencer: lib'ify save_opts()
      sequencer: lib'ify fast_forward_to()
      sequencer: lib'ify checkout_fast_forward()
      sequencer: ensure to release the lock when we could not read the in=
dex
      cat-file: introduce the --filters option
      cat-file --textconv/--filters: allow specifying the path separately
      cat-file: support --textconv/--filters in batch mode
      git-gui: respect commit.gpgsign again
      regex: -G<pattern> feeds a non NUL-terminated string to regexec() a=
nd fails
      regex: add regexec_buf() that can work on a non NUL-terminated stri=
ng
      regex: use regexec_buf()
      pull: drop confusing prefix parameter of die_on_unclean_work_tree()
      pull: make code more similar to the shell script again
      wt-status: make the require_clean_work_tree() function reusable
      wt-status: export also the has_un{staged,committed}_changes() funct=
ions
      wt-status: teach has_{unstaged,uncommitted}_changes() about submodu=
les
      wt-status: begin error messages with lower-case
      reset: fix usage
      sequencer: use static initializers for replay_opts
      sequencer: use memoized sequencer directory path
      sequencer: avoid unnecessary indirection
      sequencer: future-proof remove_sequencer_state()
      sequencer: plug memory leaks for the option values
      sequencer: future-proof read_populate_todo()
      sequencer: refactor the code to obtain a short commit name
      sequencer: completely revamp the "todo" script parsing
      sequencer: strip CR from the todo script
      sequencer: avoid completely different messages for different action=
s
      sequencer: get rid of the subcommand field
      sequencer: remember the onelines when parsing the todo file
      sequencer: prepare for rebase -i's commit functionality
      sequencer: introduce a helper to read files written by scripts
      sequencer: allow editing the commit message on a case-by-case basis
      sequencer: support amending commits
      sequencer: support cleaning up commit messages
      sequencer: left-trim lines read from the script
      sequencer: stop releasing the strbuf in write_message()
      sequencer: roll back lock file if write_message() failed
      sequencer: refactor write_message() to take a pointer/length
      sequencer: teach write_message() to append an optional LF
      sequencer: remove overzealous assumption in rebase -i mode
      sequencer: mark action_name() for translation
      sequencer: quote filenames in error messages
      sequencer: start error messages consistently with lower case
      sequencer: mark all error messages for translation
      t6026: ensure that long-running script really is

Johannes Sixt (9):
      t9903: fix broken && chain
      t6026-merge-attr: clean up background process at end of test case
      t3700-add: create subdirectory gently
      t3700-add: do not check working tree file mode without POSIXPERM
      t0060: sidestep surprising path mangling results on Windows
      t0021: expect more variations in the output of uniq -c
      t0021: compute file size with a single process instead of a pipelin=
e
      t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell variabl=
es
      t6026: clarify the point of "kill $(cat sleep.pid)"

Jonathan Nieder (1):
      connect: tighten check for unexpected early hang up

Jonathan Tan (14):
      tests: move test_lazy_prereq JGIT to test-lib.sh
      connect: advertized capability is not a ref
      mailinfo: separate in-body header processing
      mailinfo: make is_scissors_line take plain char *
      mailinfo: handle in-body header continuations
      fetch-pack: do not reset in_vain on non-novel acks
      trailer: improve const correctness
      trailer: use list.h for doubly-linked list
      trailer: streamline trailer item create and add
      trailer: make args have their own struct
      trailer: clarify failure modes in parse_trailer
      trailer: allow non-trailers in trailer block
      trailer: forbid leading whitespace in trailers
      trailer: support values folded to multiple lines

Josh Triplett (2):
      format-patch: show base info before email signature
      format-patch: add "--rfc" for the common case of [RFC PATCH]

Junio C Hamano (49):
      blame: improve diagnosis for "--reverse NEW"
      blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
      am: refactor read_author_script()
      diff.c: remove output_prefix_length field
      submodule: avoid auto-discovery in prepare_submodule_repo_env()
      symbolic-ref -d: do not allow removal of HEAD
      Prepare for 2.9.4
      Start the 2.11 cycle
      First batch for 2.11
      Second batch for 2.11
      Third batch for 2.11
      Start preparing for 2.10.1
      Fourth batch for 2.11
      streaming: make sure to notice corrupt object
      unpack_sha1_header(): detect malformed object header
      Fifth batch for 2.11
      worktree: honor configuration variables
      blame: use DEFAULT_ABBREV macro
      Prepare for 2.10.1
      Sixth batch for 2.11
      diff_unique_abbrev(): document its assumption and limitation
      abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
      abbrev: prepare for new world order
      Git 2.10.1
      Seventh batch for 2.11
      t4015: split out the "setup" part of ws-error-highlight test
      diff.c: refactor parse_ws_error_highlight()
      diff.c: move ws-error-highlight parsing helpers up
      diff: introduce diff.wsErrorHighlight option
      Eighth batch for 2.11
      Ninth batch for 2.11
      Start preparing for 2.10.2
      cocci: refactor common patterns to use xstrdup_or_null()
      Tenth batch for 2.11
      t3700: fix broken test under !SANITY
      transport: pass summary_width down the callchain
      fetch: pass summary_width down the callchain
      transport: allow summary-width to be computed dynamically
      transport: compute summary-width dynamically
      Eleventh batch for 2.11
      Getting ready for 2.11-rc0
      Git 2.10.2
      Git 2.11-rc0
      A bit of updates post -rc0
      Revert "t6026-merge-attr: ensure that the merge driver was called"
      Revert "t6026-merge-attr: don't fail if sleep exits early"
      t0021: remove debugging cruft
      Git 2.11.0-rc1
      Git 2.11-rc2

Karsten Blees (2):
      git-gui: unicode file name support on windows
      git-gui: handle the encoding of Git's output correctly

Kevin Daudt (2):
      t5100-mailinfo: replace common path prefix with variable
      mailinfo: unescape quoted-pair in header fields

Kirill Smelkov (3):
      pack-objects: respect --local/--honor-pack-keep/--incremental when =
bitmap is in use
      pack-objects: use reachability bitmap index when generating non-std=
out pack
      t/perf/run: copy config.mak.autogen & friends to build area

Lars Schneider (20):
      travis-ci: ask homebrew for its path instead of hardcoding it
      convert: quote filter names in error messages
      convert: modernize tests
      run-command: move check_pipe() from write_or_die to run_command
      run-command: add clean_on_exit_handler
      pkt-line: rename packet_write() to packet_write_fmt()
      pkt-line: extract set_packet_header()
      pkt-line: add packet_write_fmt_gently()
      pkt-line: add packet_flush_gently()
      pkt-line: add packet_write_gently()
      pkt-line: add functions to read/write flush terminated packet strea=
ms
      convert: make apply_filter() adhere to standard Git error handling
      convert: prepare filter.<driver>.process option
      convert: add filter.<driver>.process option
      contrib/long-running-filter: add long running filter example
      sha1_file: rename git_open_noatime() to git_open()
      sha1_file: open window into packfiles with O_CLOEXEC
      read-cache: make sure file handles are not inherited by child proce=
sses
      Makefile: set NO_OPENSSL on macOS by default
      travis-ci: disable GIT_TEST_HTTPD for macOS

Linus Torvalds (1):
      abbrev: auto size the default abbreviation

Mantas Mikul=C4=97nas (1):
      contrib: add credential helper for libsecret

Matthieu Moy (4):
      Documentation/config: default for color.* is color.ui
      parse_mailboxes: accept extra text after <...> address
      t9000-addresses: update expected results after fix
      Git.pm: add comment pointing to t9000

Michael Haggerty (36):
      xdl_change_compact(): fix compaction heuristic to adjust ixo
      xdl_change_compact(): only use heuristic if group can't be matched
      is_blank_line(): take a single xrecord_t as argument
      recs_match(): take two xrecord_t pointers as arguments
      xdl_change_compact(): introduce the concept of a change group
      resolve_gitlink_ref(): eliminate temporary variable
      refs: rename struct ref_cache to files_ref_store
      refs: create a base class "ref_store" for files_ref_store
      add_packed_ref(): add a files_ref_store argument
      get_packed_ref(): add a files_ref_store argument
      resolve_missing_loose_ref(): add a files_ref_store argument
      {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
      refs: reorder definitions
      resolve_packed_ref(): rename function from resolve_missing_loose_re=
f()
      resolve_gitlink_packed_ref(): remove function
      read_raw_ref(): take a (struct ref_store *) argument
      resolve_ref_recursively(): new function
      resolve_gitlink_ref(): implement using resolve_ref_recursively()
      resolve_gitlink_ref(): avoid memory allocation in many cases
      resolve_gitlink_ref(): rename path parameter to submodule
      refs: make read_raw_ref() virtual
      refs: make verify_refname_available() virtual
      refs: make pack_refs() virtual
      refs: make create_symref() virtual
      refs: make peel_ref() virtual
      repack_without_refs(): add a files_ref_store argument
      lock_raw_ref(): add a files_ref_store argument
      commit_ref_update(): add a files_ref_store argument
      lock_ref_for_update(): add a files_ref_store argument
      lock_ref_sha1_basic(): add a files_ref_store argument
      split_symref_update(): add a files_ref_store argument
      files_ref_iterator_begin(): take a ref_store argument
      refs: add method iterator_begin
      diff: improve positioning of add/delete blocks in diffs
      parse-options: add parse_opt_unknown_cb()
      blame: honor the diff heuristic options and config

Michael J Gruber (1):
      gpg-interface: use more status letters

Mike Ralphson (1):
      vcs-svn/fast_export: fix timestamp fmt specifiers

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (40):
      remote-curl.c: convert fetch_git() to use argv_array
      transport-helper.c: refactor set_helper_option()
      upload-pack: move shallow deepen code out of receive_needs()
      upload-pack: move "shallow" sending code out of deepen()
      upload-pack: remove unused variable "backup"
      upload-pack: move "unshallow" sending code out of deepen()
      upload-pack: use skip_prefix() instead of starts_with()
      upload-pack: tighten number parsing at "deepen" lines
      upload-pack: make check_non_tip() clean things up on error
      upload-pack: move rev-list code out of check_non_tip()
      fetch-pack: use skip_prefix() instead of starts_with()
      fetch-pack: use a common function for verbose printing
      fetch-pack.c: mark strings for translating
      fetch-pack: use a separate flag for fetch in deepening mode
      shallow.c: implement a generic shallow boundary finder based on rev=
-list
      upload-pack: add deepen-since to cut shallow repos based on time
      fetch: define shallow boundary with --shallow-since
      clone: define shallow clone boundary based on time with --shallow-s=
ince
      t5500, t5539: tests for shallow depth since a specific date
      refs: add expand_ref()
      upload-pack: support define shallow boundary by excluding revisions
      fetch: define shallow boundary with --shallow-exclude
      clone: define shallow clone boundary with --shallow-exclude
      t5500, t5539: tests for shallow depth excluding a ref
      upload-pack: split check_unreachable() in two, prep for get_reachab=
le_list()
      upload-pack: add get_reachable_list()
      fetch, upload-pack: --deepen=3DN extends shallow boundary by N comm=
its
      checkout: add some spaces between code and comment
      checkout.txt: document a common case that ignores ambiguation rules
      checkout: fix ambiguity check in subdir
      init: correct re-initialization from a linked worktree
      init: call set_git_dir_init() from within init_db()
      init: kill set_git_dir_init()
      init: do not set unnecessary core.worktree
      init: kill git_link variable
      git-commit.txt: clarify --patch mode with pathspec
      diff-lib: allow ita entries treated as "not yet exist in index"
      diff: add --ita-[in]visible-in-index
      commit: fix empty commit creation when there's no changes but ita e=
ntries
      commit: don't be fooled by ita entries when creating initial commit

Olaf Hering (1):
      git-gui: sort entries in tclIndex

Orgad Shaneh (1):
      git-gui: Do not reset author details on amend

Pat Thoyts (7):
      Allow keyboard control to work in the staging widgets.
      Amend tab ordering and text widget border and highlighting.
      git-gui: fix detection of Cygwin
      git-gui (Windows): use git-gui.exe in `Create Desktop Shortcut`
      git-gui: maintain backwards compatibility for merge syntax
      git-gui: avoid persisting modified author identity
      git-gui: set version 0.21

Patrick Steinhardt (1):
      doc: fix location of 'info/' with $GIT_COMMON_DIR

Petr Stodulka (1):
      http: control GSSAPI credential delegation

Philip Oakley (14):
      doc: use 'symmetric difference' consistently
      doc: revisions - name the left and right sides
      doc: show the actual left, right, and boundary marks
      doc: revisions: give headings for the two and three dot notations
      doc: revisions: extra clarification of <rev>^! notation effects
      doc: revisions: single vs multi-parent notation comparison
      doc: gitrevisions - use 'reachable' in page description
      doc: gitrevisions - clarify 'latter case' is revision walk
      doc: revisions - define `reachable`
      doc: revisions - clarify reachability examples
      doc: revisions: show revision expansion in examples
      doc: revisions: sort examples and fix alignment of the unchanged
      doc: fix merge-base ASCII art tab spacing
      doc: fix the 'revert a faulty merge' ASCII art tab spacing

Pranit Bauva (2):
      rev-list-options: clarify the usage of --reverse
      t0040: convert all possible tests to use `test-parse-options --expe=
ct`

Ralf Thielow (6):
      help: introduce option --exclude-guides
      help: make option --help open man pages only for Git commands
      rebase -i: improve advice on bad instruction lines
      l10n: de.po: fix translation of autostash
      l10n: de.po: translate 260 new messages
      fetch-pack.c: correct command at the beginning of an error message

Ray Chen (1):
      l10n: zh_CN: review for git v2.10.0 l10n

Ren=C3=A9 Scharfe (36):
      compat: move strdup(3) replacement to its own file
      introduce hex2chr() for converting two hexadecimal digits to a char=
acter
      strbuf: use valid pointer in strbuf_remove()
      checkout: constify parameters of checkout_stage() and checkout_merg=
ed()
      unpack-trees: pass checkout state explicitly to check_updates()
      sha1_file: use llist_mergesort() for sorting packs
      xdiff: fix merging of hunks with -W context and -u context
      contrib/coccinelle: fix semantic patch for oid_to_hex_r()
      add coccicheck make target
      use strbuf_addstr() for adding constant strings to a strbuf, part 2
      pretty: let %C(auto) reset all attributes
      introduce CHECKOUT_INIT
      add COPY_ARRAY
      use COPY_ARRAY
      git-gui: stop using deprecated merge syntax
      gitignore: ignore output files of coccicheck make target
      use strbuf_addstr() instead of strbuf_addf() with "%s", part 2
      use strbuf_add_unique_abbrev() for adding short hashes, part 2
      add QSORT
      use QSORT
      remove unnecessary check before QSORT
      coccicheck: use --all-includes by default
      use QSORT, part 2
      pretty: avoid adding reset for %C(auto) if output is empty
      coccicheck: make transformation for strbuf_addf(sb, "...") more pre=
cise
      show-branch: use QSORT
      remove unnecessary NULL check before free(3)
      use strbuf_add_unique_abbrev() for adding short hashes, part 3
      pretty: fix document link for color specification
      avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM
      inline xalloc_flex() into FLEXPTR_ALLOC_MEM
      hex: make wraparound of the index into ring-buffer explicit
      valgrind: support test helpers
      commit: simplify building parents list
      sha1_name: make wraparound of the index into ring-buffer explicit
      cocci: avoid self-references in object_id transformations

Ronnie Sahlberg (2):
      refs: add a backend method structure
      refs: add a transaction_commit() method

SZEDER G=C3=A1bor (1):
      ref-filter: strip format option after a field name only once while =
parsing

Satoshi Yasushima (6):
      git-gui: consistently use the same word for "remote" in Japanese
      git-gui: consistently use the same word for "blame" in Japanese
      git-gui: apply po template to Japanese translation
      git-gui: add Japanese language code
      git-gui: update Japanese translation
      git-gui: update Japanese information

Stefan Beller (16):
      t7408: modernize style
      t7408: merge short tests, factor out testing method
      submodule--helper module-clone: allow multiple references
      submodule--helper update-clone: allow multiple references
      clone: factor out checking for an alternate path
      clone: clarify option_reference as required
      clone: implement optional references
      clone: recursive and reference option triggers submodule alternates
      xdiff: remove unneeded declarations
      transport: report missing submodule pushes consistently on stderr
      diff.c: use diff_options directly
      diff: omit found pointer from emit_callback
      diff: remove dead code
      submodule: ignore trailing slash on superproject URL
      submodule: ignore trailing slash in relative url
      documentation: improve submodule.<name>.{url, path} description

Stefan Christ (1):
      Documentation/fmt-merge-msg: fix markup in example

Thomas Gummerer (4):
      add: document the chmod option
      update-index: add test for chmod flags
      read-cache: introduce chmod_index_entry
      add: modify already added files when --chmod is given

Tobias Klauser (1):
      diffcore-delta: remove unused parameter to diffcore_count_changes()

Vasco Almeida (32):
      l10n: pt_PT: update Portuguese translation
      l10n: pt_PT: update Portuguese repository info
      i18n: blame: mark error messages for translation
      i18n: branch: mark option description for translation
      i18n: config: mark error message for translation
      i18n: merge-recursive: mark error messages for translation
      i18n: merge-recursive: mark verbose message for translation
      i18n: notes: mark error messages for translation
      notes: spell first word of error messages in lowercase
      i18n: receive-pack: mark messages for translation
      i18n: show-branch: mark error messages for translation
      i18n: show-branch: mark plural strings for translation
      i18n: update-index: mark warnings for translation
      i18n: commit: mark message for translation
      i18n: connect: mark die messages for translation
      i18n: ident: mark hint for translation
      i18n: notes-merge: mark die messages for translation
      i18n: stash: mark messages for translation
      git-gui i18n: mark strings for translation
      git-gui: l10n: add Portuguese translation
      git-gui i18n: internationalize use of colon punctuation
      git-gui i18n: mark "usage:" strings for translation
      git-gui: fix incorrect use of Tcl append command
      git-gui i18n: mark string in lib/error.tcl for translation
      t1512: become resilient to GETTEXT_POISON build
      i18n: apply: mark plural string for translation
      i18n: apply: mark info messages for translation
      i18n: apply: mark error messages for translation
      i18n: apply: mark error message for translation
      i18n: convert mark error messages for translation
      i18n: credential-cache--daemon: mark advice for translation
      i18n: diff: mark warnings for translation

Vegard Nossum (1):
      revision: new rev^-n shorthand for rev^n..rev

Younes Khoudli (1):
      doc: remove reference to the traditional layout in git-tag.txt

brian m. carlson (20):
      cache: convert struct cache_entry to use struct object_id
      builtin/apply: convert static functions to struct object_id
      builtin/blame: convert struct origin to use struct object_id
      builtin/log: convert some static functions to use struct object_id
      builtin/cat-file: convert struct expand_data to use struct object_i=
d
      builtin/cat-file: convert some static functions to struct object_id
      builtin: convert textconv_object to use struct object_id
      streaming: make stream_blob_to_fd take struct object_id
      builtin/checkout: convert some static functions to struct object_id
      notes-merge: convert struct notes_merge_pair to struct object_id
      Convert read_mmblob to take struct object_id.
      builtin/blame: convert file to use struct object_id
      builtin/rm: convert to use struct object_id
      notes: convert init_notes to use struct object_id
      builtin/update-index: convert file to struct object_id
      sha1_name: convert get_sha1_mb to struct object_id
      refs: add an update_ref_oid function.
      builtin/am: convert to struct object_id
      builtin/commit-tree: convert to struct object_id
      builtin/reset: convert to use struct object_id

yaras (1):
      git-gui: fix initial git gui message encoding

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
      gitweb: fix a typo in a comment
      gitweb: link to 7-char+ SHA-1s, not only 8-char+
      gitweb: link to "git describe"'d commits in log messages

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 (1):
      ./configure.ac: detect SSL in libcurl using curl-config

