Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5166FC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 03:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBE964ECD
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 03:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBSDMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 22:12:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60260 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhBSDMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 22:12:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 719B610C3C9;
        Thu, 18 Feb 2021 22:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=R
        wpIvcak+K/F3GFsnRHv4DsaeGQ=; b=YrIxwGB6IJHDT93eKmCdwMfnUopCypDv/
        cxDmXi78JyGQkKVy3WsysFE5PMVa4GHXeP8ttFs7Pw0YDIr90NK0hmxMnk36tz+7
        LmV/xOnKazhtCRh9kpfQ0RNanki0ubNZX1vTSqAzF/ns5uhtaF+OKx9CERYrtGZN
        5EUeWBuvYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Eju
        H6Ud9xY+5mgHo441bQPRZAlBHyrF2A8keicXCfCn3TD0eOiwdc2CCWL1Dc9qAkCv
        mFjqRV48/sb33E2JYx8pIZcmSAKMV7j4Vvsz5cYgAHWBp+P7atSv52dyln/f9j4M
        lpZb7pcccKdeih4PgYZrFDNK7107QCrhhKXCQM5o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 696C610C3C8;
        Thu, 18 Feb 2021 22:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 953B110C3C6;
        Thu, 18 Feb 2021 22:11:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2021, #04; Thu, 18)
X-master-at: 2283e0e9af55689215afa39c03beb2315ce18e83
X-next-at: b4fecdf3b781fae907790b59fd149f0dae8f8df6
Date:   Thu, 18 Feb 2021 19:11:24 -0800
Message-ID: <xmqqim6obvkz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27462062-7260-11EB-8549-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The ninth batch of topics are in 'master'.

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

* ak/config-bad-bool-error (2021-02-11) 1 commit
  (merged to 'next' on 2021-02-12 at 76784be663)
 + config: improve error message for boolean config

 The error message given when a configuration variable that is
 expected to have a boolean value has been improved.


* ak/corrected-commit-date (2021-01-18) 11 commits
  (merged to 'next' on 2021-01-26 at deae33ec7d)
 + doc: add corrected commit date info
 + commit-reach: use corrected commit dates in paint_down_to_common()
 + commit-graph: use generation v2 only if entire chain does
 + commit-graph: implement generation data chunk
 + commit-graph: implement corrected commit date
 + commit-graph: return 64-bit generation number
 + commit-graph: add a slab to store topological levels
 + t6600-test-reach: generalize *_three_modes
 + commit-graph: consolidate fill_commit_graph_info
 + revision: parse parent in indegree_walk_step()
 + commit-graph: fix regression when computing Bloom filters
 (this branch is used by ds/chunked-file-api, ds/commit-graph-genno-fix and ds/merge-base-independent.)

 The commit-graph learned to use corrected commit dates instead of
 the generation number to help topological revision traversal.

 Will merge to 'master', together with "ds/commit-graph-genno-fix".


* ds/commit-graph-genno-fix (2021-02-01) 6 commits
  (merged to 'next' on 2021-02-03 at b3a9e11efb)
 + commit-graph: prepare commit graph
 + commit-graph: be extra careful about mixed generations
 + commit-graph: compute generations separately
 + commit-graph: validate layers for generation data
 + commit-graph: always parse before commit_graph_data_at()
 + commit-graph: use repo_parse_commit
 (this branch uses ak/corrected-commit-date; is tangled with ds/chunked-file-api and ds/merge-base-independent.)

 Fix incremental update of commit-graph file around corrected commit
 date data.

 Will merge to 'master', together with "ak/corrected-commit-date".


* ds/maintenance-pack-refs (2021-02-09) 2 commits
  (merged to 'next' on 2021-02-11 at 36f56bc9ec)
 + maintenance: incremental strategy runs pack-refs weekly
 + maintenance: add pack-refs task

 "git maintenance" tool learned a new "pack-refs" maintenance task.


* ew/rev-parse-since-test (2021-02-10) 1 commit
  (merged to 'next' on 2021-02-11 at 2490918be8)
 + t1500: ensure current --since= behavior remains

 Test to make sure "git rev-parse one-thing one-thing" gives
 the same thing twice (when one-thing is --since=X).


* jk/mailmap-only-at-root (2021-02-10) 1 commit
  (merged to 'next' on 2021-02-10 at fbd122fd6c)
 + mailmap: only look for .mailmap in work tree

 The .mailmap is documented to be read only from the root level of a
 working tree, but a stray file in a bare repository also was read
 by accident, which has been corrected.


* js/commit-graph-warning (2021-02-11) 1 commit
  (merged to 'next' on 2021-02-12 at e9faad550a)
 + commit-graph: when incompatible with graphs, indicate why

 When certain features (e.g. grafts) used in the repository are
 incompatible with the use of the commit-graph, we used to silently
 turned commit-graph off; we now tell the user what we are doing.


* js/fsck-name-objects-fix (2021-02-10) 2 commits
  (merged to 'next' on 2021-02-10 at 79afd7ebdc)
 + fsck --name-objects: be more careful parsing generation numbers
 + t1450: robustify `remove_object()`

 Fix "git fsck --name-objects" which apparently has not been used by
 anybody who is motivated enough to report breakage.


* js/range-diff-one-side-only (2021-02-06) 6 commits
  (merged to 'next' on 2021-02-08 at 8c35ed8523)
 + range-diff: offer --left-only/--right-only options
 + range-diff: move the diffopt initialization down one layer
 + range-diff: combine all options in a single data structure
 + range-diff: simplify code spawning `git log`
 + range-diff: libify the read_patches() function again
 + range-diff: avoid leaking memory in two error code paths

 The "git range-diff" command learned "--(left|right)-only" option
 to show only one side of the compared range.


* js/range-diff-wo-dotdot (2021-02-06) 3 commits
  (merged to 'next' on 2021-02-08 at 9ae8b46d99)
 + range-diff(docs): explain how to specify commit ranges
 + range-diff/format-patch: handle commit ranges other than A..B
 + range-diff/format-patch: refactor check for commit range

 There are other ways than ".." for a single token to denote a
 "commit range", namely "<rev>^!" and "<rev>^-<n>", but "git
 range-diff" did not understand them.


* js/reflog-expire-stale-fix (2021-02-11) 1 commit
  (merged to 'next' on 2021-02-12 at 899034efca)
 + reflog expire --stale-fix: be generous about missing objects

 "git reflog expire --stale-fix" can be used to repair the reflog by
 removing entries that refer to objects that have been pruned away,
 but was not careful to tolerate missing objects.


* jt/clone-unborn-head (2021-02-05) 3 commits
  (merged to 'next' on 2021-02-08 at 3ba9f80e7f)
 + clone: respect remote unborn HEAD
 + connect, transport: encapsulate arg in struct
 + ls-refs: report unborn targets of symrefs

 "git clone" tries to locally check out the branch pointed at by
 HEAD of the remote repository after it is done, but the protocol
 did not convey the information necessary to do so when copying an
 empty repository.  The protocol v2 learned how to do so.


* jt/trace2-BUG (2021-02-09) 1 commit
  (merged to 'next' on 2021-02-09 at 94911ad676)
 + usage: trace2 BUG() invocations

 Even though invocations of "die()" were logged to the trace2
 system, "BUG()"s were not, which has been corrected.


* jx/t5411-unique-filenames (2021-01-22) 2 commits
  (merged to 'next' on 2021-02-11 at bc5c67f70f)
 + t5411: refactor check of refs using test_cmp_refs
 + t5411: use different out file to prevent overwriting

 Avoid individual tests in t5411 from getting affected by each other
 by forcing them to use separate output files during the test.


* mr/bisect-in-c-4 (2021-02-03) 7 commits
  (merged to 'next' on 2021-02-05 at ea18026619)
 + bisect--helper: retire `--check-and-set-terms` subcommand
 + bisect--helper: reimplement `bisect_skip` shell function in C
 + bisect--helper: retire `--bisect-auto-next` subcommand
 + bisect--helper: use `res` instead of return in BISECT_RESET case option
 + bisect--helper: retire `--bisect-write` subcommand
 + bisect--helper: reimplement `bisect_replay` shell function in C
 + bisect--helper: reimplement `bisect_log` shell function in C

 Piecemeal of rewrite of "git bisect" in C continues.


* mt/grep-cached-untracked (2021-02-09) 1 commit
  (merged to 'next' on 2021-02-10 at e1fca79104)
 + grep: error out if --untracked is used with --cached

 "git grep --untracked" is meant to be "let's ALSO find in these
 files on the filesystem" when looking for matches in the working
 tree files, and does not make any sense if the primary search is
 done against the index, or the tree objects.  The "--cached" and
 "--untracked" options have been marked as mutually incompatible.


* sh/mergetool-hideresolved (2021-02-09) 3 commits
  (merged to 'next' on 2021-02-09 at c3ed19b2ec)
 + mergetool: add per-tool support and overrides for the hideResolved flag
 + mergetool: break setup_tool out into separate initialization function
 + mergetool: add hideResolved configuration

 "git mergetool" feeds three versions (base, local and remote) of
 a conflicted path unmodified.  The command learned to optionally
 prepare these files with unconflicted parts already resolved.

--------------------------------------------------
[New Topics]

* ab/fsck-api-cleanup (2021-02-18) 10 commits
 - fsck.h: update FSCK_OPTIONS_* for object_name
 - fsck.c: give "FOREACH_MSG_ID" a more specific name
 - fsck.c: undefine temporary STR macro after use
 - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
 - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
 - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
 - fsck.c: move definition of msg_id into append_msg_id()
 - fsck.c: rename variables in fsck_set_msg_type() for less confusion
 - fsck.h: use "enum object_type" instead of "int"
 - fsck.h: indent arguments to of fsck_set_msg_type

 Preliminary fsck API clean-up.

 Expecting a reroll.
 cf. <xmqqczwxc8bw.fsf@gitster.g>
 Looking good.


* ab/grep-pcre2-allocfix (2021-02-17) 10 commits
 - grep/pcre2: move definitions of pcre2_{malloc,free}
 - grep/pcre2: move back to thread-only PCREv2 structures
 - grep/pcre2: actually make pcre2 use custom allocator
 - grep/pcre2: use pcre2_maketables_free() function
 - grep/pcre2: use compile-time PCREv2 version test
 - grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
 - grep/pcre2: prepare to add debugging to pcre2_malloc()
 - grep/pcre2: correct reference to grep_init() in comment
 - grep/pcre2: drop needless assignment to NULL
 - grep/pcre2: drop needless assignment + assert() on opt->pcre2

 Updates to memory allocation code around the use of pcre2 library.

 Needs review.
 cf. <20210218000728.13995-1-avarab@gmail.com>

--------------------------------------------------
[Stalled]

* ab/make-cleanup (2021-02-01) 6 commits
 - Makefile: add {program,xdiff,test,git}-objs & objects targets
 - Makefile: split OBJECTS into OBJECTS and GIT_OBJS
 - Makefile: sort OBJECTS assignment for subsequent change
 - Makefile: split up long OBJECTS line
 - Makefile: guard against TEST_OBJS in the environment
 - Makefile: remove "all" on "$(FUZZ_OBJS)"

 Reorganize Makefile to allow building git.o and other essential
 objects without extra stuff needed only for testing.

 Expecting a reroll (or retraction)
 cf. <YBuZVfnc0ECuoKkK@coredump.intra.peff.net>
 cf. <xmqq1rdzjuaa.fsf@gitster.c.googlers.com>


* jk/symlinked-dotgitx-files (2020-10-23) 9 commits
 - docs: document symlink restrictions for .git* files
 - fsck: complain when .gitattributes or .gitignore is a symlink
 - verify_path(): disallow symlinks in .gitattributes and .gitignore
 - t0060: test obscured .gitattributes and .gitignore matching
 - t7450: test .gitmodules symlink matching against obscured names
 - t7450: test verify_path() handling of gitmodules
 - t7415: rename to expand scope
 - fsck_tree(): wrap some long lines
 - fsck_tree(): fix shadowed variable

 "git fsck" and the corresponding check done during the transport
 learned to ensure that in-tree files like `.gitignore` and
 `.gitattributes` are not symbolic links.

 It seems that there are real projects with .gitignore recorded as
 symlinks, which may need to loosen the fsck setting.  Do we need to
 introduce a class that is separate from symlinked .gitmodules that
 has potential consequences that is more/less grave, so that these
 projects can opt out of the new checks?


* ag/merge-strategies-in-c (2020-11-24) 13 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-index: don't fork if the requested program is `git-merge-one-file'
 - merge-index: libify merge_one_path() and merge_all()
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Got enough review comments to get updated.

--------------------------------------------------
[Cooking]

* tb/reverse-midx (2021-02-10) 9 commits
 - pack-revindex: write multi-pack reverse indexes
 - pack-write.c: extract 'write_rev_file_order'
 - pack-revindex: read multi-pack reverse indexes
 - Documentation/technical: describe multi-pack reverse indexes
 - midx: make some functions non-static
 - midx: keep track of the checksum
 - midx: don't free midx_name early
 - midx: allow marking a pack as preferred
 - t/helper/test-read-midx.c: add '--show-objects'

 An on-disk reverse-index to map the in-pack location of an object
 back to its object name across multiple packfiles is introduced.


* ab/detox-gettext-tests (2021-02-10) 4 commits
  (merged to 'next' on 2021-02-17 at bd3d771557)
 + tests: remove most uses of test_i18ncmp
 + tests: remove last uses of C_LOCALE_OUTPUT
 + tests: remove most uses of C_LOCALE_OUTPUT
 + tests: remove last uses of GIT_TEST_GETTEXT_POISON=false

 Removal of GIT_TEST_GETTEXT_POISON continues.

 Will merge to 'master'.


* ab/diff-deferred-free (2021-02-11) 2 commits
  (merged to 'next' on 2021-02-12 at 5e24106122)
 + diff: plug memory leak from regcomp() on {log,diff} -I
 + diff: add an API for deferred freeing

 A small memleak in "diff -I<regexp>" has been corrected.

 Will merge to 'master'.


* jc/diffcore-rotate (2021-02-16) 1 commit
 - diff: --{rotate,skip}-to=<path>

 "git {diff,log} --{skip,rotate}-to=<path>" allows the user to
 discard diff output for early paths or move them to the end of the
 output.

 Will merge to 'next'.


* mz/doc-notes-are-not-anchors (2021-02-10) 1 commit
  (merged to 'next' on 2021-02-17 at 81f92a74b2)
 + docs: clarify that refs/notes/ do not keep the attached objects alive

 Objects that lost references can be pruned away, even when they
 have notes attached to it (and these notes will become dangling,
 which in turn can be pruned with "git notes prune").  This has been
 clarified in the documentation.

 Will merge to 'master'.


* en/diffcore-rename (2021-02-15) 8 commits
 - merge-ort: call diffcore_rename() directly
 - gitdiffcore doc: mention new preliminary step for rename detection
 - diffcore-rename: guide inexact rename detection based on basenames
 - diffcore-rename: complete find_basename_matches()
 - diffcore-rename: compute basenames of source and dest candidates
 - t4001: add a test comparing basename similarity and content similarity
 - diffcore-rename: filter rename_src list when possible
 - diffcore-rename: no point trying to find a match better than exact

 Performance optimization work on the rename detection continues.

 Will merge to 'next'.


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
 (this branch uses ab/test-lib and jk/rev-list-disk-usage.)

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.

 Needs review.
 cf. <20210216115801.4773-1-avarab@gmail.com>


* cm/rebase-i-fixup-amend-reword (2021-02-17) 6 commits
 - doc/git-commit: add documentation for fixup[amend|reword] options
 - t3437: use --fixup with options to create amend! commit
 - t7500: add tests for --fixup[amend|reword] options
 - commit: add a reword suboption to --fixup
 - commit: add amend suboption to --fixup to create amend! commit
 - sequencer: export subject_length()
 (this branch uses cm/rebase-i and cm/rebase-i-updates.)

 "git commit --fixup=<commit>", which was to tweak the changes made
 to the contents while keeping the original log message intact,
 learned "--fixup=(amend|reword):<commit>", that can be used to
 tweak both the message and the contents, and only the message,
 respectively.

 Expecting a reroll.
 cf. <20210217072904.16257-1-charvi077@gmail.com>


* dl/stash-show-untracked (2021-02-16) 4 commits
 - SQUASH???
 - SQUASH???
 - stash show: learn stash.showIncludeUntracked
 - stash show: teach --include-untracked and --only-untracked
 (this branch uses dl/stash-cleanup.)

 "git stash show" learned to optionally show untracked part of the
 stash.

 Expecting a reroll.
 cf. <cover.1613459474.git.liu.denton@gmail.com>


* es/config-hooks-part-1 (2021-02-16) 17 commits
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - hook: allow specifying working directory for hooks
 - hook: allow parallel hook execution
 - run-command: allow stdin for run_processes_parallel
 - hook: support passing stdin to hooks
 - hook: replace find_hook() with hook_exists()
 - hook: add 'run' subcommand
 - parse-options: parse into strvec
 - hook: implement hookcmd.<name>.skip
 - hook: respect hook.runHookDir
 - hook: include hookdir hook in list
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config
 (this branch is used by es/config-hooks.)

 A way to specify hooks in the configuration files is introduced.

 Expecting another reroll??
 cf. <YC7o2rUQOEdiMdqh@google.com>


* jh/fsmonitor-prework (2021-02-16) 11 commits
  (merged to 'next' on 2021-02-17 at 1943efb5ac)
 + fsmonitor: refactor initialization of fsmonitor_last_update token
 + fsmonitor: allow all entries for a folder to be invalidated
 + fsmonitor: log FSMN token when reading and writing the index
 + fsmonitor: log invocation of FSMonitor hook to trace2
 + read-cache: log the number of scanned files to trace2
 + read-cache: log the number of lstat calls to trace2
 + preload-index: log the number of lstat calls to trace2
 + p7519: add trace logging during perf test
 + p7519: move watchman cleanup earlier in the test
 + p7519: fix watchman watch-list test on Windows
 + p7519: do not rely on "xargs -d" in test

 Preliminary changes to fsmonitor integration.

 Will merge to 'master'.


* jk/open-dotgitx-with-nofollow (2021-02-16) 6 commits
 - mailmap: do not respect symlinks for in-tree .mailmap
 - exclude: do not respect symlinks for in-tree .gitignore
 - attr: do not respect symlinks for in-tree .gitattributes
 - exclude: add flags parameter to add_patterns()
 - attr: convert "macro_ok" into a flags field
 - add open_nofollow() helper

 It does not make sense to make ".gitattributes", ".gitignore" and
 ".mailmap" symlinks, as they are supposed to be usable from the
 object store (think: bare repositories where HEAD:.mailmap etc. are
 used).  When these files are symbolic links, we used to read the
 contents of the files pointed by them by mistake, which has been
 corrected.


* js/doc-proto-v2-response-end (2021-02-17) 1 commit
  (merged to 'next' on 2021-02-17 at 9d5d479469)
 + doc: fix naming of response-end-pkt

 Docfix.

 Will merge to 'master'.


* ma/doc-markup-fix (2021-02-18) 3 commits
 - gitmailmap.txt: fix rendering of e-mail addresses
 - git.txt: fix monospace rendering
 - rev-list-options.txt: fix rendering of bonus paragraph

 Docfix.

 Will merge to 'next'.


* rs/blame-optim (2021-02-17) 1 commit
  (merged to 'next' on 2021-02-17 at e54665eeb3)
 + blame: remove unnecessary use of get_commit_info()

 Optimization in "git blame"

 Will merge to 'master'.


* rs/pretty-describe (2021-02-17) 2 commits
 - pretty: add merge and exclude options to %(describe)
 - pretty: add %(describe)

 "git log --format='...'" learned "%(describe)" placeholder.


* cm/rebase-i-updates (2021-02-10) 11 commits
  (merged to 'next' on 2021-02-12 at e29227780b)
 + doc/rebase -i: fix typo in the documentation of 'fixup' command
 + t/t3437: fixup the test 'multiple fixup -c opens editor once'
 + t/t3437: use named commits in the tests
 + t/t3437: simplify and document the test helpers
 + t/t3437: check the author date of fixed up commit
 + t/t3437: remove the dependency of 'expected-message' file from tests
 + t/t3437: fixup here-docs in the 'setup' test
 + t/lib-rebase: update the documentation of FAKE_LINES
 + rebase -i: clarify and fix 'fixup -c' rebase-todo help
 + sequencer: rename a few functions
 + sequencer: fixup the datatype of the 'flag' argument
 (this branch is used by cm/rebase-i-fixup-amend-reword; uses cm/rebase-i.)

 Follow-up fixes to "cm/rebase-i" topic.

 Will merge to 'master', together with "cm/rebase-i".


* cw/pack-vs-bigfilethreashold (2021-02-09) 2 commits
 - fixup! doc: mention bigFileThreshold for packing
 - doc: mention bigFileThreshold for packing

 Doc update.

 Expecting a reroll.
 cf. <F63929A8-7BC9-43A7-9E7B-118433F62588@gmx.ch>


* jk/rev-list-disk-usage (2021-02-17) 4 commits
 - docs/rev-list: add some examples of --disk-usage
 - docs/rev-list: add an examples section
  (merged to 'next' on 2021-02-11 at 6fb701f287)
 + rev-list: add --disk-usage option for calculating disk usage
 + t: add --no-tag option to test_commit
 (this branch is used by ab/pickaxe-pcre2.)

 "git rev-list" command learned "--disk-usage" option.

 Will merge to 'next' and then to 'master'.


* mt/checkout-index-corner-cases (2021-02-16) 2 commits
  (merged to 'next' on 2021-02-17 at 81dad9735b)
 + checkout-index: omit entries with no tempname from --temp output
 + write_entry(): fix misuses of `path` in error messages

 The error codepath around the "--temp/--prefix" feature of "git
 checkout-index" has been improved.

 Will merge to 'master'.


* ab/test-lib (2021-02-12) 11 commits
  (merged to 'next' on 2021-02-12 at 666a0422dc)
 + test-lib-functions: assert correct parameter count
 + test-lib-functions: remove bug-inducing "diagnostics" helper param
 + test libs: rename "diff-lib" to "lib-diff"
 + t/.gitattributes: sort lines
 + test-lib-functions: move function to lib-bitmap.sh
 + test libs: rename gitweb-lib.sh to lib-gitweb.sh
 + test libs: rename bundle helper to "lib-bundle.sh"
 + test-lib-functions: remove generate_zero_bytes() wrapper
 + test-lib-functions: move test_set_index_version() to its user
 + test lib: change "error" to "BUG" as appropriate
 + test-lib: remove check_var_migration
 (this branch is used by ab/pickaxe-pcre2.)

 Test framework clean-up.

 Will merge to 'master'.


* dl/stash-cleanup (2021-02-11) 7 commits
  (merged to 'next' on 2021-02-11 at ae1cde1380)
 + stash: declare ref_stash as an array
 + t3905: use test_cmp() to check file contents
 + t3905: replace test -s with test_file_not_empty
 + t3905: remove nested git in command substitution
 + t3905: move all commands into test cases
 + t3905: remove spaces after redirect operators
 + git-stash.txt: be explicit about subcommand options
 (this branch is used by dl/stash-show-untracked.)

 Documentation, code and test clean-up around "git stash".

 Will merge to 'master'.
 This is an early part of a topic that added a new feature to the
 command, but the implementation is expected to need a handful of
 iterations; I split the preparatory part up to fast-track it.


* sv/t7001-modernize (2021-02-11) 10 commits
 - t7001: use `test` rather than `[`
 - t7001: use here-docs instead of echo
 - t7001: put each command on a separate line
 - t7001: use '>' rather than 'touch'
 - t7001: avoid using `cd` outside of subshells
 - t7001: remove whitespace after redirect operators
 - t7001: modernize subshell formatting
 - t7001: remove unnecessary blank lines
 - t7001: indent with TABs instead of spaces
 - t7001: modernize test formatting

 Test script modernization.

 Expecting the final version with corrected author attribution.


* mt/grep-sparse-checkout (2021-02-09) 1 commit
 - grep: honor sparse-checkout on working tree searches

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Will merge to 'next'.


* jh/simple-ipc (2021-02-17) 12 commits
 - t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
 - simple-ipc: add Unix domain socket implementation
 - unix-socket: create `unix_stream_server__listen_with_lock()`
 - unix-socket: disallow chdir() when creating unix domain sockets
 - unix-socket: add backlog size option to unix_stream_listen()
 - unix-socket: elimiate static unix_stream_socket() helper function
 - simple-ipc: add win32 implementation
 - simple-ipc: design documentation for new IPC mechanism
 - pkt-line: add options argument to read_packetized_to_strbuf()
 - pkt-line: (optionally) libify the packet readers
 - pkt-line: do not issue flush packets in write_packetized_*()
 - pkt-line: eliminate the need for static buffer in packet_write_gently()

 A simple IPC interface gets introduced to build services like
 fsmonitor on top.


* ab/pager-exit-log (2021-02-01) 4 commits
  (merged to 'next' on 2021-02-12 at ffe9f2d364)
 + pager: properly log pager exit code when signalled
 + run-command: add braces for "if" block in wait_or_whine()
 + pager: test for exit code with and without SIGPIPE
 + pager: refactor wait_for_pager() function

 When a pager spawned by us exited, the trace log did not record its
 exit status correctly, which has been corrected.

 Will merge to 'master'.
 The original "what should we do with SIGPIPE?" question remains, though.


* ta/hash-function-transition-doc (2021-02-05) 6 commits
  (merged to 'next' on 2021-02-12 at f620f3cfd3)
 + doc: use https links
 + doc hash-function-transition: move rationale upwards
 + doc hash-function-transition: fix incomplete sentence
 + doc hash-function-transition: use upper case consistently
 + doc hash-function-transition: use SHA-1 and SHA-256 consistently
 + doc hash-function-transition: fix asciidoc output

 Update formatting and grammar of the hash transition plan
 documentation, plus some updates.

 Will merge to 'master'.


* ds/chunked-file-api (2021-02-18) 17 commits
 - chunk-format: add technical docs
 - chunk-format: restore duplicate chunk checks
 - midx: use 64-bit multiplication for chunk sizes
 - midx: use chunk-format read API
 - commit-graph: use chunk-format read API
 - chunk-format: create read chunk API
 - midx: use chunk-format API in write_midx_internal()
 - midx: drop chunk progress during write
 - midx: return success/failure in chunk write methods
 - midx: add num_large_offsets to write_midx_context
 - midx: add pack_perm to write_midx_context
 - midx: add entries to write_midx_context
 - midx: use context in write_midx_pack_names()
 - midx: rename pack_info to write_midx_context
 - commit-graph: use chunk-format write API
 - chunk-format: create chunk format write API
 - commit-graph: anonymize data in chunk_write_fn

 The common code to deal with "chunked file format" that is shared
 by the multi-pack-index and commit-graph files have been factored
 out, to help codepaths for both filetypes to become more rebust.

 Will merge to 'next'.


* ds/merge-base-independent (2021-02-01) 5 commits
 - commit-reach: stale commits may prune generation further
 - commit-reach: use heuristic in remove_redundant()
 - commit-reach: move compare_commits_by_gen
 - commit-reach: use one walk in remove_redundant()
 - commit-reach: reduce requirements for remove_redundant()

 The code to implement "git merge-base --independent" was poorly
 done and was kept from the very beginning of the feature.

 Expecting a reroll.
 cf. <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>


* hv/trailer-formatting (2021-02-15) 4 commits
 - ref-filter: use pretty.c logic for trailers
 - pretty.c: capture invalid trailer argument
 - pretty.c: refactor trailer logic to `format_set_trailers_options()`
 - t6300: use function to test trailer options

 The logic to handle "trailer" related placeholders in the
 "--format=" mechanisms in the "log" family and "for-each-ref"
 family is getting unified.

 Ready for 'next'?


* cm/rebase-i (2021-01-29) 9 commits
  (merged to 'next' on 2021-02-01 at 4f9aa6cec3)
 + doc/git-rebase: add documentation for fixup [-C|-c] options
 + rebase -i: teach --autosquash to work with amend!
 + t3437: test script for fixup [-C|-c] options in interactive rebase
 + rebase -i: add fixup [-C | -c] command
 + sequencer: use const variable for commit message comments
 + sequencer: pass todo_item to do_pick_commit()
 + rebase -i: comment out squash!/fixup! subjects from squash message
 + sequencer: factor out code to append squash message
 + rebase -i: only write fixup-message when it's needed
 (this branch is used by cm/rebase-i-fixup-amend-reword and cm/rebase-i-updates.)

 "rebase -i" is getting cleaned up and also enhanced.

 Will merge to 'master', together with "cm/rebase-i-updates".


* tb/geometric-repack (2021-02-18) 8 commits
 - builtin/repack.c: add '--geometric' option
 - packfile: add kept-pack cache for find_kept_pack_entry()
 - builtin/pack-objects.c: rewrite honor-pack-keep logic
 - p5303: measure time to repack with keep
 - p5303: add missing &&-chains
 - builtin/pack-objects.c: add '--stdin-packs' option
 - revision: learn '--no-kept-objects'
 - packfile: introduce 'find_kept_pack_entry()'

 "git repack" so far has been only capable of repacking everything
 under the sun into a single pack (or split by size).  A cleverer
 strategy to reduce the cost of repacking a repository has been
 introduced.

 cf. <cover.1613618042.git.me@ttaylorr.com>


* ah/rebase-no-fork-point-config (2021-01-21) 1 commit
 - rebase: add a config option for --no-fork-point

 "git rebase --[no-]fork-point" gained a configuration variable
 rebase.forkPoint so that users do not have to keep specifying a
 non-default setting.

 Expecting a reroll to update its tests.
 cf. <CAMMLpeTDNLUz9UVnL3aVK=J7X50Sq8L-OVGaoEsT5AY6EQON-g@mail.gmail.com>


* jt/transfer-fsck-across-packs (2021-01-25) 5 commits
 - SQUASH??? test fix
 - fetch-pack: print and use dangling .gitmodules
 - fetch-pack: with packfile URIs, use index-pack arg
 - http-fetch: allow custom index-pack args
 - http: allow custom index-pack args

 The approach to "fsck" the incoming objects in "index-pack" is
 attractive for performance reasons (we have them already in core,
 inflated and ready to be inspected), but fundamentally cannot be
 applied fully when we receive more than one pack stream, as a tree
 object in one pack may refer to a blob object in another pack as
 ".gitmodules", when we want to inspect blobs that are used as
 ".gitmodules" file, for example.  Teach "index-pack" to emit
 objects that must be inspected later and check them in the calling
 "fetch-pack" process.

 Expecting an update, but perhaps it may be a good approach to
 rebuild the topic on top of ab/fsck-api-cleanup


* bc/signed-objects-with-both-hashes (2021-02-10) 6 commits
  (merged to 'next' on 2021-02-11 at 391cc85104)
 + gpg-interface: remove other signature headers before verifying
 + ref-filter: hoist signature parsing
 + commit: allow parsing arbitrary buffers with headers
 + gpg-interface: improve interface for parsing tags
 + commit: ignore additional signatures when parsing signed commits
 + ref-filter: switch some uses of unsigned long to size_t

 Signed commits and tags now allow verification of objects, whose
 two object names (one in SHA-1, the other in SHA-256) are both
 signed.

 Will merge to 'master'.


* mt/parallel-checkout-part-1 (2020-12-16) 9 commits
 - entry: add checkout_entry_ca() taking preloaded conv_attrs
 - entry: move conv_attrs lookup up to checkout_entry()
 - entry: extract update_ce_after_write() from write_entry()
 - entry: make fstat_output() and read_blob_entry() public
 - entry: extract a header file for entry.c functions
 - convert: add classification for conv_attrs struct
 - convert: add get_stream_filter_ca() variant
 - convert: add [async_]convert_to_working_tree_ca() variants
 - convert: make convert_attrs() and convert structs public

 Parallel checkout.

 Looking good.


* es/config-hooks (2021-02-16) 17 commits
 - run-command: stop thinking about hooks
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - proc-receive: acquire hook list from hook.h
 - receive-pack: convert 'update' hook to hook.h
 - reference-transaction: look for hooks in config
 - transport: convert pre-push hook to use config
 - hook: convert 'post-rewrite' hook to config
 - hooks: convert 'post-checkout' hook to hook library
 - git-p4: use 'git hook' to run hooks
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change hook to use config
 - rebase: teach pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - merge: use config-based hooks for post-merge hook
 - am: convert applypatch hooks to use config
 - commit: use config-based hooks
 (this branch uses es/config-hooks-part-1.)

 The "hooks defined in config" topic.

 Expecting doc updates, but otherwise seems to be progressing nicely.


* hn/reftable (2020-12-21) 16 commits
 - SQUASH??? allow t0031 to run with any default branch name
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

--------------------------------------------------
[Discarded]

* sm/curl-retry (2020-10-13) 3 commits
 . http: automatically retry some requests
 . replace CURLOPT_FILE With CURLOPT_WRITEDATA
 . remote-curl: add testing for intelligent retry for HTTP

 The http transport has been taught to retry a failed request that
 may reasonably be retried.

 Stalled for too long without any activity.
 cf. <20201015000410.GB328643@google.com>
 cf. <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>


* ar/fetch-transfer-ipversion (2020-09-16) 1 commit
 . config: option transfer.ipversion to set transport protocol version for network fetches

 Adds transfer.ipversion configuration variable.

 Stalled for too long without any activity.


* jc/war-on-dashed-git (2020-12-21) 2 commits
 . fixup??? git: catch an attempt to run "git-foo"
 . git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 Stalled for too long without any activity.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Stalled for too long without any activity.
