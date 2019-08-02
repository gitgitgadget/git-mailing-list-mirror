Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F611F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437176AbfHBWGX (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:06:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51869 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfHBWGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:06:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DDC515E223;
        Fri,  2 Aug 2019 18:06:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=4xjpRZPduYjME7ieyTFZU3PdP
        iQ=; b=IEQiHcECBYcKBaMcksVc38hE4wg4SiDOVqHqrXoqjydJpzpmSmPjPwL8Q
        9N82AViMTwkA7U4jfIqbt/Tb0eQKS7opGQqRmAVL90h2hCSU7MhQBIl4EsqRyaFB
        uIRqmd04h90mQ6NZVfOYYXTuWd5Jj+vELlmxiIALJYfVUBQppM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Z2/6tfZfR572sJsPkgy
        zKKQXsEJiMWvdfjqJHsS6yVdEFefRcwS8Rga/XwQfpIM4LTNBduGu4mdOHzMUFFc
        Sk/+MgQuWWxOUvhCqMyoHQHfaCKD45Pwvs7N4ogRldVoDTGXvkqG/tQt5bnGV8u3
        CGSzZ6eCOuYUefvQEdy3vQCc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94DF415E222;
        Fri,  2 Aug 2019 18:06:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF6FF15E220;
        Fri,  2 Aug 2019 18:06:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.23.0-rc1
Date:   Fri, 02 Aug 2019 15:06:05 -0700
Message-ID: <xmqq36ijjk8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA0A8E36-B571-11E9-A862-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.23.0-rc1 is now available for testing
at the usual places.  It is comprised of 471 non-merge commits
since v2.22.0, contributed by 63 people, 23 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.23.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.22.0 are as follows.
Welcome to the Git development community!

  Ariadne Conill, Barret Rhoden, Ben Avison, Daniel Ferreira, Doug
  Ilijev, Dr. Adam Nielsen, Jakub Wilk, John Lin, Matheus Tavares,
  Mazo, Andrey, Michael Osipov, Michael Platings, Miguel Ojeda,
  Mike Mueller, Morian Sonnet, Quentin Nerden, Robert Morgan,
  Simon Williams, Steven Roberts, Tigran Mkrtchyan, Varun Naik,
  Vishal Verma, and Xin Li.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Beat Bolli, Boxuan Li, brian
  m. carlson, Carlo Marcelo Arenas Bel=C3=B3n, Cesar Eduardo Barros,
  Chris Mayo, Christian Couder, Denton Liu, Derrick Stolee,
  Dimitriy Ryazantcev, Edmundo Carmona Antoranz, Elijah Newren,
  Emily Shaffer, Eric Wong, Felipe Contreras, Jeff Hostetler,
  Jeff King, Johannes Schindelin, Johannes Sixt, Jonathan Tan,
  Josh Steadmon, Junio C Hamano, Karsten Blees, Marc-Andr=C3=A9 Lureau,
  Martin =C3=85gren, Matthew DeVore, Mike Hommey, Nguy=E1=BB=85n Th=C3=A1=
i Ng=E1=BB=8Dc
  Duy, Nickolai Belakovski, Paolo Bonzini, Philip Oakley, Phillip
  Wood, Ramsay Jones, Ren=C3=A9 Scharfe, Rohit Ashiwal, Stephen Boyd,
  SZEDER G=C3=A1bor, Taylor Blau, and Thomas Gummerer.

----------------------------------------------------------------

Git 2.23 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Updates since v2.22
-------------------

Backward compatibility note

 * The "--base" option of "format-patch" computed the patch-ids for
   prerequisite patches in an unstable way, which has been updated to
   compute in a way that is compatible with "git patch-id --stable".

 * The "git log" command by default behaves as if the --mailmap option
   was given.


UI, Workflows & Features

 * The "git fast-export/import" pair has been taught to handle commits
   with log messages in encoding other than UTF-8 better.

 * In recent versions of Git, per-worktree refs are exposed in
   refs/worktrees/<wtname>/ hierarchy, which means that worktree names
   must be a valid refname component.  The code now sanitizes the names
   given to worktrees, to make sure these refs are well-formed.

 * "git merge" learned "--quit" option that cleans up the in-progress
   merge while leaving the working tree and the index still in a mess.

 * "git format-patch" learns a configuration to set the default for
   its --notes=3D<ref> option.

 * The code to show args with potential typo that cannot be
   interpreted as a commit-ish has been improved.

 * "git clone --recurse-submodules" learned to set up the submodules
   to ignore commit object names recorded in the superproject gitlink
   and instead use the commits that happen to be at the tip of the
   remote-tracking branches from the get-go, by passing the new
   "--remote-submodules" option.

 * The pattern "git diff/grep" use to extract funcname and words
   boundary for Matlab has been extend to cover Octave, which is more
   or less equivalent.

 * "git help git" was hard to discover (well, at least for some
   people).

 * The pattern "git diff/grep" use to extract funcname and words
   boundary for Rust has been added.

 * "git status" can be told a non-standard default value for the
   "--[no-]ahead-behind" option with a new configuration variable
   status.aheadBehind.

 * "git fetch" and "git pull" reports when a fetch results in
   non-fast-forward updates to let the user notice unusual situation.
   The commands learned "--no-show-forced-updates" option to disable
   this safety feature.

 * Two new commands "git switch" and "git restore" are introduced to
   split "checking out a branch to work on advancing its history" and
   "checking out paths out of the index and/or a tree-ish to work on
   advancing the current history" out of the single "git checkout"
   command.

 * "git branch --list" learned to always output the detached HEAD as
   the first item (when the HEAD is detached, of course), regardless
   of the locale.

 * The conditional inclusion mechanism learned to base the choice on
   the branch the HEAD currently is on.

 * "git rev-list --objects" learned the "--no-object-names" option to
   squelch the path to the object that is used as a grouping hint for
   pack-objects.

 * A new tag.gpgSign configuration variable turns "git tag -a" into
   "git tag -s".

 * "git multi-pack-index" learned expire and repack subcommands.

 * "git blame" learned to "ignore" commits in the history, whose
   effects (as well as their presence) get ignored.

 * "git cherry-pick/revert" learned a new "--skip" action.

 * The tips of refs from the alternate object store can be used as
   starting point for reachability computation now.

 * Extra blank lines in "git status" output have been reduced.

 * The commits in a repository can be described by multiple
   commit-graph files now, which allows the commit-graph files to be
   updated incrementally.

 * "git range-diff" output has been tweaked for easier identification
   of which part of what file the patch shown is about.


Performance, Internal Implementation, Development Support etc.

 * Update supporting parts of "git rebase" to remove code that should
   no longer be used.

 * Developer support to emulate unsatisfied prerequisites in tests to
   ensure that the remainder of the tests still succeeds when tests
   with prerequisites are skipped.

 * "git update-server-info" learned not to rewrite the file with the
   same contents.

 * The way of specifying the path to find dynamic libraries at runtime
   has been simplified.  The old default to pass -R/path/to/dir has been
   replaced with the new default to pass -Wl,-rpath,/path/to/dir,
   which is the more recent GCC uses.  Those who need to build with an
   old GCC can still use "CC_LD_DYNPATH=3D-R"

 * Prepare use of reachability index in topological walker that works
   on a range (A..B).

 * A new tutorial targeting specifically aspiring git-core
   developers has been added.

 * Auto-detect how to tell HP-UX aCC where to use dynamically linked
   libraries from at runtime.

 * "git mergetool" and its tests now spawn fewer subprocesses.

 * Dev support update to help tracing out tests.

 * Support to build with MSVC has been updated.

 * "git fetch" that grabs from a group of remotes learned to run the
   auto-gc only once at the very end.

 * A handful of Windows build patches have been upstreamed.

 * The code to read state files used by the sequencer machinery for
   "git status" has been made more robust against a corrupt or stale
   state files.

 * "git for-each-ref" with multiple patterns have been optimized.

 * The tree-walk API learned to pass an in-core repository
   instance throughout more codepaths.

 * When one step in multi step cherry-pick or revert is reset or
   committed, the command line prompt script failed to notice the
   current status, which has been improved.

 * Many GIT_TEST_* environment variables control various aspects of
   how our tests are run, but a few followed "non-empty is true, empty
   or unset is false" while others followed the usual "there are a few
   ways to spell true, like yes, on, etc., and also ways to spell
   false, like no, off, etc." convention.

 * Adjust the dir-iterator API and apply it to the local clone
   optimization codepath.

 * We have been trying out a few language features outside c89; the
   coding guidelines document did not talk about them and instead had
   a blanket ban against them.

 * A test helper has been introduced to optimize preparation of test
   repositories with many simple commits, and a handful of test
   scripts have been updated to use it.


Fixes since v2.22
-----------------

 * A relative pathname given to "git init --template=3D<path> <repo>"
   ought to be relative to the directory "git init" gets invoked in,
   but it instead was made relative to the repository, which has been
   corrected.

 * "git worktree add" used to fail when another worktree connected to
   the same repository was corrupt, which has been corrected.

 * The ownership rule for the file descriptor to fast-import remote
   backend was mixed up, leading to an unrelated file descriptor getting
   closed, which has been fixed.

 * A "merge -c" instruction during "git rebase --rebase-merges" should
   give the user a chance to edit the log message, even when there is
   otherwise no need to create a new merge and replace the existing
   one (i.e. fast-forward instead), but did not.  Which has been
   corrected.

 * Code cleanup and futureproof.

 * More parameter validation.

 * "git update-server-info" used to leave stale packfiles in its
   output, which has been corrected.

 * The server side support for "git fetch" used to show incorrect
   value for the HEAD symbolic ref when the namespace feature is in
   use, which has been corrected.

 * "git am -i --resolved" segfaulted after trying to see a commit as
   if it were a tree, which has been corrected.

 * "git bundle verify" needs to see if prerequisite objects exist in
   the receiving repository, but the command did not check if we are
   in a repository upfront, which has been corrected.

 * "git merge --squash" is designed to update the working tree and the
   index without creating the commit, and this cannot be countermanded
   by adding the "--commit" option; the command now refuses to work
   when both options are given.

 * The data collected by fsmonitor was not properly written back to
   the on-disk index file, breaking t7519 tests occasionally, which
   has been corrected.

 * Update to Unicode 12.1 width table.

 * The command line to invoke a "git cat-file" command from inside
   "git p4" was not properly quoted to protect a caret and running a
   broken command on Windows, which has been corrected.

 * "git request-pull" learned to warn when the ref we ask them to pull
   from in the local repository and in the published repository are
   different.

 * When creating a partial clone, the object filtering criteria is
   recorded for the origin of the clone, but this incorrectly used a
   hardcoded name "origin" to name that remote; it has been corrected
   to honor the "--origin <name>" option.

 * "git fetch" into a lazy clone forgot to fetch base objects that are
   necessary to complete delta in a thin packfile, which has been
   corrected.

 * The filter_data used in the list-objects-filter (which manages a
   lazily sparse clone repository) did not use the dynamic array API
   correctly---'nr' is supposed to point at one past the last element
   of the array in use.  This has been corrected.

 * The description about slashes in gitignore patterns (used to
   indicate things like "anchored to this level only" and "only
   matches directories") has been revamped.

 * The URL decoding code has been updated to avoid going past the end
   of the string while parsing %-<hex>-<hex> sequence.

 * The list of for-each like macros used by clang-format has been
   updated.

 * "git branch --list" learned to show branches that are checked out
   in other worktrees connected to the same repository prefixed with
   '+', similar to the way the currently checked out branch is shown
   with '*' in front.
   (merge 6e9381469e nb/branch-show-other-worktrees-head later to maint).

 * Code restructuring during 2.20 period broke fetching tags via
   "import" based transports.

 * The commit-graph file is now part of the "files that the runtime
   may keep open file descriptors on, all of which would need to be
   closed when done with the object store", and the file descriptor to
   an existing commit-graph file now is closed before "gc" finalizes a
   new instance to replace it.

 * "git checkout -p" needs to selectively apply a patch in reverse,
   which did not work well.

 * Code clean-up to avoid signed integer wraparounds during binary search=
.

 * "git interpret-trailers" always treated '#' as the comment
   character, regardless of core.commentChar setting, which has been
   corrected.

 * "git stash show 23" used to work, but no more after getting
   rewritten in C; this regression has been corrected.

 * "git rebase --abort" used to leave refs/rewritten/ when concluding
   "git rebase -r", which has been corrected.

 * An incorrect list of options was cached after command line
   completion failed (e.g. trying to complete a command that requires
   a repository outside one), which has been corrected.

 * The code to parse scaled numbers out of configuration files has
   been made more robust and also easier to follow.

 * The codepath to compute delta islands used to spew progress output
   without giving the callers any way to squelch it, which has been
   fixed.

 * Protocol capabilities that go over wire should never be translated,
   but it was incorrectly marked for translation, which has been
   corrected.  The output of protocol capabilities for debugging has
   been tweaked a bit.

 * Use "Erase in Line" CSI sequence that is already used in the editor
   support to clear cruft in the progress output.

 * "git submodule foreach" did not protect command line options passed
   to the command to be run in each submodule correctly, when the
   "--recursive" option was in use.

 * The configuration variable rebase.rescheduleFailedExec should be
   effective only while running an interactive rebase and should not
   affect anything when running a non-interactive one, which was not
   the case.  This has been corrected.

 * The "git clone" documentation refers to command line options in its
   description in the short form; they have been replaced with long
   forms to make them more recognisable.

 * Generation of pack bitmaps are now disabled when .keep files exist,
   as these are mutually exclusive features.
   (merge 7328482253 ew/repack-with-bitmaps-by-default later to maint).

 * "git rm" to resolve a conflicted path leaked an internal message
   "needs merge" before actually removing the path, which was
   confusing.  This has been corrected.

 * "git stash --keep-index" did not work correctly on paths that have
   been removed, which has been fixed.
   (merge b932f6a5e8 tg/stash-keep-index-with-removed-paths later to main=
t).

 * Window 7 update ;-)

 * A codepath that reads from GPG for signed object verification read
   past the end of allocated buffer, which has been fixed.

 * "git clean" silently skipped a path when it cannot lstat() it; now
   it gives a warning.

 * "git push --atomic" that goes over the transport-helper (namely,
   the smart http transport) failed to prevent refs to be pushed when
   it can locally tell that one of the ref update will fail without
   having to consult the other end, which has been corrected.

 * The internal diff machinery can be made to read out of bounds while
   looking for --function-context line in a corner case, which has been
   corrected.
   (merge b777f3fd61 jk/xdiff-clamp-funcname-context-index later to maint=
).

 * Other code cleanup, docfix, build fix, etc.
   (merge fbec05c210 cc/test-oidmap later to maint).
   (merge 7a06fb038c jk/no-system-includes-in-dot-c later to maint).
   (merge 81ed2b405c cb/xdiff-no-system-includes-in-dot-c later to maint)=
.
   (merge d61e6ce1dd sg/fsck-config-in-doc later to maint).

----------------------------------------------------------------

Changes since v2.22.0 are as follows:

Ariadne Conill (3):
      log: add warning for unspecified log.mailmap setting
      documentation: mention --no-use-mailmap and log.mailmap false setti=
ng
      tests: defang pager tests by explicitly disabling the log.mailmap w=
arning

Barret Rhoden (8):
      fsck: rename and touch up init_skiplist()
      Move oidset_parse_file() to oidset.c
      blame: use a helper function in blame_chunk()
      blame: add the ability to ignore commits and their changes
      blame: add config options for the output of ignored or unblamable l=
ines
      blame: optionally track line fingerprints during fill_blame_origin(=
)
      blame: use the fingerprint heuristic to match ignored lines
      blame: add a test to cover blame_coalesce()

Beat Bolli (2):
      unicode: update the width tables to Unicode 12.1
      grep: print the pcre2_jit_on value

Ben Avison (1):
      clone: add `--remote-submodules` flag

Boxuan Li (2):
      userdiff: add Octave
      userdiff: fix grammar and style issues

Carlo Marcelo Arenas Bel=C3=B3n (6):
      fsmonitor: avoid signed integer overflow / infinite loop
      wrapper: avoid undefined behaviour in macOS
      trace2: correct typo in technical documentation
      xdiff: drop system includes in xutils.c
      xdiff: remove duplicate headers from xhistogram.c
      xdiff: remove duplicate headers from xpatience.c

Cesar Eduardo Barros (1):
      mingw: embed a manifest to trick UAC into Doing The Right Thing

Chris Mayo (1):
      send-email: update documentation of required Perl modules

Christian Couder (7):
      t/helper: add test-oidmap.c
      t: add t0016-oidmap.sh
      oidmap: use sha1hash() instead of static hash() function
      test-hashmap: remove 'hash' command
      doc: improve usage string in MyFirstContribution
      test-oidmap: remove 'add' subcommand
      t0016: add 'remove' subcommand test

Daniel Ferreira (1):
      dir-iterator: add tests for dir-iterator API

Denton Liu (5):
      git-format-patch.txt: document --no-notes option
      format-patch: teach format.notes config option
      config: learn the "onbranch:" includeIf condition
      config/alias.txt: change " and ' to `
      config/alias.txt: document alias accepting non-command first word

Derrick Stolee (50):
      commit-graph: fix the_repository reference
      revision: use generation for A..B --topo-order queries
      revision: keep topo-walk free of unintersting commits
      sha1-file: split OBJECT_INFO_FOR_PREFETCH
      repack: refactor pack deletion for future use
      Docs: rearrange subcommands for multi-pack-index
      multi-pack-index: prepare for 'expire' subcommand
      midx: simplify computation of pack name lengths
      midx: refactor permutation logic and pack sorting
      multi-pack-index: implement 'expire' subcommand
      multi-pack-index: prepare 'repack' subcommand
      midx: implement midx_repack()
      multi-pack-index: test expire while adding packs
      midx: add test that 'expire' respects .keep files
      t5319-multi-pack-index.sh: test batch size zero
      commit-graph: return with errors during write
      commit-graph: collapse parameters into flags
      commit-graph: remove Future Work section
      commit-graph: create write_commit_graph_context
      commit-graph: extract fill_oids_from_packs()
      commit-graph: extract fill_oids_from_commit_hex()
      commit-graph: extract fill_oids_from_all_packs()
      commit-graph: extract count_distinct_commits()
      commit-graph: extract copy_oids_to_commits()
      commit-graph: extract write_commit_graph_file()
      commit-graph: use raw_object_store when closing
      packfile: close commit-graph in close_all_packs
      packfile: rename close_all_packs to close_object_store
      commit-graph: document commit-graph chains
      commit-graph: prepare for commit-graph chains
      commit-graph: rename commit_compare to oid_compare
      commit-graph: load commit-graph chains
      commit-graph: add base graphs chunk
      commit-graph: rearrange chunk count logic
      commit-graph: write commit-graph chains
      commit-graph: add --split option to builtin
      commit-graph: merge commit-graph chains
      commit-graph: allow cross-alternate chains
      commit-graph: expire commit-graph files
      commit-graph: create options for split files
      commit-graph: verify chains with --shallow mode
      commit-graph: clean up chains after flattened write
      commit-graph: test octopus merges with --split
      commit-graph: test --split across alternate without --split
      commit-graph: normalize commit-graph filenames
      commit-graph: test verify across alternates
      fetch: add --[no-]show-forced-updates argument
      fetch: warn about forced updates in branch listing
      pull: add --[no-]show-forced-updates passthrough
      t5319: use 'test-tool path-utils' instead of 'ls -l'

Dimitriy Ryazantcev (1):
      l10n: localizable upload progress messages

Doug Ilijev (1):
      README: fix rendering of text in angle brackets

Dr. Adam Nielsen (1):
      gitignore.txt: make slash-rules more readable

Edmundo Carmona Antoranz (1):
      builtin/merge.c - cleanup of code in for-cycle that tests strategie=
s

Elijah Newren (5):
      t9350: fix encoding test to actually test reencoding
      fast-import: support 'encoding' commit header
      fast-export: avoid stripping encoding header if we cannot reencode
      fast-export: differentiate between explicitly UTF-8 and implicitly =
UTF-8
      fast-export: do automatic reencoding of commit messages only if req=
uested

Emily Shaffer (7):
      documentation: add tutorial for first contribution
      documentation: add anchors to MyFirstContribution
      grep: fail if call could output and name is null
      doc: hint about GIT_DEBUGGER in CodingGuidelines
      doc: add some nit fixes to MyFirstContribution
      rev-list: teach --no-object-names to enable piping
      transport-helper: enforce atomic in push_refs_with_push

Eric Wong (3):
      update-server-info: avoid needless overwrites
      server-info: do not list unlinked packs
      repack: disable bitmaps-by-default if .keep files exist

Felipe Contreras (5):
      t5801 (remote-helpers): cleanup refspec stuff
      t5801 (remote-helpers): add test to fetch tags
      fetch: trivial cleanup
      fetch: make the code more understandable
      fetch: fix regression with transport helpers

Jakub Wilk (1):
      doc: don't use git.kernel.org as example gitweb URL

Jeff Hostetler (13):
      cache-tree/blame: avoid reusing the DEBUG constant
      msvc: mark a variable as non-const
      msvc: do not re-declare the timespec struct
      msvc: define ftello()
      msvc: fix detect_msys_tty()
      msvc: update Makefile to allow for spaces in the compiler path
      status: add status.aheadbehind setting
      status: warn when a/b calculation takes too long
      status: ignore status.aheadbehind in porcelain formats
      msvc: support building Git using MS Visual C++
      msvc: add a compile-time flag to allow detailed heap debugging
      msvc: do not pretend to support all signals
      msvc: ignore .dll and incremental compile output

Jeff King (56):
      cmd_{read,write}_tree: rename "unused" variable that is used
      builtin: consistently pass cmd_* prefix to parse_options
      submodule: drop unused prefix parameter from some functions
      clone: drop dest parameter from copy_alternates()
      read-cache: drop unused parameter from threaded load
      wt-status: drop unused status parameter
      mktree: drop unused length parameter
      name-rev: drop unused parameters from is_better_name()
      pack-objects: drop unused rev_info parameters
      receive-pack: drop unused "commands" from prepare_shallow_update()
      remove_all_fetch_refspecs(): drop unused "remote" parameter
      rev-list: drop unused void pointer from finish_commit()
      show-branch: drop unused parameter from show_independent()
      verify-commit: simplify parameters to run_gpg_verify()
      help_unknown_ref(): duplicate collected refnames
      help_unknown_ref(): check for refname ambiguity
      upload-pack: strip namespace from symref data
      am: simplify prompt response handling
      am: read interactive input from stdin
      am: drop tty requirement for --interactive
      am: fix --interactive HEAD tree resolution
      interpret-trailers: load default config
      verify-tag: drop signal.h include
      wt-status.h: drop stdio.h include
      describe: fix accidental oid/hash type-punning
      upload-pack: rename a "sha1" variable to "oid"
      pack-bitmap-write: convert some helpers to use object_id
      pack-objects: convert packlist_find() to use object_id
      pack-objects: convert locate_object_entry_hash() to object_id
      object: convert lookup_unknown_object() to use object_id
      object: convert lookup_object() to use object_id
      object: convert internal hash_obj() to object_id
      object: convert create_object() to use object_id
      khash: drop broken oid_map typedef
      khash: rename kh_oid_t to kh_oid_set
      delta-islands: convert island_marks khash to use oids
      pack-bitmap: convert khash_sha1 maps into kh_oid_map
      khash: drop sha1-specific map types
      khash: rename oid helper functions
      hash.h: move object_id definition from cache.h
      hashmap: convert sha1hash() to oidhash()
      delta-islands: respect progress flag
      blame: drop some unused function parameters
      object-store.h: move for_each_alternate_ref() from transport.h
      check_everything_connected: assume alternate ref tips are valid
      test-lib: introduce test_commit_bulk
      t5310: increase the number of bitmapped commits
      t3311: use test_commit_bulk
      t5702: use test_commit_bulk
      t5703: use test_commit_bulk
      t6200: use test_commit_bulk
      xdiff: clamp function context indices in post-image
      t: sort output of hashmap iteration
      t7700: clean up .keep file in bitmap-writing test
      repack: silence warnings when auto-enabled bitmaps cannot be built
      repack: simplify handling of auto-bitmaps and .keep files

Johannes Schindelin (47):
      Drop unused git-rebase--am.sh
      t3400: stop referring to the scripted rebase
      .gitignore: there is no longer a built-in `git-rebase--interactive`
      sequencer: the `am` and `rebase--interactive` scripts are gone
      rebase: fold git-rebase--common into the -p backend
      bisect--helper: verify HEAD could be parsed before continuing
      fill_stat_cache_info(): prepare for an fsmonitor fix
      mark_fsmonitor_valid(): mark the index as changed if needed
      bundle verify: error out if called without an object database
      poll (mingw): allow compiling with GCC 8 and DEVELOPER=3D1
      kwset: allow building with GCC 8
      winansi: simplify loading the GetCurrentConsoleFontEx() function
      config: avoid calling `labs()` on too-large data type
      t3404: fix a typo
      mingw: fix a typo in the msysGit-specific section
      Mark .bat files as requiring CR/LF endings
      t0001 (mingw): do not expect a specific order of stdout/stderr
      obstack: fix compiler warning
      mingw: replace mingw_startup() hack
      msvc: fix dependencies of compat/msvc.c
      t0001: fix on case-insensitive filesystems
      msvc: avoid debug assertion windows in Debug Mode
      mingw: enable stack smashing protector
      mingw: get pw_name in UTF-8 format
      mingw: use Unicode functions explicitly
      rebase --am: ignore rebase.rescheduleFailedExec
      mingw: fix possible buffer overrun when calling `GetUserNameW()`
      diff: munmap() file contents before running external diff
      mingw: support spawning programs containing spaces in their names
      clean: show an error message when the path is too long
      rebase: fix white-space
      git: mark cmd_rebase as requiring a worktree
      Vcproj.pm: auto-generate GUIDs
      Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
      Vcproj.pm: urlencode '<' and '>' when generating VC projects
      contrib/buildsystems: ignore irrelevant files in Generators/
      contrib/buildsystems: error out on unknown option
      contrib/buildsystems: handle libiconv, too
      contrib/buildsystems: also handle -lexpat
      contrib/buildsystems: handle options starting with a slash
      contrib/buildsystems: add a backend for modern Visual Studio versio=
ns
      msvc: add a Makefile target to pre-generate the Visual Studio solut=
ion
      vcxproj: also link-or-copy builtins
      .gitignore: ignore Visual Studio's temporary/generated files
      bin-wrappers: append `.exe` to target paths if necessary
      git: avoid calling aliased builtins via their dashed form
      config: work around bug with includeif:onbranch and early config

Johannes Sixt (5):
      userdiff: two simplifications of patterns for rust
      t7610-mergetool: do not place pipelines headed by `yes` in subshell=
s
      t7610-mergetool: use test_cmp instead of test $(cat file) =3D $txt
      mergetool: dissect strings with shell variable magic instead of `ex=
pr`
      mergetool: use shell variable magic instead of `awk`

John Lin (1):
      status: remove the empty line after hints

Jonathan Tan (5):
      t5616: refactor packfile replacement
      index-pack: prefetch missing REF_DELTA bases
      t5616: use correct flag to check object is missing
      t5616: cover case of client having delta base
      t5551: test usage of chunked encoding explicitly

Josh Steadmon (1):
      trace2: correct trace2 field name documentation

Junio C Hamano (18):
      The first batch after 2.22
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      transport-helper: avoid var decl in for () loop control
      rm: resolving by removal is not a warning-worthy event
      CodingGuidelines: spell out post-C89 rules
      The sixth batch
      The seventh batch
      Flush fixes up to the third batch post 2.22.0
      Merge fixes made on the 'master' front
      Git 2.23-rc0
      test-dir-iterator: do not assume errno values
      A few more last-minute fixes
      log: flip the --mailmap default unconditionally
      log: really flip the --mailmap default
      Git 2.23-rc1

Karsten Blees (2):
      gettext: always use UTF-8 on native Windows
      mingw: initialize HOME on startup

Marc-Andr=C3=A9 Lureau (1):
      userdiff: add built-in pattern for rust

Martin =C3=85gren (3):
      ref-filter: fix memory leak in `free_array_item()`
      RelNotes/2.21.1: typofix
      RelNotes/2.23.0: fix a few typos and other minor issues

Matheus Tavares (8):
      clone: better handle symlinked files at .git/objects/
      dir-iterator: use warning_errno when possible
      dir-iterator: refactor state machine model
      dir-iterator: add flags parameter to dir_iterator_begin
      clone: copy hidden paths at local clone
      clone: extract function from copy_or_link_directory
      clone: use dir-iterator to avoid explicit dir traversal
      clone: replace strcmp by fspathcmp

Matthew DeVore (5):
      list-objects-filter-options: error is localizeable
      list-objects-filter: correct usage of ALLOC_GROW
      url: do not read past end of buffer
      url: do not allow %00 to represent NUL in URLs
      ref-filter: sort detached HEAD lines firstly

Mazo, Andrey (8):
      git-p4: detect/prevent infinite loop in gitCommitByP4Change()
      git-p4: add failing test for "git-p4: match branches case insensiti=
vely if configured"
      git-p4: match branches case insensitively if configured
      git-p4: don't groom exclude path list on every commit
      git-p4: add failing test for "don't exclude other files with same p=
refix"
      git-p4: don't exclude other files with same prefix
      git-p4: add failing test for "git-p4: respect excluded paths when d=
etecting branches"
      git-p4: respect excluded paths when detecting branches

Michael Osipov (1):
      configure: Detect linking style for HP aCC on HP-UX

Michael Platings (2):
      blame: add a fingerprint heuristic to match ignored lines
      t8014: remove unnecessary braces

Miguel Ojeda (1):
      clang-format: use git grep to generate the ForEachMacros list

Mike Hommey (2):
      dup() the input fd for fast-import used for remote helpers
      Use xmmap_gently instead of xmmap in use_pack

Mike Mueller (1):
      p4 unshelve: fix "Not a valid object name HEAD0" on Windows

Morian Sonnet (1):
      submodule foreach: fix recursion of options

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (63):
      git-checkout.txt: spell out --no-option
      git-checkout.txt: fix one syntax line
      doc: document --overwrite-ignore
      git-checkout.txt: fix monospace typeset
      t: rename t2014-switch.sh to t2014-checkout-switch.sh
      checkout: advice how to get out of detached HEAD mode
      checkout: inform the user when removing branch state
      checkout: keep most #include sorted
      checkout: factor out some code in parse_branchname_arg()
      checkout: make "opts" in cmd_checkout() a pointer
      checkout: move 'confict_style' and 'dwim_..' to checkout_opts
      checkout: split options[] array in three pieces
      checkout: split part of it to new command 'switch'
      switch: better names for -b and -B
      switch: add --discard-changes
      switch: remove -l
      switch: stop accepting pathspec
      switch: reject "do nothing" case
      switch: only allow explicit detached HEAD
      switch: add short option for --detach
      switch: implicit dwim, use --no-guess to disable it
      switch: no worktree status unless real branch switch happens
      switch: reject if some operation is in progress
      switch: make --orphan switch to an empty tree
      t: add tests for switch
      completion: support switch
      doc: promote "git switch"
      checkout: split part of it to new command 'restore'
      restore: take tree-ish from --source option instead
      restore: make pathspec mandatory
      restore: disable overlay mode by default
      checkout: factor out worktree checkout code
      restore: add --worktree and --staged
      restore: reject invalid combinations with --staged
      restore: default to --source=3DHEAD when only --staged is specified
      restore: replace --force with --ignore-unmerged
      restore: support --patch
      t: add tests for restore
      completion: support restore
      user-manual.txt: prefer 'merge --abort' over 'reset --hard'
      doc: promote "git restore"
      help: move git-diff and git-reset to different groups
      Declare both git-switch and git-restore experimental
      merge: remove drop_save() in favor of remove_merge_branch_state()
      init: make --template path relative to $CWD
      worktree add: sanitize worktree names
      worktree add: be tolerant of corrupt worktrees
      merge: add --quit
      completion: do not cache if --git-completion-helper fails
      fetch: only run 'gc' once when fetching multiple remotes
      t2027: use test_must_be_empty
      switch: allow to switch in the middle of bisect
      completion: disable dwim on "git switch -d"
      fetch-pack: move capability names out of i18n strings
      fetch-pack: print all relevant supported capabilities with -v -v
      fetch-pack: print server version at the top in -v -v
      sha1-file.c: remove the_repo from read_object_with_reference()
      tree-walk.c: remove the_repo from fill_tree_descriptor()
      tree-walk.c: remove the_repo from get_tree_entry()
      tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
      match-trees.c: remove the_repo from shift_tree*()
      Use the right 'struct repository' instead of the_repository
      t7814: do not generate same commits in different repos

Nickolai Belakovski (3):
      ref-filter: add worktreepath atom
      branch: update output to include worktree info
      branch: add worktree info on verbose output

Paolo Bonzini (2):
      request-pull: quote regex metacharacters in local ref
      request-pull: warn if the remote object is not the same as the loca=
l one

Philip Oakley (15):
      git.c: show usage for accessing the git(1) help page
      Doc: git.txt: remove backticks from link and add git-scm.com/docs
      doc branch: provide examples for listing remote tracking branches
      msvc: include sigset_t definition
      msvc: define O_ACCMODE
      msvc: add pragmas for common warnings
      Vcproj.pm: list git.exe first to be startup project
      contrib/buildsystems: ignore invalidcontinue.obj
      contrib/buildsystems: fix misleading error message
      contrib/buildsystems: handle quoted spaces in filenames
      contrib/buildsystems: ignore gettext stuff
      contrib/buildsystems: redirect errors of the dry run into a log fil=
e
      contrib/buildsystems: optionally capture the dry-run in a file
      contrib/buildsystems: handle the curl library option
      .gitignore: touch up the entries regarding Visual Studio

Phillip Wood (12):
      rebase: fix a memory leak
      rebase: warn if state directory cannot be removed
      sequencer: return errors from sequencer_remove_state()
      rebase --abort/--quit: cleanup refs/rewritten
      rebase -r: always reword merge -c
      add -p: fix checkout -p with pathological context
      show --continue/skip etc. consistently in synopsis
      sequencer: always allow tab after command name
      sequencer: factor out todo command name parsing
      status: do not report errors in sequencer/todo
      git-prompt: improve cherry-pick/revert detection
      t3420: remove progress lines before comparing output

Quentin Nerden (2):
      docs: git-clone: refer to long form of options
      docs: git-clone: list short form of options first

Ramsay Jones (1):
      env--helper: mark a file-local symbol as static

Ren=C3=A9 Scharfe (6):
      cleanup: fix possible overflow errors in binary search, part 2
      coccinelle: use COPY_ARRAY for copying arrays
      use COPY_ARRAY for copying arrays
      config: use unsigned_mult_overflows to check for overflows
      config: don't multiply in parse_unit_factor()
      config: simplify parsing of unit factors

Robert Morgan (1):
      gpg(docs): use correct --verify syntax

Rohit Ashiwal (5):
      sequencer: add advice for revert
      sequencer: rename reset_for_rollback to reset_merge
      sequencer: use argv_array in reset_merge
      cherry-pick/revert: add --skip option
      cherry-pick/revert: advise using --skip

SZEDER G=C3=A1bor (12):
      t3404: modernize here doc style
      t3404: make the 'rebase.missingCommitsCheck=3Dignore' test more foc=
used
      pager: add a helper function to clear the last line in the terminal
      t5551: use 'test_i18ngrep' to check translated output
      rebase: fix garbled progress display with '-x'
      progress: use term_clear_line()
      Document that 'git -C ""' works and doesn't change directory
      ci: don't update Homebrew
      ci: disable Homebrew's auto cleanup
      ci/lib.sh: update a comment about installed P4 and Git-LFS versions
      travis-ci: build with GCC 4.8 as well
      Documentation/git-fsck.txt: include fsck.* config variables

Simon Williams (1):
      git-p4: allow unshelving of branched files

Stephen Boyd (2):
      format-patch: inform user that patch-id generation is unstable
      format-patch: make --base patch-id output stable

Steven Roberts (1):
      gpg-interface: do not scan past the end of buffer

Taylor Blau (1):
      ref-filter.c: find disjoint pattern prefixes

Thomas Gummerer (16):
      stash: fix show referencing stash index
      apply: replace marc.info link with public-inbox
      apply: only pass required data to skip_tree_prefix
      apply: only pass required data to git_header_name
      apply: only pass required data to check_header_line
      apply: only pass required data to find_name_*
      apply: only pass required data to gitdiff_* functions
      apply: make parse_git_diff_header public
      range-diff: fix function parameter indentation
      range-diff: split lines manually
      range-diff: don't remove funcname from inner diff
      range-diff: suppress line count in outer diff
      range-diff: add section header instead of diff header
      range-diff: add filename to inner diff
      range-diff: add headers to the outer hunk header
      stash: fix handling removed files with --keep-index

Tigran Mkrtchyan (1):
      tag: add tag.gpgSign config option to force all tags be GPG-signed

Varun Naik (1):
      read-cache.c: do not die if mmap fails

Vishal Verma (1):
      merge: refuse --commit with --squash

Xin Li (1):
      clone: respect user supplied origin name when setting up partial cl=
one

brian m. carlson (10):
      t: add helper to convert object IDs to paths
      t1410: make hash size independent
      t1450: make hash size independent
      t5000: make hash independent
      t6030: make test work with SHA-256
      t0027: make hash size independent
      t0090: make test pass with SHA-256
      t1007: remove SHA1 prerequisites
      t1710: make hash independent
      t2203: avoid hard-coded object ID values

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (21):
      send-email: move the read_config() function above getopts
      send-email: rename the @bcclist variable for consistency
      send-email: do defaults -> config -> getopt in that order
      tests: add a special setup where prerequisites fail
      Makefile: remove the NO_R_TO_GCC_LINKER flag
      send-email: remove cargo-culted multi-patch pattern in tests
      send-email: fix broken transferEncoding tests
      send-email: document --no-[to|cc|bcc]
      hash-object doc: stop mentioning git-cvsimport
      send-email: fix regression in sendemail.identity parsing
      Revert "test-lib: whitelist GIT_TR2_* in the environment"
      config tests: simplify include cycle test
      env--helper: new undocumented builtin wrapping git_env_*()
      config.c: refactor die_bad_number() to not call gettext() early
      t6040 test: stop using global "script" variable
      tests: make GIT_TEST_GETTEXT_POISON a boolean
      tests README: re-flow a previously changed paragraph
      tests: replace test_tristate with "git env--helper"
      tests: make GIT_TEST_FAIL_PREREQS a boolean
      tests: mark two failing tests under FAIL_PREREQS
      clone: test for our behavior on odd objects/* content

