Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E034C11F66
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D9161449
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhF3W6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:58:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55626 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhF3W6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 18:58:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BF7FDD0ED;
        Wed, 30 Jun 2021 18:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=lhWBSJY62mTp1MnAomX/OVsB2
        VR2mShaR9NpfX+HbQk=; b=UF12hbDgpUz/W8v5c3d9PmeieGVRUaRkvIIb9A4zT
        ji9ZKyxYhWtPF8KW3P9455/5jrav3ObnjYTjd+tjTAC3p/IByI4o6IFsy4WgGHjW
        gjcp3em68mB6QtyasQXwxXHRyC7cO2lkCFfSZ/1zKek1MG56SRxslaLX5HIsfj9v
        3k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A0F8DD0EB;
        Wed, 30 Jun 2021 18:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB95FDD0EA;
        Wed, 30 Jun 2021 18:55:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2021, #07; Wed, 30)
X-master-at: 670b81a890388c60b7032a4f5b879f2ece8c4558
X-next-at: 670b81a890388c60b7032a4f5b879f2ece8c4558
Date:   Wed, 30 Jun 2021 15:55:33 -0700
Message-ID: <xmqq4kdft122.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 475A17AC-D9F6-11EB-A830-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '-' are only in 'seen' while commits prefixed with '+'
are in 'next'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.  Generally,
being in 'next' is a sign that a topic is stable enough to be used
and are candidate to be in a future release, while being in 'seen'
means nothing more than that the maintainer has found it interesting
for some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful")---do not read too much into a topic being in (or not in)
'seen'.

Some new topics have been merged to 'seen' and are listed in this
report but there may well be topics that I haven't got around to
pick them up.  Also, among those that are in 'seen', I haven't
summarized many of them in this rerpot (let alone decided what to do
with them).  Help and patience is greatly appreciated.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[New Topics]

* fw/complete-cmd-idx-fix (2021-06-19) 1 commit
 - completion: bash: fix late declaration of __git_cmd_idx

 Recent update to completion script (in contrib/) broke those who
 use the __git_complete helper to define completion to their custom
 command.

 Will merge to 'next'.


* jk/test-avoid-globmatch-with-skip-patterns (2021-06-17) 1 commit
 - test-lib: avoid accidental globbing in match_pattern_list()

 We broke "GIT_SKIP_TESTS=3Dt?000" to skip certain tests in recent
 update, which got fixed.

 Will merge to 'next'.


* jk/test-without-readlink-1 (2021-06-19) 1 commit
 - t: use portable wrapper for readlink(1)

 Some test scripts assumed that readlink(1) was universally
 installed and available, which is not the case.

 Will merge to 'next'.


* jx/sideband-cleanup (2021-06-17) 4 commits
 - test: refactor to use "get_abbrev_oid" to get abbrev oid
 - test: refactor to use "test_commit" to create commits
 - test: compare raw output, not mangle tabs and spaces
 - sideband: don't lose clear-to-eol at packet boundary

 The side-band demultiplexer that is used to display progress output
 from the remote end did not clear the line properly when the end of
 line hits at a packet boundary, which has been corrected.  Also
 comes with test clean-ups.

 Will merge to 'next'.


* ab/bundle-doc (2021-06-30) 3 commits
 - bundle doc: elaborate on rev<->ref restriction
 - bundle doc: split out open v.s. closed discussion from <rev-arg>
 - bundle doc: rewrite the "DESCRIPTION" section

 Doc update.


* ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
 - test-lib.sh: set COLUMNS=3D80 for --verbose repeatability

 Output from some of our tests were affected by the width of the
 terminal that they were run in, which has been corrected by
 exporting a fixed value in the COLUMNS environment.

 Will merge to 'next'.


* ab/pack-stdin-packs-fix (2021-06-28) 2 commits
 - pack-objects: fix segfault in --stdin-packs option
 - pack-objects tests: cover blindspots in stdin handling

 Input validation of "git pack-objects --stdin-packs" has been
 corrected.

 cf. <YND3h2l10PlnSNGJ@nand.local>


* ar/more-typofix (2021-06-28) 3 commits
 - git-worktree.txt: fix typo in example path
 - t: fix typos in test messages
 - blame: correct name of config option in docs

 Typofixes.

 Will merge to 'next'.


* bk/doc-commit-typofix (2021-06-28) 1 commit
 - Documentation: fix typo in the --patch option of the commit command


* dc/p4-binary-submit-fix (2021-06-28) 1 commit
 - git-p4: fix failed submit by skip non-text data files


* ds/commit-and-checkout-with-sparse-index (2021-06-28) 5 commits
 - checkout: stop expanding sparse indexes
 - sparse-index: recompute cache-tree
 - commit: integrate with sparse-index
 - p2000: compress repo names
 - p2000: add 'git checkout -' test and decrease depth
 (this branch uses ds/status-with-sparse-index.)


* en/merge-dir-rename-corner-case-fix (2021-06-30) 3 commits
 - merge-recursive: handle rename-to-self case
 - merge-ort: ensure we consult df_conflict and path_conflicts
 - t6423: test directory renames causing rename-to-self


* ew/many-alternate-optim (2021-06-29) 5 commits
 - oidtree: a crit-bit tree for odb_loose_cache
 - oidcpy_with_padding: constify `src' arg
 - make object_directory.loose_objects_subdir_seen a bitmap
 - avoid strlen via strbuf_addstr in link_alt_odb_entry
 - speed up alt_odb_usable() with many alternates


* jk/log-decorate-optim (2021-06-28) 6 commits
 - add_ref_decoration(): rename s/type/deco_type/
 - load_ref_decorations(): avoid parsing non-tag objects
 - object.h: add lookup_object_by_type() function
 - object.h: expand docstring for lookup_unknown_object()
 - log: avoid loading decorations for userformats that don't need it
 - pretty.h: update and expand docstring for userformat_find_requirements=
()


* js/ci-windows-update (2021-06-28) 6 commits
 - ci: accelerate the checkout
 - ci(vs-build): build with NO_GETTEXT
 - ci(windows): transfer also the Git-tracked files to the test jobs
 - ci: upgrade to using actions/{up,down}load-artifacts v2
 - ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
 - ci: use the new GitHub Action to download git-sdk-64-minimal


* js/config-mak-windows-pcre-fix (2021-06-28) 1 commit
 - config.mak.uname: PCRE1 cleanup


* js/gfw-system-config-loc-fix (2021-06-28) 3 commits
 - config: normalize the path of the system gitconfig
 - cmake(windows): set correct path to the system Git config
 - mingw: move Git for Windows' system config where users expect it


* jt/push-negotiation-fixes (2021-06-28) 3 commits
 - fetch: die on invalid --negotiation-tip hash
 - send-pack: fix push nego. when remote has refs
 - send-pack: fix push.negotiate with remote helper


* ks/submodule-cleanup (2021-06-28) 1 commit
 - submodule: remove unnecessary `prefix` based option logic


* rs/grep-parser-fix (2021-06-30) 1 commit
 - grep: report missing left operand of --and


* tb/midx-use-checksum (2021-06-28) 4 commits
 - midx: report checksum mismatches during 'verify'
 - midx: don't reuse corrupt MIDXs when writing
 - commit-graph: rewrite to use checksum_valid()
 - csum-file: introduce checksum_valid()


* ab/bundle-updates (2021-06-30) 3 commits
 - bundle: remove "ref_list" in favor of string-list.c API
 - bundle.c: use a temporary variable for OIDs and names
 - bundle cmd: stop leaking memory from parse_options_cmd_bundle()


* ab/fetch-negotiate-segv-fix (2021-06-30) 3 commits
 - fetch: fix segfault in --negotiate-only without --negotiation-tip=3D*
 - fetch: document the --negotiate-only option
 - send-pack.c: move "no refs in common" abort earlier


* ab/make-delete-on-error (2021-06-29) 1 commit
 - Makefile: add and use the ".DELETE_ON_ERROR" flag


* ab/make-tags-cleanup (2021-06-29) 5 commits
 - Makefile: normalize clobbering & xargs for tags targets
 - Makefile: don't use "FORCE" for tags targets
 - Makefile: fix "cscope" target to refer to cscope.out
 - Makefile: add QUIET_GEN to "cscope" target
 - Makefile: move ".PHONY: cscope" near its target


* ew/mmap-failures (2021-06-29) 1 commit
 - xmmap: inform Linux users of tuning knobs on ENOMEM

--------------------------------------------------
[Stalled]

* hn/reftable (2021-05-20) 28 commits
 . t1404: annotate test cases with REFFILES
 . t1401,t2011: parameterize HEAD.lock for REFTABLE
 . t1301: document what needs to be done for REFTABLE
 . Add "test-tool dump-reftable" command.
 . git-prompt: prepare for reftable refs backend
 . Reftable support for git-core
 . reftable: add dump utility
 . reftable: implement stack, a mutable database of reftable files.
 . reftable: implement refname validation
 . reftable: add merged table view
 . reftable: add a heap-based priority queue for reftable records
 . reftable: reftable file level tests
 . reftable: read reftable files
 . reftable: generic interface to tables
 . reftable: write reftable files
 . reftable: a generic binary tree implementation
 . reftable: reading/writing blocks
 . Provide zlib's uncompress2 from compat/zlib-compat.c
 . reftable: (de)serialization for the polymorphic record type.
 . reftable: add blocksource, an abstraction for random access reads
 . reftable: utility functions
 . reftable: add error related functionality
 . reftable: add LICENSE
 . init-db: set the_repository->hash_algo early on
 . hash.h: provide constants for the hash IDs
 . refs/debug: trace into reflog expiry too
 . refs: document reflog_expire_fn's flag argument
 . refs: make explicit that ref_iterator_peel returns boolean

 The "reftable" backend for the refs API.

 Waiting for reviews.
 Seems to break tests when merged to 'seen'.


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Waiting for reviews.

--------------------------------------------------
[Cooking]

* tb/multi-pack-bitmaps (2021-06-28) 24 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: infer preferred pack when not given one
 - midx: respect 'core.multiPackIndex' when writing
 - midx: clear auxiliary .rev after replacing the MIDX
 - midx: make a number of functions non-static
 - Documentation: describe MIDX-based bitmaps
 - Documentation: build 'technical/bitmap-format' by default
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.


* ds/status-with-sparse-index (2021-06-28) 16 commits
 - fsmonitor: integrate with sparse index
 - wt-status: expand added sparse directory entries
 - status: use sparse-index throughout
 - status: skip sparse-checkout percentage with sparse-index
 - diff-lib: handle index diffs with sparse dirs
 - dir.c: accept a directory as part of cone-mode patterns
 - unpack-trees: handle dir/file conflict of sparse entries
 - unpack-trees: unpack sparse directory entries
 - unpack-trees: rename unpack_nondirectories()
 - unpack-trees: compare sparse directories correctly
 - unpack-trees: preserve cache_bottom
 - t1092: add tests for status/add and sparse files
 - t1092: expand repository data shape
 - t1092: replace incorrect 'echo' with 'cat'
 - sparse-index: include EXTENDED flag when expanding
 - sparse-index: skip indexes with unmerged entries
 (this branch is used by ds/commit-and-checkout-with-sparse-index.)

 "git status" codepath learned to work with sparsely populated index
 without hydrating it fully.


* ab/describe-tests-fix (2021-05-11) 5 commits
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: don't rely on err.actual from "check_describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty

 Various updates to tests around "git describe"

 Will merge to 'next'.


* ab/pickaxe-pcre2 (2021-05-11) 22 commits
 - xdiff-interface: replace discard_hunk_line() with a flag
 - xdiff users: use designated initializers for out_line
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: allow early return from xdiff_emit_line_fn
 - xdiff-interface: prepare for allowing early return
 - pickaxe -S: slightly optimize contains()
 - pickaxe: rename variables in has_changes() for brevity
 - pickaxe -S: support content with NULs under --pickaxe-regex
 - pickaxe: assert that we must have a needle under -G or -S
 - pickaxe: refactor function selection in diffcore-pickaxe()
 - perf: add performance test for pickaxe
 - pickaxe/style: consolidate declarations and assignments
 - diff.h: move pickaxe fields together again
 - pickaxe: die when --find-object and --pickaxe-all are combined
 - pickaxe: die when -G and --pickaxe-regex are combined
 - pickaxe tests: add missing test for --no-pickaxe-regex being an error
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - grep/pcre2 tests: reword comments referring to kwset

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.

 Will merge to 'next'.


* ab/config-based-hooks-base (2021-06-29) 33 commits
 - hooks: fix a TOCTOU in "did we run a hook?" heuristic
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - receive-pack: convert 'update' hook to hook.h
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - reference-transaction: use hook.h to run hooks
 - transport: convert pre-push hook to use config
 - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - am: convert 'post-rewrite' hook to hook.h
 - hook: support passing stdin to hooks
 - run-command: allow stdin for run_processes_parallel
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change hook to use config
 - commit: use hook.h to execute hooks
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - merge: use config-based hooks for post-merge hook
 - hooks: convert 'post-checkout' hook to hook library
 - am: convert applypatch hooks to use config
 - rebase: teach pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook: add 'run' subcommand
 - hook-list.h: add a generated list of hooks, like config-list.h
 - hook.c: add a hook_exists() wrapper and use it in bugreport.c
 - hook.[ch]: move find_hook() to this new library
 - Makefile: remove an out-of-date comment
 - Makefile: stop hardcoding {command,config}-list.h
 - Makefile: mark "check" target as .PHONY

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Waiting for reviews.


* ab/config-hooks-path-testfix (2021-06-16) 1 commit
 - pre-commit hook tests: don't leave "actual" nonexisting on failure

 Test fix.

 Will merge to 'next'.


* ab/doc-retire-alice-bob (2021-06-16) 6 commits
 - pack-protocol doc: use "www-data" in place of "alice"
 - doc: replace "alice" and "bob" with "jdoe" and "msmith"
 - fast-import doc: change "bob" in an example to "file.txt"
 - daemon doc + code comments: reword "alice" example
 - gitcvs-migration doc: replace "alice" and "bob" with "you" and "www-da=
ta"
 - gittutorial doc: replace "alice" and "bob" with "you" and "www-data"


* ab/pre-auto-gc-hook-test (2021-06-16) 1 commit
 - gc tests: add a test for the "pre-auto-gc" hook

 Test fix.

 Will merge to 'next'.


* jv/userdiff-csharp-update (2021-06-16) 1 commit
 - userdiff: add support for C# record types

 The userdiff pattern for C# learned the token "record".

 Will merge to 'next'.


* en/ort-perf-batch-13 (2021-06-28) 5 commits
 - merge-ort: add prefetching for content merges
 - diffcore-rename: use a different prefetch for basename comparisons
 - diffcore-rename: allow different missing_object_cb functions
 - t6421: add tests checking for excessive object downloads during merge
 - promisor-remote: output trace2 statistics for number of objects fetche=
d

 Performance tweaks of "git merge -sort" around lazy fetching of objects.


* ab/serve-cleanup (2021-06-28) 8 commits
 - upload-pack.c: convert to new serve.c "startup" config cb
 - serve: add support for a "startup" git_config() callback
 - serve.c: add trace2 regions for advertise & command
 - serve.c: add call_{advertise,command}() indirection
 - serve: use designated initializers
 - transport: use designated initializers
 - transport: rename "fetch" in transport_vtable to "fetch_refs"
 - serve: mark has_capability() as static

 Code clean-up around "git serve".


* js/stop-exporting-bogus-columns (2021-06-28) 1 commit
 - pager: avoid setting COLUMNS when we're guessing its value

 When we cannot figure out how wide the terminal is, we use a
 fallback value of 80 ourselves (which cannot be avoided), but when
 we run the pager, we export it in COLUMNS, which forces the pager
 to use the hardcoded value, even when the pager is perfectly
 capable to figure it out itself.  Stop exporting COLUMNS when we
 fall back on the hardcoded default value for our own use.

 Will merge to 'next'.


* ah/uninitialized-reads-fix (2021-06-15) 3 commits
 - builtin/checkout--worker: zero-initialise struct to avoid MSAN complai=
nts
 - split-index: use oideq instead of memcmp to compare object_id's
 - bulk-checkin: make buffer reuse more obvious and safer

 Make the codebase MSAN clean.

 Will merge to 'next'.


* ar/typofix (2021-06-14) 1 commit
 - *: fix typos which duplicate a word

 Typofixes.

 Will merge to 'next'.


* jk/revision-squelch-gcc-warning (2021-06-11) 1 commit
 - add_pending_object_with_path(): work around "gcc -O3" complaint

 Warning fix.

 Will merge to 'next'.


* jk/union-merge-binary (2021-06-11) 3 commits
 - ll_union_merge(): rename path_unused parameter
 - ll_union_merge(): pass name labels to ll_xdl_merge()
 - ll_binary_merge(): handle XDL_MERGE_FAVOR_UNION

 The "union" conflict resultion variant misbehaved when used with
 binary merge driver.

 Will merge to 'next'.


* js/no-more-multimail (2021-06-11) 1 commit
 - multimail: stop shipping a copy

 Remove multimail from contrib/

 Will merge to 'next'.


* js/subtree-on-windows-fix (2021-06-15) 2 commits
 - subtree: fix assumption about the directory separator
 - subtree: fix the GIT_EXEC_PATH sanity check to work on Windows

 Update "git subtree" to work better on Windows.

 Will merge to 'next'.


* jt/partial-clone-submodule-1 (2021-06-28) 5 commits
 - promisor-remote: teach lazy-fetch in any repo
 - run-command: refactor subprocess env preparation
 - submodule: refrain from filtering GIT_CONFIG_COUNT
 - promisor-remote: support per-repository config
 - repository: move global r_f_p_c to repo struct

 Prepare the internals for lazily fetching objects in submodules
 from their promisor remotes.

 Waiting for reviews.


* ab/mktag-tests (2021-06-28) 6 commits
 - mktag tests: test fast-export
 - mktag tests: test for-each-ref
 - mktag tests: test update-ref and reachable fsck
 - mktag tests: test hash-object --literally and unreachable fsck
 - mktag tests: invert --no-strict test
 - mktag tests: parse out options in helper

 Fill test gaps.


* ab/show-branch-tests (2021-06-28) 4 commits
 - show-branch tests: add missing tests
 - show-branch: don't <COLOR></RESET> for space characters
 - show-branch tests: modernize test code
 - show-branch tests: rename the one "show-branch" test file

 Fill test gaps.


* ah/graph-typofix (2021-06-15) 1 commit
 - graph: improve grammar of "invalid color" error message

 Typofix in an error message.

 Will merge to 'next'.


* es/superproject-aware-submodules (2021-06-16) 5 commits
 - SQUASH???
 - submodule: cache superproject gitdir during 'update'
 - submodule: cache superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir cache
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Waiting for reviews.


* fc/pull-cleanups (2021-06-19) 3 commits
 - pull: trivial whitespace style fix
 - pull: trivial cleanup
 - pull: cleanup autostash check

 Code cleanup.

 Will merge to 'next'.


* jk/bitmap-tree-optim (2021-06-15) 1 commit
 - bitmaps: don't recurse into trees already in the bitmap

 Avoid duplicated work while building reachability bitmaps.

 Will merge to 'next'.


* jx/t6020-with-older-bash (2021-06-17) 1 commit
 - t6020: fix incompatible parameter expansion

 Work around inefficient glob substitution in older versions of bash
 by rewriting parts of a test.

 Will merge to 'next'.


* en/zdiff3 (2021-06-15) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.

 Expecting a reroll.
 cf. <CABPp-BE7-E03+x38EK-=3DAE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.co=
m>


* pw/diff-color-moved-fix (2021-06-15) 10 commits
 - diff --color-moved: intern strings
 - diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zebra color=
ing
 - diff --color-moved=3Dzebra: fix alternate coloring

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Waiting for reviews.


* hn/refs-errno-cleanup (2021-06-11) 8 commits
 - refs: explicitly propagate errno from refs_read_raw_ref
 - refs: clear errno return in refs_resolve_ref_unsafe()
 - refs: add failure_errno to refs_read_raw_ref() signature
 - refs: use refs_resolve_ref_unsafe_with_errno() where needed
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL errno output from specification of read_raw_ref_fn

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Will merge to 'next'?


* ab/cmd-foo-should-return (2021-06-09) 1 commit
 - builtins + test helpers: use return instead of exit() in cmd_*

 Code clean-up.

 Will merge to 'next'.


* ab/progress-cleanup (2021-06-08) 1 commit
 - read-cache.c: don't guard calls to progress.c API

 Code clean-up.

 Will merge to 'next'.


* ab/test-tool-cache-cleanup (2021-06-08) 4 commits
 - read-cache perf: add a perf test for refresh_index()
 - test-tool: migrate read-cache-again to parse_options()
 - test-tool: migrate read-cache-perf to parse_options()
 - test-tool: split up test-tool read-cache

 Test code shuffling.

 Waiting for reviews.


* ab/xdiff-bug-cleanup (2021-06-08) 1 commit
 - xdiff: use BUG(...), not xdl_bug(...)

 Code clean-up.

 Will merge to 'next'.


* ar/test-code-cleanup (2021-06-08) 1 commit
 - t: fix whitespace around &&

 Test code clean-up.

 Will merge to 'next'.


* ba/object-info (2021-06-08) 1 commit
 - protocol-caps.h: add newline at end of file

 Code clean-up.

 Will merge to 'next'.


* dd/document-log-decorate-default (2021-06-08) 1 commit
 - doc/log: correct default for --decorate

 Doc clean-up.

 Will merge to 'next'.


* fc/doc-default-to-upstream-config (2021-06-08) 1 commit
 - doc: merge: mention default of defaulttoupstream

 Doc clean-up.

 Will merge to 'next'.


* ms/mergetools-kdiff3-on-windows (2021-06-08) 1 commit
 - mergetools/kdiff3: make kdiff3 work on Windows too

 On Windows, mergetool has been taught to find kdiff3.exe just like
 it finds winmerge.exe.

 Will merge to 'next'.


* ab/pack-objects-stdin (2021-06-28) 4 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.h: refactor "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Code clean-up.


* ar/doc-libera-chat-in-my-first-contrib (2021-06-09) 1 commit
 - MyFirstContribution: link #git-devel to Libera Chat

 Update MyFirst document.

 Will merge to 'next'.


* ar/mailinfo-memcmp-to-skip-prefix (2021-06-09) 1 commit
 - mailinfo: use starts_with() when checking scissors

 Code clean-up.

 Will merge to 'next'.


* ar/submodule-add (2021-06-16) 3 commits
 - submodule--helper: introduce add-config subcommand
 - submodule--helper: introduce add-clone subcommand
 - submodule--helper: refactor module_clone()

 Rewrite of "git submodule" in C continues.

 Waiting for reviews.


* ds/gender-neutral-doc (2021-06-16) 5 commits
 - SQUASH??? replace neutering tips with that of =C3=86ver
 - CodingGuidelines: recommend singular they
 - *: fix typos
 - comments: avoid using the gender of our users
 - doc: avoid using the gender of other people

 Attempt to update the documentation not to assume users are of
 certain gender and adds to guidelines to do so.

 Will wait for conclusion of the on-list discussion.
 It appears that the updates to the text are favourably accepted by
 reviewers, but not necessarily the update to the guidelines.


* gh/gitweb-branch-sort (2021-06-10) 1 commit
 - gitweb: use HEAD as secondary sort key in git_get_heads_list()

 Tie-break branches that point at the same object in the list of
 branches on GitWeb to show the one pointed at by HEAD early.

 Waiting for reviews.


* jk/doc-max-pack-size (2021-06-09) 1 commit
 - doc: warn people against --max-pack-size

 Doc update.

 Will merge to 'next'.


* lh/systemd-timers (2021-06-14) 3 commits
 - maintenance: add support for systemd timers on Linux
 - maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.

 Waiting for reviews.


* dd/svn-test-wo-locale-a (2021-06-08) 1 commit
 - t: use user-specified utf-8 locale for testing svn

 "git-svn" tests assumed that "locale -a", which is used to pick an
 available UTF-8 locale, is available everywhere.  A knob has been
 introduced to allow testers to specify a suitable locale to use.

 Will merge to 'next'.


* fc/completion-updates (2021-06-07) 4 commits
 - completion: bash: add correct suffix in variables
 - completion: bash: fix for multiple dash commands
 - completion: bash: fix for suboptions with value
 - completion: bash: fix prefix detection in branch.*

 Command line completion updates.

 Expecting a reroll.
 cf. <60be6f7fa4435_db80d208f2@natae.notmuch>


* mr/cmake (2021-06-11) 3 commits
 - cmake: add warning for ignored MSGFMT_EXE
 - cmake: create compile_commands.json by default
 - cmake: add knob to disable vcpkg

 CMake update.

 Will merge to 'next'.


* ab/update-submitting-patches (2021-06-08) 3 commits
 - SubmittingPatches: remove pine-specific hints from MUA hints
 - SubmittingPatches: replace discussion of Travis with GitHub Actions
 - SubmittingPatches: move discussion of Signed-off-by above "send"

 Reorganize and update the SubmitingPatches document.

 Expecting a reroll.
 cf. <20210607172542.GA6312@szeder.dev>
 cf. <nycvar.QRO.7.76.6.2106072346560.55@tvgsbejvaqbjf.bet>


* hn/prep-tests-for-reftable (2021-06-02) 22 commits
 - t1415: set REFFILES for test specific to storage format
 - t4202: mark bogus head hash test with REFFILES
 - t7003: check reflog existence only for REFFILES
 - t7900: stop checking for loose refs
 - t1404: mark tests that muck with .git directly as REFFILES.
 - t2017: mark --orphan/logAllRefUpdates=3Dfalse test as REFFILES
 - t1414: mark corruption test with REFFILES
 - t1407: require REFFILES for for_each_reflog test
 - test-lib: provide test prereq REFFILES
 - t5304: use "reflog expire --all" to clear the reflog
 - t5304: restyle: trim empty lines, drop ':' before >
 - t7003: use rev-parse rather than FS inspection
 - t5000: inspect HEAD using git-rev-parse
 - t5000: reformat indentation to the latest fashion
 - t1301: fix typo in error message
 - t1413: use tar to save and restore entire .git directory
 - t1401-symbolic-ref: avoid direct filesystem access
 - t1401: use tar to snapshot and restore repo state
 - t5601: read HEAD using rev-parse
 - t9300: check ref existence using test-helper rather than a file system=
 check
 - t/helper/ref-store: initialize oid in resolve-ref
 - t4202: split testcase for invalid HEAD symref and HEAD hash

 Preliminary clean-up of tests before the main reftable changes
 hits the codebase.

 Will merge to 'next'.


* js/trace2-discard-event-docfix (2021-06-04) 1 commit
 - docs: fix api-trace2 doc for "too_many_files" event

 Docfix.

 Will merge to 'next'.


* tk/partial-clone-repack-doc (2021-06-04) 1 commit
 - Remove warning that repack only works on non-promisor packfiles

 Docfix.

 Will merge to 'next'.


* zh/cat-file-batch-fix (2021-06-04) 2 commits
 - cat-file: merge two block into one
 - cat-file: handle trivial --batch format with --batch-all-objects

 "git cat-file --batch-all-objects"" misbehaved when "--batch" is in
 use and did not ask for certain object traits.

 Will merge to 'next'.


* fc/push-simple-updates (2021-06-02) 7 commits
 - doc: push: explain default=3Dsimple correctly
 - push: remove unused code in setup_push_upstream()
 - push: simplify setup_push_simple()
 - push: reorganize setup_push_simple()
 - push: copy code to setup_push_simple()
 - push: hedge code of default=3Dsimple
 - push: rename !triangular to same_remote
 (this branch is used by fc/push-simple-updates-cleanup.)

 Some code and doc clarification around "git push".

 Will merge to 'next'.


* fc/push-simple-updates-cleanup (2021-06-02) 13 commits
 - push: don't get a full remote object
 - push: only check same_remote when needed
 - push: remove trivial function
 - push: remove redundant check
 - push: factor out the typical case
 - push: get rid of all the setup_push_* functions
 - push: trivial simplifications
 - push: make setup_push_* return the dst
 - push: only get the branch when needed
 - push: factor out null branch check
 - push: split switch cases
 - push: return immediately in trivial switch case
 - push: create new get_upstream_ref() helper
 (this branch uses fc/push-simple-updates.)

 Some more code and doc clarification around "git push".

 Will merge to 'next'.


* tb/complete-diff-anchored (2021-05-31) 1 commit
 - completion: add --anchored to diff's options

 The command line completion (in contrib/) learned that "git diff"
 takes the "--anchored" option.

 Will merge to 'next'.


* en/ort-perf-batch-12 (2021-06-09) 4 commits
 - merge-ort: miscellaneous touch-ups
 - Fix various issues found in comments
 - diffcore-rename: avoid unnecessary strdup'ing in break_idx
 - merge-ort: replace string_list_df_name_compare with faster alternative

 More fix-ups and optimization to "merge -sort".

 Will merge to 'next'.


* zh/ref-filter-raw-data (2021-06-28) 15 commits
 . ref-filter: remove grab_oid() function
 . cat-file: re-implement --textconv, --filters options
 . cat-file: reuse err buf in batch_object_write()
 . cat-file: reuse ref-filter logic
 . cat-file: change batch_objects parameter name
 . cat-file: add has_object_file() check
 . ref-filter: modify the error message and value in get_object
 . ref-filter: add cat_file_mode in struct ref_format
 . ref-filter: introduce free_ref_array_item_value() function
 . ref-filter: pass get_object() return value to their callers
 . ref-filter: add %(rest) atom
 . ref-filter: use non-const ref_format in *_atom_parser()
 . ref-filter: --format=3D%(raw) re-support --perl
 . ref-filter: add %(raw) atom
 . ref-filter: add obj-type check in grab contents

 Prepare the "ref-filter" machinery that drives the "--format"
 option of "git for-each-ref" and its friends to be used in "git
 cat-file --batch".

 This conflicts with the other topic on "cat-file --batch" by the
 same author.


* jh/builtin-fsmonitor (2021-05-24) 30 commits
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - p7519: add fsmonitor--daemon
 - t7527: create test for fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor: enhance existing comments
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement daemon command options
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - fsmonitor--daemon: implement client command options
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via=
 IPC
 - config: FSMonitor is repository-specific
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor--daemon: update fsmonitor documentation
 - fsmonitor--daemon: man page
 - simple-ipc: preparations for supporting binary messages.
 - Merge branch 'jk/perf-in-worktrees' into HEAD
 - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 What's the status of this one?


* es/trace2-log-parent-process-name (2021-06-09) 1 commit
 - tr2: log parent process name

 trace2 logs learned to show parent process name to see in what
 context Git was invoked.

 Will merge to 'next'?


* ab/send-email-optim (2021-05-28) 13 commits
 - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
 - send-email: move trivial config handling to Perl
 - perl: lazily load some common Git.pm setup code
 - send-email: lazily load modules for a big speedup
 - send-email: get rid of indirect object syntax
 - send-email: use function syntax instead of barewords
 - send-email: lazily shell out to "git var"
 - send-email: lazily load config for a big speedup
 - send-email: copy "config_regxp" into git-send-email.perl
 - send-email: refactor sendemail.smtpencryption config parsing
 - send-email: remove non-working support for "sendemail.smtpssl"
 - send-email tests: test for boolean variables without a value
 - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=3Dtrue

 "git send-email" optimization.

 Will merge to 'next'.


* ab/fsck-unexpected-type (2021-06-28) 21 commits
 - fsck: report invalid object type-path combinations
 - fsck: report invalid types recorded in objects
 - object-store.h: move read_loose_object() below 'struct object_info'
 - fsck: don't hard die on invalid object types
 - object-file.c: return -2 on "header too long" in unpack_loose_header()
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: guard against future bugs in loose_object_info()
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: split up ternary in parse_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: add missing braces to loose_object_info()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: don't set "typep" when returning non-zero
 - cache.h: move object functions to object-store.h
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - rev-list tests: test for behavior with invalid object types
 - cat-file tests: test that --allow-unknown-type isn't on by default
 - cat-file tests: test for missing object with -t and -s
 - fsck tests: add test for fsck-ing an unknown type
 - fsck tests: refactor one test to use a sub-repo

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

--------------------------------------------------
[Will Discard]

* ag/merge-strategies-in-c (2021-03-17) 15 commits
 . sequencer: use the "octopus" merge strategy without forking
 . sequencer: use the "resolve" strategy without forking
 . merge: use the "octopus" strategy without forking
 . merge: use the "resolve" strategy without forking
 . merge-octopus: rewrite in C
 . merge-recursive: move better_branch_name() to merge.c
 . merge-resolve: rewrite in C
 . merge-one-file: rewrite in C
 . update-index: move add_cacheinfo() to read-cache.c
 . merge-index: add a new way to invoke `git-merge-one-file'
 . merge-index: drop the index
 . merge-index: libify merge_one_path() and merge_all()
 . t6060: add tests for removed files
 . t6060: modify multiple files to expose a possible issue with merge-ind=
ex
 . t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Will discard.
 We had to wait for a reroll for too long.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* mr/bisect-in-c-4 (2021-04-11) 4 commits
 . bisect--helper: retire `--bisect-next-check` subcommand
 . bisect--helper: reimplement `bisect_run` shell function in C
 . bisect--helper: reimplement `bisect_visualize()`shell function in C
 . run-command: make `exists_in_PATH()` non-static

 The codepaths involved in running "git bisect visualize" and "git
 bisect run" has been rewritten in C.

 Will discard.
 We had to wait for a reroll for too long.
 cf. <xmqq35vwh8qk.fsf@gitster.g>, <xmqqy2doftrj.fsf@gitster.g>,
 <CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ciavCVQ@mail.gmail.com>
 May want to boost the test coverage.


* ma/t0091-bugreport-fix (2021-04-12) 1 commit
 . t0091-bugreport.sh: actually verify some content of report

 Test fix.

 Will discard.
 We had to wait for a reroll for too long.
 Expecting a reroll.
 cf. <YHYZTLl90rkWWVOr@google.com>, <87a6q22dei.fsf@evledraar.gmail.com>


* ls/fast-export-signed (2021-05-03) 5 commits
 . fast-export, fast-import: add support for signed-commits
 . fast-export: do not modify memory from get_commit_buffer
 . git-fast-export.txt: clarify why 'verbatim' may not be a good idea
 . fast-export: rename --signed-tags=3D'warn' to 'warn-verbatim'
 . git-fast-import.txt: add missing LF in the BNF

 "git fast-export" offers a way to control how signed tags are
 handled; the mechanism has been extended to allow specifying how
 signed commits are handled as well.

 Will discard.
 We had to wait for a reroll for too long.
 cf. <xmqqa6pca0pv.fsf@gitster.g>, <xmqq1rao9zev.fsf@gitster.g>


* fc/neuter-doc (2021-06-14) 2 commits
 . comments: avoid using the gender of our users
 . doc: avoid using the gender of other people

 An attempt to avoid gendered pronouns by rewriting parts of docs.

 This seems to give more readable result than Stolee's "use singular
 they" topic.

 Now is a part of the ds/gender-neutral-doc topic.


* es/config-based-hooks (2021-05-27) 37 commits
 . docs: link githooks and git-hook manpages
 . doc: clarify fsmonitor-watchman specification
 . run-command: stop thinking about hooks
 . git-send-email: use 'git hook run' for 'sendemail-validate'
 . bugreport: use hook_exists instead of find_hook
 . receive-pack: convert receive hooks to hook.h
 . post-update: use hook.h library
 . proc-receive: acquire hook list from hook.h
 . receive-pack: convert 'update' hook to hook.h
 . reference-transaction: look for hooks in config
 . transport: convert pre-push hook to use config
 . hook: convert 'post-rewrite' hook to config
 . hooks: convert 'post-checkout' hook to hook library
 . git-p4: use 'git hook' to run hooks
 . receive-pack: convert push-to-checkout hook to hook.h
 . read-cache: convert post-index-change hook to use config
 . rebase: teach pre-rebase to use hook.h
 . gc: use hook library for pre-auto-gc hook
 . merge: use config-based hooks for post-merge hook
 . am: convert applypatch hooks to use config
 . commit: use config-based hooks
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . hook: allow specifying working directory for hooks
 . hook: allow parallel hook execution
 . run-command: allow stdin for run_processes_parallel
 . hook: support passing stdin to hooks
 . hook: introduce hook_exists()
 . hook: add 'run' subcommand
 . parse-options: parse into strvec
 . hook: implement hookcmd.<name>.skip
 . hook: teach hook.runHookDir
 . hook: include hookdir hook in list
 . hook: introduce git-hook subcommand
 . doc: propose hooks managed by the config

 Propose hook scripts defined in the configuration.

 Tentatively kicked out to give ab/config-based-hooks-base a chance
 to interact with other topics in flight.


* bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
 . doc: remove GNU_ROFF option
 . doc: add an option to have Asciidoctor build man pages directly

 An option to render the manual pages via AsciiDoctor bypassing
 xmlto has been introduced.
