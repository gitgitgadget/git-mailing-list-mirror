Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB4CC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAAF610C7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhDHWnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:43:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57472 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhDHWnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:43:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA290C5AB3;
        Thu,  8 Apr 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=6
        SPfLoTenqTAfeyqhG4Ym6aP1Wk=; b=rzMRX2cAb30qxc2JqNw6ZNHjRKkPGqlW0
        nb1DZe56C8DUmOLVm+Hk+zBaMRRBsWA8h0nE3ycLKnHels000XoI0J9lG01A+OYA
        keKIfe709or9aCCGTRxjMl4BNlVgz4FjNjcKkVngV8JYZGzxpCpk4gdSpz0+ZECH
        xiHK5QbS2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=phu
        PLM/fZPdgqeNMSsw/uSAeF7i5sXuQN8f472nLf+YNle8/LjuX0sLDD51qWI5Fvqw
        fFPUcSI4m2BiPesOrUhwMJIjZ9guGNlOrVEQrLfxK+6rgHONMPw2TrwUBH14hNQO
        uP1zOpPgvv+kDhEtgBU7RnoAyND57O2GbV0YgCPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E23A7C5AB2;
        Thu,  8 Apr 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F826C5AB1;
        Thu,  8 Apr 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2021, #02; Thu, 8)
X-master-at: 89b43f80a514aee58b662ad606e6352e03eaeee4
X-next-at: be11c130afeab11780014fb555625b10f13c8463
Date:   Thu, 08 Apr 2021 15:43:08 -0700
Message-ID: <xmqqk0pcqtxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAC940C6-98BB-11EB-A94B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

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
[Graduated to 'master']

* ab/fsck-api-cleanup (2021-03-28) 19 commits
  (merged to 'next' on 2021-03-31 at 30c3303dba)
 + fetch-pack: use new fsck API to printing dangling submodules
 + fetch-pack: use file-scope static struct for fsck_options
 + fetch-pack: don't needlessly copy fsck_options
 + fsck.c: move gitmodules_{found,done} into fsck_options
 + fsck.c: add an fsck_set_msg_type() API that takes enums
 + fsck.c: pass along the fsck_msg_id in the fsck_error callback
 + fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
 + fsck.c: give "FOREACH_MSG_ID" a more specific name
 + fsck.c: undefine temporary STR macro after use
 + fsck.c: call parse_msg_type() early in fsck_set_msg_type()
 + fsck.h: re-order and re-assign "enum fsck_msg_type"
 + fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
 + fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
 + fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
 + fsck.c: remove (mostly) redundant append_msg_id() function
 + fsck.c: rename variables in fsck_set_msg_type() for less confusion
 + fsck.h: use "enum object_type" instead of "int"
 + fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 + fsck.c: refactor and rename common config callback

 Fsck API clean-up.


* ab/make-tags-quiet (2021-04-01) 1 commit
  (merged to 'next' on 2021-04-01 at 9ea45b61b8)
 + Makefile: add QUIET_GEN to "tags" and "TAGS" targets

 Generate [ec]tags under $(QUIET_GEN).


* ah/plugleaks (2021-03-21) 9 commits
  (merged to 'next' on 2021-03-30 at 78636ede89)
 + transport: also free remote_refs in transport_disconnect()
 + parse-options: don't leak alias help messages
 + parse-options: convert bitfield values to use binary shift
 + init-db: silence template_dir leak when converting to absolute path
 + init: remove git_init_db_config() while fixing leaks
 + worktree: fix leak in dwim_branch()
 + clone: free or UNLEAK further pointers when finished
 + reset: free instead of leaking unneeded ref
 + symbolic-ref: don't leak shortened refname in check_symref()

 Plug or annotate remaining leaks that trigger while running the
 very basic set of tests.


* cc/downcase-opt-help (2021-03-29) 1 commit
  (merged to 'next' on 2021-03-31 at 0df5c647b9)
 + column, range-diff: downcase option description

 A few option description strings started with capital letters,
 which were corrected.


* ds/clarify-hashwrite (2021-03-26) 1 commit
  (merged to 'next' on 2021-03-30 at 701f5c0696)
 + csum-file: make hashwrite() more readable

 The hashwrite() API uses a buffering mechanism to avoid calling
 write(2) too frequently. This logic has been refactored to be
 easier to understand.


* en/ort-perf-batch-9 (2021-03-10) 8 commits
  (merged to 'next' on 2021-04-01 at cc5254aadc)
 + diffcore-rename: avoid doing basename comparisons for irrelevant sources
 + merge-ort: skip rename detection entirely if possible
 + merge-ort: use relevant_sources to filter possible rename sources
 + merge-ort: precompute whether directory rename detection is needed
 + merge-ort: introduce wrappers for alternate tree traversal
 + merge-ort: add data structures for an alternate tree traversal
 + merge-ort: precompute subset of sources for which we need rename detection
 + diffcore-rename: enable filtering possible rename sources
 (this branch is used by en/ort-perf-batch-10, en/ort-perf-batch-11 and en/ort-readiness.)

 The ort merge backend has been optimized by skipping irrelevant
 renames.


* en/sequencer-edit-upon-conflict-fix (2021-03-31) 1 commit
  (merged to 'next' on 2021-04-01 at 2e3c705a73)
 + sequencer: fix edit handling for cherry-pick and revert messages

 "git cherry-pick/revert" with or without "--[no-]edit" did not spawn
 the editor as expected (e.g. "revert --no-edit" after a conflict
 still asked to edit the message), which has been corrected.


* js/cmake-vsbuild (2021-03-29) 4 commits
  (merged to 'next' on 2021-03-31 at e0c4369f65)
 + cmake(install): include vcpkg dlls
 + cmake: add a preparatory work-around to accommodate `vcpkg`
 + cmake(install): fix double .exe suffixes
 + cmake: support SKIP_DASHED_BUILT_INS

 CMake update for vsbuild.


* js/security-md (2021-03-27) 2 commits
  (merged to 'next' on 2021-03-31 at 28f64fee38)
 + Document how we do embargoed releases
 + SECURITY: describe how to report vulnerabilities

 SECURITY.md that is facing individual contributors and end users
 has been introduced.  Also a procedure to follow when preparing
 embargoed releases has been spelled out.


* ll/clone-reject-shallow (2021-04-01) 1 commit
  (merged to 'next' on 2021-04-01 at 9b13372e1a)
 + builtin/clone.c: add --reject-shallow option

 "git clone --reject-shallow" option fails the clone as soon as we
 notice that we are cloning from a shallow repository.


* ps/pack-bitmap-optim (2021-03-22) 1 commit
  (merged to 'next' on 2021-03-31 at 12bb775d9a)
 + pack-bitmap: avoid traversal of objects referenced by uninteresting tag

 Optimize "rev-list --use-bitmap-index --objects" corner case that
 uses negative tags as the stopping points.


* rs/daemon-sanitize-dir-sep (2021-03-26) 1 commit
  (merged to 'next' on 2021-04-01 at c8f43b1c8d)
 + daemon: sanitize all directory separators

 "git daemon" has been tightened against systems that take backslash
 as directory separator.


* tb/reverse-midx (2021-04-01) 17 commits
  (merged to 'next' on 2021-04-01 at 17c9542606)
 + midx.c: improve cache locality in midx_pack_order_cmp()
 + pack-revindex: write multi-pack reverse indexes
 + pack-write.c: extract 'write_rev_file_order'
 + pack-revindex: read multi-pack reverse indexes
 + Documentation/technical: describe multi-pack reverse indexes
 + midx: make some functions non-static
 + midx: keep track of the checksum
 + midx: don't free midx_name early
 + midx: allow marking a pack as preferred
 + t/helper/test-read-midx.c: add '--show-objects'
 + builtin/multi-pack-index.c: display usage on unrecognized command
 + builtin/multi-pack-index.c: don't enter bogus cmd_mode
 + builtin/multi-pack-index.c: split sub-commands
 + builtin/multi-pack-index.c: define common usage with a macro
 + builtin/multi-pack-index.c: don't handle 'progress' separately
 + builtin/multi-pack-index.c: inline 'flags' with options
 + Merge branch 'ds/chunked-file-api' into tb/reverse-midx

 An on-disk reverse-index to map the in-pack location of an object
 back to its object name across multiple packfiles is introduced.


* zh/commit-trailer (2021-03-23) 1 commit
  (merged to 'next' on 2021-03-31 at f17d196ee1)
 + commit: add --trailer option
 (this branch is used by zh/trailer-cmd.)

 "git commit" learned "--trailer <key>[=<value>]" option; together
 with the interpret-trailers command, this will make it easier to
 support custom trailers.

--------------------------------------------------
[Stalled]

* dl/complete-stash (2021-03-24) 3 commits
  (merged to 'next' on 2021-03-24 at ce573a99cc)
 + git-completion.bash: use __gitcomp_builtin() in _git_stash()
 + git-completion.bash: extract from else in _git_stash()
 + git-completion.bash: pass $__git_subcommand_idx from __git_main()

 Update "git stash branch<TAB>" command line completion (in contrib/).

 On hold.  Probably needs either a reroll or incremental refinements.
 cf. <20210327183554.GD2271@szeder.dev>


* ag/merge-strategies-in-c (2021-03-17) 15 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Expecting a (hopefully final) reroll.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* ab/unexpected-object-type (2021-03-27) 10 commits
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - object.c: add and use oid_is_type_or_die_msg() function
 - object.c: add a utility function for "expected type X, got Y"
 - tree.c: fix misindentation in parse_tree_gently()
 - object-name.c: make dependency on object_type order more obvious
 - object-file.c: make oid_object_info() return "enum object_type"
 - object.c: make type_from_string() return "enum object_type"
 - object.c: refactor type_from_string_gently()
 - object.c: stop supporting len == -1 in type_from_string_gently()

 Error reporting upon object type mismatch has been improved

 Expecting a reroll.
 cf. <YGBL88lYheyFmwCg@coredump.intra.peff.net>
 ... we would be much better off to say something like "somebody
 expected X to be a commit, but now somebody else expects it to be a
 blob", which is all that we can reliably say.


* ab/describe-tests-fix (2021-03-01) 10 commits
 - test-lib: return 1 from test_expect_{success,failure}
 - svn tests: refactor away a "set -e" in test body
 - svn tests: remove legacy re-setup from init-clone test
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: convert setup to use test_commit
 - test-lib functions: add an --annotated-tag option to "test_commit"
 - describe tests: always assert empty stderr from "describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty

 Various updates to tests around "git describe"

 Expecting a reroll.
 cf. <xmqq1rcj6hzr.fsf@gitster.g>


* ab/pickaxe-pcre2 (2021-02-18) 24 commits
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: support early exit in xdiff_outf()
 - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
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
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - test-lib functions: add --printf option to test_commit
 - test-lib-functions: reword "test_commit --append" docs
 - test-lib-functions: document and test test_commit --no-tag
 - grep/pcre2 tests: reword comments referring to kwset
 - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
 - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.

 Needs (hopefully the final round of) reroll and its review.
 cf. <xmqqh7ksb5j7.fsf@gitster.g>, <xmqqa6qkb5fi.fsf@gitster.g>, etc.


* es/config-hooks (2021-03-10) 36 commits
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
 . hook: add list command
 . hook: scaffolding for git-hook subcommand
 . doc: propose hooks managed by the config

 The "hooks defined in config" topic.

--------------------------------------------------
[New Topics]

* cc/test-helper-bloom-usage-fix (2021-04-05) 1 commit
  (merged to 'next' on 2021-04-06 at 4895f33fee)
 + test-bloom: fix missing 'bloom' from usage string

 Usage message fix for a test helper.

 Will merge to 'master'.


* jz/apply-run-3way-first (2021-04-06) 1 commit
 - git-apply: try threeway first when "--3way" is used
 (this branch is used by jz/apply-3way-cached.)

 "git apply --3way" has always been "to fall back to 3-way merge
 only when straight application fails". Swap the order of falling
 back so that 3-way is always attempted first (only when the option
 is given, of course) and then straight patch application is used as
 a fallback when it fails.

 Will merge to 'next'.


* ds/maintenance-prefetch-fix (2021-04-06) 5 commits
 - maintenance: allow custom refspecs during prefetch
 - test-tool: test refspec input/output
 - refspec: output a refspec item
 - test-lib: use exact match for test_subcommand
 - maintenance: simplify prefetch logic

 The prefetch task in "git maintenance" assumed that "git fetch"
 from any remote would fetch all its local branches, which would
 fetch too much if the user is interested in only a subset of
 branches there.

 Expecting a reroll.
 cf. <35fa99cf-ba24-f13e-0607-f9acce2905cf@gmail.com>


* ab/complete-cherry-pick-head (2021-04-07) 1 commit
 - bash completion: complete CHERRY_PICK_HEAD

 The command line completion (in contrib/) has learned that
 CHERRY_PICK_HEAD is a possible pseudo-ref.

 Will merge to 'next'?


* mr/bisect-in-c-4 (2021-04-07) 4 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell function in C
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static

 The codepaths involved in running "git bisect visualize" and "git
 bisect run" has been rewritten in C.

 Expecting a reroll.
 cf. <xmqqo8epydwx.fsf@gitster.g>, <xmqqeeflycf9.fsf@gitster.g>


* ab/detox-config-gettext (2021-04-08) 1 commit
 - config.c: remove last remnant of GIT_TEST_GETTEXT_POISON

 The last remnant of gettext-poison has been removed.

 Will merge to 'next'.


* jz/apply-3way-cached (2021-04-07) 1 commit
 - git-apply: allow simultaneous --cached and --3way options
 (this branch uses jz/apply-run-3way-first.)

 "git apply" now takes "--3way" and "--cached" at the same time, and
 work and record results only in the index.

 Will merge to 'next'.


* vs/completion-with-set-u (2021-04-08) 1 commit
 - completion: audit and guard $GIT_* against unset use

 The command-line completion script (in contrib/) had a couple of
 references that would have given a warning under the "-u" (nounset)
 option.

 Will merge to 'next'.


* sg/bugreport-fixes (2021-04-08) 1 commit
 - Makefile: add missing dependencies of 'config-list.h'

 The dependencies for config-list.h and command-list.h were broken
 when the former was split out of the latter, which has been
 corrected.

 Will merge to 'next'.

--------------------------------------------------
[Cooking]

* mt/add-rm-in-sparse-checkout (2021-04-08) 7 commits
 - rm: honor sparse checkout patterns
 - add: warn when asked to update SKIP_WORKTREE entries
 - refresh_index(): add flag to ignore SKIP_WORKTREE entries
 - pathspec: allow to ignore SKIP_WORKTREE entries on index matching
 - add: make --chmod and --renormalize honor sparse checkouts
 - t3705: add tests for `git add` in sparse checkouts
 - add: include magic part of pathspec on --refresh error

 "git add" and "git rm" learned not to touch those paths that are
 outside of sparse checkout.


* jh/rfc-builtin-fsmonitor (2021-04-08) 23 commits
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - p7519: add fsmonitor--daemon
 - t7527: create test for fsmonitor--daemon
 - fsmonitor: force update index when fsmonitor token advances
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon:: introduce client delay for testing
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
 - fsmonitor--daemon: implement client command options
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
 - config: FSMonitor is repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor


* jk/ref-filter-segfault-fix (2021-04-01) 1 commit
  (merged to 'next' on 2021-04-02 at 03596563b7)
 + ref-filter: fix NULL check for parse object failure

 A NULL-dereference bug has been corrected in an error codepath in
 "git for-each-ref", "git branch --list" etc.

 Will merge to 'master'.


* tb/pack-preferred-tips-to-give-bitmap (2021-03-31) 3 commits
  (merged to 'next' on 2021-04-03 at cd7024ecd8)
 + builtin/pack-objects.c: respect 'pack.preferBitmapTips'
 + t/helper/test-bitmap.c: initial commit
 + pack-bitmap: add 'test_bitmap_commits()' helper

 A configuration variable has been added to force tips of certain
 refs to be given a reachability bitmap.

 Will merge to 'master'.


* ab/perl-do-not-abuse-map (2021-04-02) 1 commit
  (merged to 'next' on 2021-04-03 at 4eaf558557)
 + git-send-email: replace "map" in void context with "for"
 (this branch is used by ab/send-email-validate-errors.)

 Perl critique.

 Will merge to 'master'.


* zh/trailer-cmd (2021-04-02) 1 commit
 - trailer: add new trailer.<token>.cmd config option

 The way the command line specified by the trailer.<token>.command
 configuration variable receives the end-user supplied value was
 both error prone and misleading.  An alternative to achieve the
 same goal in a safer and more intuitive way has been added, as
 the trailer.<token>.cmd configuration variable, to replace it.

 Expecting a reroll.
 cf. <CAP8UFD08Lagij6oqpOJkpbzMLRgQ08=mDfiyf1qXyD5VW6Ae7A@mail.gmail.com>


* fm/user-manual-use-preface (2021-04-03) 1 commit
  (merged to 'next' on 2021-04-05 at 0ae8f63207)
 + user-manual.txt: assign preface an id and a title

 Doc update to improve git.info

 Will merge to 'master'.


* ab/send-email-validate-errors (2021-04-06) 3 commits
  (merged to 'next' on 2021-04-06 at d7fb1dbde0)
 + git-send-email: improve --validate error output
 + git-send-email: refactor duplicate $? checks into a function
 + git-send-email: test full --validate output
 (this branch uses ab/perl-do-not-abuse-map.)

 Clean-up codepaths that implements "git send-email --validate"
 option and improves the message from it.

 Will merge to 'master'.


* tb/precompose-prefix-simplify (2021-04-05) 2 commits
  (merged to 'next' on 2021-04-05 at 78e8ed11b7)
 + macOS: precompose startup_info->prefix
 + precompose_utf8: make precompose_string_if_needed() public

 Streamline the codepath to fix the UTF-8 encoding issues in the
 argv[] and the prefix on macOS.

 Will merge to 'master'.


* ab/userdiff-tests (2021-04-08) 9 commits
 - blame tests: simplify userdiff driver test
 - blame tests: don't rely on t/t4018/ directory
 - userdiff: remove support for "broken" tests
 - userdiff tests: list builtin drivers via test-tool
 - userdiff tests: explicitly test "default" pattern
 - userdiff: add and use for_each_userdiff_driver()
 - userdiff style: normalize pascal regex declaration
 - userdiff style: declare patterns with consistent style
 - userdiff style: re-order drivers in alphabetical order

 A bit of code clean-up and a lot of test clean-up around userdiff
 area.

 Will merge to 'next'?


* ar/userdiff-scheme (2021-04-08) 1 commit
 - userdiff: add support for Scheme

 Userdiff patterns for "Scheme" has been added.

 Will merge to 'next'?


* gk/gitweb-redacted-email (2021-03-31) 1 commit
 - gitweb: add "e-mail privacy" feature to redact e-mail addresses

 "gitweb" learned "e-mail privacy" feature to redact strings that
 look like e-mail addresses on various pages.

 Waiting for reviews.
 cf. <xmqq5z19k9wu.fsf@gitster.g>


* ds/sparse-index (2021-03-30) 21 commits
  (merged to 'next' on 2021-04-07 at f1290a7929)
 + p2000: add sparse-index repos
 + sparse-index: loose integration with cache_tree_verify()
 + cache-tree: integrate with sparse directory entries
 + sparse-checkout: disable sparse-index
 + sparse-checkout: toggle sparse index from builtin
 + sparse-index: add index.sparse config option
 + sparse-index: check index conversion happens
 + unpack-trees: allow sparse directories
 + submodule: sparse-index should not collapse links
 + sparse-index: convert from full to sparse
 + sparse-index: add 'sdir' index extension
 + sparse-checkout: hold pattern list in index
 + unpack-trees: ensure full index
 + test-tool: don't force full index
 + test-read-cache: print cache entries with --table
 + t1092: compare sparse-checkout to sparse-index
 + sparse-index: implement ensure_full_index()
 + sparse-index: add guard to ensure full index
 + t1092: clean up script quoting
 + t/perf: add performance test for sparse operations
 + sparse-index: design doc and format update
 (this branch is used by ds/sparse-index-protections.)

 Both in-core and on-disk index has been updated to optionally omit
 individual entries and replace them with the tree object that
 corresponds to the directory that contains them when the "cone"
 mode of sparse checkout is in use.

 On hold, waiting for the "protections" topic to stablize.


* en/ort-perf-batch-10 (2021-03-18) 8 commits
  (merged to 'next' on 2021-04-07 at 9826d89311)
 + diffcore-rename: determine which relevant_sources are no longer relevant
 + merge-ort: record the reason that we want a rename for a file
 + diffcore-rename: add computation of number of unknown renames
 + diffcore-rename: check if we have enough renames for directories early on
 + diffcore-rename: only compute dir_rename_count for relevant directories
 + merge-ort: record the reason that we want a rename for a directory
 + merge-ort, diffcore-rename: tweak dirs_removed and relevant_source type
 + diffcore-rename: take advantage of "majority rules" to skip more renames
 (this branch is used by en/ort-perf-batch-11 and en/ort-readiness.)

 Various rename detection optimization to help "ort" merge strategy
 backend.

 Will merge to 'master'.


* mt/parallel-checkout-part-2 (2021-04-08) 5 commits
 - parallel-checkout: add design documentation
 - parallel-checkout: support progress displaying
 - parallel-checkout: add configuration options
 - parallel-checkout: make it truly parallel
 - unpack-trees: add basic support for parallel checkout


* ds/sparse-index-protections (2021-03-31) 25 commits
 - name-hash: use expand_to_path()
 - sparse-index: expand_to_path()
 - revision: ensure full index
 - resolve-undo: ensure full index
 - read-cache: ensure full index
 - pathspec: ensure full index
 - merge-recursive: ensure full index
 - entry: ensure full index
 - dir: ensure full index
 - update-index: ensure full index
 - stash: ensure full index
 - rm: ensure full index
 - merge-index: ensure full index
 - ls-files: ensure full index
 - grep: ensure full index
 - fsck: ensure full index
 - difftool: ensure full index
 - commit: ensure full index
 - checkout: ensure full index
 - checkout-index: ensure full index
 - add: ensure full index
 - cache: move ensure_full_index() to cache.h
 - read-cache: expand on query into sparse-directory entry
 - *: remove 'const' qualifier for struct index_state
 - sparse-index: API protection strategy
 (this branch uses ds/sparse-index.)

 Builds on top of the sparse-index infrastructure to mark operations
 that are not ready to mark with the sparse index, causing them to
 fall back on fully-populated index that they always have worked with.


* en/ort-readiness (2021-03-20) 13 commits
 - Add testing with merge-ort merge strategy
 - t6423: mark remaining expected failure under merge-ort as such
 - Revert "merge-ort: ignore the directory rename split conflict for now"
 - merge-recursive: add a bunch of FIXME comments documenting known bugs
 - merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
 - t: mark several submodule merging tests as fixed under merge-ort
 - merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
 - t6428: new test for SKIP_WORKTREE handling and conflicts
 - merge-ort: support subtree shifting
 - merge-ort: let renormalization change modify/delete into clean delete
 - merge-ort: have ll_merge() use a special attr_index for renormalization
 - merge-ort: add a special minimal index just for renormalization
 - merge-ort: use STABLE_QSORT instead of QSORT where required
 (this branch is used by en/ort-perf-batch-11; uses en/ort-perf-batch-10.)

 Plug the ort merge backend throughout the rest of the system, and
 start testing it as a replacement for the recursive backend.

 Will merge to 'next'?


* hn/reftable (2021-03-12) 15 commits
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - Reftable support for git-core
 - reftable: rest of library
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - init-db: set the_repository->hash_algo early on

 The "reftable" backend for the refs API.

 What's the status of this topic?

--------------------------------------------------
[Discarded]

* ab/make-cocci-dedup (2021-03-22) 4 commits
 . Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
 . Makefile/coccicheck: allow for setting xargs concurrency
 . Makefile/coccicheck: speed up and fix bug with duplicate hunks
 . Makefile/coccicheck: add comment heading for all SPATCH flags

 Coccicheck update.

 Retracted.
 cf. <cover.1616414951.git.avarab@gmail.com>
 cf. <87k0psnzv5.fsf@evledraar.gmail.com>


* ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
 - tests: get rid of $_x05 from the test suite
 - shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
 - test-lib: remove unused $_x40 and $_z40 variables
 - git-bisect: remove unused SHA-1 $x40 shell variable

 Remove variables that hold regexp and glob that match fixed number
 of hexadecimal digits from the test suite.

 Retracted, to be replaced by another series.
 cf. <878s67o09v.fsf@evledraar.gmail.com>
