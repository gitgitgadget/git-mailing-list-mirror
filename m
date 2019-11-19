Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35C81F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 07:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKSHGE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 02:06:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56630 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSHF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 02:05:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 126BA196FD;
        Tue, 19 Nov 2019 02:05:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=F
        cx1pJt4xI6RSKwh245kcct+iDQ=; b=GVFkU2d2Z7q0tFFOEI+cgs+c6wQmY28+r
        /FALdmbPqRZWSrMYw6Z343GBOWlBG0qd8V48oDFZTiMnDkAy8WlEUAsqGeWOXlQX
        MmOdxsI4RTzFLPSP5gkxCHk92eE2ERMFaCs/pdA7E0sUlqLdZ6g5Co1mdoLF1gNJ
        PHoUJ8gWTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=qH1
        g5s+ENB8qhvyz7GG++RG4BFgJAxEFXIvilbwwS9ftye8MxQ1doN4ppJ1OmjifLvc
        QMkmsDtKsQeIIcdxlKebGUQ/cubL6JiFTjsEBpXEp4jr/M4rbyrEeacqvCv/Q/T6
        YxROy0J17Xer6zOFEsaAerHbv7oBFRF2aGttsQ98=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08FEE196FC;
        Tue, 19 Nov 2019 02:05:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A359196FA;
        Tue, 19 Nov 2019 02:05:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2019, #03; Tue, 19)
X-master-at: d9f6f3b6195a0ca35642561e530798ad1469bd41
X-next-at: 69ef04c0130f4b0b2f74006aac01f51233c7f246
Date:   Tue, 19 Nov 2019 16:05:48 +0900
Message-ID: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04195DA8-0A9B-11EA-9629-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A bunch of topics, mostly the ones that were in 'next' before the
latest release, have been merged to 'master'.  Also, quite a lot of
topics now have started cooking in 'next'.  It will hopefully become
a short and productive cycle ;-)

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/hash-independent-tests-part-6 (2019-10-28) 15 commits
  (merged to 'next' on 2019-10-30 at 70037a3839)
 + t4048: abstract away SHA-1-specific constants
 + t4045: make hash-size independent
 + t4044: update test to work with SHA-256
 + t4039: abstract away SHA-1-specific constants
 + t4038: abstract away SHA-1 specific constants
 + t4034: abstract away SHA-1-specific constants
 + t4027: make hash-size independent
 + t4015: abstract away SHA-1-specific constants
 + t4011: abstract away SHA-1-specific constants
 + t4010: abstract away SHA-1-specific constants
 + t3429: remove SHA1 annotation
 + t1305: avoid comparing extensions
 + rev-parse: add a --show-object-format option
 + t/oid-info: add empty tree and empty blob values
 + t/oid-info: allow looking up hash algorithm name

 Test updates to prepare for SHA-2 transition continues.


* dd/notes-copy-default-dst-to-head (2019-10-18) 2 commits
  (merged to 'next' on 2019-10-18 at 2588a175ec)
 + notes: fix minimum number of parameters to "copy" subcommand
 + t3301: test diagnose messages for too few/many paramters

 "git notes copy $original" ought to copy the notes attached to the
 original object to HEAD, but a mistaken tightening to command line
 parameter validation made earlier disabled that feature by mistake.


* dl/apply-3way-diff3 (2019-10-24) 5 commits
  (merged to 'next' on 2019-10-24 at 84e27d28b6)
 + apply: respect merge.conflictStyle in --3way
 + t4108: demonstrate bug in apply
 + t4108: use `test_config` instead of `git config`
 + t4108: remove git command upstream of pipe
 + t4108: replace create_file with test_write_lines

 "git apply --3way" learned to honor merge.conflictStyle
 configuration variable, like merges would.


* dl/format-patch-cover-from-desc (2019-10-16) 3 commits
  (merged to 'next' on 2019-10-18 at 40e992b6f5)
 + format-patch: teach --cover-from-description option
 + format-patch: use enum variables
 + format-patch: replace erroneous and condition

 The branch description ("git branch --edit-description") has been
 used to fill the body of the cover letters by the format-patch
 command; this has been enhanced so that the subject can also be
 filled.


* en/merge-recursive-directory-rename-fixes (2019-10-23) 3 commits
  (merged to 'next' on 2019-10-24 at 82e64029a8)
 + t604[236]: do not run setup in separate tests
 + merge-recursive: fix merging a subdirectory into the root directory
 + merge-recursive: clean up get_renamed_dir_portion()

 When all files from some subdirectory were renamed to the root
 directory, the directory rename heuristics would fail to detect that
 as a rename/merge of the subdirectory to the root directory, which has
 been corrected.


* es/walken-tutorial (2019-10-12) 1 commit
  (merged to 'next' on 2019-10-18 at 59160e59e9)
 + documentation: add tutorial for object walking

 A tutorial on object enumeration.


* hv/bitshift-constants-in-blame (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-24 at bc84aae4d4)
 + builtin/blame.c: constants into bit shift format

 Move the definition of a set of bitmask constants from 0ctal
 literal to (1U<<count) notation.


* hw/remove-api-docs-placeholder (2019-10-25) 1 commit
  (merged to 'next' on 2019-10-30 at c99fe16682)
 + documentation: remove empty doc files

 Docfix.


* jc/am-show-current-patch-docfix (2019-10-23) 1 commit
  (merged to 'next' on 2019-10-24 at 31fa6081f2)
 + doc: am --show-current-patch gives an entire e-mail message

 Doc update.


* js/rebase-deprecate-preserve-merges (2019-10-21) 1 commit
  (merged to 'next' on 2019-10-24 at 82fa49bbf2)
 + rebase: hide --preserve-merges option

 "git rebase --preserve-merges" has been marked as deprecated; this
 release stops advertising it in the "git rebase -h" output.


* js/update-index-ignore-removal-for-skip-worktree (2019-11-02) 2 commits
  (merged to 'next' on 2019-11-02 at 57f7fb885f)
 + stash: handle staged changes in skip-worktree files correctly
 + update-index: optionally leave skip-worktree entries alone

 "git stash save" in a working tree that is sparsely checked out
 mistakenly removed paths that are outside the area of interest.


* jt/fetch-pack-record-refs-in-the-dot-promisor (2019-10-16) 1 commit
  (merged to 'next' on 2019-10-18 at 4ead52e59a)
 + fetch-pack: write fetched refs to .promisor

 Debugging support for lazy cloning has been a bit improved.


* pb/pretty-email-without-domain-part (2019-10-30) 3 commits
  (merged to 'next' on 2019-10-30 at 06f719efa5)
 + pretty: add "%aL" etc. to show local-part of email addresses
 + t4203: use test-lib.sh definitions
 + t6006: use test-lib.sh definitions

 The custom format for "git log --format=<format>" learned the l/L
 placeholder that is similar to e/E that fills in the e-mail
 address, but only the local part on the left side of '@'.


* pw/post-commit-from-sequencer (2019-10-16) 6 commits
  (merged to 'next' on 2019-10-18 at 15b41a097d)
 + sequencer: run post-commit hook
 + move run_commit_hook() to libgit and use it there
 + sequencer.h fix placement of #endif
 + t3404: remove uneeded calls to set_fake_editor
 + t3404: set $EDITOR in subshell
 + t3404: remove unnecessary subshell

 "rebase -i" ceased to run post-commit hook by mistake in an earlier
 update, which has been corrected.


* sg/commit-graph-usage-fix (2019-10-28) 1 commit
  (merged to 'next' on 2019-10-28 at 13d01506dd)
 + builtin/commit-graph.c: remove subcommand-less usage string

 Message fix.


* sg/dir-trie-fixes (2019-10-23) 5 commits
  (merged to 'next' on 2019-10-24 at 06d60a7fb0)
 + path.c: don't call the match function without value in trie_find()
 + path.c: clarify two field names in 'struct common_dir'
 + path.c: mark 'logs/HEAD' in 'common_list' as file
 + path.c: clarify trie_find()'s in-code comment
 + Documentation: mention more worktree-specific exceptions

 Code clean-up and a bugfix in the logic used to tell worktree local
 and repository global refs apart.


* wb/midx-progress (2019-10-23) 6 commits
  (merged to 'next' on 2019-10-24 at 95c3e3ab3a)
 + multi-pack-index: add [--[no-]progress] option.
 + midx: honor the MIDX_PROGRESS flag in midx_repack
 + midx: honor the MIDX_PROGRESS flag in verify_midx_file
 + midx: add progress to expire_midx_packs
 + midx: add progress to write_midx_file
 + midx: add MIDX_PROGRESS flag

 The code to generate multi-pack index learned to show (or not to
 show) progress indicators.

--------------------------------------------------
[New Topics]

* rs/skip-iprefix (2019-11-10) 2 commits
  (merged to 'next' on 2019-11-19 at c87ae31b14)
 + convert: use skip_iprefix() in validate_encoding()
 + utf8: use skip_iprefix() in same_utf_encoding()

 Code simplification.

 Will merge to 'master'.


* dj/typofix-merge-strat (2019-11-11) 1 commit
  (merged to 'next' on 2019-11-19 at 5b6c0cf125)
 + merge-strategies: fix typo "reflected to" to "reflected in"

 Typofix.

 Will merge to 'master'.


* jh/userdiff-python-async (2019-11-11) 1 commit
 - userdiff: support Python async functions

 The userdiff machinery has been taught that "async def" is another
 way to begin a "function" in Python.

 Waiting for a response to review.
 cf. <f8a729c6-7b27-cac8-815e-b5c02a5c7b44@kdbg.org>


* rj/bundle-ui-updates (2019-11-11) 3 commits
  (merged to 'next' on 2019-11-19 at d88f626256)
 + bundle-verify: add --quiet
 + bundle-create: progress output control
 + bundle: framework for options before bundle file

 "git bundle" has been taught to use the parse options API.  "git
 bundle verify" learned "--quiet" and "git bundle create" learned
 options to control the progress output.

 Will merge to 'master'.


* ar/install-doc-update-cmds-needing-the-shell (2019-11-15) 1 commit
  (merged to 'next' on 2019-11-19 at 216468eb98)
 + INSTALL: use existing shell scripts as example

 Doc update.

 Will merge to 'master'.


* dl/complete-rebase-onto (2019-11-12) 1 commit
  (merged to 'next' on 2019-11-19 at ba53946a3b)
 + completion: learn to complete `git rebase --onto=`

 The completion script (in contrib/) learned that the "--onto"
 option of "git rebase" can take its argument as the value of the
 option.

 Will merge to 'master'.


* dl/pretty-reference (2019-11-19) 11 commits
 - squash! pretty: implement 'reference' format
 - SubmittingPatches: use `--pretty=reference`
 - pretty: implement 'reference' format
 - pretty: provide short date format
 - t4205: cover `git log --reflog -z` blindspot
 - pretty.c: inline initalize format_context
 - revision: make get_revision_mark() return const pointer
 - completion: complete `tformat:` pretty format
 - SubmittingPatches: remove dq from commit reference
 - pretty-formats.txt: use generic terms for hash
 - SubmittingPatches: use generic terms for hash

 "git log" family learned "--pretty=ref" that gives the name of a
 commit in the format that is often used to refer to it in log
 messages.

 Expecting finishing touches to the data handling.
 Other than that, this is reasonably well done, I think.


* ds/test-read-graph (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at 80152fc082)
 + test-tool: use 'read-graph' helper

 Dev support for commit-graph feature.

 Will merge to 'master'.


* hw/doc-in-header (2019-11-18) 20 commits
 - trace2: move doc to trace2.h
 - submodule-config: move doc to submodule-config.h
 - tree-walk: move doc to tree-walk.h
 - trace: move doc to trace.h
 - run-command: move doc to run-command.h
 - parse-options: add link to doc file in parse-options.h
 - credential: move doc to credential.h
 - argv-array: move doc to argv-array.h
 - cache: move doc to cache.h
 - sigchain: move doc to sigchain.h
 - pathspec: move doc to pathspec.h
 - revision: move doc to revision.h
 - attr: move doc to attr.h
 - refs: move doc to refs.h
 - remote: move doc to remote.h and refspec.h
 - sha1-array: move doc to sha1-array.h
 - merge: move doc to ll-merge.h
 - graph: move doc to graph.h and graph.c
 - dir: move doc to dir.h
 - diff: move doc to diff.h and diffcore.h


* jc/fsmonitor-sanity-fix (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at 1fceb9b55b)
 + fsmonitor: do not compare bitmap size with size of split index

 Remove an incorrect BUG() that should not trigger.

 Will merge to 'master'.


* jk/gitweb-anti-xss (2019-11-18) 4 commits
  (merged to 'next' on 2019-11-19 at 69ef04c013)
 + gitweb: escape URLs generated by href()
 + t/gitweb-lib.sh: set $REQUEST_URI
 + t/gitweb-lib.sh: drop confusing quotes
 + t9502: pass along all arguments in xss helper

 Some codepaths in "gitweb" that forgot to escape URLs generated
 based on end-user input have been corrected.

 Will merge to 'master'.


* jk/optim-in-pack-idx-conversion (2019-11-12) 1 commit
  (merged to 'next' on 2019-11-19 at a81ebc7b8d)
 + pack-objects: avoid pointless oe_map_new_pack() calls

 Code clean-up.

 Will merge to 'master'.


* jk/remove-sha1-to-hex (2019-11-13) 2 commits
  (merged to 'next' on 2019-11-19 at fb68824870)
 + hex: drop sha1_to_hex()
 + hex: drop sha1_to_hex_r()

 Code clean-up.

 Will merge to 'master'.


* jk/send-pack-remote-failure (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at d02c0107ee)
 + send-pack: check remote ref status on pack-objects failure

 Error handling after "git push" finishes sending the packdata and
 waits for the response to the remote side has been improved.

 Will merge to 'master'.


* js/builtin-add-i-cmds (2019-11-18) 8 commits
 - built-in add -i: offer the `quit` command
 - built-in add -i: re-implement the `diff` command
 - built-in add -i: implement the `patch` command
 - built-in add -i: re-implement `add-untracked` in C
 - built-in add -i: re-implement `revert` in C
 - built-in add -i: implement the `update` command
 - built-in add -i: prepare for multi-selection commands
 - built-in add -i: allow filtering the modified files list
 (this branch uses js/builtin-add-i.)

 "git add -i" that is getting rewritten in C has been extended to
 cover subcommands other than the "patch".


* js/complete-svn-recursive (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at fa2a97911c)
 + completion: tab-complete "git svn --recursive"

 The completion script (in contrib/) has been taught that "git svn"
 supports the "--recursive" option.

 Will merge to 'master'.


* js/rebase-r-safer-label (2019-11-18) 2 commits
 - rebase -r: let `label` generate safer labels
 - rebase-merges: move labels' whitespace mangling into `label_oid()`
 (this branch is used by dd/rebase-merge-reserves-onto-label.)

 A label used in the todo list that are generated by "git rebase
 --rebase-merges" is used as a part of a refname; the logic to come
 up with the label has been tightened to avoid names that cannot be
 used as such.

 Will merge to 'next'.


* dd/rebase-merge-reserves-onto-label (2019-11-19) 1 commit
 - sequencer: handle rebase-merge for "onto" message
 (this branch uses js/rebase-r-safer-label.)

 The logic to avoid duplicate label names generated by "git rebase
 --rebase-merges" forgot that the machinery itself uses "onto" as a
 label name, which must be avoided by auto-generated labels, which
 has been corrected.

 Will merge to 'next'.


* ma/config-bool-valex (2019-11-14) 8 commits
 - builtin/config: die if "value_regex" doesn't canonicalize as boolean
 - builtin/config: warn if "value_regex" doesn't canonicalize as boolean
 - builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
 - builtin/config: canonicalize "value_regex" with `--type=bool`
 - builtin/config: collect "value_regexp" data in a struct
 - builtin/config: extract `handle_value_regex()` from `get_value()`
 - t1300: modernize part of script
 - config: make `git_parse_maybe_bool_text()` public


* ma/t7004 (2019-11-14) 1 commit
  (merged to 'next' on 2019-11-19 at 789a0a0f05)
 + t7004: check existence of correct tag

 Test fix.

 Will merge to 'master'.


* nn/doc-rebase-merges (2019-11-12) 1 commit
  (merged to 'next' on 2019-11-19 at db74ff488c)
 + doc: improve readability of --rebase-merges in git-rebase

 Doc update.

 Will merge to 'master'.


* rs/parse-options-dup-null-fix (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at 73040e1605)
 + parse-options: avoid arithmetic on pointer that's potentially NULL

 Code cleanup.

 Will merge to 'master'.


* rs/use-copy-array-in-mingw-shell-command-preparation (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at 52ee6a8887)
 + mingw: use COPY_ARRAY for copying array

 Code cleanup.

 Will merge to 'master'.


* sg/name-rev-wo-recursion (2019-11-13) 13 commits
 - name-rev: cleanup name_ref()
 - name-rev: eliminate recursion in name_rev()
 - name-rev: drop name_rev()'s 'generation' and 'distance' parameters
 - name-rev: restructure creating/updating 'struct rev_name' instances
 - name-rev: restructure parsing commits and applying date cutoff
 - name-rev: pull out deref handling from the recursion
 - name-rev: extract creating/updating a 'struct name_rev' into a helper
 - t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
 - name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
 - name-rev: avoid unnecessary cast in name_ref()
 - name-rev: use strbuf_strip_suffix() in get_rev_name()
 - t6120-describe: modernize the 'check_describe' helper
 - t6120-describe: correct test repo history graph in comment


* sg/skip-skipped-prereq (2019-11-13) 1 commit
  (merged to 'next' on 2019-11-19 at 10d344fed7)
 + test-lib: don't check prereqs of test cases that won't be run anyway

 Test update to avoid wasted cycles.

 Will merge to 'master'.


* tg/stash-refresh-index (2019-11-14) 1 commit
  (merged to 'next' on 2019-11-19 at 4d67af8d3f)
 + stash: make sure we have a valid index before writing it

 Recent update to "git stash pop" made the command empty the index
 when run with the "--quiet" option, which has been corrected.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* js/advise-rebase-skip (2019-10-23) 3 commits
 - commit: give correct advice for empty commit during a rebase
 - sequencer: export the function to get the path of `.git/rebase-merge/`
 - cherry-pick: add test for `--skip` advice in `git commit`

 The logic used in "git commit" to give hints and errors depending
 on what operation was in progress learned to distinguish rebase and
 cherry-pick better.

 Kicked back to 'pu'.
 cf. <nycvar.QRO.7.76.6.1911081508560.46@tvgsbejvaqbjf.bet>


* vn/reset-deleted-ita (2019-07-26) 1 commit
 - reset: unstage empty deleted ita files

 "git reset HEAD [<pathspec>]" did not reset an empty file that was
 added with the intent-to-add bit.

 Expecting a reroll.


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

* am/pathspec-from-file (2019-11-07) 6 commits
 - commit: support the --pathspec-from-file option
 - doc: commit: unify <pathspec> description
 - reset: support the `--pathspec-from-file` option
 - doc: reset: unify <pathspec> description
 - pathspec: add new function to parse file
 - parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`

 A few commands learned to take the pathspec from the
 standard input or a named file, instead of taking it as the command
 line arguments.

 Expecting a response to review.
 This smells more or less done.


* cb/curl-use-xmalloc (2019-11-07) 1 commit
  (merged to 'next' on 2019-11-19 at 1c587d0775)
 + remote-curl: unbreak http.extraHeader with custom allocators

 HTTP transport had possible allocator/deallocator mismatch, which
 has been corrected.

 Will merge to 'master'.


* ds/commit-graph-delay-gen-progress (2019-11-07) 1 commit
  (merged to 'next' on 2019-11-19 at afa7c921be)
 + commit-graph: use start_delayed_progress()

 One kind of progress messages were always given during commit-graph
 generation, instead of following the "if it takes more than two
 seconds, show progress" pattern, which has been corrected.

 Will merge to 'master'.


* ec/fetch-mark-common-refs-trace2 (2019-11-07) 1 commit
 - fetch: add trace2 instrumentation

 Trace2 annotation.

 Expecting a response to review.


* en/misc-doc-fixes (2019-11-07) 3 commits
  (merged to 'next' on 2019-11-19 at 7222cf3720)
 + name-hash.c: remove duplicate word in comment
 + hashmap: fix documentation misuses of -> versus .
 + git-filter-branch.txt: correct argument name typo

 Misc doc fixes.

 Will merge to 'master'.


* en/t6024-style (2019-11-07) 1 commit
  (merged to 'next' on 2019-11-19 at b41c2ed21b)
 + t6024: modernize style

 Test updates.

 Will merge to 'master'.


* ep/guard-kset-tar-headers (2019-11-07) 1 commit
 - kset.h, tar.h: add missing header guard to prevent multiple inclusion

 Code clean-up.

 Will merge to 'next'.


* js/fetch-multi-lockfix (2019-11-06) 2 commits
  (merged to 'next' on 2019-11-19 at b9683b7ec9)
 + fetch: avoid locking issues between fetch.jobs/fetch.writeCommitGraph
 + fetch: add the command-line option `--write-commit-graph`

 Fetching from multiple remotes into the same repository in parallel
 had a bad interaction with the recent change to (optionally) update
 the commit-graph after a fetch job finishes, as these parallel
 fetches compete with each other.  Which has been corrected.

 Will merge to 'master'.


* jt/fetch-remove-lazy-fetch-plugging (2019-11-13) 3 commits
  (merged to 'next' on 2019-11-19 at 1b26c28dcd)
 + promisor-remote: remove fetch_if_missing=0
 + clone: remove fetch_if_missing=0
 + fetch: remove fetch_if_missing=0

 "git fetch" codepath had a big "do not lazily fetch missing objects
 when I ask if something exists" switch.  This has been corrected by
 marking the "does this thing exist?" calls with "if not please do not
 lazily fetch it" flag.

 Will merge to 'master'.


* kw/fsmonitor-watchman-fix (2019-11-06) 1 commit
  (merged to 'next' on 2019-11-19 at ee786a5c39)
 + fsmonitor: fix watchman integration

 The watchman integration for fsmonitor was racy, which has been
 corrected to be more conservative.

 Will merge to 'master'.


* ln/userdiff-elixir (2019-11-10) 1 commit
  (merged to 'next' on 2019-11-19 at 6318918ba8)
 + userdiff: add Elixir to supported userdiff languages

 The patterns to detect function boundary for Elixir language has
 been added.

 Will merge to 'master'.


* ns/test-desc-typofix (2019-11-07) 1 commit
  (merged to 'next' on 2019-11-19 at 804861f385)
 + t: fix typo in test descriptions

 Typofix.

 Will merge to 'master'.


* py/shortlog-list-options-for-log (2019-11-10) 1 commit
  (merged to 'next' on 2019-11-19 at 92a10e39f7)
 + git-shortlog.txt: include commit limiting options

 Documentation pages for "git shortlog" now lists commit limiting
 options explicitly.

 Will merge to 'master'.


* rs/trace2-dots (2019-11-06) 1 commit
  (merged to 'next' on 2019-11-19 at a045233ad0)
 + trace2: add dots directly to strbuf in perf_fmt_prepare()

 Code cleanup.

 Will merge to 'master'.


* dd/sequencer-utf8 (2019-11-11) 8 commits
  (merged to 'next' on 2019-11-19 at 9432ddc32c)
 + sequencer: reencode commit message for am/rebase --show-current-patch
 + sequencer: reencode old merge-commit message
 + sequencer: reencode squashing commit's message
 + sequencer: reencode revert/cherry-pick's todo list
 + sequencer: reencode to utf-8 before arrange rebase's todo list
 + t3900: demonstrate git-rebase problem with multi encoding
 + configure.ac: define ICONV_OMITS_BOM if necessary
 + t0028: eliminate non-standard usage of printf

 Handling of commit objects that use non UTF-8 encoding during
 "rebase -i" has been improved.

 Will merge to 'master'.


* dl/t5520-cleanup (2019-11-19) 14 commits
 - t5520: replace `! git` with `test_must_fail git`
 - t5520: remove redundant lines in test cases
 - t5520: replace $(cat ...) comparison with test_cmp
 - t5520: don't put git in upstream of pipe
 - t5520: test single-line files by git with test_cmp
 - t5520: use test_cmp_rev where possible
 - t5520: replace test -{n,z} with test-lib functions
 - t5520: use test_line_count where possible
 - t5520: remove spaces after redirect operator
 - t5520: replace test -f with test-lib functions
 - t5520: let sed open its own input
 - t5520: use sq for test case names
 - t5520: improve test style
 - t: teach test_cmp_rev to accept ! for not-equals

 Test cleanup.

 Will merge to 'next'.


* js/builtin-add-i (2019-11-18) 9 commits
 - built-in add -i: implement the `help` command
 - built-in add -i: use color in the main loop
 - built-in add -i: support `?` (prompt help)
 - built-in add -i: show unique prefixes of the commands
 - built-in add -i: implement the main loop
 - built-in add -i: color the header in the `status` command
 - built-in add -i: implement the `status` command
 - diff: export diffstat interface
 - Start to implement a built-in version of `git add --interactive`
 (this branch is used by js/builtin-add-i-cmds.)

 The beginning of rewriting "git add -i" in C.

 Will merge to 'next'.


* es/myfirstcontrib-updates (2019-11-02) 3 commits
  (merged to 'next' on 2019-11-19 at 41d70e1db4)
 + myfirstcontrib: hint to find gitgitgadget allower
 + myfirstcontrib: add dependency installation step
 + myfirstcontrib: add 'psuh' to command-list.txt

 Doc updates.

 Will merge to 'master'.


* rt/fetch-message-fix (2019-11-02) 1 commit
  (merged to 'next' on 2019-11-19 at 69eb337cd8)
 + fetch.c: fix typo in a warning message

 A small message update.

 Will merge to 'master'.


* ra/rebase-i-more-options (2019-11-02) 6 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_rename
 - rebase -i: support --committer-date-is-author-date
 - sequencer: allow callers of read_author_script() to ignore fields
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learned a few options that are known by "git
 rebase" proper.


* en/doc-typofix (2019-11-10) 10 commits
  (merged to 'next' on 2019-11-19 at e7bfe50de5)
 + Fix spelling errors in no-longer-updated-from-upstream modules
 + multimail: fix a few simple spelling errors
 + sha1dc: fix trivial comment spelling error
 + Fix spelling errors in test commands
 + Fix spelling errors in messages shown to users
 + Fix spelling errors in names of tests
 + Fix spelling errors in comments of testcases
 + Fix spelling errors in code comments
 + Fix spelling errors in documentation outside of Documentation/
 + Documentation: fix a bunch of typos, both old and new

 Docfix.

 Will merge to 'master'.


* dl/doc-diff-no-index-implies-exit-code (2019-11-02) 1 commit
  (merged to 'next' on 2019-11-19 at e2b2181e28)
 + git-diff.txt: document return code of `--no-index`

 Doc update.

 Will merge to 'master'.


* dl/submodule-set-url (2019-10-30) 1 commit
 - submodule: teach set-url subcommand

 "git submodule" learned a subcommand "set-url".


* js/vreportf-wo-buffering (2019-11-02) 1 commit
  (merged to 'next' on 2019-11-19 at cae61b9899)
 + vreportf(): avoid relying on stdio buffering

 Messages from die() etc. can be mixed up from multiple processes
 without even line buffering on Windows, which has been worked
 around.

 Will merge to 'master'.


* ma/bisect-doc-sample-update (2019-10-29) 1 commit
  (merged to 'next' on 2019-11-19 at bde6adce1b)
 + Documentation/git-bisect.txt: add --no-ff to merge command

 "git merge --no-commit" needs "--no-ff" if you do not want to move
 HEAD, which has been corrected in the manual page for "git bisect".

 Will merge to 'master'.


* mr/clone-dir-exists-to-path-exists (2019-10-29) 1 commit
  (merged to 'next' on 2019-11-19 at 07b6ab25de)
 + clone: rename static function `dir_exists()`.

 Code cleanup.

 Will merge to 'master'.


* pb/help-list-gitsubmodules-among-guides (2019-10-29) 1 commit
  (merged to 'next' on 2019-11-19 at 3c6f5c1901)
 + help: add gitsubmodules to the list of guides

 Help update.

 Will merge to 'master'.


* pb/no-recursive-reset-hard-in-worktree-add (2019-10-30) 1 commit
  (merged to 'next' on 2019-11-19 at cdfb0643e9)
 + worktree: teach "add" to ignore submodule.recurse config

 "git worktree add" internally calls "reset --hard" that should not
 descend into submodules, even when submodule.recurse configuration
 is set, but it was affected.  This has been correct.

 Will merge to 'master'.


* sg/blame-indent-heuristics-is-now-the-default (2019-10-29) 1 commit
  (merged to 'next' on 2019-11-19 at 68e60f08cc)
 + builtin/blame.c: remove '--indent-heuristic' from usage string

 Message update.

 Will merge to 'master'.


* jk/cleanup-object-parsing-and-fsck (2019-10-28) 23 commits
  (merged to 'next' on 2019-11-10 at 50b2267a2a)
 + fsck: accept an oid instead of a "struct tree" for fsck_tree()
 + fsck: accept an oid instead of a "struct commit" for fsck_commit()
 + fsck: accept an oid instead of a "struct tag" for fsck_tag()
 + fsck: rename vague "oid" local variables
 + fsck: don't require an object struct in verify_headers()
 + fsck: don't require an object struct for fsck_ident()
 + fsck: drop blob struct from fsck_finish()
 + fsck: accept an oid instead of a "struct blob" for fsck_blob()
 + fsck: don't require an object struct for report()
 + fsck: only require an oid for skiplist functions
 + fsck: only provide oid/type in fsck_error callback
 + fsck: don't require object structs for display functions
 + fsck: use oids rather than objects for object_name API
 + fsck_describe_object(): build on our get_object_name() primitive
 + fsck: unify object-name code
 + fsck: require an actual buffer for non-blobs
 + fsck: stop checking tag->tagged
 + fsck: stop checking commit->parent counts
 + fsck: stop checking commit->tree value
 + commit, tag: don't set parsed bit for parse failures
 + parse_tag_buffer(): treat NULL tag pointer as parse error
 + parse_commit_buffer(): treat lookup_tree() failure as parse error
 + parse_commit_buffer(): treat lookup_commit() failure as parse error

 Originally merged to 'next' on 2019-10-30

 Crufty code and logic accumulated over time around the object
 parsing and low-level object access used in "git fsck" have been
 cleaned up.

 Will merge to 'master'.


* po/bundle-doc-clonable (2019-10-21) 1 commit
 - Doc: Bundle file usage

 Doc update.

 Expecting a reroll.


* hw/config-doc-in-header (2019-10-24) 1 commit
  (merged to 'next' on 2019-11-19 at 7f314c649e)
 + config: move documentation to config.h

 Follow recent push to move API docs from Documentation/ to header
 files and update config.h

 Will merge to 'master'.


* jc/log-graph-simplify (2019-11-13) 14 commits
  (merged to 'next' on 2019-11-19 at de6360c648)
 + t4215: use helper function to check output
  (merged to 'next' on 2019-11-10 at 79d2b8ff98)
 + graph: fix coloring of octopus dashes
 + graph: flatten edges that fuse with their right neighbor
 + graph: smooth appearance of collapsing edges on commit lines
 + graph: rename `new_mapping` to `old_mapping`
 + graph: commit and post-merge lines for left-skewed merges
 + graph: tidy up display of left-skewed merges
 + graph: example of graph output that can be simplified
 + graph: extract logic for moving to GRAPH_PRE_COMMIT state
 + graph: remove `mapping_idx` and `graph_update_width()`
 + graph: reduce duplication in `graph_insert_into_new_columns()`
 + graph: reuse `find_new_column_by_commit()`
 + graph: handle line padding in `graph_next_line()`
 + graph: automatically track display width of graph lines

 The implementation of "git log --graph" got refactored and then its
 output got simplified.

 Will merge to 'master'.


* js/git-path-head-dot-lock-fix (2019-10-29) 2 commits
  (merged to 'next' on 2019-11-19 at b406944979)
 + git_path(): handle `.lock` files correctly
 + t1400: wrap setup code in test case

 "git rev-parse --git-path HEAD.lock" did not give the right path
 when run in a secondary worktree.

 Will merge to 'master'.


* ds/sparse-cone (2019-10-23) 17 commits
  (merged to 'next' on 2019-11-19 at 1eb4b3a012)
 + sparse-checkout: cone mode should not interact with .gitignore
 + sparse-checkout: write using lockfile
 + sparse-checkout: update working directory in-process
 + sparse-checkout: sanitize for nested folders
 + read-tree: show progress by default
 + unpack-trees: add progress to clear_ce_flags()
 + unpack-trees: hash less in cone mode
 + sparse-checkout: init and set in cone mode
 + sparse-checkout: use hashmaps for cone patterns
 + sparse-checkout: add 'cone' mode
 + trace2: add region in clear_ce_flags
 + sparse-checkout: create 'disable' subcommand
 + sparse-checkout: add '--stdin' option to set subcommand
 + sparse-checkout: 'set' subcommand
 + clone: add --sparse mode
 + sparse-checkout: create 'init' subcommand
 + sparse-checkout: create builtin with 'list' subcommand

 Management of sparsely checked-out working tree has gained a
 dedicated "sparse-checkout" command.

 Will merge to 'master'.


* ag/sequencer-todo-updates (2019-10-28) 6 commits
 - SQUASH??? tentative leakfix
 - sequencer: directly call pick_commits() from complete_action()
 - rebase: fill `squash_onto' in get_replay_opts()
 - sequencer: move the code writing total_nr on the disk to a new function
 - sequencer: update `done_nr' when skipping commands in a todo list
 - sequencer: update `total_nr' when adding an item to a todo list

 Reduce unnecessary reading of state variables back from the disk
 during sequener operation.

 Is the leakfix patch at the tip the only thing that needs to
 prepare the topic ready for 'next'?


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

 Expecting a reroll.
 cf. <CAHd-oW7UPSSExyLtfLMCObWogKrBOctYabrFrOdf9-4Q2PZmMg@mail.gmail.com>


* jk/packfile-reuse-cleanup (2019-10-23) 9 commits
  (merged to 'next' on 2019-11-19 at 9683853939)
 + pack-objects: improve partial packfile reuse
 + builtin/pack-objects: introduce obj_is_packed()
 + pack-objects: introduce pack.allowPackReuse
 + csum-file: introduce hashfile_total()
 + pack-bitmap: introduce bitmap_walk_contains()
 + pack-bitmap: don't rely on bitmap_git->reuse_objects
 + ewah/bitmap: introduce bitmap_word_alloc()
 + packfile: expose get_delta_base()
 + builtin/pack-objects: report reused packfile objects

 The way "git pack-objects" reuses objects stored in existing pack
 to generate its result has been improved.

 Will merge to 'master'.
