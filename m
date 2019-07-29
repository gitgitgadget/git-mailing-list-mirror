Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75BE1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfG2Vty (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 17:49:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62729 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfG2Vty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 17:49:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9EF415D239;
        Mon, 29 Jul 2019 17:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JbAv9dqsoQB7PlJxiRU2NGimW
        TM=; b=i8qtkq6mPaH3X+8FHZmHy6PzS9lgbIfTdOlWInw6/+iw1Dd1/RqJ8BltE
        HfXWAYRLXVDskWKixDvmHwzVuKk5pbKAAVJ1769oGY1XV7YMU8UgNRBir56lXP0Q
        lf+IZutg6Bp2Zp604Q9NXz7EDkAEbh5Dx0lEDjt+yo8fARTIMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=QGIOMqcejWU85/u53So
        04i3j1pflBMyrxjZw5zEVD+gKh7CcuyEOvHKt4/1kQr8ShLqwnHuRtuGOBs5hzNS
        NAYasbDCqCGa6eGPJO5ok2cnBx6r1HkUXWmelPfJjmN8m13UMN23cd1Z1OvS8I7x
        1BQndPsW9clVX4qhfKRXd6eU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0E2915D238;
        Mon, 29 Jul 2019 17:49:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0097D15D237;
        Mon, 29 Jul 2019 17:49:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.23.0-rc0
Date:   Mon, 29 Jul 2019 14:49:42 -0700
Message-ID: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6901268-B24A-11E9-93EF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early preview release Git v2.23.0-rc0 is now available for
testing at the usual places.  It is comprised of 420 non-merge
commits since v2.22.0, contributed by 62 people, 23 of which are
new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.23.0-rc0' tag and the 'master' branch that the tag points at:

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

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Beat Bolli, Boxuan Li, Carlo Ma=
rcelo
  Arenas Bel=C3=B3n, Cesar Eduardo Barros, Chris Mayo, Christian
  Couder, Denton Liu, Derrick Stolee, Dimitriy Ryazantcev,
  Edmundo Carmona Antoranz, Elijah Newren, Emily Shaffer, Eric
  Wong, Felipe Contreras, Jeff Hostetler, Jeff King, Johannes
  Schindelin, Johannes Sixt, Jonathan Tan, Josh Steadmon, Junio
  C Hamano, Karsten Blees, Marc-Andr=C3=A9 Lureau, Martin =C3=85gren,
  Matthew DeVore, Mike Hommey, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy,=
 Nickolai
  Belakovski, Paolo Bonzini, Philip Oakley, Phillip Wood, Ramsay
  Jones, Ren=C3=A9 Scharfe, Rohit Ashiwal, Stephen Boyd, SZEDER G=C3=A1bo=
r,
  Taylor Blau, and Thomas Gummerer.

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
   The commands learned "--no-shown-forced-updates" option to disable
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

 * "git rev-list --objects" learned with "--no-object-names" option to
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

 * The "git log" command learns to issue a warning when log.mailmap
   configuration is not set and --[no-]mailmap option is not used, to
   prepare users for future versions of Git that uses the mailmap by
   default.

 * "git range-diff" output has been tweaked for easier identification
   of which part of what file the patch shown is about.


Performance, Internal Implementation, Development Support etc.

 * Update supporting parts of "git rebase" to remove code that should
   no longer be used.

 * Developer support to emulate unsatisfied prerequisites in tests to
   ensure that the remainer of the tests still succeeds when tests
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

 * A new tutorial targetting specifically aspiring git-core
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
   (merge cc0c42975a jc/post-c89-rules-doc later to maint).

 * A test helper has been introduced to optimize preparation of test
   repositories with many simple commits, and a handful of test
   scripts have been updated to use it.


Fixes since v2.22
-----------------

 * A relative pathname given to "git init --template=3D<path> <repo>"
   ought to be relative to the directory "git init" gets invoked in,
   but it instead was made relative to the repository, which has been
   corrected.
   (merge e1df7fe43f nd/init-relative-template-fix later to maint).

 * "git worktree add" used to fail when another worktree connected to
   the same repository was corrupt, which has been corrected.
   (merge 105df73e71 nd/corrupt-worktrees later to maint).

 * The ownership rule for the file descriptor to fast-import remote
   backend was mixed up, leading to unrelated file descriptor getting
   closed, which has been fixed.
   (merge 3203566a71 mh/import-transport-fd-fix later to maint).

 * A "merge -c" instruction during "git rebase --rebase-merges" should
   give the user a chance to edit the log message, even when there is
   otherwise no need to create a new merge and replace the existing
   one (i.e. fast-forward instead), but did not.  Which has been
   corrected.

 * Code cleanup and futureproof.
   (merge 31f5256c82 ds/object-info-for-prefetch-fix later to maint).

 * More parameter validation.
   (merge de99eb0c24 es/grep-require-name-when-needed later to maint).

 * "git update-server-info" used to leave stale packfiles in its
   output, which has been corrected.
   (merge e941c48d49 ew/server-info-remove-crufts later to maint).

 * The server side support for "git fetch" used to show incorrect
   value for the HEAD symbolic ref when the namespace feature is in
   use, which has been corrected.
   (merge 533e088250 jk/HEAD-symref-in-xfer-namespaces later to maint).

 * "git am -i --resolved" segfaulted after trying to see a commit as
   if it were a tree, which has been corrected.
   (merge 7663e438c5 jk/am-i-resolved-fix later to maint).

 * "git bundle verify" needs to see if prerequisite objects exist in
   the receiving repository, but the command did not check if we are
   in a repository upfront, which has been corrected.
   (merge 3bbbe467f2 js/bundle-verify-require-object-store later to maint=
).

 * "git merge --squash" is designed to update the working tree and the
   index without creating the commit, and this cannot be countermanded
   by adding the "--commit" option; the command now refuses to work
   when both options are given.
   (merge 1d14d0c994 vv/merge-squash-with-explicit-commit later to maint)=
.

 * The data collected by fsmonitor was not properly written back to
   the on-disk index file, breaking t7519 tests occasionally, which
   has been corrected.
   (merge b5a8169752 js/fsmonitor-unflake later to maint).

 * Update to Unicode 12.1 width table.
   (merge 5817f9caa3 bb/unicode-12.1-reiwa later to maint).

 * The command line to invoke a "git cat-file" command from inside
   "git p4" was not properly quoted to protect a caret and running a
   broken command on Windows, which has been corrected.
   (merge c3f2358de3 mm/p4-unshelve-windows-fix later to maint).

 * "git request-pull" learned to warn when the ref we ask them to pull
   from in the local repository and in the published repository are
   different.
   (merge 0454220d66 pb/request-pull-verify-remote-ref later to maint).

 * When creating a partial clone, the object filtering criteria is
   recorded for the origin of the clone, but this incorrectly used a
   hardcoded name "origin" to name that remote; it has been corrected
   to honor the "--origin <name>" option.
   (merge 1c4a9f9114 xl/record-partial-clone-origin later to maint).

 * "git fetch" into a lazy clone forgot to fetch base objects that are
   necessary to complete delta in a thin packfile, which has been
   corrected.
   (merge 810e19322d jt/partial-clone-missing-ref-delta-base later to mai=
nt).

 * The filter_data used in the list-objects-filter (which manages a
   lazily sparse clone repository) did not use the dynamic array API
   correctly---'nr' is supposed to point at one past the last element
   of the array in use.  This has been corrected.
   (merge 7140600e2e md/list-objects-filter-memfix later to maint).

 * The description about slashes in gitignore patterns (used to
   indicate things like "anchored to this level only" and "only
   matches directories") has been revamped.
   (merge 1a58bad014 an/ignore-doc-update later to maint).

 * The URL decoding code has been updated to avoid going past the end
   of the string while parsing %-<hex>-<hex> sequence.
   (merge d37dc239a4 md/url-parse-harden later to maint).

 * The list of for-each like macros used by clang-format has been
   updated.
   (merge fc7e03aace mo/clang-format-for-each-update later to maint).

 * "git branch --list" learned to show branches that are checked out
   in other worktrees connected to the same repository prefixed with
   '+', similar to the way the currently checked out branch is shown
   with '*' in front.
   (merge 6e9381469e nb/branch-show-other-worktrees-head later to maint).

 * Code restructuring during 2.20 period broke fetching tags via
   "import" based transports.
   (merge f80d922355 fc/fetch-with-import-fix later to maint).

 * The commit-graph file is now part of the "files that the runtime
   may keep open file descriptors on, all of which would need to be
   closed when done with the object store", and the file descriptor to
   an existing commit-graph file now is closed before "gc" finalizes a
   new instance to replace it.
   (merge 2d511cfc0b ds/close-object-store later to maint).

 * "git checkout -p" needs to selectively apply a patch in reverse,
   which did not work well.
   (merge 2bd69b9024 pw/add-p-recount later to maint).

 * Code clean-up to avoid signed integer wraparounds during binary search=
.
   (merge 568a05c5ec rs/avoid-overflow-in-midpoint-computation later to m=
aint).

 * "git interpret-trailers" always treated '#' as the comment
   character, regardless of core.commentChar setting, which has been
   corrected.
   (merge 29c83fc23f jk/trailers-use-config later to maint).

 * "git stash show 23" used to work, but no more after getting
   rewritten in C; this regression has been corrected.
   (merge 63b50c8ffe tg/stash-ref-by-index-fix later to maint).

 * "git rebase --abort" used to leave refs/rewritten/ when concluding
   "git rebase -r", which has been corrected.
   (merge d559f502c5 pw/rebase-abort-clean-rewritten later to maint).

 * An incorrect list of options was cached after command line
   completion failed (e.g. trying to complete a command that requires
   a repository outside one), which has been corrected.
   (merge 69702523af nd/completion-no-cache-failure later to maint).

 * The code to parse scaled numbers out of configuration files has
   been made more robust and also easier to follow.
   (merge 39c575c969 rs/config-unit-parsing later to maint).

 * The codepath to compute delta islands used to spew progress output
   without giving the callers any way to squelch it, which has been
   fixed.
   (merge bdbdf42f8a jk/delta-islands-progress-fix later to maint).

 * Protocol capabilities that go over wire should never be translated,
   but it was incorrectly marked for translation, which has been
   corrected.  The output of protocol capabilities for debugging has
   been tweaked a bit.

 * Use "Erase in Line" CSI sequence that is already used in the editor
   support to clear cruft in the progress output.
   (merge 5b12e3123b sg/rebase-progress later to maint).

 * "git submodule foreach" did not protect command line options passed
   to the command to be run in each submodule correctly, when the
   "--recursive" option was in use.
   (merge 30db18b148 ms/submodule-foreach-fix later to maint).

 * The configuration variable rebase.rescheduleFailedExec should be
   effective only while running an interactive rebase and should not
   affect anything when running an non-interactive one, which was not
   the case.  This has been corrected.
   (merge 906b63942a js/rebase-reschedule-applies-only-to-interactive lat=
er to maint).

 * The "git clone" documentation refers to command line options in its
   description in the short form; they have been replaced with long
   forms to make them more recognisable.
   (merge bfc8c84ed5 qn/clone-doc-use-long-form later to maint).

 * Generation of pack bitmaps are now disabled when .keep files exist,
   as these are mutually exclusive features.
   (merge 7328482253 ew/repack-with-bitmaps-by-default later to maint).

 * "git rm" to resolve a conflicted path leaked an internal message
   "needs merge" before actually removing the path, which was
   confusing.  This has been corrected.
   (merge b2b1f615ce jc/denoise-rm-to-resolve later to maint).

 * "git stash --keep-index" did not work correctly on paths that have
   been removed, which has been fixed.
   (merge b932f6a5e8 tg/stash-keep-index-with-removed-paths later to main=
t).

 * Window 7 update ;-)
   (merge eb7c786314 js/mingw-spawn-with-spaces-in-path later to maint).

 * A codepath that reads from GPG for signed object verification read
   past the end of allocated buffer, which has been fixed.
   (merge 64c45dc72e sr/gpg-interface-stop-at-the-end later to maint).

 * "git clean" silently skipped a path when it cannot lstat() it; now
   it gives a warning.
   (merge b09364c47a js/clean-report-too-long-a-path later to maint).

 * "git push --atomic" that goes over the transport-helper (namely,
   the smart http transport) failed to prevent refs to be pushed when
   it can locally tell that one of the ref update will fail without
   having to consult the other end, which has been corrected.
   (merge 2581ea3d31 es/local-atomic-push-failure-with-http later to main=
t).

 * The internal diff machinery can be made to read out of bounds while
   looking for --funcion-context line in a corner case, which has been
   corrected.
   (merge b777f3fd61 jk/xdiff-clamp-funcname-context-index later to maint=
).

 * Other code cleanup, docfix, build fix, etc.
   (merge f547101b26 es/git-debugger-doc later to maint).
   (merge 7877ac3d7b js/bisect-helper-check-get-oid-return-value later to=
 maint).
   (merge 0108f47eb3 sw/git-p4-unshelve-branched-files later to maint).
   (merge 9df8f734fd cm/send-email-document-req-modules later to maint).
   (merge afc3bf6eb1 ab/hash-object-doc later to maint).
   (merge 1fde99cfc7 po/doc-branch later to maint).
   (merge 459842e1c2 dl/config-alias-doc later to maint).
   (merge 5d137fc2c7 cb/fsmonitor-intfix later to maint).
   (merge 921d49be86 rs/copy-array later to maint).
   (merge cc8d872e69 js/t3404-typofix later to maint).
   (merge 729a9b558b cb/mkstemps-uint-type-fix later to maint).
   (merge 9dae4fe79f js/gcc-8-and-9 later to maint).
   (merge ed33bd8f30 js/t0001-case-insensitive later to maint).
   (merge dfa880e336 jw/gitweb-sample-update later to maint).
   (merge e532a90a9f sg/t5551-fetch-smart-error-is-translated later to ma=
int).
   (merge 8d45ad8c29 jt/t5551-test-chunked later to maint).
   (merge 1a64e07d23 sg/git-C-empty-doc later to maint).
   (merge 37a2e35395 sg/ci-brew-gcc-workaround later to maint).
   (merge 24df0d49c4 js/trace2-signo-typofix later to maint).
   (merge fbec05c210 cc/test-oidmap later to maint).
   (merge 7926cee904 di/readme-markup-fix later to maint).
   (merge 02638d1e11 vn/xmmap-gently later to maint).
   (merge f7bf24d4dd rm/gpg-program-doc-fix later to maint).
   (merge 3aef54e8b8 js/unmap-before-ext-diff later to maint).

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

Carlo Marcelo Arenas Bel=C3=B3n (3):
      fsmonitor: avoid signed integer overflow / infinite loop
      wrapper: avoid undefined behaviour in macOS
      trace2: correct typo in technical documentation

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

Jeff King (50):
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

Johannes Schindelin (32):
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

Junio C Hamano (13):
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

Karsten Blees (2):
      gettext: always use UTF-8 on native Windows
      mingw: initialize HOME on startup

Marc-Andr=C3=A9 Lureau (1):
      userdiff: add built-in pattern for rust

Martin =C3=85gren (1):
      ref-filter: fix memory leak in `free_array_item()`

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

Philip Oakley (6):
      git.c: show usage for accessing the git(1) help page
      Doc: git.txt: remove backticks from link and add git-scm.com/docs
      doc branch: provide examples for listing remote tracking branches
      msvc: include sigset_t definition
      msvc: define O_ACCMODE
      msvc: add pragmas for common warnings

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

SZEDER G=C3=A1bor (11):
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

