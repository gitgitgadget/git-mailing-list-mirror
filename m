Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F2A1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 23:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeHCA4C (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 20:56:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeHCA4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 20:56:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so3682803wro.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=mVVILhEFPBN6KUbwLWPiyR1yf71D/oLj1EcJmFWqGwo=;
        b=vY3ep3ZNm/z7PbesA1Y0LbhITJ3BExt2Om/9eZw8ZlWcIwL5ZVP2NuSiOS0zgybGm2
         rH0kED+KUo4wg+CHPJrplojtMNRAQBHllf7KrSSCGppHHiwMq213CeJMB1C/n2/hDCO5
         fI7n/22oCjBYUH5Y7TcQqYzENivoj6NCx+TfNONW6e0MnxR8vSijOKYHr+kKhvjwiU+w
         xVeIfV8VF++J8jfcE6WSmE1Xjr04I1WjsbG1DuuKo5pa1FTjzzZU8jLWsNenuRJF/TvH
         emAOf1kVZd+dvvIyZS/TdSKOUf7cETPjggw/eCPXmWfmUi7Ba2G83KAhCziacKXQiHhV
         SUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=mVVILhEFPBN6KUbwLWPiyR1yf71D/oLj1EcJmFWqGwo=;
        b=fWG3D9CMGrqU1FIUQlyHwF/pEScFGwsN6PwV3VZ91HXh53XJDWrOwFoCawHRUqsIeW
         FcQdTgwLFpuLw1fRnTmsY+HZEYM5HASVcMzPDUYbf1oiiBJgco1jYvQJeMjG3gIZCdW2
         hrmJRi2iCONz6GiYMuTD1PyyiG14jmRzoGbCY7RfboI20b079M0UyihViGfW32m7Hzbm
         3rWlpCcumOe8crN6BD3RpOZcBUJjy2Rxj2mtFUUWRTDd0AYbnAZh88ah51qRmREkDEva
         8VMxFwUzWoOIPBlTG1GFCkcQ0iYFiLqLfqp8mk9nn9kTjv38qOMwUajErS3VRkyGNIHk
         b0wA==
X-Gm-Message-State: AOUpUlEFsG8DB4eO3ZR7bqkgCW22ODEiNOObRw3zB5tPVkQM7tpLxFfC
        Bf2MJDhXFSTm8TE6aXtBv9287JflEuT0lA==
X-Google-Smtp-Source: AAOMgpdqXwvUBC2SEUE2S2vCb5zQRNH0lIX+s36bPmur6BcgUfkk7/muQAKc2Bw2nZGL6pVnGbwK0A==
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr896671wrh.267.1533250957751;
        Thu, 02 Aug 2018 16:02:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n7-v6sm4008530wmc.2.2018.08.02.16.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 16:02:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2018, #01; Thu, 2)
X-master-at: 1d89318c48d233d52f1db230cf622935ac3c69fa
X-next-at: f7a957e2e7d6c0922e75e5f5e5e1a0bb01cfe2bb
Date:   Thu, 02 Aug 2018 16:02:36 -0700
Message-ID: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
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

Many topics have moved to 'master' and 'next' from 'next' to 'pu'
respectively.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/checkout-default-remote (2018-06-11) 8 commits
  (merged to 'next' on 2018-07-24 at 6ef645f485)
 + checkout & worktree: introduce checkout.defaultRemote
 + checkout: add advice for ambiguous "checkout <branch>"
 + builtin/checkout.c: use "ret" variable for return
 + checkout: pass the "num_matches" up to callers
 + checkout.c: change "unique" member to "num_matches"
 + checkout.c: introduce an *_INIT macro
 + checkout.h: wrap the arguments to unique_tracking_name()
 + checkout tests: index should be clean after dwim checkout
 (this branch is used by ab/test-must-be-empty.)

 "git checkout" and "git worktree add" learned to honor
 checkout.defaultRemote when auto-vivifying a local branch out of a
 remote tracking branch in a repository with multiple remotes that
 have tracking branches that share the same names.


* bc/object-id (2018-07-16) 16 commits
  (merged to 'next' on 2018-07-24 at 23680778a9)
 + pretty: switch hard-coded constants to the_hash_algo
 + sha1-file: convert constants to uses of the_hash_algo
 + log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
 + diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
 + builtin/merge-recursive: make hash independent
 + builtin/merge: switch to use the_hash_algo
 + builtin/fmt-merge-msg: make hash independent
 + builtin/update-index: simplify parsing of cacheinfo
 + builtin/update-index: convert to using the_hash_algo
 + refs/files-backend: use the_hash_algo for writing refs
 + sha1-name: use the_hash_algo when parsing object names
 + strbuf: allocate space with GIT_MAX_HEXSZ
 + commit: express tree entry constants in terms of the_hash_algo
 + hex: switch to using the_hash_algo
 + tree-walk: replace hard-coded constants with the_hash_algo
 + cache: update object ID functions for the_hash_algo

 Conversion from uchar[40] to struct object_id continues.


* bc/sequencer-export-work-tree-as-well (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-24 at 0b83ade721)
 + sequencer: pass absolute GIT_WORK_TREE to exec commands

 "git rebase" started exporting GIT_DIR environment variable and
 exposing it to hook scripts when part of it got rewritten in C.
 Instead of matching the old scripted Porcelains' behaviour,
 compensate by also exporting GIT_WORK_TREE environment as well to
 lessen the damage.  This can harm existing hooks that want to
 operate on different repository, but the current behaviour is
 already broken for them anyway.


* bp/test-drop-caches-for-windows (2018-07-12) 1 commit
  (merged to 'next' on 2018-07-24 at 257bb336c6)
 + handle lower case drive letters on Windows

 A test helper update for Windows.


* ds/commit-graph-fsck (2018-07-16) 23 commits
  (merged to 'next' on 2018-07-24 at 6a802adc7a)
 + coccinelle: update commit.cocci
 + commit-graph: update design document
 + gc: automatically write commit-graph files
 + commit-graph: add '--reachable' option
 + commit-graph: use string-list API for input
 + fsck: verify commit-graph
 + commit-graph: verify contents match checksum
 + commit-graph: test for corrupted octopus edge
 + commit-graph: verify commit date
 + commit-graph: verify generation number
 + commit-graph: verify parent list
 + commit-graph: verify root tree OIDs
 + commit-graph: verify objects exist
 + commit-graph: verify corrupt OID fanout and lookup
 + commit-graph: verify required chunks are present
 + commit-graph: verify catches corrupt signature
 + commit-graph: add 'verify' subcommand
 + commit-graph: load a root tree from specific graph
 + commit: force commit to parse from object database
 + commit-graph: parse commit from chosen graph
 + commit-graph: fix GRAPH_MIN_SIZE
 + commit-graph: UNLEAK before die()
 + t5318-commit-graph.sh: use core.commitGraph
 (this branch is used by ds/commit-graph-with-grafts, ds/reachable and jt/commit-graph-per-object-store.)

 "git fsck" learns to make sure the optional commit-graph file is in
 a sane state.


* en/dirty-merge-fixes (2018-07-11) 9 commits
  (merged to 'next' on 2018-07-24 at 7b6ca3507c)
 + merge: fix misleading pre-merge check documentation
 + merge-recursive: enforce rule that index matches head before merging
 + t6044: add more testcases with staged changes before a merge is invoked
 + merge-recursive: fix assumption that head tree being merged is HEAD
 + merge-recursive: make sure when we say we abort that we actually abort
 + t6044: add a testcase for index matching head, when head doesn't match HEAD
 + t6044: verify that merges expected to abort actually abort
 + index_has_changes(): avoid assuming operating on the_index
 + read-cache.c: move index_has_changes() from merge.c

 The recursive merge strategy did not properly ensure there was no
 change between HEAD and the index before performing its operation,
 which has been corrected.


* en/t6036-merge-recursive-tests (2018-07-11) 6 commits
  (merged to 'next' on 2018-07-24 at 75055cb6e1)
 + t6036: add a failed conflict detection case: regular files, different modes
 + t6036: add a failed conflict detection case with conflicting types
 + t6036: add a failed conflict detection case with submodule add/add
 + t6036: add a failed conflict detection case with submodule modify/modify
 + t6036: add a failed conflict detection case with symlink add/add
 + t6036: add a failed conflict detection case with symlink modify/modify

 Tests to cover various conflicting cases have been added for
 merge-recursive.


* en/t6036-recursive-corner-cases (2018-07-12) 2 commits
  (merged to 'next' on 2018-07-24 at b7b3514ef4)
 + t6036: fix broken && chain in sub-shell
 + t6036: add lots of detail for directory/file conflicts in recursive case

 Tests to cover more D/F conflict cases have been added for
 merge-recursive.


* en/t6042-insane-merge-rename-testcases (2018-07-03) 3 commits
  (merged to 'next' on 2018-07-24 at 65c80f72da)
 + t6042: add testcase covering long chains of rename conflicts
 + t6042: add testcase covering rename/rename(2to1)/delete/delete conflict
 + t6042: add testcase covering rename/add/delete conflict type

 Various glitches in the heuristics of merge-recursive strategy have
 been documented in new tests.

 I am not sure if there is a single "correct" answer everybody can
 agree on for each of these "insane" cases, though.


* en/t7405-recursive-submodule-conflicts (2018-07-11) 3 commits
  (merged to 'next' on 2018-07-24 at 6cb7d02298)
 + t7405: verify 'merge --abort' works after submodule/path conflicts
 + t7405: add a directory/submodule conflict
 + t7405: add a file/submodule conflict

 Tests to cover conflict cases that involve submodules have been
 added for merge-recursive.


* es/chain-lint-in-subshell (2018-07-31) 11 commits
  (merged to 'next' on 2018-07-31 at 4ce2a8faa4)
 + t/chainlint.sed: drop extra spaces from regex character class
  (merged to 'next' on 2018-07-24 at 9370bbdfaf)
 + t/chainlint: add chainlint "specialized" test cases
 + t/chainlint: add chainlint "complex" test cases
 + t/chainlint: add chainlint "cuddled" test cases
 + t/chainlint: add chainlint "loop" and "conditional" test cases
 + t/chainlint: add chainlint "nested subshell" test cases
 + t/chainlint: add chainlint "one-liner" test cases
 + t/chainlint: add chainlint "whitespace" test cases
 + t/chainlint: add chainlint "basic" test cases
 + t/Makefile: add machinery to check correctness of chainlint.sed
 + t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
 (this branch uses es/test-fixes.)

 Look for broken "&&" chains that are hidden in subshell, many of
 which have been found and corrected.


* es/test-fixes (2018-07-17) 26 commits
  (merged to 'next' on 2018-07-24 at fd6796a3ef)
 + t5608: fix broken &&-chain
 + t9119: fix broken &&-chains
 + t9000-t9999: fix broken &&-chains
 + t7000-t7999: fix broken &&-chains
 + t6000-t6999: fix broken &&-chains
 + t5000-t5999: fix broken &&-chains
 + t4000-t4999: fix broken &&-chains
 + t3030: fix broken &&-chains
 + t3000-t3999: fix broken &&-chains
 + t2000-t2999: fix broken &&-chains
 + t1000-t1999: fix broken &&-chains
 + t0000-t0999: fix broken &&-chains
 + t9814: simplify convoluted check that command correctly errors out
 + t9001: fix broken "invoke hook" test
 + t7810: use test_expect_code() instead of hand-rolled comparison
 + t7400: fix broken "submodule add/reconfigure --force" test
 + t7201: drop pointless "exit 0" at end of subshell
 + t6036: fix broken "merge fails but has appropriate contents" tests
 + t5505: modernize and simplify hard-to-digest test
 + t5406: use write_script() instead of birthing shell script manually
 + t5405: use test_must_fail() instead of checking exit code manually
 + t/lib-submodule-update: fix "absorbing" test
 + t: drop unnecessary terminating semicolon in subshell
 + t: use sane_unset() rather than 'unset' with broken &&-chain
 + t: use test_write_lines() instead of series of 'echo' commands
 + t: use test_might_fail() instead of manipulating exit code manually
 (this branch is used by es/chain-lint-in-subshell.)

 Test clean-up and corrections.


* is/parsing-line-range (2018-06-15) 2 commits
  (merged to 'next' on 2018-07-24 at a06b453f32)
 + log: prevent error if line range ends past end of file
 + blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.


* jk/fsck-gitmodules-gently (2018-07-16) 6 commits
  (merged to 'next' on 2018-07-24 at 5b15c800db)
 + fsck: downgrade gitmodulesParse default to "info"
 + fsck: split ".gitmodules too large" error from parse failure
 + fsck: silence stderr when parsing .gitmodules
 + config: add options parameter to git_config_from_mem
 + config: add CONFIG_ERROR_SILENT handler
 + config: turn die_on_error into caller-facing enum

 Recent "security fix" to pay attention to contents of ".gitmodules"
 while accepting "git push" was a bit overly strict than necessary,
 which has been adjusted.


* jk/has-uncommitted-changes-fix (2018-07-11) 1 commit
  (merged to 'next' on 2018-07-24 at 2ea14c0afb)
 + has_uncommitted_changes(): fall back to empty tree

 "git pull --rebase" on a corrupt HEAD caused a segfault.  In
 general we substitute an empty tree object when running the in-core
 equivalent of the diff-index command, and the codepath has been
 corrected to do so as well to fix this issue.


* jm/cache-entry-from-mem-pool (2018-07-03) 8 commits
  (merged to 'next' on 2018-07-24 at 9be51a88dc)
 + block alloc: add validations around cache_entry lifecyle
 + block alloc: allocate cache entries from mem_pool
 + mem-pool: fill out functionality
 + mem-pool: add life cycle management functions
 + mem-pool: only search head block for available space
 + block alloc: add lifecycle APIs for cache_entry structs
 + read-cache: teach make_cache_entry to take object_id
 + read-cache: teach refresh_cache_entry to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 This makes each cache-entry larger by either 4 or 8 bytes, which is
 a bit sad, though.


* jm/send-email-tls-auth-on-batch (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-24 at fb3e653f44)
 + send-email: fix tls AUTH when sending batch

 "git send-email" when using in a batched mode that limits the
 number of messages sent in a single SMTP session lost the contents
 of the variable used to choose between tls/ssl, unable to send the
 second and later batches, which has been fixed.

 This is marked to be merged to 'next' already, but I do not mind
 getting an updated version with an improved log message before that
 happens.


* js/rebase-merge-octopus (2018-07-11) 3 commits
  (merged to 'next' on 2018-07-24 at 14ad8699de)
 + rebase --rebase-merges: adjust man page for octopus support
 + rebase --rebase-merges: add support for octopus merges
 + merge: allow reading the merge commit message from a file

 "git rebase --rebase-merges" mode now handles octopus merges as
 well.


* jt/commit-graph-per-object-store (2018-07-17) 7 commits
  (merged to 'next' on 2018-07-24 at 090d1a4d59)
 + commit-graph: add repo arg to graph readers
 + commit-graph: store graph in struct object_store
 + commit-graph: add free_commit_graph
 + commit-graph: add missing forward declaration
 + object-store: add missing include
 + commit-graph: refactor preparing commit graph
 + Merge branch 'ds/commit-graph-fsck' into jt/commit-graph-per-object-store
 (this branch is used by ds/commit-graph-with-grafts and ds/reachable; uses ds/commit-graph-fsck and sb/object-store-lookup.)

 The singleton commit-graph in-core instance is made per in-core
 repository instance.


* jt/fetch-nego-tip (2018-07-03) 1 commit
  (merged to 'next' on 2018-07-24 at a9e299006d)
 + fetch-pack: support negotiation tip whitelist
 (this branch is used by ab/fetch-nego; uses jt/fetch-pack-negotiator; is tangled with jt/fetch-negotiator-skipping.)

 "git fetch" learned a new option "--negotiation-tip" to limit the
 set of commits it tells the other end as "have", to reduce wasted
 bandwidth and cycles, which would be helpful when the receiving
 repository has a lot of refs that have little to do with the
 history at the remote it is fetching from.


* jt/fetch-negotiator-skipping (2018-07-16) 1 commit
  (merged to 'next' on 2018-07-24 at 8e25a49405)
 + negotiator/skipping: skip commits during fetch
 (this branch is used by ab/fetch-nego; uses jt/fetch-pack-negotiator; is tangled with jt/fetch-nego-tip.)

 Add a server-side knob to skip commits in exponential/fibbonacci
 stride in an attempt to cover wider swath of history with a smaller
 number of iterations, potentially accepting a larger packfile
 transfer, instead of going back one commit a time during common
 ancestor discovery during the "git fetch" transaction.


* jt/fetch-pack-negotiator (2018-06-15) 7 commits
  (merged to 'next' on 2018-07-24 at 438efcd6b1)
 + fetch-pack: introduce negotiator API
 + fetch-pack: move common check and marking together
 + fetch-pack: make negotiation-related vars local
 + fetch-pack: use ref adv. to prune "have" sent
 + fetch-pack: directly end negotiation if ACK ready
 + fetch-pack: clear marks before re-marking
 + fetch-pack: split up everything_local()
 (this branch is used by ab/fetch-nego, jt/fetch-nego-tip and jt/fetch-negotiator-skipping.)

 Code restructuring and a small fix to transport protocol v2 during
 fetching.


* jt/tags-to-promised-blobs-fix (2018-07-16) 2 commits
  (merged to 'next' on 2018-07-24 at 8d7e78a671)
 + tag: don't warn if target is missing but promised
 + revision: tolerate promised targets of tags

 The lazy clone support had a few places where missing but promised
 objects were not correctly tolerated, which have been fixed.


* kg/gc-auto-windows-workaround (2018-07-09) 1 commit
  (merged to 'next' on 2018-07-24 at 71c05d27b6)
 + gc --auto: release pack files before auto packing

 "git gc --auto" opens file descriptors for the packfiles before
 spawning "git repack/prune", which would upset Windows that does
 not want a process to work on a file that is open by another
 process.  The issue has been worked around.


* sb/diff-color-move-more (2018-07-19) 10 commits
  (merged to 'next' on 2018-07-24 at 89c893cab2)
 + diff.c: offer config option to control ws handling in move detection
 + diff.c: add white space mode to move detection that allows indent changes
 + diff.c: factor advance_or_nullify out of mark_color_as_moved
 + diff.c: decouple white space treatment from move detection algorithm
 + diff.c: add a blocks mode for moved code detection
 + diff.c: adjust hash function signature to match hashmap expectation
 + diff.c: do not pass diff options as keydata to hashmap
 + t4015: avoid git as a pipe input
 + xdiff/xdiffi.c: remove unneeded function declarations
 + xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.


* sb/object-store-lookup (2018-06-29) 33 commits
  (merged to 'next' on 2018-07-24 at dd96e29376)
 + commit.c: allow lookup_commit_reference to handle arbitrary repositories
 + commit.c: allow lookup_commit_reference_gently to handle arbitrary repositories
 + tag.c: allow deref_tag to handle arbitrary repositories
 + object.c: allow parse_object to handle arbitrary repositories
 + object.c: allow parse_object_buffer to handle arbitrary repositories
 + commit.c: allow get_cached_commit_buffer to handle arbitrary repositories
 + commit.c: allow set_commit_buffer to handle arbitrary repositories
 + commit.c: migrate the commit buffer to the parsed object store
 + commit-slabs: remove realloc counter outside of slab struct
 + commit.c: allow parse_commit_buffer to handle arbitrary repositories
 + tag: allow parse_tag_buffer to handle arbitrary repositories
 + tag: allow lookup_tag to handle arbitrary repositories
 + commit: allow lookup_commit to handle arbitrary repositories
 + tree: allow lookup_tree to handle arbitrary repositories
 + blob: allow lookup_blob to handle arbitrary repositories
 + object: allow lookup_object to handle arbitrary repositories
 + object: allow object_as_type to handle arbitrary repositories
 + tag: add repository argument to deref_tag
 + tag: add repository argument to parse_tag_buffer
 + tag: add repository argument to lookup_tag
 + commit: add repository argument to get_cached_commit_buffer
 + commit: add repository argument to set_commit_buffer
 + commit: add repository argument to parse_commit_buffer
 + commit: add repository argument to lookup_commit
 + commit: add repository argument to lookup_commit_reference
 + commit: add repository argument to lookup_commit_reference_gently
 + tree: add repository argument to lookup_tree
 + blob: add repository argument to lookup_blob
 + object: add repository argument to object_as_type
 + object: add repository argument to parse_object_buffer
 + object: add repository argument to lookup_object
 + object: add repository argument to parse_object
 + Merge branch 'sb/object-store-grafts' into sb/object-store-lookup
 (this branch is used by ds/commit-graph-with-grafts, ds/reachable and jt/commit-graph-per-object-store.)

 lookup_commit_reference() and friends have been updated to find
 in-core object for a specific in-core repository instance.


* sg/httpd-test-unflake (2018-07-12) 3 commits
  (merged to 'next' on 2018-07-24 at b7df820256)
 + t/lib-httpd: avoid occasional failures when checking access.log
 + t/lib-httpd: add the strip_access_log() helper function
 + t5541: clean up truncating access log

 httpd tests saw occasional breakage due to the way its access log
 gets inspected by the tests, which has been updated to make them
 less flaky.


* tb/grep-only-matching (2018-07-09) 2 commits
  (merged to 'next' on 2018-07-24 at 7e878b9d95)
 + grep.c: teach 'git grep --only-matching'
 + grep.c: extract show_line_header()

 "git grep" learned the "--only-matching" option.

--------------------------------------------------
[New Topics]

* ab/fsck-transfer-updates (2018-07-27) 10 commits
 - fsck: test and document unknown fsck.<msg-id> values
 - fsck: add stress tests for fsck.skipList
 - fsck: test & document {fetch,receive}.fsck.* config fallback
 - fetch: implement fetch.fsck.*
 - transfer.fsckObjects tests: untangle confusing setup
 - config doc: elaborate on fetch.fsckObjects security
 - config doc: elaborate on what transfer.fsckObjects does
 - config doc: unify the description of fsck.* and receive.fsck.*
 - config doc: don't describe *.fetchObjects twice
 - receive.fsck.<msg-id> tests: remove dead code

 The test performed at the receiving end of "git push" to prevent
 bad objects from entering repository can be customized via
 receive.fsck.* configuration variables; we now have gained a
 counterpart to do the same on the "git fetch" side, with
 fetch.fsck.* configuration variables.

 Will merge to 'next'.


* ab/test-must-be-empty (2018-07-30) 1 commit
 - tests: make use of the test_must_be_empty function

 Test updates.

 Will merge to 'next'.


* ab/test-must-be-empty-for-master (2018-07-30) 1 commit
 - tests: make use of the test_must_be_empty function

 Test updates.

 Did anybody spot incorrect conversion in this yet?


* cb/p4-pre-submit-hook (2018-08-01) 1 commit
 - git-p4: add the `p4-pre-submit` hook

 "git p4 submit" learns to ask its own pre-submit hook if it should
 continue with submitting.

 Will merge to 'next'.


* es/rebase-i-author-script-fix (2018-07-31) 4 commits
 - sequencer: don't die() on bogus user-edited timestamp
 - sequencer: fix "rebase -i --root" corrupting author header timestamp
 - sequencer: fix "rebase -i --root" corrupting author header timezone
 - sequencer: fix "rebase -i --root" corrupting author header
 (this branch is used by pw/rebase-i-author-script-fix.)

 The "author-script" file "git rebase -i" creates got broken when
 we started to move the command away from shell script, which is
 getting fixed now.

 Will merge to 'next'.


* hn/highlight-sideband-keywords (2018-07-31) 1 commit
 - sideband: highlight keywords in remote output

 The sideband code learned to optionally paint selected keywords at
 the beginning of incoming lines on the receiving end.


* jn/subtree-test-fixes (2018-07-30) 2 commits
 - subtree test: simplify preparation of expected results
 - subtree test: add missing && to &&-chain

 Test fix.

 Will merge to 'next'.


* ms/http-proto-doc (2018-07-30) 1 commit
 - doc: fix want-capability separator

 Doc fix.

 Will merge to 'next'.


* nd/pack-objects-threading-doc (2018-07-30) 1 commit
 - pack-objects: document about thread synchronization

 Doc fix.

 Will merge to 'next'.


* sb/indent-heuristic-optim (2018-08-01) 1 commit
 - xdiff: reduce indent heuristic overhead

 "git diff --indent-heuristic" had a bad corner case performance.

 Will merge to 'next'.


* ab/fetch-nego (2018-08-01) 3 commits
 - fetch doc: cross-link two new negotiation options
 - negotiator: unknown fetch.negotiationAlgorithm should error out
 - Merge branch 'jt/fetch-nego-tip' into ab/fetch-nego

 Update to a few other topics.

 Will merge to 'next'.


* ab/fetch-tags-noclobber (2018-07-31) 10 commits
 - fetch: stop clobbering existing tags without --force
 - pull doc: fix a long-standing grammar error
 - fetch tests: add a test clobbering tag behavior
 - fetch tests: correct a comment "remove it" -> "remove them"
 - push doc: correct lies about how push refspecs work
 - push tests: assert re-pushing annotated tags
 - push tests: add more testing for forced tag pushing
 - push tests: fix logic error in "push" test assertion
 - push tests: remove redundant 'git push' invocation
 - fetch tests: change "Tag" test tag to "testTag"

 "git fetch" used to apply the same "fast-forward" rule and allow
 tags to move without "--force" option, which made little sense,
 which has been corrected.

 Expecting a reroll.
 cf. <xmqq4lgfcn5a.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqzhy7b7v9.fsf@gitster-ct.c.googlers.com>


* bp/checkout-new-branch-optim (2018-07-31) 1 commit
 - checkout: optimize "git checkout -b <new_branch>"

 "git checkout -b newbranch [HEAD]" should not have to do as much as
 checking out a commit different from HEAD.  An attempt is made to
 optimize this special case.

 Waiting for review comments to be responded.
 cf. <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>


* es/mw-to-git-chain-fix (2018-07-31) 1 commit
 - mw-to-git/t9360: fix broken &&-chain

 Test fix.

 Will merge to 'next'.


* jk/merge-subtree-heuristics (2018-08-02) 1 commit
 - score_trees(): fix iteration over trees with missing entries

 The automatic tree-matching in "git merge -s subtree" was broken 5
 years ago and nobody has noticed since then, which is now fixed.

 Will merge to 'next'.


* jt/connectivity-check-after-unshallow (2018-08-01) 1 commit
 - fetch-pack: unify ref in and out param

 Recent update to the transport layer broke ref updates after "git
 fetch", which is now fixed.

 Will merge to 'next'.


* jt/refspec-dwim-precedence-fix (2018-08-02) 1 commit
 - remote: make refspec follow the same disambiguation rule as local refs

 "git fetch $there refs/heads/s" ought to fetch the tip of the
 branch 's', but when "refs/heads/refs/heads/s", i.e. a branch whose
 name is "refs/heads/s" exists at the same time, fetched that one
 instead by mistake.  This has been corrected to honor the usual
 disambiguation rules for abbreviated refnames.

 Will merge to 'next'.


* nd/clone-case-smashing-warning (2018-07-31) 1 commit
 - clone: report duplicate entries on case-insensitive filesystems

 Running "git clone" against a project that contain two files with
 pathnames that differ only in cases on a case insensitive
 filesystem would result in one of the files lost because the
 underlying filesystem is incapable of holding both at the same
 time.  An attempt is made to detect such a case and warn.

 Discussion getting petered out.
 Doing this portably and extending it to UTF-8 normalization issue
 HFS+ has would be costly.

 cf. <20180728095659.GA21450@sigill.intra.peff.net>
 cf. <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>


* nd/unpack-trees-with-cache-tree (2018-07-31) 4 commits
 - unpack-trees: cheaper index update when walking by cache-tree
 - unpack-trees: reduce malloc in cache-tree walk
 - unpack-trees: optimize walking same trees with cache-tree
 - unpack-trees.c: add performance tracing

 The unpack_trees() API used in checking out a branch and merging
 walks one or more trees along with the index.  When the cache-tree
 in the index tells us that we are walking a tree whose flattened
 contents is known (i.e. matches a span in the index), as linearly
 scanning a span in the index is much more efficient than having to
 open tree objects recursively and listing their entries, the walk
 can be optimized, which is done in this topic.


* rs/remote-mv-leakfix (2018-08-01) 1 commit
 - remote: clear string_list after use in mv()

 Leakfix.

 Will merge to 'next'.


* sb/config-write-fix (2018-08-01) 3 commits
 - git-config: document accidental multi-line setting in deprecated syntax
 - config: fix case sensitive subsection names on writing
 - t1300: document current behavior of setting options

 Recent update to "git config" broke updating variable in a
 subsection, which has been corrected.

 Not quite?
 cf. <xmqq4lgc1rbv.fsf@gitster-ct.c.googlers.com>


* sb/range-diff-colors (2018-08-01) 9 commits
 - fixup! t3206: add color test for range-diff --dual-color
 - diff.c: rewrite emit_line_0 more understandably
 - diff.c: compute reverse locally in emit_line_0
 - diff: use emit_line_0 once per line
 - diff.c: add set_sign to emit_line_0
 - diff.c: reorder arguments for emit_line_ws_markup
 - diff.c: simplify caller of emit_line_0
 - t3206: add color test for range-diff --dual-color
 - test_decode_color: understand FAINT and ITALIC
 (this branch uses js/range-diff; is tangled with es/format-patch-rangediff.)


* sg/t1404-update-ref-test-timeout (2018-08-01) 1 commit
 - t1404: increase core.packedRefsTimeout to avoid occasional test failure

 An attempt to unflake a test a bit.


* sg/travis-retrieve-trash-upon-failure (2018-08-01) 1 commit
 - travis-ci: include the trash directories of failed tests in the trace log

 The Travis CI scripts were taught to ship back the test data from
 failed tests.

 Will merge to 'next'.


* jt/fetch-follow-fix (2018-08-01) 1 commit
 - fetch-pack: unify ref in and out param

 "git fetch" sometimes failed to update the remote-tracking refs,
 which has been corrected.

 Will merge to 'next'.


* ab/sha1dc (2018-08-02) 1 commit
 - sha1dc: update from upstream

 AIX portability update for SHADC hash, imported from upstream.

 Will merge to 'next'.


* es/want-color-fd-defensive (2018-08-02) 1 commit
 - color: protect against out-of-bounds array access/assignment

 Futureproofing a helper function that can easily misused.

 Will merge to 'next'.


* pw/rebase-i-author-script-fix (2018-08-02) 2 commits
 - sequencer: fix quoting in write_author_script
 - sequencer: handle errors in read_author_ident()
 (this branch uses es/rebase-i-author-script-fix.)

 Recent "git rebase -i" update started to write bogusly formatted
 author-script, with a matching broken reading code.  These are
 being fixed.

 Undecided.
 Is it the list consensus to favor this "with extra code, read the
 script written by bad writer" approach?


* rs/parse-opt-lithelp (2018-08-02) 6 commits
 - parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP
 - shortlog: correct option help for -w
 - send-pack: specify --force-with-lease argument help explicitly
 - pack-objects: specify --index-version argument help explicitly
 - difftool: remove angular brackets from argument help
 - add, update-index: fix --chmod argument help

 The parse-options machinery learned to refrain from enclosing
 placeholder string inside a "<bra" and "ket>" pair automatically
 without PARSE_OPT_LITERAL_ARGHELP.  Existing help text for option
 arguments that are not formatted correctly have been identified and
 fixed.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Will discard and wait for a cleaned-up rewrite.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>

* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


* av/fsmonitor-updates (2018-01-04) 6 commits
 - fsmonitor: use fsmonitor data in `git diff`
 - fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 - dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Waiting for an update.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>


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

* es/diff-color-moved-fix (2018-07-25) 1 commit
  (merged to 'next' on 2018-08-02 at 233bccfbfb)
 + diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"

 One of the "diff --color-moved" mode "dimmed_zebra" that was named
 in an unusual way has been deprecated and replaced by
 "dimmed-zebra".

 Will merge to 'master'.


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will merge to and cook in 'next'.

 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.


* mk/http-backend-content-length (2018-07-30) 4 commits
 - t5562: avoid non-portable "export FOO=bar" construct
 - http-backend: respect CONTENT_LENGTH for receive-pack
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875
 - http-backend: cleanup writing to child process

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Will merge to 'next'.


* ds/commit-graph-with-grafts (2018-07-19) 8 commits
  (merged to 'next' on 2018-08-02 at 0ee624e329)
 + commit-graph: close_commit_graph before shallow walk
 + commit-graph: not compatible with uninitialized repo
 + commit-graph: not compatible with grafts
 + commit-graph: not compatible with replace objects
 + test-repository: properly init repo
 + commit-graph: update design document
 + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
 + refs.c: migrate internal ref iteration to pass thru repository argument

 The recently introduced commit-graph auxiliary data is incompatible
 with mechanisms such as replace & grafts that "breaks" immutable
 nature of the object reference relationship.  Disable optimizations
 based on its use (and updating existing commit-graph) when these
 incompatible features are in use in the repository.

 Will merge to 'master'.


* jk/core-use-replace-refs (2018-07-18) 3 commits
  (merged to 'next' on 2018-08-02 at 90fb6b1056)
 + add core.usereplacerefs config option
 + check_replace_refs: rename to read_replace_refs
 + check_replace_refs: fix outdated comment

 A new configuration variable core.usereplacerefs has been added,
 primarily to help server installations that want to ignore the
 replace mechanism altogether.

 Will merge to 'master'.


* nd/i18n (2018-07-23) 23 commits
  (merged to 'next' on 2018-08-02 at 904a22a5d1)
 + transport-helper.c: mark more strings for translation
 + transport.c: mark more strings for translation
 + sha1-file.c: mark more strings for translation
 + sequencer.c: mark more strings for translation
 + replace-object.c: mark more strings for translation
 + refspec.c: mark more strings for translation
 + refs.c: mark more strings for translation
 + pkt-line.c: mark more strings for translation
 + object.c: mark more strings for translation
 + exec-cmd.c: mark more strings for translation
 + environment.c: mark more strings for translation
 + dir.c: mark more strings for translation
 + convert.c: mark more strings for translation
 + connect.c: mark more strings for translation
 + config.c: mark more strings for translation
 + commit-graph.c: mark more strings for translation
 + builtin/replace.c: mark more strings for translation
 + builtin/pack-objects.c: mark more strings for translation
 + builtin/grep.c: mark strings for translation
 + builtin/config.c: mark more strings for translation
 + archive-zip.c: mark more strings for translation
 + archive-tar.c: mark more strings for translation
 + Update messages in preparation for i18n

 Many more strings are prepared for l10n.

 Will merge to 'master'.


* sb/histogram-less-memory (2018-07-23) 4 commits
  (merged to 'next' on 2018-08-02 at cfb02aa3b5)
 + xdiff/histogram: remove tail recursion
 + xdiff/xhistogram: move index allocation into find_lcs
 + xdiff/xhistogram: factor out memory cleanup into free_index()
 + xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff

 "git diff --histogram" had a bad memory usage pattern, which has
 been rearranged to reduce the peak usage.

 Will merge to 'master'.


* bb/make-developer-pedantic (2018-07-25) 1 commit
  (merged to 'next' on 2018-08-02 at c738a84b7e)
 + Makefile: add a DEVOPTS flag to get pedantic compilation

 "make DEVELOPER=1 DEVOPTS=pedantic" allows developers to compile
 with -pedantic option, which may catch more problematic program
 constructs and potential bugs.

 Will merge to 'master'.


* bw/clone-ref-prefixes (2018-07-20) 1 commit
  (merged to 'next' on 2018-08-02 at c8ad140ab0)
 + clone: send ref-prefixes when using protocol v2

 The wire-protocol v2 relies on the client to send "ref prefixes" to
 limit the bandwidth spent on the initial ref advertisement.  "git
 clone" when learned to speak v2 forgot to do so, which has been
 corrected.

 Will merge to 'master'.


* bw/fetch-pack-i18n (2018-07-23) 1 commit
  (merged to 'next' on 2018-08-02 at df72001755)
 + fetch-pack: mark die strings for translation

 i18n updates.

 Will merge to 'master'.


* bw/protocol-v2 (2018-07-24) 1 commit
  (merged to 'next' on 2018-08-02 at f4076b3e94)
 + pack-protocol: mention and point to docs for protocol v2

 Doc update.

 Will merge to 'master'.


* ds/reachable (2018-07-20) 18 commits
 - commit-reach: use can_all_from_reach
 - commit-reach: make can_all_from_reach... linear
 - commit-reach: replace ref_newer logic
 - test-reach: test commit_contains
 - test-reach: test can_all_from_reach_with_flags
 - test-reach: test reduce_heads
 - test-reach: test get_merge_bases_many
 - test-reach: test is_descendant_of
 - test-reach: test in_merge_bases
 - test-reach: create new test tool for ref_newer
 - commit-reach: move can_all_from_reach_with_flags
 - upload-pack: generalize commit date cutoff
 - upload-pack: refactor ok_to_give_up()
 - upload-pack: make reachable() more generic
 - commit-reach: move commit_contains from ref-filter
 - commit-reach: move ref_newer from remote.c
 - commit.h: remove method declarations
 - commit-reach: move walk methods from commit.c

 The code for computing history reachability has been shuffled,
 obtained a bunch of new tests to cover them, and then being
 improved.

 Will merge to and cook in 'next'.


* en/merge-recursive-skip-fix (2018-07-27) 2 commits
 - merge-recursive: preserve skip_worktree bit when necessary
 - t3507: add a testcase showing failure with sparse checkout

 When the sparse checkout feature is in use, "git cherry-pick" and
 other mergy operations lost the skip_worktree bit when a path that
 is excluded from checkout requires content level merge, which is
 resolved as the same as the HEAD version, without materializing the
 merge result in the working tree, which made the path appear as
 deleted.  This has been corrected by preserving the skip_worktree
 bit (and not materializing the file in the working tree).

 Will merge to 'next'.


* es/format-patch-interdiff (2018-07-23) 6 commits
 - format-patch: allow --interdiff to apply to a lone-patch
 - log-tree: show_log: make commentary block delimiting reusable
 - interdiff: teach show_interdiff() to indent interdiff
 - format-patch: teach --interdiff to respect -v/--reroll-count
 - format-patch: add --interdiff option to embed diff in cover letter
 - format-patch: allow additional generated content in make_cover_letter()
 (this branch is used by es/format-patch-rangediff.)

 "git format-patch" learned a new "--interdiff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Stuck in review?
 cf. <CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com>


* es/format-patch-rangediff (2018-07-30) 10 commits
 - format-patch: allow --range-diff to apply to a lone-patch
 - format-patch: add --creation-factor tweak for --range-diff
 - format-patch: teach --range-diff to respect -v/--reroll-count
 - format-patch: extend --range-diff to accept revision range
 - format-patch: add --range-diff option to embed diff in cover letter
 - range-diff: relieve callers of low-level configuration burden
 - range-diff: publish default creation factor
 - range-diff: respect diff_option.file rather than assuming 'stdout'
 - Merge branch 'es/format-patch-interdiff' into es/format-patch-rangediff
 - Merge branch 'js/range-diff' into es/format-patch-rangediff
 (this branch uses es/format-patch-interdiff and js/range-diff; is tangled with sb/range-diff-colors.)

 "git format-patch" learned a new "--range-diff" option to explain
 the difference between this version and the previous atttempt in
 the cover letter (or after the tree-dashes as a comment).

 Need to wait for the prereq topics to solidify a bit more.


* jk/banned-function (2018-07-26) 5 commits
 - banned.h: mark strncpy() as banned
 - banned.h: mark sprintf() as banned
 - banned.h: mark strcat() as banned
 - automatically ban strcpy()
 - Merge branch 'sb/blame-color' into jk/banned-function

 It is too easy to misuse system API functions such as strcat();
 these selected functions are now forbidden in this codebase and
 will cause a compilation failure.

 Will merge to 'next'.


* jk/size-t (2018-07-24) 6 commits
  (merged to 'next' on 2018-08-02 at 6f861e05f0)
 + strbuf_humanise: use unsigned variables
 + pass st.st_size as hint for strbuf_readlink()
 + strbuf_readlink: use ssize_t
 + strbuf: use size_t for length in intermediate variables
 + reencode_string: use size_t for string lengths
 + reencode_string: use st_add/st_mult helpers

 Code clean-up to use size_t/ssize_t when they are the right type.

 Will merge to 'master'.


* js/t7406-recursive-submodule-update-order-fix (2018-07-23) 1 commit
  (merged to 'next' on 2018-08-02 at 217ea36a37)
 + t7406: avoid failures solely due to timing issues

 Test fix.

 Will merge to 'master'.


* js/vscode (2018-07-30) 9 commits
 - vscode: let cSpell work on commit messages, too
 - vscode: add a dictionary for cSpell
 - vscode: use 8-space tabs, no trailing ws, etc for Git's source code
 - vscode: wrap commit messages at column 72 by default
 - vscode: only overwrite C/C++ settings
 - mingw: define WIN32 explicitly
 - cache.h: extract enum declaration from inside a struct declaration
 - vscode: hard-code a couple defines
 - contrib: add a script to initialize VS Code configuration

 Add a script (in contrib/) to help users of VSCode work better with
 our codebase.

 Will merge to 'next'.


* jt/tag-following-with-proto-v2-fix (2018-07-24) 2 commits
  (merged to 'next' on 2018-08-02 at d9eabdea95)
 + fetch: send "refs/tags/" prefix upon CLI refspecs
 + t5702: test fetch with multiple refspecs at a time

 The wire-protocol v2 relies on the client to send "ref prefixes" to
 limit the bandwidth spent on the initial ref advertisement.  "git
 fetch $remote branch:branch" that asks tags that point into the
 history leading to the "branch" automatically followed sent to
 narrow prefix and broke the tag following, which has been fixed.

 Will merge to 'master'.


* nd/pack-deltify-regression-fix (2018-07-23) 1 commit
  (merged to 'next' on 2018-08-02 at f3b2bf0fef)
 + pack-objects: fix performance issues on packing large deltas

 In a recent update in 2.18 era, "git pack-objects" started
 producing a larger than necessary packfiles by missing
 opportunities to use large deltas.

 Will cook in 'next'.


* sb/trailers-docfix (2018-07-20) 1 commit
  (merged to 'next' on 2018-08-02 at ba348fafcd)
 + Documentation/git-interpret-trailers: explain possible values

 Doc update.

 Will merge to 'master'.


* sg/coccicheck-updates (2018-07-23) 5 commits
  (merged to 'next' on 2018-08-02 at b5548ff3a9)
 + coccinelle: extract dedicated make target to clean Coccinelle's results
 + coccinelle: put sane filenames into output patches
 + coccinelle: exclude sha1dc source files from static analysis
 + coccinelle: use $(addsuffix) in 'coccicheck' make target
 + coccinelle: mark the 'coccicheck' make target as .PHONY

 Update the way we use Coccinelle to find out-of-style code that
 need to be modernised.

 Will merge to 'master'.


* sg/fast-import-dump-refs-on-checkpoint-fix (2018-07-20) 1 commit
  (merged to 'next' on 2018-08-02 at f5c05b5a2c)
 + t9300: wait for background fast-import process to die after killing it

 Test update.

 Will merge to 'master'.


* sg/travis-cocci-diagnose-failure (2018-07-23) 2 commits
  (merged to 'next' on 2018-08-02 at 54808a8778)
 + travis-ci: fail if Coccinelle static analysis found something to transform
 + travis-ci: run Coccinelle static analysis with two parallel jobs

 Update the way we run static analysis tool at TravisCI to make it
 easier to use its findings.

 Will merge to 'master'.


* ab/newhash-is-sha256 (2018-07-26) 2 commits
 - doc hash-function-transition: pick SHA-256 as NewHash
 - doc hash-function-transition: note the lack of a changelog

 Documentation update.

 Will merge to 'next'.


* bb/redecl-enum-fix (2018-07-26) 1 commit
 - packfile: ensure that enum object_type is defined

 Compilation fix.

 Will merge to 'next'.


* jh/structured-logging (2018-07-25) 25 commits
 - structured-logging: add config data facility
 - structured-logging: t0420 tests for interacitve child_summary
 - structured-logging: t0420 tests for child process detail events
 - structured-logging: add child process classification
 - structured-logging: add detail-events for child processes
 - structured-logging: add structured logging to remote-curl
 - structured-logging: t0420 tests for aux-data
 - structured-logging: add aux-data for size of sparse-checkout file
 - structured-logging: add aux-data for index size
 - structured-logging: add aux-data facility
 - structured-logging: t0420 tests for timers
 - structured-logging: add timer around preload_index
 - structured-logging: add timer around wt-status functions
 - structured-logging: add timer around do_write_index
 - structured-logging: add timer around do_read_index
 - structured-logging: add timer facility
 - structured-logging: add detail-event for lazy_init_name_hash
 - structured-logging: add detail-event facility
 - structured-logging: t0420 basic tests
 - structured-logging: set sub_command field for checkout command
 - structured-logging: set sub_command field for branch command
 - structured-logging: add session-id to log events
 - structured-logging: add structured logging framework
 - structured-logging: add STRUCTURED_LOGGING=1 to Makefile
 - structured-logging: design document
 (this branch uses jh/json-writer.)

 Will merge to 'next'.


* en/abort-df-conflict-fixes (2018-07-31) 2 commits
 - read-cache: fix directory/file conflict handling in read_index_unmerged()
 - t1015: demonstrate directory/file conflict recovery failures

 "git merge --abort" etc. did not clean things up properly when
 there were conflicted entries in certain order that are involved
 in D/F conflicts.  This has been corrected.

 Will merge to 'next'.


* hs/gpgsm (2018-07-20) 7 commits
  (merged to 'next' on 2018-08-02 at db28bffe4f)
 + gpg-interface t: extend the existing GPG tests with GPGSM
 + gpg-interface: introduce new signature format "x509" using gpgsm
 + gpg-interface: introduce new config to select per gpg format program
 + gpg-interface: do not hardcode the key string len anymore
 + gpg-interface: introduce an abstraction for multiple gpg formats
 + t/t7510: check the validation of the new config gpg.format
 + gpg-interface: add new config to select how to sign a commit

 Teach "git tag -s" etc. a few configuration varaibles (gpg.format
 that can be set to "openpgp" or "x509", and gpg.<format>.program
 that is used to specify what program to use to deal with the format)
 to allow x.509 certs with CMS via "gpgsm" to be used instead of
 openpgp via "gnupg".

 Will merge to 'master'.


* jn/gc-auto (2018-07-17) 3 commits
 - gc: do not return error for prior errors in daemonized mode
 - gc: exit with status 128 on failure
 - gc: improve handling of errors reading gc.log

 "gc --auto" ended up calling exit(-1) upon error, which has been
 corrected to use exit(1).  Also the error reporting behaviour when
 daemonized has been updated to exit with zero status when stopping
 due to a previously discovered error (which implies there is no
 point running gc to improve the situation); we used to exit with
 failure in such a case.

 Stuck in review?
 cf. <20180717201348.GD26218@sigill.intra.peff.net>


* sb/submodule-update-in-c (2018-07-18) 6 commits
 - submodule--helper: introduce new update-module-mode helper
 - builtin/submodule--helper: factor out method to update a single submodule
 - builtin/submodule--helper: store update_clone information in a struct
 - builtin/submodule--helper: factor out submodule updating
 - git-submodule.sh: rename unused variables
 - git-submodule.sh: align error reporting for update mode to use path

 "git submodule update" is getting rewritten piece-by-piece into C.

 Will merge to 'next'.


* sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
 . commit: fix exit code when doing a dry run
 . wt-status: teach wt_status_collect about merges in progress
 . wt-status: rename commitable to committable
 . t7501: add coverage for flags which imply dry runs

 "git commit --dry-run" gave a correct exit status even during a
 conflict resolution toward a merge, but it did not with the
 "--short" option, which has been corrected.

 Seems to break 7512, 3404 and 7060 in 'pu'.


* tg/rerere (2018-07-16) 11 commits
 - rerere: recalculate conflict ID when unresolved conflict is committed
 - rerere: teach rerere to handle nested conflicts
 - rerere: return strbuf from handle path
 - rerere: factor out handle_conflict function
 - rerere: only return whether a path has conflicts or not
 - rerere: fix crash when conflict goes unresolved
 - rerere: add documentation for conflict normalization
 - rerere: mark strings for translation
 - rerere: wrap paths in output in sq
 - rerere: lowercase error messages
 - rerere: unify error messages when read_cache fails

 Fixes to "git rerere" corner cases, especially when conflict
 markers cannot be parsed in the file.

 I am not sure about the "nested" stuff, though.


* jk/ui-color-always-to-auto (2018-07-18) 1 commit
  (merged to 'next' on 2018-08-02 at 1a054baf0e)
 + Documentation: fix --color option formatting

 Doc formatting fix.

 Will merge to 'master'.


* jh/json-writer (2018-07-16) 1 commit
  (merged to 'next' on 2018-08-02 at d841450c7d)
 + json_writer: new routines to create JSON data
 (this branch is used by jh/structured-logging.)

 Preparatory code to later add json output for telemetry data.

 Will merge to 'master'.


* ag/rebase-i-in-c (2018-07-31) 20 commits
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
 - sequencer: make two functions and an enum from sequencer.c public

 Rewrite of the remaining "rebase -i" machinery in C.

 Will merge to 'next'.


* js/range-diff (2018-07-30) 21 commits
 - range-diff: use dim/bold cues to improve dual color mode
 - range-diff: make --dual-color the default mode
 - range-diff: left-pad patch numbers
 - completion: support `git range-diff`
 - range-diff: populate the man page
 - range-diff --dual-color: fix bogus white-space warning
 - range-diff: offer to dual-color the diffs
 - diff: add an internal option to dual-color diffs of diffs
 - color: add the meta color GIT_COLOR_REVERSE
 - range-diff: use color for the commit pairs
 - range-diff: add tests
 - range-diff: do not show "function names" in hunk headers
 - range-diff: adjust the output of the commit pairs
 - range-diff: suppress the diff headers
 - range-diff: indent the diffs just like tbdiff
 - range-diff: right-trim commit messages
 - range-diff: also show the diff between patches
 - range-diff: improve the order of the shown commits
 - range-diff: first rudimentary implementation
 - Introduce `range-diff` to compare iterations of a topic branch
 - linear-assignment: a function to solve least-cost assignment problems
 (this branch is used by es/format-patch-rangediff and sb/range-diff-colors.)

 "git tbdiff" that lets us compare individual patches in two
 iterations of a topic has been rewritten and made into a built-in
 command.

 It seems there will another hopefully the final reroll coming.
 cf. <nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet>


* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.


* ot/ref-filter-object-info (2018-07-17) 5 commits
 - ref-filter: use oid_object_info() to get object
 - ref-filter: merge get_obj and get_object
 - ref-filter: initialize eaten variable
 - ref-filter: fill empty fields with empty values
 - ref-filter: add info_source to valid_atom

 A few atoms like %(objecttype) and %(objectsize) in the format
 specifier of "for-each-ref --format=<format>" can be filled without
 getting the full contents of the object, but just with the object
 header.  These cases have been optimzied by calling
 oid_object_info() API.

 Will merge to 'next'.


* pk/rebase-in-c (2018-07-30) 3 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin

 Rewrite of the "rebase" machinery in C.

 Will merge to 'next'.


* jk/branch-l-1-repurpose (2018-06-22) 1 commit
 - branch: make "-l" a synonym for "--list"

 Updated plan to repurpose the "-l" option to "git branch".

 Will hold in 'pu' until jk/branch-l-0-deprecation progresses sufficiently.


* cc/remote-odb (2018-08-02) 9 commits
 - Documentation/config: add odb.<name>.promisorRemote
 - t0410: test fetching from many promisor remotes
 - Use odb.origin.partialclonefilter instead of core.partialclonefilter
 - Use remote_odb_get_direct() and has_remote_odb()
 - remote-odb: add remote_odb_reinit()
 - remote-odb: implement remote_odb_get_many_direct()
 - remote-odb: implement remote_odb_get_direct()
 - Add initial remote odb support
 - fetch-object: make functions return an error code

 Implement lazy fetches of missing objects to complement the
 experimental partial clone feature.

 I haven't seen much interest in this topic on list.  What's the
 doneness of this thing?

 I do not particularly mind adding code to support a niche feature
 as long as it is cleanly made and it is clear that the feature
 won't negatively affect those who do not use it, so a review from
 that point of view may also be appropriate.


* ds/multi-pack-index (2018-07-20) 23 commits
 - midx: clear midx on repack
 - packfile: skip loading index if in multi-pack-index
 - midx: prevent duplicate packfile loads
 - midx: use midx in approximate_object_count
 - midx: use existing midx when writing new one
 - midx: use midx in abbreviation calculations
 - midx: read objects from multi-pack-index
 - config: create core.multiPackIndex setting
 - midx: write object offsets
 - midx: write object id fanout chunk
 - midx: write object ids in a chunk
 - midx: sort and deduplicate objects from packfiles
 - midx: read pack names into array
 - multi-pack-index: write pack names in chunk
 - multi-pack-index: read packfile list
 - packfile: generalize pack directory list
 - t5319: expand test data
 - multi-pack-index: load into memory
 - midx: write header information to lockfile
 - multi-pack-index: add 'write' verb
 - multi-pack-index: add builtin
 - multi-pack-index: add format details
 - multi-pack-index: add design document

 When there are too many packfiles in a repository (which is not
 recommended), looking up an object in these would require
 consulting many pack .idx files; a new mechanism to have a single
 file that consolidates all of these .idx files is introduced.

 Will merge to and cook in 'next'.


--------------------------------------------------
[Discarded]

* am/sequencer-author-script-fix (2018-07-18) 1 commit
 . sequencer.c: terminate the last line of author-script properly

 The author-script that records the author information created by
 the sequencer machinery lacked the closing single quote on the last
 entry.

 Superseded by another topic.


* jc/push-cas-opt-comment (2018-08-01) 1 commit
 . push: comment on a funny unbalanced option help

 Code clarification.

 Superseded by another topic.
