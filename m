Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D03B1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 07:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfBGH17 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 02:27:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39541 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfBGH16 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 02:27:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so656687wmh.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 23:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=eit1iCJm63cRBNaPfUAqvgB2JRL5rouFOQCbkQwg9wY=;
        b=DRB0oOamdqRTq6aq5/aQuwgc6nAUN3IBM4Fxg4Jeg3pfch6oZZmqQT38nHlZkyQhUK
         HeNBiNG3ojoy8v+lIOnNnMZ1Wz9nLv0SecUY9ql3xAUmi4jFWzG/x0mh8Ubz6tOFaQLV
         UI6YqPu7cWdnPUiBB1e+tD5FECVPcjRaVTdb28OrAK0yU1HLi3PfwuPi1lAQPpCQ96iY
         7njELICyOKuf4Du1HbzXX7xWsAsibdXmx1dOSgYMo16C/DaGna3YboCdIuc8s4DjTD+F
         JFksPKR279TTPlllARQc0j2gCpp9DyDBMfrCFXeUpl38s0orpmzaYQhcf2h9XJnes4Sf
         iTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=eit1iCJm63cRBNaPfUAqvgB2JRL5rouFOQCbkQwg9wY=;
        b=eXID+Y2o/bnyBuhF6REtsYSr+uaPZjEEtIWMVnpt8VbPG8rr8Fdr1WJX4l4hzhGOdi
         AvGhXbuKZeS1doELhb+qdtuxmQGoMWYG6ybCTWZM/2wkbwF4+B22DilmnIV+WE6scKb1
         uEDiGgMc6eTdKIHO3dQc9Fre4KHsCpv+K0faPEGPmydK2jTNe5c8MaZ3Qe9ZVDkxRxbG
         FV/ChPByiTQpkCjGJNU29zW+kegWQg3Fm2OUVdxekiHv4oqUsU5S8oOkQdYd3Z25h5CR
         j1W+n23MpKsq604WyB9Al7u6kP6w/20OPgx6vTMs6M2sbaYGLoZVcTh9hBvbVnZPymGq
         hP3A==
X-Gm-Message-State: AHQUAuZ7IopXzBjvrnvPovxTb6XD6J9r5dwlkW6lSA6el7H9ivw8MX0x
        R684Nxp5Fb3PErfZhnOC2Je2FZgkwSE=
X-Google-Smtp-Source: AHgI3IY+t26eCjT2jbKiCNvGK0X5eUmJC7gE9q4u6J+m9OgOVgcf5vlA+Sx9cjPNackJtloIJi1f2Q==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr4723056wmb.27.1549524472485;
        Wed, 06 Feb 2019 23:27:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q15sm7977280wmj.46.2019.02.06.23.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 23:27:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2019, #02; Wed, 6)
X-master-at: d62dad7a7dca3f6a65162bf0e52cdf6927958e78
X-next-at: b571404aecccbd67727636813e633bcd481c0f3d
Date:   Wed, 06 Feb 2019 23:27:51 -0800
Message-ID: <xmqqimxwqcqw.fsf@gitster-ct.c.googlers.com>
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

An early preview of upcoming release 2.21-rc0 has been tagged with
the sixth batch of topics.  Usually I try to keep topics in 'next'
for at least a week before merging them to 'master', in order to
keep 'master' from getting too unstable, but for this batch, many
topics spent only a day in 'next'.  Hopefully the last minute bugs
will have the same, if not better, likelihood to get discovered and
fixed, whether the topics are in 'next' or '-rc0'.  We'll see.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/diff-tree-doc-fix (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-05 at 123f48fa2e)
 + diff-tree doc: correct & remove wrong documentation

 Doc fix.


* bc/fetch-pack-clear-alternate-shallow (2019-02-06) 2 commits
  (merged to 'next' on 2019-02-06 at 2ebc2c9f87)
 + fetch-pack: clear alternate shallow in one more place
  (merged to 'next' on 2019-02-05 at 14392fb6b2)
 + fetch-pack: clear alternate shallow when complete

 "git fetch" over protocol v2 that needs to make a second connection
 to backfill tags did not clear a variable that holds shallow
 repository information correctly, leading to an access of freed
 piece of memory.


* br/commit-tree-fully-spelled-gpg-sign-option (2019-01-22) 2 commits
  (merged to 'next' on 2019-02-05 at a0a1e30471)
 + commit-tree: add missing --gpg-sign flag
 + t7510: invoke git as part of &&-chain

 The documentation of "git commit-tree" said that the command
 understands "--gpg-sign" in addition to "-S", but the command line
 parser did not know about the longhand, which has been corrected.


* ds/push-sparse-tree-walk (2019-01-17) 5 commits
  (merged to 'next' on 2019-02-05 at 9fd04c84d6)
 + pack-objects: create GIT_TEST_PACK_SPARSE
 + pack-objects: create pack.useSparse setting
 + revision: implement sparse algorithm
 + list-objects: consume sparse tree walk
 + revision: add mark_tree_uninteresting_sparse

 "git pack-objects" learned another algorithm to compute the set of
 objects to send, that trades the resulting packfile off to save
 traversal cost to favor small pushes.


* dt/cat-file-batch-ambiguous (2019-01-31) 2 commits
  (merged to 'next' on 2019-02-05 at 121d162945)
 + t1512: test ambiguous cat-file --batch and --batch-output
 + Do not print 'dangling' for cat-file in case of ambiguity

 "git cat-file --batch" reported a dangling symbolic link by
 mistake, when it wanted to report that a given name is ambiguous.


* en/rebase-merge-on-sequencer (2019-01-07) 8 commits
  (merged to 'next' on 2019-02-05 at 88823d7c86)
 + rebase: implement --merge via the interactive machinery
 + rebase: define linearization ordering and enforce it
 + git-legacy-rebase: simplify unnecessary triply-nested if
 + git-rebase, sequencer: extend --quiet option for the interactive machinery
 + am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
 + t5407: add a test demonstrating how interactive handles --skip differently
 + rebase: fix incompatible options error message
 + rebase: make builtin and legacy script error messages the same

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".


* jk/add-ignore-errors-bit-assignment-fix (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at 46cf370d8b)
 + add_to_index(): convert forgotten HASH_RENORMALIZE check

 A hotfix to an incomplete fix made earlier.


* jk/autocrlf-overrides-eol-doc (2019-01-29) 2 commits
  (merged to 'next' on 2019-02-05 at 2b372ed6e9)
 + docs/config: clarify "text property" in core.eol
 + doc/gitattributes: clarify "autocrlf overrides eol"

 Documentation around core.crlf has been updated.


* jk/loose-object-cache-oid (2019-01-08) 11 commits
  (merged to 'next' on 2019-02-05 at 5cbc954aa5)
 + prefer "hash mismatch" to "sha1 mismatch"
 + sha1-file: avoid "sha1 file" for generic use in messages
 + sha1-file: prefer "loose object file" to "sha1 file" in messages
 + sha1-file: drop has_sha1_file()
 + convert has_sha1_file() callers to has_object_file()
 + sha1-file: convert pass-through functions to object_id
 + sha1-file: modernize loose header/stream functions
 + sha1-file: modernize loose object file functions
 + http: use struct object_id instead of bare sha1
 + update comment references to sha1_object_info()
 + sha1-file: fix outdated sha1 comment references

 Code clean-up.


* jk/unused-parameter-cleanup (2019-01-24) 8 commits
  (merged to 'next' on 2019-02-05 at 213400362c)
 + convert: drop path parameter from actual conversion functions
 + convert: drop len parameter from conversion checks
 + config: drop unused parameter from maybe_remove_section()
 + show_date_relative(): drop unused "tz" parameter
 + column: drop unused "opts" parameter in item_length()
 + create_bundle(): drop unused "header" parameter
 + apply: drop unused "def" parameter from find_name_gnu()
 + match-trees: drop unused path parameter from score functions

 Code cleanup.


* js/rebase-am (2019-01-18) 4 commits
  (merged to 'next' on 2019-02-05 at cb92db8ecf)
 + built-in rebase: call `git am` directly
 + rebase: teach `reset_head()` to optionally skip the worktree
 + rebase: avoid double reflog entry when switching branches
 + rebase: move `reset_head()` into a better spot

 Instead of going through "git-rebase--am" scriptlet to use the "am"
 backend, the built-in version of "git rebase" learned to drive the
 "am" backend directly.


* js/vsts-ci (2019-02-06) 22 commits
  (merged to 'next' on 2019-02-06 at fe1a5e9d5c)
 + test-date: drop unused parameter to getnanos()
  (merged to 'next' on 2019-02-05 at 7297a734c7)
 + ci: parallelize testing on Windows
 + ci: speed up Windows phase
 + tests: optionally skip bin-wrappers/
 + t0061: workaround issues with --with-dashes and RUNTIME_PREFIX
 + tests: add t/helper/ to the PATH with --with-dashes
 + mingw: try to work around issues with the test cleanup
 + tests: include detailed trace logs with --write-junit-xml upon failure
 + tests: avoid calling Perl just to determine file sizes
 + README: add a build badge (status of the Azure Pipelines build)
 + mingw: be more generous when wrapping up the setitimer() emulation
 + ci: use git-sdk-64-minimal build artifact
 + ci: add a Windows job to the Azure Pipelines definition
 + Add a build definition for Azure DevOps
 + ci/lib.sh: add support for Azure Pipelines
 + tests: optionally write results as JUnit-style .xml
 + test-date: add a subcommand to measure times in shell scripts
 + ci: use a junction on Windows instead of a symlink
 + ci: inherit --jobs via MAKEFLAGS in run-build-and-tests
 + ci/lib.sh: encapsulate Travis-specific things
 + ci: rename the library of common functions
 + travis: fix skipping tagged releases

 Prepare to run test suite on Azure Pipeline.


* km/init-doc-typofix (2019-01-31) 1 commit
  (merged to 'next' on 2019-02-05 at ee90a62a1c)
 + init docs: correct a punctuation typo

 Docfix.


* lt/date-human (2019-01-29) 5 commits
  (merged to 'next' on 2019-02-05 at f2850c9fc0)
 + Add `human` date format tests.
 + Add `human` format to test-tool
 + Add 'human' date format documentation
 + Replace the proposed 'auto' mode with 'auto:'
 + Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 going to the pager or to the terminal and otherwise the default
 format.


* ma/doc-diff-usage-fix (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-05 at 18f3f4bc59)
 + doc-diff: don't `cd_to_toplevel`

 Running "Documentation/doc-diff x" from anywhere other than the
 top-level of the working tree did not show the usage string
 correctly, which has been fixed.


* nd/commit-doc (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-05 at 07b341767e)
 + git-commit.txt: better description what it does

 Doc update.


* nd/help-align-command-desc (2019-01-31) 1 commit
  (merged to 'next' on 2019-02-05 at 8339c1a46e)
 + help: align the longest command in the command listing

 Output from "git help" was not correctly aligned, which has been
 fixed.


* nd/the-index-final (2019-01-24) 11 commits
  (merged to 'next' on 2019-02-05 at 71b37c09a8)
 + cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
 + read-cache.c: remove the_* from index_has_changes()
 + merge-recursive.c: remove implicit dependency on the_repository
 + merge-recursive.c: remove implicit dependency on the_index
 + sha1-name.c: remove implicit dependency on the_index
 + read-cache.c: replace update_index_if_able with repo_&
 + read-cache.c: kill read_index()
 + checkout: avoid the_index when possible
 + repository.c: replace hold_locked_index() with repo_hold_locked_index()
 + notes-utils.c: remove the_repository references
 + grep: use grep_opt->repo instead of explict repo argument

 The assumption to work on the single "in-core index" instance has
 been reduced from the library-ish part of the codebase.


* pw/rebase-x-sanity-check (2019-01-29) 1 commit
  (merged to 'next' on 2019-02-05 at 9f087a617a)
 + rebase -x: sanity check command

 "git rebase -x $cmd" did not reject multi-line command, even though
 the command is incapable of handling such a command.  It now is
 rejected upfront.


* rj/sparse-flags (2019-02-05) 2 commits
  (merged to 'next' on 2019-02-05 at 7c9a7b7ee9)
 + Makefile: improve SPARSE_FLAGS customisation
 + config.mak.uname: remove obsolete SPARSE_FLAGS setting

 Use of the sparse tool got easier to customize from the command
 line to help developers.


* sb/submodule-abort-update-upon-config-failure (2019-01-18) 1 commit
  (merged to 'next' on 2019-02-05 at 85da48a9a5)
 + git-submodule: abort if core.worktree could not be set correctly

 "git submodule update" learned to abort early when core.worktree
 for the submodule is not set correctly to prevent spreading damage.


* sg/travis-osx-brew-breakage-workaround (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-05 at 6a1d957040)
 + travis-ci: make the OSX build jobs' 'brew update' more quiet

 The way the OSX build jobs updates its build environment used the
 "--quiet" option to "brew update" command, but it wasn't all that
 quiet to be useful.  The use of the option has been replaced with
 an explicit redirection to the /dev/null (which incidentally would
 have worked around a breakage by recent updates to homebrew, which
 has fixed itself already).


* sg/travis-specific-cc (2019-01-17) 4 commits
  (merged to 'next' on 2019-02-05 at 3ecb3b6755)
 + travis-ci: build with the right compiler
 + travis-ci: switch to Xcode 10.1 macOS image
 + travis-ci: don't be '--quiet' when running the tests
 + .gitignore: ignore external debug symbols from GCC on macOS

 The travis CI scripts have been corrected to build Git with the
 compiler(s) of our choice.


* sh/submodule-summary-abbrev-fix (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-05 at b45b39c30b)
 + git-submodule.sh: shorten submodule SHA-1s using rev-parse

 The "git submodule summary" subcommand showed shortened commit
 object names by mechanically truncating them at 7-hexdigit, which
 has been improved to let "rev-parse --short" scale the length of
 the abbreviation with the size of the repository.


* sl/const (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-05 at a085045a37)
 + various: tighten constness of some local variables

 Code cleanup.


* ss/describe-dirty-in-the-right-directory (2019-02-04) 2 commits
  (merged to 'next' on 2019-02-05 at e4a3303e12)
 + t6120: test for describe with a bare repository
 + describe: setup working tree for --dirty

 "git --work-tree=$there --git-dir=$here describe --dirty" did not
 work correctly as it did not pay attention to the location of the
 worktree specified by the user by mistake, which has been
 corrected.


* tb/test-lint-sed-options (2019-01-28) 1 commit
  (merged to 'next' on 2019-02-05 at dec383d823)
 + test-lint: only use only sed [-n] [-e command] [-f command_file]

 The test lint learned to catch non-portable "sed" options.


* tb/utf-16-le-with-explicit-bom (2019-01-31) 1 commit
  (merged to 'next' on 2019-02-05 at 43ac83e06e)
 + Support working-tree-encoding "UTF-16LE-BOM"

 A new encoding UTF-16LE-BOM has been invented to force encoding to
 UTF-16 with BOM in little endian byte order, which cannot be directly
 generated by using iconv.


* tt/bisect-in-c (2019-01-02) 7 commits
  (merged to 'next' on 2019-02-05 at 1e5e00d24e)
 + bisect--helper: `bisect_start` shell function partially in C
 + bisect--helper: `get_terms` & `bisect_terms` shell function in C
 + bisect--helper: `bisect_next_check` shell function in C
 + bisect--helper: `check_and_set_terms` shell function in C
 + wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 + bisect--helper: `bisect_write` shell function in C
 + bisect--helper: `bisect_reset` shell function in C

 More code in "git bisect" has been rewritten in C.

--------------------------------------------------
[New Topics]

* dl/complete-submodule-absorbgitdirs (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at c4e0cd535a)
 + completion: complete git submodule absorbgitdirs

 Command-line completion (in contrib/) learned to tab-complete the
 "git submodule absorbgitdirs" subcommand.

 Will cook in 'next'.


* ld/git-p4-remove-flakey-test (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at 0100bce8b6)
 + git-p4: remove ticket expiry test

 A flakey "p4" test has been removed.

 Will merge to 'master'.


* nd/checkout-noisy-unmerge (2019-02-06) 2 commits
  (merged to 'next' on 2019-02-06 at 7fe9bd5b4e)
 + checkout: count and print -m paths separately
 + checkout: update count-checkouts messages

 "git checkout [<tree-ish>] <pathspec>" started reporting the number
 of paths that have got updated recently, but the same messages were
 given when "git checkout -m <pathspec>" to unresolve conflicts that
 have just been resolved.  The message now reports these unresolved
 paths separately from the paths that are checked out from the index.

 Will merge to 'master'.


* jt/test-protocol-version (2019-02-06) 9 commits
 - remote-curl: in v2, fill credentials if needed
 - t5552: compensate for v2 filtering ref adv.
 - tests: fix protocol version for overspecifications
 - t5700: only run with protocol version 1
 - t5512: compensate for v0 only sending HEAD symrefs
 - t5503: fix overspecification of trace expectation
 - tests: always test fetch of unreachable with v0
 - tests: define GIT_TEST_PROTOCOL_VERSION
 - Merge branch 'js/protocol-advertise-multi' into jt/test-protocol-version
 (this branch uses js/protocol-advertise-multi.)

 Help developers by making it easier to run most of the tests under
 different versions of over-the-wire protocols.

--------------------------------------------------
[Cooking]

* dm/some-stdio-functions-are-macro-on-freebsd (2019-02-01) 1 commit
 - http: cast result to FILE *

 Variants of BSD define fileno(fh) as a macro, breaking a program
 that passes a "void *" to it.

 Expecting a reroll.
 cf. <49B9198C-53E5-42BD-8834-B1EDEB3332CB@usask.ca>


* en/combined-all-paths (2019-02-04) 1 commit
 - log,diff-tree: add --combined-all-names option

 Output from "diff --cc" did not show the original paths when the
 merge involved renames.  A new option adds the paths in the
 original trees to the output.

 Expecting a reroll.
 cf. <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>


* js/rebase-i-redo-exec-fix (2019-02-06) 1 commit
  (merged to 'next' on 2019-02-06 at 9f99bee768)
 + Revert "rebase: introduce a shortcut for --reschedule-failed-exec"

 For "rebase -i --reschedule-failed-exec", we do not want the "-y"
 shortcut after all.

 Will merge to 'master'.


* ds/commit-graph-format-v2 (2019-01-29) 8 commits
 - SQUASH : misnamed variables and style fix
 - commit-graph: test verifying a corrupt v2 header
 - commit-graph: implement file format version 2
 - commit-graph: add --version=<n> option
 - commit-graph: create new version flags
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write
 - Merge branch 'bc/sha-256' into ds/commit-graph-format-v2

 Introduce version 2 of the commit-graph format to correct
 deficiency in the initial version.


* ds/coverage-prove (2019-01-29) 1 commit
  (merged to 'next' on 2019-02-06 at 0fc57228ec)
 + Makefile: add coverage-prove target

 A new target "coverage-prove" to run the coverage test under
 "prove" has been added.

 Will merge to 'master'.


* jh/trace2 (2019-02-06) 15 commits
 - trace2: add for_each macros to clang-format
 - trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
 - trace2:data: add subverb for rebase
 - trace2:data: add subverb to reset command
 - trace2:data: add subverb to checkout command
 - trace2:data: pack-objects: add trace2 regions
 - trace2:data: add trace2 instrumentation to index read/write
 - trace2:data: add trace2 hook classification
 - trace2:data: add trace2 transport child classification
 - trace2:data: add trace2 sub-process classification
 - trace2:data: add editor/pager child classification
 - trace2:data: add trace2 regions to wt-status
 - trace2: collect Windows-specific process information
 - trace2: create new combined trace facility
 - trace2: Documentation/technical/api-trace2.txt

 A more structured way to obtain execution trace has been added.

 Will merge to 'next'.


* sx/evolve (2019-01-27) 8 commits
 . evolve: add the 'git change list' command
 . evolve: implement the 'git change' command
 . evolve: add support for writing metacommits
 . evolve: add the change-table structure
 . evolve: add support for parsing metacommits
 . ref-filter: add the metas namespace to ref-filter
 . sha1-array: implement oid_array_readonly_contains()
 . technical doc: add a design doc for the evolve command

 The beginning of "hg evolve" mimicry.


* br/blame-ignore (2019-01-18) 3 commits
 - blame: add a config option to mark ignored lines
 - blame: add the ability to ignore commits and their changes
 - Move init_skiplist() outside of fsck

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Is this ready for 'next'?


* nd/diff-parseopt (2019-01-27) 14 commits
  (merged to 'next' on 2019-02-05 at 7c4b79aa79)
 + diff.c: convert --raw
 + diff.c: convert -W|--[no-]function-context
 + diff.c: convert -U|--unified
 + diff.c: convert -u|-p|--patch
 + diff.c: prepare to use parse_options() for parsing
 + diff.h: avoid bit fields in struct diff_flags
 + diff.h: keep forward struct declarations sorted
 + parse-options: allow ll_callback with OPTION_CALLBACK
 + parse-options: avoid magic return codes
 + parse-options: stop abusing 'callback' for lowlevel callbacks
 + parse-options: add OPT_BITOP()
 + parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
 + parse-options: add one-shot mode
 + parse-options.h: remove extern on function prototypes

 The diff machinery, one of the oldest parts of the system, which
 long predates the parse-options API, uses fairly long and complex
 handcrafted option parser.  This is being rewritten to use the
 parse-options API.

 Will cook in 'next', waiting for the remainder.
 Looking good.


* sc/pack-redundant (2019-02-04) 6 commits
 - pack-redundant: consistent sort method
 - pack-redundant: rename pack_list.all_objects
 - pack-redundant: new algorithm to find min packs
 - pack-redundant: delete redundant code
 - pack-redundant: delay creation of unique_objects
 - t5323: test cases for git-pack-redundant

 Update the implementation of pack-redundant for performance in a
 repository with many packfiles.

 Will merge to 'next'.


* nd/config-move-to (2019-01-14) 7 commits
 - config.h: fix hdr-check warnings
 - config: add --move-to
 - config: factor out set_config_source_file()
 - config: use OPT_FILENAME()
 - config.c: add repo_config_set_worktree_gently()
 - worktree.c: add get_worktree_config()
 - config.c: avoid git_path() in do_git_config_sequence()

 Needs review.


* ma/clear-repository-format (2019-01-23) 2 commits
 - setup: fix memory leaks with `struct repository_format`
 - setup: free old value before setting `work_tree`

 The setup code has been cleaned up to avoid leaks around the
 repository_format structure.

 cf. <20190124001450.GR423984@genre.crustytoothpaste.net>


* wh/author-committer-ident-config (2019-02-04) 1 commit
  (merged to 'next' on 2019-02-06 at 6ab8bfa199)
 + config: allow giving separate author and committer idents

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Will cook in 'next'.


* ds/midx-expire-repack (2019-01-27) 10 commits
 - midx: add test that 'expire' respects .keep files
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index expire/repack" are new subcommands that
 consult midx file and are used to drop unused pack files and
 coalesce small pack files that are still in use.

 Comments?


* tg/checkout-no-overlay (2019-02-04) 9 commits
  (merged to 'next' on 2019-02-04 at 9968bcf4fb)
 + revert "checkout: introduce checkout.overlayMode config"
  (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
 + checkout: introduce checkout.overlayMode config
 + checkout: introduce --{,no-}overlay option
 + checkout: factor out mark_cache_entry_for_checkout function
 + checkout: clarify comment
 + read-cache: add invalidate parameter to remove_marked_cache_entries
 + entry: support CE_WT_REMOVE flag in checkout_entry
 + entry: factor out unlink_entry function
 + move worktree tests to t24*

 "git checkout --no-overlay" can be used to trigger a new mode of
 checking out paths out of the tree-ish, that allows paths that
 match the pathspec that are in the current index and working tree
 and are not in the tree-ish.

 Will hold.
 Waiting for "restore-files" & "switch-branches" pair.
 cf. <20190205204208.GC6085@hank.intra.tgummerer.com>


* dl/merge-cleanup-scissors-fix (2019-01-27) 4 commits
  (merged to 'next' on 2019-02-06 at f4fe5d759a)
 + merge: add scissors line on merge conflict
 + merge: cleanup messages like commit
 + t7600: clean up 'merge --squash c3 with c7' test
 + commit: extract cleanup_mode functions to sequencer

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Will cook in 'next'.


* aw/pretty-trailers (2019-01-29) 7 commits
  (merged to 'next' on 2019-02-06 at b7e5437702)
 + pretty: add support for separator option in %(trailers)
 + strbuf: separate callback for strbuf_expand:ing literals
 + pretty: add support for "valueonly" option in %(trailers)
 + pretty: allow showing specific trailers
 + pretty: single return path in %(trailers) handling
 + pretty: allow %(trailers) options with explicit value
 + doc: group pretty-format.txt placeholders descriptions

 The %(trailers) formatter in "git log --format=..."  now allows to
 optionally pick trailers selectively by keyword, show only values,
 etc.

 Will cook in 'next'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 I am personally not yet quite convinced if this is worth pursuing.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions
 (this branch is used by jt/test-protocol-version.)

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.


* js/smart-http-detect-remote-error (2019-02-06) 3 commits
  (merged to 'next' on 2019-02-06 at ec1a6f67c1)
 + t5551: test server-side ERR packet
 + remote-curl: tighten "version 2" check for smart-http
 + remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.

 Will merge to 'master'.


* nb/branch-show-other-worktrees-head (2019-02-01) 3 commits
 - branch: add an extra verbose output displaying worktree path for refs checked out in a linked worktree
 - branch: mark and color a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 The top one probably deserves retitling.
 The second one is of dubious value.


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 Will merge to 'next'.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* ag/sequencer-reduce-rewriting-todo (2019-01-29) 16 commits
 - rebase--interactive: move transform_todo_file() to rebase--interactive.c
 - sequencer: use edit_todo_list() in complete_action()
 - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 - rebase-interactive: append_todo_help() changes
 - rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 - sequencer: change complete_action() to use the refactored functions
 - sequencer: make sequencer_make_script() write its script to a strbuf
 - sequencer: refactor rearrange_squash() to work on a todo_list
 - sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 - sequencer: refactor check_todo_list() to work on a todo_list
 - sequencer: introduce todo_list_write_to_file()
 - sequencer: refactor transform_todos() to work on a todo_list
 - sequencer: remove the 'arg' field from todo_item
 - sequencer: make the todo_list structure public
 - sequencer: changes in parse_insn_buffer()

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 Still being worked on.
 cf. <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2019-02-04) 29 commits
 - strbuf_vinsertf: provide the correct buffer size to vsnprintf
 - stash: fix segmentation fault when files were added with intent
 - tests: add a special setup where stash.useBuiltin is off
 - stash: optionally use the scripted version again
 - stash: add back the original, scripted `git stash`
 - stash: convert `stash--helper.c` into `stash.c`
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert save to builtin
 - stash: make push -q quiet
 - stash: convert push to builtin
 - stash: convert create to builtin
 - stash: convert store to builtin
 - stash: convert show to builtin
 - stash: convert list to builtin
 - stash: convert pop to builtin
 - stash: convert branch to builtin
 - stash: convert drop and clear to builtin
 - stash: convert apply to builtin
 - stash: mention options in `show` synopsis
 - stash: add tests for `git stash show` config
 - stash: rename test cases to be more descriptive
 - t3903: modernize style
 - stash: improve option parsing test coverage
 - ident: add the ability to provide a "fallback identity"
 - strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
 - strbuf.c: add `strbuf_join_argv()`
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
 - Merge branch 'sd/stash-wo-user-name'

 "git stash" rewritten in C.

 Will merge to 'next'.


* pw/add-p-select (2018-07-26) 4 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select modified lines correctly
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Will discard.
 No further feedbacks on the topic for quite some time.

 cf. <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
 I found the feature to be hard to explain, and may result in more
 end-user complaints, but let's see.
