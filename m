Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63D0200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEGO6t (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:58:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40544 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGO6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:58:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so29083413wrc.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=CeIgtWbiaAUxbBszNyulLzOY66IRbGUTuWkNWWn/wlU=;
        b=QsISav2cvcKzybqudJD+WeggjXOjfYgYazNylizjLcLlGFxUr/v8wP0+T+7rSOQ49k
         RxdniVZoV9YZ21oH/CXeK43ADq1C2vQTOHvXRrvfMC0kgTEcEcdi1Z9+W/NnbpW35+Rk
         UkWFqYDUOkU9KQGvlklMoP2ee24WbAyUrWFkf38hGKnLPziYg8W6FFCh3ltd7Ltr14+W
         DlP/owr5apLz/IyrdZZkCDJ5k/vMPQnBZv3gzRSikcPLl4QqcHeRPFMhszqsUlPjIG7q
         hKfsefmxeUItS2bvc0DjVRzn3LFqJOkVim5844HDbW6GTHNleMnqUaX9walGewYoN/U8
         V0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=CeIgtWbiaAUxbBszNyulLzOY66IRbGUTuWkNWWn/wlU=;
        b=hIhDh8TaywsTEvPlbLrUIUG8JzC/WxpEoUg+5w/dEHDuUUYp6iW3AHLF9ArXr3yYDk
         QWOI2ccABa/B6piShUAZL1kIp4gqtIffvn8PTjnDkqBrDRsilxQq+TLcHWL/X0wroy6m
         OyGaT5HLZXYtfg848Uf83yKdbnxAjjBNJ75FQ1o92r6kV9zjwvLW4Kc4EtH/6kmJkozh
         NeoAT6PUUqlD3O/3q4iG3O/wn9tZv73KEPk30IvOOsu/s893EuXEd4TamOFW4teDGr8D
         J2PP9xVpZIpAkQbWyEZ5BJ9A8OFwHcQIUNHccnhOmA2kixQiRbSSJTki1+cX2+7rgX4i
         /g4w==
X-Gm-Message-State: ALQs6tB5mqlXgTDqBMXVshdBEgIl8+NNpZgDYt/h8ys1X9qixlme7M+w
        0ap+Gepl1z/W8geAnkgKA5vvXyjKl6eM9g==
X-Google-Smtp-Source: AB8JxZqEmNjPb4T/0qJ7pIuVrj+ZqRqbIlbhQnied8JtEWh4FnlqasQLJNWT84iRt6L1/Qq6+q8WsA==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr31611212wrb.145.1525705123474;
        Mon, 07 May 2018 07:58:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k89-v6sm9604209wmc.46.2018.05.07.07.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 07:58:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2018, #01; Mon, 7)
X-master-at: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
X-next-at: d54016d9e3a3ac00b0483d3779ff96f3882b7094
Date:   Mon, 07 May 2018 23:58:41 +0900
Message-ID: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
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

* tb/test-apfs-utf8-normalization (2018-05-02) 1 commit
 - test: correct detection of UTF8_NFD_TO_NFC for APFS

 A test to see if the filesystem normalizes UTF-8 filename has been
 updated to check what we need to know in a more direct way, i.e. a
 path created in NFC form can be accessed with NFD form (or vice
 versa) to cope with APFS as well as HFS.

 Will merge to 'next'.


* ab/get-short-oid (2018-05-02) 12 commits
 - get_short_oid: document & warn if we ignore the type selector
 - config doc: document core.disambiguate
 - get_short_oid / peel_onion: ^{commit} should be commit, not committish
 - get_short_oid / peel_onion: ^{tree} should be tree, not treeish
 - get_short_oid: learn to disambiguate by ^{blob}
 - get_short_oid: learn to disambiguate by ^{tag}
 - get_short_oid: sort ambiguous objects by type, then SHA-1
 - sha1-name.c: move around the collect_ambiguous() function
 - cache.h: add comment explaining the order in object_type
 - git-p4: change "commitish" typo to "committish"
 - sha1-array.h: align function arguments
 - sha1-name.c: remove stray newline


* ah/misc-doc-updates (2018-05-06) 7 commits
 - doc: normalize [--options] to [options] in git-diff
 - doc: add note about shell quoting to revision.txt
 - git-svn: remove ''--add-author-from' for 'commit-diff'
 - doc: add '-d' and '-o' for 'git push'
 - doc: clarify ignore rules for git ls-files
 - doc: align 'diff --no-index' in text and synopsis
 - doc: improve formatting in githooks.txt

 Misc doc fixes.

 Will merge to 'next'.


* bc/format-patch-cover-no-attach (2018-05-02) 1 commit
 - format-patch: make cover letters always text/plain

 "git format-patch --cover --attach" created a broken MIME multipart
 message for the cover letter, which has been fixed by keeping the
 cover letter as plain text file.

 Will merge to 'next'.


* bp/test-drop-caches (2018-05-04) 1 commit
 - test-drop-caches: simplify delay loading of NtSetSystemInformation

 Code simplification.

 Will merge to 'next'.


* cc/perf-bisect (2018-05-06) 1 commit
 - perf/bisect_run_script: disable codespeed

 Performance test updates.

 Will merge to 'next'.


* cf/submodule-progress-dissociate (2018-05-04) 3 commits
 - submodule: add --dissociate option to add/update commands
 - submodule: add --progress option to add command
 - submodule: clean up subsititions in script

 "git submodule update" and "git submodule add" supported the
 "--reference" option to borrow objects from a neighbouring local
 repository like "git clone" does, but lacked the more recent
 invention "--dissociate".  Also "git submodule add" has been taught
 to take the "--progress" option.

 Is this ready for 'next'?  Should "git submodule -h" list the new
 options in its short help?


* dd/send-email-reedit (2018-05-06) 1 commit
 - git-send-email: allow re-editing of message

 "git send-email" can sometimes offer confirmation dialog "Send this
 email?" with choices 'Yes', 'No', 'Quit', and 'All'.  A new action
 'Edit' has been added to this dialog's choice.
 
 Waiting briefly for an ack or two.
 cf. <xmqq4ljlsahj.fsf@gitster-ct.c.googlers.com>


* em/status-rename-config (2018-05-06) 1 commit
 - wt-status: use settings from git_diff_ui_config

 "git status" learned to pay attention to UI related diff
 configuration variables such as diff.renames.

 Will merge to 'next'.


* jm/cache-entry-from-mem-pool (2018-05-02) 5 commits
 - block alloc: add validations around cache_entry lifecyle
 - block alloc: allocate cache entries from mem_pool
 - mem-pool: fill out functionality
 - block alloc: add lifecycle APIs for cache_entry structs
 - read-cache: teach refresh_cache_entry() to take istate

 For a large tree, the index needs to hold many cache entries
 allocated on heap.  These cache entries are now allocated out of a
 dedicated memory pool to amortize malloc(3) overhead.

 Needs review.  
 Is the "caller always knows which pool an entry came from and calls
 the right kind of free" a feasible approach?


* js/branch-diff (2018-05-06) 18 commits
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


* js/sequencer-and-root-commits (2018-05-06) 6 commits
 - rebase --rebase-merges: root commits can be cousins, too
 - rebase --rebase-merges: a "merge" into a new root is a fast-forward
 - sequencer: allow introducing new root commits
 - rebase -i --root: let the sequencer handle even the initial part
 - sequencer: learn about the special "fake root commit" handling
 - sequencer: extract helper to update active_cache_tree
 (this branch uses js/rebase-recreate-merge.)

 The implementation of "git rebase -i --root" has been updaed to use
 the sequencer machinery more.

 Will merge to 'next'.


* js/use-bug-macro (2018-05-06) 4 commits
 - Convert remaining die*(BUG) messages
 - Replace all die("BUG: ...") calls by BUG() ones
 - run-command: use BUG() to report bugs, not die()
 - test-tool: help verifying BUG() code paths


* jt/partial-clone-proto-v2 (2018-05-06) 4 commits
 - {fetch,upload}-pack: support filter in protocol v2
 - upload-pack: read config when serving protocol v2
 - upload-pack: fix error message typo
 - Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2
 (this branch uses bw/protocol-v2; is tangled with bw/server-options.)

 Transfer protocol v2 learned to support the partial clone.

 Will merge to 'next'.


* ma/doc-expand-tabs (2018-05-02) 1 commit
 - revisions.txt: expand tabs to spaces in diagram

 Fix one instance of asciidoctor's misformatting by expanding a tab
 into spaces in a literal block.

 Will discard.  This approach is less maintainable than the approach
 taken by bc/asciidoctor-tab-width topic.


* nd/completion-aliasfiletype-typofix (2018-05-06) 1 commit
 - completion: fix misspelled config key aliasesfiletype

 Typofix.

 Will merge to 'next'.


* nd/doc-header (2018-05-02) 1 commit
 - doc: keep first level section header in upper case

 Doc formatting fix.

 Will merge to 'next'.


* nd/pack-unreachable-objects-doc (2018-05-06) 1 commit
 - pack-objects: validation and documentation about unreachable options

 Doc update.

 Will merge to 'next'.


* sb/object-store-alloc (2018-05-02) 14 commits
 - alloc.c: include alloc.h
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
 - repository: introduce object parser field
 (this branch uses sb/object-store-replace and sb/oid-object-info.)

 The conversion to pass "the_repository" and then "a_repository"
 throughout the object access API continues.


* tb/grep-column (2018-05-06) 7 commits
 - contrib/git-jump/git-jump: jump to match column in addition to line
 - grep.c: add configuration variables to show matched option
 - builtin/grep.c: add '--column' option to 'git-grep(1)'
 - grep.c: display column number of first match
 - grep.[ch]: extend grep_opt to allow showing matched column
 - grep.c: expose matched column in match_line()
 - Documentation/config.txt: camel-case lineNumber for consistency

 "git grep" learned the "--column" option that gives not just the
 line number but the column number of the hit.


* bc/asciidoctor-tab-width (2018-05-07) 2 commits
 - Documentation: render revisions correctly under Asciidoctor
 - Documentation: use 8-space tabs with Asciidoctor

 Asciidoctor gives a reasonable imitation for AsciiDoc, but does not
 render illustration in a literal block correctly when indented with
 HT by default. The problem is fixed by forcing 8-space tabs.

 Will merge to 'next'.


* bc/mailmap-self (2018-05-07) 1 commit
 - mailmap: update brian m. carlson's email address

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Expecting a response to review comments
 e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


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


* is/parsing-line-range (2018-04-27) 2 commits
 . log: prevent error if line range ends past end of file
 . blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.

 Seems to break a few tests.


* ld/p4-unshelve (2018-02-22) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will hold, perhaps drop and use format-change that uses a proper "diff".
 cf. <CAE5ih7_ooDMqVtTMoQ70s5XCkncr04HY0JkqSp1UmKQeG81oaA@mail.gmail.com>


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

* cc/perf-aggregate-unknown-option (2018-04-26) 1 commit
 - perf/aggregate: use Getopt::Long for option parsing

 Perf-test helper updates.

 Will merge to 'next'.


* ab/perl-python-attrs (2018-04-27) 3 commits
 - .gitattributes: add a diff driver for Python
 - .gitattributes: use the "perl" differ for Perl
 - .gitattributes: add *.pl extension for Perl

 We learned that our source files with ".pl" and ".py" extensions
 are Perl and Python files respectively and changes to them are
 better viewed as such with appropriate diff drivers.

 Will merge to 'next'.


* js/test-unset-prereq (2018-04-30) 1 commit
 - tests: introduce test_unset_prereq, for debugging

 Test debugging aid.

 Will merge to 'next'.
 cf. <20180507115950.3887-1-szeder.dev@gmail.com>


* fg/completion-external (2018-04-30) 1 commit
 - completion: load completion file for external subcommand

 The command line completion mechanism (in contrib/) learned to load
 custom completion file for "git $command" where $command is a
 custom "git-$command" that the end user has on the $PATH when using
 newer version of bash.

 Will merge to 'next'.
 cf. <CAM0VKjkTu+OkLM3gvX73mWugxArCVmqRBmWGHiKuLiLRNkkNow@mail.gmail.com>


* ma/double-dashes-in-docs (2018-04-18) 4 commits
  (merged to 'next' on 2018-04-25 at aaac2dc63c)
 + git-submodule.txt: quote usage in monospace, drop backslash
 + git-[short]log.txt: unify quoted standalone --
 + doc: convert [\--] to [--]
 + doc: convert \--option to --option

 Doc formatting updates.

 Will merge to 'master'.


* sb/worktree-remove-opt-force (2018-04-18) 1 commit
  (merged to 'next' on 2018-04-25 at 0367d52a4b)
 + worktree: accept -f as short for --force for removal

 "git worktree remove" learned that "-f" is a shorthand for
 "--force" option, just like for "git worktree add".

 Will merge to 'master'.


* sg/completion-clear-cached (2018-04-18) 1 commit
  (merged to 'next' on 2018-04-25 at 9178da6c3d)
 + completion: reduce overhead of clearing cached --options

 The completion script (in contrib/) learned to clear cached list of
 command line options upon dot-sourcing it again in a more efficient
 way.

 Will merge to 'master'.


* sg/doc-gc-quote-mismatch-fix (2018-04-18) 1 commit
  (merged to 'next' on 2018-04-25 at bc3d1abf45)
 + docs/git-gc: fix minor rendering issue

 Doc formatting fix.

 Will merge to 'master'.


* js/ident-date-fix (2018-04-19) 1 commit
  (merged to 'next' on 2018-04-30 at d50ec2f4c1)
 + sequencer: reset the committer date before commits

 During a "rebase -i" session, the code could give older timestamp
 to commits created by later "pick" than an earlier "reword", which
 has been corrected.

 Will merge to 'master'.


* nd/submodule-status-fix (2018-04-19) 1 commit
  (merged to 'next' on 2018-04-30 at 34d1f9ca83)
 + submodule--helper: don't print null in 'submodule status'

 "git submodule status" did not check the symbolic revision name it
 computed for the submodule HEAD is not the NULL, and threw it at
 printf routines, which has been corrected.

 Will merge to 'master'.


* sa/send-email-dedup-some-headers (2018-04-19) 1 commit
  (merged to 'next' on 2018-04-30 at 2a1fd8217e)
 + send-email: avoid duplicate In-Reply-To/References

 When fed input that already has In-Reply-To: and/or References:
 headers and told to add the same information, "git send-email"
 added these headers separately, instead of appending to an existing
 one, which is a violation of the RFC.  This has been corrected.

 Will merge to 'master'.


* tg/demote-stash-save-in-completion (2018-04-20) 2 commits
  (merged to 'next' on 2018-04-30 at 93d0af5375)
 + completion: make stash -p and alias for stash push -p
 + completion: stop showing 'save' for stash by default

 The command line completion (in contrib/) has been taught that "git
 stash save" has been deprecated ("git stash push" is the preferred
 spelling in the new world) and does not offer it as a possible
 completion candidate when "git stash push" can be.

 Will merge to 'master'.


* tz/doc-git-urls-reference (2018-04-20) 1 commit
  (merged to 'next' on 2018-04-30 at 39926c99fd)
 + doc/clone: update caption for GIT URLS cross-reference

 Doc fix.

 Will merge to 'master'.


* js/deprecate-grafts (2018-04-30) 12 commits
 - Remove obsolete script to convert grafts to replace refs
 - technical/shallow: describe why shallow cannot use replace refs
 - technical/shallow: stop referring to grafts
 - filter-branch: stop suggesting to use grafts
 - Deprecate support for .git/info/grafts
 - Add a test for `git replace --convert-graft-file`
 - replace: introduce --convert-graft-file
 - replace: prepare create_graft() for converting graft files wholesale
 - replace: "libify" create_graft() and callees
 - replace: avoid using die() to indicate a bug
 - commit: Let the callback of for_each_mergetag return on error
 - argv_array: offer to split a string by whitespace

 The functionality of "$GIT_DIR/info/grafts" has been superseded by
 the "refs/replace/" mechanism for some time now, but the internal
 code had support for it in many places, which has been cleaned up
 in order to drop support of the "grafts" mechanism.

 Will merge to 'next'.


* js/rebase-i-clean-msg-after-fixup-continue (2018-05-02) 4 commits
 - rebase --skip: clean up commit message after a failed fixup/squash
 - sequencer: always commit without editing when asked for
 - rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
 - rebase -i: demonstrate bugs with fixup!/squash! commit messages

 "git rebase -i" sometimes left intermediate "# This is a
 combination of N commits" message meant for the human consumption
 inside an editor in the final result in certain corner cases, which
 has been fixed.

 Will merge to 'next'.


* ma/fast-export-skip-merge-fix (2018-04-21) 1 commit
  (merged to 'next' on 2018-04-30 at f7fca02ab1)
 + fast-export: fix regression skipping some merge-commits

 "git fast-export" had a regression in v2.15.0 era where it skipped
 some merge commits in certain cases, which has been corrected.

 Will merge to 'master'.


* bw/server-options (2018-04-24) 4 commits
 - fetch: send server options when using protocol v2
 - ls-remote: send server options when using protocol v2
 - serve: introduce the server-option capability
 - Merge branch 'bw/protocol-v2' into HEAD
 (this branch uses bw/protocol-v2; is tangled with jt/partial-clone-proto-v2.)

 The transport protocol v2 is getting updated further.

 Will merge to 'next'.


* jc/parseopt-expiry-errors (2018-04-23) 2 commits
  (merged to 'next' on 2018-04-30 at 637085f3d8)
 + parseopt: handle malformed --expire arguments more nicely
 + gc: do not upcase error message shown with die()

 "git gc --prune=nonsense" spent long time repacking and then
 silently failed when underlying "git prune --expire=nonsense"
 failed to parse its command line.  This has been corrected.

 Will merge to 'master'.


* js/colored-push-errors (2018-04-24) 4 commits
  (merged to 'next' on 2018-04-30 at 31076c52a2)
 + config: document the settings to colorize push errors/hints
 + push: test to verify that push errors are colored
 + push: colorize errors
 + color: introduce support for colorizing stderr

 Error messages from "git push" can be painted for more visibility.

 Will merge to 'master'.


* js/runtime-prefix (2018-04-24) 8 commits
  (merged to 'next' on 2018-04-30 at c6cfccf40e)
 + Avoid multiple PREFIX definitions
 + git_setup_gettext: plug memory leak
 + gettext: avoid initialization if the locale dir is not present
  (merged to 'next' on 2018-04-17 at a69aaa7a22)
 + mingw/msvc: use the new-style RUNTIME_PREFIX helper
 + exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 + exec_cmd: RUNTIME_PREFIX on some POSIX systems
 + Makefile: add Perl runtime prefix support
 + Makefile: generate Perl header from template file
 (this branch is tangled with dj/runtime-prefix.)

 Will merge to 'master'.


* ma/http-walker-no-partial (2018-04-24) 2 commits
  (merged to 'next' on 2018-04-30 at 4582c99ba8)
 + walker: drop fields of `struct walker` which are always 1
 + http-fetch: make `-a` standard behaviour

 "git http-fetch" (deprecated) had an optional and experimental
 "feature" to fetch only commits and/or trees, which nobody used.
 This has been removed.

 Will merge to 'master'.


* bc/object-id (2018-05-02) 42 commits
 - merge-one-file: compute empty blob object ID
 - add--interactive: compute the empty tree value
 - Update shell scripts to compute empty tree object ID
 - sha1_file: only expose empty object constants through git_hash_algo
 - dir: use the_hash_algo for empty blob object ID
 - sequencer: use the_hash_algo for empty tree object ID
 - cache-tree: use is_empty_tree_oid
 - sha1_file: convert cached object code to struct object_id
 - builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
 - builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
 - wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
 - submodule: convert several uses of EMPTY_TREE_SHA1_HEX
 - sequencer: convert one use of EMPTY_TREE_SHA1_HEX
 - merge: convert empty tree constant to the_hash_algo
 - builtin/merge: switch tree functions to use object_id
 - builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
 - sha1-file: add functions for hex empty tree and blob OIDs
 - builtin/receive-pack: avoid hard-coded constants for push certs
 - diff: specify abbreviation size in terms of the_hash_algo
 - upload-pack: replace use of several hard-coded constants
 - revision: replace use of hard-coded constants
 - http: eliminate hard-coded constants
 - dir: convert struct untracked_cache_dir to object_id
 - commit: convert uses of get_sha1_hex to get_oid_hex
 - index-pack: abstract away hash function constant
 - pack-redundant: convert linked lists to use struct object_id
 - Update struct index_state to use struct object_id
 - split-index: convert struct split_index to object_id
 - submodule-config: convert structures to object_id
 - fsck: convert static functions to struct object_id
 - tree-walk: convert get_tree_entry_follow_symlinks to object_id
 - tree-walk: avoid hard-coded 20 constant
 - pack-redundant: abstract away hash algorithm
 - pack-objects: abstract away hash algorithm
 - packfile: abstract away hash constant values
 - packfile: convert find_pack_entry to object_id
 - sha1-file: convert freshen functions to object_id
 - packfile: convert has_sha1_pack to object_id
 - packfile: remove unused member from struct pack_entry
 - Remove unused member in struct object_context
 - server-info: remove unused members from struct pack_info
 - cache: add a function to read an object ID from a buffer

 Conversion from uchar[20] to struct object_id continues.


* sb/oid-object-info (2018-04-26) 9 commits
 - cache.h: allow oid_object_info to handle arbitrary repositories
 - packfile: add repository argument to cache_or_unpack_entry
 - packfile: add repository argument to unpack_entry
 - packfile: add repository argument to read_object
 - packfile: add repository argument to packed_object_info
 - packfile: add repository argument to packed_to_object_type
 - packfile: add repository argument to retry_bad_packed_offset
 - cache.h: add repository argument to oid_object_info
 - cache.h: add repository argument to oid_object_info_extended
 (this branch is used by sb/object-store-alloc; uses sb/object-store-replace.)

 The codepath around object-info API has been taught to take the
 repository object (which in turn tells the API which object store
 the objects are to be located).

 Will merge to 'next'.


* en/unpack-trees-split-index-fix (2018-05-02) 1 commit
 - unpack_trees: fix breakage when o->src_index != o->dst_index

 The split-index feature had a long-standing and dormant bug in
 certain use of the in-core merge machinery, which has been fixed.

 Will merge to 'next'.
 cf. <CACsJy8CeDhrT9GXe9q5gqsAeq_sSQ8jyF2nMOFxzjwKtE31oPQ@mail.gmail.com>


* bp/merge-rename-config (2018-05-04) 3 commits
 - merge: pass aggressive when rename detection is turned off
 - merge: add merge.renames config setting
 - merge: update documentation for {merge,diff}.renameLimit
 (this branch uses en/rename-directory-detection-reboot.)


* en/git-debugger (2018-04-25) 1 commit
 - Make running git under other debugger-like programs easy

 Dev support.

 Will merge to 'next'.


* js/no-pager-shorthand (2018-05-04) 1 commit
 - git: add -P as a short option for --no-pager

 "git --no-pager cmd" did not have short-and-sweet single letter
 option. Now it does.

 Will merge to 'next'.


* sb/diff-color-move-more (2018-04-25) 7 commits
 - diff.c: add --color-moved-ignore-space-delta option
 - diff.c: decouple white space treatment from move detection algorithm
 - diff.c: add a blocks mode for moved code detection
 - diff.c: adjust hash function signature to match hashmap expectation
 - diff.c: do not pass diff options as keydata to hashmap
 - xdiff/xdiffi.c: remove unneeded function declarations
 - xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.


* so/glossary-ancestor (2018-04-17) 1 commit
  (merged to 'next' on 2018-04-25 at 0a849fee00)
 + glossary: substitute "ancestor" for "direct ancestor" in 'push' description.

 Docfix.

 Will merge to 'master'.


* bt/gpg-interface (2018-04-16) 7 commits
  (merged to 'next' on 2018-04-30 at 50c507b7d8)
 + gpg-interface: find the last gpg signature line
 + gpg-interface: extract gpg line matching helper
 + gpg-interface: fix const-correctness of "eol" pointer
 + gpg-interface: use size_t for signature buffer size
 + gpg-interface: modernize function declarations
 + gpg-interface: handle bool user.signingkey
 + t7004: fix mistaken tag name

 What is queued here is only the obviously correct and
 uncontroversial code clean-up part, which is an earlier 7 patches,
 of a larger series.

 The remainder that is not queued introduces a few configuration
 variables to deal with e-signature backends with different
 signature format.

 Will merge to 'master'.


* ds/generation-numbers (2018-05-02) 11 commits
 - commit-graph.txt: update design document
 - merge: check config before loading commits
 - commit: use generation number in remove_redundant()
 - commit: add short-circuit to paint_down_to_common()
 - commit: use generation numbers for in_merge_bases()
 - ref-filter: use generation number for --contains
 - commit-graph: always load commit-graph information
 - commit: use generations in paint_down_to_common()
 - commit-graph: compute generation numbers
 - commit: add generation number to struct commmit
 - ref-filter: fix outdated comment on in_commit_list
 (this branch uses ds/commit-graph and ds/lazy-load-trees.)

 A recently added "commit-graph" datafile has learned to store
 pre-computed generation numbers to speed up the decisions to stop
 history traversal.

 Is this ready for 'next'?


* en/rename-directory-detection-reboot (2018-04-25) 36 commits
 - merge-recursive: fix check for skipability of working tree updates
 - merge-recursive: make "Auto-merging" comment show for other merges
 - merge-recursive: fix remainder of was_dirty() to use original index
 - merge-recursive: fix was_tracked() to quit lying with some renamed paths
 - t6046: testcases checking whether updates can be skipped in a merge
 - merge-recursive: avoid triggering add_cacheinfo error with dirty mod
 - merge-recursive: move more is_dirty handling to merge_content
 - merge-recursive: improve add_cacheinfo error handling
 - merge-recursive: avoid spurious rename/rename conflict from dir renames
 - directory rename detection: new testcases showcasing a pair of bugs
 - merge-recursive: fix remaining directory rename + dirty overwrite cases
 - merge-recursive: fix overwriting dirty files involved in renames
 - merge-recursive: avoid clobbering untracked files with directory renames
 - merge-recursive: apply necessary modifications for directory renames
 - merge-recursive: when comparing files, don't include trees
 - merge-recursive: check for file level conflicts then get new name
 - merge-recursive: add computation of collisions due to dir rename & merging
 - merge-recursive: check for directory level conflicts
 - merge-recursive: add get_directory_renames()
 - merge-recursive: make a helper function for cleanup for handle_renames
 - merge-recursive: split out code for determining diff_filepairs
 - merge-recursive: make !o->detect_rename codepath more obvious
 - merge-recursive: fix leaks of allocated renames and diff_filepairs
 - merge-recursive: introduce new functions to handle rename logic
 - merge-recursive: move the get_renames() function
 - directory rename detection: tests for handling overwriting dirty files
 - directory rename detection: tests for handling overwriting untracked files
 - directory rename detection: miscellaneous testcases to complete coverage
 - directory rename detection: testcases exploring possibly suboptimal merges
 - directory rename detection: more involved edge/corner testcases
 - directory rename detection: testcases checking which side did the rename
 - directory rename detection: files/directories in the way of some renames
 - directory rename detection: partially renamed directory testcase/discussion
 - directory rename detection: testcases to avoid taking detection too far
 - directory rename detection: directory splitting testcases
 - directory rename detection: basic testcases
 (this branch is used by bp/merge-rename-config.)

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  Incidentally, this avoids updating a file in the
 working tree after a (non-trivial) merge whose result matches what
 our side originally had.

 Will merge to 'next'.


* nd/command-list (2018-04-30) 10 commits
 - completion: let git provide the completable command list
 - help: use command-list.txt for the source of guides
 - help: add "-a --verbose" to list all commands with synopsis
 - git: support --list-cmds=list-<category>
 - completion: implement and use --list-cmds=main,others
 - git.c: convert --list-*builtins to --list-cmds=*
 - Remove common-cmds.h
 - help: use command-list.h for common command list
 - generate-cmds.sh: export all commands to command-list.h
 - generate-cmds.sh: factor out synopsis extract code

 The list of commands with their various attributes were spread
 across a few places in the build procedure, but it now is getting a
 bit more consolidated to allow more automation.

 Is this ready for 'next'.


* sb/object-store-replace (2018-04-12) 15 commits
  (merged to 'next' on 2018-04-25 at 9a213fb505)
 + replace-object: allow lookup_replace_object to handle arbitrary repositories
 + replace-object: allow do_lookup_replace_object to handle arbitrary repositories
 + replace-object: allow prepare_replace_object to handle arbitrary repositories
 + refs: allow for_each_replace_ref to handle arbitrary repositories
 + refs: store the main ref store inside the repository struct
 + replace-object: add repository argument to lookup_replace_object
 + replace-object: add repository argument to do_lookup_replace_object
 + replace-object: add repository argument to prepare_replace_object
 + refs: add repository argument to for_each_replace_ref
 + refs: add repository argument to get_main_ref_store
 + replace-object: check_replace_refs is safe in multi repo environment
 + replace-object: eliminate replace objects prepared flag
 + object-store: move lookup_replace_object to replace-object.h
 + replace-object: move replace_map to object store
 + replace_object: use oidmap
 (this branch is used by sb/object-store-alloc and sb/oid-object-info.)

 The effort to pass the repository in-core structure throughout the
 API continues.  This round deals with the code that implements the
 refs/replace/ mechanism.

 Will merge to 'master'.


* sg/complete-paths (2018-04-17) 11 commits
 - completion: fill COMPREPLY directly when completing paths
 - completion: improve handling quoted paths in 'git ls-files's output
 - completion: remove repeated dirnames with 'awk' during path completion
 - t9902-completion: ignore COMPREPLY element order in some tests
 - completion: use 'awk' to strip trailing path components
 - completion: let 'ls-files' and 'diff-index' filter matching paths
 - completion: improve handling quoted paths on the command line
 - completion: support completing non-ASCII pathnames
 - completion: simplify prefix path component handling during path completion
 - completion: move __git_complete_index_file() next to its helpers
 - t9902-completion: add tests demonstrating issues with quoted pathnames

 Command line completion (in contrib/) learned to complete pathnames
 for various commands better.

 Will merge to 'next'.


* tq/t1510 (2018-04-17) 1 commit
  (merged to 'next' on 2018-04-25 at 5710c81979)
 + t1510-repo-setup.sh: remove useless mkdir

 Test cleanup.

 Will merge to 'master'.


* sb/blame-color (2018-04-24) 3 commits
 - builtin/blame: add new coloring scheme config
 - builtin/blame: highlight recently changed lines
 - builtin/blame: dim uninteresting metadata lines

 "git blame" learns to unhighlight uninteresting metadata from the
 originating commit on lines that are the same as the previous one,
 and also paint lines in different colors depending on the age of
 the commit.

 Is this ready for 'next'?


* ab/simplify-perl-makefile (2018-04-19) 2 commits
  (merged to 'next' on 2018-04-25 at 906cf21682)
 + Makefile: mark perllibdir as a .PHONY target
  (merged to 'next' on 2018-04-17 at 4448756934)
 + perl: fix installing modules from contrib

 Recent simplification of build procedure forgot a bit of tweak to
 the build procedure of contrib/mw-to-git/

 Will merge to 'master'.


* ds/lazy-load-trees (2018-05-02) 6 commits
  (merged to 'next' on 2018-05-02 at d54016d9e3)
 + coccinelle: avoid wrong transformation suggestions from commit.cocci
  (merged to 'next' on 2018-04-25 at b90813f421)
 + commit-graph: lazy-load trees for commits
 + treewide: replace maybe_tree with accessor methods
 + commit: create get_commit_tree() method
 + treewide: rename tree to maybe_tree
 + Merge branch 'bw/c-plus-plus' into ds/lazy-load-trees
 (this branch is used by ds/generation-numbers; uses ds/commit-graph.)

 The code has been taught to use the duplicated information stored
 in the commit-graph file to learn the tree object name for a commit
 to avoid opening and parsing the commit object when it makes sense
 to do so.

 Will merge to 'master'.


* ab/git-svn-get-record-typofix (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-30 at 23f875f6b9)
 + git-svn: avoid warning on undef readline()

 "git svn" had a minor thinko/typo which has been fixed.

 Will merge to 'master'.


* hn/sort-ls-remote (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-30 at 244ca5d30a)
 + ls-remote: create '--sort' option

 "git ls-remote" learned an option to allow sorting its output based
 on the refnames being shown.

 Will merge to 'master'.


* js/empty-config-section-fix (2018-04-09) 15 commits
  (merged to 'next' on 2018-04-25 at 1690df3e5f)
 + git_config_set: reuse empty sections
 + git config --unset: remove empty sections (in the common case)
 + git_config_set: make use of the config parser's event stream
 + git_config_set: do not use a state machine
 + config_set_store: rename some fields for consistency
 + config: avoid using the global variable `store`
 + config: introduce an optional event stream while parsing
 + t1300: `--unset-all` can leave an empty section behind (bug)
 + t1300: add a few more hairy examples of sections becoming empty
 + t1300: remove unreasonable expectation from TODO
 + t1300: avoid relying on a bug
 + config --replace-all: avoid extra line breaks
 + t1300: demonstrate that --replace-all can "invent" newlines
 + t1300: rename it to reflect that `repo-config` was deprecated
 + git_config_set: fix off-by-two

 "git config --unset a.b", when "a.b" is the last variable in an
 otherwise empty section "a", left an empty section "a" behind, and
 worse yet, a subsequent "git config a.c value" did not reuse that
 empty shell and instead created a new one.  These have been
 (partially) corrected.

 Will merge to 'master'.


* nd/warn-more-for-devs (2018-04-16) 4 commits
  (merged to 'next' on 2018-04-25 at 2978e61414)
 + Makefile: add a DEVOPTS to get all of -Wextra
 + Makefile: add a DEVOPTS to suppress -Werror under DEVELOPER
 + Makefile: detect compiler and enable more warnings in DEVELOPER=1
 + connect.c: mark die_initial_contact() NORETURN

 The build procedure "make DEVELOPER=YesPlease" learned to enable a
 bit more warning options depending on the compiler used to help
 developers more.  There also is "make DEVOPTS=tokens" knob
 available now, for those who want to help fixing warnings we
 usually ignore, for example.

 Will merge to 'master'.


* sb/submodule-move-nested (2018-03-29) 6 commits
  (merged to 'next' on 2018-04-25 at 86b177433a)
 + submodule: fixup nested submodules after moving the submodule
 + submodule-config: remove submodule_from_cache
 + submodule-config: add repository argument to submodule_from_{name, path}
 + submodule-config: allow submodule_free to handle arbitrary repositories
 + grep: remove "repo" arg from non-supporting funcs
 + submodule.h: drop declaration of connect_work_tree_and_git_dir

 Moving a submodule that itself has submodule in it with "git mv"
 forgot to make necessary adjustment to the nested sub-submodules;
 now the codepath learned to recurse into the submodules.

 Will merge to 'master'.


* tb/config-type (2018-04-19) 2 commits
  (merged to 'next' on 2018-04-25 at fe69e93c82)
 + builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`
 + builtin/config.c: treat type specifiers singularly
 (this branch is used by tb/config-default.)

 The "git config" command uses separate options e.g. "--int",
 "--bool", etc. to specify what type the caller wants the value to
 be interpreted as.  A new "--type=<typename>" option has been
 introduced, which would make it cleaner to define new types.

 Will merge to 'master'.


* tb/config-default (2018-04-23) 3 commits
  (merged to 'next' on 2018-04-25 at 59bb6beb2a)
 + builtin/config: introduce `color` type specifier
 + config.c: introduce 'git_config_color' to parse ANSI colors
 + builtin/config: introduce `--default`
 (this branch uses tb/config-type.)

 "git config --get" learned the "--default" option, to help the
 calling script.  Building on top of the tb/config-type topic, the
 "git config" learns "--type=color" type.  Taken together, you can
 do things like "git config --get foo.color --default blue" and get
 the ANSI color sequence for the color given to foo.color variable,
 or "blue" if the variable does not exist.

 Will merge to 'master'.


* ot/libify-get-ref-atom-value (2018-03-29) 6 commits
  (merged to 'next' on 2018-04-25 at 056bcaa69c)
 + ref-filter: libify get_ref_atom_value()
 + ref-filter: add return value to parsers
 + ref-filter: change parsing function error handling
 + ref-filter: add return value && strbuf to handlers
 + ref-filter: start adding strbufs with errors
 + ref-filter: add shortcut to work with strbufs

 Code restructuring, in preparation for further work.

 Will merge to 'master'.


* jk/branch-l-0-deprecation (2018-03-26) 3 commits
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


* jk/branch-l-1-removal (2018-03-26) 1 commit
 - branch: drop deprecated "-l" option
 (this branch is used by jk/branch-l-2-reincarnation; uses jk/branch-l-0-deprecation.)

 Following the "git branch -l" deprecation, the short-hand is removed.

 Will keep in 'pu'.


* jk/branch-l-2-reincarnation (2018-03-26) 1 commit
 - branch: make "-l" a synonym for "--list"
 (this branch uses jk/branch-l-0-deprecation and jk/branch-l-1-removal.)

 Following the "git branch -l" removal, "-l" is resurrected as a
 short-hand for "--list".

 Will keep in 'pu'.


* dj/runtime-prefix (2018-04-24) 7 commits
  (merged to 'next' on 2018-04-25 at e7e635a70e)
 + Makefile: quote $INSTLIBDIR when passing it to sed
 + Makefile: remove unused @@PERLLIBDIR@@ substitution variable
  (merged to 'next' on 2018-04-17 at a69aaa7a22)
 + mingw/msvc: use the new-style RUNTIME_PREFIX helper
 + exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 + exec_cmd: RUNTIME_PREFIX on some POSIX systems
 + Makefile: add Perl runtime prefix support
 + Makefile: generate Perl header from template file
 (this branch is tangled with js/runtime-prefix.)

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 Will merge to 'master'.


* ab/nuke-emacs-contrib (2018-04-16) 1 commit
  (merged to 'next' on 2018-04-25 at 9b133d8a65)
 + git{,-blame}.el: remove old bitrotting Emacs code

 The scripts in contrib/emacs/ have outlived their usefulness and
 have been replaced with a stub that errors out and tells the user
 there are replacements.

 Will merge to 'master'.


* nd/pack-objects-pack-struct (2018-04-16) 15 commits
 - ci: exercise the whole test suite with uncommon code in pack-objects
 - pack-objects: reorder members to shrink struct object_entry
 - pack-objects: shrink delta_size field in struct object_entry
 - pack-objects: shrink size field in struct object_entry
 - pack-objects: clarify the use of object_entry::size
 - pack-objects: don't check size when the object is bad
 - pack-objects: shrink z_delta_size field in struct object_entry
 - pack-objects: refer to delta objects by index instead of pointer
 - pack-objects: move in_pack out of struct object_entry
 - pack-objects: move in_pack_pos out of struct object_entry
 - pack-objects: use bitfield for object_entry::depth
 - pack-objects: use bitfield for object_entry::dfs_state
 - pack-objects: turn type and in_pack_type to bitfields
 - pack-objects: a bit of document about struct object_entry
 - read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean

 "git pack-objects" needs to allocate tons of "struct object_entry"
 while doing its work, and shrinking its size helps the performance
 quite a bit.

 Will merge to 'next'.
 cf. <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>


* nd/repack-keep-pack (2018-04-16) 7 commits
 - pack-objects: show some progress when counting kept objects
 - gc --auto: exclude base pack if not enough mem to "repack -ad"
 - gc: handle a corner case in gc.bigPackThreshold
 - gc: add gc.bigPackThreshold config
 - gc: add --keep-largest-pack option
 - repack: add --keep-pack option
 - t7700: have closing quote of a test at the beginning of line

 "git gc" in a large repository takes a lot of time as it considers
 to repack all objects into one pack by default.  The command has
 been taught to pretend as if the largest existing packfile is
 marked with ".keep" so that it is left untouched while objects in
 other packs and loose ones are repacked.

 Will merge to 'next'.
 cf. <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>


* ds/commit-graph (2018-04-11) 16 commits
  (merged to 'next' on 2018-04-25 at 18af3d28d9)
 + commit-graph: implement "--append" option
 + commit-graph: build graph from starting commits
 + commit-graph: read only from specific pack-indexes
 + commit: integrate commit graph with commit parsing
 + commit-graph: close under reachability
 + commit-graph: add core.commitGraph setting
 + commit-graph: implement git commit-graph read
 + commit-graph: implement git-commit-graph write
 + commit-graph: implement write_commit_graph()
 + commit-graph: create git-commit-graph builtin
 + graph: add commit graph design document
 + commit-graph: add format document
 + csum-file: refactor finalize_hashfile() method
 + csum-file: rename hashclose() to finalize_hashfile()
 + Merge branch 'jk/cached-commit-buffer' into HEAD
 + Merge branch 'jt/binsearch-with-fanout' into HEAD
 (this branch is used by ds/generation-numbers and ds/lazy-load-trees.)

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 Will merge to 'master'.


* tg/worktree-add-existing-branch (2018-04-30) 4 commits
 - worktree: teach "add" to check out existing branches
 - worktree: factor out dwim_branch function
 - worktree: improve message when creating a new worktree
 - worktree: remove extra members from struct add_opts

 "git worktree add" learned to check out an existing branch.

 Will merge to 'next'.


* js/rebase-recreate-merge (2018-04-26) 17 commits
 - rebase -i --rebase-merges: add a section to the man page
 - rebase -i: introduce --rebase-merges=[no-]rebase-cousins
 - pull: accept --rebase=merges to recreate the branch topology
 - rebase --rebase-merges: avoid "empty merges"
 - sequencer: handle post-rewrite for merge commands
 - sequencer: make refs generated by the `label` command worktree-local
 - rebase --rebase-merges: add test for --keep-empty
 - rebase: introduce the --rebase-merges option
 - rebase-helper --make-script: introduce a flag to rebase merges
 - sequencer: fast-forward `merge` commands, if possible
 - sequencer: introduce the `merge` command
 - sequencer: introduce new commands to reset the revision
 - git-rebase--interactive: clarify arguments
 - sequencer: offer helpful advice when a command was rescheduled
 - sequencer: refactor how original todo list lines are accessed
 - sequencer: make rearrange_squash() a bit more obvious
 - sequencer: avoid using errno clobbered by rollback_lock_file()
 (this branch is used by js/sequencer-and-root-commits.)

 "git rebase" learned "--rebase-merges" to transplant the whole
 topology of commit graph elsewhere.

 Will merge to 'next'.


* bw/protocol-v2 (2018-03-15) 35 commits
  (merged to 'next' on 2018-04-11 at 23ee234a2c)
 + remote-curl: don't request v2 when pushing
 + remote-curl: implement stateless-connect command
 + http: eliminate "# service" line when using protocol v2
 + http: don't always add Git-Protocol header
 + http: allow providing extra headers for http requests
 + remote-curl: store the protocol version the server responded with
 + remote-curl: create copy of the service name
 + pkt-line: add packet_buf_write_len function
 + transport-helper: introduce stateless-connect
 + transport-helper: refactor process_connect_service
 + transport-helper: remove name parameter
 + connect: don't request v2 when pushing
 + connect: refactor git_connect to only get the protocol version once
 + fetch-pack: support shallow requests
 + fetch-pack: perform a fetch using v2
 + upload-pack: introduce fetch server command
 + push: pass ref prefixes when pushing
 + fetch: pass ref prefixes when fetching
 + ls-remote: pass ref prefixes when requesting a remote's refs
 + transport: convert transport_get_remote_refs to take a list of ref prefixes
 + transport: convert get_refs_list to take a list of ref prefixes
 + connect: request remote refs using v2
 + ls-refs: introduce ls-refs server command
 + serve: introduce git-serve
 + test-pkt-line: introduce a packet-line test helper
 + protocol: introduce enum protocol_version value protocol_v2
 + transport: store protocol version
 + connect: discover protocol version outside of get_remote_heads
 + connect: convert get_remote_heads to use struct packet_reader
 + transport: use get_refs_via_connect to get refs
 + upload-pack: factor out processing lines
 + upload-pack: convert to a builtin
 + pkt-line: add delim packet support
 + pkt-line: allow peeking a packet line without consuming it
 + pkt-line: introduce packet_read_with_status
 (this branch is used by bw/server-options and jt/partial-clone-proto-v2.)

 The beginning of the next-gen transfer protocol.

 Will merge to 'master'.


* ls/checkout-encoding (2018-04-16) 10 commits
  (merged to 'next' on 2018-04-25 at e0f8554b2a)
 + convert: add round trip check based on 'core.checkRoundtripEncoding'
 + convert: add tracing for 'working-tree-encoding' attribute
 + convert: check for detectable errors in UTF encodings
 + convert: add 'working-tree-encoding' attribute
 + utf8: add function to detect a missing UTF-16/32 BOM
 + utf8: add function to detect prohibited UTF-16/32 BOM
 + utf8: teach same_encoding() alternative UTF encoding names
 + strbuf: add a case insensitive starts_with()
 + strbuf: add xstrdup_toupper()
 + strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).

 Will merge to 'master'.

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
