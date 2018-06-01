Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857CD1F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 07:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeFAHWF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 03:22:05 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52278 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAHWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 03:22:03 -0400
Received: by mail-wm0-f54.google.com with SMTP id 18-v6so1035812wml.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=IrVzdjFX8Wl/hDEYB3ouHY0RvZkSNXe4EtIYkpKUh6s=;
        b=AsKkKnOHp8PGtU7FXgprO68wOdvHJy8cDZQM7G46abmVlZFBNBwYSErGwvXKjMz4SL
         gXbFdWjIL+jx8wGgOUKWZ140/b+brP83BQ28dG/pm+UHv+yn+RSo8h0BnrftI0w3TWeB
         r6DVCezvjI2EUMqrhyJW9qJKrvPHNzCHg8xOv83tH5cNb2wagkAoBGN810AjXE4R8oIK
         ZMlWmfG+REtUrgXjfajSIXRz++pxJRLBUwiHvrVD6IjMPXIKEYl/DBT3SckyE9M0TGXp
         JyeKiwr2s54wZKa0nUD/Sj3eA6ggSHOkUwlqdv2kCTCU7RNSNfRCKgwGwC+9rSiBHlxZ
         Ds3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=IrVzdjFX8Wl/hDEYB3ouHY0RvZkSNXe4EtIYkpKUh6s=;
        b=AsSMciZVMgd5c8NUTQmCaUiewwX2RRIqldD2yCV1/bUiW5vy0ZYbjFQD5rUrs1TBxN
         sjDgqrdn80Iw2Ktntt3dgHjwOFGwadO22nYSmRnVjZF3Y44ZrSBKjTuaqWx57zelJl1e
         Jk21H7LBAyCFmHdVXflpIHWF3v/efoSY8NseSYeLeSLSxP7U0qS9MBarsR2N53SnbiVz
         I1kFfo20XSHvHqkbpvPD6G6/fFb0N4WDCNKGTxuDcohtCUdXYafNnDG+Cq72cuQls3KY
         2ErqMvrvbcXVwMjLXg45y/Ifhk/9qV3W/3HzvdDL7lqG1ErjlN9lm6mFbs2eSJoRmwmE
         Shxg==
X-Gm-Message-State: APt69E1Jx3lqfF63B+1g4+B8HOaT740bIp/KkxjfGysS9BQd2YRgNz4J
        R2ZWqb+AAORO47PPdYUajh8Lg4nd
X-Google-Smtp-Source: ADUXVKJhSBwEEcjT+ft29LdiAxQNt6X90DoTaHetnVKoQwfBQmOMRsMyjvx7OvTuCv+GJu4d/hGK5w==
X-Received: by 2002:a1c:e146:: with SMTP id y67-v6mr1834170wmg.17.1527837720852;
        Fri, 01 Jun 2018 00:22:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y3-v6sm5505522wro.21.2018.06.01.00.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 00:21:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2018, #01; Fri, 1)
X-master-at: c2c7d17b030646b40e6764ba34a5ebf66aee77af
X-next-at: fd7c087b0d85b48ffb998ee0349e5bb8945e292a
Date:   Fri, 01 Jun 2018 16:21:59 +0900
Message-ID: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
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

* ag/rebase-p (2018-06-01) 4 commits
 - rebase: remove -p code from git-rebase--interactive.sh
 - rebase: use the new git-rebase--preserve-merges.sh
 - rebase: strip unused code in git-rebase--preserve-merges.sh
 - rebase: introduce a dedicated backend for --preserve-merges

 Separate "rebase -p" codepath out of "rebase -i" implementation to
 slim down the latter and make it easier to manage.


* jk/index-pack-maint (2018-06-01) 2 commits
 - index-pack: handle --strict checks of non-repo packs
 - prepare_commit_graft: treat non-repository as a noop

 "index-pack --strict" has been taught to make sure that it runs the
 final object integrity checks after making the freshly indexed
 packfile available to itself.

 Will merge to 'next' and then to 'master'.


* ls/complete-remote-update-names (2018-06-01) 1 commit
 - completion: complete remote names too

 "git remote update" can take both a single remote nickname and a
 nickname for remote groups, and the completion script (in contrib/)
 has been taught about it.

 Will merge to and cook in 'next'.


* nd/remote-update-doc (2018-06-01) 1 commit
 - remote.txt: update documentation for 'update' command

 "git remote update" can take both a single remote nickname and a
 nickname for remote groups, but only one of them was documented.

 Will merge to 'next' and then to 'master'.


* rd/p4-doc-markup-env (2018-06-01) 1 commit
 - p4.txt: Use backquotes for variable names

 Doc markup update.

 Will merge to 'next' and then to 'master'.


* sb/plug-misc-leaks (2018-06-01) 2 commits
 - submodule--helper: plug mem leak in print_default_remote
 - refs/packed-backend.c: close fd of empty file

 Misc leak plugging.

 Will merge to 'next' and then to 'master'.


* tg/doc-sec-list (2018-06-01) 2 commits
 - note git-security@googlegroups.com in more places
 - SubmittingPatches: replace numbered attributes with names

 Doc update.

 Will merge to 'next' and then to 'master'.

* bw/refspec-api (2018-06-01) 1 commit
 - refspec-api: avoid uninitialized field in refspec item

 Hotfix.

 Will merge to 'next' and then to 'master'.

--------------------------------------------------
[Graduated to "master"]

* bw/refspec-api (2018-05-18) 36 commits
  (merged to 'next' on 2018-05-24 at 83d361419e)
 + submodule: convert push_unpushed_submodules to take a struct refspec
 + remote: convert check_push_refs to take a struct refspec
 + remote: convert match_push_refs to take a struct refspec
 + http-push: store refspecs in a struct refspec
 + transport: remove transport_verify_remote_names
 + send-pack: store refspecs in a struct refspec
 + transport: convert transport_push to take a struct refspec
 + push: convert to use struct refspec
 + push: check for errors earlier
 + remote: convert match_explicit_refs to take a struct refspec
 + remote: convert get_ref_match to take a struct refspec
 + remote: convert query_refspecs to take a struct refspec
 + remote: convert apply_refspecs to take a struct refspec
 + remote: convert get_stale_heads to take a struct refspec
 + fetch: convert prune_refs to take a struct refspec
 + fetch: convert get_ref_map to take a struct refspec
 + fetch: convert do_fetch to take a struct refspec
 + refspec: remove the deprecated functions
 + fetch: convert refmap to use struct refspec
 + fetch: convert fetch_one to use struct refspec
 + transport-helper: convert to use struct refspec
 + remote: remove add_prune_tags_to_fetch_refspec
 + remote: convert fetch refspecs to struct refspec
 + remote: convert push refspecs to struct refspec
 + fast-export: convert to use struct refspec
 + clone: convert cmd_clone to use refspec_item_init
 + remote: convert match_push_refs to use struct refspec
 + remote: convert check_push_refs to use struct refspec
 + transport: convert transport_push to use struct refspec
 + pull: convert get_tracking_branch to use refspec_item_init
 + submodule--helper: convert push_check to use struct refspec
 + refspec: convert valid_fetch_refspec to use parse_refspec
 + refspec: introduce struct refspec
 + refspec: factor out parsing a single refspec
 + refspec: rename struct refspec to struct refspec_item
 + refspec: move refspec parsing logic into its own file
 (this branch is used by bw/ref-prefix-for-configured-refspec.)

 An API update for handling of refspecs used by fetch & push
 codepath.


* bc/hash-independent-tests (2018-05-21) 28 commits
  (merged to 'next' on 2018-05-24 at 40fb709f7c)
 + t5300: abstract away SHA-1-specific constants
 + t4208: abstract away SHA-1-specific constants
 + t4045: abstract away SHA-1-specific constants
 + t4042: abstract away SHA-1-specific constants
 + t4205: sort log output in a hash-independent way
 + t/lib-diff-alternative: abstract away SHA-1-specific constants
 + t4030: abstract away SHA-1-specific constants
 + t4029: abstract away SHA-1-specific constants
 + t4029: fix test indentation
 + t4022: abstract away SHA-1-specific constants
 + t4020: abstract away SHA-1-specific constants
 + t4014: abstract away SHA-1-specific constants
 + t4008: abstract away SHA-1-specific constants
 + t4007: abstract away SHA-1-specific constants
 + t3905: abstract away SHA-1-specific constants
 + t3702: abstract away SHA-1-specific constants
 + t3103: abstract away SHA-1-specific constants
 + t2203: abstract away SHA-1-specific constants
 + t: skip pack tests if not using SHA-1
 + t4044: skip test if not using SHA-1
 + t1512: skip test if not using SHA-1
 + t1007: annotate with SHA1 prerequisite
 + t0000: annotate with SHA1 prerequisite
 + t: switch $_x40 to $OID_REGEX
 + t/test-lib: introduce OID_REGEX
 + t: switch $_z40 to $ZERO_OID
 + t/test-lib: introduce ZERO_OID
 + t/test-lib: add an SHA1 prerequisite

 Many tests hardcode the raw object names, which would change once
 we migrate away from SHA-1.  While some of them must test against
 exact object names, most of them do not have to use hardcoded
 constants in the test.  The latter kind of tests have been updated
 to test the moral equivalent of the original without hardcoding the
 actual object names.


* bw/ref-prefix-for-configured-refspec (2018-05-18) 2 commits
  (merged to 'next' on 2018-05-24 at a0d4af6180)
 + fetch: generate ref-prefixes when using a configured refspec
 + refspec: consolidate ref-prefix generation logic
 (this branch uses bw/refspec-api.)

 "git fetch $there $refspec" that talks over protocol v2 can take
 advantage of server-side ref filtering; the code has been extended
 so that this mechanism triggers also when fetching with configured
 refspec.


* bw/remote-curl-compressed-responses (2018-05-23) 2 commits
  (merged to 'next' on 2018-05-24 at 98ee4308dc)
 + remote-curl: accept compressed responses with protocol v2
 + remote-curl: accept all encodings supported by curl

 Our HTTP client code used to advertise that we accept gzip encoding
 from the other side; instead, just let cURL library to advertise
 and negotiate the best one.


* cc/tests-without-assuming-ref-files-backend (2018-05-30) 2 commits
  (merged to 'next' on 2018-05-30 at e9605bacf0)
 + t990X: use '.git/objects' as 'deep inside .git' path
  (merged to 'next' on 2018-05-24 at 19138b162f)
 + t: make many tests depend less on the refs being files

 Quite a many tests assumed that newly created refs are made as
 loose refs using the files backend, which have been updated to use
 proper plumbing like rev-parse and update-ref, to avoid breakage
 once we start using different ref backends.


* en/rev-parse-invalid-range (2018-05-25) 1 commit
  (merged to 'next' on 2018-05-30 at aec27f8a94)
 + rev-parse: check lookup'ed commit references for NULL

 "git rev-parse Y..." etc. misbehaved when given endpoints were
 not committishes.


* jk/config-blob-sans-repo (2018-05-21) 1 commit
  (merged to 'next' on 2018-05-24 at 3426d9508c)
 + config: die when --blob is used outside a repository

 Error codepath fix.


* jk/snprintf-truncation (2018-05-21) 5 commits
  (merged to 'next' on 2018-05-24 at 4b78e15f66)
 + fmt_with_err: add a comment that truncation is OK
 + shorten_unambiguous_ref: use xsnprintf
 + fsmonitor: use internal argv_array of struct child_process
 + log_write_email_headers: use strbufs
 + http: use strbufs instead of fixed buffers

 Avoid unchecked snprintf() to make future code auditing easier.


* js/empty-config-section-fix (2018-05-18) 1 commit
  (merged to 'next' on 2018-05-24 at 3d0875c7b4)
 + config: a user-provided invalid section is not a BUG

 Error codepath fix.


* js/rebase-recreate-merge (2018-05-30) 2 commits
  (merged to 'next' on 2018-05-30 at e295dfb56e)
 + sequencer: ensure labels that are object IDs are rewritten
 + git-rebase--interactive: fix copy-paste mistake

 Hotfixes.


* ld/p4-unshelve (2018-05-24) 1 commit
  (merged to 'next' on 2018-05-30 at 7367508399)
 + git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.


* ma/config-store-data-clear (2018-05-21) 3 commits
  (merged to 'next' on 2018-05-24 at cc6e4b9371)
 + config: let `config_store_data_clear()` handle `key`
 + config: let `config_store_data_clear()` handle `value_regex`
 + config: free resources of `struct config_store_data`

 Leak plugging.


* ma/regex-no-regfree-after-comp-fail (2018-05-21) 1 commit
  (merged to 'next' on 2018-05-24 at 3e473da1b5)
 + regex: do not call `regfree()` if compilation fails

 We used to call regfree() after regcomp() failed in some codepaths,
 which have been corrected.


* ma/unpack-trees-free-msgs (2018-05-22) 4 commits
  (merged to 'next' on 2018-05-24 at 84cbd459f7)
 + unpack_trees_options: free messages when done
 + argv-array: return the pushed string from argv_push*()
 + merge-recursive: provide pair of `unpack_trees_{start,finish}()`
 + merge: setup `opts` later in `checkout_fast_forward()`

 Leak plugging.


* nd/command-list (2018-05-21) 17 commits
  (merged to 'next' on 2018-05-24 at 093e983b05)
 + completion: allow to customize the completable command list
 + completion: add and use --list-cmds=alias
 + completion: add and use --list-cmds=nohelpers
 + Move declaration for alias.c to alias.h
 + completion: reduce completable command list
 + completion: let git provide the completable command list
 + command-list.txt: documentation and guide line
 + help: use command-list.txt for the source of guides
 + help: add "-a --verbose" to list all commands with synopsis
 + git: support --list-cmds=list-<category>
 + completion: implement and use --list-cmds=main,others
 + git --list-cmds: collect command list in a string_list
 + git.c: convert --list-* to --list-cmds=*
 + Remove common-cmds.h
 + help: use command-list.h for common command list
 + generate-cmds.sh: export all commands to command-list.h
 + generate-cmds.sh: factor out synopsis extract code
 (this branch is used by nd/complete-config-vars.)

 The list of commands with their various attributes were spread
 across a few places in the build procedure, but it now is getting a
 bit more consolidated to allow more automation.


* nd/use-opt-int-set-f (2018-05-24) 1 commit
  (merged to 'next' on 2018-05-30 at f8f5d612ed)
 + Use OPT_SET_INT_F() for cmdline option specification

 Code simplification.


* pa/import-tars-long-names (2018-05-24) 1 commit
  (merged to 'next' on 2018-05-30 at 5e043b2fca)
 + import-tars: read overlong names from pax extended header

 The import-tars script (in contrib/) has been taught to handle
 tarballs with overly long paths that use PAX extended headers.


* rd/doc-options-placeholder (2018-05-25) 1 commit
  (merged to 'next' on 2018-05-30 at e3961b038f)
 + Use proper syntax for replaceables in command docs

 Docfix.


* rd/init-typo (2018-05-30) 1 commit
  (merged to 'next' on 2018-05-30 at 8813a649eb)
 + init: fix grammar in "templates not found" msg

 Message fix.


* rd/tag-doc-lightweight (2018-05-29) 1 commit
  (merged to 'next' on 2018-05-30 at 979ba9f720)
 + tag: clarify in the doc that a tag can refer to a non-commit object

 Docfix.


* sb/grep-die-on-unreadable-index (2018-05-16) 1 commit
  (merged to 'next' on 2018-05-24 at 6d78916503)
 + grep: handle corrupt index files early

 Error behaviour of "git grep" when it cannot read the index was
 inconsistent with other commands that uses the index, which has
 been corrected to error out early.


* sb/submodule-merge-in-merge-recursive (2018-05-18) 3 commits
  (merged to 'next' on 2018-05-24 at 6228d22182)
 + merge-recursive: give notice when submodule commit gets fast-forwarded
 + merge-recursive: i18n submodule merge output and respect verbosity
 + submodule.c: move submodule merging to merge-recursive.c

 By code restructuring of submodule merge in merge-recursive,
 informational messages from the codepath are now given using the
 same mechanism as other output, and honor the merge.verbosity
 configuration.  The code also learned to give a few new messages
 when a submodule three-way merge resolves cleanly when one side
 records a descendant of the commit chosen by the other side.

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


* jh/json-writer (2018-03-28) 1 commit
 - json_writer: new routines to create data in JSON format

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


* is/parsing-line-range (2018-06-01) 2 commits
 . log: prevent error if line range ends past end of file
 . blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.

 Updated.   Still seems to break a few tests.


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


* pb/bisect-helper-2 (2017-10-28) 8 commits
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


* mk/http-backend-content-length (2017-11-27) 4 commits
 - SQUASH???
 - t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
 - SQUASH???
 - http-backend: respect CONTENT_LENGTH as specified by rfc3875

 The http-backend (used for smart-http transport) used to slurp the
 whole input until EOF, without paying attention to CONTENT_LENGTH
 that is supplied in the environment and instead expecting the Web
 server to close the input stream.  This has been fixed.

 Expecting a reroll.
 Suggested fixes to be used when rerolling is queued, but I'd
 prefer _not_ squashing them myself.

 Also, it may be too complex solution for the problem.
 cf. <20171204171308.GA13332@sigill.intra.peff.net>


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


* jt/submodule-pull-recurse-rebase (2018-05-25) 1 commit
  (merged to 'next' on 2018-06-01 at cd3e2a1008)
 + submodule: do not pass null OID to setup_revisions

 "git pull -recurse-submodules --rebase", when the submodule
 repository's history did not have anything common between ours and
 the upstream's, failed to execute.  We need to fetch from them to
 continue even in such a case.

 Will merge to 'master'.


* ma/wrapped-info (2018-05-28) 2 commits
 - usage: prefix all lines in `vreportf()`, not just the first
 - usage: extract `prefix_suffix_lines()` from `advise()`

 An attempt to help making multi-line messages fed to warning(),
 error(), and friends more easily translatable.

 Wait for discussion to settle.
 cf. <20180529213957.GF7964@sigill.intra.peff.net>


* nd/complete-config-vars (2018-05-29) 13 commits
 - completion: complete general config vars in two steps
 - log-tree: allow to customize 'grafted' color
 - completion: support case-insensitive config vars
 - completion: keep other config var completion in camelCase
 - completion: drop the hard coded list of config vars
 - am: move advice.amWorkDir parsing back to advice.c
 - advice: keep config name in camelCase in advice_config[]
 - fsck: produce camelCase config key names
 - help: add --config to list all available config
 - fsck: factor out msg_id_info[] lazy initialization code
 - grep: keep all colors in an array
 - Add and use generic name->id mapping code for color slot parsing
 - Merge branch 'nd/command-list' into nd/complete-config-vars

 Continuing with the idea to programatically enumerate various
 pieces of data required for command line completion, teach the
 codebase to report the list of configuration variables
 subcommands care about to help complete them.

 Will merge to and cook in 'next'.


* nd/completion-negation (2018-05-29) 3 commits
 - completion: collapse extra --no-.. options
 - completion: suppress some -no- options
 - parse-options: option to let --git-completion-helper show negative form

 Continuing with the idea to programatically enumerate various
 pieces of data required for command line completion, the codebase
 has been taught to enumerate options prefixed with "--no-" to
 negate them.

 Will merge to and cook in 'next'.


* jm/cache-entry-from-mem-pool (2018-05-24) 7 commits
 - block alloc: add validations around cache_entry lifecyle
 - block alloc: allocate cache entries from mem_pool
 - mem-pool: fill out functionality
 - mem-pool: add lifecycle management functions
 - mem-pool: only search head block for available space
 - block alloc: add lifecycle APIs for cache_entry structs
 - read-cache: teach refresh_cache_entry() to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 Is this ready for 'next'?


* rm/p4-submit-with-commit-option (2018-05-21) 1 commit
 - git-p4: add options --commit and --disable-rebase

 Needs sign-off.


* ds/commit-graph-lockfile-fix (2018-05-22) 1 commit
  (merged to 'next' on 2018-05-24 at 3d12a02b0c)
 + commit-graph: fix UX issue when .lock file exists
 (this branch is used by ds/commit-graph-fsck; uses ds/generation-numbers.)

 Update to ds/generation-numbers topic.

 Wait for ds/generation-numbers


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

 Will merge to and cook in 'next'.


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
 - alloc: allow arbitrary repositories for alloc functions
 - object: allow create_object to handle arbitrary repositories
 - object: allow grow_object_hash to handle arbitrary repositories
 - alloc: add repository argument to alloc_commit_index
 - alloc: add repository argument to alloc_report
 - alloc: add repository argument to alloc_object_node
 - alloc: add repository argument to alloc_tag_node
 - alloc: add repository argument to alloc_commit_node
 - alloc: add repository argument to alloc_tree_node
 - alloc: add repository argument to alloc_blob_node
 - object: add repository argument to grow_object_hash
 - object: add repository argument to create_object
 - repository: introduce parsed objects field
 (this branch is used by sb/object-store-grafts.)

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.

 Will merge to and cook in 'next'.


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
