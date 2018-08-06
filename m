Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3637C208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbeHGArT (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:47:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43258 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387496AbeHGArS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 20:47:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so13803373wrv.10
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=sv4xJhn3EJudrzAdKP9akPfrH6NS+6ykOy7SmtxEl6c=;
        b=mGUwaKwxI6HvpCG5R4CBNtEMJxGprI1o3EBQv3RF7QkL0EI7InEHOl9oHlf/Ks5inj
         EX8GFXFhIQwynuQ+nT/TtBpzOJPbZl3/yxsu6iZTfzBStvEbSn6G0xn0Yoc1D9MQvxIb
         7+ETygcE8ob7Rn9Nm/HUVV5G52yXg3I8zaJkikY1IBhZGckG/rBKzJuIr/6trsiXwlhF
         H6u/QgXbIS75JwoIk2kQDHeeLGEgfw5ecccKkmupl/hstAK5yz9NUbPxWaJEwDrvhIt9
         CoYEBVzU75xzc7uQJ9sJP+7ickbORk/YXXOgX9dIo+U2Zsm+qwLSmhueXHL4I9qtvLJi
         zDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=sv4xJhn3EJudrzAdKP9akPfrH6NS+6ykOy7SmtxEl6c=;
        b=baj8/1D+srBWZzmEYddZ3p0G+lLfjNiIjviJTfZhJWI5A4t+bnx4cQfbmyOht1eB86
         AziZwQcNutYnwYfj/f50TxwNLNrF/jNUAyn0WBHXA+MRCVBm3cYCxqWjCQXbQd7XHjFr
         yDakqnU7K25E+Kzr/lQSS+DWEO/wheeNMK2goFkhlvnqkoUwChN+nZ8yxSx++LK1aFlp
         0rTXfR6iwlVd6J7GCcc5aHiX2DM2jouZoKKXn2+hu/G7bb09JZwgA2u3M6jkMnAsm1ES
         +6FhyMK4OxKCaGQgTOFPO6pJ1jQR0RS2kT/wrFh4z+gkWzjhNSeh91OQhrJZF2L2vB7y
         +QbA==
X-Gm-Message-State: AOUpUlH1LfxyhIygioZcZzfsWV7tuGQ3ZMklCpQzrbgT7DNFjyl7H21P
        xuVR0wHescCigic0Q/MJJ3mK0LbYniwpvw==
X-Google-Smtp-Source: AAOMgpf02IzOJlsLjJ4Lu/iLfpl/i1ywp7RnF9xhqXmwi6HaLWlUXS8MgjuKpaSp76UDPFfge0W9Uw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5-v6mr11831674wrt.232.1533594961333;
        Mon, 06 Aug 2018 15:36:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x82-v6sm24567101wmd.11.2018.08.06.15.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:36:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2018, #02; Mon, 6)
X-master-at: 1d89318c48d233d52f1db230cf622935ac3c69fa
X-next-at: 1932418f4676b98c810dd5182aeba50bbd7c02d4
Date:   Mon, 06 Aug 2018 15:35:59 -0700
Message-ID: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
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

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* js/rebase-merges-exec-fix (2018-08-06) 2 commits
 - rebase --exec: make it work with --rebase-merges
 - t3430: demonstrate what -r, --autosquash & --exec should do

 The "--exec" option to "git rebase --rebase-merges" placed the exec
 commands at wrong places, which has been corrected.
 
 cf. <pull.13.v2.git.gitgitgadget@gmail.com>


* nd/no-extern (2018-08-03) 12 commits
 - submodule.h: drop extern from function declaration
 - revision.h: drop extern from function declaration
 - repository.h: drop extern from function declaration
 - rerere.h: drop extern from function declaration
 - line-range.h: drop extern from function declaration
 - diff.h: remove extern from function declaration
 - diffcore.h: drop extern from function declaration
 - convert.h: drop 'extern' from function declaration
 - cache-tree.h: drop extern from function declaration
 - blame.h: drop extern on func declaration
 - attr.h: drop extern from function declaration
 - apply.h: drop extern on func declaration

 Noiseword "extern" has been removed from function decls in the
 header files.

 Will merge to 'next'.


* ar/t4150-am-scissors-test-fix (2018-08-06) 1 commit
 - t4150: fix broken test for am --scissors

 Test fix.

 Will merge to 'next'.


* en/t3031-title-fix (2018-08-06) 1 commit
 - t3031: update test description to mention desired behavior

 Test fix.

 Will merge to 'next'.


* hn/config-in-code-comment (2018-08-06) 1 commit
 - config: document git config getter return value

 Header update.

 Will merge to 'next'.


* jk/diff-rendered-docs (2018-08-06) 1 commit
 - add a script to diff rendered documentation

 Developer support to allow the end result of documentation update
 to be inspected more easily.

 Will merge to 'next'.


* js/pull-rebase-type-shorthand (2018-08-06) 1 commit
 - pull --rebase=<type>: allow single-letter abbreviations for the type

 "git pull --rebase=interactive" learned "i" as a short-hand for
 "interactive".

 Will merge to 'next'.


* nd/complete-config-vars (2018-08-06) 1 commit
 - Makefile: add missing dependency for command-list.h

 Build fix.

 Will merge to 'next'.


* nd/config-blame-sort (2018-08-06) 1 commit
 - config.txt: reorder blame stuff to keep config keys sorted

 Doc fix.

 Will merge to 'next'.


* wc/make-funnynames-shared-lazy-prereq (2018-08-06) 1 commit
 - t: factor out FUNNYNAMES as shared lazy prereq

 A test prerequisite defined by various test scripts with slightly
 different sematics has been consolidated into a single copy and
 made into a lazily defined one.



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
  (merged to 'next' on 2018-08-06 at e40ae4af80)
 + git-p4: add the `p4-pre-submit` hook

 "git p4 submit" learns to ask its own pre-submit hook if it should
 continue with submitting.

 Will merge to 'master'.


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


* hn/highlight-sideband-keywords (2018-08-06) 2 commits
 - SQUASH???
 - sideband: highlight keywords in remote sideband output

 The sideband code learned to optionally paint selected keywords at
 the beginning of incoming lines on the receiving end.


* jn/subtree-test-fixes (2018-07-30) 2 commits
  (merged to 'next' on 2018-08-06 at 62f21c328f)
 + subtree test: simplify preparation of expected results
 + subtree test: add missing && to &&-chain

 Test fix.

 Will merge to 'master'.


* ms/http-proto-doc (2018-07-30) 1 commit
  (merged to 'next' on 2018-08-06 at df1cac9945)
 + doc: fix want-capability separator

 Doc fix.

 Will merge to 'master'.


* nd/pack-objects-threading-doc (2018-07-30) 1 commit
  (merged to 'next' on 2018-08-06 at cc8c305191)
 + pack-objects: document about thread synchronization

 Doc fix.

 Will merge to 'master'.


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
  (merged to 'next' on 2018-08-06 at c10246e1c8)
 + mw-to-git/t9360: fix broken &&-chain

 Test fix.

 Will merge to 'master'.


* jk/merge-subtree-heuristics (2018-08-02) 1 commit
 - score_trees(): fix iteration over trees with missing entries

 The automatic tree-matching in "git merge -s subtree" was broken 5
 years ago and nobody has noticed since then, which is now fixed.

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


* nd/unpack-trees-with-cache-tree (2018-08-06) 4 commits
 - unpack-trees: cheaper index update when walking by cache-tree
 - unpack-trees: reduce malloc in cache-tree walk
 - unpack-trees: optimize walking same trees with cache-tree
 - unpack-trees: add performance tracing

 The unpack_trees() API used in checking out a branch and merging
 walks one or more trees along with the index.  When the cache-tree
 in the index tells us that we are walking a tree whose flattened
 contents is known (i.e. matches a span in the index), as linearly
 scanning a span in the index is much more efficient than having to
 open tree objects recursively and listing their entries, the walk
 can be optimized, which is done in this topic.


* rs/remote-mv-leakfix (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-06 at 999fe6d3e5)
 + remote: clear string_list after use in mv()

 Leakfix.

 Will merge to 'master'.


* sb/config-write-fix (2018-08-01) 3 commits
 - git-config: document accidental multi-line setting in deprecated syntax
 - config: fix case sensitive subsection names on writing
 - t1300: document current behavior of setting options

 Recent update to "git config" broke updating variable in a
 subsection, which has been corrected.

 Expecting a reroll.
 cf. <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>


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
  (merged to 'next' on 2018-08-06 at d67def2a92)
 + travis-ci: include the trash directories of failed tests in the trace log

 The Travis CI scripts were taught to ship back the test data from
 failed tests.

 Will merge to 'master'.


* jt/connectivity-check-after-unshallow (2018-08-01) 1 commit
  (merged to 'next' on 2018-08-06 at 1932418f46)
 + fetch-pack: unify ref in and out param

 "git fetch" sometimes failed to update the remote-tracking refs,
 which has been corrected.

 Will merge to 'master'.


* ab/sha1dc (2018-08-02) 1 commit
 - sha1dc: update from upstream

 AIX portability update for SHADC hash, imported from upstream.

 Will merge to 'next'.


* es/want-color-fd-defensive (2018-08-03) 1 commit
 - color: protect against out-of-bounds reads and writes

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


* rs/parse-opt-lithelp (2018-08-03) 7 commits
 - parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP
 - shortlog: correct option help for -w
 - send-pack: specify --force-with-lease argument help explicitly
 - pack-objects: specify --index-version argument help explicitly
 - difftool: remove angular brackets from argument help
 - add, update-index: fix --chmod argument help
 - push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets

 The parse-options machinery learned to refrain from enclosing
 placeholder string inside a "<bra" and "ket>" pair automatically
 without PARSE_OPT_LITERAL_ARGHELP.  Existing help text for option
 arguments that are not formatted correctly have been identified and
 fixed.

 Will merge to 'next'.


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

 Will hold.
 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
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

 Will cook in 'next'.


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
  (merged to 'next' on 2018-08-06 at 9ab321a15c)
 + merge-recursive: preserve skip_worktree bit when necessary
 + t3507: add a testcase showing failure with sparse checkout

 When the sparse checkout feature is in use, "git cherry-pick" and
 other mergy operations lost the skip_worktree bit when a path that
 is excluded from checkout requires content level merge, which is
 resolved as the same as the HEAD version, without materializing the
 merge result in the working tree, which made the path appear as
 deleted.  This has been corrected by preserving the skip_worktree
 bit (and not materializing the file in the working tree).

 Will merge to 'master'.


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
  (merged to 'next' on 2018-08-06 at 3dcd1999df)
 + banned.h: mark strncpy() as banned
 + banned.h: mark sprintf() as banned
 + banned.h: mark strcat() as banned
 + automatically ban strcpy()
 + Merge branch 'sb/blame-color' into jk/banned-function

 It is too easy to misuse system API functions such as strcat();
 these selected functions are now forbidden in this codebase and
 will cause a compilation failure.

 Will merge to 'master'.


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
  (merged to 'next' on 2018-08-06 at 5c578b63a8)
 + vscode: let cSpell work on commit messages, too
 + vscode: add a dictionary for cSpell
 + vscode: use 8-space tabs, no trailing ws, etc for Git's source code
 + vscode: wrap commit messages at column 72 by default
 + vscode: only overwrite C/C++ settings
 + mingw: define WIN32 explicitly
 + cache.h: extract enum declaration from inside a struct declaration
 + vscode: hard-code a couple defines
 + contrib: add a script to initialize VS Code configuration

 Add a script (in contrib/) to help users of VSCode work better with
 our codebase.

 Will merge to 'master'.


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


* ab/newhash-is-sha256 (2018-08-06) 2 commits
 - doc hash-function-transition: pick SHA-256 as NewHash
 - doc hash-function-transition: note the lack of a changelog

 Documentation update.

 Will Merge to 'next'.


* bb/redecl-enum-fix (2018-07-26) 1 commit
  (merged to 'next' on 2018-08-06 at 828dc4b156)
 + packfile: ensure that enum object_type is defined

 Compilation fix.

 Will merge to 'master'.


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


* sb/submodule-update-in-c (2018-08-03) 7 commits
 - submodule--helper: introduce new update-module-mode helper
 - submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree
 - builtin/submodule--helper: factor out method to update a single submodule
 - builtin/submodule--helper: store update_clone information in a struct
 - builtin/submodule--helper: factor out submodule updating
 - git-submodule.sh: rename unused variables
 - git-submodule.sh: align error reporting for update mode to use path

 "git submodule update" is getting rewritten piece-by-piece into C.

 Will merge to and cook in 'next'.


* sl/commit-dry-run-with-short-output-fix (2018-07-30) 4 commits
 . commit: fix exit code when doing a dry run
 . wt-status: teach wt_status_collect about merges in progress
 . wt-status: rename commitable to committable
 . t7501: add coverage for flags which imply dry runs

 "git commit --dry-run" gave a correct exit status even during a
 conflict resolution toward a merge, but it did not with the
 "--short" option, which has been corrected.

 Seems to break 7512, 3404 and 7060 in 'pu'.


* tg/rerere (2018-08-06) 11 commits
 - rerere: recalculate conflict ID when unresolved conflict is committed
 - rerere: teach rerere to handle nested conflicts
 - rerere: return strbuf from handle path
 - rerere: factor out handle_conflict function
 - rerere: only return whether a path has conflicts or not
 - rerere: fix crash with files rerere can't handle
 - rerere: add documentation for conflict normalization
 - rerere: mark strings for translation
 - rerere: wrap paths in output in sq
 - rerere: lowercase error messages
 - rerere: unify error messages when read_cache fails

 Fixes to "git rerere" corner cases, especially when conflict
 markers cannot be parsed in the file.

 Will merge to and cook in 'next'.


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


* pk/rebase-in-c (2018-08-06) 3 commits
 - builtin/rebase: support running "git rebase <upstream>"
 - rebase: refactor common shell functions into their own file
 - rebase: start implementing it as a builtin

 Rewrite of the "rebase" machinery in C.


* jk/branch-l-1-repurpose (2018-06-22) 1 commit
 - branch: make "-l" a synonym for "--list"

 Updated plan to repurpose the "-l" option to "git branch".

 Will merge to and cook in 'next'.


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
