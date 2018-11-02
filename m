Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34CA1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 05:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeKBOQt (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:16:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41564 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeKBOQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:16:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so668359wrw.8
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=O+zHLDmA8Jl26Vyr0khjpSBzHNwLVK58KxxceQtm5Vw=;
        b=mRB/CGx/RALkLz9tIU/i1cwVaz4xpkHLr1k0QLaYpMmv9QlYqwz6HuNdwLm3KxqAZ6
         X+acC/ZfmfN8NMTAS1aiYlI65lJGBHsSPvFWgKJKFDIW+XMX0J3mXeUrBN7HA3b/zo9y
         G+bjK63vfP9AthdgBHcIcqtyyPy7fbmnNqDF0BEq1kBJWXkRv1BemnEoJrolVFArmEJ7
         kO6dFjY9Q0qd4nVYlq8KZ4PHm3B1coqXa8Y5XN/Dw9h+XHn3B4UpUzF3pbf1s+g8AIcP
         fL1u1bA5r/EIpsfdnikjh94k/zw3YU0Hx86scyAOc8uQef+KiiuEg/82sv/fyFt88Tad
         AFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=O+zHLDmA8Jl26Vyr0khjpSBzHNwLVK58KxxceQtm5Vw=;
        b=t/PvQHuBenGXlh/NZAd749GcUDPcp61FdtYSlgqNs1C78bwxysGuTzfSoLNQgqoW3P
         2V4yxZhfBQvUgPRNmzo79SigU/xrPjHMDpBGnvqwxm6XnhQn1KUu4coUA/bi0T705yqG
         QWESIsaXbvshnygIoN38qNYjgYFriLYmhM9e8qh1HfxKUlEHiKWhjDIJrGuSdOU0OCwC
         kxFBGx1guv2617slqwdZnWCdgmHuYlN95DShw9q27MidKMirdZjIzlhiPy0sLSGHQBF0
         40a4IFs7EovzQ8N8XAVHIdsqCaEgAlNa8oF+/eHnDFAarDomNVH+KdTQL//E0JMKumjH
         FeWw==
X-Gm-Message-State: AGRZ1gJu5h6SyWLIHhhqM1J4DzFJQFT2TZ0tOjPZE4EJeD1DnXya7mNo
        ua1LlYlpg2hsVzUvw960aGxmPNuwHTY=
X-Google-Smtp-Source: AJdET5f0IykJ9ogBwptTtEGdQhowYsVVXPI/qGdCSxxeT6V742ze8m7hmv2A9b2AJOAIsRQTQ38siQ==
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr8949717wrq.294.1541135453365;
        Thu, 01 Nov 2018 22:10:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 4-v6sm28776852wrk.52.2018.11.01.22.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 22:10:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2018, #02; Fri, 2)
X-master-at: d582ea202b626dcc6c3b01e1e11a296d9badd730
X-next-at: 96ac06677ac950c97d331f0ef4892125027eff39
Date:   Fri, 02 Nov 2018 14:10:51 +0900
Message-ID: <xmqq1s84qd2c.fsf@gitster-ct.c.googlers.com>
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

The eighth batch is all about "rebase and rebase-i in C" ;-)

The disruptive "let's split up the Documentation/config.txt file"
topic will enter 'next' soon, and I expect I'd be slow while it
skips over various topics in flight that changes the source it
touches, as they would produce conflicts with different shape and
won't be helped by rerere.  Let's merge it down quickly.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

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
 (this branch is used by ag/sequencer-reduce-rewriting-todo, cb/printf-empty-format, js/rebase-autostash-fix, js/rebase-i-break, js/rebase-i-shortopt, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Rewrite of the remaining "rebase -i" machinery in C.


* cb/printf-empty-format (2018-10-27) 1 commit
  (merged to 'next' on 2018-11-01 at 9fcb05f22c)
 + sequencer: cleanup for gcc warning in non developer mode
 (this branch uses ag/rebase-i-in-c; is tangled with ag/sequencer-reduce-rewriting-todo, js/rebase-autostash-fix, js/rebase-i-break, js/rebase-i-shortopt, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Build fix for a topic in flight.


* jc/rebase-in-c-5-test-typofix (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-19 at 08c9d86ffd)
 + rebase: fix typoes in error messages
 (this branch uses pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 Typofix.


* js/rebase-autostash-fix (2018-10-24) 5 commits
  (merged to 'next' on 2018-10-29 at 680e648001)
 + rebase --autostash: fix issue with dirty submodules
 + rebase --autostash: demonstrate a problem with dirty submodules
 + rebase (autostash): use an explicit OID to apply the stash
 + rebase (autostash): store the full OID in <state-dir>/autostash
 + rebase (autostash): avoid duplicate call to state_dir_path()
 (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final; is tangled with ag/sequencer-reduce-rewriting-todo, cb/printf-empty-format, jc/rebase-in-c-5-test-typofix, js/rebase-i-break and js/rebase-i-shortopt.)

 "git rebase" that has recently been rewritten in C had a few issues
 in its "--autstash" feature, which have been corrected.


* js/rebase-i-break (2018-10-12) 2 commits
  (merged to 'next' on 2018-10-19 at 6db9b14495)
 + rebase -i: introduce the 'break' command
 + rebase -i: clarify what happens on a failed `exec`
 (this branch is used by js/rebase-i-shortopt; uses ag/rebase-i-in-c; is tangled with ag/sequencer-reduce-rewriting-todo, cb/printf-empty-format, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 "git rebase -i" learned a new insn, 'break', that the user can
 insert in the to-do list.  Upon hitting it, the command returns
 control back to the user.


* js/rebase-i-shortopt (2018-10-26) 1 commit
  (merged to 'next' on 2018-11-01 at 4e9da19145)
 + rebase -i: recognize short commands without arguments
 (this branch uses ag/rebase-i-in-c and js/rebase-i-break; is tangled with ag/sequencer-reduce-rewriting-todo, cb/printf-empty-format, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c and pk/rebase-in-c-6-final.)

 "git rebase -i" learned to take 'b' as the short form of 'break'
 option in the todo list.


* js/rebase-in-c-5.5-work-with-rebase-i-in-c (2018-10-11) 2 commits
  (merged to 'next' on 2018-10-19 at b734d81006)
 + builtin rebase: prepare for builtin rebase -i
 + Merge branch 'ag/rebase-i-in-c' into js/rebase-in-c-5.5-work-with-rebase-i-in-c
 (this branch is used by js/rebase-autostash-fix and pk/rebase-in-c-6-final; uses ag/rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-reduce-rewriting-todo, cb/printf-empty-format, jc/rebase-in-c-5-test-typofix, js/rebase-i-break and js/rebase-i-shortopt.)

 "rebase" that has been rewritten learns the new calling convention
 used by "rebase -i" that was rewritten in C, tying the loose end
 between two GSoC topics that stomped on each other's toes.


* pk/rebase-in-c (2018-08-06) 3 commits
  (merged to 'next' on 2018-10-19 at 26c29ace53)
 + builtin/rebase: support running "git rebase <upstream>"
 + rebase: refactor common shell functions into their own file
 + rebase: start implementing it as a builtin
 (this branch is used by jc/rebase-in-c-5-test-typofix, js/rebase-autostash-fix, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

 Rewrite of the "rebase" machinery in C.


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


* pk/rebase-in-c-6-final (2018-10-11) 1 commit
  (merged to 'next' on 2018-10-19 at 52f1dadf69)
 + rebase: default to using the builtin rebase
 (this branch is used by js/rebase-autostash-fix; uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts and pk/rebase-in-c-5-test; is tangled with ag/sequencer-reduce-rewriting-todo, cb/printf-empty-format, jc/rebase-in-c-5-test-typofix, js/rebase-i-break and js/rebase-i-shortopt.)

 The final step of rewriting "rebase -i" in C.

--------------------------------------------------
[New Topics]

* ab/dynamic-gettext-poison (2018-11-02) 1 commit
 - i18n: make GETTEXT_POISON a runtime option


* js/rebase-p-tests (2018-11-02) 3 commits
 - tests: optionally skip `git rebase -p` tests
 - t3418: decouple test cases from a previous `rebase -p` test case
 - t3404: decouple some test cases from outcomes of previous test cases

 In preparation to the day when we can deprecate and remove the
 "rebase -p", make sure we can skip and later remove tests for
 it.

 Will merge to 'next'.


* sg/travis-install-dependencies (2018-11-02) 1 commit
 - travis-ci: install packages in 'ci/install-dependencies.sh'
 (this branch uses ss/travis-ci-force-vm-mode.)

 The procedure to install dependencies before testing at Travis CI
 is getting revamped for both simplicity and flexibility, taking
 advantage of the recent move to the vm-based environment.

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

* ab/push-dwim-dst (2018-10-29) 9 commits
 - SQUASH???
 - push doc: document the DWYM behavior pushing to unqualified <dst>
 - push: add DWYM support for "git push refs/remotes/...:<dst>"
 - push: test that <src> doesn't DWYM if <dst> is unqualified
 - push: add an advice on unqualified <dst> push
 - push: move unqualified refname error into a function
 - push: improve the error shown on unqualified <dst> push
 - i18n: remote.c: mark error(...) messages for translation
 - remote.c: add braces in anticipation of a follow-up change

 "git push $there $src:$dst" rejects when $dst is not a fully
 qualified refname and not clear what the end user meant.  The
 codepath has been taught to give a clearer error message, and also
 guess where the push should go by taking the type of the pushed
 object into account (e.g. a tag object would want to go under
 refs/tags/).

 The last few steps are questionable.
 cf. <87in1lkw54.fsf@evledraar.gmail.com>


* md/list-lazy-objects-fix (2018-10-29) 1 commit
 - list-objects.c: don't segfault for missing cmdline objects

 "git rev-list --exclude-promissor-objects" had to take an object
 that does not exist locally (and is lazily available) from the
 command line without barfing, but the code dereferenced NULL.

 That sympotom may be worth addressing, but I think the "fix" is
 overly broad and is wrong.  Giving a missing object should be
 diagnosed as an error, not swept under the rug silently.


* nd/i18n (2018-10-29) 12 commits
 - fsck: mark strings for translation
 - parse-options.c: mark more strings for translation
 - parse-options: replace opterror() with optname()
 - repack: mark more strings for translation
 - remote.c: mark messages for translation
 - reflog: mark strings for translation
 - read-cache.c: add missing colon separators
 - read-cache.c: mark more strings for translation
 - attr.c: mark more string for translation
 - archive.c: mark more strings for translation
 - alias.c: mark split_cmdline_strerror() strings for translation
 - git.c: mark more strings for translation

 More _("i18n") markings.

 Some changes seem not to be mere mechanical convesions and needs
 a careful review.


* nd/pthreads (2018-10-29) 10 commits
 - read-cache.c: initialize copy_len to shut up gcc 8
 - Clean up pthread_create() error handling
 - read-cache.c: remove #ifdef NO_PTHREADS
 - pack-objects: remove #ifdef NO_PTHREADS
 - preload-index.c: remove #ifdef NO_PTHREADS
 - grep: remove #ifdef NO_PTHREADS
 - attr.c: remove #ifdef NO_PTHREADS
 - name-hash.c: remove #ifdef NO_PTHREADS
 - index-pack: remove #ifdef NO_PTHREADS
 - thread-utils: macros to unconditionally compile pthreads API

 The codebase has been cleaned up to reduce "#ifndef NO_PTHREADS".


* nd/wildmatch-double-asterisk (2018-10-29) 1 commit
  (merged to 'next' on 2018-11-01 at 627186d020)
 + wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode

 A pattern with '**' that does not have a slash on either side used
 to be an invalid one, but the code now treats such double-asterisks
 the same way as two normal asterisks that happen to be adjacent to
 each other.

 Will merge to 'master'.


* rj/header-cleanup (2018-10-29) 3 commits
  (merged to 'next' on 2018-11-01 at 975e56048f)
 + commit-reach.h: add missing declarations (hdr-check)
 + ewok_rlw.h: add missing 'inline' to function definition
 + fetch-object.h: add missing declaration (hdr-check)

 Code cleanup.

 Will merge to 'master'.


* js/mingw-ns-filetime (2018-10-24) 3 commits
  (merged to 'next' on 2018-10-29 at 4563a0d9d0)
 + mingw: implement nanosecond-precision file times
 + mingw: replace MSVCRT's fstat() with a Win32-based implementation
 + mingw: factor out code to set stat() data

 Windows port learned to use nano-second resolution file timestamps.

 Will merge to 'master'.


* bp/refresh-index-using-preload (2018-10-30) 1 commit
  (merged to 'next' on 2018-11-01 at 289e6bcece)
 + speed up refresh_index() by utilizing preload_index()

 The helper function to refresh the cached stat information in the
 in-core index has learned to perform the lstat() part of the
 operation in parallel on multi-core platforms.

 Will merge to 'master'.


* sg/test-verbose-log (2018-10-30) 1 commit
  (merged to 'next' on 2018-11-01 at 0c4a18a71f)
 + test-lib: introduce the '-V' short option for '--verbose-log'

 Our test scripts can now take the '-V' option as a synonym for the
 '--verbose-log' option.

 Will merge to 'master'.


* ab/pack-tests-cleanup (2018-10-31) 3 commits
 - index-pack tests: don't leave test repo dirty at end
 - pack-objects tests: don't leave test .git corrupt at end
 - pack-objects test: modernize style

 A couple of tests used to leave the repository in a state that is
 deliberately corrupt, which have been corrected.

 Will merge to 'next'.


* jk/detect-truncated-zlib-input (2018-10-31) 4 commits
 - Adjust for 2.19.x series
 - cat-file: handle streaming failures consistently
 - check_stream_sha1(): handle input underflow
 - t1450: check large blob in trailing-garbage test

 A regression in Git 2.12 era made "git fsck" fall into an infinite
 loop while processing truncated loose objects.

 Will merge to 'next'.


* jk/proto-v2-ref-prefix-fix (2018-10-31) 2 commits
 - ls-remote: pass heads/tags prefixes to transport
 - ls-remote: do not send ref prefixes for patterns

 "git ls-remote $there foo" was broken by recent update for the
 protocol v2 and stopped showing refs that match 'foo' that are not
 refs/{heads,tags}/foo, which has been fixed.

 Will merge to 'next'.


* jk/stream-pack-non-delta-clarification (2018-10-31) 1 commit
 - read_istream_pack_non_delta(): document input handling

 Additional comment on a tricky piece of code to help developers.

 Will merge to 'next'.


* js/mingw-isatty-and-dup2 (2018-10-31) 1 commit
 - mingw: fix isatty() after dup2()

 Windows fix.

 Will merge to 'next'.


* js/mingw-perl5lib (2018-10-31) 4 commits
 - mingw: unset PERL5LIB by default
 - config: move Windows-specific config settings into compat/mingw.c
 - config: allow for platform-specific core.* config settings
 - config: rename `dummy` parameter to `cb` in git_default_config()

 Windows fix.

 Will merge to 'next'.


* js/mingw-utf8-env (2018-10-31) 2 commits
 - mingw: reencode environment variables on the fly (UTF-16 <-> UTF-8)
 - t7800: fix quoting

 Windows fix.

 Will merge to 'next'.


* ma/sequencer-do-reset-saner-loop-termination (2018-10-31) 1 commit
 - sequencer: break out of loop explicitly

 Code readability fix.

 Will merge to 'next'.


* nb/worktree-api-doc (2018-10-31) 2 commits
 - worktree: rename is_worktree_locked to worktree_lock_reason
 - worktree: update documentation for lock_reason and lock_reason_valid

 Code readability fix.

 Will merge to 'next'.


* sh/mingw-safer-compat-poll (2018-11-01) 1 commit
 - poll: use GetTickCount64() to avoid wrap-around issues

 Windows fix.

 Will merge to 'next'.


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

 On hold.
 Not quite correct?
 cf. <20181025091406.GK30222@szeder.dev>
 Reroll being worked on.
 cf. <20181030220817.61691-1-sbeller@google.com>


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

 Updates for corner cases in merge-recursive.

 Expecting a reroll.
 cf. <CABPp-BGq1YDdzZ6CqzCp9QXPZy6XxV8sujyRxwBc-EnS+ygSrg@mail.gmail.com>


* jt/tighten-fetch-proto-v2-response (2018-11-01) 1 commit
 - fetch-pack: be more precise in parsing v2 response

 "git fetch" was a bit loose in parsing resposes from the other side
 when talking over the protocol v2.

 Will merge to 'next'.


* nd/complete-format-patch (2018-10-22) 1 commit
 . completion: use __gitcomp_builtin for format-patch

 Expecting a reroll.


* nd/completion-negation (2018-10-22) 1 commit
  (merged to 'next' on 2018-10-29 at 87e73b0c72)
 + completion: fix __gitcomp_builtin no longer consider extra options

 The command line completion machinery (in contrib/) has been
 updated to allow the completion script to tweak the list of options
 that are reported by the parse-options machinery correctly.

 Will merge to 'master'.


* nd/config-split (2018-10-29) 79 commits
 - config.txt: remove config/dummy.txt
 - config.txt: move worktree.* to a separate file
 - config.txt: move web.* to a separate file
 - config.txt: move versionsort.* to a separate file
 - config.txt: move user.* to a separate file
 - config.txt: move url.* to a separate file
 - config.txt: move uploadpack.* to a separate file
 - config.txt: move uploadarchive.* to a separate file
 - config.txt: move transfer.* to a separate file
 - config.txt: move tag.* to a separate file
 - config.txt: move submodule.* to a separate file
 - config.txt: move stash.* to a separate file
 - config.txt: move status.* to a separate file
 - config.txt: move splitIndex.* to a separate file
 - config.txt: move showBranch.* to a separate file
 - config.txt: move sequencer.* to a separate file
 - config.txt: move sendemail-config.txt to config/
 - config.txt: move reset.* to a separate file
 - config.txt: move rerere.* to a separate file
 - config.txt: move repack.* to a separate file
 - config.txt: move remotes.* to a separate file
 - config.txt: move remote.* to a separate file
 - config.txt: move receive-config.txt to config/
 - config.txt: move rebase-config.txt to config/
 - config.txt: move push-config.txt to config/
 - config.txt: move pull-config.txt to config/
 - config.txt: move protocol.* to a separate file
 - config.txt: move pretty.* to a separate file
 - config.txt: move pager.* to a separate file
 - config.txt: move pack.* to a separate file
 - config.txt: move notes.* to a separate file
 - config.txt: move mergetool.* to a separate file
 - config.txt: move merge-config.txt to config/
 - config.txt: move man.* to a separate file
 - config.txt: move mailmap.* to a separate file
 - config.txt: move mailinfo.* to a separate file
 - config.txt: move log.* to a separate file
 - config.txt: move interactive.* to a separate file
 - config.txt: move instaweb.* to a separate file
 - config.txt: move init.* to a separate file
 - config.txt: move index.* to a separate file
 - git-imap-send.txt: move imap.* to a separate file
 - config.txt: move i18n.* to a separate file
 - config.txt: move http.* to a separate file
 - config.txt: move ssh.* to a separate file
 - config.txt: move help.* to a separate file
 - config.txt: move guitool.* to a separate file
 - config.txt: move gui-config.txt to config/
 - config.txt: move gpg.* to a separate file
 - config.txt: move grep.* to a separate file
 - config.txt: move gitweb.* to a separate file
 - config.txt: move gitcvs-config.txt to config/
 - config.txt: move gc.* to a separate file
 - config.txt: move fsck.* to a separate file
 - config.txt: move fmt-merge-msg-config.txt to config/
 - config.txt: move format-config.txt to config/
 - config.txt: move filter.* to a separate file
 - config.txt: move fetch-config.txt to config/
 - config.txt: move fastimport.* to a separate file
 - config.txt: move difftool.* to a separate file
 - config.txt: move diff-config.txt to config/
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
 - Update makefile in preparation for Documentation/config/*.txt
 - Merge branches 'bp/reset-quiet' and 'js/mingw-http-ssl' into nd/config-split
 (this branch uses bp/reset-quiet and js/mingw-http-ssl; is tangled with jc/http-curlver-warnings.)

 Split the overly large Documentation/config.txt file into million
 little pieces.  This potentially allows each individual piece
 included into the manual page of the command it affects more easily.

 Will merge to 'next'.

 This is a painful conversions while many other topics in flight
 wants to add to or edit the documentation of configuration
 variables.


* nd/per-worktree-config (2018-10-22) 2 commits
  (merged to 'next' on 2018-11-01 at 3746343ca8)
 + worktree: add per-worktree config files
 + t1300: extract and use test_cmp_config()

 A fourth class of configuration files (in addition to the
 traditional "system wide", "per user in the $HOME directory" and
 "per repository in the $GIT_DIR/config") has been introduced so
 that different worktrees that share the same repository (hence the
 same $GIT_DIR/config file) can use different customization.

 Will merge to 'master'.


* nd/submodule-unused-vars (2018-10-22) 1 commit
  (merged to 'next' on 2018-10-29 at 33641dcc89)
 + submodule.c: remove some of the_repository references

 Code clean-up.

 Will merge to 'master'.


* nd/unpack-trees-with-cache-tree (2018-10-22) 1 commit
  (merged to 'next' on 2018-10-29 at de51b606da)
 + read-cache: use of memory after it is freed

 Trivial bugfix.

 Will merge to 'master'.


* ag/rev-parse-all-exclude-fix (2018-11-01) 1 commit
 - rev-parse: clear --exclude list after 'git rev-parse --all'

 "git rev-parse --exclude=* --branches --branches"  (i.e. first
 saying "add only things that do not match '*' out of all branches"
 and then adding all branches, without any exclusion this time")
 worked as expected, but "--exclude=* --all --all" did not work the
 same way, which has been fixed.

 Will merge to 'next'.


* bp/reset-quiet (2018-10-24) 3 commits
  (merged to 'next' on 2018-10-29 at 71f4fbc802)
 + reset: warn when refresh_index() takes more than 2 seconds
 + reset: add new reset.quiet config setting
 + reset: don't compute unstaged changes after reset when --quiet
 (this branch is used by nd/config-split.)

 "git reset --quiet" no longer runs "update-index --refresh"
 internally, which shifts the refresh cost away from the command.

 Will merge to 'master'.


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
  (merged to 'next' on 2018-10-29 at a3fbbdb889)
 + send-email: explicitly disable authentication

 "git send-email" learned to disable SMTP authentication via the
 "--smtp-auth=none" option, even when the smtp username is given
 (which turns the authentication on by default).

 Will merge to 'master'.


* md/exclude-promisor-objects-fix (2018-10-23) 2 commits
  (merged to 'next' on 2018-10-29 at fb36a5dcbe)
 + exclude-promisor-objects: declare when option is allowed
 + Documentation/git-log.txt: do not show --exclude-promisor-objects

 Operations on promisor objects make sense in the context of only a
 small subset of the commands that internally use the revisions
 machinery, but the "--exclude-promisor-objects" option were taken
 and led to nonsense results by commands like "log", to which it
 didn't make much sense.  This has been corrected.

 Will merge to 'master'.


* mg/gpg-fingerprint (2018-10-23) 3 commits
  (merged to 'next' on 2018-10-26 at 1e219cb754)
 + gpg-interface.c: obtain primary key fingerprint as well
 + gpg-interface.c: support getting key fingerprint via %GF format
 + gpg-interface.c: use flags to determine key/signer info presence
 (this branch uses mg/gpg-parse-tighten; is tangled with jc/gpg-cocci-preincr.)

 New "--pretty=format:" placeholders %GF and %GP that show the GPG
 key fingerprints have been invented.

 Will merge to 'master'.


* jc/http-curlver-warnings (2018-10-26) 1 commit
  (merged to 'next' on 2018-10-26 at 870e125cec)
 + http: give curl version warnings consistently
 (this branch uses js/mingw-http-ssl; is tangled with nd/config-split.)

 Warning message fix.

 Will merge to 'master'.


* sd/stash-wo-user-name (2018-11-02) 1 commit
 - t3903-stash: test without configured user.name and user.email

 An early part of a wip.


* sg/test-rebase-editor-fix (2018-10-29) 1 commit
  (merged to 'next' on 2018-11-01 at 271e0fc663)
 + t3404-rebase-interactive: test abbreviated commands

 Will merge to 'master'.


* ss/travis-ci-force-vm-mode (2018-10-26) 1 commit
  (merged to 'next' on 2018-11-01 at 8596bb2a65)
 + travis-ci: no longer use containers
 (this branch is used by sg/travis-install-dependencies.)

 The "container" mode of TravisCI is going away.  Our .travis.yml
 file is getting prepared for the transition.

 Will merge to 'master'.


* tb/char-may-be-unsigned (2018-10-26) 1 commit
  (merged to 'next' on 2018-11-01 at 9e14f289f8)
 + path.c: char is not (always) signed

 Build portability fix.

 Will merge to 'master'.


* jt/upload-pack-v2-fix-shallow (2018-10-19) 3 commits
  (merged to 'next' on 2018-10-29 at d9010b3c7b)
 + upload-pack: clear flags before each v2 request
 + upload-pack: make want_obj not global
 + upload-pack: make have_obj not global

 "git fetch" over protocol v2 into a shallow repository failed to
 fetch full history behind a new tip of history that was diverged
 before the cut-off point of the history that was previously fetched
 shallowly.

 Will merge to 'master'.


* pw/am-rebase-read-author-script (2018-11-01) 5 commits
 - sequencer: use read_author_script()
 - add read_author_script() to libgit
 - am: rename read_author_script()
 - am: improve author-script error reporting
 - am: don't die in read_author_script()

 Unify code to read the author-script used in "git am" and the
 commands that use the sequencer machinery, e.g. "git rebase -i".

 Will merge to 'next'.


* sb/submodule-url-to-absolute (2018-10-18) 1 commit
  (merged to 'next' on 2018-10-29 at 4264c150cb)
 + submodule helper: convert relative URL to absolute URL if needed

 Some codepaths failed to form a proper URL when .gitmodules record
 the URL to a submodule repository as relative to the repository of
 superproject, which has been corrected.

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

 Expecting a reroll.
 cf. <20181031225521.GA573515@genre.crustytoothpaste.net>


* js/mingw-http-ssl (2018-10-26) 3 commits
  (merged to 'next' on 2018-10-26 at 318e82e101)
 + http: when using Secure Channel, ignore sslCAInfo by default
 + http: add support for disabling SSL revocation checks in cURL
 + http: add support for selecting SSL backends at runtime
 (this branch is used by jc/http-curlver-warnings and nd/config-split.)

 On platforms with recent cURL library, http.sslBackend configuration
 variable can be used to choose a different SSL backend at runtime.
 The Windows port uses this mechanism to switch between OpenSSL and
 Secure Channel while talking over the HTTPS protocol.

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
 cf. <nycvar.QRO.7.76.6.1810261033440.4546@tvgsbejvaqbjf.bet>


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 On hold, monitoring the discussion.
 cf. <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* jc/war-on-string-list (2018-11-01) 1 commit
 - fetch: replace string-list used as a look-up table with a hashmap

 Replace three string-list instances used as look-up tables in "git
 fetch" with hashmaps.

 Will merge to 'next'.


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


* ag/sequencer-reduce-rewriting-todo (2018-10-09) 16 commits
 . rebase--interactive: move transform_todo_file() to rebase--interactive.c
 . sequencer: fix a call to error() in transform_todo_file()
 . sequencer: use edit_todo_list() in complete_action()
 . rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 . rebase-interactive: append_todo_help() changes
 . rebase-interactive: use todo_list_transform() in edit_todo_list()
 . sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 . sequencer: change complete_action() to use the refactored functions
 . sequencer: make sequencer_make_script() write its script to a strbuf
 . sequencer: refactor transform_todos() to work on a todo_list
 . sequencer: refactor rearrange_squash() to work on a todo_list
 . sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 . sequencer: refactor check_todo_list() to work on a todo_list
 . sequencer: make the todo_list structure public
 . sequencer: clear the number of items of a todo_list before parsing
 . Merge branch 'ag/rebase-i-in-c' into ag/sequencer-reduce-rewriting-todo

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 A reroll exists but is based on a stale codebase and is painful to
 merge.


* ds/test-multi-pack-index (2018-10-26) 4 commits
 - packfile: close multi-pack-index in close_all_packs
 - multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
 - midx: close multi-pack-index on repack
 - midx: fix broken free() in close_midx()

 Tests for the recently introduced multi-pack index machinery.

 Will merge to 'next'.


* nd/per-worktree-ref-iteration (2018-10-22) 8 commits
 - reflog expire: cover reflog from all worktrees
 - fsck: check HEAD and reflog from other worktrees
 - fsck: move fsck_head_link() to get_default_heads() to avoid some globals
 - revision.c: better error reporting on ref from different worktrees
 - revision.c: correct a parameter name
 - refs: new ref types to make per-worktree refs visible to all worktrees
 - Add a place for (not) sharing stuff between worktrees
 - refs.c: indent with tabs, not spaces

 The code to traverse objects for reachability, used to decide what
 objects are unreferenced and expendable, have been taught to also
 consider per-worktree refs of other worktrees as starting points to
 prevent data loss.

 Will merge to 'next'.


* ds/reachable-topo-order (2018-11-02) 7 commits
 - t6012: make rev-list tests more interesting
 - revision.c: generation-based topo-order algorithm
 - commit/revisions: bookkeeping before refactoring
 - revision.c: begin refactoring --topo-order logic
 - test-reach: add rev-list tests
 - test-reach: add run_three_modes method
 - prio-queue: add 'peek' operation

 The revision walker machinery learned to take advantage of the
 commit generation numbers stored in the commit-graph file.


* sb/submodule-recursive-fetch-gets-the-tip (2018-10-31) 11 commits
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

 On hold, monitoring the discussion.
 cf. <20181025233231.102245-1-sbeller@google.com>


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ao/submodule-wo-gitmodules-checked-out (2018-10-31) 10 commits
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

 Will merge to 'next'.


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

--------------------------------------------------
[Discarded]

* ab/reject-alias-loop (2018-10-19) 1 commit
  (merged to 'next' on 2018-10-26 at bc213f1bef)
 + alias: detect loops in mixed execution mode

 Two (or more) aliases that mutually refer to each other can form an
 infinite loop; we now attempt to notice and stop.

 Discarded.
 Reverted out of 'next'.
 cf. <87sh0slvxm.fsf@evledraar.gmail.com>
