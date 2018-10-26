Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB6E1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 07:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeJZQde (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:33:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37865 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQdd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:33:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so492884wmc.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=BCtmSZopfVdgQk6x+DqXDJ1zBxfXncIVvECkTIYlFy8=;
        b=himSey8SaHKQcMe2zZoPoLPgkC7ZeCplsQmo+2vxqXNq65h/gBg/1uy3P8iN5ujrep
         nBafIy+VaDo0EFsetgsgQ8KEs+2v8lUKnUDHjhIrGx/bGbmnpAQie77iKw85nZzi6aRS
         Fp1Vc4G4DvsRsfK0FYxhX9gpVYh2Chf8AHki75K1hne12yXf98vxTCKyuVrHiLmtTz2f
         QyZZTNAB06H0xJfG42i8CUQdYq6sWsOMyQi0GWPSrRz6WWP67xIcoAF5jiTQP6L2WiyX
         pJjRbpuIcKploolc7x9WPsFuU2M91Vqg+IjuFp5zalIhKEPBMd9u3qih7Yp9J0HaDwBl
         SoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=BCtmSZopfVdgQk6x+DqXDJ1zBxfXncIVvECkTIYlFy8=;
        b=XCRkBhXl3F7wjtPouVmoUgf7UW8VpiAkk42dvwtfvvcnt1/6XWAmruOYOl79avbmMC
         GLE4cNeOKcFiWvq1TqGhkswf2waCLl62lxXpGd9P1aiDqH5K5Jx+maThvbnMg0oZOyp6
         wtH+7gjgdNiqKjg/Y/PeroWGGNnMeAzFrQLLAx/Q4N0UNkqgRg9OdNmm9BcLFHpy86V0
         h8QB9o+RrU5pYK90LPkY4cj0yX6YyArRlulGSoBPaqy52NOGBgXFffHpmrzuJDMC8vc9
         Az4hIz3UJEREgMpINZvxmroeUsU7tTt+BCAj4znwW7fABrTAVNqowff3gDxUZG/WDgj+
         LQqQ==
X-Gm-Message-State: AGRZ1gLsm14OlyH0S1vqkP8UMLGhsDFlZOKD4ohP+rFp4h4eEZPwCmlB
        NcaCQsWjtzDfJG+i3PvF3+H5H0PM9INIDWSq
X-Google-Smtp-Source: AJdET5d6m7I4S9OIGVXTG3cqLP+lMCSMxSmqNbyBLI5pRJD4+5Ec07x6a2SXAQj6nQjajua4ZpY6KA==
X-Received: by 2002:a1c:3795:: with SMTP id e143-v6mr4719007wma.9.1540540648784;
        Fri, 26 Oct 2018 00:57:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v2-v6sm3284981wru.17.2018.10.26.00.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 00:57:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2018, #05; Fri, 26)
X-master-at: c670b1f876521c9f7cd40184bf7ed05aad843433
X-next-at: b2b9d981bf34f0657045fe90a098deb6e3a9dbe8
Date:   Fri, 26 Oct 2018 16:57:26 +0900
Message-ID: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
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

Quite a few topics have graduated to 'master'.  At sixth batch,
'master' now has 450+ patches since v2.19 and 'next' has additional
170+ patches pending.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/gc-doc-update (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-19 at 84347d36a7)
 + gc doc: mention the commit-graph in the intro

 The documentation of "git gc" has been updated to mention that it
 is no longer limited to "pruning away crufts" but also updates
 ancillary files like commit-graph as a part of repository
 optimization.


* bc/editorconfig (2018-10-09) 2 commits
  (merged to 'next' on 2018-10-16 at 81461ae0fd)
 + editorconfig: indicate settings should be kept in sync
 + editorconfig: provide editor settings for Git developers

 To help developers, an EditorConfig file that attempts to follow
 the project convention has been added.


* ds/coverage-diff (2018-10-10) 1 commit
  (merged to 'next' on 2018-10-16 at c12b7279d9)
 + contrib: add coverage-diff script

 The result of coverage test can be combined with "git blame" to
 check the test coverage of code introduced recently with a new
 'coverage-diff' tool (in contrib/).


* du/cherry-is-plumbing (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-19 at ffe6c5449e)
 + doc: move git-cherry to plumbing

 Doc update to mark "git cherry" as a plumbing command.


* du/get-tar-commit-id-is-plumbing (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at 23e7f018cd)
 + doc: move git-get-tar-commit-id to plumbing

 Doc update to mark "git get-tar-commit-id" as a plumbing command.


* du/rev-parse-is-plumbing (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-16 at 50aca759e2)
 + doc: move git-rev-parse from porcelain to plumbing

 Doc update.


* js/fuzzer (2018-10-15) 2 commits
  (merged to 'next' on 2018-10-19 at 649a2bf1fb)
 + fuzz: add fuzz testing for packfile indices.
 + fuzz: add basic fuzz testing target.

 An experiment to fuzz test a few areas, hopefully we can gain more
 coverage to various areas.


* js/mingw-default-ident (2018-10-16) 3 commits
  (merged to 'next' on 2018-10-19 at 2f710c811b)
 + mingw: use domain information for default email
 + getpwuid(mingw): provide a better default for the user name
 + getpwuid(mingw): initialize the structure only once

 The logic to select the default user name and e-mail on Windows has
 been improved.


* ld/p4-unshelve (2018-10-16) 3 commits
  (merged to 'next' on 2018-10-19 at 35339798f9)
 + git-p4: fully support unshelving changelists
 + git-p4: unshelve into refs/remotes/p4-unshelved, not refs/remotes/p4/unshelved
 + git-p4: do not fail in verbose mode for missing 'fileSize' key

 "git p4 unshelve" improvements.


* ma/t7005-bash-workaround (2018-09-28) 1 commit
  (merged to 'next' on 2018-10-16 at 543e1e6574)
 + t7005-editor: quote filename to fix whitespace-issue

 Test fix.


* mm/doc-no-dashed-git (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-16 at c26bcd740b)
 + doc: fix a typo and clarify a sentence

 Doc update.


* np/log-graph-octopus-fix (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at aa00813683)
 + log: fix coloring of certain octopus merge shapes

 "git log --graph" showing an octopus merge sometimes miscounted the
 number of display columns it is consuming to show the merge and its
 parent commits, which has been corrected.


* rs/subtree-fixes (2018-10-12) 5 commits
  (merged to 'next' on 2018-10-16 at be23c9343c)
 + subtree: performance improvement for finding unexpected parent commits
  (merged to 'next' on 2018-10-12 at 2b47258e04)
 + subtree: improve decision on merges kept in split
 + subtree: use commits before rejoins for splits
 + subtree: make --ignore-joins pay attention to adds
 + subtree: refactor split of a commit into standalone method

 Various subtree fixes.
 Unless somebody objects, that is.


* rv/alias-help (2018-10-11) 3 commits
  (merged to 'next' on 2018-10-19 at f16bbfb3ef)
 + git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
 + git.c: handle_alias: prepend alias info when first argument is -h
 + help: redirect to aliased commands for "git cmd --help"

 "git cmd --help" when "cmd" is aliased used to only say "cmd is
 aliased to ...".  Now it shows that to the standard error stream
 and runs "git $cmd --help" where $cmd is the first word of the
 alias expansion.

 This could be misleading for those who alias a command with options
 (e.g. with "[alias] cpn = cherry-pick -n", "git cpn --help" would
 show the manual of "cherry-pick", and the reader would not be told
 to pay close attention to the part that describes the "--no-commit"
 option until closing the pager that showed the contents of the
 manual, if the pager is configured to restore the original screen,
 or would not be told at all, if the pager simply makes the message
 on the standard error scroll away.


* sb/diff-emit-line-ws-markup-cleanup (2018-10-12) 1 commit
  (merged to 'next' on 2018-10-16 at a68a6f0003)
 + diff.c: pass sign_index to emit_line_ws_markup

 Code clean-up.


* sg/split-index-racefix (2018-10-12) 7 commits
  (merged to 'next' on 2018-10-16 at c1d6563c51)
 + split-index: BUG() when cache entry refers to non-existing shared entry
 + split-index: smudge and add racily clean cache entries to split index
 + split-index: don't compare cached data of entries already marked for split index
 + split-index: count the number of deleted entries
 + t1700-split-index: date back files to avoid racy situations
 + split-index: add tests to demonstrate the racy split index problem
 + t1700-split-index: document why FSMONITOR is disabled in this test script

 The codepath to support the experimental split-index mode had
 remaining "racily clean" issues fixed.

--------------------------------------------------
[New Topics]

* sb/more-repo-in-api (2018-10-19) 19 commits
 - submodule: don't add submodule as odb for push
 - submodule: use submodule repos for object lookup
 - pretty: prepare format_commit_message to handle arbitrary repositories
 - commit: prepare logmsg_reencode to handle arbitrary repositories
 - commit: prepare repo_unuse_commit_buffer to handle arbitrary repositories
 - commit: prepare get_commit_buffer to handle arbitrary repositories
 - commit-reach: prepare in_merge_bases[_many] to handle arbitrary repositories
 - commit-reach: prepare get_merge_bases to handle arbitrary repositories
 - commit-reach.c: allow get_merge_bases_many_0 to handle arbitrary repositories
 - commit-reach.c: allow remove_redundant to handle arbitrary repositories
 - commit-reach.c: allow merge_bases_many to handle arbitrary repositories
 - commit-reach.c: allow paint_down_to_common to handle arbitrary repositories
 - commit: allow parse_commit* to handle arbitrary repositories
 - object: parse_object to honor its repository argument
 - object-store: prepare has_{sha1, object}_file[_with_flags] to handle arbitrary repositories
 - object-store: prepare read_object_file to deal with arbitrary repositories
 - object-store: allow read_object_file_extended to read from arbitrary repositories
 - packfile: allow has_packed_and_bad to handle arbitrary repositories
 - sha1_file: allow read_object to read objects in arbitrary repositories

 The in-core repository instances are passed through more codepaths.

 Not quite correct?
 cf. <20181025091406.GK30222@szeder.dev>


* en/merge-path-collision (2018-10-22) 8 commits
 - merge-recursive: improve rename/rename(1to2)/add[/add] handling
 - merge-recursive: use handle_file_collision for add/add conflicts
 - merge-recursive: improve handling for rename/rename(2to1) conflicts
 - merge-recursive: fix rename/add conflict handling
 - merge-recursive: new function for better colliding conflict resolutions
 - merge-recursive: increase marker length with depth of recursion
 - t6036, t6042: testcases for rename collision of already conflicting files
 - Add testcases for consistency in file collision conflict handling
 (this branch uses en/merge-cleanup-more.)


* jt/tighten-fetch-proto-v2-response (2018-10-22) 2 commits
 - SQUASH???
 - fetch-pack: be more precise in parsing v2 response

 "git fetch" was a bit loose in parsing resposes from the other side
 when talking over the protocol v2.

 Will squash the fix and merge to 'next'.


* nd/complete-format-patch (2018-10-22) 1 commit
 . completion: use __gitcomp_builtin for format-patch

 Expecting a reroll.


* nd/completion-negation (2018-10-22) 1 commit
 - completion: fix __gitcomp_builtin no longer consider extra options

 The command line completion machinery (in contrib/) has been
 updated to allow the completion script to tweak the list of options
 that are reported by the parse-options machinery correctly.

 Will merge to 'next'.


* nd/config-split (2018-10-22) 59 commits
 - config.txt: move worktree.* to a separate file
 - config.txt: move web.* to a separate file
 - config.txt: move versionsort.* to a separate file
 - config.txt: move user.* to a separate file
 - config.txt: move url.* to a separate file
 - config.txt: move uploadpack.* to a separate file
 - config.txt: move uploadarchive.* to a separate file
 - config.txt: move transfer.* to a separate file
 - config.txt: move tag.* to a separate file
 - config.txt: move status.* to a separate file
 - config.txt: move splitIndex.* to a separate file
 - config.txt: move showBranch.* to a separate file
 - config.txt: move sequencer.* to a separate file
 - config.txt: move rerere.* to a separate file
 - config.txt: move repack.* to a separate file
 - config.txt: move remotes.* to a separate file
 - config.txt: move remote.* to a separate file
 - config.txt: move protocol.* to a separate file
 - config.txt: move pretty.* to a separate file
 - config.txt: move pager.* to a separate file
 - config.txt: move pack.* to a separate file
 - config.txt: move notes.* to a separate file
 - config.txt: move mergetool.* to a separate file
 - config.txt: move man.* to a separate file
 - config.txt: move mailmap.* to a separate file
 - config.txt: move mailinfo.* to a separate file
 - config.txt: move log.* to a separate file
 - config.txt: move interactive.* to a separate file
 - config.txt: move instaweb.* to a separate file
 - config.txt: move init.* to a separate file
 - config.txt: move index.* to a separate file
 - config.txt: move i18n.* to a separate file
 - config.txt: move ssh.* to a separate file
 - config.txt: move help.* to a separate file
 - config.txt: move guitool.* to a separate file
 - config.txt: move gpg.* to a separate file
 - config.txt: move grep.* to a separate file
 - config.txt: move gitweb.* to a separate file
 - config.txt: move gc.* to a separate file
 - config.txt: move fsck.* to a separate file
 - config.txt: move filter.* to a separate file
 - config.txt: move fastimport.* to a separate file
 - config.txt: move difftool.* to a separate file
 - config.txt: move completion.* to a separate file
 - config.txt: move credential.* to a separate file
 - config.txt: move commit.* to a separate file
 - config.txt: move column.* to a separate file
 - config.txt: move color.* to a separate file
 - config.txt: move clean.* to a separate file
 - config.txt: move checkout.* to a separate file
 - config.txt: move browser.* to a separate file
 - config.txt: move branch.* to a separate file
 - config.txt: move blame.* to a separate file
 - config.txt: move apply.* to a separate file
 - config.txt: move am.* to a separate file
 - config.txt: move alias.* to a separate file
 - config.txt: move add.* to a separate file
 - config.txt: move core.* to a separate file
 - config.txt: move advice.* to a separate file

 Expecting a reroll.


* nd/per-worktree-config (2018-10-22) 2 commits
 - worktree: add per-worktree config files
 - t1300: extract and use test_cmp_config()

 A fourth class of configuration files (in addition to the
 traditional "system wide", "per user in the $HOME directory" and
 "per repository in the $GIT_DIR/config") has been introduced so
 that different worktrees that share the same repository (hence the
 same $GIT_DIR/config file) can use different customization.

 Will merge to 'next'.


* nd/submodule-unused-vars (2018-10-22) 1 commit
 - submodule.c: remove some of the_repository references

 Code clean-up.

 Will merge to 'next'.


* nd/unpack-trees-with-cache-tree (2018-10-22) 1 commit
 - read-cache: use of memory after it is freed

 Trivial bugfix.

 Will merge to 'next'.


* ag/rev-parse-all-exclude-fix (2018-10-24) 1 commit
 - rev-parse: clear --exclude list after 'git rev-parse --all'


* ah/doc-updates (2018-10-23) 6 commits
  (merged to 'next' on 2018-10-26 at b0bb46a602)
 + doc: fix formatting in git-update-ref
 + doc: fix indentation of listing blocks in gitweb.conf.txt
 + doc: fix descripion for 'git tag --format'
 + doc: fix inappropriate monospace formatting
 + doc: fix ASCII art tab spacing
 + doc: clarify boundaries of 'git worktree list --porcelain'

 Doc updates.

 Will merge to 'master'.


* bp/reset-quiet (2018-10-24) 3 commits
 - reset: warn when refresh_index() takes more than 2 seconds
 - reset: add new reset.quiet config setting
 - reset: don't compute unstaged changes after reset when --quiet

 "git reset --quiet" no longer runs "update-index --refresh"
 internally, which shifts the refresh cost away from the command.

 Will merge to 'next'.
 cf. <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
 We may want its doc further updated.


* cb/compat-mmap-is-private-read-only (2018-10-25) 1 commit
  (merged to 'next' on 2018-10-26 at d3bfab3034)
 + compat: make sure git_mmap is not expected to write

 Code tightening.

 Will merge to 'master'.


* cb/khash-maybe-unused-function (2018-10-24) 2 commits
  (merged to 'next' on 2018-10-26 at 17fc4e55a0)
 + khash: silence -Wunused-function for delta-islands
 + commit-slabs: move MAYBE_UNUSED out

 Build fix.

 Will merge to 'master'.


* dl/mergetool-gui-option (2018-10-25) 3 commits
  (merged to 'next' on 2018-10-26 at 2c46355e81)
 + doc: document diff/merge.guitool config keys
 + completion: support `git mergetool --[no-]gui`
 + mergetool: accept -g/--[no-]gui as arguments

 "git mergetool" learned to take the "--[no-]gui" option, just like
 "git difftool" does.

 Will merge to 'master'.


* ds/reachable (2018-10-23) 1 commit
  (merged to 'next' on 2018-10-26 at 76b5fc9a46)
 + commit-reach: fix cast in compare_commits_by_gen()

 Trivial bugfix.

 Will merge to 'master'.


* jc/cocci-preincr (2018-10-24) 2 commits
  (merged to 'next' on 2018-10-26 at cbd98b44e2)
 + fsck: s/++i > 1/i++/
 + cocci: simplify "if (++u > 1)" to "if (u++)"

 Code cleanup.

 Will merge to 'master'.


* jk/run-command-notdot (2018-10-25) 2 commits
  (merged to 'next' on 2018-10-26 at 9d9335b23f)
 + t0061: adjust to test-tool transition
 + run-command: mark path lookup errors with ENOENT

 The implementation of run_command() API on the UNIX platforms had a
 bug that caused a command not on $PATH to be found in the current
 directory.

 Will merge to 'master'.


* js/ming-ns-filetime (2018-10-24) 3 commits
 - mingw: implement nanosecond-precision file times
 - mingw: replace MSVCRT's fstat() with a Win32-based implementation
 - mingw: factor out code to set stat() data

 Windows port learned to use nano-second resolution file timestamps.

 Will merge to 'next'.


* js/mingw-getcwd (2018-10-24) 2 commits
  (merged to 'next' on 2018-10-26 at f31abc8d8f)
 + mingw: fix getcwd when the parent directory cannot be queried
 + mingw: ensure `getcwd()` reports the correct case

 The way the Windows port figures out the current directory has been
 improved.

 Will merge to 'master'.


* js/mingw-load-sys-dll (2018-10-24) 1 commit
  (merged to 'next' on 2018-10-26 at 1f458a7e04)
 + mingw: load system libraries the recommended way

 The way DLLs are loaded on the Windows port has been improved.

 Will merge to 'master'.


* js/rebase-autostash-fix (2018-10-24) 5 commits
 - rebase --autostash: fix issue with dirty submodules
 - rebase --autostash: demonstrate a problem with dirty submodules
 - rebase (autostash): use an explicit OID to apply the stash
 - rebase (autostash): store the full OID in <state-dir>/autostash
 - rebase (autostash): avoid duplicate call to state_dir_path()
 (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; is tangled with ag/sequencer-reduce-rewriting-todo, jc/rebase-in-c-5-test-typofix, js/rebase-i-break and js/rebase-i-shortopt.)

 "git rebase" that has recently been rewritten in C had a few issues
 in its "--autstash" feature, which have been corrected.

 Will merge to 'next'.


* js/remote-archive-dwimfix (2018-10-26) 1 commit
  (merged to 'next' on 2018-10-26 at f5bf6946bd)
 + archive: initialize archivers earlier

 The logic to determine the archive type "git archive" uses did not
 correctly kick in for "git archive --remote", which has been
 corrected.

 Will merge to 'master'.


* js/shallow-and-fetch-prune (2018-10-25) 3 commits
  (merged to 'next' on 2018-10-26 at 93b7196560)
 + repack -ad: prune the list of shallow commits
 + shallow: offer to prune only non-existing entries
 + repack: point out a bug handling stale shallow info

 "git repack" in a shallow clone did not correctly update the
 shallow points in the repository, leading to a repository that
 does not pass fsck.

 Will merge to 'master'.


* jw/send-email-no-auth (2018-10-23) 1 commit
 - send-email: explicitly disable authentication

 "git send-email" learned to disable SMTP authentication via the
 "--smtp-auth=none" option, even when the smtp username is given
 (which turns the authentication on by default).

 Will merge to 'next'.


* md/exclude-promisor-objects-fix (2018-10-23) 2 commits
 - exclude-promisor-objects: declare when option is allowed
 - Documentation/git-log.txt: do not show --exclude-promisor-objects

 Operations on promisor objects make sense in the context of only a
 small subset of the commands that internally use the revisions
 machinery, but the "--exclude-promisor-objects" option were taken
 and led to nonsense results by commands like "log", to which it
 didn't make much sense.  This has been corrected.

 Will merge to 'next'.


* mg/gpg-fingerprint (2018-10-23) 3 commits
  (merged to 'next' on 2018-10-26 at 1e219cb754)
 + gpg-interface.c: obtain primary key fingerprint as well
 + gpg-interface.c: support getting key fingerprint via %GF format
 + gpg-interface.c: use flags to determine key/signer info presence
 (this branch uses mg/gpg-parse-tighten; is tangled with jc/gpg-cocci-preincr.)

 New "--pretty=format:" placeholders %GF and %GP that show the GPG
 key fingerprints have been invented.

 Will merge to 'master'.


* ss/rename-tests (2018-10-23) 5 commits
  (merged to 'next' on 2018-10-26 at e4929c2ece)
 + t7501: rename commit test to comply with naming convention
 + t7500: rename commit tests script to comply with naming convention
 + t7502: rename commit test script to comply with naming convention
 + t7509: cleanup description and filename
 + t2000: rename and combine checkout clash tests

 Reorganize some tests and rename them; "ls t/" now gives a better
 overview of what is tested for these scripts than before.

 Will merge to 'master'.


* tb/filter-alternate-refs (2018-10-25) 2 commits
  (merged to 'next' on 2018-10-26 at 887a7779a3)
 + t5410: use longer path for sample script
 + Documentation/config.txt: fix typo in core.alternateRefsCommand

 Test fix.

 Will merge to 'master'.


* jc/http-curlver-warnings (2018-10-26) 1 commit
  (merged to 'next' on 2018-10-26 at 870e125cec)
 + http: give curl version warnings consistently
 (this branch uses js/mingw-http-ssl.)

 Warning message fix.

 Will merge to 'master'.


* jk/uploadpack-packobjectshook-fix (2018-10-26) 1 commit
  (merged to 'next' on 2018-10-26 at 95c93b1199)
 + upload-pack: fix broken if/else chain in config callback

 Code clean-up that results in a small bugfix.

 Will merge to 'master'.


* sd/stash-wo-user-name (2018-10-26) 1 commit
 - t3903-stash: test without configured user name

 An early part of a wip.


* uk/merge-subtree-doc-update (2018-10-25) 1 commit
  (merged to 'next' on 2018-10-26 at 7ab4fc8ab1)
 + howto/using-merge-subtree: mention --allow-unrelated-histories

 Belated documentation update to adjust to a new world order that
 happened a yew years ago.

 Will merge to 'master'.


* js/rebase-i-shortopt (2018-10-26) 1 commit
 - rebase -i: recognize short commands without arguments
 (this branch uses ag/rebase-i-in-c and js/rebase-i-break; is tangled with ag/sequencer-reduce-rewriting-todo, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)


* sg/test-rebase-editor-fix (2018-10-26) 1 commit
 - t3404-rebase-interactive: test abbreviated commands


* ss/travis-ci-force-vm-mode (2018-10-26) 1 commit
 - travis-ci: no longer use containers


* tb/char-may-be-unsigned (2018-10-26) 1 commit
 - path.c: char is not (always) signed

--------------------------------------------------
[Stalled]

* lt/date-human (2018-07-09) 1 commit
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.

--------------------------------------------------
[Cooking]

* ab/reject-alias-loop (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at bc213f1bef)
 + alias: detect loops in mixed execution mode

 Two (or more) aliases that mutually refer to each other can form an
 infinite loop; we now attempt to notice and stop.

 Will merge to 'master'.


* cb/remove-dead-init (2018-10-19) 2 commits
  (merged to 'next' on 2018-10-26 at ba725a64ad)
 + multi-pack-index: avoid dead store for struct progress
 + unpack-trees: avoid dead store for struct progress

 Code clean-up.

 Will merge to 'master'.


* ds/ci-commit-graph-and-midx (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at a13664e49a)
 + ci: add optional test variables

 One of our CI tests to run with "unusual/experimental/random"
 settings now also uses commit-graph and midx.

 Will merge to 'master'.


* ds/reachable-first-parent-fix (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at 076442d512)
 + commit-reach: fix first-parent heuristic

 Correct performance regression in commit ancestry computation when
 generation numbers are involved.

 Will merge to 'master'.


* jk/test-tool-help (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-26 at ed32bae21b)
 + test-tool: show tool list on error

 Developer support.

 Will merge to 'master'.


* jk/unused-function (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at c8c3fbb432)
 + config.mak.dev: enable -Wunused-function

 Developer support.

 Will merge to 'master'.


* js/diff-notice-has-drive-prefix (2018-10-22) 1 commit
  (merged to 'next' on 2018-10-26 at 6b2d004194)
 + diff: don't attempt to strip prefix from absolute Windows paths

 Under certain circumstances, "git diff D:/a/b/c D:/a/b/d" on
 Windows would strip initial parts from the paths because they
 were not recognized as absolute, which has been corrected.

 Will merge to 'master'.


* js/pack-objects-mutex-init-fix (2018-10-19) 3 commits
  (merged to 'next' on 2018-10-26 at 7516dcc6e4)
 + pack-objects (mingw): initialize `packing_data` mutex in the correct spot
 + pack-objects (mingw): demonstrate a segmentation fault with large deltas
 + pack-objects: fix typo 'detla' -> 'delta'

 A mutex used in "git pack-objects" were not correctly initialized
 and this caused "git repack" to dump core on Windows.

 Will merge to 'master'.


* jt/upload-pack-v2-fix-shallow (2018-10-19) 3 commits
 - upload-pack: clear flags before each v2 request
 - upload-pack: make want_obj not global
 - upload-pack: make have_obj not global

 "git fetch" over protocol v2 into a shallow repository failed to
 fetch full history behind a new tip of history that was diverged
 before the cut-off point of the history that was previously fetched
 shallowly.

 Will merge to 'next'.


* pw/am-rebase-read-author-script (2018-10-19) 5 commits
 - sequencer: use read_author_script()
 - add read_author_script() to libgit
 - am: rename read_author_script()
 - am: improve author-script error reporting
 - am: don't die in read_author_script()


* rj/header-guards (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-26 at c767be34df)
 + headers: normalize the spelling of some header guards

 Code clean-up.

 Will merge to 'master'.


* sb/submodule-helper-remove-cruft (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-26 at 5719bc5d7e)
 + builtin/submodule--helper: remove debugging leftover tracing

 Code clean-up.

 Will merge to 'master'.


* sb/submodule-url-to-absolute (2018-10-18) 1 commit
 - submodule helper: convert relative URL to absolute URL if needed

 Some codepaths failed to form a proper URL when .gitmodules record
 the URL to a submodule repository as relative to the repository of
 superproject, which has been corrected.

 Will merge to 'next'.


* sg/doc-show-branch-typofix (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-26 at 9444be6a99)
 + doc: fix small typo in git show-branch

 Docfix.

 Will merge to 'master'.


* tq/branch-create-wo-branch-get (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-26 at fe522704b7)
 + builtin/branch.c: remove useless branch_get

 Code clean-up.

 Will merge to 'master'.


* tq/branch-style-fix (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-26 at 6e79291d55)
 + branch: trivial style fix

 Code clean-up.

 Will merge to 'master'.


* jc/receive-deny-current-branch-fix (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at 2975c42215)
 + receive: denyCurrentBranch=updateinstead should not blindly update

 The receive.denyCurrentBranch=updateInstead codepath kicked in even
 when the push should have been rejected due to other reasons, such
 as it does not fast-forward or the update-hook rejects it, which
 has been corrected.

 Will merge to 'master'.


* en/merge-cleanup-more (2018-10-18) 2 commits
  (merged to 'next' on 2018-10-26 at c706319c26)
 + merge-recursive: avoid showing conflicts with merge branch before HEAD
 + merge-recursive: improve auto-merging messages with path collisions
 (this branch is used by en/merge-path-collision.)

 Further clean-up of merge-recursive machinery.

 Will merge to 'master'.


* mg/gpg-parse-tighten (2018-10-22) 1 commit
  (merged to 'next' on 2018-10-26 at efdec77193)
 + gpg-interface.c: detect and reject multiple signatures on commits
 (this branch is used by jc/gpg-cocci-preincr and mg/gpg-fingerprint.)

 Detect and reject a signature block that has more than one GPG
 signature.

 Will merge to 'master'.


* bc/sha-256 (2018-10-25) 12 commits
 - hash: add an SHA-256 implementation using OpenSSL
 - sha256: add an SHA-256 implementation using libgcrypt
 - Add a base implementation of SHA-256 support
 - commit-graph: convert to using the_hash_algo
 - t/helper: add a test helper to compute hash speed
 - sha1-file: add a constant for hash block size
 - t: make the sha1 test-tool helper generic
 - t: add basic tests for our SHA-1 implementation
 - cache: make hashcmp and hasheq work with larger hashes
 - hex: introduce functions to print arbitrary hashes
 - sha1-file: provide functions to look up hash algorithms
 - sha1-file: rename algorithm to "sha1"

 Add sha-256 hash and plug it through the code to allow building Git
 with the "NewHash".


* js/mingw-http-ssl (2018-10-26) 3 commits
  (merged to 'next' on 2018-10-26 at 318e82e101)
 + http: when using Secure Channel, ignore sslCAInfo by default
 + http: add support for disabling SSL revocation checks in cURL
 + http: add support for selecting SSL backends at runtime
 (this branch is used by jc/http-curlver-warnings.)

 On Windows with recent enough cURL library, the configuration
 variable http.sslBackend can be used to choose between OpenSSL and
 Secure Channel at runtime as the SSL backend while talking over
 the HTTPS protocol.

 Will merge to 'master'.


* js/vsts-ci (2018-10-16) 13 commits
 - travis: fix skipping tagged releases
 - README: add a build badge (status of the Azure Pipelines build)
 - tests: record more stderr with --write-junit-xml in case of failure
 - tests: include detailed trace logs with --write-junit-xml upon failure
 - git-p4: use `test_atexit` to kill the daemon
 - git-daemon: use `test_atexit` in the tests
 - tests: introduce `test_atexit`
 - ci: add a build definition for Azure DevOps
 - ci/lib.sh: add support for Azure Pipelines
 - tests: optionally write results as JUnit-style .xml
 - test-date: add a subcommand to measure times in shell scripts
 - ci/lib.sh: encapsulate Travis-specific things
 - ci: rename the library of common functions

 Prepare to run test suite on Azure DevOps.

 On hold, monitoring the discussion.
 cf. <nycvar.QRO.7.76.6.1810151657080.4546@tvgsbejvaqbjf.bet>


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 On hold, monitoring the discussion.
 cf. <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>


* ot/ref-filter-plug-leaks (2018-10-19) 3 commits
  (merged to 'next' on 2018-10-26 at a475cb6568)
 + ref-filter: free item->value and item->value->s
 + ls-remote: release memory instead of UNLEAK
 + ref-filter: free memory from used_atom

 Plugging a handful of memory leaks in the ref-filter codepath.

 Will merge to 'master'.


* rv/send-email-cc-misc-by (2018-10-16) 3 commits
  (merged to 'next' on 2018-10-19 at 2c1e5f75af)
 + send-email: also pick up cc addresses from -by trailers
 + send-email: only consider lines containing @ or <> for automatic Cc'ing
 + Documentation/git-send-email.txt: style fixes

 "git send-email" learned to grab address-looking string on any
 trailer whose name ends with "-by"; --suppress-cc=misc-by on the
 command line, or setting sendemail.suppresscc configuration
 variable to "misc-by", can be used to disable this behaviour.

 This is a backward-incompatible change that may surprise existing
 users.

 Will merge to 'master'.


* lm/range-diff-submodule-fix (2018-10-25) 1 commit
  (merged to 'next' on 2018-10-25 at af387d8978)
 + range-diff: allow to diff files regardless of submodule config

 "git range-diff" did not work well when the compared ranges had
 changes in submodules and the "--submodule=log" was used.

 Will merge to 'master'.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* jc/rebase-in-c-5-test-typofix (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-19 at 08c9d86ffd)
 + rebase: fix typoes in error messages
 (this branch uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Typofix.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* jc/war-on-string-list (2018-10-19) 1 commit
 - fetch: replace string-list used as a look-up table with a hashmap

 Replace three string-list instances used as look-up tables in "git
 fetch" with hashmaps.


* js/rebase-i-break (2018-10-12) 2 commits
  (merged to 'next' on 2018-10-19 at 6db9b14495)
 + rebase -i: introduce the 'break' command
 + rebase -i: clarify what happens on a failed `exec`
 (this branch is used by js/rebase-i-shortopt; uses ag/rebase-i-in-c; is tangled with ag/sequencer-reduce-rewriting-todo, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 "git rebase -i" learned a new insn, 'break', that the user can
 insert in the to-do list.  Upon hitting it, the command returns
 control back to the user.

 Will merge to 'master' after 'pk/rebase-in-c-6-final'.


* js/remote-archive-v2 (2018-09-28) 4 commits
  (merged to 'next' on 2018-10-12 at 5f34377f60)
 + archive: allow archive over HTTP(S) with proto v2
 + archive: implement protocol v2 archive command
 + archive: use packet_reader for communications
 + archive: follow test standards around assertions

 The original implementation of "git archive --remote" more or less
 bypassed the transport layer and did not work over http(s).  The
 version 2 of the protocol is defined to allow going over http(s) as
 well as Git native transport.

 Will hold.
 cf. <20181016212008.GA249669@google.com>
 Breaks interoperability.


* sb/strbuf-h-update (2018-09-29) 1 commit
  (merged to 'next' on 2018-10-26 at e4ad935cb0)
 + strbuf.h: format according to coding guidelines

 Code clean-up to serve as a BCP example.

 Will merge to 'master'.
 Further clean-up patches may need to follow soon before this
 change escapes to 'master'.


* ag/sequencer-reduce-rewriting-todo (2018-10-09) 16 commits
 - rebase--interactive: move transform_todo_file() to rebase--interactive.c
 - sequencer: fix a call to error() in transform_todo_file()
 - sequencer: use edit_todo_list() in complete_action()
 - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 - rebase-interactive: append_todo_help() changes
 - rebase-interactive: use todo_list_transform() in edit_todo_list()
 - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 - sequencer: change complete_action() to use the refactored functions
 - sequencer: make sequencer_make_script() write its script to a strbuf
 - sequencer: refactor transform_todos() to work on a todo_list
 - sequencer: refactor rearrange_squash() to work on a todo_list
 - sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 - sequencer: refactor check_todo_list() to work on a todo_list
 - sequencer: make the todo_list structure public
 - sequencer: clear the number of items of a todo_list before parsing
 - Merge branch 'ag/rebase-i-in-c' into ag/sequencer-reduce-rewriting-todo
 (this branch uses ag/rebase-i-in-c; is tangled with js/rebase-autostash-fix, js/rebase-i-break, js/rebase-i-shortopt, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 Will hold, waiting for the "rebase-in-c" and "rebase-i-in-c" topics.


* bc/hash-transition-part-15 (2018-10-15) 15 commits
  (merged to 'next' on 2018-10-26 at 4ff8111b4b)
 + rerere: convert to use the_hash_algo
 + submodule: make zero-oid comparison hash function agnostic
 + apply: rename new_sha1_prefix and old_sha1_prefix
 + apply: replace hard-coded constants
 + tag: express constant in terms of the_hash_algo
 + transport: use parse_oid_hex instead of a constant
 + upload-pack: express constants in terms of the_hash_algo
 + refs/packed-backend: express constants using the_hash_algo
 + packfile: express constants in terms of the_hash_algo
 + pack-revindex: express constants in terms of the_hash_algo
 + builtin/fetch-pack: remove constants with parse_oid_hex
 + builtin/mktree: remove hard-coded constant
 + builtin/repack: replace hard-coded constants
 + pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
 + object_id.cocci: match only expressions of type 'struct object_id'

 More codepaths are moving away from hardcoded hash sizes.

 Will merge to 'master'.


* ch/subtree-build (2018-10-18) 3 commits
  (merged to 'next' on 2018-10-18 at f89fd5e6aa)
 + Revert "subtree: make install targets depend on build targets"
  (merged to 'next' on 2018-10-16 at 919599cc37)
 + subtree: make install targets depend on build targets
  (merged to 'next' on 2018-10-12 at 4ed9ff6300)
 + subtree: add build targets 'man' and 'html'

 Build update for "git subtree" (in contrib/) documentation pages.

 Will merge to 'master'.


* ds/test-multi-pack-index (2018-10-26) 4 commits
 - packfile: close multi-pack-index in close_all_packs
 - multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
 - midx: close multi-pack-index on repack
 - midx: fix broken free() in close_midx()

 Tests for the recently introduced multi-pack index machinery.


* nd/per-worktree-ref-iteration (2018-10-22) 8 commits
 - reflog expire: cover reflog from all worktrees
 - fsck: check HEAD and reflog from other worktrees
 - fsck: move fsck_head_link() to get_default_heads() to avoid some globals
 - revision.c: better error reporting on ref from different worktrees
 - revision.c: correct a parameter name
 - refs: new ref types to make per-worktree refs visible to all worktrees
 - Add a place for (not) sharing stuff between worktrees
 - refs.c: indent with tabs, not spaces


* ds/reachable-topo-order (2018-10-18) 7 commits
 - t6012: make rev-list tests more interesting
 - revision.c: generation-based topo-order algorithm
 - commit/revisions: bookkeeping before refactoring
 - revision.c: begin refactoring --topo-order logic
 - test-reach: add rev-list tests
 - test-reach: add run_three_modes method
 - prio-queue: add 'peek' operation

 The revision walker machinery learned to take advantage of the
 commit generation numbers stored in the commit-graph file.

 cf. <pull.25.v4.git.gitgitgadget@gmail.com>


* sb/submodule-recursive-fetch-gets-the-tip (2018-10-26) 11 commits
 - builtin/fetch: check for submodule updates in any ref update
 - fetch: try fetching submodules if needed objects were not fetched
 - submodule.c: fetch in submodules git directory instead of in worktree
 - submodule: migrate get_next_submodule to use repository structs
 - repository: repo_submodule_init to take a submodule struct
 - submodule: store OIDs in changed_submodule_names
 - submodule.c: tighten scope of changed_submodule_names struct
 - submodule.c: sort changed_submodule_names before searching it
 - submodule.c: fix indentation
 - sha1-array: provide oid_array_filter
 - Merge branch 'ao/submodule-wo-gitmodules-checked-out' into sb/submodule-recursive-fetch-gets-the-tip
 (this branch uses ao/submodule-wo-gitmodules-checked-out.)

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.


* js/rebase-in-c-5.5-work-with-rebase-i-in-c (2018-10-11) 2 commits
  (merged to 'next' on 2018-10-19 at b734d81006)
 + builtin rebase: prepare for builtin rebase -i
 + Merge branch 'ag/rebase-i-in-c' into js/rebase-in-c-5.5-work-with-rebase-i-in-c
 (this branch is used by js/rebase-autostash-fix and pk/rebase-in-c-6-final; uses ag/rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-reduce-rewriting-todo, jc/rebase-in-c-5-test-typofix, js/rebase-i-break and js/rebase-i-shortopt.)

 "rebase" that has been rewritten learns the new calling convention
 used by "rebase -i" that was rewritten in C, tying the loose end
 between two GSoC topics that stomped on each other's toes.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ao/submodule-wo-gitmodules-checked-out (2018-10-26) 10 commits
 - t/helper: add test-submodule-nested-repo-config
 - submodule: support reading .gitmodules when it's not in the working tree
 - submodule: add a helper to check if it is safe to write to .gitmodules
 - t7506: clean up .gitmodules properly before setting up new scenario
 - submodule: use the 'submodule--helper config' command
 - submodule--helper: add a new 'config' subcommand
 - t7411: be nicer to future tests and really clean things up
 - t7411: merge tests 5 and 6
 - submodule: factor out a config_set_in_gitmodules_file_gently function
 - submodule: add a print_config_from_gitmodules() helper
 (this branch is used by sb/submodule-recursive-fetch-gets-the-tip.)

 The submodule support has been updated to read from the blob at
 HEAD:.gitmodules when the .gitmodules file is missing from the
 working tree.

 Expecting a reroll.
 cf. <20181010205645.e1529eff9099805029b1d6ef@ao2.it>


* md/filter-trees (2018-10-18) 10 commits
  (merged to 'next' on 2018-10-18 at 55be2fded9)
 + list-objects: support for skipping tree traversal
  (merged to 'next' on 2018-10-16 at 64d351d342)
 + filter-trees: code clean-up of tests
  (merged to 'next' on 2018-10-12 at c66e49d4ca)
 + list-objects-filter: implement filter tree:0
 + list-objects-filter-options: do not over-strbuf_init
 + list-objects-filter: use BUG rather than die
 + revision: mark non-user-given objects instead
 + rev-list: handle missing tree objects properly
 + list-objects: always parse trees gently
 + list-objects: refactor to process_tree_contents
 + list-objects: store common func args in struct

 The "rev-list --filter" feature learned to exclude all trees via
 "tree:0" filter.

 Will merge to 'master'.


* pk/rebase-in-c-2-basic (2018-09-06) 11 commits
  (merged to 'next' on 2018-10-19 at c2a0046e52)
 + builtin rebase: support `git rebase <upstream> <switch-to>`
 + builtin rebase: only store fully-qualified refs in `options.head_name`
 + builtin rebase: start a new rebase only if none is in progress
 + builtin rebase: support --force-rebase
 + builtin rebase: try to fast forward when possible
 + builtin rebase: require a clean worktree
 + builtin rebase: support the `verbose` and `diffstat` options
 + builtin rebase: support --quiet
 + builtin rebase: handle the pre-rebase hook and --no-verify
 + builtin rebase: support `git rebase --onto A...B`
 + builtin rebase: support --onto
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c.)

 Rewrite "git rebase" in C.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-3-acts (2018-09-06) 7 commits
  (merged to 'next' on 2018-10-19 at 9275677430)
 + builtin rebase: stop if `git am` is in progress
 + builtin rebase: actions require a rebase in progress
 + builtin rebase: support --edit-todo and --show-current-patch
 + builtin rebase: support --quit
 + builtin rebase: support --abort
 + builtin rebase: support --skip
 + builtin rebase: support --continue
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c and pk/rebase-in-c-2-basic.)

 Rewrite "git rebase" in C.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-4-opts (2018-10-11) 18 commits
  (merged to 'next' on 2018-10-19 at 2770b2f5d5)
 + builtin rebase: support --root
 + builtin rebase: add support for custom merge strategies
 + builtin rebase: support `fork-point` option
 + merge-base --fork-point: extract libified function
 + builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
 + builtin rebase: support `--allow-empty-message` option
 + builtin rebase: support `--exec`
 + builtin rebase: support `--autostash` option
 + builtin rebase: support `-C` and `--whitespace=<type>`
 + builtin rebase: support `--gpg-sign` option
 + builtin rebase: support `--autosquash`
 + builtin rebase: support `keep-empty` option
 + builtin rebase: support `ignore-date` option
 + builtin rebase: support `ignore-whitespace` option
 + builtin rebase: support --committer-date-is-author-date
 + builtin rebase: support --rerere-autoupdate
 + builtin rebase: support --signoff
 + builtin rebase: allow selecting the rebase "backend"
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic and pk/rebase-in-c-3-acts.)

 Rewrite "git rebase" in C.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-5-test (2018-10-11) 6 commits
  (merged to 'next' on 2018-10-19 at 0e48bc8243)
 + builtin rebase: error out on incompatible option/mode combinations
 + builtin rebase: use no-op editor when interactive is "implied"
 + builtin rebase: show progress when connected to a terminal
 + builtin rebase: fast-forward to onto if it is a proper descendant
 + builtin rebase: optionally pass custom reflogs to reset_head()
 + builtin rebase: optionally auto-detect the upstream
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final; uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts and pk/rebase-in-c-4-opts.)

 Rewrite "git rebase" in C.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c-6-final (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-19 at 52f1dadf69)
 + rebase: default to using the builtin rebase
 (this branch is used by js/rebase-autostash-fix; uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-reduce-rewriting-todo, jc/rebase-in-c-5-test-typofix, js/rebase-i-break and js/rebase-i-shortopt.)

 The final step of rewriting "rebase -i" in C.

 Will merge to 'master'.


* ps/stash-in-c (2018-10-15) 21 commits
 - stash: replace all `write-tree` child processes with API calls
 - stash: optimize `get_untracked_files()` and `check_changes()`
 - stash: convert `stash--helper.c` into `stash.c`
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
 - strbuf.c: add `strbuf_join_argv()`
 - sha1-name.c: add `get_oidf()` which acts like `get_oid()`

 "git stash" rewritten in C.

 Almost there.
 cf. <20181015221040.GD4883@hank.intra.tgummerer.com>


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


* ag/rebase-i-in-c (2018-10-09) 20 commits
  (merged to 'next' on 2018-10-19 at 1b24712d46)
 + rebase -i: move rebase--helper modes to rebase--interactive
 + rebase -i: remove git-rebase--interactive.sh
 + rebase--interactive2: rewrite the submodes of interactive rebase in C
 + rebase -i: implement the main part of interactive rebase as a builtin
 + rebase -i: rewrite init_basic_state() in C
 + rebase -i: rewrite write_basic_state() in C
 + rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
 + rebase -i: implement the logic to initialize $revisions in C
 + rebase -i: remove unused modes and functions
 + rebase -i: rewrite complete_action() in C
 + t3404: todo list with commented-out commands only aborts
 + sequencer: change the way skip_unnecessary_picks() returns its result
 + sequencer: refactor append_todo_help() to write its message to a buffer
 + rebase -i: rewrite checkout_onto() in C
 + rebase -i: rewrite setup_reflog_action() in C
 + sequencer: add a new function to silence a command, except if it fails
 + rebase -i: rewrite the edit-todo functionality in C
 + editor: add a function to launch the sequence editor
 + rebase -i: rewrite append_todo_help() in C
 + sequencer: make three functions and an enum from sequencer.c public
 (this branch is used by ag/sequencer-reduce-rewriting-todo, js/rebase-autostash-fix, js/rebase-i-break, js/rebase-i-shortopt, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Rewrite of the remaining "rebase -i" machinery in C.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.


* pk/rebase-in-c (2018-08-06) 3 commits
  (merged to 'next' on 2018-10-19 at 26c29ace53)
 + builtin/rebase: support running "git rebase <upstream>"
 + rebase: refactor common shell functions into their own file
 + rebase: start implementing it as a builtin
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 Rewrite of the "rebase" machinery in C.

 Will merge to 'master' together with pk/rebase-i-in-c-6-final.
