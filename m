Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9E11F404
	for <e@80x24.org>; Wed, 25 Apr 2018 08:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbeDYIiI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 04:38:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39316 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYIh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 04:37:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id b21so5315483wme.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CkDmvGDUseJUmqHJVZAVBssdIknSkHa+lQg4WHAad+k=;
        b=k5k6jwPKMRXyvzkT/DAlxXeDwL1ZWm60GbOQBY6B76j56wYj9rMlSQQCPKM+Ud6tBR
         nBGiyLOuEZK+qvZX+G18DFj6BmQyhN215aM/Lkm66PbOxg1rPi2W144ZAXV+pWMKieqa
         310BUDBjG9AdRVNq3a96cdx4q1CCfSutLS99NiOOQumAZwjPvTAlHY7AduyiKpgOk5BS
         B91ru45YLzaY8oUim58af2UfHKoeon/1J5KY4tSB8H6vZLaaDYi2YYvks/AESPzVsBkw
         5LF5q2drQSmJ9uMV/awIHKd3ZJOtMEq3mdqVVyL0C/yf1TPOPfnhSmx2VLj9zkGsghGh
         fTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CkDmvGDUseJUmqHJVZAVBssdIknSkHa+lQg4WHAad+k=;
        b=OmLt084gIWUNhILp16ZVC03yF5CR4F08elwhd+KqHhN8dMzKoyAxW9MupVp+3gX+ZG
         +526tbvH8Lac9w8/TBpAKBuZKbHQLr6SDKT+5byFqkU010u9kt4JcFS+jd6ZL/KZ8861
         sC0OA6NNGe0ctyZcmzcB0hH4uIcjVWpb765y8ZGINu70vY1zXhgjmlQiCKdBErFsQFNJ
         vd+nuw3mUYVxOqyQpKr8//wxVzRMR4E4T/BXkWATqqh9OHNj+6eOvZdZN0e3DNFIWK6+
         YXgGbSfeK9eZxqNM7Swru/MRHaY93qi8qWmndR1P2XVXVrUhUFbWBWrOG4j39ltRXbJr
         32KQ==
X-Gm-Message-State: ALQs6tBcWVrirU5TH4kfmrTsu9BMfryZ2U2nxrbjCT+0cazOHBOVBKpV
        cQDeXQcPe7zK4eq75Q/VebNvDG0SQq/v5w==
X-Google-Smtp-Source: AB8JxZpvjpeIVELADrLjMH2Dd+2a6gQslKlwzrIEHCnkz4fJEPbxeDpfYl9Ezau0Moypr2L6t7Wt8Q==
X-Received: by 10.28.54.71 with SMTP id d68mr754161wma.39.1524645474032;
        Wed, 25 Apr 2018 01:37:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v6-v6sm16326456wrd.54.2018.04.25.01.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 01:37:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2018, #03; Wed, 25)
X-master-at: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
X-next-at: 969e05fae2431648e30fa9034c7319a06e8575d5
Date:   Wed, 25 Apr 2018 17:37:52 +0900
Message-ID: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

* ak/bisect-doc-typofix (2018-04-07) 1 commit
  (merged to 'next' on 2018-04-17 at eafdeb0248)
 + Documentation/git-bisect.txt: git bisect term → git bisect terms

 Docfix.


* bb/git-gui-ssh-key-files (2018-03-02) 2 commits
  (merged to 'next' on 2018-04-17 at e439f0398d)
 + Merge branch 'bb/ssh-key-files' of git-gui into bb/git-gui-ssh-key-files
 + git-gui: search for all current SSH key types

 "git gui" learned that "~/.ssh/id_ecdsa.pub" and
 "~/.ssh/id_ed25519.pub" are also possible SSH key files.


* bp/fsmonitor-bufsize-fix (2018-04-11) 1 commit
  (merged to 'next' on 2018-04-17 at 70a7091e06)
 + fsmonitor: fix incorrect buffer size when printing version number

 Fix an unexploitable (because the oversized contents are not under
 attacker's control) buffer overflow.


* bp/fsmonitor-prime-index (2018-04-11) 1 commit
  (merged to 'next' on 2018-04-17 at 765edccdf0)
 + fsmonitor: force index write after full scan

 The index file is updated to record the fsmonitor section after a
 full scan was made, to avoid wasting the effort that has already
 spent.


* bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
  (merged to 'next' on 2018-04-17 at 35828e90e2)
 + Merge branch 'bp/bind-kp-enter' of git-gui into bp/git-gui-bind-kp-enter
 + git-gui: bind CTRL/CMD+numpad ENTER to do_commit

 "git gui" performs commit upon CTRL/CMD+ENTER but the
 CTRL/CMD+KP_ENTER (i.e. enter key on the numpad) did not have the
 same key binding.  It now does.


* br/mergetools-guiffy (2018-04-06) 1 commit
  (merged to 'next' on 2018-04-17 at 8ec0697d5d)
 + mergetools: add support for guiffy

 "git mergetools" learned talking to guiffy.


* bw/commit-partial-from-subdirectory-fix (2018-04-05) 1 commit
  (merged to 'next' on 2018-04-17 at 1e56bbc14d)
 + commit: allow partial commits with relative paths

 "cd sub/dir && git commit ../path" ought to record the changes to
 the file "sub/path", but this regressed long time ago.


* cb/bash-completion-ls-files-processing (2018-04-10) 1 commit
  (merged to 'next' on 2018-04-17 at 956b155366)
 + completion: improve ls-files filter performance

 Shell completion (in contrib) that gives list of paths have been
 optimized somewhat.


* cb/git-gui-ttk-style (2018-03-05) 2 commits
  (merged to 'next' on 2018-04-17 at 1a4f677a0d)
 + Merge branch 'cb/ttk-style' of git-gui into cb/git-gui-ttk-style
 + git-gui: workaround ttk:style theme use

 "git gui" has been taught to work with old versions of tk (like
 8.5.7) that do not support "ttk::style theme use" as a way to query
 the current theme.


* cc/perf-bisect (2018-04-11) 2 commits
  (merged to 'next' on 2018-04-17 at 62a1498dd0)
 + t/perf: add scripts to bisect performance regressions
 + perf/run: add --subsection option

 Performance measuring framework in t/perf learned to help bisecting
 performance regressions.


* en/doc-typoes (2018-04-09) 2 commits
  (merged to 'next' on 2018-04-17 at 81e5c8da18)
 + Documentation: normalize spelling of 'normalised'
 + Documentation: fix several one-character-off spelling errors

 Docfix.


* es/fread-reads-dir-autoconf-fix (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-17 at 538601fef3)
 + configure.ac: fix botched FREAD_READS_DIRECTORIES check

 Small fix to the autoconf build procedure.


* es/worktree-docs (2018-04-09) 2 commits
  (merged to 'next' on 2018-04-17 at 15a098e9b1)
 + git-worktree.txt: unify command-line prompt in example blocks
 + git-worktree.txt: recommend 'git worktree remove' over manual deletion
 (this branch uses nd/worktree-move.)

 Doc updates.


* jk/flockfile-stdio (2018-03-30) 1 commit
  (merged to 'next' on 2018-04-17 at e11bd565f4)
 + config: move flockfile() closer to unlocked functions

 Code clean-up.


* jk/ref-array-push (2018-04-09) 3 commits
  (merged to 'next' on 2018-04-17 at 61859b271b)
 + ref-filter: factor ref_array pushing into its own function
 + ref-filter: make ref_array_item allocation more consistent
 + ref-filter: use "struct object_id" consistently
 (this branch is used by hn/sort-ls-remote.)

 API clean-up aournd ref-filter code.


* jk/relative-directory-fix (2018-03-30) 5 commits
  (merged to 'next' on 2018-04-17 at 1b8cc9dcb4)
 + refs: use chdir_notify to update cached relative paths
 + set_work_tree: use chdir_notify
 + add chdir-notify API
 + trace.c: export trace_setup_key
 + set_git_dir: die when setenv() fails

 Some codepaths, including the refs API, get and keep relative
 paths, that go out of sync when the process does chdir(2).  The
 chdir-notify API is introduced to let these codepaths adjust these
 cached paths to the new current directory.


* jk/t5561-missing-curl (2018-04-05) 2 commits
  (merged to 'next' on 2018-04-17 at d8592fa6c2)
 + t5561: skip tests if curl is not available
 + t5561: drop curl stderr redirects

 Test fixes.


* jm/mem-pool (2018-04-12) 3 commits
  (merged to 'next' on 2018-04-17 at 8a3641ab3a)
 + mem-pool: move reusable parts of memory pool into its own file
 + fast-import: introduce mem_pool type
 + fast-import: rename mem_pool type to mp_block

 An reusable "memory pool" implementation has been extracted from
 fast-import.c, which in turn has become the first user of the
 mem-pool API.


* js/t5404-path-fix (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-17 at 94092f2896)
 + t5404: relax overzealous test

 Test fix.


* ks/branch-list-detached-rebase-i (2018-04-05) 2 commits
  (merged to 'next' on 2018-04-17 at 5c2842c3f9)
 + t3200: verify "branch --list" sanity when rebasing from detached HEAD
 + branch --list: print useful info whilst interactive rebasing a detached HEAD

 "git branch --list" during an interrupted "rebase -i" now lets
 users distinguish the case where a detached HEAD is being rebased
 and a normal branch is being rebased.


* lw/daemon-log-destination (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-17 at b06cdcc45e)
 + daemon.c: fix condition for redirecting stderr

 Recent introduction of "--log-destination" option to "git daemon"
 did not work well when the daemon was run under "--inetd" mode.


* mn/send-email-credential-doc (2018-04-08) 1 commit
  (merged to 'next' on 2018-04-17 at c4db21eb9b)
 + send-email: simplify Gmail example in the documentation

 Doc update.


* nd/worktree-move (2018-04-05) 1 commit
  (merged to 'next' on 2018-04-17 at 11ca393110)
 + t2028: tighten grep expression to make "move worktree" test more robust
 (this branch is used by es/worktree-docs.)

 Test update.


* ps/test-chmtime-get (2018-04-09) 1 commit
  (merged to 'next' on 2018-04-17 at dcb138d8b1)
 + t/helper: 'test-chmtime (--get|-g)' to print only the mtime

 Test cleanup.


* pw/rebase-keep-empty-fixes (2018-03-29) 3 commits
  (merged to 'next' on 2018-04-17 at 10a4d92060)
 + rebase: respect --no-keep-empty
 + rebase -i --keep-empty: don't prune empty commits
 + rebase --root: stop assuming squash_onto is unset
 (this branch is used by pw/rebase-signoff.)

 "git rebase --keep-empty" still removed an empty commit if the
 other side contained an empty commit (due to the "does an
 equivalent patch exist already?" check), which has been corrected.


* pw/rebase-signoff (2018-03-29) 4 commits
  (merged to 'next' on 2018-04-17 at fbdc16e20e)
 + rebase --keep-empty: always use interactive rebase
 + rebase -p: error out if --signoff is given
 + rebase: extend --signoff support
 + Merge branch 'pw/rebase-keep-empty-fixes' into pw/rebase-signoff
 (this branch uses pw/rebase-keep-empty-fixes.)

 "git rebase" has learned to honor "--signoff" option when using
 backends other than "am" (but not "--preserve-merges").


* sb/filenames-with-dashes (2018-04-11) 6 commits
  (merged to 'next' on 2018-04-17 at 45fdeb5cb1)
 + replace_object.c: rename to use dash in file name
 + sha1_file.c: rename to use dash in file name
 + sha1_name.c: rename to use dash in file name
 + exec_cmd: rename to use dash in file name
 + unicode_width.h: rename to use dash in file name
 + write_or_die.c: rename to use dashes in file name

 Rename bunch of source files to more consistently use dashes
 instead of underscores to connect words.


* tg/use-git-contacts (2018-04-12) 1 commit
  (merged to 'next' on 2018-04-17 at 26cf8c1d8c)
 + SubmittingPatches: mention the git contacts command

 Doc update.

--------------------------------------------------
[New Topics]

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
 - sequencer: reset the committer date before commits

 During a "rebase -i" session, the code could give older timestamp
 to commits created by later "pick" than an earlier "reword", which
 has been corrected.

 Will merge to 'next'.


* nd/submodule-status-fix (2018-04-19) 1 commit
 - submodule--helper: don't print null in 'submodule status'

 "git submodule status" did not check the symbolic revision name it
 computed for the submodule HEAD is not the NULL, and threw it at
 printf routines, which has been corrected.

 Will merge to 'next'.


* sa/send-email-dedup-some-headers (2018-04-19) 1 commit
 - send-email: avoid duplicate In-Reply-To/References

 When fed input that already has In-Reply-To: and/or References:
 headers and told to add the same information, "git send-email"
 added these headers separately, instead of appending to an existing
 one, which is a violation of the RFC.  This has been corrected.

 Will merge to 'next'.


* tg/demote-stash-save-in-completion (2018-04-20) 2 commits
 - completion: make stash -p and alias for stash push -p
 - completion: stop showing 'save' for stash by default

 THe command line completion (in contrib/) has been taught that "git
 stash save" has been deprecated ("git stash push" is the preferred
 spellingin the new world) and does not offer it as a possible
 completion candidate when "git stash push" can be.

 Will merge to 'next'.


* tz/doc-git-urls-reference (2018-04-20) 1 commit
 - doc/clone: update caption for GIT URLS cross-reference

 Doc fix.

 Will merge to 'next'.


* js/deprecate-grafts (2018-04-24) 11 commits
 - Remove obsolete script to convert grafts to replace refs
 - technical/shallow: describe why shallow cannot use replace refs
 - technical/shallow: describe the relationship with replace refs
 - filter-branch: stop suggesting to use grafts
 - Deprecate support for .git/info/grafts
 - Add a test for `git replace --convert-graft-file`
 - replace: introduce --convert-graft-file
 - replace: "libify" create_graft() and callees
 - replace: avoid using die() to indicate a bug
 - commit: Let the callback of for_each_mergetag return on error
 - argv_array: offer to split a string by whitespace

 The functionality of "$GIT_DIR/info/grafts" has been superseded by
 the "refs/replace/" mechanism for some time now, but the internal
 code had support for it in many places, which has been cleaned up
 in order to drop support of the "grafts" mechanism.


* js/rebase-i-clean-msg-after-fixup-continue (2018-04-24) 4 commits
 - rebase --skip: clean up commit message after a failed fixup/squash
 - sequencer: leave a tell-tale when a fixup/squash failed
 - rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
 - rebase -i: demonstrate bugs with fixup!/squash! commit messages

 "git rebase -i" sometimes left intermediate "# This is a
 combination of N commits" message meant for the human consumption
 inside an editor in the final result in certain corner cases, which
 has been fixed.

 Will merge to 'next'.


* ma/fast-export-skip-merge-fix (2018-04-21) 1 commit
 - fast-export: fix regression skipping some merge-commits

 "git fast-export" had a regression in v2.15.0 era where it skipped
 some merge commits in certain cases, which has been corrected.

 Will merge to 'next'.


* bw/server-options (2018-04-24) 4 commits
 - fetch: send server options when using protocol v2
 - ls-remote: send server options when using protocol v2
 - serve: introduce the server-option capability
 - Merge branch 'bw/protocol-v2' into HEAD
 (this branch uses bw/protocol-v2.)

 The transport protocol v2 is getting updated further.


* jc/parseopt-expiry-errors (2018-04-23) 2 commits
 - parseopt: handle malformed --expire arguments more nicely
 - gc: do not upcase error message shown with die()

 "git gc --prune=nonsense" spent long time repacking and then
 silently failed when underlying "git prune --expire=nonsense"
 failed to parse its command line.  This has been corrected.

 Will merge to 'next'.


* js/colored-push-errors (2018-04-24) 4 commits
 - config: document the settings to colorize push errors/hints
 - push: test to verify that push errors are colored
 - push: colorize errors
 - color: introduce support for colorizing stderr

 Error messages from "git push" can be painted for more visibility.

 Will merge to 'next'.


* js/runtime-prefix (2018-04-24) 8 commits
 - Avoid multiple PREFIX definitions
 - git_setup_gettext: plug memory leak
 - gettext: avoid initialization if the locale dir is not present
  (merged to 'next' on 2018-04-17 at a69aaa7a22)
 + mingw/msvc: use the new-style RUNTIME_PREFIX helper
 + exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
 + exec_cmd: RUNTIME_PREFIX on some POSIX systems
 + Makefile: add Perl runtime prefix support
 + Makefile: generate Perl header from template file
 (this branch is tangled with dj/runtime-prefix.)

 Will merge to 'next'.


* ma/http-walker-no-partial (2018-04-24) 2 commits
 - walker: drop fields of `struct walker` which are always 1
 - http-fetch: make `-a` standard behaviour

 "git http-fetch" (deprecated) had an optional and experimental
 "feature" to fetch only commits and/or trees, which nobody used.
 This has been removed.

 Will merge to 'next'.


* bc/object-id (2018-04-24) 41 commits
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
 - sha1_file: convert freshen functions to object_id
 - packfile: convert has_sha1_pack to object_id
 - packfile: remove unused member from struct pack_entry
 - Remove unused member in struct object_context
 - server-info: remove unused members from struct pack_info
 - cache: add a function to read an object ID from a buffer

 Conversion from uchar[20] to struct object_id continues.


* sb/oid-object-info (2018-04-25) 9 commits
 - cache.h: allow oid_object_info to handle arbitrary repositories
 - packfile: add repository argument to cache_or_unpack_entry
 - packfile: add repository argument to unpack_entry
 - packfile: add repository argument to read_object
 - packfile: add repository argument to packed_object_info
 - packfile: add repository argument to packed_to_object_type
 - packfile: add repository argument to retry_bad_packed_offset
 - cache.h: add repository argument to oid_object_info
 - cache.h: add repository argument to oid_object_info_extended
 (this branch uses sb/object-store-replace.)

 The codepath around object-info API has been taught to take the
 repository object (which in turn tells the API which object store
 the objects are to be located).


* en/unpack-trees-split-index-fix (2018-04-24) 1 commit
 - unpack_trees: fix breakage when o->src_index != o->dst_index

 The split-index feature had a long-standing and dormant bug in
 certain use of the in-core merge machinery, which has been fixed.

 Will merge to 'next'.


* bp/merge-rename-config (2018-04-25) 2 commits
 - merge: add merge.aggressive config setting
 - merge: add merge.renames config setting


* en/git-debugger (2018-04-25) 1 commit
 - Make running git under other debugger-like programs easy


* js/no-pager-shorthand (2018-04-25) 1 commit
 - git: add -N as a short option for --no-pager

 "git --no-pager cmd" did not have short-and-sweet single letter
 option.


* sb/diff-color-move-more (2018-04-25) 7 commits
 - diff.c: add --color-moved-ignore-space-delta option
 - diff.c: decouple white space treatment from move detection algorithm
 - diff.c: add a blocks mode for moved code detection
 - diff.c: adjust hash function signature to match hashmap expectation
 - diff.c: do not pass diff options as keydata to hashmap
 - xdiff/xdiffi.c: remove unneeded function declarations
 - xdiff/xdiff.h: remove unused flags

 "git diff --color-moved" feature has further been tweaked.


--------------------------------------------------
[Stalled]

* fg/completion-external (2018-04-11) 1 commit
 - completion: load completion file for external subcommand

 The command line completion mechanism (in contrib/) learned to load
 custom completion file for "git $command" where $command is a
 custom "git-$command" that the end user has on the $PATH when using
 newer version of bash.

 Hold.
 cf. <CAM0VKj=pDVxfJtUZx7c6uCmPxwQFPBOQYdd7NH=YnVG86iK0Pw@mail.gmail.com>


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

* so/glossary-ancestor (2018-04-17) 1 commit
  (merged to 'next' on 2018-04-25 at 0a849fee00)
 + glossary: substitute "ancestor" for "direct ancestor" in 'push' description.

 Docfix.

 Will merge to 'master'.


* bt/gpg-interface (2018-04-16) 7 commits
 - gpg-interface: find the last gpg signature line
 - gpg-interface: extract gpg line matching helper
 - gpg-interface: fix const-correctness of "eol" pointer
 - gpg-interface: use size_t for signature buffer size
 - gpg-interface: modernize function declarations
 - gpg-interface: handle bool user.signingkey
 - t7004: fix mistaken tag name

 What is queued here is only the obviously correct and
 uncontroversial code clean-up part, which is an earlier 7 patches,
 of a larger series.

 The remainder that is not queued introuces a few configuration
 variables to deal with e-signature backends with different
 signature format.

 Will merge to 'next'.


* ds/generation-numbers (2018-04-11) 10 commits
 - commit: add short-circuit to paint_down_to_common()
 - commit: use generation numbers for in_merge_bases()
 - ref-filter: use generation number for --contains
 - commit-graph.txt: update future work
 - commit.c: use generation to halt paint walk
 - commit: use generations in paint_down_to_common()
 - commit-graph: compute generation numbers
 - commit: add generation number to struct commmit
 - merge: check config before loading commits
 - object.c: parse commit in graph first
 (this branch uses ds/commit-graph; is tangled with ds/lazy-load-trees.)

 A recently added "commit-graph" datafile has learned to store
 pre-computed generation numbers to speed up the decisions to stop
 history traversal.

 Expecting a reroll.
 cf. <cc58d8c1-f8de-4841-934f-56e4ad7729aa@gmail.com>


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

 Reboot of an attempt to detect wholesale directory renames and use
 it while merging.

 Expecting a reroll.
 cf. <CABPp-BHZ-agTY77iqe9BxLC2ijrcKO+UPk83Bn+0cckA3fJFYg@mail.gmail.com>


* nd/command-list (2018-04-24) 6 commits
 - help: use command-list.txt for the source of guides
 - help: add "-a --verbose" to list all commands with synopsis
 - git.c: implement --list-cmds=porcelain
 - generate-cmdlist.sh: keep all information in common-cmds.h
 - git.c: implement --list-cmds=all and use it in git-completion.bash
 - git.c: convert --list-*builtins to --list-cmds=*

 The list of commands with their various attributes were spread
 across a few places in the build procedure, but it now is getting a
 bit more consolidated to allow more automation.

 Expecting a reroll.
 Bash-isms and other things need to be fixed.


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
 (this branch is used by sb/oid-object-info.)

 The effort to pass the repository in-core structure throughout the
 API continues.  This round deals with the code that implements the
 refs/replace/ mechanism.

 Will merge to 'master'.


* hn/bisect-first-parent (2018-04-21) 1 commit
 - bisect: create 'bisect_flags' parameter in find_bisection()

 Preliminary code update to allow passing more flags down the
 bisection codepath in the future.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


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


* ab/simplify-perl-makefile (2018-04-19) 2 commits
  (merged to 'next' on 2018-04-25 at 906cf21682)
 + Makefile: mark perllibdir as a .PHONY target
  (merged to 'next' on 2018-04-17 at 4448756934)
 + perl: fix installing modules from contrib

 Recent simplification of build procedure forgot a bit of tweak to
 the build procedure of contrib/mw-to-git/

 Will merge to 'master'.


* ds/lazy-load-trees (2018-04-11) 5 commits
  (merged to 'next' on 2018-04-25 at b90813f421)
 + commit-graph: lazy-load trees for commits
 + treewide: replace maybe_tree with accessor methods
 + commit: create get_commit_tree() method
 + treewide: rename tree to maybe_tree
 + Merge branch 'bw/c-plus-plus' into ds/lazy-load-trees
 (this branch uses ds/commit-graph; is tangled with ds/generation-numbers.)

 The code has been taught to use the duplicated information stored
 in the commit-graph file to learn the tree object name for a commit
 to avoid opening and parsing the commit object when it makes sense
 to do so.

 Will merge to 'master'.


* ab/git-svn-get-record-typofix (2018-04-09) 1 commit
 - git-svn: avoid warning on undef readline()

 "git svn" had a minor thinko/typo which has been fixed.

 Will merge to 'next'.


* hn/sort-ls-remote (2018-04-09) 1 commit
 - ls-remote: create '--sort' option

 "git ls-remote" learned an option to allow sorting its output based
 on the refnames being shown.

 Will merge to 'next'.


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

 Expecting a final reroll.
 cf. <20180411034941.GA63158@syl.local>
 This looked more or less ready, IIRC


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

 Will wait on the tb/config-type topic.


* jh/json-writer (2018-03-28) 1 commit
 - json_writer: new routines to create data in JSON format

 Preparatory code to later add json output for unspecified telemetry
 data.

 We do not add random code that does not have real users to our
 codebase, so let's have it wait until such a real code materializes
 before too long.


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

 What's the doneness of this thing?  The interdiff since previous
 rounds looked reasonable, but I didn't see this round otherwise
 scrutinized by reviewers.  The numbers given in the commit near the
 tip do look impressive, though ;-)


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

 What's the doneness of this thing?  The interdiff since the earlier
 one looked reasonable, but I didn't see this round otherwise
 scrutinized by reviewers.


* pw/add-p-select (2018-03-16) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines

 "git add -p" interactive interface learned to let users choose
 individual added/removed lines to be used in the operation, instead
 of accepting or rejecting a whole hunk.

 Expecting a reroll to reignite the discussion.
 cf. <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>


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


* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Expecting a response to review comments
 e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


* tg/worktree-add-existing-branch (2018-04-25) 4 commits
 - worktree: teach "add" to check out existing branches
 - worktree: factor out dwim_branch function
 - worktree: improve message when creating a new worktree
 - worktree: remove extra members from struct add_opts

 "git worktree add" learned to check out an existing branch.

 Is this ready for 'next'?


* js/rebase-recreate-merge (2018-04-24) 16 commits
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
 - git-rebase--interactive: clarify arguments
 - sequencer: offer helpful advice when a command was rescheduled
 - sequencer: refactor how original todo list lines are accessed
 - sequencer: make rearrange_squash() a bit more obvious
 - sequencer: avoid using errno clobbered by rollback_lock_file()

 "git rebase" learned "--rebase-merges" to transplant the whole
 topology of commit graph elsewhere.

 Was on hold.  What's the donness of this thing?
 cf. <nycvar.QRO.7.76.6.1804210017020.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>


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
 (this branch is used by bw/server-options.)

 The beginning of the next-gen transfer protocol.

 Will cook in 'next'.


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
 This looked more or less ready for 'next'.  Please stop me if there
 are remaining issues I forgot about.

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
