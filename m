Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F363F20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLIInV (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 03:43:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35056 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIInV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 03:43:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so8215943wmh.0;
        Sun, 09 Dec 2018 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=W6hkl8eyue+edEWBxNM5w/Ud9Wp+Me0BtkV6M7WYLso=;
        b=N6j6DtvoAawP1NyYo/ePaK/zBkudeJ7VRfKUml7zzfEtA7EJoECd1Ee3kEhAJ8VY2J
         StFcUMaOQ6xqLLNy7pi+qmH9ItFrLc+S/7N7OWDuBdvN0BnidIddPhQ6TQQsXBRkVpXa
         3ckT6V/0oSjAQDr83IdZ3DjRqhPATwKvelBtCGWhx2V13xEKdue1ZG4XDBPgD7copCTi
         uuwrOrTeFVJeDqHYQZ6Nq/XffDBT2foPXs27vyvhGdyaVd/KTFBKGRQiWh+PgTmxeT2h
         ktk6jcGZ9MfgGNZg4ua47GPgLXHyLo92fEFu/xfzszf1CqepUEBuigiCPWBFZQZAB57D
         xPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=W6hkl8eyue+edEWBxNM5w/Ud9Wp+Me0BtkV6M7WYLso=;
        b=VwFBUNf+MhG4oDJ/rDbKw+BdAKJ2rsKoqe/M3XyhmngUTjVWQBTv+WEVFuFf3DHvqD
         MOvciaS3DHNHZV1XKpnWXmCUED4wgWtGY677jKr4+HA26eWsLvJCxgYvJ6huwn7fEEqo
         mqDYYb5auEaArcXxIX0PHeKnYgK+uPKcW9JKumNseTuMXPvuZNVC4GZIy7n/JCOlernu
         Tl8F/CQjS33Ez6JzIQ7q60MEAgKoPibyu4G0YF1/AGDmotERZXIFarX7MQCuc7zo/Hnj
         550PD/jc21b0utrA1PEP10pEciG61POPnzQblQvOU2GcyHAUaDGodlkNEVsFTCbb93zi
         9L1Q==
X-Gm-Message-State: AA+aEWa0oz/0lAXCju5C7xeBZ8z3JoEuqQpiCCJ7H2zZ8jwKWD7zVFEt
        Yl6tBF/qeVPmYmEKNBDI6pRJE6fpTm4=
X-Google-Smtp-Source: AFSGD/WlOjm6adyV0gOkVMfZkgzwZ6XMDZg6kTOHIVClWOLQJ74ZeNYt9VRo6tHKfo4oJ8cwwDHUpQ==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr7095307wmb.23.1544344992181;
        Sun, 09 Dec 2018 00:43:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r77sm15831486wmd.22.2018.12.09.00.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 00:43:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.20.0
Date:   Sun, 09 Dec 2018 17:43:10 +0900
Message-ID: <xmqq1s6r3xb5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.20.0 is now available at the usual
places.  It is comprised of 962 non-merge commits since v2.19.0
(this is by far the largest release in v2.x.x series), contributed
by 83 people, 26 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.20.0'
tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.19.0 are as follows.
Welcome to the Git development community!

  Aaron Lindsay, Alexander Pyhalov, Anton Serbulov, Brendan
  Forster, Carlo Marcelo Arenas Belón, Daniels Umanovskis,
  David Zych, Đoàn Trần Công Danh, Frederick Eaton, Greg
  Hurrell, James Knight, Jann Horn, Joshua Watt, Loo Rong Jie,
  Lucas De Marchi, Matthew DeVore, Mihir Mehta, Minh Nguyen,
  Nickolai Belakovski, Roger Strain, Sam McKelvie, Saulius Gurklys,
  Shulhan, Steven Fernandez, Strain, Roger L, and Tim Schumacher.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alban Gruin, Alexander Shopov,
  Andreas Gruenbacher, Andreas Heiduk, Antonio Ospite, Ben Peart,
  Brandon Williams, brian m. carlson, Christian Couder, Christian
  Hesse, Christopher Díaz Riveros, Denton Liu, Derrick Stolee,
  Elijah Newren, Eric Sunshine, Jean-Noël Avila, Jeff Hostetler,
  Jeff King, Jiang Xin, Johannes Schindelin, Johannes Sixt,
  Jonathan Nieder, Jonathan Tan, Jordi Mas, Josh Steadmon,
  Junio C Hamano, Karsten Blees, Luke Diamand, Martin Ågren,
  Max Kirillov, Michael Witten, Michał Górny, Nguyễn Thái
  Ngọc Duy, Noam Postavsky, Olga Telezhnaya, Peter Krefting,
  Phillip Wood, Pratik Karki, Rafael Ascensão, Ralf Thielow,
  Ramsay Jones, Rasmus Villemoes, René Scharfe, Sebastian Staudt,
  Stefan Beller, Stephen P. Smith, Steve Hoelzer, Sven Strickroth,
  SZEDER Gábor, Tao Qingyun, Taylor Blau, Thomas Gummerer,
  Todd Zullinger, Torsten Bögershausen, Trần Ngọc Quân,
  and Uwe Kleine-König.

----------------------------------------------------------------

Git 2.20 Release Notes
======================

Backward Compatibility Notes
----------------------------

 * "git branch -l <foo>" used to be a way to ask a reflog to be
   created while creating a new branch, but that is no longer the
   case.  It is a short-hand for "git branch --list <foo>" now.

 * "git push" into refs/tags/* hierarchy is rejected without getting
   forced, but "git fetch" (misguidedly) used the "fast forwarding"
   rule used for the refs/heads/* hierarchy; this has been corrected,
   which means some fetches of tags that did not fail with older
   version of Git will fail without "--force" with this version.

 * "git help -a" now gives verbose output (same as "git help -av").
   Those who want the old output may say "git help --no-verbose -a"..

 * "git cpn --help", when "cpn" is an alias to, say, "cherry-pick -n",
   reported only the alias expansion of "cpn" in earlier versions of
   Git.  It now runs "git cherry-pick --help" to show the manual page
   of the command, while sending the alias expansion to the standard
   error stream.

 * "git send-email" learned to grab address-looking string on any
   trailer whose name ends with "-by". This is a backward-incompatible
   change.  Adding "--suppress-cc=misc-by" on the command line, or
   setting sendemail.suppresscc configuration variable to "misc-by",
   can be used to disable this behaviour.


Updates since v2.19
-------------------

UI, Workflows & Features

 * Running "git clone" against a project that contain two files with
   pathnames that differ only in cases on a case insensitive
   filesystem would result in one of the files lost because the
   underlying filesystem is incapable of holding both at the same
   time.  An attempt is made to detect such a case and warn.

 * "git checkout -b newbranch [HEAD]" should not have to do as much as
   checking out a commit different from HEAD.  An attempt is made to
   optimize this special case.

 * "git rev-list --stdin </dev/null" used to be an error; it now shows
   no output without an error.  "git rev-list --stdin --default HEAD"
   still falls back to the given default when nothing is given on the
   standard input.

 * Lift code from GitHub to restrict delta computation so that an
   object that exists in one fork is not made into a delta against
   another object that does not appear in the same forked repository.

 * "git format-patch" learned new "--interdiff" and "--range-diff"
   options to explain the difference between this version and the
   previous attempt in the cover letter (or after the three-dashes as
   a comment).

 * "git mailinfo" used in "git am" learned to make a best-effort
   recovery of a patch corrupted by MUA that sends text/plain with
   format=flawed option.
   (merge 3aa4d81f88 rs/mailinfo-format-flowed later to maint).

 * The rules used by "git push" and "git fetch" to determine if a ref
   can or cannot be updated were inconsistent; specifically, fetching
   to update existing tags were allowed even though tags are supposed
   to be unmoving anchoring points.  "git fetch" was taught to forbid
   updates to existing tags without the "--force" option.

 * "git multi-pack-index" learned to detect corruption in the .midx
   file it uses, and this feature has been integrated into "git fsck".

 * Generation of (experimental) commit-graph files have so far been
   fairly silent, even though it takes noticeable amount of time in a
   meaningfully large repository.  The users will now see progress
   output.

 * The minimum version of Windows supported by Windows port of Git is
   now set to Vista.

 * The completion script (in contrib/) learned to complete a handful of
   options "git stash list" command takes.

 * The completion script (in contrib/) learned that "git fetch
   --multiple" only takes remote names as arguments and no refspecs.

 * "git status" learns to show progress bar when refreshing the index
   takes a long time.
   (merge ae9af12287 nd/status-refresh-progress later to maint).

 * "git help -a" and "git help -av" give different pieces of
   information, and generally the "verbose" version is more friendly
   to the new users.  "git help -a" by default now uses the more
   verbose output (with "--no-verbose", you can go back to the
   original).  Also "git help -av" now lists aliases and external
   commands, which it did not used to.

 * Unlike "grep", "git grep" by default recurses to the whole tree.
   The command learned "git grep --recursive" option, so that "git
   grep --no-recursive" can serve as a synonym to setting the
   max-depth to 0.

 * When pushing into a repository that borrows its objects from an
   alternate object store, "git receive-pack" that responds to the
   push request on the other side lists the tips of refs in the
   alternate to reduce the amount of objects transferred.  This
   sometimes is detrimental when the number of refs in the alternate
   is absurdly large, in which case the bandwidth saved in potentially
   fewer objects transferred is wasted in excessively large ref
   advertisement.  The alternate refs that are advertised are now
   configurable with a pair of configuration variables.

 * "git cmd --help" when "cmd" is aliased used to only say "cmd is
   aliased to ...".  Now it shows that to the standard error stream
   and runs "git $cmd --help" where $cmd is the first word of the
   alias expansion.

 * The documentation of "git gc" has been updated to mention that it
   is no longer limited to "pruning away crufts" but also updates
   ancillary files like commit-graph as a part of repository
   optimization.

 * "git p4 unshelve" improvements.

 * The logic to select the default user name and e-mail on Windows has
   been improved.
   (merge 501afcb8b0 js/mingw-default-ident later to maint).

 * The "rev-list --filter" feature learned to exclude all trees via
   "tree:0" filter.

 * "git send-email" learned to grab address-looking string on any
   trailer whose name ends with "-by"; --suppress-cc=misc-by on the
   command line, or setting sendemail.suppresscc configuration
   variable to "misc-by", can be used to disable this behaviour.

 * "git mergetool" learned to take the "--[no-]gui" option, just like
   "git difftool" does.

 * "git rebase -i" learned a new insn, 'break', that the user can
   insert in the to-do list.  Upon hitting it, the command returns
   control back to the user.

 * New "--pretty=format:" placeholders %GF and %GP that show the GPG
   key fingerprints have been invented.

 * On platforms with recent cURL library, http.sslBackend configuration
   variable can be used to choose a different SSL backend at runtime.
   The Windows port uses this mechanism to switch between OpenSSL and
   Secure Channel while talking over the HTTPS protocol.

 * "git send-email" learned to disable SMTP authentication via the
   "--smtp-auth=none" option, even when the smtp username is given
   (which turns the authentication on by default).

 * A fourth class of configuration files (in addition to the
   traditional "system wide", "per user in the $HOME directory" and
   "per repository in the $GIT_DIR/config") has been introduced so
   that different worktrees that share the same repository (hence the
   same $GIT_DIR/config file) can use different customization.

 * A pattern with '**' that does not have a slash on either side used
   to be an invalid one, but the code now treats such double-asterisks
   the same way as two normal asterisks that happen to be adjacent to
   each other.
   (merge e5bbe09e88 nd/wildmatch-double-asterisk later to maint).

 * The "--no-patch" option, which can be used to get a high-level
   overview without the actual line-by-line patch difference shown, of
   the "range-diff" command was earlier broken, which has been
   corrected.

 * The recently merged "rebase in C" has an escape hatch to use the
   scripted version when necessary, but it hasn't been documented,
   which has been corrected.


Performance, Internal Implementation, Development Support etc.

 * Developer builds now use -Wunused-function compilation option.

 * One of our CI tests to run with "unusual/experimental/random"
   settings now also uses commit-graph and midx.

 * When there are too many packfiles in a repository (which is not
   recommended), looking up an object in these would require
   consulting many pack .idx files; a new mechanism to have a single
   file that consolidates all of these .idx files is introduced.

 * "git submodule update" is getting rewritten piece-by-piece into C.

 * The code for computing history reachability has been shuffled,
   obtained a bunch of new tests to cover them, and then being
   improved.

 * The unpack_trees() API used in checking out a branch and merging
   walks one or more trees along with the index.  When the cache-tree
   in the index tells us that we are walking a tree whose flattened
   contents is known (i.e. matches a span in the index), as linearly
   scanning a span in the index is much more efficient than having to
   open tree objects recursively and listing their entries, the walk
   can be optimized, which has been done.

 * When creating a thin pack, which allows objects to be made into a
   delta against another object that is not in the resulting pack but
   is known to be present on the receiving end, the code learned to
   take advantage of the reachability bitmap; this allows the server
   to send a delta against a base beyond the "boundary" commit.

 * spatch transformation to replace boolean uses of !hashcmp() to
   newly introduced oideq() is added, and applied, to regain
   performance lost due to support of multiple hash algorithms.

 * Fix a bug in which the same path could be registered under multiple
   worktree entries if the path was missing (for instance, was removed
   manually).  Also, as a convenience, expand the number of cases in
   which --force is applicable.

 * Split Documentation/config.txt for easier maintenance.
   (merge 6014363f0b nd/config-split later to maint).

 * Test helper binaries clean-up.
   (merge c9a1f4161f nd/test-tool later to maint).

 * Various tests have been updated to make it easier to swap the
   hash function used for object identification.
   (merge ae0c89d41b bc/hash-independent-tests later to maint).

 * Update fsck.skipList implementation and documentation.
   (merge 371a655074 ab/fsck-skiplist later to maint).

 * An alias that expands to another alias has so far been forbidden,
   but now it is allowed to create such an alias.

 * Various test scripts have been updated for style and also correct
   handling of exit status of various commands.

 * "gc --auto" ended up calling exit(-1) upon error, which has been
   corrected to use exit(1).  Also the error reporting behaviour when
   daemonized has been updated to exit with zero status when stopping
   due to a previously discovered error (which implies there is no
   point running gc to improve the situation); we used to exit with
   failure in such a case.

 * Various codepaths in the core-ish part learned to work on an
   arbitrary in-core index structure, not necessarily the default
   instance "the_index".
   (merge b3c7eef9b0 nd/the-index later to maint).

 * Code clean-up in the internal machinery used by "git status" and
   "git commit --dry-run".
   (merge 73ba5d78b4 ss/wt-status-committable later to maint).

 * Some environment variables that control the runtime options of Git
   used during tests are getting renamed for consistency.
   (merge 4231d1ba99 bp/rename-test-env-var later to maint).

 * A pair of new extensions to the index file have been introduced.
   They allow the index file to be read in parallel for performance.

 * The oidset API was built on top of the oidmap API which in turn is
   on the hashmap API.  Replace the implementation to build on top of
   the khash API and gain performance.

 * Over some transports, fetching objects with an exact commit object
   name can be done without first seeing the ref advertisements.  The
   code has been optimized to exploit this.

 * In a partial clone that will lazily be hydrated from the
   originating repository, we generally want to avoid "does this
   object exist (locally)?" on objects that we deliberately omitted
   when we created the clone.  The cache-tree codepath (which is used
   to write a tree object out of the index) however insisted that the
   object exists, even for paths that are outside of the partial
   checkout area.  The code has been updated to avoid such a check.

 * To help developers, an EditorConfig file that attempts to follow
   the project convention has been added.
   (merge b548d698a0 bc/editorconfig later to maint).

 * The result of coverage test can be combined with "git blame" to
   check the test coverage of code introduced recently with a new
   'coverage-diff' tool (in contrib/).
   (merge 783faedd65 ds/coverage-diff later to maint).

 * An experiment to fuzz test a few areas, hopefully we can gain more
   coverage to various areas.

 * More codepaths are moving away from hardcoded hash sizes.

 * The way the Windows port figures out the current directory has been
   improved.

 * The way DLLs are loaded on the Windows port has been improved.

 * Some tests have been reorganized and renamed; "ls t/" now gives a
   better overview of what is tested for these scripts than before.

 * "git rebase" and "git rebase -i" have been reimplemented in C.

 * Windows port learned to use nano-second resolution file timestamps.

 * The overly large Documentation/config.txt file have been split into
   million little pieces.  This potentially allows each individual piece
   to be included into the manual page of the command it affects more easily.

 * Replace three string-list instances used as look-up tables in "git
   fetch" with hashmaps.

 * Unify code to read the author-script used in "git am" and the
   commands that use the sequencer machinery, e.g. "git rebase -i".

 * In preparation to the day when we can deprecate and remove the
   "rebase -p", make sure we can skip and later remove tests for
   it.

 * The history traversal used to implement the tag-following has been
   optimized by introducing a new helper.

 * The helper function to refresh the cached stat information in the
   in-core index has learned to perform the lstat() part of the
   operation in parallel on multi-core platforms.

 * The code to traverse objects for reachability, used to decide what
   objects are unreferenced and expendable, have been taught to also
   consider per-worktree refs of other worktrees as starting points to
   prevent data loss.

 * "git add" needs to internally run "diff-files" equivalent, and the
   codepath learned the same optimization as "diff-files" has to run
   lstat(2) in parallel to find which paths have been updated in the
   working tree.

 * The procedure to install dependencies before testing at Travis CI
   is getting revamped for both simplicity and flexibility, taking
   advantage of the recent move to the vm-based environment.

 * The support for format-patch (and send-email) by the command-line
   completion script (in contrib/) has been simplified a bit.

 * The revision walker machinery learned to take advantage of the
   commit generation numbers stored in the commit-graph file.

 * The codebase has been cleaned up to reduce "#ifndef NO_PTHREADS".

 * The way -lcurl library gets linked has been simplified by taking
   advantage of the fact that we can just ask curl-config command how.

 * Various functions have been audited for "-Wunused-parameter" warnings
   and bugs in them got fixed.

 * A sanity check for start-up sequence has been added in the config
   API codepath.

 * The build procedure to link for fuzzing test has been made
   customizable with a new Makefile variable.

 * The way "git rebase" parses and forwards the command line options
   meant for underlying "git am" has been revamped, which fixed for
   options with parameters that were not passed correctly.

 * Our testing framework uses a special i18n "poisoned localization"
   feature to find messages that ought to stay constant but are
   incorrectly marked to be translated.  This feature has been made
   into a runtime option (it used to be a compile-time option).

 * "git push" used to check ambiguities between object-names and
   refnames while processing the list of refs' old and new values,
   which was unnecessary (as it knew that it is feeding raw object
   names).  This has been optimized out.

 * The xcurl_off_t() helper function is used to cast size_t to
   curl_off_t, but some compilers gave warnings against the code to
   ensure the casting is done without wraparound, when size_t is
   narrower than curl_off_t.  This warning has been squelched.

 * Code preparation to replace ulong vars with size_t vars where
   appropriate continues.

 * The "test installed Git" mode of our test suite has been updated to
   work better.

 * A coding convention around the Coccinelle semantic patches to have
   two classes to ease code migration process has been proposed and
   its support has been added to the Makefile.

 * The "container" mode of TravisCI is going away.  Our .travis.yml
   file is getting prepared for the transition.
   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).

 * Our test scripts can now take the '-V' option as a synonym for the
   '--verbose-log' option.
   (merge a5f52c6dab sg/test-verbose-log later to maint).


Fixes since v2.19
-----------------

 * "git interpret-trailers" and its underlying machinery had a buggy
   code that attempted to ignore patch text after commit log message,
   which triggered in various codepaths that will always get the log
   message alone and never get such an input.
   (merge 66e83d9b41 jk/trailer-fixes later to maint).

 * Malformed or crafted data in packstream can make our code attempt
   to read or write past the allocated buffer and abort, instead of
   reporting an error, which has been fixed.

 * "git rebase -i" did not clear the state files correctly when a run
   of "squash/fixup" is aborted and then the user manually amended the
   commit instead, which has been corrected.
   (merge 10d2f35436 js/rebase-i-autosquash-fix later to maint).

 * When fsmonitor is in use, after operation on submodules updates
   .gitmodules, we lost track of the fact that we did so and relied on
   stale fsmonitor data.
   (merge 43f1180814 bp/mv-submodules-with-fsmonitor later to maint).

 * Fix for a long-standing bug that leaves the index file corrupt when
   it shrinks during a partial commit.
   (merge 6c003d6ffb jk/reopen-tempfile-truncate later to maint).

 * Further fix for O_APPEND emulation on Windows
   (merge eeaf7ddac7 js/mingw-o-append later to maint).

 * A corner case bugfix in "git rerere" code.
   (merge ad2bf0d9b4 en/rerere-multi-stage-1-fix later to maint).

 * "git add ':(attr:foo)'" is not supported and is supposed to be
   rejected while the command line arguments are parsed, but we fail
   to reject such a command line upfront.
   (merge 84d938b732 nd/attr-pathspec-fix later to maint).

 * Recent update broke the reachability algorithm when refs (e.g.
   tags) that point at objects that are not commit were involved,
   which has been fixed.

 * "git rebase" etc. in Git 2.19 fails to abort when given an empty
   commit log message as result of editing, which has been corrected.
   (merge a3ec9eaf38 en/sequencer-empty-edit-result-aborts later to maint).

 * The code to backfill objects in lazily cloned repository did not
   work correctly, which has been corrected.
   (merge e68302011c jt/lazy-object-fetch-fix later to maint).

 * Update error messages given by "git remote" and make them consistent.
   (merge 5025425dff ms/remote-error-message-update later to maint).

 * "git update-ref" learned to make both "--no-deref" and "--stdin"
   work at the same time.
   (merge d345e9fbe7 en/update-ref-no-deref-stdin later to maint).

 * Recently added "range-diff" had a corner-case bug to cause it
   segfault, which has been corrected.
   (merge e467a90c7a tg/range-diff-corner-case-fix later to maint).

 * The recently introduced commit-graph auxiliary data is incompatible
   with mechanisms such as replace & grafts that "breaks" immutable
   nature of the object reference relationship.  Disable optimizations
   based on its use (and updating existing commit-graph) when these
   incompatible features are in use in the repository.
   (merge 829a321569 ds/commit-graph-with-grafts later to maint).

 * The mailmap file update.
   (merge 255eb03edf jn/mailmap-update later to maint).

 * The code in "git status" sometimes hit an assertion failure.  This
   was caused by a structure that was reused without cleaning the data
   used for the first run, which has been corrected.
   (merge 3e73cc62c0 en/status-multiple-renames-to-the-same-target-fix later to maint).

 * "git fetch $repo $object" in a partial clone did not correctly
   fetch the asked-for object that is referenced by an object in
   promisor packfile, which has been fixed.

 * A corner-case bugfix.
   (merge c5cbb27cb5 sm/show-superproject-while-conflicted later to maint).

 * Various fixes to "diff --color-moved-ws".

 * A partial clone that is configured to lazily fetch missing objects
   will on-demand issue a "git fetch" request to the originating
   repository to fill not-yet-obtained objects.  The request has been
   optimized for requesting a tree object (and not the leaf blob
   objects contained in it) by telling the originating repository that
   no blobs are needed.
   (merge 4c7f9567ea jt/non-blob-lazy-fetch later to maint).

 * The codepath to support the experimental split-index mode had
   remaining "racily clean" issues fixed.
   (merge 4c490f3d32 sg/split-index-racefix later to maint).

 * "git log --graph" showing an octopus merge sometimes miscounted the
   number of display columns it is consuming to show the merge and its
   parent commits, which has been corrected.
   (merge 04005834ed np/log-graph-octopus-fix later to maint).

 * "git range-diff" did not work well when the compared ranges had
   changes in submodules and the "--submodule=log" was used.

 * The implementation of run_command() API on the UNIX platforms had a
   bug that caused a command not on $PATH to be found in the current
   directory.
   (merge f67b980771 jk/run-command-notdot later to maint).

 * A mutex used in "git pack-objects" were not correctly initialized
   and this caused "git repack" to dump core on Windows.
   (merge 34204c8166 js/pack-objects-mutex-init-fix later to maint).

 * Under certain circumstances, "git diff D:/a/b/c D:/a/b/d" on
   Windows would strip initial parts from the paths because they
   were not recognized as absolute, which has been corrected.
   (merge ffd04e92e2 js/diff-notice-has-drive-prefix later to maint).

 * The receive.denyCurrentBranch=updateInstead codepath kicked in even
   when the push should have been rejected due to other reasons, such
   as it does not fast-forward or the update-hook rejects it, which
   has been corrected.
   (merge b072a25fad jc/receive-deny-current-branch-fix later to maint).

 * The logic to determine the archive type "git archive" uses did not
   correctly kick in for "git archive --remote", which has been
   corrected.

 * "git repack" in a shallow clone did not correctly update the
   shallow points in the repository, leading to a repository that
   does not pass fsck.
   (merge 5dcfbf564c js/shallow-and-fetch-prune later to maint).

 * Some codepaths failed to form a proper URL when .gitmodules record
   the URL to a submodule repository as relative to the repository of
   superproject, which has been corrected.
   (merge e0a862fdaf sb/submodule-url-to-absolute later to maint).

 * "git fetch" over protocol v2 into a shallow repository failed to
   fetch full history behind a new tip of history that was diverged
   before the cut-off point of the history that was previously fetched
   shallowly.

 * The command line completion machinery (in contrib/) has been
   updated to allow the completion script to tweak the list of options
   that are reported by the parse-options machinery correctly.
   (merge 276b49ff34 nd/completion-negation later to maint).

 * Operations on promisor objects make sense in the context of only a
   small subset of the commands that internally use the revisions
   machinery, but the "--exclude-promisor-objects" option were taken
   and led to nonsense results by commands like "log", to which it
   didn't make much sense.  This has been corrected.
   (merge 669b1d2aae md/exclude-promisor-objects-fix later to maint).

 * A regression in Git 2.12 era made "git fsck" fall into an infinite
   loop while processing truncated loose objects.
   (merge 18ad13e5b2 jk/detect-truncated-zlib-input later to maint).

 * "git ls-remote $there foo" was broken by recent update for the
   protocol v2 and stopped showing refs that match 'foo' that are not
   refs/{heads,tags}/foo, which has been fixed.
   (merge 6a139cdd74 jk/proto-v2-ref-prefix-fix later to maint).

 * Additional comment on a tricky piece of code to help developers.
   (merge 0afbe3e806 jk/stream-pack-non-delta-clarification later to maint).

 * A couple of tests used to leave the repository in a state that is
   deliberately corrupt, which have been corrected.
   (merge aa984dbe5e ab/pack-tests-cleanup later to maint).

 * The submodule support has been updated to read from the blob at
   HEAD:.gitmodules when the .gitmodules file is missing from the
   working tree.
   (merge 2b1257e463 ao/submodule-wo-gitmodules-checked-out later to maint).

 * "git fetch" was a bit loose in parsing responses from the other side
   when talking over the protocol v2.

 * "git rev-parse --exclude=* --branches --branches"  (i.e. first
   saying "add only things that do not match '*' out of all branches"
   and then adding all branches, without any exclusion this time)
   worked as expected, but "--exclude=* --all --all" did not work the
   same way, which has been fixed.
   (merge 5221048092 ag/rev-parse-all-exclude-fix later to maint).

 * "git send-email --transfer-encoding=..." in recent versions of Git
   sometimes produced an empty "Content-Transfer-Encoding:" header,
   which has been corrected.
   (merge 3c88e46f1a al/send-email-auto-cte-fixup later to maint).

 * The interface into "xdiff" library used to discover the offset and
   size of a generated patch hunk by first formatting it into the
   textual hunk header "@@ -n,m +k,l @@" and then parsing the numbers
   out.  A new interface has been introduced to allow callers a more
   direct access to them.
   (merge 5eade0746e jk/xdiff-interface later to maint).

 * Pathspec matching against a tree object were buggy when negative
   pathspec elements were involved, which has been fixed.
   (merge b7845cebc0 nd/tree-walk-path-exclusion later to maint).

 * "git merge" and "git pull" that merges into an unborn branch used
   to completely ignore "--verify-signatures", which has been
   corrected.
   (merge 01a31f3bca jk/verify-sig-merge-into-void later to maint).

 * "git rebase --autostash" did not correctly re-attach the HEAD at times.

 * "rev-parse --exclude=<pattern> --branches=<pattern>" etc. did not
   quite work, which has been corrected.
   (merge 9ab9b5df0e ra/rev-parse-exclude-glob later to maint).

 * When editing a patch in a "git add -i" session, a hunk could be
   made to no-op.  The "git apply" program used to reject a patch with
   such a no-op hunk to catch user mistakes, but it is now updated to
   explicitly allow a no-op hunk in an edited patch.
   (merge 22cb3835b9 js/apply-recount-allow-noop later to maint).

 * The URL to an MSDN page in a comment has been updated.
   (merge 2ef2ae2917 js/mingw-msdn-url later to maint).

 * "git ls-remote --sort=<thing>" can feed an object that is not yet
   available into the comparison machinery and segfault, which has
   been corrected to check such a request upfront and reject it.

 * When "git bundle" aborts due to an empty commit ranges
   (i.e. resulting in an empty pack), it left a file descriptor to an
   lockfile open, which resulted in leftover lockfile on Windows where
   you cannot remove a file with an open file descriptor.  This has
   been corrected.
   (merge 2c8ee1f53c jk/close-duped-fd-before-unlock-for-bundle later to maint).

 * "git format-patch --stat=<width>" can be used to specify the width
   used by the diffstat (shown in the cover letter).
   (merge 284aeb7e60 nd/format-patch-cover-letter-stat-width later to maint).

 * The way .git/index and .git/sharedindex* files were initially
   created gave these files different perm bits until they were
   adjusted for shared repository settings.  This was made consistent.
   (merge c9d6c78870 cc/shared-index-permbits later to maint).

 * "git rebase --stat" to transplant a piece of history onto a totally
   unrelated history were not working before and silently showed wrong
   result.  With the recent reimplementation in C, it started to instead
   die with an error message, as the original logic was not prepared
   to cope with this case.  This has now been fixed.

 * The advice message to tell the user to migrate an existing graft
   file to the replace system when a graft file was read was shown
   even when "git replace --convert-graft-file" command, which is the
   way the message suggests to use, was running, which made little
   sense.
   (merge 8821e90a09 ab/replace-graft-with-replace-advice later to maint).

 * "git diff --raw" lost ellipses to adjust the output columns for
   some time now, but the documentation still showed them.

 * Code cleanup, docfix, build fix, etc.
   (merge 96a7501aad ts/doc-build-manpage-xsl-quietly later to maint).
   (merge b9b07efdb2 tg/conflict-marker-size later to maint).
   (merge fa0aeea770 sg/doc-trace-appends later to maint).
   (merge d64324cb60 tb/void-check-attr later to maint).
   (merge c3b9bc94b9 en/double-semicolon-fix later to maint).
   (merge 79336116f5 sg/t3701-tighten-trace later to maint).
   (merge 801fa63a90 jk/dev-build-format-security later to maint).
   (merge 0597dd62ba sb/string-list-remove-unused later to maint).
   (merge db2d36fad8 bw/protocol-v2 later to maint).
   (merge 456d7cd3a9 sg/split-index-test later to maint).
   (merge 7b6057c852 tq/refs-internal-comment-fix later to maint).
   (merge 29e8dc50ad tg/t5551-with-curl-7.61.1 later to maint).
   (merge 55f6bce2c9 fe/doc-updates later to maint).
   (merge 7987d2232d jk/check-everything-connected-is-long-gone later to maint).
   (merge 4ba3c9be47 dz/credential-doc-url-matching-rules later to maint).
   (merge 4c399442f7 ma/commit-graph-docs later to maint).
   (merge fc0503b04e ma/t1400-undebug-test later to maint).
   (merge e56b53553a nd/packobjectshook-doc-fix later to maint).
   (merge c56170a0c4 ma/mailing-list-address-in-git-help later to maint).
   (merge 6e8fc70fce rs/sequencer-oidset-insert-avoids-dups later to maint).
   (merge ad0b8f9575 mw/doc-typofixes later to maint).
   (merge d9f079ad1a jc/how-to-document-api later to maint).
   (merge b1492bf315 ma/t7005-bash-workaround later to maint).
   (merge ac1f98a0df du/rev-parse-is-plumbing later to maint).
   (merge ca8ed443a5 mm/doc-no-dashed-git later to maint).
   (merge ce366a8144 du/get-tar-commit-id-is-plumbing later to maint).
   (merge 61018fe9e0 du/cherry-is-plumbing later to maint).
   (merge c7e5fe79b9 sb/strbuf-h-update later to maint).
   (merge 8d2008196b tq/branch-create-wo-branch-get later to maint).
   (merge 2e3c894f4b tq/branch-style-fix later to maint).
   (merge c5d844af9c sg/doc-show-branch-typofix later to maint).
   (merge 081d91618b ah/doc-updates later to maint).
   (merge b84c783882 jc/cocci-preincr later to maint).
   (merge 5e495f8122 uk/merge-subtree-doc-update later to maint).
   (merge aaaa881822 jk/uploadpack-packobjectshook-fix later to maint).
   (merge 3063477445 tb/char-may-be-unsigned later to maint).
   (merge 8c64bc9420 sg/test-rebase-editor-fix later to maint).
   (merge 71571cd7d6 ma/sequencer-do-reset-saner-loop-termination later to maint).
   (merge 9a4cb8781e cb/notes-freeing-always-null-fix later to maint).
   (merge 3006f5ee16 ma/reset-doc-rendering-fix later to maint).
   (merge 4c2eb06419 sg/daemon-test-signal-fix later to maint).
   (merge d27525e519 ss/msvc-strcasecmp later to maint).

----------------------------------------------------------------

Changes since v2.19.0 are as follows:

Aaron Lindsay (1):
      send-email: avoid empty transfer encoding header

Alban Gruin (21):
      sequencer: make three functions and an enum from sequencer.c public
      rebase -i: rewrite append_todo_help() in C
      editor: add a function to launch the sequence editor
      rebase -i: rewrite the edit-todo functionality in C
      sequencer: add a new function to silence a command, except if it fails
      rebase -i: rewrite setup_reflog_action() in C
      rebase -i: rewrite checkout_onto() in C
      sequencer: refactor append_todo_help() to write its message to a buffer
      sequencer: change the way skip_unnecessary_picks() returns its result
      t3404: todo list with commented-out commands only aborts
      rebase -i: rewrite complete_action() in C
      rebase -i: remove unused modes and functions
      rebase -i: implement the logic to initialize $revisions in C
      rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
      rebase -i: rewrite write_basic_state() in C
      rebase -i: rewrite init_basic_state() in C
      rebase -i: implement the main part of interactive rebase as a builtin
      rebase--interactive2: rewrite the submodes of interactive rebase in C
      rebase -i: remove git-rebase--interactive.sh
      rebase -i: move rebase--helper modes to rebase--interactive
      p3400: replace calls to `git checkout -b' by `git checkout -B'

Alexander Pyhalov (1):
      t7005-editor: quote filename to fix whitespace-issue

Alexander Shopov (3):
      l10n: bg.po: Updated Bulgarian translation (4185t)
      l10n: bg.po: Updated Bulgarian translation (4185t)
      l10n: bg.po: Updated Bulgarian translation (4187t)

Andreas Gruenbacher (1):
      rev-parse: clear --exclude list after 'git rev-parse --all'

Andreas Heiduk (6):
      doc: clarify boundaries of 'git worktree list --porcelain'
      doc: fix ASCII art tab spacing
      doc: fix inappropriate monospace formatting
      doc: fix descripion for 'git tag --format'
      doc: fix indentation of listing blocks in gitweb.conf.txt
      doc: fix formatting in git-update-ref

Anton Serbulov (1):
      mingw: fix getcwd when the parent directory cannot be queried

Antonio Ospite (10):
      submodule: add a print_config_from_gitmodules() helper
      submodule: factor out a config_set_in_gitmodules_file_gently function
      t7411: merge tests 5 and 6
      t7411: be nicer to future tests and really clean things up
      submodule--helper: add a new 'config' subcommand
      submodule: use the 'submodule--helper config' command
      t7506: clean up .gitmodules properly before setting up new scenario
      submodule: add a helper to check if it is safe to write to .gitmodules
      submodule: support reading .gitmodules when it's not in the working tree
      t/helper: add test-submodule-nested-repo-config

Ben Peart (19):
      checkout: optimize "git checkout -b <new_branch>"
      git-mv: allow submodules and fsmonitor to work together
      t/README: correct spelling of "uncommon"
      preload-index: use git_env_bool() not getenv() for customization
      fsmonitor: update GIT_TEST_FSMONITOR support
      read-cache: update TEST_GIT_INDEX_VERSION support
      preload-index: update GIT_FORCE_PRELOAD_TEST support
      read-cache: clean up casting and byte decoding
      eoie: add End of Index Entry (EOIE) extension
      config: add new index.threads config setting
      read-cache: load cache extensions on a worker thread
      ieot: add Index Entry Offset Table (IEOT) extension
      read-cache: load cache entries on worker threads
      reset: don't compute unstaged changes after reset when --quiet
      reset: add new reset.quiet config setting
      reset: warn when refresh_index() takes more than 2 seconds
      speed up refresh_index() by utilizing preload_index()
      add: speed up cmd_add() by utilizing read_cache_preload()
      refresh_index: remove unnecessary calls to preload_index()

Brandon Williams (1):
      config: document value 2 for protocol.version

Brendan Forster (1):
      http: add support for disabling SSL revocation checks in cURL

Carlo Marcelo Arenas Belón (8):
      unpack-trees: avoid dead store for struct progress
      multi-pack-index: avoid dead store for struct progress
      read-cache: use of memory after it is freed
      commit-slabs: move MAYBE_UNUSED out
      khash: silence -Wunused-function for delta-islands
      compat: make sure git_mmap is not expected to write
      sequencer: cleanup for gcc warning in non developer mode
      builtin/notes: remove unnecessary free

Christian Couder (3):
      pack-objects: refactor code into compute_layer_order()
      pack-objects: move tree_depth into 'struct packing_data'
      pack-objects: move 'layer' into 'struct packing_data'

Christian Hesse (2):
      subtree: add build targets 'man' and 'html'
      subtree: make install targets depend on build targets

Christopher Díaz Riveros (2):
      l10n: es.po v2.20.0 round 1
      l10n: es.po v2.20.0 round 3

Daniels Umanovskis (3):
      doc: move git-rev-parse from porcelain to plumbing
      doc: move git-get-tar-commit-id to plumbing
      doc: move git-cherry to plumbing

David Zych (1):
      doc: clarify gitcredentials path component matching

Denton Liu (3):
      mergetool: accept -g/--[no-]gui as arguments
      completion: support `git mergetool --[no-]gui`
      doc: document diff/merge.guitool config keys

Derrick Stolee (93):
      multi-pack-index: add design document
      multi-pack-index: add format details
      multi-pack-index: add builtin
      multi-pack-index: add 'write' verb
      midx: write header information to lockfile
      multi-pack-index: load into memory
      t5319: expand test data
      packfile: generalize pack directory list
      multi-pack-index: read packfile list
      multi-pack-index: write pack names in chunk
      midx: read pack names into array
      midx: sort and deduplicate objects from packfiles
      midx: write object ids in a chunk
      midx: write object id fanout chunk
      midx: write object offsets
      config: create core.multiPackIndex setting
      midx: read objects from multi-pack-index
      midx: use midx in abbreviation calculations
      midx: use existing midx when writing new one
      midx: use midx in approximate_object_count
      midx: prevent duplicate packfile loads
      packfile: skip loading index if in multi-pack-index
      midx: clear midx on repack
      commit-reach: move walk methods from commit.c
      commit.h: remove method declarations
      commit-reach: move ref_newer from remote.c
      commit-reach: move commit_contains from ref-filter
      upload-pack: make reachable() more generic
      upload-pack: refactor ok_to_give_up()
      upload-pack: generalize commit date cutoff
      commit-reach: move can_all_from_reach_with_flags
      test-reach: create new test tool for ref_newer
      test-reach: test in_merge_bases
      test-reach: test is_descendant_of
      test-reach: test get_merge_bases_many
      test-reach: test reduce_heads
      test-reach: test can_all_from_reach_with_flags
      test-reach: test commit_contains
      commit-reach: replace ref_newer logic
      commit-reach: make can_all_from_reach... linear
      commit-reach: use can_all_from_reach
      multi-pack-index: provide more helpful usage info
      multi-pack-index: store local property
      midx: mark bad packed objects
      midx: stop reporting garbage
      midx: fix bug that skips midx with alternates
      packfile: add all_packs list
      treewide: use get_all_packs
      midx: test a few commands that use get_all_packs
      pack-objects: consider packs in multi-pack-index
      commit-graph: update design document
      test-repository: properly init repo
      commit-graph: not compatible with replace objects
      commit-graph: not compatible with grafts
      commit-graph: not compatible with uninitialized repo
      commit-graph: close_commit_graph before shallow walk
      commit-graph: define GIT_TEST_COMMIT_GRAPH
      t3206-range-diff.sh: cover single-patch case
      t5318: use test_oid for HASH_LEN
      multi-pack-index: add 'verify' verb
      multi-pack-index: verify bad header
      multi-pack-index: verify corrupt chunk lookup table
      multi-pack-index: verify packname order
      multi-pack-index: verify missing pack
      multi-pack-index: verify oid fanout order
      multi-pack-index: verify oid lookup order
      multi-pack-index: fix 32-bit vs 64-bit size check
      multi-pack-index: verify object offsets
      multi-pack-index: report progress during 'verify'
      fsck: verify multi-pack-index
      commit-reach: properly peel tags
      commit-reach: fix memory and flag leaks
      commit-reach: cleanups in can_all_from_reach...
      commit-graph: clean up leaked memory during write
      commit-graph: reduce initial oid allocation
      midx: fix broken free() in close_midx()
      contrib: add coverage-diff script
      ci: add optional test variables
      commit-reach: fix first-parent heuristic
      midx: close multi-pack-index on repack
      multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
      packfile: close multi-pack-index in close_all_packs
      prio-queue: add 'peek' operation
      test-reach: add run_three_modes method
      test-reach: add rev-list tests
      revision.c: begin refactoring --topo-order logic
      commit/revisions: bookkeeping before refactoring
      revision.c: generation-based topo-order algorithm
      t6012: make rev-list tests more interesting
      commit-reach: implement get_reachable_subset
      test-reach: test get_reachable_subset
      remote: make add_missing_tags() linear
      pack-objects: ignore ambiguous object warnings

Elijah Newren (14):
      Remove superfluous trailing semicolons
      t4200: demonstrate rerere segfault on specially crafted merge
      rerere: avoid buffer overrun
      update-ref: fix type of update_flags variable to match its usage
      update-ref: allow --no-deref with --stdin
      sequencer: fix --allow-empty-message behavior, make it smarter
      merge-recursive: set paths correctly when three-way merging content
      merge-recursive: avoid wrapper function when unnecessary and wasteful
      merge-recursive: remove final remaining caller of merge_file_one()
      merge-recursive: rename merge_file_1() and merge_content()
      commit: fix erroneous BUG, 'multiple renames on the same target? how?'
      merge-recursive: improve auto-merging messages with path collisions
      merge-recursive: avoid showing conflicts with merge branch before HEAD
      fsck: move fsck_head_link() to get_default_heads() to avoid some globals

Eric Sunshine (26):
      format-patch: allow additional generated content in make_cover_letter()
      format-patch: add --interdiff option to embed diff in cover letter
      format-patch: teach --interdiff to respect -v/--reroll-count
      interdiff: teach show_interdiff() to indent interdiff
      log-tree: show_log: make commentary block delimiting reusable
      format-patch: allow --interdiff to apply to a lone-patch
      range-diff: respect diff_option.file rather than assuming 'stdout'
      range-diff: publish default creation factor
      range-diff: relieve callers of low-level configuration burden
      format-patch: add --range-diff option to embed diff in cover letter
      format-patch: extend --range-diff to accept revision range
      format-patch: teach --range-diff to respect -v/--reroll-count
      format-patch: add --creation-factor tweak for --range-diff
      format-patch: allow --range-diff to apply to a lone-patch
      worktree: don't die() in library function find_worktree()
      worktree: move delete_git_dir() earlier in file for upcoming new callers
      worktree: generalize delete_git_dir() to reduce code duplication
      worktree: prepare for more checks of whether path can become worktree
      worktree: disallow adding same path multiple times
      worktree: teach 'add' to respect --force for registered but missing path
      worktree: teach 'move' to override lock when --force given twice
      worktree: teach 'remove' to override lock when --force given twice
      worktree: delete .git/worktrees if empty after 'remove'
      doc-diff: fix non-portable 'man' invocation
      doc-diff: add --clean mode to remove temporary working gunk
      doc/Makefile: drop doc-diff worktree and temporary files on "make clean"

Frederick Eaton (3):
      git-archimport.1: specify what kind of Arch we're talking about
      git-column.1: clarify initial description, provide examples
      git-describe.1: clarify that "human readable" is also git-readable

Greg Hurrell (1):
      doc: update diff-format.txt for removed ellipses in --raw

James Knight (1):
      build: link with curl-defined linker flags

Jann Horn (2):
      patch-delta: fix oob read
      patch-delta: consistently report corruption

Jean-Noël Avila (3):
      l10n: fr.po v2.20 rnd 1
      i18n: fix small typos
      l10n: fr.po v2.20.0 round 3

Jeff Hostetler (2):
      t0051: test GIT_TRACE to a windows named pipe
      mingw: fix mingw_open_append to work with named pipes

Jeff King (98):
      branch: make "-l" a synonym for "--list"
      Add delta-islands.{c,h}
      pack-objects: add delta-islands support
      repack: add delta-islands support
      t5320: tests for delta islands
      t/perf: factor boilerplate out of test_perf
      t/perf: factor out percent calculations
      t/perf: add infrastructure for measuring sizes
      t/perf: add perf tests for fetches from a bitmapped server
      pack-bitmap: save "have" bitmap from walk
      pack-objects: reuse on-disk deltas for thin "have" objects
      SubmittingPatches: mention doc-diff
      rev-list: make empty --stdin not an error
      trailer: use size_t for string offsets
      trailer: use size_t for iterating trailer list
      trailer: pass process_trailer_opts to trailer_info_get()
      interpret-trailers: tighten check for "---" patch boundary
      interpret-trailers: allow suppressing "---" divider
      pretty, ref-filter: format %(trailers) with no_divider option
      sequencer: ignore "---" divider when parsing trailers
      append_signoff: use size_t for string offsets
      coccinelle: use <...> for function exclusion
      introduce hasheq() and oideq()
      convert "oidcmp() == 0" to oideq()
      convert "hashcmp() == 0" to hasheq()
      convert "oidcmp() != 0" to "!oideq()"
      convert "hashcmp() != 0" to "!hasheq()"
      convert hashmap comparison functions to oideq()
      read-cache: use oideq() in ce_compare functions
      show_dirstat: simplify same-content check
      doc-diff: always use oids inside worktree
      test-delta: read input into a heap buffer
      t5303: test some corrupt deltas
      patch-delta: handle truncated copy parameters
      t5303: use printf to generate delta bases
      doc/git-branch: remove obsolete "-l" references
      bitmap_has_sha1_in_uninteresting(): drop BUG check
      t5310: test delta reuse with bitmaps
      traverse_bitmap_commit_list(): don't free result
      pack-bitmap: drop "loaded" flag
      reopen_tempfile(): truncate opened file
      doc-diff: force worktree add
      config.mak.dev: add -Wformat-security
      pack-objects: handle island check for "external" delta base
      receive-pack: update comment with check_everything_connected
      submodule--helper: use "--" to signal end of clone options
      submodule-config: ban submodule urls that start with dash
      submodule-config: ban submodule paths that start with a dash
      fsck: detect submodule urls starting with dash
      fsck: detect submodule paths starting with dash
      more oideq/hasheq conversions
      transport: drop refnames from for_each_alternate_ref
      test-tool: show tool list on error
      config.mak.dev: enable -Wunused-function
      run-command: mark path lookup errors with ENOENT
      t5410: use longer path for sample script
      upload-pack: fix broken if/else chain in config callback
      t1450: check large blob in trailing-garbage test
      check_stream_sha1(): handle input underflow
      cat-file: handle streaming failures consistently
      ls-remote: do not send ref prefixes for patterns
      ls-remote: pass heads/tags prefixes to transport
      read_istream_pack_non_delta(): document input handling
      xdiff: provide a separate emit callback for hunks
      xdiff-interface: provide a separate consume callback for hunks
      rev-list: handle flags for --indexed-objects
      approxidate: handle pending number for "specials"
      pathspec: handle non-terminated strings with :(attr)
      diff: avoid generating unused hunk header lines
      diff: discard hunk headers for patch-ids earlier
      diff: use hunk callback for word-diff
      combine-diff: use an xdiff hunk callback
      diff: convert --check to use a hunk callback
      range-diff: use a hunk callback
      xdiff-interface: drop parse_hunk_header()
      apply: mark include/exclude options as NONEG
      am: handle --no-patch-format option
      ls-files: mark exclude options as NONEG
      pack-objects: mark index-version option as NONEG
      cat-file: mark batch options with NONEG
      status: mark --find-renames option with NONEG
      format-patch: mark "--no-numbered" option with NONEG
      show-branch: mark --reflog option as NONEG
      tag: mark "--message" option with NONEG
      cat-file: report an error on multiple --batch options
      apply: return -1 from option callback instead of calling exit(1)
      parse-options: drop OPT_DATE()
      assert NOARG/NONEG behavior of parse-options callbacks
      midx: double-check large object write loop
      merge: extract verify_merge_signature() helper
      merge: handle --verify-signatures for unborn branch
      pull: handle --verify-signatures for unborn branch
      approxidate: fix NULL dereference in date_time()
      bundle: dup() output descriptor closer to point-of-use
      pack-objects: fix tree_depth and layer invariants
      pack-objects: zero-initialize tree_depth/layer arrays
      pack-objects: fix off-by-one in delta-island tree-depth computation
      t5562: fix perl path

Jiang Xin (5):
      l10n: zh_CN: review for git v2.19.0 l10n
      l10n: git.pot: v2.20.0 round 1 (254 new, 27 removed)
      l10n: git.pot: v2.20.0 round 2 (2 new, 2 removed)
      l10n: git.pot: v2.20.0 round 3 (5 new, 3 removed)
      l10n: zh_CN: for git v2.20.0 l10n round 1 to 3

Johannes Schindelin (64):
      rebase -i --autosquash: demonstrate a problem skipping the last squash
      rebase -i: be careful to wrap up fixup/squash chains
      compat/poll: prepare for targeting Windows Vista
      mingw: set _WIN32_WINNT explicitly for Git for Windows
      mingw: bump the minimum Windows version to Vista
      builtin rebase: prepare for builtin rebase -i
      rebase -i: clarify what happens on a failed `exec`
      rebase -i: introduce the 'break' command
      getpwuid(mingw): initialize the structure only once
      getpwuid(mingw): provide a better default for the user name
      mingw: use domain information for default email
      http: add support for selecting SSL backends at runtime
      pack-objects: fix typo 'detla' -> 'delta'
      pack-objects (mingw): demonstrate a segmentation fault with large deltas
      pack-objects (mingw): initialize `packing_data` mutex in the correct spot
      rebase (autostash): avoid duplicate call to state_dir_path()
      rebase (autostash): store the full OID in <state-dir>/autostash
      rebase (autostash): use an explicit OID to apply the stash
      mingw: factor out code to set stat() data
      rebase --autostash: demonstrate a problem with dirty submodules
      rebase --autostash: fix issue with dirty submodules
      mingw: load system libraries the recommended way
      mingw: ensure `getcwd()` reports the correct case
      repack: point out a bug handling stale shallow info
      shallow: offer to prune only non-existing entries
      repack -ad: prune the list of shallow commits
      http: when using Secure Channel, ignore sslCAInfo by default
      t7800: fix quoting
      mingw: reencode environment variables on the fly (UTF-16 <-> UTF-8)
      config: rename `dummy` parameter to `cb` in git_default_config()
      config: allow for platform-specific core.* config settings
      config: move Windows-specific config settings into compat/mingw.c
      mingw: unset PERL5LIB by default
      mingw: fix isatty() after dup2()
      t3404: decouple some test cases from outcomes of previous test cases
      t3418: decouple test cases from a previous `rebase -p` test case
      tests: optionally skip `git rebase -p` tests
      Windows: force-recompile git.res for differing architectures
      built-in rebase: demonstrate regression with --autostash
      built-in rebase --autostash: leave the current branch alone if possible
      Update .mailmap
      rebase -r: demonstrate bug with conflicting merges
      rebase -r: do not write MERGE_HEAD unless needed
      rebase -i: include MERGE_HEAD into files to clean up
      built-in rebase --skip/--abort: clean up stale .git/<name> files
      status: rebase and merge can be in progress at the same time
      apply --recount: allow "no-op hunks"
      rebase: consolidate clean-up code before leaving reset_head()
      rebase: prepare reset_head() for more flags
      built-in rebase: reinstate `checkout -q` behavior where appropriate
      tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/
      tests: respect GIT_TEST_INSTALLED when initializing repositories
      t/lib-gettext: test installed git-sh-i18n if GIT_TEST_INSTALLED is set
      mingw: use `CreateHardLink()` directly
      rebase: really just passthru the `git am` options
      rebase: validate -C<n> and --whitespace=<mode> parameters early
      config: report a bug if git_dir exists without commondir
      tests: do not require Git to be built when testing an installed Git
      tests: explicitly use `git.exe` on Windows
      mingw: replace an obsolete link with the superseding one
      legacy-rebase: backport -C<n> and --whitespace=<option> checks
      rebase: warn about the correct tree's OID
      rebase: fix GIT_REFLOG_ACTION regression
      rebase --stat: fix when rebasing to an unrelated history

Johannes Sixt (4):
      diff: don't attempt to strip prefix from absolute Windows paths
      rebase -i: recognize short commands without arguments
      t3404-rebase-interactive: test abbreviated commands
      rebase docs: fix incorrect format of the section Behavioral Differences

Jonathan Nieder (9):
      gc: improve handling of errors reading gc.log
      gc: exit with status 128 on failure
      gc: do not return error for prior errors in daemonized mode
      commit-reach: correct accidental #include of C file
      mailmap: consistently normalize brian m. carlson's name
      git doc: direct bug reporters to mailing list archive
      eoie: default to not writing EOIE section
      ieot: default to not writing IEOT section
      index: make index.threads=true enable ieot and eoie

Jonathan Tan (15):
      fetch-object: unify fetch_object[s] functions
      fetch-object: set exact_oid when fetching
      connected: document connectivity in partial clones
      fetch: in partial clone, check presence of targets
      fetch-pack: avoid object flags if no_dependents
      fetch-pack: exclude blobs when lazy-fetching trees
      transport: allow skipping of ref listing
      transport: do not list refs if possible
      transport: list refs before fetch if necessary
      fetch: do not list refs if fetching only hashes
      cache-tree: skip some blob checks in partial clone
      upload-pack: make have_obj not global
      upload-pack: make want_obj not global
      upload-pack: clear flags before each v2 request
      fetch-pack: be more precise in parsing v2 response

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: Update Catalan translation

Josh Steadmon (4):
      fuzz: add basic fuzz testing target.
      fuzz: add fuzz testing for packfile indices.
      archive: initialize archivers earlier
      Makefile: use FUZZ_CXXFLAGS for linking fuzzers

Joshua Watt (1):
      send-email: explicitly disable authentication

Junio C Hamano (37):
      Revert "doc/Makefile: drop doc-diff worktree and temporary files on "make clean""
      Initial batch post 2.19
      Second batch post 2.19
      Git 2.14.5
      Git 2.15.3
      Git 2.16.5
      Git 2.17.2
      Git 2.18.1
      Git 2.19.1
      t0000: do not get self-test disrupted by environment warnings
      CodingGuidelines: document the API in *.h files
      Declare that the next one will be named 2.20
      Third batch for 2.20
      rebase: fix typoes in error messages
      Fourth batch for 2.20
      Revert "subtree: make install targets depend on build targets"
      Fifth batch for 2.20
      receive: denyCurrentBranch=updateinstead should not blindly update
      cocci: simplify "if (++u > 1)" to "if (u++)"
      fsck: s/++i > 1/i++/
      http: give curl version warnings consistently
      Sixth batch for 2.20
      Seventh batch for 2.20
      fetch: replace string-list used as a look-up table with a hashmap
      rebase: apply cocci patch
      Eighth batch for 2.20
      Ninth batch for 2.20
      Makefile: ease dynamic-gettext-poison transition
      Tenth batch for 2.20
      Git 2.20-rc0
      RelNotes: name the release properly
      Prepare for 2.20-rc1
      Git 2.19.2
      Git 2.20-rc1
      format-patch: do not let its diff-options affect --range-diff
      Git 2.20-rc2
      Git 2.20

Karsten Blees (2):
      mingw: replace MSVCRT's fstat() with a Win32-based implementation
      mingw: implement nanosecond-precision file times

Loo Rong Jie (1):
      win32: replace pthread_cond_*() with much simpler code

Lucas De Marchi (1):
      range-diff: allow to diff files regardless of submodule config

Luke Diamand (3):
      git-p4: do not fail in verbose mode for missing 'fileSize' key
      git-p4: unshelve into refs/remotes/p4-unshelved, not refs/remotes/p4/unshelved
      git-p4: fully support unshelving changelists

Martin Ågren (15):
      Doc: use `--type=bool` instead of `--bool`
      git-config.txt: fix 'see: above' note
      git-commit-graph.txt: fix bullet lists
      git-commit-graph.txt: typeset more in monospace
      git-commit-graph.txt: refer to "*commit*-graph file"
      Doc: refer to the "commit-graph file" with dash
      t1400: drop debug `echo` to actually execute `test`
      builtin/commit-graph.c: UNLEAK variables
      sequencer: break out of loop explicitly
      git-reset.txt: render tables correctly under Asciidoctor
      git-reset.txt: render literal examples as monospace
      range-diff: always pass at least minimal diff options
      RelNotes 2.20: move some items between sections
      RelNotes 2.20: clarify sentence
      RelNotes 2.20: drop spurious double quote

Matthew DeVore (19):
      list-objects: store common func args in struct
      list-objects: refactor to process_tree_contents
      list-objects: always parse trees gently
      t/README: reformat Do, Don't, Keep in mind lists
      Documentation: add shell guidelines
      tests: standardize pipe placement
      t/*: fix ordering of expected/observed arguments
      tests: don't swallow Git errors upstream of pipes
      t9109: don't swallow Git errors upstream of pipes
      tests: order arguments to git-rev-list properly
      rev-list: handle missing tree objects properly
      revision: mark non-user-given objects instead
      list-objects-filter: use BUG rather than die
      list-objects-filter-options: do not over-strbuf_init
      list-objects-filter: implement filter tree:0
      filter-trees: code clean-up of tests
      list-objects: support for skipping tree traversal
      Documentation/git-log.txt: do not show --exclude-promisor-objects
      exclude-promisor-objects: declare when option is allowed

Max Kirillov (1):
      http-backend test: make empty CONTENT_LENGTH test more realistic

Michael Witten (3):
      docs: typo: s/go/to/
      docs: graph: remove unnecessary `graph_update()' call
      docs: typo: s/isimilar/similar/

Michał Górny (6):
      gpg-interface.c: detect and reject multiple signatures on commits
      gpg-interface.c: use flags to determine key/signer info presence
      gpg-interface.c: support getting key fingerprint via %GF format
      gpg-interface.c: obtain primary key fingerprint as well
      t/t7510-signed-commit.sh: Add %GP to custom format checks
      t/t7510-signed-commit.sh: add signing subkey to Eris Discordia key

Mihir Mehta (1):
      doc: fix a typo and clarify a sentence

Minh Nguyen (1):
      l10n: vi.po: fix typo in pack-objects

Nguyễn Thái Ngọc Duy (170):
      clone: report duplicate entries on case-insensitive filesystems
      trace.h: support nested performance tracing
      unpack-trees: add performance tracing
      unpack-trees: optimize walking same trees with cache-tree
      unpack-trees: reduce malloc in cache-tree walk
      unpack-trees: reuse (still valid) cache-tree from src_index
      unpack-trees: add missing cache invalidation
      cache-tree: verify valid cache-tree in the test suite
      Document update for nd/unpack-trees-with-cache-tree
      bisect.c: make show_list() build again
      t/helper: keep test-tool command list sorted
      t/helper: merge test-dump-untracked-cache into test-tool
      t/helper: merge test-pkt-line into test-tool
      t/helper: merge test-parse-options into test-tool
      t/helper: merge test-dump-fsmonitor into test-tool
      Makefile: add a hint about TEST_BUILTINS_OBJS
      config.txt: follow camelCase naming
      config.txt: move fetch part out to a separate file
      config.txt: move format part out to a separate file
      config.txt: move gitcvs part out to a separate file
      config.txt: move gui part out to a separate file
      config.txt: move pull part out to a separate file
      config.txt: move push part out to a separate file
      config.txt: move receive part out to a separate file
      config.txt: move sendemail part out to a separate file
      config.txt: move sequence.editor out of "core" part
      config.txt: move submodule part out to a separate file
      archive.c: remove implicit dependency the_repository
      status: show progress bar if refreshing the index takes too long
      add: do not accept pathspec magic 'attr'
      completion: support "git fetch --multiple"
      read-cache.c: remove 'const' from index_has_changes()
      diff.c: reduce implicit dependency on the_index
      combine-diff.c: remove implicit dependency on the_index
      blame.c: rename "repo" argument to "r"
      diff.c: remove the_index dependency in textconv() functions
      grep.c: remove implicit dependency on the_index
      diff.c: remove implicit dependency on the_index
      read-cache.c: remove implicit dependency on the_index
      diff-lib.c: remove implicit dependency on the_index
      ll-merge.c: remove implicit dependency on the_index
      merge-blobs.c: remove implicit dependency on the_index
      merge.c: remove implicit dependency on the_index
      patch-ids.c: remove implicit dependency on the_index
      sha1-file.c: remove implicit dependency on the_index
      rerere.c: remove implicit dependency on the_index
      userdiff.c: remove implicit dependency on the_index
      line-range.c: remove implicit dependency on the_index
      submodule.c: remove implicit dependency on the_index
      tree-diff.c: remove implicit dependency on the_index
      ws.c: remove implicit dependency on the_index
      revision.c: remove implicit dependency on the_index
      revision.c: reduce implicit dependency the_repository
      read-cache.c: optimize reading index format v4
      config.txt: correct the note about uploadpack.packObjectsHook
      help -a: improve and make --verbose default
      refs.c: indent with tabs, not spaces
      Add a place for (not) sharing stuff between worktrees
      submodule.c: remove some of the_repository references
      completion: fix __gitcomp_builtin no longer consider extra options
      t1300: extract and use test_cmp_config()
      worktree: add per-worktree config files
      refs: new ref types to make per-worktree refs visible to all worktrees
      revision.c: correct a parameter name
      revision.c: better error reporting on ref from different worktrees
      fsck: check HEAD and reflog from other worktrees
      reflog expire: cover reflog from all worktrees
      Update makefile in preparation for Documentation/config/*.txt
      config.txt: move advice.* to a separate file
      config.txt: move core.* to a separate file
      config.txt: move add.* to a separate file
      config.txt: move alias.* to a separate file
      config.txt: move am.* to a separate file
      config.txt: move apply.* to a separate file
      config.txt: move blame.* to a separate file
      config.txt: move branch.* to a separate file
      config.txt: move browser.* to a separate file
      config.txt: move checkout.* to a separate file
      config.txt: move clean.* to a separate file
      config.txt: move color.* to a separate file
      config.txt: move column.* to a separate file
      config.txt: move commit.* to a separate file
      config.txt: move credential.* to a separate file
      config.txt: move completion.* to a separate file
      config.txt: move diff-config.txt to config/
      config.txt: move difftool.* to a separate file
      config.txt: move fastimport.* to a separate file
      config.txt: move fetch-config.txt to config/
      config.txt: move filter.* to a separate file
      config.txt: move format-config.txt to config/
      config.txt: move fmt-merge-msg-config.txt to config/
      config.txt: move fsck.* to a separate file
      config.txt: move gc.* to a separate file
      config.txt: move gitcvs-config.txt to config/
      config.txt: move gitweb.* to a separate file
      config.txt: move grep.* to a separate file
      config.txt: move gpg.* to a separate file
      config.txt: move gui-config.txt to config/
      config.txt: move guitool.* to a separate file
      config.txt: move help.* to a separate file
      config.txt: move ssh.* to a separate file
      config.txt: move http.* to a separate file
      config.txt: move i18n.* to a separate file
      git-imap-send.txt: move imap.* to a separate file
      config.txt: move index.* to a separate file
      config.txt: move init.* to a separate file
      config.txt: move instaweb.* to a separate file
      config.txt: move interactive.* to a separate file
      config.txt: move log.* to a separate file
      config.txt: move mailinfo.* to a separate file
      config.txt: move mailmap.* to a separate file
      config.txt: move man.* to a separate file
      config.txt: move merge-config.txt to config/
      config.txt: move mergetool.* to a separate file
      config.txt: move notes.* to a separate file
      config.txt: move pack.* to a separate file
      config.txt: move pager.* to a separate file
      config.txt: move pretty.* to a separate file
      config.txt: move protocol.* to a separate file
      config.txt: move pull-config.txt to config/
      config.txt: move push-config.txt to config/
      config.txt: move rebase-config.txt to config/
      config.txt: move receive-config.txt to config/
      config.txt: move remote.* to a separate file
      config.txt: move remotes.* to a separate file
      config.txt: move repack.* to a separate file
      config.txt: move rerere.* to a separate file
      config.txt: move reset.* to a separate file
      config.txt: move sendemail-config.txt to config/
      config.txt: move sequencer.* to a separate file
      config.txt: move showBranch.* to a separate file
      config.txt: move splitIndex.* to a separate file
      config.txt: move status.* to a separate file
      config.txt: move stash.* to a separate file
      config.txt: move submodule.* to a separate file
      config.txt: move tag.* to a separate file
      config.txt: move transfer.* to a separate file
      config.txt: move uploadarchive.* to a separate file
      config.txt: move uploadpack.* to a separate file
      config.txt: move url.* to a separate file
      config.txt: move user.* to a separate file
      config.txt: move versionsort.* to a separate file
      config.txt: move web.* to a separate file
      config.txt: move worktree.* to a separate file
      config.txt: remove config/dummy.txt
      thread-utils: macros to unconditionally compile pthreads API
      wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode
      git-worktree.txt: correct linkgit command name
      sequencer.c: remove a stray semicolon
      tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
      run-command.h: include thread-utils.h instead of pthread.h
      send-pack.c: move async's #ifdef NO_PTHREADS back to run-command.c
      index-pack: remove #ifdef NO_PTHREADS
      name-hash.c: remove #ifdef NO_PTHREADS
      attr.c: remove #ifdef NO_PTHREADS
      grep: remove #ifdef NO_PTHREADS
      grep: clean up num_threads handling
      preload-index.c: remove #ifdef NO_PTHREADS
      pack-objects: remove #ifdef NO_PTHREADS
      read-cache.c: remove #ifdef NO_PTHREADS
      read-cache.c: reduce branching based on HAVE_THREADS
      read-cache.c: initialize copy_len to shut up gcc 8
      Clean up pthread_create() error handling
      completion: use __gitcomp_builtin for format-patch
      build: fix broken command-list.h generation with core.autocrlf
      format-patch: respect --stat in cover letter's diffstat
      doc: move extensions.worktreeConfig to the right place
      clone: fix colliding file detection on APFS
      files-backend.c: fix build error on Solaris
      transport-helper.c: do not translate a string twice

Nickolai Belakovski (2):
      worktree: update documentation for lock_reason and lock_reason_valid
      worktree: rename is_worktree_locked to worktree_lock_reason

Noam Postavsky (1):
      log: fix coloring of certain octopus merge shapes

Olga Telezhnaya (3):
      ref-filter: free memory from used_atom
      ls-remote: release memory instead of UNLEAK
      ref-filter: free item->value and item->value->s

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (4185t0f0u)
      l10n: sv.po: Update Swedish translation (4187t0f0u)

Phillip Wood (11):
      diff: fix --color-moved-ws=allow-indentation-change
      diff --color-moved-ws: fix double free crash
      diff --color-moved-ws: fix out of bounds string access
      diff --color-moved-ws: fix a memory leak
      diff --color-moved-ws: fix another memory leak
      diff --color-moved: fix a memory leak
      am: don't die in read_author_script()
      am: improve author-script error reporting
      am: rename read_author_script()
      add read_author_script() to libgit
      sequencer: use read_author_script()

Pratik Karki (46):
      rebase: start implementing it as a builtin
      rebase: refactor common shell functions into their own file
      builtin/rebase: support running "git rebase <upstream>"
      builtin rebase: support --onto
      builtin rebase: support `git rebase --onto A...B`
      builtin rebase: handle the pre-rebase hook and --no-verify
      builtin rebase: support --quiet
      builtin rebase: support the `verbose` and `diffstat` options
      builtin rebase: require a clean worktree
      builtin rebase: try to fast forward when possible
      builtin rebase: support --force-rebase
      builtin rebase: start a new rebase only if none is in progress
      builtin rebase: only store fully-qualified refs in `options.head_name`
      builtin rebase: support `git rebase <upstream> <switch-to>`
      builtin rebase: support --continue
      builtin rebase: support --skip
      builtin rebase: support --abort
      builtin rebase: support --quit
      builtin rebase: support --edit-todo and --show-current-patch
      builtin rebase: actions require a rebase in progress
      builtin rebase: stop if `git am` is in progress
      builtin rebase: allow selecting the rebase "backend"
      builtin rebase: support --signoff
      builtin rebase: support --rerere-autoupdate
      builtin rebase: support --committer-date-is-author-date
      builtin rebase: support `ignore-whitespace` option
      builtin rebase: support `ignore-date` option
      builtin rebase: support `keep-empty` option
      builtin rebase: support `--autosquash`
      builtin rebase: support `--gpg-sign` option
      builtin rebase: support `-C` and `--whitespace=<type>`
      builtin rebase: support `--autostash` option
      builtin rebase: support `--exec`
      builtin rebase: support `--allow-empty-message` option
      builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
      merge-base --fork-point: extract libified function
      builtin rebase: support `fork-point` option
      builtin rebase: add support for custom merge strategies
      builtin rebase: support --root
      builtin rebase: optionally auto-detect the upstream
      builtin rebase: optionally pass custom reflogs to reset_head()
      builtin rebase: fast-forward to onto if it is a proper descendant
      builtin rebase: show progress when connected to a terminal
      builtin rebase: use no-op editor when interactive is "implied"
      builtin rebase: error out on incompatible option/mode combinations
      rebase: default to using the builtin rebase

Rafael Ascensão (2):
      refs: show --exclude failure with --branches/tags/remotes=glob
      refs: fix some exclude patterns being ignored

Ralf Thielow (5):
      git-rebase.sh: fix typos in error messages
      l10n: update German translation
      builtin/rebase.c: remove superfluous space in messages
      l10n: update German translation
      l10n: de.po: fix two messages

Ramsay Jones (12):
      Makefile: add a hdr-check target
      json-writer.h: add missing include (hdr-check)
      ewah/ewok_rlw.h: add missing include (hdr-check)
      refs/ref-cache.h: add missing declarations (hdr-check)
      refs/packed-backend.h: add missing declaration (hdr-check)
      refs/refs-internal.h: add missing declarations (hdr-check)
      midx.h: add missing forward declarations (hdr-check)
      delta-islands.h: add missing forward declarations (hdr-check)
      headers: normalize the spelling of some header guards
      fetch-object.h: add missing declaration (hdr-check)
      ewok_rlw.h: add missing 'inline' to function definition
      commit-reach.h: add missing declarations (hdr-check)

Rasmus Villemoes (6):
      help: redirect to aliased commands for "git cmd --help"
      git.c: handle_alias: prepend alias info when first argument is -h
      git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
      Documentation/git-send-email.txt: style fixes
      send-email: only consider lines containing @ or <> for automatic Cc'ing
      send-email: also pick up cc addresses from -by trailers

René Scharfe (12):
      mailinfo: support format=flowed
      fsck: add a performance test for skipList
      fsck: use strbuf_getline() to read skiplist file
      fsck: use oidset instead of oid_array for skipList
      sequencer: use return value of oidset_insert()
      grep: add -r/--[no-]recursive
      fetch-pack: factor out is_unmatched_ref()
      fetch-pack: load tip_oids eagerly iff needed
      khash: factor out kh_release_*
      oidset: use khash
      oidset: uninline oidset_init()
      commit-reach: fix cast in compare_commits_by_gen()

Roger Strain (1):
      subtree: performance improvement for finding unexpected parent commits

SZEDER Gábor (20):
      t1404: increase core.packedRefsTimeout to avoid occasional test failure
      Documentation/git.txt: clarify that GIT_TRACE=/path appends
      t3701-add-interactive: tighten the check of trace output
      t1700-split-index: drop unnecessary 'grep'
      t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split index
      t1700-split-index: document why FSMONITOR is disabled in this test script
      split-index: add tests to demonstrate the racy split index problem
      t1700-split-index: date back files to avoid racy situations
      split-index: count the number of deleted entries
      split-index: don't compare cached data of entries already marked for split index
      split-index: smudge and add racily clean cache entries to split index
      split-index: BUG() when cache entry refers to non-existing shared entry
      object_id.cocci: match only expressions of type 'struct object_id'
      test-lib: introduce the '-V' short option for '--verbose-log'
      travis-ci: install packages in 'ci/install-dependencies.sh'
      coccicheck: introduce 'pending' semantic patches
      ref-filter: don't look for objects when outside of a repository
      tests: send "bug in the test script" errors to the script's stderr
      test-lib-functions: make 'test_cmp_rev' more informative on failure
      t/lib-git-daemon: fix signal checking

Sam McKelvie (1):
      rev-parse: --show-superproject-working-tree should work during a merge

Saulius Gurklys (1):
      doc: fix small typo in git show-branch

Sebastian Staudt (1):
      travis-ci: no longer use containers

Shulhan (1):
      builtin/remote: quote remote name on error to display empty name

Stefan Beller (25):
      git-submodule.sh: align error reporting for update mode to use path
      git-submodule.sh: rename unused variables
      builtin/submodule--helper: factor out submodule updating
      builtin/submodule--helper: store update_clone information in a struct
      builtin/submodule--helper: factor out method to update a single submodule
      submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
      submodule--helper: introduce new update-module-mode helper
      test_decode_color: understand FAINT and ITALIC
      t3206: add color test for range-diff --dual-color
      diff.c: simplify caller of emit_line_0
      diff.c: reorder arguments for emit_line_ws_markup
      diff.c: add set_sign to emit_line_0
      diff: use emit_line_0 once per line
      diff.c: omit check for line prefix in emit_line_0
      diff.c: rewrite emit_line_0 more understandably
      diff.c: add --output-indicator-{new, old, context}
      range-diff: make use of different output indicators
      range-diff: indent special lines as context
      refs.c: migrate internal ref iteration to pass thru repository argument
      refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
      string-list: remove unused function print_string_list
      strbuf.h: format according to coding guidelines
      diff.c: pass sign_index to emit_line_ws_markup
      submodule helper: convert relative URL to absolute URL if needed
      builtin/submodule--helper: remove debugging leftover tracing

Stephen P. Smith (10):
      wt-status.c: move has_unmerged earlier in the file
      wt-status: rename commitable to committable
      t7501: add test of "commit --dry-run --short"
      wt-status.c: set the committable flag in the collect phase
      roll wt_status_state into wt_status and populate in the collect phase
      t2000: rename and combine checkout clash tests
      t7509: cleanup description and filename
      t7502: rename commit test script to comply with naming convention
      t7500: rename commit tests script to comply with naming convention
      t7501: rename commit test to comply with naming convention

Steve Hoelzer (1):
      poll: use GetTickCount64() to avoid wrap-around issues

Steven Fernandez (1):
      git-completion.bash: add completion for stash list

Strain, Roger L (4):
      subtree: refactor split of a commit into standalone method
      subtree: make --ignore-joins pay attention to adds
      subtree: use commits before rejoins for splits
      subtree: improve decision on merges kept in split

Sven Strickroth (1):
      msvc: directly use MS version (_stricmp) of strcasecmp

Tao Qingyun (3):
      refs: docstring typo
      builtin/branch.c: remove useless branch_get
      branch: trivial style fix

Taylor Blau (4):
      transport.c: extract 'fill_alternate_refs_command'
      transport.c: introduce core.alternateRefsCommand
      transport.c: introduce core.alternateRefsPrefixes
      Documentation/config.txt: fix typo in core.alternateRefsCommand

Thomas Gummerer (17):
      rerere: unify error messages when read_cache fails
      rerere: lowercase error messages
      rerere: wrap paths in output in sq
      rerere: mark strings for translation
      rerere: add documentation for conflict normalization
      rerere: fix crash with files rerere can't handle
      rerere: only return whether a path has conflicts or not
      rerere: factor out handle_conflict function
      rerere: return strbuf from handle path
      rerere: teach rerere to handle nested conflicts
      rerere: recalculate conflict ID when unresolved conflict is committed
      rerere: mention caveat about unmatched conflict markers
      rerere: add note about files with existing conflict markers
      .gitattributes: add conflict-marker-size for relevant files
      linear-assignment: fix potential out of bounds memory access
      t5551: move setup code inside test_expect blocks
      t5551: compare sorted cookies files

Tim Schumacher (4):
      Documentation/Makefile: make manpage-base-url.xsl generation quieter
      alias: add support for aliases of an alias
      alias: show the call history when an alias is looping
      t0014: introduce an alias testing suite

Todd Zullinger (1):
      Documentation: build technical/multi-pack-index

Torsten Bögershausen (5):
      Make git_check_attr() a void function
      path.c: char is not (always) signed
      Upcast size_t variables to uintmax_t when printing
      remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)
      t5601-99: Enable colliding file detection for MINGW

Trần Ngọc Quân (2):
      l10n: vi(4185t): Updated Vietnamese translation for v2.20.0
      l10n: vi(4187t): Updated Vietnamese translation for v2.20.0 rd3

Uwe Kleine-König (1):
      howto/using-merge-subtree: mention --allow-unrelated-histories

brian m. carlson (26):
      t: add test functions to translate hash-related values
      t0000: use hash translation table
      t0000: update tests for SHA-256
      t0002: abstract away SHA-1 specific constants
      t0064: make hash size independent
      t1006: make hash size independent
      t1400: switch hard-coded object ID to variable
      t1405: make hash size independent
      t1406: make hash-size independent
      t1407: make hash size independent
      editorconfig: provide editor settings for Git developers
      editorconfig: indicate settings should be kept in sync
      pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
      builtin/repack: replace hard-coded constants
      builtin/mktree: remove hard-coded constant
      builtin/fetch-pack: remove constants with parse_oid_hex
      pack-revindex: express constants in terms of the_hash_algo
      packfile: express constants in terms of the_hash_algo
      refs/packed-backend: express constants using the_hash_algo
      upload-pack: express constants in terms of the_hash_algo
      transport: use parse_oid_hex instead of a constant
      tag: express constant in terms of the_hash_algo
      apply: replace hard-coded constants
      apply: rename new_sha1_prefix and old_sha1_prefix
      submodule: make zero-oid comparison hash function agnostic
      rerere: convert to use the_hash_algo

Ævar Arnfjörð Bjarmason (35):
      fetch: change "branch" to "reference" in --force -h output
      push tests: make use of unused $1 in test description
      push tests: use spaces in interpolated string
      fetch tests: add a test for clobbering tag behavior
      push doc: remove confusing mention of remote merger
      push doc: move mention of "tag <tag>" later in the prose
      push doc: correct lies about how push refspecs work
      fetch: document local ref updates with/without --force
      fetch: stop clobbering existing tags without --force
      fsck tests: setup of bogus commit object
      fsck tests: add a test for no skipList input
      fsck: document and test sorted skipList input
      fsck: document and test commented & empty line skipList input
      fsck: document that skipList input must be unabbreviated
      fsck: add a performance test
      fsck: support comments & empty lines in skipList
      commit-graph write: add progress output
      commit-graph verify: add progress output
      config doc: add missing list separator for checkout.optimizeNewBranch
      push doc: add spacing between two words
      fetch doc: correct grammar in --force docs
      gc: fix regression in 7b0f229222 impacting --quiet
      gc doc: mention the commit-graph in the intro
      pack-objects test: modernize style
      pack-objects tests: don't leave test .git corrupt at end
      index-pack tests: don't leave test repo dirty at end
      i18n: make GETTEXT_POISON a runtime option
      range-diff doc: add a section about output stability
      range-diff: fix regression in passing along diff options
      range-diff: make diff option behavior (e.g. --stat) consistent
      push: change needlessly ambiguous example in error
      rebase doc: document rebase.useBuiltin
      tests: add a special setup where rebase.useBuiltin is off
      read-cache: make the split index obey umask settings
      advice: don't pointlessly suggest --convert-graft-file

Đoàn Trần Công Danh (1):
      git-compat-util: prefer poll.h to sys/poll.h

