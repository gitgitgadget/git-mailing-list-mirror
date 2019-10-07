Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E84C1F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 03:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfJGDiW (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 23:38:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64075 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJGDiV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 23:38:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6D3A8E96D;
        Sun,  6 Oct 2019 23:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=8
        Betztt5JQA+4VlvCjIygdDMtUo=; b=Q9KO6IIlSN/0hhCNJcgIb71WY52UEI30o
        w9SzWeDCtfrO5xzMcMCK4nK5TqtOFSv5UVRaqkPSmyWS5nMXlEVMnSyRrG8o047/
        3EF3oN6ePbotL1a5Qhb4iyX0AEj9B5QRadRQ25+adCNgBj+rdIcRKlCrE200wTwL
        ssI2Bd8Lfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=sTT
        HyoHCX4i8p2S0j/1lybDjjQW9+qJq2xVZY1JjnEe1fyMbKqyUKuLySFRVczbG8GC
        X8FD6IB9DmxrofzJQd+hwn31UXGn+FzTA4EToE1uhuInhFOlqXFeQFfdO/TEE9Nl
        Ni7Y2cn2mtHkIACOBiNpsm6KUGtr62nOupGF9t5c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E6CA8E96C;
        Sun,  6 Oct 2019 23:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92EA58E96B;
        Sun,  6 Oct 2019 23:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2019, #02; Mon, 7)
X-master-at: b744c3af07a15aaeb1b82fab689995fd5528f120
X-next-at: a0afb4120df1aa6aa268d347b87bc5bd5302742c
Date:   Mon, 07 Oct 2019 12:38:03 +0900
Message-ID: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF63FD0A-E8B3-11E9-90D2-8D86F504CC47-77302942!pb-smtp21.pobox.com
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

* ah/doc-submodule-ignore-submodules (2019-09-18) 1 commit
  (merged to 'next' on 2019-09-30 at 9eb3de8d1b)
 + doc: fix reference to --ignore-submodules

 Docfix.


* am/mailmap-andrey-mazo (2019-09-20) 1 commit
  (merged to 'next' on 2019-09-30 at 5e373b3cba)
 + .mailmap: update email address of Andrey Mazo


* bc/doc-use-docbook-5 (2019-09-16) 1 commit
  (merged to 'next' on 2019-09-30 at 31c4cf70ae)
 + Documentation: fix build with Asciidoctor 2

 Start using DocBook 5 (instead of DocBook 4.5) as Asciidoctor 2.0
 no longer works with the older one.


* bw/submodule-helper-usage-fix (2019-09-29) 1 commit
  (merged to 'next' on 2019-09-30 at 78d2f28ef7)
 + builtin/submodule--helper: fix usage string for 'update-clone'

 Typofix.


* cb/do-not-use-test-cmp-with-a (2019-09-28) 1 commit
  (merged to 'next' on 2019-09-30 at 273ff0e62d)
 + t4038: Remove non-portable '-a' option passed to test_cmp

 Test portability fix.


* cb/skip-utf8-check-with-pcre1 (2019-09-09) 1 commit
  (merged to 'next' on 2019-09-30 at f6113b33cf)
 + grep: skip UTF8 checks explicitly

 Make sure the grep machinery does not abort when seeing a payload
 that is not UTF-8 even when JIT is not in use with PCRE1.


* cc/multi-promisor (2019-10-02) 2 commits
  (merged to 'next' on 2019-10-03 at a0a8ea56a9)
 + promisor-remote: skip move_to_tail when no-op
  (merged to 'next' on 2019-09-30 at c4826f5a08)
 + promisor-remote.h: drop extern from function declaration

 Cleanup.


* cc/svn-fe-py-shebang (2019-09-18) 1 commit
  (merged to 'next' on 2019-09-30 at 27c8457202)
 + contrib/svn-fe: fix shebang for svnrdump_sim.py


* cs/pretty-formats-doc-typofix (2019-09-12) 1 commit
  (merged to 'next' on 2019-09-30 at a29a425208)
 + doc: minor formatting fix

 Doc fix.


* dl/cocci-everywhere (2019-09-17) 4 commits
  (merged to 'next' on 2019-09-30 at 1bb1c0846f)
 + Makefile: run coccicheck on more source files
 + Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
 + Makefile: define THIRD_PARTY_SOURCES
 + Makefile: strip leading ./ in $(LIB_H)

 Coccinelle checks are done on more source files than before now.


* dl/complete-rebase-and-archive (2019-09-12) 2 commits
  (merged to 'next' on 2019-09-30 at ddeb81ff41)
 + completion: teach archive to use __gitcomp_builtin
 + completion: teach rebase to use __gitcomp_builtin

 The command line completion for "git archive" and "git rebase" are
 now made less prone to go out of sync with the binary.


* dl/honor-cflags-in-hdr-check (2019-10-03) 5 commits
  (merged to 'next' on 2019-10-03 at a346b79a78)
 + ci: run `hdr-check` as part of the `Static Analysis` job
  (merged to 'next' on 2019-09-30 at 708fb8988e)
 + Makefile: emulate compile in $(HCO) target better
 + pack-bitmap.h: remove magic number
 + promisor-remote.h: include missing header
 + apply.h: include missing header

 Dev support.


* dl/submodule-set-branch (2019-09-16) 1 commit
  (merged to 'next' on 2019-09-30 at c66b398cc1)
 + git-submodule.txt: fix AsciiDoc formatting error

 Docfix.


* gs/commit-graph-progress (2019-09-18) 1 commit
  (merged to 'next' on 2019-09-30 at 7c03eac969)
 + commit-graph: add --[no-]progress to write and verify


* hb/hg-to-git-py3 (2019-09-18) 1 commit
  (merged to 'next' on 2019-09-30 at 28f7e9bae3)
 + hg-to-git: make it compatible with both python3 and python2

 The hg-to-git script (in contrib/) has been updated to work with
 Python 3.


* jc/git-gui-has-maintainer (2019-09-18) 1 commit
  (merged to 'next' on 2019-09-30 at dfe61e947c)
 + SubmittingPatches: git-gui has a new maintainer


* jk/commit-graph-cleanup (2019-09-09) 2 commits
  (merged to 'next' on 2019-09-30 at f78e24d14b)
 + commit-graph: turn off save_commit_buffer
 + commit-graph: don't show progress percentages while expanding reachable commits

 A pair of small fixups to "git commit-graph" have been applied.


* jk/disable-commit-graph-during-upload-pack (2019-09-12) 2 commits
  (merged to 'next' on 2019-09-30 at 87dae76fb7)
 + upload-pack: disable commit graph more gently for shallow traversal
 + commit-graph: bump DIE_ON_LOAD check to actual load-time

 The "upload-pack" (the counterpart of "git fetch") needs to disable
 commit-graph when responding to a shallow clone/fetch request, but
 the way this was done made Git panic, which has been corrected.


* jk/list-objects-optim-wo-trees (2019-09-12) 1 commit
  (merged to 'next' on 2019-09-30 at 9ef098d07f)
 + list-objects: don't queue root trees unless revs->tree_objects is set

 The object traversal machinery has been optimized not to load tree
 objects when we are only interested in commit history.


* jk/partial-clone-sparse-blob (2019-09-16) 4 commits
  (merged to 'next' on 2019-09-30 at 44b33488ea)
 + list-objects-filter: use empty string instead of NULL for sparse "base"
 + list-objects-filter: give a more specific error sparse parsing error
 + list-objects-filter: delay parsing of sparse oid
 + t5616: test cloning/fetching with sparse:oid=<oid> filter

 The name of the blob object that stores the filter specification
 for sparse cloning/fetching was interpreted in a wrong place in the
 code, causing Git to abort.


* js/doc-patch-text (2019-09-17) 2 commits
  (merged to 'next' on 2019-09-30 at f9b391a66b)
 + diff, log doc: small grammer, format, and language fixes
 + diff, log doc: say "patch text" instead of "patches"

 Docfix.


* jt/cache-tree-avoid-lazy-fetch-during-merge (2019-09-09) 1 commit
  (merged to 'next' on 2019-09-30 at 5d8ffc2e0f)
 + cache-tree: do not lazy-fetch tentative tree

 The cache-tree code has been taught to be less aggressive in
 attempting to see if a tree object it computed already exists in
 the repository.


* jt/merge-recursive-symlink-is-not-a-dir-in-way (2019-09-20) 1 commit
  (merged to 'next' on 2019-09-30 at a5d6788e2e)
 + merge-recursive: symlink's descendants not in way

 A bug in merge-recursive code that triggers when a branch with a
 symbolic link is merged with a branch that replaces it with a
 directory has been fixed.


* ma/asciidoctor-more-fixes (2019-09-09) 7 commits
  (merged to 'next' on 2019-09-30 at 4937cac46f)
 + gitweb.conf.txt: switch pluses to backticks to help Asciidoctor
 + git-merge-index.txt: wrap shell listing in "----"
 + git-receive-pack.txt: wrap shell [script] listing in "----"
 + git-ls-remote.txt: wrap shell listing in "----"
 + Documentation: wrap config listings in "----"
 + git-merge-base.txt: render indentations correctly under Asciidoctor
 + Documentation: wrap blocks with "--"

 Doc formatting updates.


* ma/asciidoctor-refmiscinfo (2019-09-16) 3 commits
  (merged to 'next' on 2019-09-30 at e5d13aceb8)
 + doc-diff: replace --cut-header-footer with --cut-footer
 + asciidoctor-extensions: provide `<refmiscinfo/>`
 + Doc/Makefile: give mansource/-version/-manual attributes

 Update support for Asciidoctor documentation toolchain.


* ma/user-manual-markup-update (2019-09-28) 4 commits
  (merged to 'next' on 2019-09-30 at 822fa2ed99)
 + user-manual.txt: render ASCII art correctly under Asciidoctor
 + asciidoctor-extensions.rb: handle "book" doctype in linkgit
 + user-manual.txt: change header notation
 + user-manual.txt: add missing section label

 The markup used in user-manual has been updated to work better with
 asciidoctor.


* mr/complete-more-for-log-etc (2019-09-12) 1 commit
  (merged to 'next' on 2019-09-30 at b2507b21cb)
 + completion: add missing completions for log, diff, show

 Completion updates.


* ms/fetch-follow-tag-optim (2019-09-16) 1 commit
  (merged to 'next' on 2019-09-30 at 97ec83d2a2)
 + fetch: use oidset to keep the want OIDs for faster lookup

 The code used in following tags in "git fetch" has been optimized.


* ps/my-first-contribution-alphasort (2019-09-28) 1 commit
  (merged to 'next' on 2019-09-30 at 729e6dc708)
 + doc: MyFirstContribution: fix cmd placement instructions

 Docfix.


* rs/alias-use-copy-array (2019-09-20) 1 commit
  (merged to 'next' on 2019-09-30 at 4d90f4ba93)
 + git: use COPY_ARRAY and MOVE_ARRAY in handle_alias()

 Code cleanup.


* rs/commit-graph-use-list-count (2019-09-16) 1 commit
  (merged to 'next' on 2019-09-30 at 8986e5537f)
 + commit-graph: use commit_list_count()

 Code cleanup.


* rs/nth-parent-parse (2019-09-16) 2 commits
  (merged to 'next' on 2019-09-30 at 5bdfeacdff)
 + sha1-name: check for overflow of N in "foo^N" and "foo~N"
 + rev-parse: demonstrate overflow of N for "foo^N" and "foo~N"

 The object name parser for "Nth parent" syntax has been made more
 robust against integer overflows.


* rs/nth-switch-code-simplification (2019-09-18) 1 commit
  (merged to 'next' on 2019-09-30 at 4233f54a72)
 + sha1_name: simplify strbuf handling in interpret_nth_prior_checkout()

 Code simplification.


* rs/simplify-by-deco-with-deco-refs-exclude (2019-09-09) 2 commits
  (merged to 'next' on 2019-09-30 at 3c155bbd24)
 + log-tree: call load_ref_decorations() in get_name_decoration()
 + log: test --decorate-refs-exclude with --simplify-by-decoration

 "git log --decorate-refs-exclude=<pattern>" was incorrectly
 overruled when the "--simplify-by-decoration" option is used, which
 has been corrected.


* sg/progress-fix (2019-09-17) 2 commits
  (merged to 'next' on 2019-09-30 at d352332810)
 + Test the progress display
 + Revert "progress: use term_clear_line()"

 Regression fix for progress output.


* sg/t-helper-gitignore (2019-09-20) 1 commit
  (merged to 'next' on 2019-09-30 at 8e319a2eae)
 + t/helper: ignore only executable files

 Update the way build artifacts in t/helper/ directory are ignored.


* sg/travis-help-debug (2019-09-28) 1 commit
  (merged to 'next' on 2019-09-30 at 054a66bb75)
 + travis-ci: do not skip successfully tested trees in debug mode

 Dev support update.


* ss/get-time-cleanup (2019-09-18) 2 commits
  (merged to 'next' on 2019-09-30 at 21a0dced8f)
 + test_date.c: remove reference to GIT_TEST_DATE_NOW
 + Quit passing 'now' to date code

 Code simplification.


* tb/commit-graph-harden (2019-09-09) 3 commits
  (merged to 'next' on 2019-09-30 at b9350a562d)
 + commit-graph.c: handle corrupt/missing trees
 + commit-graph.c: handle commit parsing errors
 + t/t5318: introduce failing 'git commit-graph write' tests

 The code to parse and use the commit-graph file has been made more
 robust against corrupted input.


* tg/stash-refresh-index (2019-09-20) 3 commits
  (merged to 'next' on 2019-09-30 at de7759ad1d)
 + stash: make sure to write refreshed cache
 + merge: use refresh_and_write_cache
 + factor out refresh_and_write_cache function

 "git stash" learned to write refreshed index back to disk.

--------------------------------------------------
[New Topics]

* dl/octopus-graph-bug (2019-10-04) 5 commits
  (merged to 'next' on 2019-10-07 at c6bc2fe4a0)
 + t4214: demonstrate octopus graph coloring failure
 + t4214: explicitly list tags in log
 + t4214: generate expect in their own test cases
 + t4214: use test_merge
 + test-lib: let test_merge() perform octopus merges

 "git log --graph" for an octopus merge is sometimes colored
 incorrectly, which is demonstrated and documented but not yet
 fixed.

 Will merge to 'master'.


* js/azure-pipelines-msvc (2019-10-06) 13 commits
  (merged to 'next' on 2019-10-07 at d5a3604dc6)
 + ci: also build and test with MS Visual Studio on Azure Pipelines
 + ci: really use shallow clones on Azure Pipelines
 + tests: let --immediate and --write-junit-xml play well together
 + test-tool run-command: learn to run (parts of) the testsuite
 + vcxproj: include more generated files
 + vcxproj: only copy `git-remote-http.exe` once it was built
 + msvc: work around a bug in GetEnvironmentVariable()
 + msvc: handle DEVELOPER=1
 + msvc: ignore some libraries when linking
 + compat/win32/path-utils.h: add #include guards
 + winansi: use FLEX_ARRAY to avoid compiler warning
 + msvc: avoid using minus operator on unsigned types
 + push: do not pretend to return `int` from `die_push_simple()`

 CI updates.

 Will merge to 'master'.


* js/stash-apply-in-secondary-worktree (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at b3474c9c3d)
 + stash apply: report status correctly even in a worktree's subdirectory

 "git stash apply" in a subdirectory of a secondary worktree failed
 to access the worktree correctly, which has been corrected.

 Will merge to 'master'.


* js/trace2-cap-max-output-files (2019-10-05) 4 commits
 - trace2: write discard message to sentinel files
 - trace2: discard new traces if target directory has too many files
 - docs: clarify trace2 version invariants
 - docs: mention trace2 target-dir mode in git-config

 The trace2 output, when sending them to files in a designated
 directory, can populate the directory with too many files; a
 mechanism is introduced to set the maximum number of files and
 discard further logs when the maximum is reached.

 Will merge to 'next'.


* kt/add-i-progress (2019-10-04) 1 commit
  (merged to 'next' on 2019-10-07 at 00cf8fe076)
 + add -i: show progress counter in the prompt

 "git add -i" has been taught to show the total number of hunks and
 the hunks that has been processed so far when showing prompts.

 Will merge to 'master'.


* rs/dedup-includes (2019-10-04) 1 commit
  (merged to 'next' on 2019-10-07 at 5a4fc44657)
 + treewide: remove duplicate #include directives

 Code cleanup.

 Will merge to 'master'.


* bc/hash-independent-tests-part-6 (2019-10-06) 15 commits
 - t4048: abstract away SHA-1-specific constants
 - t4045: make hash-size independent
 - t4044: update test to work with SHA-256
 - t4039: abstract away SHA-1-specific constants
 - t4038: abstract away SHA-1 specific constants
 - t4034: abstract away SHA-1-specific constants
 - t4027: make hash-size independent
 - t4015: abstract away SHA-1-specific constants
 - t4011: abstract away SHA-1-specific constants
 - t4010: abstract away SHA-1-specific constants
 - t3429: remove SHA1 annotation
 - t1305: avoid comparing extensions
 - rev-parse: add an --object-format option
 - t/oid-info: add empty tree and empty blob values
 - t/oid-info: allow looking up hash algorithm name

 Test updates to prepare for SHA-2 transition continues.

 Will merge to 'next'.


* bw/format-patch-o-create-leading-dirs (2019-10-06) 1 commit
 - format-patch: create leading components of output directory

 "git format-patch -o <outdir>" did an equivalent of "mkdir <outdir>"
 not "mkdir -p <outdir>", which is being corrected.

 Use of adjust shared perm on the leading directory may have
 security implictions.


* dl/rev-list-doc-cleanup (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 712594feb1)
 + git-rev-list.txt: prune options in synopsis

 Doc update.

 Will merge to 'master'.


* py/git-gui-has-maintainer (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 0945190c4c)
 + Documentation: update the location of the git-gui repo

 Doc update.

 Will merge to 'master'.


* rs/convert-fix-utf-without-dash (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 9d0e27b5c3)
 + convert: fix handling of dashless UTF prefix in validate_encoding()

 The code to skip "UTF" and "UTF-" prefix, when computing an advice
 message, did not work correctly when the prefix was "UTF", which
 has been fixed.

 Will merge to 'master'.


* pm/p4-auto-delete-named-temporary (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at 4f45be70f5)
 + git-p4: auto-delete named temporary file

 Will merge to 'master'.


* rs/test-remove-useless-debugging-cat (2019-10-07) 1 commit
  (merged to 'next' on 2019-10-07 at 6d8cb22a4f)
 + tests: remove "cat foo" before "test_i18ngrep bar foo"

 Code cleanup.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* cb/pcre2-chartables-leakfix (2019-08-06) 3 commits
 - grep: avoid leak of chartables in PCRE2
 - grep: make PCRE2 aware of custom allocator
 - grep: make PCRE1 aware of custom allocator

 WIP (this is v3 which is rather old, where the last message in the
 discussion talks about v6 that has never been sent to the list).
 cf. <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>


* es/walken-tutorial (2019-08-07) 1 commit
 - documentation: add tutorial for revision walking

 A tutorial on object enumeration.

 Perhaps take the thing with as little tweaks as possible, retitling
 it to "my first object enumeration" or something?
 cf. <20190814183328.GA40797@google.com>


* dl/format-patch-cover-letter-subject (2019-09-05) 1 commit
 - format-patch: learn --infer-cover-subject option

 "git format-patch --cover-letter" learned to optionally use the
 first paragraph (typically a single-liner) of branch.*.description
 as the subject of the cover letter.

 Reroll with a redesign with less emphasis on "subject" coming?


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

--------------------------------------------------
[Cooking]

* ag/sequencer-todo-updates (2019-10-02) 5 commits
 - sequencer: directly call pick_commits() from complete_action()
 - rebase: fill `squash_onto' in get_replay_opts()
 - sequencer: move the code writing total_nr on the disk to a new function
 - sequencer: update `done_nr' when skipping commands in a todo list
 - sequencer: update `total_nr' when adding an item to a todo list

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.1910021018360.46@tvgsbejvaqbjf.bet> to clarify log messages.
 there may be others.


* ah/cleanups (2019-10-03) 4 commits
  (merged to 'next' on 2019-10-04 at 1345f09afb)
 + git_mkstemps_mode(): replace magic numbers with computed value
 + wrapper: use a loop instead of repetitive statements
 + diffcore-break: use a goto instead of a redundant if statement
 + commit-graph: remove a duplicate assignment

 Miscellaneous code clean-ups.

 Will merge to 'master'.


* as/shallow-slab-use-fix (2019-10-02) 1 commit
  (merged to 'next' on 2019-10-04 at f3a22d2b18)
 + shallow.c: don't free unallocated slabs

 Correct code that tried to reference all entries in a sparse array
 of pointers by mistake.

 Will merge to 'master'.


* js/fetch-jobs (2019-10-06) 1 commit
  (merged to 'next' on 2019-10-07 at e798bac35d)
 + fetch: let --jobs=<n> parallelize --multiple, too

 "git fetch --jobs=<n>" allowed <n> parallel jobs when fetching
 submodules, but this did not apply to "git fetch --multiple" that
 fetches from multiple remote repositories.  It now does.

 Will merge to 'master'.


* js/mingw-spawn-with-spaces-in-path (2019-10-02) 1 commit
  (merged to 'next' on 2019-10-04 at 0fdb87dd53)
 + t0061: fix test for argv[0] with spaces (MINGW only)

 Test fix.

 Will merge to 'master'.


* gs/commit-graph-trace-with-cmd (2019-10-02) 1 commit
  (merged to 'next' on 2019-10-07 at 369df0e5cd)
 + commit-graph: emit trace2 cmd_mode for each sub-command

 Dev support.

 Will merge to 'master'.


* js/trace2-fetch-push (2019-10-03) 2 commits
  (merged to 'next' on 2019-10-04 at 1d63701064)
 + push: add trace2 instrumentation
 + fetch: add trace2 instrumentation

 Dev support.

 Will merge to 'master'.


* js/range-diff-noprefix (2019-10-03) 1 commit
  (merged to 'next' on 2019-10-04 at 56cf767bdb)
 + range-diff: internally force `diff.noprefix=true`

 "git range-diff" segfaulted when diff.noprefix configuration was
 used, as it blindly expected the patch it internally generates to
 have the standard a/ and b/ prefixes.  The command now forces the
 internal patch to be built without any prefix, not to be affected
 by any end-user configuration.

 Will merge to 'master'.


* mt/threaded-grep-in-object-store (2019-10-02) 11 commits
 - grep: move driver pre-load out of critical section
 - grep: re-enable threads in non-worktree case
 - grep: protect packed_git [re-]initialization
 - grep: allow submodule functions to run in parallel
 - submodule-config: add skip_if_read option to repo_read_gitmodules()
 - grep: replace grep_read_mutex by internal obj read lock
 - object-store: allow threaded access to object reading
 - replace-object: make replace operations thread-safe
 - grep: fix racy calls in grep_objects()
 - grep: fix race conditions at grep_submodule()
 - grep: fix race conditions on userdiff calls

 Traditionally, we avoided threaded grep while searching in objects
 (as opposed to files in the working tree) as accesses to the object
 layer is not thread-safe.  This limitation is getting lifted.


* am/t0028-utf16-tests (2019-09-28) 2 commits
 - t0028: add more tests
 - t0028: fix test for UTF-16-LE-BOM

 Test fixes.

 Will merge to 'next'.


* am/visual-studio-config-fix (2019-09-28) 1 commit
  (merged to 'next' on 2019-10-04 at 135d93143b)
 + contrib/buildsystems: fix Visual Studio Debug configuration

 Dev support.

 Will merge to 'master'.


* en/fast-imexport-nested-tags (2019-10-04) 8 commits
  (merged to 'next' on 2019-10-07 at 3e75779e10)
 + fast-export: handle nested tags
 + t9350: add tests for tags of things other than a commit
 + fast-export: allow user to request tags be marked with --mark-tags
 + fast-export: add support for --import-marks-if-exists
 + fast-import: add support for new 'alias' command
 + fast-import: allow tags to be identified by mark labels
 + fast-import: fix handling of deleted tags
 + fast-export: fix exporting a tag and nothing else

 Updates to fast-import/export.

 Will merge to 'master'.


* js/diff-rename-force-stable-sort (2019-10-02) 2 commits
  (merged to 'next' on 2019-10-04 at e02d882510)
 + diffcore_rename(): use a stable sort
 + Move git_sort(), a stable sort, into into libgit.a

 The rename detection logic sorts a list of rename source candidates
 by similarity to pick the best candidate, which means that a tie
 between sources with the same similarity is broken by the original
 location in the original canidate list (which is sorted by path).
 Force the sorting by similarity done with a stable sort, which is
 not promised by system supplied qsort(3), to ensure consistent
 results across platforms.

 Will merge to 'master'.


* sg/name-rev-cutoff-underflow-fix (2019-09-28) 1 commit
  (merged to 'next' on 2019-10-04 at 25e4436b3d)
 + name-rev: avoid cutoff timestamp underflow

 Integer arith fix.

 Will merge to 'master'.


* tk/git-svn-trim-author-name (2019-09-28) 1 commit
  (merged to 'next' on 2019-10-04 at c1c619f7c4)
 + git-svn: trim leading and trailing whitespaces in author name

 The author names taken from SVN repositories may have extra leading
 or trailing whitespaces, which are now munged away.

 Will merge to 'master'.


* bc/object-id-part17 (2019-08-19) 26 commits
  (merged to 'next' on 2019-10-04 at b0460b0db2)
 + midx: switch to using the_hash_algo
 + builtin/show-index: replace sha1_to_hex
 + rerere: replace sha1_to_hex
 + builtin/receive-pack: replace sha1_to_hex
 + builtin/index-pack: replace sha1_to_hex
 + packfile: replace sha1_to_hex
 + wt-status: convert struct wt_status to object_id
 + cache: remove null_sha1
 + builtin/worktree: switch null_sha1 to null_oid
 + builtin/repack: write object IDs of the proper length
 + pack-write: use hash_to_hex when writing checksums
 + sequencer: convert to use the_hash_algo
 + bisect: switch to using the_hash_algo
 + sha1-lookup: switch hard-coded constants to the_hash_algo
 + config: use the_hash_algo in abbrev comparison
 + combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
 + bundle: switch to use the_hash_algo
 + connected: switch GIT_SHA1_HEXSZ to the_hash_algo
 + show-index: switch hard-coded constants to the_hash_algo
 + blame: remove needless comparison with GIT_SHA1_HEXSZ
 + builtin/rev-parse: switch to use the_hash_algo
 + builtin/blame: switch uses of GIT_SHA1_HEXSZ to the_hash_algo
 + builtin/receive-pack: switch to use the_hash_algo
 + fetch-pack: use parse_oid_hex
 + patch-id: convert to use the_hash_algo
 + builtin/replace: make hash size independent

 Preparation for SHA-256 upgrade continues.

 Will merge to 'master'.


* en/clean-nested-with-ignored (2019-10-02) 13 commits
  (merged to 'next' on 2019-10-03 at 969ec06cc7)
 + dir: special case check for the possibility that pathspec is NULL
  (merged to 'next' on 2019-09-30 at 778cc31eac)
 + clean: fix theoretical path corruption
 + clean: rewrap overly long line
 + clean: avoid removing untracked files in a nested git repository
 + clean: disambiguate the definition of -d
 + git-clean.txt: do not claim we will delete files with -n/--dry-run
 + dir: add commentary explaining match_pathspec_item's return value
 + dir: if our pathspec might match files under a dir, recurse into it
 + dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
 + dir: also check directories for matching pathspecs
 + dir: fix off-by-one error in match_pathspec_item
 + dir: fix typo in comment
 + t7300: add testcases showing failure to clean specified pathspecs

 "git clean" fixes.

 Will merge to 'master'.


* jk/packfile-reuse-cleanup (2019-09-13) 10 commits
  (merged to 'next' on 2019-09-30 at dc60b31833)
 + pack-objects: improve partial packfile reuse
 + builtin/pack-objects: introduce obj_is_packed()
 + pack-objects: introduce pack.allowPackReuse
 + csum-file: introduce hashfile_total()
 + pack-bitmap: introduce bitmap_walk_contains()
 + pack-bitmap: don't rely on bitmap_git->reuse_objects
 + ewah/bitmap: always allocate 2 more words
 + ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 On hold until we give it a more thorough review.
 cf. <20191002155721.GD6116@sigill.intra.peff.net>


* cb/pcre1-cleanup (2019-08-26) 2 commits
  (merged to 'next' on 2019-10-04 at a2dd896ee8)
 + grep: refactor and simplify PCRE1 support
 + grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
 (this branch uses ab/pcre-jit-fixes.)

 PCRE fixes.

 Will merge to 'master'.


* ew/hashmap (2019-10-07) 20 commits
 - hashmap_entry: remove first member requirement from docs
 - hashmap: remove type arg from hashmap_{get,put,remove}_entry
 - OFFSETOF_VAR macro to simplify hashmap iterators
 - hashmap: introduce hashmap_free_entries
 - hashmap: hashmap_{put,remove} return hashmap_entry *
 - hashmap: use *_entry APIs for iteration
 - hashmap_cmp_fn takes hashmap_entry params
 - hashmap_get{,_from_hash} return "struct hashmap_entry *"
 - hashmap: use *_entry APIs to wrap container_of
 - hashmap_get_next returns "struct hashmap_entry *"
 - introduce container_of macro
 - hashmap_put takes "struct hashmap_entry *"
 - hashmap_remove takes "const struct hashmap_entry *"
 - hashmap_get takes "const struct hashmap_entry *"
 - hashmap_add takes "struct hashmap_entry *"
 - hashmap_get_next takes "const struct hashmap_entry *"
 - hashmap_entry_init takes "struct hashmap_entry *"
 - packfile: use hashmap_entry in delta_base_cache_entry
 - coccicheck: detect hashmap_entry.hash assignment
 - diff: use hashmap_entry_init on moved_entry.ent

 Code clean-up of the hashmap API, both users and implementation.

 Will merge to 'next'.


* js/builtin-add-i (2019-08-30) 11 commits
 . built-in add -i: implement the `help` command
 . built-in add -i: use color in the main loop
 . built-in add -i: support `?` (prompt help)
 . built-in add -i: show unique prefixes of the commands
 . Add a function to determine unique prefixes for a list of strings
 . built-in add -i: implement the main loop
 . built-in add -i: color the header in the `status` command
 . built-in add -i: refresh the index before running `status`
 . built-in add -i: implement the `status` command
 . diff: export diffstat interface
 . Start to implement a built-in version of `git add --interactive`

 The beginning of rewriting "git add -i" in C.

 On hold, waiting for tg/stash-refresh-index to work well with this.


* en/merge-recursive-cleanup (2019-10-02) 25 commits
  (merged to 'next' on 2019-10-03 at 7b5a32726b)
 + merge-recursive: fix the diff3 common ancestor label for virtual commits
  (merged to 'next' on 2019-09-18 at f52cb08a14)
 + merge-recursive: alphabetize include list
 + merge-recursive: add sanity checks for relevant merge_options
 + merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
 + merge-recursive: split internal fields into a separate struct
 + merge-recursive: avoid losing output and leaking memory holding that output
 + merge-recursive: comment and reorder the merge_options fields
 + merge-recursive: consolidate unnecessary fields in merge_options
 + merge-recursive: move some definitions around to clean up the header
 + merge-recursive: rename merge_options argument to opt in header
 + merge-recursive: rename 'mrtree' to 'result_tree', for clarity
 + merge-recursive: use common name for ancestors/common/base_list
 + merge-recursive: fix some overly long lines
 + cache-tree: share code between functions writing an index as a tree
 + merge-recursive: don't force external callers to do our logging
 + merge-recursive: remove useless parameter in merge_trees()
 + merge-recursive: exit early if index != head
 + Ensure index matches head before invoking merge machinery, round N
 + merge-recursive: remove another implicit dependency on the_repository
 + merge-recursive: future-proof update_file_flags() against memory leaks
 + merge-recursive: introduce an enum for detect_directory_renames values
 + merge-recursive: provide a better label for diff3 common ancestor
 + merge-recursive: enforce opt->ancestor != NULL when calling merge_trees()
 + checkout: provide better conflict hunk description with detached HEAD
 + merge-recursive: be consistent with assert

 The merge-recursive machiery is one of the most complex parts of
 the system that accumulated cruft over time.  This large series
 cleans up the implementation quite a bit.

 Will merge to 'master'.


* pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
  (merged to 'next' on 2019-10-04 at ab3d7eeb72)
 + sequencer: simplify root commit creation
 + rebase -i: check for updated todo after squash and reword
 + rebase -i: always update HEAD before rewording
 (this branch is used by ra/rebase-i-more-options.)

 "git rebase -i" showed a wrong HEAD while "reword" open the editor.

 Will merge to 'master'.


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


* ra/rebase-i-more-options (2019-09-09) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: allow callers of read_author_script() to ignore fields
 - rebase -i: add --ignore-whitespace flag
 (this branch uses pw/rebase-i-show-HEAD-to-reword.)

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.

 Needs to consider existing GIT_COMMITTER_DATE environment, etc.
 cf. <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>


* ab/pcre-jit-fixes (2019-08-19) 18 commits
  (merged to 'next' on 2019-10-04 at 2d55f2b470)
 + grep: under --debug, show whether PCRE JIT is enabled
 + grep: do not enter PCRE2_UTF mode on fixed matching
 + grep: stess test PCRE v2 on invalid UTF-8 data
 + grep: create a "is_fixed" member in "grep_pat"
 + grep: consistently use "p->fixed" in compile_regexp()
 + grep: stop using a custom JIT stack with PCRE v1
 + grep: stop "using" a custom JIT stack with PCRE v2
 + grep: remove overly paranoid BUG(...) code
 + grep: use PCRE v2 for optimized fixed-string search
 + grep: remove the kwset optimization
 + grep: drop support for \0 in --fixed-strings <pattern>
 + grep: make the behavior for NUL-byte in patterns sane
 + grep tests: move binary pattern tests into their own file
 + grep tests: move "grep binary" alongside the rest
 + grep: inline the return value of a function call used only once
 + t4210: skip more command-line encoding tests on MinGW
 + grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 + log tests: test regex backends in "--encode=<enc>" tests
 (this branch is used by cb/pcre1-cleanup.)

 A few simplification and bugfixes to PCRE interface.

 Will merge to 'master'.


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Will discard.

--------------------------------------------------
[Discarded]

* dl/remote-save-to-push (2018-12-11) 1 commit
 . remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.


* js/trace2-json-schema (2019-07-25) 3 commits
 . ci: run trace2 schema validation in the CI suite
 . trace2: add a schema validator for trace2 events
 . trace2: add a JSON schema for trace2 events

 The JSON output produced by "trace2" subsystem now has JSON schema
 defined on it, to allow us validate the output and catch deviation.

 Abandoned, at least for now.
 cf. <20190910182305.GA11186@google.com>


* pd/fetch-jobs (2019-08-13) 5 commits
 . fetch: make --jobs control submodules and remotes
 . fetch: add the --submodule-fetch-jobs option
 . fetch: add the fetch.jobs config key
 . fetch: add the "--fetch-jobs" option
 . fetch: rename max_children to max_children_for_submodules

 "git fetch --jobs" is getting taught to also run fetch jobs in
 parallel when fetching from multiple remote repositories.

 cf. <nycvar.QRO.7.76.6.1909111359150.5377@tvgsbejvaqbjf.bet>


* js/honor-cflags-in-hdr-check (2019-08-26) 1 commit
  (merged to 'next' on 2019-09-09 at fcd9ee9f1b)
 + hdr-check: make it work on Windows

 Build fix to make sure hdr-check is run with the same preprocessor
 macros predefined by the $(MAKE) procedure.

 Superseded by dl/honor-cflags-in-hdr-check series.
