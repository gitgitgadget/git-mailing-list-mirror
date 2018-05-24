Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2AB31F42D
	for <e@80x24.org>; Thu, 24 May 2018 00:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935153AbeEXACq (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 20:02:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53117 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEXACn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 20:02:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id w194-v6so257702wmf.2
        for <git@vger.kernel.org>; Wed, 23 May 2018 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=9kw/kXWWuT6LHCKIbjZum2RsOxBZUecFCJ79Wc3f6aA=;
        b=N1Qy23cFpt0R2Vo01F72aRNB8e02u+bfFHNP1/kSDzj+Q+p3C/Eu2XkheAkaWbCH+2
         5sj9gTeczTzpBHnxhQm4FfkuasjIVCoKmQCPYLI1Nm72q0a6istpCu13v23ZHQEcg4gl
         +VKuDn1YmL6COLcsrdr077y4TdSbRZuFx8PE4t6cAXroJegk3B0zFmV1/Lh1Hgj+COLz
         Fa/NTaojb8BdPSlQ/9mNmBNPzWdyKv6O1dKf3rTwIZbtNGYrLV8q1HpTzLfy5WndjgTu
         hXAJgLQKCRKshXUE+/qvxND3CAgFfqpfMozG/IQ6eyq/aVEdc1CEjeu9atCmvmJKVNUC
         Vz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=9kw/kXWWuT6LHCKIbjZum2RsOxBZUecFCJ79Wc3f6aA=;
        b=RGiLp2c/bKsvOsXaBtrxP4Gv3PspFJTiutuH15fSTN6uOzhukidKkeqfNLYknbz3No
         MYGvxdNfS2fhFB8Ts8Tub+Nf4Do3j+KDzXJRMoijDBPQ7wwyFfbbNIgnohKZDI8iqQJ7
         rsyeSWR5sLCTaZ0NiA6nmK8Oy5L5NpRkL1mYb+F74dK+pPNx9LDlOseh7EAxZQPQYpdC
         6V58rl4m8EpWZWZ3ZQUbilxlDZDIWyxvC5UyuyDCfaoGoAOhRZlQxmKBaIO+27gyk4Ek
         1aqCpzle8GCHDdKPzwBWZA8K+WLwEd6yU7OFsu5hw1rU/V0/Zb/YOZ61hXHL/0yjILCy
         V3+Q==
X-Gm-Message-State: ALKqPwdsoawM7aciamv1zyTnvdHuB3SwaLUfgEM0ycWomUP/jO2/y2TS
        eO98skdb4qqvScGYzh/wG/I4VJvA0mT0sw==
X-Google-Smtp-Source: AB8JxZo3xFXIhnT0NcvYCx1+ktdob5dvI6CcjeXDKA46YwawS907/P5dE116CsO55YXUjIhmOfL6SQ==
X-Received: by 2002:a1c:5f83:: with SMTP id t125-v6mr5684352wmb.124.1527120159866;
        Wed, 23 May 2018 17:02:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s7-v6sm8821603wrp.4.2018.05.23.17.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 17:02:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2018, #03; Wed, 23)
X-master-at: e144d126d74f5d2702870ca9423743102eec6fcd
X-next-at: 671052e690087fed435bbc7ce67a6a0cc77818e0
Date:   Thu, 24 May 2018 09:02:37 +0900
Message-ID: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
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
[Graduated to "master"]

* ab/perl-python-attrs (2018-04-27) 3 commits
  (merged to 'next' on 2018-05-08 at b440e9bbb9)
 + .gitattributes: add a diff driver for Python
 + .gitattributes: use the "perl" differ for Perl
 + .gitattributes: add *.pl extension for Perl

 We learned that our source files with ".pl" and ".py" extensions
 are Perl and Python files respectively and changes to them are
 better viewed as such with appropriate diff drivers.


* ah/misc-doc-updates (2018-05-06) 7 commits
  (merged to 'next' on 2018-05-16 at e2e3b68a66)
 + doc: normalize [--options] to [options] in git-diff
 + doc: add note about shell quoting to revision.txt
 + git-svn: remove ''--add-author-from' for 'commit-diff'
 + doc: add '-d' and '-o' for 'git push'
 + doc: clarify ignore rules for git ls-files
 + doc: align 'diff --no-index' in text and synopsis
 + doc: improve formatting in githooks.txt

 Misc doc fixes.


* ao/config-api-doc (2018-05-11) 1 commit
  (merged to 'next' on 2018-05-22 at a17d6dda92)
 + doc: fix config API documentation about config_with_options

 Doc update.


* bc/asciidoctor-tab-width (2018-05-07) 2 commits
  (merged to 'next' on 2018-05-16 at be2a42c473)
 + Documentation: render revisions correctly under Asciidoctor
 + Documentation: use 8-space tabs with Asciidoctor

 Asciidoctor gives a reasonable imitation for AsciiDoc, but does not
 render illustration in a literal block correctly when indented with
 HT by default. The problem is fixed by forcing 8-space tabs.


* bc/format-patch-cover-no-attach (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at fa1ffeb3fe)
 + format-patch: make cover letters always text/plain

 "git format-patch --cover --attach" created a broken MIME multipart
 message for the cover letter, which has been fixed by keeping the
 cover letter as plain text file.


* bc/mailmap-self (2018-05-08) 1 commit
  (merged to 'next' on 2018-05-16 at a009c64bd2)
 + mailmap: update brian m. carlson's email address


* bp/test-drop-caches (2018-05-04) 1 commit
  (merged to 'next' on 2018-05-16 at 0e40ab2408)
 + test-drop-caches: simplify delay loading of NtSetSystemInformation

 Code simplification.


* bw/server-options (2018-04-24) 4 commits
  (merged to 'next' on 2018-05-08 at a18ce56f3c)
 + fetch: send server options when using protocol v2
 + ls-remote: send server options when using protocol v2
 + serve: introduce the server-option capability
 + Merge branch 'bw/protocol-v2' into HEAD

 The transport protocol v2 is getting updated further.


* cc/perf-aggregate-unknown-option (2018-04-26) 1 commit
  (merged to 'next' on 2018-05-08 at db7d2870f8)
 + perf/aggregate: use Getopt::Long for option parsing

 Perf-test helper updates.


* cc/perf-bisect (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at 5a078a2fdf)
 + perf/bisect_run_script: disable codespeed

 Performance test updates.


* ds/lazy-load-trees (2018-05-02) 6 commits
  (merged to 'next' on 2018-05-02 at d54016d9e3)
 + coccinelle: avoid wrong transformation suggestions from commit.cocci
  (merged to 'next' on 2018-04-25 at b90813f421)
 + commit-graph: lazy-load trees for commits
 + treewide: replace maybe_tree with accessor methods
 + commit: create get_commit_tree() method
 + treewide: rename tree to maybe_tree
 + Merge branch 'bw/c-plus-plus' into ds/lazy-load-trees
 (this branch is used by ds/commit-graph-lockfile-fix and ds/generation-numbers.)

 The code has been taught to use the duplicated information stored
 in the commit-graph file to learn the tree object name for a commit
 to avoid opening and parsing the commit object when it makes sense
 to do so.


* em/status-rename-config (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at 33c1cc093c)
 + wt-status: use settings from git_diff_ui_config
 (this branch is used by bp/status-rename-config.)

 "git status" learned to pay attention to UI related diff
 configuration variables such as diff.renames.


* en/git-debugger (2018-04-25) 1 commit
  (merged to 'next' on 2018-05-08 at 73369cd1e5)
 + Make running git under other debugger-like programs easy

 Dev support.


* en/rename-directory-detection-reboot (2018-05-08) 36 commits
  (merged to 'next' on 2018-05-08 at be350ebc17)
 + merge-recursive: fix check for skipability of working tree updates
 + merge-recursive: make "Auto-merging" comment show for other merges
 + merge-recursive: fix remainder of was_dirty() to use original index
 + merge-recursive: fix was_tracked() to quit lying with some renamed paths
 + t6046: testcases checking whether updates can be skipped in a merge
 + merge-recursive: avoid triggering add_cacheinfo error with dirty mod
 + merge-recursive: move more is_dirty handling to merge_content
 + merge-recursive: improve add_cacheinfo error handling
 + merge-recursive: avoid spurious rename/rename conflict from dir renames
 + directory rename detection: new testcases showcasing a pair of bugs
 + merge-recursive: fix remaining directory rename + dirty overwrite cases
 + merge-recursive: fix overwriting dirty files involved in renames
 + merge-recursive: avoid clobbering untracked files with directory renames
 + merge-recursive: apply necessary modifications for directory renames
 + merge-recursive: when comparing files, don't include trees
 + merge-recursive: check for file level conflicts then get new name
 + merge-recursive: add computation of collisions due to dir rename & merging
 + merge-recursive: check for directory level conflicts
 + merge-recursive: add get_directory_renames()
 + merge-recursive: make a helper function for cleanup for handle_renames
 + merge-recursive: split out code for determining diff_filepairs
 + merge-recursive: make !o->detect_rename codepath more obvious
 + merge-recursive: fix leaks of allocated renames and diff_filepairs
 + merge-recursive: introduce new functions to handle rename logic
 + merge-recursive: move the get_renames() function
 + directory rename detection: tests for handling overwriting dirty files
 + directory rename detection: tests for handling overwriting untracked files
 + directory rename detection: miscellaneous testcases to complete coverage
 + directory rename detection: testcases exploring possibly suboptimal merges
 + directory rename detection: more involved edge/corner testcases
 + directory rename detection: testcases checking which side did the rename
 + directory rename detection: files/directories in the way of some renames
 + directory rename detection: partially renamed directory testcase/discussion
 + directory rename detection: testcases to avoid taking detection too far
 + directory rename detection: directory splitting testcases
 + directory rename detection: basic testcases
 (this branch is used by bp/merge-rename-config and ma/unpack-trees-free-msgs.)

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.  Incidentally, this also avoids updating a file in the
 working tree after a (non-trivial) merge whose result matches what
 our side originally had.


* en/unpack-trees-split-index-fix (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at 1adff065b2)
 + unpack_trees: fix breakage when o->src_index != o->dst_index

 The split-index feature had a long-standing and dormant bug in
 certain use of the in-core merge machinery, which has been fixed.
 cf. <CACsJy8CeDhrT9GXe9q5gqsAeq_sSQ8jyF2nMOFxzjwKtE31oPQ@mail.gmail.com>


* fg/completion-external (2018-05-07) 1 commit
  (merged to 'next' on 2018-05-16 at 5d83f92caf)
 + completion: load completion file for external subcommand

 The command line completion mechanism (in contrib/) learned to load
 custom completion file for "git $command" where $command is a
 custom "git-$command" that the end user has on the $PATH when using
 newer version of bash.
 cf. <CAM0VKjkTu+OkLM3gvX73mWugxArCVmqRBmWGHiKuLiLRNkkNow@mail.gmail.com>


* hn/sort-ls-remote (2018-05-14) 1 commit
  (merged to 'next' on 2018-05-16 at 64336850f2)
 + t5512: run git fetch inside test

 Hotfix.


* jk/apply-p-doc (2018-05-11) 1 commit
  (merged to 'next' on 2018-05-22 at 48f280346b)
 + apply: clarify "-p" documentation

 Doc update.


* js/deprecate-grafts (2018-04-30) 12 commits
  (merged to 'next' on 2018-05-08 at 1d7b31d179)
 + Remove obsolete script to convert grafts to replace refs
 + technical/shallow: describe why shallow cannot use replace refs
 + technical/shallow: stop referring to grafts
 + filter-branch: stop suggesting to use grafts
 + Deprecate support for .git/info/grafts
 + Add a test for `git replace --convert-graft-file`
 + replace: introduce --convert-graft-file
 + replace: prepare create_graft() for converting graft files wholesale
 + replace: "libify" create_graft() and callees
 + replace: avoid using die() to indicate a bug
 + commit: Let the callback of for_each_mergetag return on error
 + argv_array: offer to split a string by whitespace

 The functionality of "$GIT_DIR/info/grafts" has been superseded by
 the "refs/replace/" mechanism for some time now, but the internal
 code had support for it in many places, which has been cleaned up
 in order to drop support of the "grafts" mechanism.


* js/no-pager-shorthand (2018-05-04) 1 commit
  (merged to 'next' on 2018-05-08 at 10e6031dd1)
 + git: add -P as a short option for --no-pager

 "git --no-pager cmd" did not have short-and-sweet single letter
 option. Now it does.


* js/rebase-i-clean-msg-after-fixup-continue (2018-05-02) 4 commits
  (merged to 'next' on 2018-05-08 at 7e684c153d)
 + rebase --skip: clean up commit message after a failed fixup/squash
 + sequencer: always commit without editing when asked for
 + rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
 + rebase -i: demonstrate bugs with fixup!/squash! commit messages

 "git rebase -i" sometimes left intermediate "# This is a
 combination of N commits" message meant for the human consumption
 inside an editor in the final result in certain corner cases, which
 has been fixed.


* js/rebase-recreate-merge (2018-04-26) 17 commits
  (merged to 'next' on 2018-05-16 at f1aeea2879)
 + rebase -i --rebase-merges: add a section to the man page
 + rebase -i: introduce --rebase-merges=[no-]rebase-cousins
 + pull: accept --rebase=merges to recreate the branch topology
 + rebase --rebase-merges: avoid "empty merges"
 + sequencer: handle post-rewrite for merge commands
 + sequencer: make refs generated by the `label` command worktree-local
 + rebase --rebase-merges: add test for --keep-empty
 + rebase: introduce the --rebase-merges option
 + rebase-helper --make-script: introduce a flag to rebase merges
 + sequencer: fast-forward `merge` commands, if possible
 + sequencer: introduce the `merge` command
 + sequencer: introduce new commands to reset the revision
 + git-rebase--interactive: clarify arguments
 + sequencer: offer helpful advice when a command was rescheduled
 + sequencer: refactor how original todo list lines are accessed
 + sequencer: make rearrange_squash() a bit more obvious
 + sequencer: avoid using errno clobbered by rollback_lock_file()
 (this branch is used by js/sequencer-and-root-commits.)

 "git rebase" learned "--rebase-merges" to transplant the whole
 topology of commit graph elsewhere.


* js/test-unset-prereq (2018-04-30) 1 commit
  (merged to 'next' on 2018-05-08 at 3aecbf25a3)
 + tests: introduce test_unset_prereq, for debugging

 Test debugging aid.
 cf. <20180507115950.3887-1-szeder.dev@gmail.com>


* nd/completion-aliasfiletype-typofix (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at 045e4ac190)
 + completion: fix misspelled config key aliasesfiletype

 Typofix.


* nd/doc-header (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at 0599eb3ec9)
 + doc: keep first level section header in upper case

 Doc formatting fix.


* nd/pack-format-doc (2018-05-13) 1 commit
  (merged to 'next' on 2018-05-22 at ff2c48f356)
 + pack-format.txt: more details on pack file format

 Doc update.


* nd/pack-objects-pack-struct (2018-04-16) 15 commits
  (merged to 'next' on 2018-05-16 at 171459475d)
 + ci: exercise the whole test suite with uncommon code in pack-objects
 + pack-objects: reorder members to shrink struct object_entry
 + pack-objects: shrink delta_size field in struct object_entry
 + pack-objects: shrink size field in struct object_entry
 + pack-objects: clarify the use of object_entry::size
 + pack-objects: don't check size when the object is bad
 + pack-objects: shrink z_delta_size field in struct object_entry
 + pack-objects: refer to delta objects by index instead of pointer
 + pack-objects: move in_pack out of struct object_entry
 + pack-objects: move in_pack_pos out of struct object_entry
 + pack-objects: use bitfield for object_entry::depth
 + pack-objects: use bitfield for object_entry::dfs_state
 + pack-objects: turn type and in_pack_type to bitfields
 + pack-objects: a bit of document about struct object_entry
 + read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean

 "git pack-objects" needs to allocate tons of "struct object_entry"
 while doing its work, and shrinking its size helps the performance
 quite a bit.
 cf. <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>


* nd/pack-unreachable-objects-doc (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-16 at c4bf977564)
 + pack-objects: validation and documentation about unreachable options

 Doc update.


* nd/repack-keep-pack (2018-04-16) 7 commits
  (merged to 'next' on 2018-05-08 at ab906be358)
 + pack-objects: show some progress when counting kept objects
 + gc --auto: exclude base pack if not enough mem to "repack -ad"
 + gc: handle a corner case in gc.bigPackThreshold
 + gc: add gc.bigPackThreshold config
 + gc: add --keep-largest-pack option
 + repack: add --keep-pack option
 + t7700: have closing quote of a test at the beginning of line

 "git gc" in a large repository takes a lot of time as it considers
 to repack all objects into one pack by default.  The command has
 been taught to pretend as if the largest existing packfile is
 marked with ".keep" so that it is left untouched while objects in
 other packs and loose ones are repacked.
 cf. <CACsJy8CuVRy4UPEwXJJYAjePEz5zjKMLhRjh9UFw0DPYTzobkw@mail.gmail.com>


* nd/term-columns (2018-05-13) 2 commits
  (merged to 'next' on 2018-05-22 at e50b727a48)
 + column: fix off-by-one default width
 + pager: set COLUMNS to term_columns()

 The code did not propagate the terminal width to subprocesses via
 COLUMNS environment variable, which it now does.  This caused
 trouble to "git column" helper subprocess when "git tag --column=row"
 tried to list the existing tags on a display with non-default width.


* sb/object-store-replace (2018-05-21) 4 commits
  (merged to 'next' on 2018-05-21 at 4fb28f7b16)
 + get_main_ref_store: BUG() when outside a repository
  (merged to 'next' on 2018-05-18 at c95db04db9)
 + object.c: clear replace map before freeing it
  (merged to 'next' on 2018-05-16 at 41bbedcc81)
 + replace-object.c: remove the_repository from prepare_replace_object
 + object.c: free replace map in raw_object_store_clear

 Hotfix.


* sb/oid-object-info (2018-04-26) 9 commits
  (merged to 'next' on 2018-05-08 at f3c08f298e)
 + cache.h: allow oid_object_info to handle arbitrary repositories
 + packfile: add repository argument to cache_or_unpack_entry
 + packfile: add repository argument to unpack_entry
 + packfile: add repository argument to read_object
 + packfile: add repository argument to packed_object_info
 + packfile: add repository argument to packed_to_object_type
 + packfile: add repository argument to retry_bad_packed_offset
 + cache.h: add repository argument to oid_object_info
 + cache.h: add repository argument to oid_object_info_extended
 (this branch is used by sb/object-store-alloc and sb/object-store-grafts.)

 The codepath around object-info API has been taught to take the
 repository object (which in turn tells the API which object store
 the objects are to be located).


* sg/t5310-jgit-bitmap-test (2018-05-11) 1 commit
  (merged to 'next' on 2018-05-22 at ef0d86084d)
 + t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX

 Test update.


* sg/t5516-fixes (2018-05-11) 2 commits
  (merged to 'next' on 2018-05-22 at 254fa59e3a)
 + t5516-fetch-push: fix broken &&-chain
 + t5516-fetch-push: fix 'push with dry-run' test

 Test fixes.


* sg/t7005-spaces-in-filenames-cleanup (2018-05-15) 1 commit
  (merged to 'next' on 2018-05-22 at 0bc626c61a)
 + t7005-editor: get rid of the SPACES_IN_FILENAMES prereq

 Test update.


* tb/test-apfs-utf8-normalization (2018-05-02) 1 commit
  (merged to 'next' on 2018-05-16 at feabe72b42)
 + test: correct detection of UTF8_NFD_TO_NFC for APFS

 A test to see if the filesystem normalizes UTF-8 filename has been
 updated to check what we need to know in a more direct way, i.e. a
 path created in NFC form can be accessed with NFD form (or vice
 versa) to cope with APFS as well as HFS.


* tg/worktree-add-existing-branch (2018-04-30) 4 commits
  (merged to 'next' on 2018-05-08 at 8b76505192)
 + worktree: teach "add" to check out existing branches
 + worktree: factor out dwim_branch function
 + worktree: improve message when creating a new worktree
 + worktree: remove extra members from struct add_opts

 "git worktree add" learned to check out an existing branch.

--------------------------------------------------
[New Topics]

* bw/ref-prefix-for-configured-refspec (2018-05-18) 2 commits
 - fetch: generate ref-prefixes when using a configured refspec
 - refspec: consolidate ref-prefix generation logic
 (this branch uses bw/refspec-api.)

 "git fetch $there $refspec" that talks over protocol v2 can take
 advantage of server-side ref filtering; the code has been extended
 so that this mechanism triggers also when fetching with configured
 refspec.

 Will merge to 'next'.


* jk/config-blob-sans-repo (2018-05-21) 1 commit
 - config: die when --blob is used outside a repository

 Error codepath fix.

 Will merge to 'next'.


* jk/snprintf-truncation (2018-05-21) 5 commits
 - fmt_with_err: add a comment that truncation is OK
 - shorten_unambiguous_ref: use xsnprintf
 - fsmonitor: use internal argv_array of struct child_process
 - log_write_email_headers: use strbufs
 - http: use strbufs instead of fixed buffers

 Avoid unchecked snprintf() to make future code auditing easier.

 Will merge to 'next'.


* js/empty-config-section-fix (2018-05-18) 1 commit
 - config: a user-provided invalid section is not a BUG

 Error codepath fix.

 Will merge to 'next'.


* ma/config-store-data-clear (2018-05-21) 3 commits
 - config: let `config_store_data_clear()` handle `key`
 - config: let `config_store_data_clear()` handle `value_regex`
 - config: free resources of `struct config_store_data`

 Leak plugging.

 Will merge to 'next'.


* ma/regex-no-regfree-after-comp-fail (2018-05-21) 1 commit
 - regex: do not call `regfree()` if compilation fails

 We used to call regfree() after regcomp() failed in some codepaths,
 which have been corrected.

 Will merge to 'next'.


* ma/unpack-trees-free-msgs (2018-05-22) 4 commits
 - unpack_trees_options: free messages when done
 - argv-array: return the pushed string from argv_push*()
 - merge-recursive: provide pair of `unpack_trees_{start,finish}()`
 - merge: setup `opts` later in `checkout_fast_forward()`
 (this branch uses bp/merge-rename-config.)

 Leak plugging.

 Will merge to 'next'.


* rm/p4-submit-with-commit-option (2018-05-21) 1 commit
 - git-p4: add options --commit and --disable-rebase

 Needs sign-off.


* bw/remote-curl-compressed-responses (2018-05-23) 2 commits
 - remote-curl: accept compressed responses with protocol v2
 - remote-curl: accept all encodings supported by curl

 Our HTTP client code used to advertise that we accept gzip encoding
 from the other side; instead, just let cURL library to advertise
 and negotiate the best one.

 Will merge to 'next'.


* cc/tests-without-assuming-ref-files-backend (2018-05-23) 1 commit
 - t: make many tests depend less on the refs being files

 Quite a many tests assumed that newly created refs are made as
 loose refs using the files backend, which have been updated to use
 proper plumbing like rev-parse and update-ref, to avoid breakage
 once we start using different ref backends.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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
 Oh, another thing, there is "lifecyle" typo in the title.


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


* is/parsing-line-range (2018-04-27) 2 commits
 . log: prevent error if line range ends past end of file
 . blame: prevent error if range ends past end of file

 Parsing of -L[<N>][,[<M>]] parameters "git blame" and "git log"
 take has been tweaked.

 Seems to break a few tests.


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

* sg/t6500-no-redirect-of-stdin (2018-05-09) 1 commit
  (merged to 'next' on 2018-05-22 at 7019b3a1d5)
 + t6050-replace: don't disable stdin for the whole test script

 Test cleanup.

 Will merge to 'master'.


* bc/hash-independent-tests (2018-05-21) 28 commits
 - t5300: abstract away SHA-1-specific constants
 - t4208: abstract away SHA-1-specific constants
 - t4045: abstract away SHA-1-specific constants
 - t4042: abstract away SHA-1-specific constants
 - t4205: sort log output in a hash-independent way
 - t/lib-diff-alternative: abstract away SHA-1-specific constants
 - t4030: abstract away SHA-1-specific constants
 - t4029: abstract away SHA-1-specific constants
 - t4029: fix test indentation
 - t4022: abstract away SHA-1-specific constants
 - t4020: abstract away SHA-1-specific constants
 - t4014: abstract away SHA-1-specific constants
 - t4008: abstract away SHA-1-specific constants
 - t4007: abstract away SHA-1-specific constants
 - t3905: abstract away SHA-1-specific constants
 - t3702: abstract away SHA-1-specific constants
 - t3103: abstract away SHA-1-specific constants
 - t2203: abstract away SHA-1-specific constants
 - t: skip pack tests if not using SHA-1
 - t4044: skip test if not using SHA-1
 - t1512: skip test if not using SHA-1
 - t1007: annotate with SHA1 prerequisite
 - t0000: annotate with SHA1 prerequisite
 - t: switch $_x40 to $OID_REGEX
 - t/test-lib: introduce OID_REGEX
 - t: switch $_z40 to $ZERO_OID
 - t/test-lib: introduce ZERO_OID
 - t/test-lib: add an SHA1 prerequisite

 Many tests hardcode the raw object names, which would change once
 we migrate away from SHA-1.  While some of them must test against
 exact object names, most of them do not have to use hardcoded
 constants in the test.  The latter kind of tests have been updated
 to test the moral equivalent of the original without hardcoding the
 actual object names.

 Will merge to 'next'.


* bp/status-rename-config (2018-05-13) 1 commit
  (merged to 'next' on 2018-05-22 at ffcb0a7aa7)
 + add status config and command line options for rename detection

 "git status" learned to honor a new status.renames configuration to
 skip rename detection, which could be useful for those who want to
 do so without disabling the default rename detection done by the
 "git diff" command.

 Will merge to 'master'.


* bw/refspec-api (2018-05-18) 36 commits
 - submodule: convert push_unpushed_submodules to take a struct refspec
 - remote: convert check_push_refs to take a struct refspec
 - remote: convert match_push_refs to take a struct refspec
 - http-push: store refspecs in a struct refspec
 - transport: remove transport_verify_remote_names
 - send-pack: store refspecs in a struct refspec
 - transport: convert transport_push to take a struct refspec
 - push: convert to use struct refspec
 - push: check for errors earlier
 - remote: convert match_explicit_refs to take a struct refspec
 - remote: convert get_ref_match to take a struct refspec
 - remote: convert query_refspecs to take a struct refspec
 - remote: convert apply_refspecs to take a struct refspec
 - remote: convert get_stale_heads to take a struct refspec
 - fetch: convert prune_refs to take a struct refspec
 - fetch: convert get_ref_map to take a struct refspec
 - fetch: convert do_fetch to take a struct refspec
 - refspec: remove the deprecated functions
 - fetch: convert refmap to use struct refspec
 - fetch: convert fetch_one to use struct refspec
 - transport-helper: convert to use struct refspec
 - remote: remove add_prune_tags_to_fetch_refspec
 - remote: convert fetch refspecs to struct refspec
 - remote: convert push refspecs to struct refspec
 - fast-export: convert to use struct refspec
 - clone: convert cmd_clone to use refspec_item_init
 - remote: convert match_push_refs to use struct refspec
 - remote: convert check_push_refs to use struct refspec
 - transport: convert transport_push to use struct refspec
 - pull: convert get_tracking_branch to use refspec_item_init
 - submodule--helper: convert push_check to use struct refspec
 - refspec: convert valid_fetch_refspec to use parse_refspec
 - refspec: introduce struct refspec
 - refspec: factor out parsing a single refspec
 - refspec: rename struct refspec to struct refspec_item
 - refspec: move refspec parsing logic into its own file
 (this branch is used by bw/ref-prefix-for-configured-refspec.)

 An API update for handling of refspecs used by fetch & push
 codepath.

 Will merge to 'next'.


* ds/commit-graph-lockfile-fix (2018-05-22) 1 commit
 - commit-graph: fix UX issue when .lock file exists
 (this branch uses ds/generation-numbers.)

 Update to ds/generation-numbers topic.

 Will merge to 'next'.


* jk/unavailable-can-be-missing (2018-05-13) 4 commits
  (merged to 'next' on 2018-05-22 at 91980c5d1e)
 + mark_parents_uninteresting(): avoid most allocation
 + mark_parents_uninteresting(): replace list with stack
 + mark_parents_uninteresting(): drop missing object check
 + mark_tree_contents_uninteresting(): drop missing object check

 Code clean-up to turn history traversal more robust in a
 semi-corrupt repository.

 Will merge to 'master'.


* lm/credential-netrc (2018-05-14) 2 commits
  (merged to 'next' on 2018-05-23 at c3a0417715)
 + git-credential-netrc: accept gpg option
 + git-credential-netrc: adapt to test framework for git

 Update credential-netrc helper (in contrib/) to allow customizing
 the GPG used to decrypt the encrypted .netrc file.

 Will merge to 'master'.


* ma/create-pseudoref-with-null-old-oid (2018-05-13) 3 commits
  (merged to 'next' on 2018-05-22 at c751a19b67)
 + refs: handle zero oid for pseudorefs
 + t1400: add tests around adding/deleting pseudorefs
 + refs.c: refer to "object ID", not "sha1", in error messages

 "git update-ref A B" is supposed to ensure that ref A does not yet
 exist when B is a NULL OID, but this check was not done correctly
 for pseudo-refs outside refs/ hierarchy, e.g. MERGE_HEAD.

 Will merge to 'master'.


* ma/lockfile-cleanup (2018-05-10) 5 commits
  (merged to 'next' on 2018-05-22 at e2efbf0b90)
 + lock_file: move static locks into functions
 + lock_file: make function-local locks non-static
 + refs.c: do not die if locking fails in `delete_pseudoref()`
 + refs.c: do not die if locking fails in `write_pseudoref()`
 + t/helper/test-write-cache: clean up lock-handling

 Code clean-up to adjust to a more recent lockfile API convention that
 allows lockfile instances kept on the stack.

 Will merge to 'master'.


* nd/commit-util-to-slab (2018-05-21) 15 commits
 - commit.h: delete 'util' field in struct commit
 - merge: use commit-slab in merge remote desc instead of commit->util
 - log: use commit-slab in prepare_bases() instead of commit->util
 - show-branch: note about its object flags usage
 - show-branch: use commit-slab for commit-name instead of commit->util
 - name-rev: use commit-slab for rev-name instead of commit->util
 - bisect.c: use commit-slab for commit weight instead of commit->util
 - revision.c: use commit-slab for show_source
 - sequencer.c: use commit-slab to associate todo items to commits
 - sequencer.c: use commit-slab to mark seen commits
 - shallow.c: use commit-slab for commit depth instead of commit->util
 - describe: use commit-slab for commit names instead of commit->util
 - blame: use commit-slab for blame suspects instead of commit->util
 - commit-slab: support shared commit-slab
 - commit-slab.h: code split

 The in-core "commit" object had an all-purpose "void *util" field,
 which was tricky to use especially in library-ish part of the
 code.  All of the existing uses of the field has been migrated to a
 more dedicated "commit-slab" mechanism and the field is eliminated.

 Will merge to 'next'.


* nd/diff-apply-ita (2018-05-14) 2 commits
  (merged to 'next' on 2018-05-22 at a15cc0ce1c)
 + apply: add --intent-to-add
 + diff: turn --ita-invisible-in-index on by default

 "git diff" compares the index and the working tree.  For paths
 added with intent-to-add bit, the command shows the full contents
 of them as added, but the paths themselves were not marked as new
 files.  They are now shown as new by default.

 "git apply" learned the "--intent-to-add" option so that an
 otherwise working-tree-only application of a patch will add new
 paths to the index marked with the "intent-to-add" bit.

 Will merge to and cook in 'next'.


* nd/pack-struct-commit (2018-05-13) 1 commit
  (merged to 'next' on 2018-05-22 at 38d8a651f0)
 + commit.h: rearrange 'index' to shrink struct commit

 Memory optimization.

 Will merge to 'master'.


* nd/repo-clear-keep-the-index (2018-05-10) 1 commit
  (merged to 'next' on 2018-05-22 at 398c7ac4e9)
 + repository: fix free problem with repo_clear(the_repository)

 the_repository->index is not a allocated piece of memory but
 repo_clear() indiscriminately attempted to free(3) it, which has
 been corrected.

 Will merge to 'master'.


* nd/travis-gcc-8 (2018-05-21) 1 commit
  (merged to 'next' on 2018-05-22 at d5d54efa72)
 + travis-ci: run gcc-8 on linux-gcc jobs

 Developer support.  Use newer GCC on one of the builds done at
 TravisCI.org to get more warnings and errors diagnosed.

 Will merge to 'master'.


* rs/no-null-ptr-arith-in-fast-export (2018-05-10) 1 commit
  (merged to 'next' on 2018-05-22 at db60f06bba)
 + fast-export: avoid NULL pointer arithmetic

 Code clean-up to avoid non-standard-conformant pointer arithmetic.

 Will merge to 'master'.


* sb/grep-die-on-unreadable-index (2018-05-16) 1 commit
 - grep: handle corrupt index files early

 Error behaviour of "git grep" when it cannot read the index was
 inconsistent with other commands that uses the index, which has
 been corrected to error out early.

 Will merge to 'next'.


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


* sb/submodule-merge-in-merge-recursive (2018-05-18) 3 commits
 - merge-recursive: give notice when submodule commit gets fast-forwarded
 - merge-recursive: i18n submodule merge output and respect verbosity
 - submodule.c: move submodule merging to merge-recursive.c

 By code restructuring of submodule merge in merge-recursive,
 informational messages from the codepath are now given using the
 same mechanism as other output, and honor the merge.verbosity
 configuration.  The code also learned to give a few new messages
 when a submodule three-way merge resolves cleanly when one side
 records a descendant of the commit chosen by the other side.

 Will merge to 'next'.


* sb/submodule-update-try-harder (2018-05-16) 1 commit
  (merged to 'next' on 2018-05-23 at 698e6707d7)
 + git-submodule.sh: try harder to fetch a submodule

 "git submodule update" attempts two different kinds of "git fetch"
 against the upstream repository to grab a commit bound at the
 submodule's path, but it incorrectly gave up if the first kind
 (i.e. a normal fetch) failed, making the second "last resort" one
 (i.e. fetching an exact commit object by object name) ineffective.
 This has been corrected.

 Will merge to 'master'.


* tb/grep-only-matching (2018-05-14) 2 commits
 - builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'
 - grep.c: extract show_line_header()
 (this branch uses tb/grep-column.)


* ld/p4-unshelve (2018-05-23) 3 commits
 - git-p4: unshelve: use action==add instead of rev==none
 - SQUASH???
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Expecting a reroll.
 cf. <CAE5ih7_jgrTXv25hYqoq=95H0zArbJAeQO3gO_TRpyLHGfTWUg@mail.gmail.com>


* pc/submodule-helper-foreach (2018-05-11) 4 commits
  (merged to 'next' on 2018-05-22 at f22659ad46)
 + submodule: port submodule subcommand 'foreach' from shell to C
 + submodule foreach: document variable '$displaypath'
 + submodule foreach: document '$sm_path' instead of '$path'
 + submodule foreach: correct '$path' in nested submodules from a subdirectory

 The bulk of "git submodule foreach" has been rewritten in C.

 Will merge to and cook in 'next'.


* ab/get-short-oid (2018-05-11) 5 commits
  (merged to 'next' on 2018-05-23 at 07e1908439)
 + get_short_oid: sort ambiguous objects by type, then SHA-1
 + sha1-name.c: move around the collect_ambiguous() function
 + git-p4: change "commitish" typo to "committish"
 + sha1-array.h: align function arguments
 + sha1-name.c: remove stray newline

 When a short hexadecimal string is used to name an object but there
 are multiple objects that share the string as the prefix of their
 names, the code lists these ambiguous candidates in a help message.
 These object names are now sorted according to their types for
 easier eyeballing.

 Will merge to 'master'.


* cf/submodule-progress-dissociate (2018-05-22) 3 commits
  (merged to 'next' on 2018-05-22 at 9b3b96c54b)
 + submodule: add --dissociate option to add/update commands
 + submodule: add --progress option to add command
 + submodule: clean up substitutions in script

 "git submodule update" and "git submodule add" supported the
 "--reference" option to borrow objects from a neighbouring local
 repository like "git clone" does, but lacked the more recent
 invention "--dissociate".  Also "git submodule add" has been taught
 to take the "--progress" option.

 Will merge to 'master'.


* dd/send-email-reedit (2018-05-06) 1 commit
  (merged to 'next' on 2018-05-22 at 1f4c98324f)
 + git-send-email: allow re-editing of message

 "git send-email" can sometimes offer confirmation dialog "Send this
 email?" with choices 'Yes', 'No', 'Quit', and 'All'.  A new action
 'Edit' has been added to this dialog's choice.

 Will merge to 'master'.


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


* js/sequencer-and-root-commits (2018-05-06) 6 commits
  (merged to 'next' on 2018-05-22 at c1a62f5bc9)
 + rebase --rebase-merges: root commits can be cousins, too
 + rebase --rebase-merges: a "merge" into a new root is a fast-forward
 + sequencer: allow introducing new root commits
 + rebase -i --root: let the sequencer handle even the initial part
 + sequencer: learn about the special "fake root commit" handling
 + sequencer: extract helper to update active_cache_tree

 The implementation of "git rebase -i --root" has been updated to use
 the sequencer machinery more.

 Will merge to 'master'.


* js/use-bug-macro (2018-05-10) 5 commits
  (merged to 'next' on 2018-05-22 at fd848c39ae)
 + BUG_exit_code: fix sparse "symbol not declared" warning
 + Convert remaining die*(BUG) messages
 + Replace all die("BUG: ...") calls by BUG() ones
 + run-command: use BUG() to report bugs, not die()
 + test-tool: help verifying BUG() code paths

 Developer support update, by using BUG() macro instead of die() to
 mark codepaths that should not happen more clearly.

 Will merge to 'master'.
 Further updates can come on top later.
 cf. <20180507090109.GA367@sigill.intra.peff.net>


* jt/partial-clone-proto-v2 (2018-05-06) 4 commits
  (merged to 'next' on 2018-05-23 at f8b3692e8e)
 + {fetch,upload}-pack: support filter in protocol v2
 + upload-pack: read config when serving protocol v2
 + upload-pack: fix error message typo
 + Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2

 Transfer protocol v2 learned to support the partial clone.

 Will merge to 'master'.


* ma/doc-expand-tabs (2018-05-02) 1 commit
 - revisions.txt: expand tabs to spaces in diagram

 Fix one instance of asciidoctor's misformatting by expanding a tab
 into spaces in a literal block.

 Will discard.  This approach is less maintainable than the approach
 taken by bc/asciidoctor-tab-width topic.


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


* tb/grep-column (2018-05-14) 7 commits
 - contrib/git-jump/git-jump: jump to match column in addition to line
 - grep.c: add configuration variables to show matched option
 - builtin/grep.c: add '--column' option to 'git-grep(1)'
 - grep.c: display column number of first match
 - grep.[ch]: extend grep_opt to allow showing matched column
 - grep.c: expose matched column in match_line()
 - Documentation/config.txt: camel-case lineNumber for consistency
 (this branch is used by tb/grep-only-matching.)

 "git grep" learned the "--column" option that gives not just the
 line number but the column number of the hit.


* bc/object-id (2018-05-02) 42 commits
  (merged to 'next' on 2018-05-23 at 916bcce829)
 + merge-one-file: compute empty blob object ID
 + add--interactive: compute the empty tree value
 + Update shell scripts to compute empty tree object ID
 + sha1_file: only expose empty object constants through git_hash_algo
 + dir: use the_hash_algo for empty blob object ID
 + sequencer: use the_hash_algo for empty tree object ID
 + cache-tree: use is_empty_tree_oid
 + sha1_file: convert cached object code to struct object_id
 + builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
 + builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
 + wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
 + submodule: convert several uses of EMPTY_TREE_SHA1_HEX
 + sequencer: convert one use of EMPTY_TREE_SHA1_HEX
 + merge: convert empty tree constant to the_hash_algo
 + builtin/merge: switch tree functions to use object_id
 + builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
 + sha1-file: add functions for hex empty tree and blob OIDs
 + builtin/receive-pack: avoid hard-coded constants for push certs
 + diff: specify abbreviation size in terms of the_hash_algo
 + upload-pack: replace use of several hard-coded constants
 + revision: replace use of hard-coded constants
 + http: eliminate hard-coded constants
 + dir: convert struct untracked_cache_dir to object_id
 + commit: convert uses of get_sha1_hex to get_oid_hex
 + index-pack: abstract away hash function constant
 + pack-redundant: convert linked lists to use struct object_id
 + Update struct index_state to use struct object_id
 + split-index: convert struct split_index to object_id
 + submodule-config: convert structures to object_id
 + fsck: convert static functions to struct object_id
 + tree-walk: convert get_tree_entry_follow_symlinks to object_id
 + tree-walk: avoid hard-coded 20 constant
 + pack-redundant: abstract away hash algorithm
 + pack-objects: abstract away hash algorithm
 + packfile: abstract away hash constant values
 + packfile: convert find_pack_entry to object_id
 + sha1-file: convert freshen functions to object_id
 + packfile: convert has_sha1_pack to object_id
 + packfile: remove unused member from struct pack_entry
 + Remove unused member in struct object_context
 + server-info: remove unused members from struct pack_info
 + cache: add a function to read an object ID from a buffer

 Conversion from uchar[20] to struct object_id continues.

 Will merge to 'master'.


* bp/merge-rename-config (2018-05-08) 3 commits
  (merged to 'next' on 2018-05-22 at 911440a742)
 + merge: pass aggressive when rename detection is turned off
 + merge: add merge.renames config setting
 + merge: update documentation for {merge,diff}.renameLimit
 (this branch is used by ma/unpack-trees-free-msgs.)

 With merge.renames configuration set to false, the recursive merge
 strategy can be told not to spend cycles trying to find renamed
 paths and merge them accordingly.

 Will merge to 'master'.


* sb/diff-color-move-more (2018-05-21) 8 commits
 - diff: color-moved white space handling options imply color-moved
 - diff.c: add --color-moved-ignore-space-delta option
 - diff.c: decouple white space treatment from move detection algorithm
 - diff.c: add a blocks mode for moved code detection
 - diff.c: adjust hash function signature to match hashmap expectation
 - diff.c: do not pass diff options as keydata to hashmap
 - xdiff/xdiffi.c: remove unneeded function declarations
 - xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.

 Will merge to 'next'.


* ds/generation-numbers (2018-05-22) 11 commits
 - commit-graph.txt: update design document
 - merge: check config before loading commits
 - commit: use generation number in remove_redundant()
 - commit: add short-circuit to paint_down_to_common()
 - commit: use generation numbers for in_merge_bases()
 - ref-filter: use generation number for --contains
 - commit-graph: always load commit-graph information
 - commit: use generations in paint_down_to_common()
 - commit-graph: compute generation numbers
 - commit: add generation number to struct commit
 - ref-filter: fix outdated comment on in_commit_list
 (this branch is used by ds/commit-graph-lockfile-fix.)

 A recently added "commit-graph" datafile has learned to store
 pre-computed generation numbers to speed up the decisions to stop
 history traversal.

 Will merge to 'next'.


* nd/command-list (2018-05-21) 17 commits
 - completion: allow to customize the completable command list
 - completion: add and use --list-cmds=alias
 - completion: add and use --list-cmds=nohelpers
 - Move declaration for alias.c to alias.h
 - completion: reduce completable command list
 - completion: let git provide the completable command list
 - command-list.txt: documentation and guide line
 - help: use command-list.txt for the source of guides
 - help: add "-a --verbose" to list all commands with synopsis
 - git: support --list-cmds=list-<category>
 - completion: implement and use --list-cmds=main,others
 - git --list-cmds: collect command list in a string_list
 - git.c: convert --list-* to --list-cmds=*
 - Remove common-cmds.h
 - help: use command-list.h for common command list
 - generate-cmds.sh: export all commands to command-list.h
 - generate-cmds.sh: factor out synopsis extract code

 The list of commands with their various attributes were spread
 across a few places in the build procedure, but it now is getting a
 bit more consolidated to allow more automation.

 Will merge to 'next'.


* sg/complete-paths (2018-05-21) 13 commits
  (merged to 'next' on 2018-05-22 at a00b992aec)
 + t9902-completion: exercise __git_complete_index_file() directly
 + completion: don't return with error from __gitcomp_file_direct()
  (merged to 'next' on 2018-05-08 at 2a11444f90)
 + completion: fill COMPREPLY directly when completing paths
 + completion: improve handling quoted paths in 'git ls-files's output
 + completion: remove repeated dirnames with 'awk' during path completion
 + t9902-completion: ignore COMPREPLY element order in some tests
 + completion: use 'awk' to strip trailing path components
 + completion: let 'ls-files' and 'diff-index' filter matching paths
 + completion: improve handling quoted paths on the command line
 + completion: support completing non-ASCII pathnames
 + completion: simplify prefix path component handling during path completion
 + completion: move __git_complete_index_file() next to its helpers
 + t9902-completion: add tests demonstrating issues with quoted pathnames

 Command line completion (in contrib/) learned to complete pathnames
 for various commands better.

 Will merge to 'master'.


* sb/blame-color (2018-04-24) 3 commits
  (merged to 'next' on 2018-05-23 at 2e9c0daf0b)
 + builtin/blame: add new coloring scheme config
 + builtin/blame: highlight recently changed lines
 + builtin/blame: dim uninteresting metadata lines

 "git blame" learns to unhighlight uninteresting metadata from the
 originating commit on lines that are the same as the previous one,
 and also paint lines in different colors depending on the age of
 the commit.

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
 Perhaps merge to 'master' immediately after 2.18 release?


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
