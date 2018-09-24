Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C5C1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 22:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIYELi (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:11:38 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39653 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeIYELX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:11:23 -0400
Received: by mail-wm1-f42.google.com with SMTP id q8-v6so11552340wmq.4
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=JJpU0cA4JyNJlZPztWQiZkJpwupCDzrx+isRvZonYfo=;
        b=Wz+yQ7XmAH2uhr3vH4kHTORrXRy6bSMF2zeZEGMfiTtJwXfhQXfNG2uEF1GIqi6+/F
         sqNFIxy3aDKmgUQob9bZRaMT3MJGZFEXdB9g0EcViTC1pZbuow67l288ltjw60E3Ba6c
         IpPD+6/3YKV1eErQoC2OW1uqrT9hxq9WJWhDp8836oeunaEjlD8nDKTpWytXqsrvPLWd
         k2qS1nTt0HOOrJrgMkLyT6XvILrwIGsNIS3lFCAwl6M7Nv3TDL3IwNaoyjj2Pn5Jt4tR
         SbkXDZsdIUlrSRG1YxEzRrpJPdDRaZqo+1O6ljr4Ens5WgtmpAJmnWgE8NlHqwNCP8ae
         ersQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=JJpU0cA4JyNJlZPztWQiZkJpwupCDzrx+isRvZonYfo=;
        b=rPeehiIabWyvbriisv4yXni87NlYnOPz070y1imObmLvk6z2iCNJTT1fEOkeT+oTd2
         0RwkNz245SPHkMCRW6OwLlMZR2wYYiA+UL7ULrQhIf3jsg7fhr+oI0Tbtx6131Ki7S1h
         h0/GAmdMlAzeOhMbi3VCgMU10H0REGmOtcl0tDEItKptLFPoCZplOLQe/Plh1gcI9p2a
         lGbDd5R/cLhxPgZzoS4uXwI22CQ+ZRUeSI3sPI6TGTHZ0dHUhG7AAuIgFytj+jwKg8Yr
         YuixpbpHl7RBpO58dKHf7Hdfyim+l8uRu8A4Y+HOSxcSRUwKh8sCoh26fhLXWWc8oxc3
         IkQA==
X-Gm-Message-State: ABuFfoiW1LDrIWV0wVhFVXheTKV23T2Q0erZJSWERp4Ada5Sdwy8mGIv
        86GsqwL2aJCPrsbFBYVz68/sp6Hz
X-Google-Smtp-Source: ACcGV60/aBR9FdKh1cUHZLok4p0sNAji/sNNn+tsIoMxSK9NhFR8sQ0Ofvy1FTUvciF554j35KMnjQ==
X-Received: by 2002:a7b:c215:: with SMTP id x21-v6mr243229wmi.72.1537826819343;
        Mon, 24 Sep 2018 15:06:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 66-v6sm179486wmw.34.2018.09.24.15.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:06:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2018, #05; Mon, 24)
X-master-at: fe8321ec057f9231c26c29b364721568e58040f7
X-next-at: 76f2f5c1e34c4dbef1029e2984c2892894c444ce
Date:   Mon, 24 Sep 2018 15:06:58 -0700
Message-ID: <xmqqmus6r1ml.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'master' has been updated with about 20 topics, the tip
of 'next' has been rewound, and 'maint' now prepares for Git 2.19.x
maintenance track.  A few topics have been kicked out of 'next' to
'pu' to be replaced with a newer iterations.

Please double check what's in and not in 'next', and when you are
rerolling a topic in flight, make sure to make patches incremental
if your topic is already in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bp/mv-submodules-with-fsmonitor (2018-09-12) 1 commit
  (merged to 'next' on 2018-09-17 at 61c3dc4ebe)
 + git-mv: allow submodules and fsmonitor to work together

 When fsmonitor is in use, after operation on submodules updates
 .gitmodules, we lost track of the fact that we did so and relied on
 stale fsmonitor data.


* bw/protocol-v2 (2018-09-10) 1 commit
  (merged to 'next' on 2018-09-17 at 973a67bf55)
 + config: document value 2 for protocol.version

 Doc fix.


* ds/format-patch-range-diff-test (2018-09-12) 1 commit
  (merged to 'next' on 2018-09-17 at bd99e0e88c)
 + t3206-range-diff.sh: cover single-patch case

 A new test to cover "--range-diff" option of format-patch used for
 a single patch.


* ds/reachable (2018-09-21) 2 commits
  (merged to 'next' on 2018-09-21 at d4cd62108e)
 + commit-reach: fix memory and flag leaks
 + commit-reach: properly peel tags

 Recent update broke the reachability algorithm when refs (e.g.
 tags) that point at objects that are not commit were involved,
 which has been fixed.
 Hotfix for a topic already in 'master'.


* en/double-semicolon-fix (2018-09-05) 1 commit
  (merged to 'next' on 2018-09-17 at dc3847b728)
 + Remove superfluous trailing semicolons

 Code clean-up.


* en/rerere-multi-stage-1-fix (2018-09-11) 2 commits
  (merged to 'next' on 2018-09-17 at 07b9b319ab)
 + rerere: avoid buffer overrun
 + t4200: demonstrate rerere segfault on specially crafted merge

 A corner case bugfix in "git rerere" code.


* en/sequencer-empty-edit-result-aborts (2018-09-13) 1 commit
  (merged to 'next' on 2018-09-17 at 768dcf3cab)
 + sequencer: fix --allow-empty-message behavior, make it smarter

 "git rebase" etc. in Git 2.19 fails to abort when given an empty
 commit log message as result of editing, which has been corrected.


* en/update-ref-no-deref-stdin (2018-09-12) 2 commits
  (merged to 'next' on 2018-09-17 at a56c0a3003)
 + update-ref: allow --no-deref with --stdin
 + update-ref: fix type of update_flags variable to match its usage

 "git update-ref" learned to make both "--no-deref" and "--stdin"
 work at the same time.


* jk/dev-build-format-security (2018-09-11) 1 commit
  (merged to 'next' on 2018-09-17 at 36fbb6a88b)
 + config.mak.dev: add -Wformat-security

 Build tweak to help developers.


* jk/reopen-tempfile-truncate (2018-09-05) 1 commit
  (merged to 'next' on 2018-09-17 at 7c7a0608e0)
 + reopen_tempfile(): truncate opened file

 Fix for a long-standing bug that leaves the index file corrupt when
 it shrinks during a partial commit.


* js/mingw-o-append (2018-09-11) 2 commits
  (merged to 'next' on 2018-09-17 at 5b6e9be48e)
 + mingw: fix mingw_open_append to work with named pipes
 + t0051: test GIT_TRACE to a windows named pipe

 Further fix for O_APPEND emulation on Windows


* js/rebase-i-autosquash-fix (2018-09-04) 2 commits
  (merged to 'next' on 2018-09-17 at cec540d24b)
 + rebase -i: be careful to wrap up fixup/squash chains
 + rebase -i --autosquash: demonstrate a problem skipping the last squash

 "git rebase -i" did not clear the state files correctly when a run
 of "squash/fixup" is aborted and then the user manually amended the
 commit instead, which has been corrected.


* jt/lazy-object-fetch-fix (2018-09-13) 2 commits
  (merged to 'next' on 2018-09-17 at 321602b284)
 + fetch-object: set exact_oid when fetching
 + fetch-object: unify fetch_object[s] functions

 The code to backfill objects in lazily cloned repository did not
 work correctly, which has been corrected.


* ms/remote-error-message-update (2018-09-14) 1 commit
  (merged to 'next' on 2018-09-17 at d37a215b62)
 + builtin/remote: quote remote name on error to display empty name

 Update error messages given by "git remote" and make them consistent.


* nd/attr-pathspec-fix (2018-09-21) 1 commit
  (merged to 'next' on 2018-09-21 at 9f6b5a497f)
 + add: do not accept pathspec magic 'attr'

 "git add ':(attr:foo)'" is not supported and is supposed to be
 rejected while the command line arguments are parsed, but we fail
 to reject such a command line upfront.


* sb/diff-color-move-more (2018-09-11) 1 commit
  (merged to 'next' on 2018-09-17 at 70c8d0fea8)
 + diff: fix --color-moved-ws=allow-indentation-change

 Bugfix.


* sb/string-list-remove-unused (2018-09-11) 1 commit
  (merged to 'next' on 2018-09-17 at 9ecdec31d9)
 + string-list: remove unused function print_string_list

 Code clean-up.


* sg/split-index-test (2018-09-12) 2 commits
  (merged to 'next' on 2018-09-17 at aed95d1bb5)
 + t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split index
 + t1700-split-index: drop unnecessary 'grep'

 Test updates.


* sg/t3701-tighten-trace (2018-09-11) 1 commit
  (merged to 'next' on 2018-09-17 at a3ed2d4df1)
 + t3701-add-interactive: tighten the check of trace output

 Test update.


* tb/void-check-attr (2018-09-12) 1 commit
  (merged to 'next' on 2018-09-17 at 92f5473ff4)
 + Make git_check_attr() a void function

 Code clean-up.


* tg/range-diff-corner-case-fix (2018-09-14) 1 commit
  (merged to 'next' on 2018-09-17 at b5cf2541e7)
 + linear-assignment: fix potential out of bounds memory access

 Recently added "range-diff" had a corner-case bug to cause it
 segfault, which has been corrected.

--------------------------------------------------
[New Topics]

* fe/doc-updates (2018-09-21) 3 commits
 - git-describe.1: clarify that "human readable" is also git-readable
 - git-column.1: clarify initial description, provide examples
 - git-archimport.1: specify what kind of Arch we're talking about

 Doc updates.

 Will merge to 'next'.


* md/test-cleanup (2018-09-20) 5 commits
 - t9109: don't swallow Git errors upstream of pipes
 - tests: don't swallow Git errors upstream of pipes
 - t/*: fix ordering of expected/observed arguments
 - tests: standardize pipe placement
 - CodingGuidelines: add shell piping guidelines

 Various test scripts have been updated for style and also correct
 handling of exit status of various commands.

 Will merge to 'next'.


* nd/complete-fetch-multiple-args (2018-09-21) 1 commit
 - completion: support "git fetch --multiple"

 Teach bash completion that "git fetch --multiple" only takes remote
 names as arguments and no refspecs.

 Will merge to 'next'.


* jt/fetch-tips-in-partial-clone (2018-09-21) 2 commits
 - fetch: in partial clone, check presence of targets
 - connected: document connectivity in partial clones

 "git fetch $repo $object" in a partial clone did not correctly
 fetch the asked-for object that is referenced by an object in
 promisor packfile, which has been fixed.


* tg/t5551-with-curl-7.61.1 (2018-09-24) 2 commits
 - t5551: compare sorted cookies files
 - t5551: move setup code inside test_expect blocks

 Test update.

 Will merge to 'next'.
 Supersedes tz/t5551-with-curl-7.61.1 topic

--------------------------------------------------
[Stalled]

* bw/submodule-name-to-dir (2018-08-10) 2 commits
 - submodule: munge paths to submodule git directories
 - submodule: create helper to build paths to submodule gitdirs

 In modern repository layout, the real body of a cloned submodule
 repository is held in .git/modules/ of the superproject, indexed by
 the submodule name.  URLencode the submodule name before computing
 the name of the directory to make sure they form a flat namespace.

 Kicked back to 'pu', expecting further work on the topic.
 cf. <CAGZ79kYnbjaPoWdda0SM_-_X77mVyYC7JO61OV8nm2yj3Q1OvQ@mail.gmail.com>


* ng/status-i-short-for-ignored (2018-08-09) 1 commit
 - status: -i shorthand for --ignored command line option

 "git status --ignored" gained a shorthand "git status -i".

 Will discard, after hearing no strong support.
 What's the list opinion on this one?  It is Meh to me, but
 obviously the author cared enough to write a patch, so...


* sb/submodule-move-head-with-corruption (2018-08-28) 2 commits
 - submodule.c: warn about missing submodule git directories
 - t2013: add test for missing but active submodule

 Will discard and wait for a cleaned-up rewrite.
 cf. <20180907195349.GA103699@aiede.svl.corp.google.com>


* sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
 . commit: fix exit code when doing a dry run
 . wt-status: teach wt_status_collect about merges in progress
 . wt-status: rename commitable to committable
 . t7501: add coverage for flags which imply dry runs

 "git commit --dry-run" gave a correct exit status even during a
 conflict resolution toward a merge, but it did not with the
 "--short" option, which has been corrected.

 Seems to break 7512, 3404 and 7060 in 'pu'.


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Will discard and wait for a cleaned-up rewrite.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()
 (this branch is used by tb/bisect-first-parent.)

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


* pb/bisect-helper-2 (2018-07-23) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>

 I just rebased the topic to a newer base as it did not build
 standalone with the base I originally queued the topic on, but
 otherwise there is no update to address any of the review comments
 in the thread above---we are still waiting for a reroll.


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).

--------------------------------------------------
[Cooking]

* jn/gc-auto-prep (2018-07-17) 2 commits
 - gc: exit with status 128 on failure
 - gc: improve handling of errors reading gc.log
 (this branch is used by jn/gc-auto.)

 Code clean-up.

 Will merge to 'next'.


* nd/status-refresh-progress (2018-09-17) 1 commit
 - status: show progress bar if refreshing the index takes too long

 "git status" learns to show progress bar when refreshing the index
 takes a long time.

 Will merge to 'next'.


* nd/the-index (2018-09-21) 23 commits
 - revision.c: reduce implicit dependency the_repository
 - revision.c: remove implicit dependency on the_index
 - ws.c: remove implicit dependency on the_index
 - tree-diff.c: remove implicit dependency on the_index
 - submodule.c: remove implicit dependency on the_index
 - line-range.c: remove implicit dependency on the_index
 - userdiff.c: remove implicit dependency on the_index
 - rerere.c: remove implicit dependency on the_index
 - sha1-file.c: remove implicit dependency on the_index
 - patch-ids.c: remove implicit dependency on the_index
 - merge.c: remove implicit dependency on the_index
 - merge-blobs.c: remove implicit dependency on the_index
 - ll-merge.c: remove implicit dependency on the_index
 - diff-lib.c: remove implicit dependency on the_index
 - read-cache.c: remove implicit dependency on the_index
 - diff.c: remove implicit dependency on the_index
 - grep.c: remove implicit dependency on the_index
 - diff.c: remove the_index dependency in textconv() functions
 - blame.c: rename "repo" argument to "r"
 - combine-diff.c: remove implicit dependency on the_index
 - diff.c: reduce implicit dependency on the_index
 - read-cache.c: remove 'const' from index_has_changes()
 - archive.c: remove implicit dependency the_repository

 Various codepaths in the core-ish part learn to work on an
 arbitrary in-core index structure, not necessarily the default
 instance "the_index".

 Will merge to 'next'.


* tq/refs-internal-comment-fix (2018-09-17) 1 commit
 - refs: docstring typo

 Fix for typo in a sample code in comment.

 Will merge to 'next'.


* ts/alias-of-alias (2018-09-17) 3 commits
 - t0014: introduce an alias testing suite
 - alias: show the call history when an alias is looping
 - alias: add support for aliases of an alias

 An alias that expands to another alias has so far been forbidden,
 but now it is allowed to create such an alias.

 Will merge to 'next'.


* ds/reachable-topo-order (2018-09-21) 7 commits
 - revision.c: refactor basic topo-order logic
 - revision.h: add whitespace in flag definitions
 - commit/revisions: bookkeeping before refactoring
 - revision.c: begin refactoring --topo-order logic
 - test-reach: add rev-list tests
 - test-reach: add run_three_modes method
 - prio-queue: add 'peek' operation

 The revision walker machinery learned to take advantage of the
 commit generation numbers stored in the commit-graph file.


* en/merge-cleanup (2018-09-20) 4 commits
 - merge-recursive: rename merge_file_1() and merge_content()
 - merge-recursive: remove final remaining caller of merge_file_one()
 - merge-recursive: avoid wrapper function when unnecessary and wasteful
 - merge-recursive: set paths correctly when three-way merging content

 Code clean-up.

 Will merge to 'next'.


* jk/delta-islands-with-bitmap-reuse-delta-fix (2018-09-19) 1 commit
 - pack-objects: handle island check for "external" delta base

 Fix interactions between two recent topics.

 Will merge to 'next'.


* jn/mailmap-update (2018-09-19) 1 commit
 - mailmap: consistently normalize brian m. carlson's name

 The mailmap file update.

 Will merge to 'next'.


* ma/config-doc-update (2018-09-20) 2 commits
 - git-config.txt: fix 'see: above' note
 - Doc: use `--type=bool` instead of `--bool`

 Doc update.

 Will merge to 'next'.


* rj/header-check (2018-09-20) 8 commits
 - delta-islands.h: add missing forward declarations (hdr-check)
 - midx.h: add missing forward declarations (hdr-check)
 - refs/refs-internal.h: add missing declarations (hdr-check)
 - refs/packed-backend.h: add missing declaration (hdr-check)
 - refs/ref-cache.h: add missing declarations (hdr-check)
 - ewah/ewok_rlw.h: add missing include (hdr-check)
 - json-writer.h: add missing include (hdr-check)
 - Makefile: add a hdr-check target

 Header files clean-up.

 Will merge to 'next'.


* ab/fsck-skiplist (2018-09-12) 10 commits
  (merged to 'next' on 2018-09-24 at 26adeb8b8f)
 + fsck: support comments & empty lines in skipList
 + fsck: use oidset instead of oid_array for skipList
 + fsck: use strbuf_getline() to read skiplist file
 + fsck: add a performance test for skipList
 + fsck: add a performance test
 + fsck: document that skipList input must be unabbreviated
 + fsck: document and test commented & empty line skipList input
 + fsck: document and test sorted skipList input
 + fsck tests: add a test for no skipList input
 + fsck tests: setup of bogus commit object

 (Originally merged to 'next' on 2018-09-17 at dc9094ba9b)

 Update fsck.skipList implementation and documentation.

 Will merge to 'master'.


* bc/hash-independent-tests (2018-09-17) 11 commits
  (merged to 'next' on 2018-09-24 at 7c4a61fe46)
 + t5318: use test_oid for HASH_LEN
 + t1407: make hash size independent
 + t1406: make hash-size independent
 + t1405: make hash size independent
 + t1400: switch hard-coded object ID to variable
 + t1006: make hash size independent
 + t0064: make hash size independent
 + t0002: abstract away SHA-1 specific constants
 + t0000: update tests for SHA-256
 + t0000: use hash translation table
 + t: add test functions to translate hash-related values

 (Originally merged to 'next' on 2018-09-17 at 9e94794d05)


 Various tests have been updated to make it easier to swap the
 hash function used for object identification.

 Will merge to 'master'.


* bp/read-cache-parallel (2018-09-17) 5 commits
 - read-cache: clean up casting and byte decoding
 - read-cache.c: optimize reading index format v4
 - read-cache: load cache entries on worker threads
 - read-cache: load cache extensions on a worker thread
 - eoie: add End of Index Entry (EOIE) extension

 A new extension to the index file has been introduced, which allows
 the file to be read in parallel.

 Expecting a reroll.
 cf. <78f62979-18a7-2fc1-6f26-c4f84e19424f@gmail.com>


* ds/coverage-diff (2018-09-12) 1 commit
 - contrib: add coverage-diff script

 The result of coverage test can be combined with "git blame" to
 check the test coverage of code introduced recently with a new
 'coverage-diff' tool (in contrib/).

 Expecting a reroll.


* ds/multi-pack-verify (2018-09-17) 11 commits
  (merged to 'next' on 2018-09-24 at f294a34aaf)
 + fsck: verify multi-pack-index
 + multi-pack-index: report progress during 'verify'
 + multi-pack-index: verify object offsets
 + multi-pack-index: fix 32-bit vs 64-bit size check
 + multi-pack-index: verify oid lookup order
 + multi-pack-index: verify oid fanout order
 + multi-pack-index: verify missing pack
 + multi-pack-index: verify packname order
 + multi-pack-index: verify corrupt chunk lookup table
 + multi-pack-index: verify bad header
 + multi-pack-index: add 'verify' verb

 (Originally merged to 'next' on 2018-09-17 at f27244f302)

 "git multi-pack-index" learned to detect corruption in the .midx
 file it uses, and this feature has been integrated into "git fsck".

 Will merge to 'master'.


* nd/config-split (2018-09-12) 11 commits
  (merged to 'next' on 2018-09-24 at 150cb40d2c)
 + config.txt: move submodule part out to a separate file
 + config.txt: move sequence.editor out of "core" part
 + config.txt: move sendemail part out to a separate file
 + config.txt: move receive part out to a separate file
 + config.txt: move push part out to a separate file
 + config.txt: move pull part out to a separate file
 + config.txt: move gui part out to a separate file
 + config.txt: move gitcvs part out to a separate file
 + config.txt: move format part out to a separate file
 + config.txt: move fetch part out to a separate file
 + config.txt: follow camelCase naming

 (Originally merged to 'next' on 2018-09-17 at 33e6cb8f48)

 Split Documentation/config.txt for easier maintenance.

 Will merge to 'master'.


* sb/submodule-recursive-fetch-gets-the-tip (2018-09-12) 9 commits
 - builtin/fetch: check for submodule updates for non branch fetches
 - fetch: retry fetching submodules if sha1 were not fetched
 - submodule: fetch in submodules git directory instead of in worktree
 - submodule.c: do not copy around submodule list
 - submodule: move global changed_submodule_names into fetch submodule struct
 - submodule.c: sort changed_submodule_names before searching it
 - submodule.c: fix indentation
 - sha1-array: provide oid_array_filter
 - string-list: add string_list_{pop, last} functions

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 Expecting a reroll.
 cf. <CAGZ79kbavjVbTqXsmtjW6=jhkq47_p3mc6=92xOp4_mfhqDtvw@mail.gmail.com>
 cf. <b16af8c0-0435-0de4-ed6c-53888d6190af@ramsayjones.plus.com>
 cf. <CAGZ79kZKKf9N8yx9EuCRZhrZS_mA2218PouEG7aHDhK2bJGEdA@mail.gmail.com>


* bp/rename-test-env-var (2018-09-20) 6 commits
 - t0000: do not get self-test disrupted by environment warnings
 - preload-index: update GIT_FORCE_PRELOAD_TEST support
 - read-cache: update TEST_GIT_INDEX_VERSION support
 - fsmonitor: update GIT_TEST_FSMONITOR support
 - preload-index: use git_env_bool() not getenv() for customization
 - t/README: correct spelling of "uncommon"

 Some environment variables that control the runtime options of Git
 used during tests are getting renamed for consistency.

 Waiting for review of the fix-up at the tip.


* ab/commit-graph-progress (2018-09-20) 3 commits
  (merged to 'next' on 2018-09-24 at 76f2f5c1e3)
 + gc: fix regression in 7b0f229222 impacting --quiet
 + commit-graph verify: add progress output
 + commit-graph write: add progress output

 (Originally merged to 'next' on 2018-09-20 at 24ca94b1d4)

 Generation of (expermental) commit-graph files have so far been
 fairly silent, even though it takes noticeable amount of time in a
 meaningfully large repository.  The users will now see progress
 output.


* nd/test-tool (2018-09-11) 6 commits
  (merged to 'next' on 2018-09-24 at 23ad767573)
 + Makefile: add a hint about TEST_BUILTINS_OBJS
 + t/helper: merge test-dump-fsmonitor into test-tool
 + t/helper: merge test-parse-options into test-tool
 + t/helper: merge test-pkt-line into test-tool
 + t/helper: merge test-dump-untracked-cache into test-tool
 + t/helper: keep test-tool command list sorted

 (Originally merged to 'next' on 2018-09-17 at decbf86eeb)


 Test helper binaries clean-up.

 Will merge to 'master'.


* ss/wt-status-committable (2018-09-07) 4 commits
 - wt-status.c: set the committable flag in the collect phase
 - t7501: add test of "commit --dry-run --short"
 - wt-status: rename commitable to committable
 - wt-status.c: move has_unmerged earlier in the file
 (this branch is used by jc/wt-status-state-cleanup.)

 Code clean-up in the internal machinery used by "git status" and
 "git commit --dry-run".

 Will merge to 'next'.


* jc/wt-status-state-cleanup (2018-09-07) 1 commit
 - WIP: roll wt_status_state into wt_status and populate in the collect phase
 (this branch uses ss/wt-status-committable.)


* ds/format-commit-graph-docs (2018-08-21) 2 commits
 - commit-graph.txt: improve formatting for asciidoc
 - Docs: Add commit-graph tech docs to Makefile

 Design docs for the commit-graph machinery is now made into HTML as
 well as text.

 Will discard.
 I am inclined to drop these, as I do not see much clarity in HTML
 output over the text source.  Opinions?


* js/rebase-in-c-5.5-work-with-rebase-i-in-c (2018-09-06) 2 commits
 - builtin rebase: prepare for builtin rebase -i
 - Merge branch 'ag/rebase-i-in-c' into js/rebase-in-c-5.5-work-with-rebase-i-in-c
 (this branch is used by pk/rebase-in-c-6-final; uses ag/rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test.)

 "rebase" that has been rewritten learns the new calling convention
 used by "rebase -i" that was rewritten in C, tying the loose end
 between two GSoC topics that stomped on each other's toes.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ao/submodule-wo-gitmodules-checked-out (2018-09-17) 9 commits
 - submodule: support reading .gitmodules when it's not in the working tree
 - submodule: add a helper to check if it is safe to write to .gitmodules
 - t7506: clean up .gitmodules properly before setting up new scenario
 - submodule: use the 'submodule--helper config' command
 - submodule--helper: add a new 'config' subcommand
 - t7411: be nicer to future tests and really clean things up
 - t7411: merge tests 5 and 6
 - submodule: factor out a config_set_in_gitmodules_file_gently function
 - submodule: add a print_config_from_gitmodules() helper

 The submodule support has been updated to read from the blob at
 HEAD:.gitmodules when the .gitmodules file is missing from the
 working tree.

 Object-store access needs to be protected from multi-threading.
 cf. <20180918171257.GC27036@localhost>
 cf. <20180920173552.6109014827a062dcf3821632@ao2.it>


* md/filter-trees (2018-09-24) 8 commits
 - list-objects-filter: implement filter tree:0
 - list-objects-filter-options: do not over-strbuf_init
 - list-objects-filter: use BUG rather than die
 - revision: mark non-user-given objects instead
 - rev-list: handle missing tree objects properly
 - list-objects: always parse trees gently
 - list-objects: refactor to process_tree_contents
 - list-objects: store common func args in struct

 The "rev-list --filter" feature learned to exclude all trees via
 "tree:0" filter.

 Ejected from 'next' to be replaced with newer version.


* pk/rebase-in-c-2-basic (2018-09-06) 11 commits
 - builtin rebase: support `git rebase <upstream> <switch-to>`
 - builtin rebase: only store fully-qualified refs in `options.head_name`
 - builtin rebase: start a new rebase only if none is in progress
 - builtin rebase: support --force-rebase
 - builtin rebase: try to fast forward when possible
 - builtin rebase: require a clean worktree
 - builtin rebase: support the `verbose` and `diffstat` options
 - builtin rebase: support --quiet
 - builtin rebase: handle the pre-rebase hook and --no-verify
 - builtin rebase: support `git rebase --onto A...B`
 - builtin rebase: support --onto
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c.)


* pk/rebase-in-c-3-acts (2018-09-06) 7 commits
 - builtin rebase: stop if `git am` is in progress
 - builtin rebase: actions require a rebase in progress
 - builtin rebase: support --edit-todo and --show-current-patch
 - builtin rebase: support --quit
 - builtin rebase: support --abort
 - builtin rebase: support --skip
 - builtin rebase: support --continue
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c and pk/rebase-in-c-2-basic.)


* pk/rebase-in-c-4-opts (2018-09-06) 18 commits
 - builtin rebase: support --root
 - builtin rebase: add support for custom merge strategies
 - builtin rebase: support `fork-point` option
 - merge-base --fork-point: extract libified function
 - builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
 - builtin rebase: support `--allow-empty-message` option
 - builtin rebase: support `--exec`
 - builtin rebase: support `--autostash` option
 - builtin rebase: support `-C` and `--whitespace=<type>`
 - builtin rebase: support `--gpg-sign` option
 - builtin rebase: support `--autosquash`
 - builtin rebase: support `keep-empty` option
 - builtin rebase: support `ignore-date` option
 - builtin rebase: support `ignore-whitespace` option
 - builtin rebase: support --committer-date-is-author-date
 - builtin rebase: support --rerere-autoupdate
 - builtin rebase: support --signoff
 - builtin rebase: allow selecting the rebase "backend"
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic and pk/rebase-in-c-3-acts.)


* pk/rebase-in-c-5-test (2018-09-06) 6 commits
 - builtin rebase: error out on incompatible option/mode combinations
 - builtin rebase: use no-op editor when interactive is "implied"
 - builtin rebase: show progress when connected to a terminal
 - builtin rebase: fast-forward to onto if it is a proper descendant
 - builtin rebase: optionally pass custom reflogs to reset_head()
 - builtin rebase: optionally auto-detect the upstream
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts and pk/rebase-in-c-4-opts.)


* pk/rebase-in-c-6-final (2018-09-06) 1 commit
 - rebase: default to using the builtin rebase
 (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test.)


* ps/stash-in-c (2018-08-31) 20 commits
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert `stash--helper.c` into `stash.c`
 - stash: convert save to builtin
 - stash: make push -q quiet
 - stash: convert push to builtin
 - stash: convert create to builtin
 - stash: convert store to builtin
 - stash: mention options in `show` synopsis
 - stash: convert show to builtin
 - stash: convert list to builtin
 - stash: convert pop to builtin
 - stash: convert branch to builtin
 - stash: convert drop and clear to builtin
 - stash: convert apply to builtin
 - stash: add tests for `git stash show` config
 - stash: rename test cases to be more descriptive
 - stash: update test cases conform to coding guidelines
 - stash: improve option parsing test coverage
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will hold.
 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.


* ds/commit-graph-with-grafts (2018-08-21) 8 commits
 - commit-graph: close_commit_graph before shallow walk
 - commit-graph: not compatible with uninitialized repo
 - commit-graph: not compatible with grafts
 - commit-graph: not compatible with replace objects
 - test-repository: properly init repo
 - commit-graph: update design document
 - refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
 - refs.c: migrate internal ref iteration to pass thru repository argument

 The recently introduced commit-graph auxiliary data is incompatible
 with mechanisms such as replace & grafts that "breaks" immutable
 nature of the object reference relationship.  Disable optimizations
 based on its use (and updating existing commit-graph) when these
 incompatible features are in use in the repository.

 Will merge to 'next'.


* jn/gc-auto (2018-07-17) 1 commit
 - gc: do not return error for prior errors in daemonized mode
 (this branch uses jn/gc-auto-prep.)

 "gc --auto" ended up calling exit(-1) upon error, which has been
 corrected to use exit(1).  Also the error reporting behaviour when
 daemonized has been updated to exit with zero status when stopping
 due to a previously discovered error (which implies there is no
 point running gc to improve the situation); we used to exit with
 failure in such a case.

 cf. <20180917182639.GB140909@aiede.svl.corp.google.com>


* ag/rebase-i-in-c (2018-08-29) 20 commits
 - rebase -i: move rebase--helper modes to rebase--interactive
 - rebase -i: remove git-rebase--interactive.sh
 - rebase--interactive2: rewrite the submodes of interactive rebase in C
 - rebase -i: implement the main part of interactive rebase as a builtin
 - rebase -i: rewrite init_basic_state() in C
 - rebase -i: rewrite write_basic_state() in C
 - rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
 - rebase -i: implement the logic to initialize $revisions in C
 - rebase -i: remove unused modes and functions
 - rebase -i: rewrite complete_action() in C
 - t3404: todo list with commented-out commands only aborts
 - sequencer: change the way skip_unnecessary_picks() returns its result
 - sequencer: refactor append_todo_help() to write its message to a buffer
 - rebase -i: rewrite checkout_onto() in C
 - rebase -i: rewrite setup_reflog_action() in C
 - sequencer: add a new function to silence a command, except if it fails
 - rebase -i: rewrite the edit-todo functionality in C
 - editor: add a function to launch the sequence editor
 - rebase -i: rewrite append_todo_help() in C
 - sequencer: make three functions and an enum from sequencer.c public
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Rewrite of the remaining "rebase -i" machinery in C.


* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.


* pk/rebase-in-c (2018-08-06) 3 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin
 (this branch is used by js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 Rewrite of the "rebase" machinery in C.

--------------------------------------------------
[Discarded]

* tz/t5551-with-curl-7.61.1 (2018-09-17) 1 commit
 . t5551-http-fetch-smart.sh: sort cookies before comparing

 Test fix.

 Discarded to be replaced with tg/t5551-with-curl-7.61.1 topic.
