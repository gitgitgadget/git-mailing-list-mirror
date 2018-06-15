Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BA91F403
	for <e@80x24.org>; Fri, 15 Jun 2018 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966265AbeFOU1Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 16:27:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34430 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966118AbeFOU1N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 16:27:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so11072965wro.1
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=sEOKQsP3sm0NVxWflXKxboRMWzbFNaWSKbMBbjA8DRA=;
        b=aaXyzMcD731Z+yEQQM/SbOLS1byAkCBH0M8cDtR7+ybkL6JXQ2x8FIUIjR4pB8Lkdv
         Z8fCeLvIRISzXe8ZEQE7TBtjiU7e2qKnYsI9o/RAe1de/p7Fxg8U1Zx4McMzRqsgwgWo
         kYyRAKnyt80oVn/Q1OIePjCv4mM71IYzHImhFP8v1WuESk2AGhewHtYVbSOABM2P3A8K
         3E/TZbDQKteiTHcqk/nrmVvdsFMh3YGnRtSkFdUVEGlt2gKysnJXnhvEkHPbOPZjEpDN
         QagosfM80zsormdfk8idWbXdcmL7aT7nfxTbMy3A99NAR0hyFgigSom5Nf2gDMdFWgTp
         ymiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=sEOKQsP3sm0NVxWflXKxboRMWzbFNaWSKbMBbjA8DRA=;
        b=jum2YRjy1r2ywPnKyitdJyJM1I0jPu2oE1b0ejZGJXelP9Bnma6eDINWjXUK6GeMBs
         0p0w+rTwGSaDx5MpHjB6iIasly/Nx6oarJFPLqFdYQc0deMecxKCPZuiV8506BHzrFTG
         RDHnFNBx7f1+XaWKvdJPB87cq9f5o8lodVxMgYlbe0j0nkNJ9zjyy1Vywqi3WXlnXRMe
         qPGyE7ESQZWXEqqKCqWM8tAlkGWLYGPoNrYqGilNbmNJbaWJk8gS93cW4uznkkT32HVA
         aNr4jvpRiu73NQTHJeierKut0jh9BvDywGpGupNZCUTb5n8vVI64QNKZfKfCfFeb+U2T
         J+NA==
X-Gm-Message-State: APt69E1DQLPNjX9StK+Uy/Mav1WCVrLfnAwNMa6RgERxHhInq8W1bM4w
        klz4eViOHalAMwOOKRROkzBoR/wHRsOeHg==
X-Google-Smtp-Source: ADUXVKJgYrgABp3RTfum/bEksl5i8lx8h6ipuPE8phn/fyAHIdQwNHFYOx1Y9Rn7+covhrco9mFiXg==
X-Received: by 2002:adf:8989:: with SMTP id x9-v6mr2783847wrx.78.1529094431302;
        Fri, 15 Jun 2018 13:27:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m16-v6sm7338838wro.91.2018.06.15.13.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:27:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2018, #04; Fri, 15)
X-master-at: 68372c88794aba15f853542008cda39def768372
X-next-at: 013aa6912eb2e1677775c77626d7d5dcd8eaad9f
Date:   Fri, 15 Jun 2018 13:27:10 -0700
Message-ID: <xmqqd0wrztgh.fsf@gitster-ct.c.googlers.com>
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

We passed -rc2 mark; there are still a few hotfixes that correct
obvious bugs introduced during this cycle in trivial ways that need
to be merged before the final, and I also need to pull the i18n/l10n
updates, but other than that, I think we are in relatively good
shape given the upcoming release is fairly a big one judging from
historical norms.  Knock, knock...

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/index-pack-maint (2018-06-11) 3 commits
  (merged to 'next' on 2018-06-11 at f85a566b11)
 + index-pack: correct install_packed_git() args
  (merged to 'next' on 2018-06-04 at c553a485e8)
 + index-pack: handle --strict checks of non-repo packs
 + prepare_commit_graft: treat non-repository as a noop

 "index-pack --strict" has been taught to make sure that it runs the
 final object integrity checks after making the freshly indexed
 packfile available to itself.


* jk/submodule-fsck-loose-fixup (2018-06-11) 2 commits
  (merged to 'next' on 2018-06-11 at 3eadb39c0a)
 + fsck: avoid looking at NULL blob->object
 + t7415: don't bother creating commit for symlink test

 Finishing touches to a topic that already is in 'maint'.


* sb/submodule-merge-in-merge-recursive (2018-06-11) 1 commit
  (merged to 'next' on 2018-06-11 at ad05b6bc6a)
 + merge-submodule: reduce output verbosity

 Finishing touches to a topic that already is in 'master'.


* sg/completion-zsh-workaround (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-12 at 331a1db143)
 + completion: correct zsh detection when run from git-completion.zsh

 Work around zsh segfaulting when loading git-completion.zsh

--------------------------------------------------
[New Topics]

* ab/cred-netrc-no-autodie (2018-06-13) 1 commit
  (merged to 'next' on 2018-06-14 at 68171b82a7)
 + git-credential-netrc: remove use of "autodie"

 Hotfix for contrib/ stuff broken by this cycle.

 Will merge to 'master'.


* jl/zlib-restore-nul-termination (2018-06-13) 1 commit
  (merged to 'next' on 2018-06-14 at 3fa108363e)
 + packfile: correct zlib buffer handling

 Make zlib inflate codepath more robust against versions of zlib
 that clobber unused portion of outbuf.

 Will merge to 'master'.


* rd/doc-remote-tracking-with-hyphen (2018-06-13) 1 commit
  (merged to 'next' on 2018-06-14 at 013aa6912e)
 + Use hyphenated "remote-tracking branch" (docs and comments)

 Doc update.

 Will merge to 'master'.


* en/rename-directory-detection (2018-06-14) 1 commit
  (merged to 'next' on 2018-06-14 at 0e4c6bd117)
 + merge-recursive: use xstrdup() instead of fixed buffer

 Newly added codepath in merge-recursive had potential buffer
 overrun, which has been fixed.

 Will merge to 'master'.


* mw/doc-merge-enumfix (2018-06-14) 1 commit
  (merged to 'next' on 2018-06-14 at 7074d6d48e)
 + doc: update the order of the syntax `git merge --continue`

 Fix old merge glitch in Documentation during v2.13-rc0 era.

 Will merge to 'master'.


* sb/blame-color (2018-06-14) 1 commit
  (merged to 'next' on 2018-06-14 at f8cd824d4d)
 + blame: release string_list after use in parse_color_fields()

 Leakfix.

 Will merge to 'master'.


* ks/branch-set-upstream (2018-06-14) 1 commit
 - t3200: clarify description of --set-upstream test

 A test title has been reworded to clarify it.


* jt/fetch-pack-negotiator (2018-06-15) 7 commits
 - fetch-pack: introduce negotiator API
 - fetch-pack: move common check and marking together
 - fetch-pack: make negotiation-related vars local
 - fetch-pack: use ref adv. to prune "have" sent
 - fetch-pack: directly end negotiation if ACK ready
 - fetch-pack: clear marks before re-marking
 - fetch-pack: split up everything_local()

 Code restructuring and a small fix to transport protocol v2 during
 fetching.


* ag/rebase-i-append-todo-help (2018-06-14) 2 commits
 - rebase--interactive: rewrite append_todo_help() in C
 - Merge branch 'ag/rebase-p' into ag/rebase-i-append-todo-help
 (this branch is used by ag/rebase-i-rewrite-todo; uses ag/rebase-p.)

 Stepwise rewriting of the machinery of "rebase -i" into C continues.


* ag/rebase-i-rewrite-todo (2018-06-15) 3 commits
 - rebase--interactive: rewrite the edit-todo functionality in C
 - editor: add a function to launch the sequence editor
 - Merge branch 'bc/t3430-fixup' into ag/rebase-i-rewrite-todo
 (this branch uses ag/rebase-i-append-todo-help and ag/rebase-p.)

 Stepwise rewriting of the machinery of "rebase -i" into C continues.


* sb/fix-fetching-moved-submodules (2018-06-14) 2 commits
 - t5526: test recursive submodules when fetching moved submodules
 - submodule: fix NULL correctness in renamed broken submodules

 The code to try seeing if a fetch is necessary in a submodule
 during a fetch with --recurse-submodules got confused when the path
 to the submodule was changed in the range of commits in the
 superproject, sometimes showing "(null)".  This has been corrected.

 Will merge to 'next'.


* sb/submodule-core-worktree (2018-06-14) 3 commits
 - submodule deinit: unset core.worktree
 - submodule: ensure core.worktree is set after update
 - submodule: unset core.worktree if no working tree is present

 "git submodule" did not correctly adjust core.worktree setting that
 indicates whether/where a submodule repository has its associated
 working tree across various state transitions, which has been
 corrected.

 Will merge to 'next'.


* jk/ewah-bounds-check (2018-06-15) 2 commits
 - ewah: adjust callers of ewah_read_mmap()
 - ewah_read_mmap: bounds-check mmap reads
 (this branch is used by ds/ewah-cleanup.)

 The code to read compressed bitmap was not careful to avoid reading
 past the end of the file, which has been corrected.

 Will merge to 'next'.


* ds/ewah-cleanup (2018-06-15) 9 commits
 - ewah: drop ewah_serialize_native function
 - ewah: drop ewah_deserialize function
 - ewah_io: delete unused 'ewah_serialize()'
 - ewah_bitmap: delete unused 'ewah_or()'
 - ewah_bitmap: delete unused 'ewah_not()'
 - ewah_bitmap: delete unused 'ewah_and_not()'
 - ewah_bitmap: delete unused 'ewah_and()'
 - ewah/bitmap.c: delete unused 'bitmap_each_bit()'
 - ewah/bitmap.c: delete unused 'bitmap_clear()'
 (this branch uses jk/ewah-bounds-check.)

 Remove unused function definitions and declarations from ewah
 bitmap subsystem.

 Will merge to 'next'.


* jc/clean-after-sanity-tests (2018-06-15) 1 commit
 - tests: clean after SANITY tests

 test cleanup.

 Will merge to 'next'.


* es/make-no-iconv (2018-06-15) 1 commit
 - Makefile: make NO_ICONV really mean "no iconv"

 "make NO_ICONV=NoThanks" did not override NEEDS_LIBICONV
 (i.e. linkage of -lintl, -liconv, etc. that are platform-specific
 tweaks), which has been corrected.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* ab/fetch-tags-noclobber (2018-05-16) 9 commits
 - fixup! push tests: assert re-pushing annotated tags
 - fetch: stop clobbering existing tags without --force
 - fetch tests: add a test clobbering tag behavior
 - fetch tests: correct a comment "remove it" -> "remove them"
 - push doc: correct lies about how push refspecs work
 - push tests: assert re-pushing annotated tags
 - push tests: add more testing for forced tag pushing
 - push tests: fix logic error in "push" test assertion
 - push tests: remove redundant 'git push' invocation

 Expecting a reboot of the discussion to take it to some conclusion
 and then a reroll.
 cf. <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
 cf. <xmqq603yn50l.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqzi1alodz.fsf@gitster-ct.c.googlers.com>
 cf. <xmqqvabylnbi.fsf@gitster-ct.c.googlers.com>


* pw/add-p-select (2018-03-16) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Expecting a reroll to reignite the discussion.
 cf. <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>


* jh/json-writer (2018-06-13) 1 commit
 - json_writer: new routines to create JSON data

 Preparatory code to later add json output for unspecified telemetry
 data.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


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


* pb/bisect-helper-2 (2018-06-13) 8 commits
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


* mk/http-backend-content-length (2018-06-11) 3 commits
 - http-backend: respect CONTENT_LENGTH for receive-pack
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875
 - http-backend: cleanup writing to child process

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.


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

* is/parsing-line-range (2018-06-15) 2 commits
 - log: prevent error if line range ends past end of file
 - blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.


* ab/refspec-init-fix (2018-06-11) 3 commits
  (merged to 'next' on 2018-06-13 at 91d71d8435)
 + refspec: initalize `refspec_item` in `valid_fetch_refspec()`
 + refspec: add back a refspec_item_init() function
 + refspec: s/refspec_item_init/&_or_die/g

 Make refspec parsing codepath more robust.

 Will cook in 'next'.


* as/safecrlf-quiet-fix (2018-06-11) 1 commit
  (merged to 'next' on 2018-06-13 at b163674843)
 + config.c: fix regression for core.safecrlf false

 Fix for 2.17-era regression.

 Will cook in 'next'.


* sg/gpg-tests-fix (2018-06-11) 2 commits
  (merged to 'next' on 2018-06-13 at f3a05f1c41)
 + tests: make forging GPG signed commits and tags more robust
 + t7510-signed-commit: use 'test_must_fail'

 Some flaky tests have been fixed.

 Will cook in 'next'.


* jk/fetch-all-peeled-fix (2018-06-13) 2 commits
  (merged to 'next' on 2018-06-13 at 1333bb9d90)
 + fetch-pack: test explicitly that --all can fetch tag references pointing to non-commits
 + fetch-pack: don't try to fetch peel values with --all

 "git fetch-pack --all" used to unnecessarily fail upon seeing an
 annotated tag that points at an object other than a commit.

 Will cook in 'next'.


* rd/diff-options-typofix (2018-06-11) 1 commit
  (merged to 'next' on 2018-06-13 at a5aa58fa1b)
 + diff-options.txt: fix minor typos, font inconsistencies, in docs

 Typofix.

 Will merge to 'master'.


* ld/git-p4-updates (2018-06-12) 6 commits
  (merged to 'next' on 2018-06-13 at 4f7e24b3c4)
 + git-p4: auto-size the block
 + git-p4: narrow the scope of exceptions caught when parsing an int
 + git-p4: raise exceptions from p4CmdList based on error from p4 server
 + git-p4: better error reporting when p4 fails
 + git-p4: add option to disable syncing of p4/master with p4
 + git-p4: disable-rebase: allow setting this via configuration
 (this branch uses rm/p4-submit-with-commit-option.)

 "git p4" updates.

 Will merge to 'master'.


* en/merge-recursive-cleanup (2018-06-12) 6 commits
 - merge-recursive: add pointer about unduly complex looking code
 - merge-recursive: rename conflict_rename_*() family of functions
 - merge-recursive: clarify the rename_dir/RENAME_DIR meaning
 - merge-recursive: align labels with their respective code blocks
 - merge-recursive: fix numerous argument alignment issues
 - merge-recursive: fix miscellaneous grammar error in comment

 Code cleanup.

 Will merge to 'next'.


* jh/partial-clone (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-13 at 818f864b0c)
 + list-objects: check if filter is NULL before using

 The recent addition of "partial clone" experimental feature kicked
 in when it shouldn't, namely, when there is no partial-clone filter
 defined even if extensions.partialclone is set.

 Will cook in 'next'.


* km/doc-workflows-typofix (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-13 at 21e6a8e67b)
 + gitworkflows: fix grammar in 'Merge upwards' rule

 Typofix.

 Will merge to 'master'.


* ms/send-pack-honor-config (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-13 at e2cd933715)
 + builtin/send-pack: populate the default configs

 "git send-pack --signed" (hence "git push --signed" over the http
 transport) did not read user ident from the config mechanism to
 determine whom to sign the push certificate as, which has been
 corrected.

 Will cook in 'next'.


* ab/checkout-default-remote (2018-06-11) 8 commits
 - checkout & worktree: introduce checkout.defaultRemote
 - checkout: add advice for ambiguous "checkout <branch>"
 - builtin/checkout.c: use "ret" variable for return
 - checkout: pass the "num_matches" up to callers
 - checkout.c: change "unique" member to "num_matches"
 - checkout.c: introduce an *_INIT macro
 - checkout.h: wrap the arguments to unique_tracking_name()
 - checkout tests: index should be clean after dwim checkout


* nd/reject-empty-shallow-request (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at d6b6a1c3a7)
 + upload-pack: reject shallow requests that would return nothing

 "git fetch --shallow-since=<cutoff>" that specifies the cut-off
 point that is newer than the existing history used to end up
 grabbing the entire history.  Such a request now errors out.

 Will cook in 'next'.


* pw/add-p-recount (2018-06-11) 1 commit
 - add -p: fix counting empty context lines in edited patches

 When user edits the patch in "git add -p" and the user's editor is
 set to strip trailing whitespaces indiscriminately, an empty line
 that is unchanged in the patch would become completely empty
 (instead of a line with a sole SP on it).  The code introduced in
 Git 2.17 timeframe failed to parse such a patch, but now it learned
 to notice the situation and cope with it.

 Will merge to 'next'.


* rd/comment-typofix-in-sha1-file (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at 38ef825556)
 + sha1-file.c: correct $GITDIR to $GIT_DIR in a comment

 In code comment typofix

 Will merge to 'master'.


* sg/update-ref-stdin-cleanup (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at 2b9924760d)
 + update-ref --stdin: use skip_prefix()

 Code cleanup.

 Will cook in 'next'.


* cc/tests-without-assuming-ref-files-backend (2018-06-04) 1 commit
  (merged to 'next' on 2018-06-13 at 7e2f74431c)
 + t9104: kosherly remove remote refs

 Instead of mucking with filesystem directly, use plumbing commands
 update-ref etc. to manipulate the refs in the tests.

 Will cook in 'next'.


* ag/rebase-p (2018-06-01) 4 commits
  (merged to 'next' on 2018-06-13 at dd6f8a51d7)
 + rebase: remove -p code from git-rebase--interactive.sh
 + rebase: use the new git-rebase--preserve-merges.sh
 + rebase: strip unused code in git-rebase--preserve-merges.sh
 + rebase: introduce a dedicated backend for --preserve-merges
 (this branch is used by ag/rebase-i-append-todo-help and ag/rebase-i-rewrite-todo.)

 Separate "rebase -p" codepath out of "rebase -i" implementation to
 slim down the latter and make it easier to manage.

 Will cook in 'next'.


* ls/complete-remote-update-names (2018-06-01) 1 commit
  (merged to 'next' on 2018-06-13 at 86b4d23278)
 + completion: complete remote names too

 "git remote update" can take both a single remote nickname and a
 nickname for remote groups, and the completion script (in contrib/)
 has been taught about it.

 Will cook in 'next'.


* sb/plug-misc-leaks (2018-06-04) 5 commits
  (merged to 'next' on 2018-06-13 at bf68cabe28)
 + SQUASH: tentatively cast const-ness away when calling free()
 + sequencer.c: plug mem leak in git_sequencer_config
  (merged to 'next' on 2018-06-04 at fbefac1c7a)
 + sequencer.c: plug leaks in do_pick_commit
 + submodule--helper: plug mem leak in print_default_remote
 + refs/packed-backend.c: close fd of empty file

 Misc leak plugging.

 Will cook in 'next'.


* ds/commit-graph-fsck (2018-05-29) 20 commits
 - commit-graph: update design document
 - gc: automatically write commit-graph files
 - commit-graph: add '--reachable' option
 - fsck: verify commit-graph
 - commit-graph: verify contents match checksum
 - commit-graph: test for corrupted octopus edge
 - commit-graph: verify commit date
 - commit-graph: verify generation number
 - commit-graph: verify parent list
 - commit-graph: verify root tree OIDs
 - commit-graph: verify objects exist
 - commit-graph: verify corrupt OID fanout and lookup
 - commit-graph: verify required chunks are present
 - commit-graph: verify catches corrupt signature
 - commit-graph: add 'verify' subcommand
 - commit-graph: load a root tree from specific graph
 - commit: force commit to parse from object database
 - commit-graph: parse commit from chosen graph
 - commit-graph: fix GRAPH_MIN_SIZE
 - commit-graph: UNLEAK before die()
 (this branch uses ds/commit-graph-lockfile-fix and ds/generation-numbers.)

 Expecting a reroll.
 cf. <ba3b8e06-b5e1-99a1-0fe4-ff97d6da8f15@gmail.com>


* en/merge-recursive-tests (2018-05-28) 5 commits
  (merged to 'next' on 2018-06-01 at 8490b560b4)
 + t6036: prefer test_when_finished to manual cleanup in following test
 + t6036, t6042: prefer test_cmp to sequences of test
 + t6036, t6042: prefer test_path_is_file, test_path_is_missing
 + t6036, t6042: use test_line_count instead of wc -l
 + t6036, t6042: use test_create_repo to keep tests independent

 Clean up tests in t6xxx series about 'merge' command.

 Will cook in 'next'.


* jk/show-index (2018-05-29) 2 commits
  (merged to 'next' on 2018-06-01 at 4b3382d994)
 + show-index: update documentation for index v2
 + make show-index a builtin

 Modernize a less often used command.

 Will cook in 'next'.


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Waiting for the discussion to settle.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* nd/complete-config-vars (2018-05-29) 13 commits
  (merged to 'next' on 2018-06-13 at c2dd5546d0)
 + completion: complete general config vars in two steps
 + log-tree: allow to customize 'grafted' color
 + completion: support case-insensitive config vars
 + completion: keep other config var completion in camelCase
 + completion: drop the hard coded list of config vars
 + am: move advice.amWorkDir parsing back to advice.c
 + advice: keep config name in camelCase in advice_config[]
 + fsck: produce camelCase config key names
 + help: add --config to list all available config
 + fsck: factor out msg_id_info[] lazy initialization code
 + grep: keep all colors in an array
 + Add and use generic name->id mapping code for color slot parsing
 + Merge branch 'nd/command-list' into nd/complete-config-vars

 Continuing with the idea to programatically enumerate various
 pieces of data required for command line completion, teach the
 codebase to report the list of configuration variables
 subcommands care about to help complete them.

 Will cook in 'next'.


* nd/completion-negation (2018-06-11) 3 commits
 - completion: collapse extra --no-.. options
 - completion: suppress some -no- options
 - parse-options: option to let --git-completion-helper show negative form

 Continuing with the idea to programatically enumerate various
 pieces of data required for command line completion, the codebase
 has been taught to enumerate options prefixed with "--no-" to
 negate them.

 Will merge to 'next'.


* jm/cache-entry-from-mem-pool (2018-05-24) 7 commits
  (merged to 'next' on 2018-06-13 at 34a0e21f3e)
 + block alloc: add validations around cache_entry lifecyle
 + block alloc: allocate cache entries from mem_pool
 + mem-pool: fill out functionality
 + mem-pool: add lifecycle management functions
 + mem-pool: only search head block for available space
 + block alloc: add lifecycle APIs for cache_entry structs
 + read-cache: teach refresh_cache_entry() to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 Will cook in 'next'.


* rm/p4-submit-with-commit-option (2018-06-12) 1 commit
  (merged to 'next' on 2018-06-13 at d3a272c733)
 + git-p4: add options --commit and --disable-rebase
 (this branch is used by ld/git-p4-updates.)

 "git p4" updates.

 Will merge to 'master'.


* ds/commit-graph-lockfile-fix (2018-05-22) 1 commit
  (merged to 'next' on 2018-05-24 at 3d12a02b0c)
 + commit-graph: fix UX issue when .lock file exists
 (this branch is used by ds/commit-graph-fsck; uses ds/generation-numbers.)

 Update to ds/generation-numbers topic.

 Will cook in 'next'.


* nd/commit-util-to-slab (2018-05-21) 15 commits
  (merged to 'next' on 2018-05-24 at bb5643d75c)
 + commit.h: delete 'util' field in struct commit
 + merge: use commit-slab in merge remote desc instead of commit->util
 + log: use commit-slab in prepare_bases() instead of commit->util
 + show-branch: note about its object flags usage
 + show-branch: use commit-slab for commit-name instead of commit->util
 + name-rev: use commit-slab for rev-name instead of commit->util
 + bisect.c: use commit-slab for commit weight instead of commit->util
 + revision.c: use commit-slab for show_source
 + sequencer.c: use commit-slab to associate todo items to commits
 + sequencer.c: use commit-slab to mark seen commits
 + shallow.c: use commit-slab for commit depth instead of commit->util
 + describe: use commit-slab for commit names instead of commit->util
 + blame: use commit-slab for blame suspects instead of commit->util
 + commit-slab: support shared commit-slab
 + commit-slab.h: code split

 The in-core "commit" object had an all-purpose "void *util" field,
 which was tricky to use especially in library-ish part of the
 code.  All of the existing uses of the field has been migrated to a
 more dedicated "commit-slab" mechanism and the field is eliminated.

 Will cook in 'next'.


* nd/diff-apply-ita (2018-05-29) 4 commits
  (merged to 'next' on 2018-05-30 at f98728de81)
 + apply: add --intent-to-add
 + t2203: add a test about "diff HEAD" case
 + diff: turn --ita-invisible-in-index on by default
 + diff: ignore --ita-[in]visible-in-index when diffing worktree-to-tree

 "git diff" compares the index and the working tree.  For paths
 added with intent-to-add bit, the command shows the full contents
 of them as added, but the paths themselves were not marked as new
 files.  They are now shown as new by default.

 "git apply" learned the "--intent-to-add" option so that an
 otherwise working-tree-only application of a patch will add new
 paths to the index marked with the "intent-to-add" bit.

 Will cook in 'next'.


* sb/object-store-grafts (2018-05-18) 19 commits
 - commit: allow lookup_commit_graft to handle arbitrary repositories
 - commit: allow prepare_commit_graft to handle arbitrary repositories
 - shallow: migrate shallow information into the object parser
 - path.c: migrate global git_path_* to take a repository argument
 - cache: convert get_graft_file to handle arbitrary repositories
 - commit: convert read_graft_file to handle arbitrary repositories
 - commit: convert register_commit_graft to handle arbitrary repositories
 - commit: convert commit_graft_pos() to handle arbitrary repositories
 - shallow: add repository argument to is_repository_shallow
 - shallow: add repository argument to check_shallow_file_for_update
 - shallow: add repository argument to register_shallow
 - shallow: add repository argument to set_alternate_shallow_file
 - commit: add repository argument to lookup_commit_graft
 - commit: add repository argument to prepare_commit_graft
 - commit: add repository argument to read_graft_file
 - commit: add repository argument to register_commit_graft
 - commit: add repository argument to commit_graft_pos
 - object: move grafts to object parser
 - object-store: move object access functions to object-store.h
 (this branch uses sb/object-store-alloc.)

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.

 Will merge to 'next'.


* pc/submodule-helper-foreach (2018-05-11) 4 commits
  (merged to 'next' on 2018-05-22 at f22659ad46)
 + submodule: port submodule subcommand 'foreach' from shell to C
 + submodule foreach: document variable '$displaypath'
 + submodule foreach: document '$sm_path' instead of '$path'
 + submodule foreach: correct '$path' in nested submodules from a subdirectory

 The bulk of "git submodule foreach" has been rewritten in C.

 Will cook in 'next'.


* js/branch-diff (2018-05-16) 19 commits
 - fixup! Add a function to solve least-cost assignment problems
 - completion: support branch-diff
 - branch-diff: add a man page
 - branch-diff --dual-color: work around bogus white-space warning
 - branch-diff: offer to dual-color the diffs
 - diff: add an internal option to dual-color diffs of diffs
 - color: provide inverted colors, too
 - branch-diff: use color for the commit pairs
 - branch-diff: add tests
 - branch-diff: do not show "function names" in hunk headers
 - branch-diff: adjust the output of the commit pairs
 - branch-diff: suppress the diff headers
 - branch-diff: indent the diffs just like tbdiff
 - branch-diff: right-trim commit messages
 - branch-diff: also show the diff between patches
 - branch-diff: improve the order of the shown commits
 - branch-diff: first rudimentary implementation
 - Add a new builtin: branch-diff
 - Add a function to solve least-cost assignment problems

 "git tbdiff" that lets us compare individual patches in two
 iterations of a topic has been rewritten and made into a built-in
 command.

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.1805052351560.77@tvgsbejvaqbjf.bet>


* sb/object-store-alloc (2018-05-16) 13 commits
  (merged to 'next' on 2018-06-13 at 2868c2db9d)
 + alloc: allow arbitrary repositories for alloc functions
 + object: allow create_object to handle arbitrary repositories
 + object: allow grow_object_hash to handle arbitrary repositories
 + alloc: add repository argument to alloc_commit_index
 + alloc: add repository argument to alloc_report
 + alloc: add repository argument to alloc_object_node
 + alloc: add repository argument to alloc_tag_node
 + alloc: add repository argument to alloc_commit_node
 + alloc: add repository argument to alloc_tree_node
 + alloc: add repository argument to alloc_blob_node
 + object: add repository argument to grow_object_hash
 + object: add repository argument to create_object
 + repository: introduce parsed objects field
 (this branch is used by sb/object-store-grafts.)

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.

 Will cook in 'next'.


* tb/grep-column (2018-05-14) 7 commits
 . contrib/git-jump/git-jump: jump to match column in addition to line
 . grep.c: add configuration variables to show matched option
 . builtin/grep.c: add '--column' option to 'git-grep(1)'
 . grep.c: display column number of first match
 . grep.[ch]: extend grep_opt to allow showing matched column
 . grep.c: expose matched column in match_line()
 . Documentation/config.txt: camel-case lineNumber for consistency
 (this branch is used by tb/grep-only-matching.)

 "git grep" learned the "--column" option that gives not just the
 line number but the column number of the hit.

 Expecting a reroll.
 cf. <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>


* tb/grep-only-matching (2018-05-14) 2 commits
 . builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
 . grep.c: extract show_line_header()
 (this branch uses tb/grep-column.)

 Waiting on tb/grep-column


* sb/diff-color-move-more (2018-05-21) 8 commits
  (merged to 'next' on 2018-05-24 at 45f3fb7975)
 + diff: color-moved white space handling options imply color-moved
 + diff.c: add --color-moved-ignore-space-delta option
 + diff.c: decouple white space treatment from move detection algorithm
 + diff.c: add a blocks mode for moved code detection
 + diff.c: adjust hash function signature to match hashmap expectation
 + diff.c: do not pass diff options as keydata to hashmap
 + xdiff/xdiffi.c: remove unneeded function declarations
 + xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.

 Will kick back to 'pu'.
 cf. <CAGZ79kag9m02xtJKg05aPE4Grq2wBWSmUr3JdwfyHsMawR7m5Q@mail.gmail.com>


* ds/generation-numbers (2018-05-22) 11 commits
  (merged to 'next' on 2018-05-24 at 56fc38a1b6)
 + commit-graph.txt: update design document
 + merge: check config before loading commits
 + commit: use generation number in remove_redundant()
 + commit: add short-circuit to paint_down_to_common()
 + commit: use generation numbers for in_merge_bases()
 + ref-filter: use generation number for --contains
 + commit-graph: always load commit-graph information
 + commit: use generations in paint_down_to_common()
 + commit-graph: compute generation numbers
 + commit: add generation number to struct commit
 + ref-filter: fix outdated comment on in_commit_list
 (this branch is used by ds/commit-graph-fsck and ds/commit-graph-lockfile-fix.)

 A recently added "commit-graph" datafile has learned to store
 pre-computed generation numbers to speed up the decisions to stop
 history traversal.

 Will cook in 'next'.


* jk/branch-l-0-deprecation (2018-05-25) 5 commits
  (merged to 'next' on 2018-05-30 at a94574dfd5)
 + branch: customize "-l" warning in list mode
 + branch: issue "-l" deprecation warning after pager starts
  (merged to 'next' on 2018-04-11 at 9b2b0305dd)
 + branch: deprecate "-l" option
 + t: switch "branch -l" to "branch --create-reflog"
 + t3200: unset core.logallrefupdates when testing reflog creation
 (this branch is used by jk/branch-l-1-removal and jk/branch-l-2-reincarnation.)

 The "-l" option in "git branch -l" is an unfortunate short-hand for
 "--create-reflog", but many users, both old and new, somehow expect
 it to be something else, perhaps "--list".  This step deprecates
 the short-hand and warns about the future removal of the it when it
 is used.

 Will cook in 'next'.
 Perhaps merge to 'master' immediately after 2.18 release?


* jk/branch-l-1-removal (2018-05-30) 1 commit
 - branch: drop deprecated "-l" option
 (this branch is used by jk/branch-l-2-reincarnation; uses jk/branch-l-0-deprecation.)

 Following the "git branch -l" deprecation, the short-hand is removed.

 Will keep in 'pu'.


* jk/branch-l-2-reincarnation (2018-05-30) 1 commit
 - branch: make "-l" a synonym for "--list"
 (this branch uses jk/branch-l-0-deprecation and jk/branch-l-1-removal.)

 Following the "git branch -l" removal, "-l" is resurrected as a
 short-hand for "--list".

 Will keep in 'pu'.

--------------------------------------------------
[Discarded]

* js/runtime-prefix-windows (2018-03-27) 5 commits
 . mingw/msvc: use the new-style RUNTIME_PREFIX helper
 . exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 . exec_cmd: RUNTIME_PREFIX on some POSIX systems
 . Makefile: add Perl runtime prefix support
 . Makefile: generate Perl header from template file

 The Windows port was the first that allowed Git to be installed
 anywhere by having its components refer to each other with relative
 pathnames.  The recent dj/runtime-prefix topic extends the idea to
 other platforms, and its approach has been adopted back in the
 Windows port.

 Ejected, as the parent topic dj/runtime-prefix covers Windows now.


* bp/fsexcludes (2018-04-16) 2 commits
 . fsmonitor: switch to use new fsexcludes logic and remove unused untracked cache based logic
 . fsexcludes: add a programmatic way to exclude files from git's working directory traversal logic

 Can we have a few lines summary here, just like we have for other
 topic ;-) I personally take the overlong title of these commits as
 a sign that they can further be simplified and cleaned up by
 splitting, focusing the scope, etc.

 Retracted.
 cf. <0de30972-b0a2-67e8-7cff-c19daf9ece8b@gmail.com>


* ma/doc-expand-tabs (2018-05-02) 1 commit
 . revisions.txt: expand tabs to spaces in diagram

 Fix one instance of asciidoctor's misformatting by expanding a tab
 into spaces in a literal block.

 Discarded.
 This approach is less maintainable than the approach taken by
 bc/asciidoctor-tab-width topic.
