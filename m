Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF081F461
	for <e@80x24.org>; Fri, 12 Jul 2019 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfGLVDF (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 17:03:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGLVDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 17:03:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EC6473E3D;
        Fri, 12 Jul 2019 17:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=A
        2y2W5whdcTUF6hkTOCjryVVrNU=; b=T6zt5CHErquf/4xT0bBGQMqmgrAQ47GkH
        h+tiMJSlA2f5jsU4bS3yUX9crnz4R4L5eBnwxqCA+yt8n2Hyz8K5yh58vOuZyLIx
        YDwZDnH5xTTyI42IHFDrazId6YyDvQjFSN4jT442b4yv2F5161vug7CjC0SFp5dE
        2Wrwvnrl+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=t2r
        yW6p83FLbfVkPADvS5QSreoIFHl0Hd7Gv304+Nw6jCArOoQLhnXvTXVzgP3J1O0O
        xeGOO4bJYYq5CRzS0RRgDmxP6CDRAc4BMfUe0jwl5xPzHIjobk54nsL4Xqb5q15N
        IW0SxQf6LKvTiKOtZBe9Q7A4jqydgdz/Fig2zsLw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9744773E3C;
        Fri, 12 Jul 2019 17:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 991BA73E3A;
        Fri, 12 Jul 2019 17:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2019, #03; Fri, 12)
X-master-at: 9d418600f4d10dcbbfb0b5fdbc71d509e03ba719
X-next-at: 5628b89657138aca6088e0c4bfa2bccdba573c6b
Date:   Fri, 12 Jul 2019 14:02:52 -0700
Message-ID: <xmqq8st3otj7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B05EC2A-A4E8-11E9-A44D-8D86F504CC47-77302942!pb-smtp21.pobox.com
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

* cb/windows-manifest (2019-06-27) 1 commit
  (merged to 'next' on 2019-07-03 at 875721bdc9)
 + mingw: embed a manifest to trick UAC into Doing The Right Thing

 Windows update.


* dr/progress-i18n (2019-07-02) 1 commit
  (merged to 'next' on 2019-07-09 at 1fe05d45de)
 + l10n: localizable upload progress messages

 Progress messages have been made localizable.


* js/mingw-gcc-stack-protect (2019-06-27) 1 commit
  (merged to 'next' on 2019-07-03 at 7e3185f69d)
 + mingw: enable stack smashing protector

 Windows update.


* js/mingw-use-utf8 (2019-07-08) 3 commits
  (merged to 'next' on 2019-07-09 at f6a9349604)
 + mingw: fix possible buffer overrun when calling `GetUserNameW()`
  (merged to 'next' on 2019-07-03 at f528daf88d)
 + mingw: use Unicode functions explicitly
 + mingw: get pw_name in UTF-8 format

 Windows update.


* js/rebase-reschedule-applies-only-to-interactive (2019-07-01) 1 commit
  (merged to 'next' on 2019-07-09 at a13c7444c5)
 + rebase --am: ignore rebase.rescheduleFailedExec

 The configuration variable rebase.rescheduleFailedExec should be
 effective only while running an interactive rebase and should not
 affect anything when running an non-interactive one, which was not
 the case.  This has been corrected.


* jt/t5551-test-chunked (2019-06-27) 1 commit
  (merged to 'next' on 2019-07-03 at aafd74451c)
 + t5551: test usage of chunked encoding explicitly

 Update smart-http test.


* kb/windows-force-utf8 (2019-07-03) 1 commit
  (merged to 'next' on 2019-07-09 at 19dfe81d85)
 + gettext: always use UTF-8 on native Windows

 Windows update.


* qn/clone-doc-use-long-form (2019-07-02) 2 commits
  (merged to 'next' on 2019-07-09 at b2e1880627)
 + docs: git-clone: list short form of options first
 + docs: git-clone: refer to long form of options

 The "git clone" documentation refers to command line options in its
 description in the short form; they have been replaced with long
 forms to make them more recognisable.


* sg/ci-brew-gcc-workaround (2019-07-08) 3 commits
  (merged to 'next' on 2019-07-09 at a1b3e98f0c)
 + ci/lib.sh: update a comment about installed P4 and Git-LFS versions
  (merged to 'next' on 2019-07-03 at 264f2c817a)
 + ci: disable Homebrew's auto cleanup
 + ci: don't update Homebrew

 Dev support update.


* sg/git-C-empty-doc (2019-07-01) 1 commit
  (merged to 'next' on 2019-07-09 at 351952f80f)
 + Document that 'git -C ""' works and doesn't change directory

 Doc update.

--------------------------------------------------
[New Topics]

* js/trace2-signo-typofix (2019-07-09) 1 commit
  (merged to 'next' on 2019-07-11 at b2d2029b90)
 + trace2: correct trace2 field name documentation

 Documentation fix.

 Will merge to 'master'.


* ma/ref-filter-leakfix (2019-07-10) 1 commit
  (merged to 'next' on 2019-07-11 at a7a4bb81ac)
 + ref-filter: fix memory leak in `free_array_item()`

 Leakfix.

 Will merge to 'master'.


* js/unmap-before-ext-diff (2019-07-11) 1 commit
 - diff: munmap() file contents before running external diff

 Windows update.

 Will merge to 'next'.


* rm/gpg-program-doc-fix (2019-07-12) 1 commit
 - gpg(docs): use correct --verify syntax

 Docfix.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* nd/index-dump-in-json (2019-06-26) 11 commits
 - SQUASH???
 - t3008: use the new SINGLE_CPU prereq
 - read-cache.c: dump "IEOT" extension as json
 - read-cache.c: dump "EOIE" extension as json
 - resolve-undo.c: dump "REUC" extension as json
 - fsmonitor.c: dump "FSMN" extension as json
 - split-index.c: dump "link" extension as json
 - dir.c: dump "UNTR" extension as json
 - cache-tree.c: dump "TREE" extension as json
 - read-cache.c: dump common extension info in json
 - ls-files: add --json to dump the index

 "ls-files" learned "--debug-json" option to dump the contents and
 the extensions of the index file.

 At least the fixup at the tip needs to be squashed into the right
 commit.  Also the new test seems flaky.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).

 Stalled


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

* mt/dir-iterator-updates (2019-07-11) 10 commits
 - clone: replace strcmp by fspathcmp
 - clone: use dir-iterator to avoid explicit dir traversal
 - clone: extract function from copy_or_link_directory
 - clone: copy hidden paths at local clone
 - dir-iterator: add flags parameter to dir_iterator_begin
 - dir-iterator: refactor state machine model
 - dir-iterator: use warning_errno when possible
 - dir-iterator: add tests for dir-iterator API
 - clone: better handle symlinked files at .git/objects/
 - clone: test for our behavior on odd objects/* content

 Adjust the dir-iterator API and apply it to the local clone
 optimization codepath.

 Will merge to 'next'.


* ea/merge-code-cleanup (2019-07-09) 1 commit
  (merged to 'next' on 2019-07-11 at a7b831b03e)
 + builtin/merge.c - cleanup of code in for-cycle that tests strategies

 A loop has been rewritten for conciseness and clarity.

 Will merge to 'master'.


* kb/mingw-set-home (2019-07-08) 1 commit
  (merged to 'next' on 2019-07-11 at 51c7e23dab)
 + mingw: initialize HOME on startup

 Windows port update.

 Will merge to 'master'.


* tg/range-diff-output-update (2019-07-11) 14 commits
 - range-diff: add headers to the outer hunk header
 - range-diff: add filename to inner diff
 - range-diff: add section header instead of diff header
 - range-diff: suppress line count in outer diff
 - range-diff: don't remove funcname from inner diff
 - range-diff: split lines manually
 - range-diff: fix function parameter indentation
 - apply: make parse_git_diff_header public
 - apply: only pass required data to gitdiff_* functions
 - apply: only pass required data to find_name_*
 - apply: only pass required data to check_header_line
 - apply: only pass required data to git_header_name
 - apply: only pass required data to skip_tree_prefix
 - apply: replace marc.info link with public-inbox

 "git range-diff" output has been tweaked for easier identification
 of which part of what file the patch shown is about.

 Will merge to 'next'.


* bc/hash-independent-tests-part-4 (2019-07-01) 10 commits
 - t2203: avoid hard-coded object ID values
 - t1710: make hash independent
 - t1007: remove SHA1 prerequisites
 - t0090: make test pass with SHA-256
 - t0027: make hash size independent
 - t6030: make test work with SHA-256
 - t5000: make hash independent
 - t1450: make hash size independent
 - t1410: make hash size independent
 - t: add helper to convert object IDs to paths

 Update to the tests to help SHA-256 transition continues.

 Ready?  After cursory scan of this series I didn't find anything
 glaringly wrong.  Will merge to 'next' until I hear otherwise
 within a few days.


* pw/prompt-cherry-pick-revert-fix (2019-07-01) 1 commit
  (merged to 'next' on 2019-07-09 at bf8f0af685)
 + git-prompt: improve cherry-pick/revert detection

 When one step in multi step cherry-pick or revert is reset or
 committed, the command line prompt script failed to notice the
 current status, which has been improved.

 Will merge to 'master'.


* pw/rebase-progress-test-cleanup (2019-07-08) 1 commit
  (merged to 'next' on 2019-07-11 at 1363de0fe2)
 + t3420: remove progress lines before comparing output

 Test cleanup.

 Will merge to 'master'.


* es/local-atomic-push-failure-with-http (2019-07-12) 1 commit
 - transport-helper: enforce atomic in push_refs_with_push

 "git push --atomic" that goes over the transport-helper (namely,
 the smart http transport) failed to prevent refs to be pushed when
 it can locally tell that one of the ref update will fail without
 having to consult the other end, which has been corrected.

 Will merge to 'next'.


* es/walken-tutorial (2019-07-02) 1 commit
 - documentation: add tutorial for revision walking

 Yet another revision walker tutorial.


* tb/ref-filter-multiple-patterns (2019-06-27) 1 commit
  (merged to 'next' on 2019-07-03 at f59ad42c4a)
 + ref-filter.c: find disjoint pattern prefixes

 "git for-each-ref" with multiple patterns have been optimized.

 Will merge to 'master'.


* ew/repack-with-bitmaps-by-default (2019-07-01) 1 commit
  (merged to 'next' on 2019-07-09 at 985419cb6e)
 + repack: disable bitmaps-by-default if .keep files exist

 Generation of pack bitmaps are now disabled when .keep files exist,
 as these are mutually exclusive features.

 Will merge to 'master'.


* jk/check-connected-with-alternates (2019-07-01) 2 commits
  (merged to 'next' on 2019-07-09 at b5888bd955)
 + check_everything_connected: assume alternate ref tips are valid
 + object-store.h: move for_each_alternate_ref() from transport.h

 The tips of refs from the alternate object store can be used as
 starting point for reachability computation now.

 Will merge to 'master'.


* jk/test-commit-bulk (2019-07-02) 7 commits
 - SQUASH???
 - t6200: use test_commit_bulk
 - t5703: use test_commit_bulk
 - t5702: use test_commit_bulk
 - t3311: use test_commit_bulk
 - t5310: increase the number of bitmapped commits
 - test-lib: introduce test_commit_bulk

 A test helper has been introduced to optimize preparation of test
 repositories with many simple commits, and a handful of test
 scripts have been updated to use it.

 Needs a bit more polishing.
 I think I spotted one unused command, which we may want to remove, though.


* ab/test-env (2019-07-11) 9 commits
 - env--helper: mark a file-local symbol as static
  (merged to 'next' on 2019-07-09 at 096658f382)
 + tests: make GIT_TEST_FAIL_PREREQS a boolean
 + tests: replace test_tristate with "git env--helper"
 + tests README: re-flow a previously changed paragraph
 + tests: make GIT_TEST_GETTEXT_POISON a boolean
 + t6040 test: stop using global "script" variable
 + config.c: refactor die_bad_number() to not call gettext() early
 + env--helper: new undocumented builtin wrapping git_env_*()
 + config tests: simplify include cycle test

 Many GIT_TEST_* environment variables control various aspects of
 how our tests are run, but a few followed "non-empty is true, empty
 or unset is false" while others followed the usual "there are a few
 ways to spell true, like yes, on, etc., and also ways to spell
 false, like no, off, etc." convention.

 Will merge to 'next'.


* ds/early-access (2019-07-01) 3 commits
 - repo-settings: pack.useSparse=true
 - repo-settings: use index.version=4 by default
 - repo-settings: create core.featureAdoptionRate setting

 A mechanism to enable newish configuration settings in bulk has
 been invented.

 The model may need to be rethought.  A linear scale with "early
 adoption" mindset may not match diverse use cases of the tool.


* pw/status-with-corrupt-sequencer-state (2019-06-27) 3 commits
  (merged to 'next' on 2019-07-03 at 273aee6b3c)
 + status: do not report errors in sequencer/todo
 + sequencer: factor out todo command name parsing
 + sequencer: always allow tab after command name

 The code to read state files used by the sequencer machinery for
 "git status" has been made more robust against a corrupt or stale
 state files.

 Will merge to 'master'.


* ab/no-kwset (2019-07-01) 10 commits
 - grep: use PCRE v2 for optimized fixed-string search
 - grep: remove the kwset optimization
 - grep: drop support for \0 in --fixed-strings <pattern>
 - grep: make the behavior for NUL-byte in patterns sane
 - grep tests: move binary pattern tests into their own file
 - grep tests: move "grep binary" alongside the rest
 - grep: inline the return value of a function call used only once
 - t4210: skip more command-line encoding tests on MinGW
 - grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 - log tests: test regex backends in "--encode=<enc>" tests

 Retire use of kwset library, which is an optimization for looking
 for fixed strings, with use of pcre2 JIT.

 Will merge to 'next'.


* nd/tree-walk-with-repo (2019-06-28) 7 commits
  (merged to 'next' on 2019-07-09 at 3e613f977c)
 + t7814: do not generate same commits in different repos
 + Use the right 'struct repository' instead of the_repository
 + match-trees.c: remove the_repo from shift_tree*()
 + tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
 + tree-walk.c: remove the_repo from get_tree_entry()
 + tree-walk.c: remove the_repo from fill_tree_descriptor()
 + sha1-file.c: remove the_repo from read_object_with_reference()

 The tree-walk API learned to pass an in-core repository
 instance throughout more codepaths.

 Will merge to 'master'.


* md/list-objects-filter-combo (2019-06-28) 10 commits
 - list-objects-filter-options: make parser void
 - list-objects-filter-options: clean up use of ALLOC_GROW
 - list-objects-filter-options: allow mult. --filter
 - strbuf: give URL-encoding API a char predicate fn
 - list-objects-filter-options: make filter_spec a string_list
 - list-objects-filter-options: move error check up
 - list-objects-filter: implement composite filters
 - list-objects-filter-options: always supply *errbuf
 - list-objects-filter: put omits set in filter struct
 - list-objects-filter: encapsulate filter components

 The list-objects-filter API (used to create a sparse/lazy clone)
 learned to take a combined filter specification.

 There is a bit of interaction with cc/multi-promisor topic, whose
 conflict resolution I have no confidence in X-<.  Extra sets of
 eyes are appreciated.


* cb/xdiff-no-system-includes-in-dot-c (2019-06-19) 1 commit
 - xdiff: avoid accidental redefinition of LFS feature in OpenIndiana

 Compilation fix.

 Will be rerolled together with patches from the
 jk/no-system-includes-in-dot-c topic.


* jk/no-system-includes-in-dot-c (2019-06-19) 2 commits
 - wt-status.h: drop stdio.h include
 - verify-tag: drop signal.h include

 Compilation fix.

 Will be rerolled with the above.


* ra/cherry-pick-revert-skip (2019-07-02) 5 commits
  (merged to 'next' on 2019-07-09 at 4ffa502220)
 + cherry-pick/revert: advise using --skip
 + cherry-pick/revert: add --skip option
 + sequencer: use argv_array in reset_merge
 + sequencer: rename reset_for_rollback to reset_merge
 + sequencer: add advice for revert

 "git cherry-pick/revert" learned a new "--skip" action.

 Will merge to 'master'.


* cc/test-oidmap (2019-07-01) 6 commits
  (merged to 'next' on 2019-07-01 at 331a414a24)
 + t0016: add 'remove' subcommand test
 + test-oidmap: remove 'add' subcommand
  (merged to 'next' on 2019-06-27 at 247a4341ca)
 + test-hashmap: remove 'hash' command
 + oidmap: use sha1hash() instead of static hash() function
 + t: add t0016-oidmap.sh
 + t/helper: add test-oidmap.c

 Extend the test coverage a bit.

 Will merge to 'master'.


* ds/midx-expire-repack (2019-07-01) 12 commits
  (merged to 'next' on 2019-07-01 at c2a907f395)
 + t5319: use 'test-tool path-utils' instead of 'ls -l'
  (merged to 'next' on 2019-06-27 at 35e6e3b38d)
 + t5319-multi-pack-index.sh: test batch size zero
 + midx: add test that 'expire' respects .keep files
 + multi-pack-index: test expire while adding packs
 + midx: implement midx_repack()
 + multi-pack-index: prepare 'repack' subcommand
 + multi-pack-index: implement 'expire' subcommand
 + midx: refactor permutation logic and pack sorting
 + midx: simplify computation of pack name lengths
 + multi-pack-index: prepare for 'expire' subcommand
 + Docs: rearrange subcommands for multi-pack-index
 + repack: refactor pack deletion for future use

 "git multi-pack-index" learned expire and repack subcommands.

 Will merge to 'master'.


* jl/status-reduce-vertical-blank (2019-06-21) 1 commit
  (merged to 'next' on 2019-07-11 at 5716f37348)
 + status: remove the empty line after hints

 Extra blank lines in "git status" output have been reduced.

 Will merge to 'master'.


* ds/commit-graph-incremental (2019-06-19) 18 commits
  (merged to 'next' on 2019-07-03 at 5dee5edbdf)
 + commit-graph: test verify across alternates
 + commit-graph: normalize commit-graph filenames
 + commit-graph: test --split across alternate without --split
 + commit-graph: test octopus merges with --split
 + commit-graph: clean up chains after flattened write
 + commit-graph: verify chains with --shallow mode
 + commit-graph: create options for split files
 + commit-graph: expire commit-graph files
 + commit-graph: allow cross-alternate chains
 + commit-graph: merge commit-graph chains
 + commit-graph: add --split option to builtin
 + commit-graph: write commit-graph chains
 + commit-graph: rearrange chunk count logic
 + commit-graph: add base graphs chunk
 + commit-graph: load commit-graph chains
 + commit-graph: rename commit_compare to oid_compare
 + commit-graph: prepare for commit-graph chains
 + commit-graph: document commit-graph chains

 The commits in a repository can be described by multiple
 commit-graph files now, which allows the commit-graph files to be
 updated incrementally.

 Will cook in 'next'.


* cc/multi-promisor (2019-06-25) 15 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.

 There is a bit of interaction with md/list-objects-filter-combo
 topic, whose conflict resolution I have no confidence in X-<.
 Extra sets of eyes are appreciated.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 On hold.
 cf. <20190508001252.15752-1-avarab@gmail.com>
 cf. <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>


* br/blame-ignore (2019-07-01) 11 commits
  (merged to 'next' on 2019-07-01 at f4b79421c9)
 + t8014: remove unnecessary braces
 + blame: drop some unused function parameters
  (merged to 'next' on 2019-06-27 at 36b91a787f)
 + blame: add a test to cover blame_coalesce()
 + blame: use the fingerprint heuristic to match ignored lines
 + blame: add a fingerprint heuristic to match ignored lines
 + blame: optionally track line fingerprints during fill_blame_origin()
 + blame: add config options for the output of ignored or unblamable lines
 + blame: add the ability to ignore commits and their changes
 + blame: use a helper function in blame_chunk()
 + Move oidset_parse_file() to oidset.c
 + fsck: rename and touch up init_skiplist()

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Will cook in 'next'.
