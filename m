Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4859F1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 23:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbeAIXdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 18:33:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61134 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeAIXdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 18:33:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4290CC6E6;
        Tue,  9 Jan 2018 18:33:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=j
        kvDejOa2bCgEbklMWYvDwHXsHc=; b=w47EJSv0en25OlwkL3Emn6JYwlPB+BShg
        QBuceg85EBQ3VbluSIvR7ZxfZSFHTf+vYjSUOqDwK/YKB9tgEyfHkvtPB/knciYx
        eQjn9r1bqn5Wcjc3v5CILYCESRE9YMQ2ddswPtt/+whliHU2uD+5iCRaO5U3CwtB
        Cjs4lglQaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=gz/
        ED6sj2AuszXQJkyMu/3knfVs/bswsROn4zUXokMQxPqrugz2/tTL1ZfL6D715tAo
        bqxMi77M5M0CO2OGxuxWCrPvvAgtc88INpNH2SdLi/oRn2YK2lB8QaGnHUjJPZ3w
        G6h09ie8LmMtxFZjaXYrC5m2wV8A7A9pYO39hv3E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB894CC6E5;
        Tue,  9 Jan 2018 18:33:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11DDACC6E4;
        Tue,  9 Jan 2018 18:33:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2018, #02; Tue, 9)
X-master-at: 6366dd9000a3f67e47a30d94375a88dabc18ec6f
X-next-at: 55033e839aa0788e7eca704bfa5a1834e6ee1cde
Date:   Tue, 09 Jan 2018 15:33:07 -0800
Message-ID: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73442B26-F595-11E7-89F9-8EF31968708C-77302942!pb-smtp1.pobox.com
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
[Graduated to "master"]

* ab/dc-sha1-loose-ends (2017-12-28) 1 commit
  (merged to 'next' on 2018-01-05 at 7186e81793)
 + Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1

 Tying loose ends for the recent integration work of
 collision-detecting SHA-1 implementation.


* bc/submitting-patches-in-asciidoc (2018-01-03) 1 commit
  (merged to 'next' on 2018-01-05 at 92dd960a56)
 + doc/SubmittingPatches: improve text formatting

 Doc readability update.


* bp/fsmonitor (2017-12-18) 1 commit
  (merged to 'next' on 2017-12-27 at ce216e2978)
 + p7519: improve check for prerequisite WATCHMAN

 Test fix.


* bw/path-doc (2017-12-13) 1 commit
  (merged to 'next' on 2017-12-19 at 2cddee77ca)
 + path: document path functions

 Doc updates.


* bw/protocol-v1 (2018-01-04) 1 commit
  (merged to 'next' on 2018-01-05 at 47a5e0039a)
 + http: fix v1 protocol tests with apache httpd < 2.4

 Test fix for a topic already in 'master'.


* cc/skip-to-optional-val (2017-12-11) 7 commits
  (merged to 'next' on 2017-12-27 at 1b189d8556)
 + t4045: reindent to make helpers readable
 + diff: add tests for --relative without optional prefix value
 + diff: use skip_to_optional_arg_default() in parsing --relative
 + diff: use skip_to_optional_arg_default()
 + diff: use skip_to_optional_arg()
 + index-pack: use skip_to_optional_arg()
 + git-compat-util: introduce skip_to_optional_arg()

 Introduce a helper to simplify code to parse a common pattern that
 expects either "--key" or "--key=<something>".


* db/doc-config-section-names-with-bs (2017-12-22) 1 commit
  (merged to 'next' on 2017-12-28 at e744b99449)
 + config.txt: document behavior of backslashes in subsections

 Doc update.


* ew/svn-crlf (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at 1b81bd634d)
 + Merge branch 'svn-crlf' of git://bogomips.org/git-svn into ew/svn-crlf
 + git-svn: convert CRLF to LF in commit message to SVN

 "git svn" has been updated to strip CRs in the commit messages, as
 recent versions of Subversion rejects them.


* hi/merge-verify-sig-config (2017-12-19) 3 commits
  (merged to 'next' on 2017-12-27 at 34360fb1c1)
 + t5573, t7612: clean up after unexpected success of 'pull' and 'merge'
  (merged to 'next' on 2017-12-14 at cdc511dc36)
 + t: add tests for pull --verify-signatures
 + merge: add config option for verifySignatures

 "git merge" learned to pay attention to merge.verifySignatures
 configuration variable and pretend as if '--verify-signatures'
 option was given from the command line.


* jd/fix-strbuf-add-urlencode-bytes (2017-12-22) 1 commit
  (merged to 'next' on 2017-12-28 at 7f4f291966)
 + strbuf: fix urlencode format string on signed char

 Bytes with high-bit set were encoded incorrectly and made
 credential helper fail.


* jh/memihash-opt (2017-12-22) 1 commit
  (merged to 'next' on 2017-12-28 at bf96e0d849)
 + t/helper/test-lazy-name-hash: fix compilation

 Squelch compiler warning.


* jh/partial-clone-doc (2017-12-14) 1 commit
  (merged to 'next' on 2017-12-27 at 3695847773)
 + partial-clone: design doc


* jk/doc-diff-options (2018-01-04) 1 commit
  (merged to 'next' on 2018-01-05 at 11a42ea807)
 + docs/diff-options: clarify scope of diff-filter types

 Doc update.


* jk/test-suite-tracing (2017-12-08) 4 commits
  (merged to 'next' on 2017-12-27 at 7034a51474)
 + t/Makefile: introduce TEST_SHELL_PATH
 + test-lib: make "-x" work with "--verbose-log"
 + t5615: avoid re-using descriptor 4
 + test-lib: silence "-x" cleanup under bash

 Assorted fixes around running tests with "-x" tracing option.


* js/enhanced-version-info (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at a95dd96a78)
 + version --build-options: report commit, too, if possible
 + version --build-options: also report host CPU

 "git version --build-options" learned to report the host CPU and
 the exact commit object name the binary was built from.


* js/sequencer-cleanups (2017-12-27) 5 commits
  (merged to 'next' on 2017-12-28 at 23c10afb09)
 + sequencer: do not invent whitespace when transforming OIDs
 + sequencer: report when noop has an argument
 + sequencer: remove superfluous conditional
 + sequencer: strip bogus LF at end of error messages
 + rebase: do not continue when the todo list generation failed

 Code cleanup.


* js/test-with-ws-in-path (2018-01-03) 2 commits
  (merged to 'next' on 2018-01-05 at 6438e1c186)
 + t0302 & t3900: add forgotten quotes
 + Allow the test suite to pass in a directory whose name contains spaces

 Test fixes.


* jt/transport-hide-vtable (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at 8dc27cfb53)
 + transport: make transport vtable more private
 + clone, fetch: remove redundant transport check

 Code clean-up.


* ks/doc-previous-checkout (2017-12-19) 1 commit
  (merged to 'next' on 2017-12-27 at c706239a69)
 + Doc/check-ref-format: clarify information about @{-N} syntax

 Doc update.


* ks/rebase-error-messages (2017-12-19) 3 commits
  (merged to 'next' on 2017-12-27 at 80c62260ad)
 + rebase: rebasing can also be done when HEAD is detached
 + rebase: distinguish user input by quoting it
 + rebase: consistently use branch_name variable

 Error messages from "git rebase" have been somewhat cleaned up.


* ld/p4-multiple-shelves (2017-12-22) 1 commit
  (merged to 'next' on 2017-12-28 at 6c29703427)
 + git-p4: update multiple shelved change lists

 "git p4" update.


* nm/imap-send-quote-server-folder-name (2017-12-18) 1 commit
  (merged to 'next' on 2017-12-27 at 79326a0b77)
 + imap-send: URI encode server folder

 "git imap-send" did not correctly quote the folder name when
 making a request to the server, which has been corrected.


* ra/prompt-eread-fix (2017-12-06) 2 commits
  (merged to 'next' on 2017-12-27 at ae870af11d)
 + git-prompt: fix reading files with windows line endings
 + git-prompt: make __git_eread intended use explicit

 Update the shell prompt script (in contrib/) to strip trailing CR
 from strings read from various "state" files.


* rs/use-argv-array-in-child-process (2017-12-22) 2 commits
  (merged to 'next' on 2017-12-28 at 829a621ace)
 + send-pack: use internal argv_array of struct child_process
 + http: use internal argv_array of struct child_process

 Code cleanup.


* sb/describe-blob (2017-12-19) 7 commits
  (merged to 'next' on 2017-12-27 at 1249ca9213)
 + builtin/describe.c: describe a blob
 + builtin/describe.c: factor out describe_commit
 + builtin/describe.c: print debug statements earlier
 + builtin/describe.c: rename `oid` to avoid variable shadowing
 + revision.h: introduce blob/tree walking in order of the commits
 + list-objects.c: factor out traverse_trees_and_blobs
 + t6120: fix typo in test name

 "git describe" was taught to dig trees deeper to find a
 <commit-ish>:<path> that refers to a given blob object.


* sg/travis-check-untracked (2018-01-03) 2 commits
  (merged to 'next' on 2018-01-05 at 424bed2fb0)
 + travis-ci: check that all build artifacts are .gitignore-d
 + travis-ci: don't store P4 and Git LFS in the working tree
 (this branch uses sg/travis-fixes and sg/travis-skip-identical-test.)

 Will cook in 'next'.


* sg/travis-fixes (2017-12-27) 4 commits
  (merged to 'next' on 2017-12-28 at 6496308a5b)
 + travis-ci: only print test failures if there are test results available
 + travis-ci: save prove state for the 32 bit Linux build
 + travis-ci: don't install default addon packages for the 32 bit Linux build
 + travis-ci: fine tune the use of 'set -x' in 'ci/*' scripts
 (this branch is used by sg/travis-check-untracked and sg/travis-skip-identical-test.)

 Assorted updates for TravisCI integration.

 Will cook in 'next'.


* sg/travis-skip-identical-test (2018-01-02) 3 commits
  (merged to 'next' on 2018-01-05 at 41914fc43e)
 + travis-ci: record and skip successfully built trees
 + travis-ci: create the cache directory early in the build process
 + travis-ci: print the "tip of branch is exactly at tag" message in color
 (this branch is used by sg/travis-check-untracked; uses sg/travis-fixes.)

 Avoid repeatedly testing the same tree in TravisCI that have been
 tested successfully already.

 Will cook in 'next'.


* sr/http-sslverify-config-doc (2017-12-18) 1 commit
  (merged to 'next' on 2017-12-27 at 84a461c4b5)
 + config: document default value of http.sslVerify

 Docfix.


* tb/test-lint-wc-l (2017-12-22) 1 commit
  (merged to 'next' on 2017-12-28 at 4d91ed6d51)
 + check-non-portable-shell.pl: `wc -l` may have leading WS

 Test update.


* tz/lib-git-svn-svnserve-tests (2017-12-14) 2 commits
  (merged to 'next' on 2017-12-27 at 54513f6e20)
 + t/lib-git-svn.sh: improve svnserve tests with parallel make test
 + t/lib-git-svn: cleanup inconsistent tab/space usage


* ws/curl-http-proxy-over-https (2017-12-19) 1 commit
  (merged to 'next' on 2017-12-27 at 895bf2f94b)
 + http: support CURLPROXY_HTTPS

 Git has been taught to support an https:// URL used for http.proxy
 when using recent versions of libcurl.

--------------------------------------------------
[New Topics]

* ab/wildmatch-tests (2018-01-04) 7 commits
  (merged to 'next' on 2018-01-09 at 09f0b84098)
 + wildmatch test: create & test files on disk in addition to in-memory
 + wildmatch test: perform all tests under all wildmatch() modes
 + wildmatch test: remove dead fnmatch() test code
 + wildmatch test: use a paranoia pattern from nul_match()
 + wildmatch test: don't try to vertically align our output
 + wildmatch test: use more standard shell style
 + wildmatch test: indent with tabs, not spaces

 More tests for wildmatch functions.

 Will cook in 'next'.


* cc/codespeed (2018-01-05) 7 commits
  (merged to 'next' on 2018-01-09 at 5599f7a085)
 + perf/run: read GIT_PERF_REPO_NAME from perf.repoName
 + perf/run: learn to send output to codespeed server
 + perf/run: learn about perf.codespeedOutput
 + perf/run: add conf_opts argument to get_var_from_env_or_config()
 + perf/aggregate: implement codespeed JSON output
 + perf/aggregate: refactor printing results
 + perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}

 "perf" test output can be sent to codespeed server.

 Will cook in 'next'.


* rs/lose-leak-pending (2017-12-28) 9 commits
  (merged to 'next' on 2018-01-05 at 05305f7f2f)
 + commit: remove unused function clear_commit_marks_for_object_array()
 + revision: remove the unused flag leak_pending
 + checkout: avoid using the rev_info flag leak_pending
 + bundle: avoid using the rev_info flag leak_pending
 + bisect: avoid using the rev_info flag leak_pending
 + object: add clear_commit_marks_all()
 + ref-filter: use clear_commit_marks_many() in do_merge_filter()
 + commit: use clear_commit_marks_many() in remove_redundant()
 + commit: avoid allocation in clear_commit_marks_many()

 API clean-up around revision traversal.

 Will cook in 'next'.


* sb/diff-blobfind-pickaxe (2018-01-04) 6 commits
  (merged to 'next' on 2018-01-09 at 1c7bace3e7)
 + diff: use HAS_MULTI_BITS instead of counting bits manually
 + diff: properly error out when combining multiple pickaxe options
 + diffcore: add a pickaxe option to find a specific blob
 + diff: introduce DIFF_PICKAXE_KINDS_MASK
 + diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
 + diff.h: make pickaxe_opts an unsigned bit field

 "diff" family of commands learned "--find-object=<object-id>" option
 to limit the findings to changes that involve the named object.

 Will cook in 'next'.


* ab/perf-grep-threads (2018-01-04) 1 commit
  (merged to 'next' on 2018-01-09 at 8fe1d71894)
 + perf: amend the grep tests to test grep.threads

 More perf tests for threaded grep

 Will cook in 'next'.


* bw/protocol-v2 (2018-01-04) 26 commits
 - remote-curl: implement connect-half-duplex command
 - remote-curl: create copy of the service name
 - pkt-line: add packet_buf_write_len function
 - transport-helper: introduce connect-half-duplex
 - transport-helper: refactor process_connect_service
 - transport-helper: remove name parameter
 - fetch-pack: perform a fetch using v2
 - upload-pack: introduce fetch server command
 - push: pass ref patterns when pushing
 - fetch: pass ref patterns when fetching
 - ls-remote: pass ref patterns when requesting a remote's refs
 - transport: convert transport_get_remote_refs to take a list of ref patterns
 - transport: convert get_refs_list to take a list of ref patterns
 - connect: request remote refs using v2
 - ls-refs: introduce ls-refs server command
 - serve: introduce git-serve
 - protocol: introduce enum protocol_version value protocol_v2
 - transport: store protocol version
 - connect: discover protocol version outside of get_remote_heads
 - connect: convert get_remote_heads to use struct packet_reader
 - transport: use get_refs_via_connect to get refs
 - upload-pack: factor out processing lines
 - upload-pack: convert to a builtin
 - pkt-line: add delim packet support
 - pkt-line: introduce struct packet_reader
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.


* jh/status-no-ahead-behind (2018-01-04) 4 commits
 - status: support --no-ahead-behind in long format
 - status: update short status to respect --no-ahead-behind
 - status: add --[no-]ahead-behind to status and commit for V2 format.
 - stat_tracking_info: return +1 when branches not equal

 Still in flux.


* jk/abort-clone-with-existing-dest (2018-01-03) 4 commits
  (merged to 'next' on 2018-01-09 at 789a55a9e1)
 + clone: do not clean up directories we didn't create
 + clone: factor out dir_exists() helper
 + t5600: modernize style
 + t5600: fix outdated comment about unborn HEAD

 "git clone $there $here" is allowed even when here directory exists
 as long as it is an empty directory, but the command incorrectly
 removed it upon a failure of the operation.

 Will cook in 'next'.


* ls/checkout-encoding (2018-01-08) 6 commits
 - convert: add support for 'checkout-encoding' attribute
 - convert_to_git(): safe_crlf/checksafe becomes int conv_flags
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).


* ma/bisect-leakfix (2018-01-03) 1 commit
  (merged to 'next' on 2018-01-09 at af04bd5436)
 + bisect: fix a regression causing a segfault

 A hotfix for a recent update that broke 'git bisect'.

 Will merge to 'master'.


* mm/send-email-fallback-to-local-mail-address (2018-01-08) 3 commits
 - send-email: add test for Linux's get_maintainer.pl
 - perl/Git: remove now useless email-address parsing code
 - send-email: add and use a local copy of Mail::Address

 Instead of maintaining home-grown email address parsing code, ship
 a copy of reasonably recent Mail::Address to be used as a fallback
 in 'git send-email' when the platform lacks it.

 Will merge to 'next'.


* sb/submodule-update-reset-fix (2018-01-05) 4 commits
 - submodule: submodule_move_head omits old argument in forced case
 - unpack-trees: oneway_merge to update submodules
 - t/lib-submodule-update.sh: fix test ignoring ignored files in submodules
 - t/lib-submodule-update.sh: clarify test

 When resetting the working tree files recursively, the working tree
 of submodules are now also reset to match.

 Will merge to 'next'.


* js/fix-merge-arg-quoting-in-rebase-p (2018-01-05) 1 commit
  (merged to 'next' on 2018-01-09 at 57950f1843)
 + rebase -p: fix quoting when calling `git merge`

 "git rebase -p -X<option>" did not propagate the option properly
 down to underlying merge strategy backend.

 Will merge to 'master'.


* as/read-tree-prefix-doc-fix (2018-01-09) 1 commit
 - doc/read-tree: remove obsolete remark

 Doc update.

 Will merge to 'next'.


* jh/object-filtering (2018-01-08) 1 commit
 - oidset: don't return value from oidset_init

 Hotfix for a topic already in 'master'.

 Will merge to 'next'.


* pc/submodule-helper (2018-01-09) 2 commits
 - submodule: port submodule subcommand 'deinit' from shell to C
 - submodule: port submodule subcommand 'sync' from shell to C

 Rewrite two more "git submodule" subcommands in C.

 Will segfault.
 cf. <xmqqpo6i4uns.fsf@gitster.mtv.corp.google.com>


* sb/blame-color (2018-01-08) 4 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata
 - color.h: document and modernize header


* sg/travis-build-during-script-phase (2018-01-08) 1 commit
 - travis-ci: build Git during the 'script' phase

 Still under discussion.
 cf. <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>


* tg/stash-with-pathspec-fix (2018-01-08) 1 commit
 - stash: don't delete untracked files that match pathspec

 "git stash -- <pathspec>" incorrectly blew away untracked files in
 the directory that matched the pathspec, which has been corrected.

 Will merge to 'next'.


* ys/bisect-object-id-missing-conversion-fix (2018-01-09) 1 commit
 - bisect: debug: convert struct object to object_id

 Fix for a commented-out code to adjust it to a rather old API change.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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


* dj/runtime-prefix (2017-12-05) 4 commits
 . exec_cmd: RUNTIME_PREFIX on some POSIX systems
 . Makefile: add Perl runtime prefix support
 . Makefile: add support for "perllibdir"
 . Makefile: generate Perl header from template file

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 Tentatively kicked out of 'next' to see how well another topic
 ab/simplify-perl-makefile that heavily conflicts with this fares.


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


* cc/require-tcl-tk-for-build (2017-11-29) 2 commits
 - travis-ci: avoid new tcl/tk build requirement
 - Makefile: check that tcl/tk is installed

 A first-time builder of Git may have installed neither tclsh nor
 msgfmt, in which case git-gui and gitk part will fail and break the
 build.  As a workaround, refuse to run a build when tclsh is not
 installed and NO_TCLTK is not set.

 Undecided.
 I still feel that requring tclsh to be installed, with or without
 "escape hatch" for experts, may be too heavy-handed.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


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


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>

--------------------------------------------------
[Cooking]

* ew/empty-merge-with-dirty-index (2018-01-09) 1 commit
  (merged to 'next' on 2018-01-09 at 851bc45d06)
 + Merge branch 'ew/empty-merge-with-dirty-index-maint' into ew/empty-merge-with-dirty-index
 (this branch uses ew/empty-merge-with-dirty-index-maint.)

 "git merge -s recursive" did not correctly abort when the index is
 dirty, if the merged tree happened to be the same as the current
 HEAD, which has been fixed.

 Will merge to 'master'.


* ew/empty-merge-with-dirty-index-maint (2018-01-09) 1 commit
 + merge-recursive: do not look at the index during recursive merge
 (this branch is used by ew/empty-merge-with-dirty-index.)

 "git merge -s recursive" did not correctly abort when the index is
 dirty, if the merged tree happened to be the same as the current
 HEAD, which has been fixed.

 Will merge to 'master' (as part of the above).


* jc/merge-symlink-ours-theirs (2018-01-03) 1 commit
  (merged to 'next' on 2018-01-05 at 63ebfc45eb)
 + merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Will cook in 'next'.


* ab/commit-m-with-fixup (2017-12-22) 2 commits
 - commit: add support for --fixup <commit> -m"<extra message>"
 - commit doc: document that -c, -C, -F and --fixup with -m error

 "git commit --fixup" did not allow "-m<message>" option to be used
 at the same time; allow it to annotate resulting commit with more
 text.

 Will merge to 'next'.


* bw/oidmap-autoinit (2017-12-27) 1 commit
 - oidmap: ensure map is initialized

 Code clean-up.

 Will merge to 'next'.


* dk/describe-all-output-fix (2017-12-27) 1 commit
  (merged to 'next' on 2017-12-28 at c6254494e3)
 + describe: prepend "tags/" when describing tags with embedded name

 An old regression in "git describe --all $annotated_tag^0" has been
 fixed.

 Will cook in 'next'.


* nd/fix-untracked-cache-invalidation (2018-01-04) 5 commits
 - dir.c: stop ignoring opendir() error in open_cached_dir()
 - update-index doc: note a fixed bug in the untracked cache
 - dir.c: fix missing dir invalidation in untracked code
 - dir.c: avoid stat() in valid_cached_dir()
 - status: add a failing test showing a core.untrackedCache bug

 Some bugs around "untracked cache" feature have been fixed.

 Will merge to 'next'.


* nd/ita-wt-renames-in-status (2017-12-27) 6 commits
  (merged to 'next' on 2017-12-28 at 7610331a11)
 + wt-status.c: handle worktree renames
 + wt-status.c: rename rename-related fields in wt_status_change_data
 + wt-status.c: catch unhandled diff status codes
 + wt-status.c: coding style fix
 + Use DIFF_DETECT_RENAME for detect_rename assignments
 + t2203: test status output with porcelain v2 format

 "git status" after moving a path in the working tree (hence making
 it appear "removed") and then adding with the -N option (hence
 making that appear "added") detected it as a rename, but did not
 report the  old and new pathnames correctly.

 Will cook in 'next'.


* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided.


* av/fsmonitor-updates (2018-01-04) 6 commits
 - fsmonitor: use fsmonitor data in `git diff`
 - fsmonitor: remove debugging lines from t/t7519-status-fsmonitor.sh
 - fsmonitor: make output of test-dump-fsmonitor more concise
 - fsmonitor: update helper tool, now that flags are filled later
 - fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
 - dir.c: update comments to match argument name

 Code clean-up on fsmonitor integration, plus optional utilization
 of the fsmonitor data in diff-files.

 Undecided.
 cf. <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>


* ab/sha1dc-build (2017-12-12) 4 commits
 - Makefile: use the sha1collisiondetection submodule by default
 - sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
 - Makefile: under "make dist", include the sha1collisiondetection submodule
 - Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto

 Push the submodule version of collision-detecting SHA-1 hash
 implementation a bit harder on builders.

 The earlier two may make sense, but leaning toward rejecting the last step.
 cf. <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>


* ab/simplify-perl-makefile (2018-01-03) 3 commits
  (merged to 'next' on 2018-01-03 at ecd1f51af2)
 + perl: treat PERLLIB_EXTRA as an extra path again
  (merged to 'next' on 2017-12-28 at d189d91ec6)
 + perl: avoid *.pmc and fix Error.pm further
  (merged to 'next' on 2017-12-13 at 1b791d2503)
 + Makefile: replace perl/Makefile.PL with simple make rules

 The build procedure for perl/ part has been greatly simplified by
 weaning ourselves off of MakeMaker.

 Will cook in 'next'.


* en/rename-directory-detection (2017-12-13) 35 commits
 - SQUASH???
 - merge-recursive: ensure we write updates for directory-renamed file
 - merge-recursive: avoid spurious rename/rename conflict from dir renames
 - directory rename detection: new testcases showcasing a pair of bugs
 - merge-recursive: fix remaining directory rename + dirty overwrite cases
 - merge-recursive: fix overwriting dirty files involved in renames
 - merge-recursive: avoid clobbering untracked files with directory renames
 - merge-recursive: apply necessary modifications for directory renames
 - merge-recursive: when comparing files, don't include trees
 - merge-recursive: check for file level conflicts then get new name
 - merge-recursive: add computation of collisions due to dir rename & merging
 - merge-recursive: add a new hashmap for storing file collisions
 - merge-recursive: check for directory level conflicts
 - merge-recursive: add get_directory_renames()
 - merge-recursive: make a helper function for cleanup for handle_renames
 - merge-recursive: add a new hashmap for storing directory renames
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
 - merge-recursive: add explanation for src_entry and dst_entry
 - merge-recursive: fix logic ordering issue
 - Tighten and correct a few testcases for merging and cherry-picking

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.

 A rerolled version exists; it needs to be picked up.


* pw/sequencer-in-process-commit (2017-12-22) 11 commits
  (merged to 'next' on 2017-12-28 at c496b3fa29)
 + sequencer: assign only free()able strings to gpg_sign
  (merged to 'next' on 2017-12-13 at ec4d2b9c84)
 + sequencer: improve config handling
  (merged to 'next' on 2017-12-06 at a4212f7ebd)
 + t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 + sequencer: try to commit without forking 'git commit'
 + sequencer: load commit related config
 + sequencer: simplify adding Signed-off-by: trailer
 + commit: move print_commit_summary() to libgit
 + commit: move post-rewrite code to libgit
 + Add a function to update HEAD after creating a commit
 + commit: move empty message checks to libgit
 + t3404: check intermediate squash messages

 The sequencer infrastructure is shared across "git cherry-pick",
 "git rebase -i", etc., and has always spawned "git commit" when it
 needs to create a commit.  It has been taught to do so internally,
 when able, by reusing the codepath "git commit" itself uses, which
 gives performance boost for a few tens of percents in some sample
 scenarios.

 Will cook in 'next'.


* jh/fsck-promisors (2017-12-08) 10 commits
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension
 - extension.partialclone: introduce partial clone extension
 (this branch is used by jh/partial-clone.)

 In preparation for implementing narrow/partial clone, the machinery
 for checking object connectivity used by gc and fsck has been
 taught that a missing object is OK when it is referenced by a
 packfile specially marked as coming from trusted repository that
 promises to make them available on-demand and lazily.


* jh/partial-clone (2017-12-08) 13 commits
 - t5616: test bulk prefetch after partial fetch
 - fetch: inherit filter-spec from partial clone
 - t5616: end-to-end tests for partial clone
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - clone: partial clone
 - partial-clone: define partial clone settings in config
 - fetch: support filters
 - fetch: refactor calculation of remote list
 - fetch-pack: test support excluding large blobs
 - fetch-pack: add --no-filter
 - fetch-pack, index-pack, transport: partial clone
 - upload-pack: add object filtering for partial clone
 (this branch uses jh/fsck-promisors.)

 The machinery to clone & fetch, which in turn involves packing and
 unpacking objects, have been told how to omit certain objects using
 the filtering mechanism introduced by the jh/object-filtering
 topic, and also mark the resulting pack as a promisor pack to
 tolerate missing objects, taking advantage of the mechanism
 introduced by the jh/fsck-promisors topic.


* ot/mru-on-list (2017-10-01) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Is there any remaining issues on this one?


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
  (merged to 'next' on 2018-01-05 at 6cb237ea44)
 + git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* rs/revision-keep-pending (2017-12-19) 1 commit
  (merged to 'next' on 2017-12-27 at 20a9527941)
 + revision: introduce prepare_revision_walk_extended()

 Reverted out of 'next' to give a chance to its reworked successor,
 queued on the rs/lose-leak-pending topic.


* sb/diff-blobfind (2017-12-12) 1 commit
  (merged to 'next' on 2017-12-13 at 9a27a20c5f)
 + diffcore: add a filter to find a specific blob

 "git diff" family of commands learned --blobfind=<object-name> that
 allows you to limit the output only to a change that involves the
 named blob object (either changing the contents from or to it).

 Reverted out of 'next' to give a chance to its reworked successor,
 queued on the sb/diff-blobfind-pickaxe topic.
