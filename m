Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A5C1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeCFXeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:34:07 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36067 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFXeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:34:05 -0500
Received: by mail-wr0-f195.google.com with SMTP id v111so346045wrb.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=IimH3ogkzeAtk7B6q1VatbogyRpsqlHdJ5PAjkwSYCY=;
        b=tB+P0w67nuQtzgiCa2+KXShQpY+6YlYhg00MXuZd8SlU4KnS7l7K8b73aST3H9vZ7v
         wA/8R/mWJXbVDanuwOR8h1PgFciKZHtJSBhE4YwT+JM8L+mk+JuCypvFRQvpGMSCQfxj
         dGRYcifSRSyj3AiM4CYBBzcfkQ47himRW2lB8wrnC7IVdHmBQBJUUA7OxAoqQHXN93mj
         oUddQD2ZKzkqh3ddJtFG3iZq2kbJ6zLhsZjRNBBf7V9kdsgvsrL5SzK2IXb8+LTs5lpT
         qk6WdlIdM8U21iCCP1oQd37/m/sNnmsoNOnXWaL9+oUFR1BTm/iMT4ehk6IfataJ5mPA
         nfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=IimH3ogkzeAtk7B6q1VatbogyRpsqlHdJ5PAjkwSYCY=;
        b=UBbtvqt+GVdvjBIWuxZPHtXG1u7Lvfot+ARSD4YMmFsr7JIog8Szi6tZ74mscpdhv+
         zbvHA/rAiA3IJWmdNcxXpSOISsjrNt2jsAG9qcxO8PpTI30E+VQH3aof73hJaEMle5X6
         VUb+dJxsas7kihv8WpJ/+vuq4riHAQ9T7/jtD5yKo7XUnIRTstyQW+JnyP8IrJTWFzXl
         QjYKaEPO3amTqahMPIkigwy4VTedGPdFsSRhiuvg8jmxSxjLOh88KcRZbMuWBzxTIcPG
         /S9ESR9ULsDTKGP/Qr2K0x8TIqJx1EJVjuEuHUQTVPdkISjkZRzQuELepnlf41/WsoIz
         NbeA==
X-Gm-Message-State: APf1xPCKgM3Korecoa46jir2hSPIfqdpKFHuHSgyWE/STSa6YCHCqEt1
        5V55Ez8OUV1hqCsCR2NWNF9xHvjS3AZ0HQ==
X-Google-Smtp-Source: AG47ELveeoyuh2jARXXI2+IOVnxE+oi/O85iLtiEww/NPZtiTrl3jVZcFqX/E8gvTHE/g2MGg8G0eg==
X-Received: by 10.223.166.135 with SMTP id t7mr16716744wrc.260.1520379242396;
        Tue, 06 Mar 2018 15:34:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r6sm18015053wrg.63.2018.03.06.15.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 15:34:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2018, #02; Tue, 6)
X-master-at: c6284da4ff4afbde8211efe5d03f3604b1c6b9d6
X-next-at: d534789076285d319a5ede615f98c24b4ad17c81
Date:   Tue, 06 Mar 2018 15:34:01 -0800
Message-ID: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
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

I haven't seen enough reviews (nor I had chance to sufficiently
review them myself) to comfortably decide what to do with them on a
handful of new topics that appeared in the past week or two, so the
ones in the new topics section may not have any description yet in
this issue.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/fetch-prune (2018-02-09) 17 commits
  (merged to 'next' on 2018-02-27 at eafb648dd9)
 + fetch: make the --prune-tags work with <url>
 + fetch: add a --prune-tags option and fetch.pruneTags config
 + fetch tests: add scaffolding for the new fetch.pruneTags
 + git-fetch & config doc: link to the new PRUNING section
 + git remote doc: correct dangerous lies about what prune does
 + git fetch doc: add a new section to explain the ins & outs of pruning
 + fetch tests: fetch <url> <spec> as well as fetch [<remote>]
 + fetch tests: expand case/esac for later change
 + fetch tests: double quote a variable for interpolation
 + fetch tests: test --prune and refspec interaction
 + fetch tests: add a tag to be deleted to the pruning tests
 + fetch tests: re-arrange arguments for future readability
 + fetch tests: refactor in preparation for testing tag pruning
 + remote: add a macro for "refs/tags/*:refs/tags/*"
 + fetch: stop accessing "remote" variable indirectly
 + fetch: trivially refactor assignment to ref_nr
 + fetch: don't redundantly NULL something calloc() gave us

 "git fetch --prune-tags" may be used as a handy short-hand for
 getting rid of stale tags that are locally held.


* ab/simplify-perl-makefile (2018-02-15) 1 commit
  (merged to 'next' on 2018-02-27 at b0d68a2013)
 + Makefile: generate Git(3pm) as dependency of the 'doc' and 'man' targets

 Hotfix for a topic already in 'master'.


* bw/c-plus-plus (2018-02-22) 37 commits
  (merged to 'next' on 2018-02-27 at daf85c03de)
 + replace: rename 'new' variables
 + trailer: rename 'template' variables
 + tempfile: rename 'template' variables
 + wrapper: rename 'template' variables
 + environment: rename 'namespace' variables
 + diff: rename 'template' variables
 + environment: rename 'template' variables
 + init-db: rename 'template' variables
 + unpack-trees: rename 'new' variables
 + trailer: rename 'new' variables
 + submodule: rename 'new' variables
 + split-index: rename 'new' variables
 + remote: rename 'new' variables
 + ref-filter: rename 'new' variables
 + read-cache: rename 'new' variables
 + line-log: rename 'new' variables
 + imap-send: rename 'new' variables
 + http: rename 'new' variables
 + entry: rename 'new' variables
 + diffcore-delta: rename 'new' variables
 + diff: rename 'new' variables
 + diff-lib: rename 'new' variable
 + commit: rename 'new' variables
 + combine-diff: rename 'new' variables
 + remote: rename 'new' variables
 + reflog: rename 'new' variables
 + pack-redundant: rename 'new' variables
 + help: rename 'new' variables
 + checkout: rename 'new' variables
 + apply: rename 'new' variables
 + apply: rename 'try' variables
 + diff: rename 'this' variables
 + rev-parse: rename 'this' variable
 + pack-objects: rename 'this' variables
 + blame: rename 'this' variables
 + object: rename function 'typename' to 'type_name'
 + object_info: change member name from 'typename' to 'type_name'

 We now avoid using identifiers that clash with C++ keywords.  Even though
 it is not a goal to compile Git with C++ compilers, changes like
 this help use of code analysis tools that targets C++ on our
 codebase.


* bw/doc-submodule-recurse-config-with-clone (2018-02-21) 1 commit
  (merged to 'next' on 2018-02-27 at 5b12841508)
 + submodule: indicate that 'submodule.recurse' doesn't apply to clone

 Doc update.


* bw/perl-timegm-timelocal-fix (2018-02-23) 1 commit
  (merged to 'next' on 2018-02-27 at 565a3141ce)
 + perl: call timegm and timelocal with 4-digit year

 Y2k20 fix ;-) for our perl scripts.


* jc/allow-ff-merging-kept-tags (2018-02-16) 1 commit
  (merged to 'next' on 2018-02-27 at 8b03610d2b)
 + merge: allow fast-forward when merging a tracked tag

 Since Git 1.7.9, "git merge" defaulted to --no-ff (i.e. even when
 the side branch being merged is a descendant of the current commit,
 create a merge commit instead of fast-forwarding) when merging a
 tag object.  This was appropriate default for integrators who pull
 signed tags from their downstream contributors, but caused an
 unnecessary merges when used by downstream contributors who
 habitually "catch up" their topic branches with tagged releases
 from the upstream.  Update "git merge" to default to --no-ff only
 when merging a tag object that does *not* sit at its usual place in
 refs/tags/ hierarchy, and allow fast-forwarding otherwise, to
 mitigate the problem.


* jk/cached-commit-buffer (2018-02-22) 2 commits
  (merged to 'next' on 2018-02-27 at af791d9a1e)
 + revision: drop --show-all option
 + commit: drop uses of get_cached_commit_buffer()

 Code clean-up.


* jk/strbuf-read-file-close-error (2018-02-23) 1 commit
  (merged to 'next' on 2018-02-27 at c5dfe33335)
 + strbuf_read_file(): preserve errno across close() call

 Code clean-up.


* jk/test-helper-v-output-fix (2018-02-22) 1 commit
  (merged to 'next' on 2018-02-27 at c9109977e8)
 + t: send verbose test-helper output to fd 4

 Test framework update.


* ms/non-ascii-ticks (2018-02-22) 1 commit
  (merged to 'next' on 2018-02-27 at 41159fc4f0)
 + Documentation/gitsubmodules.txt: avoid non-ASCII apostrophes

 Doc markup fix.


* nd/rebase-show-current-patch (2018-02-12) 3 commits
  (merged to 'next' on 2018-02-27 at 5a4e23a77c)
 + rebase: introduce and use pseudo-ref REBASE_HEAD
 + rebase: add --show-current-patch
 + am: add --show-current-patch

 The new "--show-current-patch" option gives an end-user facing way
 to get the diff being applied when "git rebase" (and "git am")
 stops with a conflict.


* nm/tag-edit (2018-02-07) 1 commit
  (merged to 'next' on 2018-02-27 at 3bc8345213)
 + tag: add --edit option

 "git tag" learned an explicit "--edit" option that allows the
 message given via "-m" and "-F" to be further edited.


* pw/add-p-single (2018-02-13) 3 commits
  (merged to 'next' on 2018-02-27 at 0e2bd585e3)
 + add -p: improve error messages
 + add -p: only bind search key if there's more than one hunk
 + add -p: only display help for active keys

 "git add -p" used to offer "/" (look for a matching hunk) as a
 choice, even there was only one hunk, which has been corrected.
 Also the single-key help is now given only for keys that are
 enabled (e.g. help for '/' won't be shown when there is only one
 hunk).


* rs/strbuf-read-file-or-whine (2018-02-22) 1 commit
  (merged to 'next' on 2018-02-27 at 56017cb5e2)
 + sequencer: factor out strbuf_read_file_or_whine()

 Code clean-up.


* sb/color-h-cleanup (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-27 at 617345de77)
 + color.h: document and modernize header
 (this branch is used by sb/blame-color.)

 Devdoc update.


* sg/t6300-modernize (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-27 at b6f13b6915)
 + t6300-for-each-ref: fix "more than one quoting style" tests

 Test update.


* sm/mv-dry-run-update (2018-02-07) 2 commits
  (merged to 'next' on 2018-02-27 at 17eef62ddf)
 + mv: remove unneeded 'if (!show_only)'
 + t7001: add test case for --dry-run

 Code clean-up.


* xz/send-email-batch-size (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-27 at da0247d532)
 + send-email: error out when relogin delay is missing

 "git send-email" learned to complain when the batch-size option is
 not defined when the relogin-delay option is, since these two are
 mutually required.

--------------------------------------------------
[New Topics]

* bb/git-gui-ssh-key-files (2018-03-02) 2 commits
 - Merge branch 'bb/ssh-key-files' of git-gui into bb/git-gui-ssh-key-files
 - git-gui: search for all current SSH key types


* bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
 - Merge branch 'bp/bind-kp-enter' of git-gui into bp/git-gui-bind-kp-enter
 - git-gui: bind CTRL/CMD+numpad ENTER to do_commit


* cb/git-gui-ttk-style (2018-03-05) 2 commits
 - Merge branch 'cb/ttk-style' of git-gui into cb/git-gui-ttk-style
 - git-gui: workaround ttk:style theme use


* dp/git-el-ls-files-excludes (2018-03-05) 1 commit
 - git.el: handle default excludesfile properly


* jk/add-i-diff-filter (2018-03-05) 2 commits
 - add--interactive: detect bogus diffFilter output
 - t3701: add a test for interactive.diffFilter


* jk/smart-http-protocol-doc-fix (2018-03-05) 1 commit
 - smart-http: document flush after "# service" line


* nd/object-allocation-comments (2018-03-06) 2 commits
 - object.h: realign object flag allocation comment
 - object.h: update flag allocation comment


* nd/pack-objects-pack-struct (2018-03-05) 9 commits
 - pack-objects: reorder 'hash' to pack struct object_entry
 - pack-objects: refer to delta objects by index instead of pointer
 - pack-objects: move in_pack out of struct object_entry
 - pack-objects: move in_pack_pos out of struct object_entry
 - pack-objects: note about in_pack_header_size
 - pack-objects: use bitfield for object_entry::depth
 - pack-objects: use bitfield for object_entry::dfs_state
 - pack-objects: turn type and in_pack_type to bitfields
 - pack-objects: document holes in struct object_entry.h


* nd/repack-keep-pack (2018-03-06) 5 commits
 - pack-objects: display progress in get_object_details()
 - pack-objects: show some progress when counting kept objects
 - gc --auto: exclude base pack if not enough mem to "repack -ad"
 - repack: add --keep-pack option
 - t7700: have closing quote of a test at the beginning of line


* nd/worktree-prune (2018-03-06) 3 commits
 - worktree prune: improve prune logic when worktree is moved
 - worktree: delete dead code
 - gc.txt: more details about what gc does


* pw/add-p-select (2018-03-06) 3 commits
 - add -p: optimize line selection for short hunks
 - add -p: allow line selection to be inverted
 - add -p: select individual hunk lines
 (this branch uses pw/add-p-recount.)

--------------------------------------------------
[Stalled]

* sb/blame-color (2018-02-13) 3 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


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


* dj/runtime-prefix (2017-12-05) 4 commits
 . exec_cmd: RUNTIME_PREFIX on some POSIX systems
 . Makefile: add Perl runtime prefix support
 . Makefile: add support for "perllibdir"
 . Makefile: generate Perl header from template file

 A build-time option has been added to allow Git to be told to refer
 to its associated files relative to the main binary, in the same
 way that has been possible on Windows for quite some time, for
 Linux, BSDs and Darwin.

 Perhaps it is about time to reboot the effort?


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

 Stalled for too long without any response; will discard.
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

 Stalled for too long without any response; will discard.


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

 Stalled for too long without any response; will discard.
 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>

--------------------------------------------------
[Cooking]

* sg/travis-build-during-script-phase (2018-01-08) 1 commit
  (merged to 'next' on 2018-03-02 at 29e1585ae7)
 + travis-ci: build Git during the 'script' phase

 Build the executable in 'script' phase in Travis CI integration, to
 follow the established practice, rather than during 'before_script'
 phase.  This allows the CI categorize the failures better ('failed'
 is project's fault, 'errored' is build environment's).

 Will merge to 'master'.


* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine
 (this branch is used by cl/send-email-reply-to.)

 Code refactoring.


* ld/p4-unshelve (2018-02-22) 1 commit
 - git-p4: add unshelve command

 "git p4" learned to "unshelve" shelved commit from P4.

 Will hold, perhaps drop and use format-change that uses a proper "diff".
 cf. <CAE5ih7_ooDMqVtTMoQ70s5XCkncr04HY0JkqSp1UmKQeG81oaA@mail.gmail.com>


* ps/contains-id-error-message (2018-03-06) 1 commit
 - parse-options: squelch usage help on certain errors

 "git tag --contains no-such-commit" gave a full list of options
 after giving an error message.

 Rebooted and fixed the root cause of the issue at a lower level.


* rv/grep-cleanup (2018-02-23) 2 commits
  (merged to 'next' on 2018-03-02 at 4aafca15f9)
 + grep: simplify grep_oid and grep_file
 + grep: move grep_source_init outside critical section

 Threaded "git grep" has been optimized to avoid allocation in code
 section that is covered under a mutex.

 Will merge to 'master'.


* sg/subtree-signed-commits (2018-02-23) 1 commit
  (merged to 'next' on 2018-03-02 at c5f6fd33e6)
 + subtree: fix add and pull for GPG-signed commits

 "git subtree" script (in contrib/) scripted around "git log", whose
 output got affected by end-user configuration like log.showsignature

 Will merge to 'master'.


* ds/find-unique-abbrev-optim (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 0b6d4f9335)
 + sha1_name: fix uninitialized memory errors

 While finding unique object name abbreviation, the code may
 accidentally have read beyond the end of the array of object names
 in a pack.

 Will merge to 'master'.


* ds/mark-parents-uninteresting-optim (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 5a42c79806)
 + revision.c: reduce object database queries

 Micro optimization in revision traversal code.

 Will merge to 'master'.


* jc/test-must-be-empty (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at ec129f1b97)
 + test_must_be_empty: make sure the file exists, not just empty

 Test framework tweak to catch developer thinko.

 Will merge to 'master'.


* ma/roll-back-lockfiles (2018-02-28) 5 commits
  (merged to 'next' on 2018-03-06 at be29bf891c)
 + sequencer: do not roll back lockfile unnecessarily
 + merge: always roll back lock in `checkout_fast_forward()`
 + merge-recursive: always roll back lock in `merge_recursive_generic()`
 + sequencer: always roll back lock in `do_recursive_merge()`
 + sequencer: make lockfiles non-static
 (this branch is used by ma/skip-writing-unchanged-index.)

 Some codepaths used to take a lockfile and did not roll it back;
 they are automatically rolled back at program exit, so there is no
 real "breakage", but it still is a good practice to roll back when
 you are done with a lockfile.

 Will merge to 'master'.


* mk/doc-pretty-fill (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 623461b127)
 + docs/pretty-formats: fix typo '% <(<N>)' -> '%<|(<N>)'

 Docfix.

 Will merge to 'master'.


* nd/remove-ignore-env-field (2018-03-05) 5 commits
 - repository: delete ignore_env member
 - sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
 - repository.c: delete dead functions
 - repository.c: move env-related setup code back to environment.c
 - repository: initialize the_repository in main()
 (this branch is used by sb/object-store and sb/packfiles-in-repository.)


* rj/test-i18ngrep (2018-02-28) 2 commits
  (merged to 'next' on 2018-03-06 at 7ea1a2352c)
 + t5536: simplify checking of messages output to stderr
 + t4151: consolidate multiple calls to test_i18ngrep

 Test updates.

 Will merge to 'master'.


* rs/perf-repeat-thrice-by-default (2018-02-27) 1 commit
  (merged to 'next' on 2018-03-02 at 4898b3c450)
 + perf: use GIT_PERF_REPEAT_COUNT=3 by default even without config file

 Perf test regression fix.

 Will merge to 'master'.


* sb/object-store (2018-03-05) 27 commits
 - sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
 - sha1_file: allow map_sha1_file to handle arbitrary repositories
 - sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
 - sha1_file: allow open_sha1_file to handle arbitrary repositories
 - sha1_file: allow stat_sha1_file to handle arbitrary repositories
 - sha1_file: allow sha1_file_name to handle arbitrary repositories
 - sha1_file: add repository argument to sha1_loose_object_info
 - sha1_file: add repository argument to map_sha1_file
 - sha1_file: add repository argument to map_sha1_file_1
 - sha1_file: add repository argument to open_sha1_file
 - sha1_file: add repository argument to stat_sha1_file
 - sha1_file: add repository argument to sha1_file_name
 - sha1_file: allow prepare_alt_odb to handle arbitrary repositories
 - sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
 - sha1_file: add repository argument to prepare_alt_odb
 - sha1_file: add repository argument to link_alt_odb_entries
 - sha1_file: add repository argument to read_info_alternates
 - sha1_file: add repository argument to link_alt_odb_entry
 - sha1_file: add raw_object_store argument to alt_odb_usable
 - pack: move approximate object count to object store
 - pack: move prepare_packed_git_run_once to object store
 - object-store: close all packs upon clearing the object store
 - object-store: move packed_git and packed_git_mru to object store
 - object-store: free alt_odb_list
 - object-store: move alt_odb_list and alt_odb_tail to object store
 - object-store: migrate alternates struct and functions from cache.h
 - repository: introduce raw object store field
 (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)

 Refactoring the internal global data structure to make it possible
 to open multiple repositories, work with and then close them.

 Rerolled by Duy on top of a separate preliminary clean-up topic.
 The resulting structure of the topics looked very sensible.


* sb/packfiles-in-repository (2018-03-05) 12 commits
 - packfile: keep prepare_packed_git() private
 - packfile: allow find_pack_entry to handle arbitrary repositories
 - packfile: add repository argument to find_pack_entry
 - packfile: allow reprepare_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git_one to handle arbitrary repositories
 - packfile: add repository argument to reprepare_packed_git
 - packfile: add repository argument to prepare_packed_git
 - packfile: add repository argument to prepare_packed_git_one
 - packfile: allow install_packed_git to handle arbitrary repositories
 - packfile: allow rearrange_packed_git to handle arbitrary repositories
 - packfile: allow prepare_packed_git_mru to handle arbitrary repositories
 (this branch uses nd/remove-ignore-env-field and sb/object-store.)

 Refactoring of the internal global data structure continues.


* sg/test-x (2018-02-28) 11 commits
  (merged to 'next' on 2018-03-06 at ab0684b27c)
 + travis-ci: run tests with '-x' tracing
 + t/README: add a note about don't saving stderr of compound commands
 + t1510-repo-setup: mark as untraceable with '-x'
 + t9903-bash-prompt: don't check the stderr of __git_ps1()
 + t5570-git-daemon: don't check the stderr of a subshell
 + t5526: use $TRASH_DIRECTORY to specify the path of GIT_TRACE log file
 + t5500-fetch-pack: don't check the stderr of a subshell
 + t3030-merge-recursive: don't check the stderr of a subshell
 + t1507-rev-parse-upstream: don't check the stderr of a shell function
 + t: add means to disable '-x' tracing for individual test scripts
 + t: prevent '-x' tracing from interfering with test helpers' stderr

 Running test scripts under -x option of the shell is often not a
 useful way to debug them, because the error messages from the
 commands tests try to capture and inspect are contaminated by the
 tracing output by the shell.  An earlier work done to make it more
 pleasant to run tests under -x with recent versions of bash is
 extended to cover posix shells that do not support BASH_XTRACEFD.

 Will merge to 'master'.


* ab/gc-auto-in-commit (2018-03-01) 1 commit
  (merged to 'next' on 2018-03-02 at 96a5a4d629)
 + commit: run git gc --auto just before the post-commit hook

 "git commit" used to run "gc --auto" near the end, which was lost
 when the command was reimplemented in C by mistake.

 Will merge to 'master'.


* ab/pre-auto-gc-battery (2018-02-28) 1 commit
  (merged to 'next' on 2018-03-06 at ca9cb273cb)
 + hooks/pre-auto-gc-battery: allow gc to run on non-laptops

 A sample auto-gc hook (in contrib/) to skip auto-gc while on
 battery has been updated to almost always allow running auto-gc
 unless on_ac_power command is absolutely sure that we are on
 battery power (earlier, it skipped unless the command is sure that
 we are on ac power).

 Will merge to 'master'.


* ag/userdiff-go-funcname (2018-03-01) 1 commit
  (merged to 'next' on 2018-03-02 at ea404d1be9)
 + userdiff: add built-in pattern for golang

 "git diff" and friends learned funcname patterns for Go language
 source files.

 Will merge to 'master'.


* ma/skip-writing-unchanged-index (2018-03-01) 1 commit
 - write_locked_index(): add flag to avoid writing unchanged index
 (this branch uses ma/roll-back-lockfiles.)

 Internal API clean-up to allow write_locked_index() optionally skip
 writing the in-core index when it is not modified.

 May want to merge into ma/roll-back-lockfiles topic before merging
 to 'next'.


* jh/status-no-ahead-behind (2018-01-24) 4 commits
  (merged to 'next' on 2018-03-02 at 68bde8d571)
 + status: support --no-ahead-behind in long format
 + status: update short status to respect --no-ahead-behind
 + status: add --[no-]ahead-behind to status and commit for V2 format.
 + stat_tracking_info: return +1 when branches not equal

 "git status" can spend a lot of cycles to compute the relation
 between the current branch and its upstream, which can now be
 disabled with "--no-ahead-behind" option.

 Will merge to 'master'.


* nd/tilde-expand-opt-file-value (2018-02-14) 2 commits
 - init-db: change --template type to OPTION_FILENAME
 - parse-options: expand $HOME on filename options

 "git cmd --opt=~u/path/to/file" did not tilde-expand "~u" part to
 the path to the home directory of user 'u'

 Will discard.
 This may make the resulting whole more confusing, though.
 cf. <87wozffavp.fsf@evledraar.gmail.com>


* ab/perl-fixes (2018-03-05) 13 commits
 - perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS
 - Makefile: add NO_PERL_CPAN_FALLBACKS knob
 - perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
 - perl: generalize the Git::LoadCPAN facility
 - perl: move CPAN loader wrappers to another namespace
 - perl: update our copy of Mail::Address
 - perl: update our ancient copy of Error.pm
 - git-send-email: unconditionally use Net::{SMTP,Domain}
 - Git.pm: hard-depend on the File::{Temp,Spec} modules
 - gitweb: hard-depend on the Digest::MD5 5.8 module
 - Git.pm: add the "use warnings" pragma
 - Git.pm: remove redundant "use strict" from sub-package
 - perl: *.pm files should not have the executable bit

 Clean-up to various pieces of Perl code we have.

 WIll merge to 'next'.


* ds/commit-graph (2018-02-20) 13 commits
 - commit-graph: build graph from starting commits
 - commit-graph: read only from specific pack-indexes
 - commit: integrate commit graph with commit parsing
 - commit-graph: close under reachability
 - commit-graph: add core.commitGraph setting
 - commit-graph: implement --delete-expired
 - commit-graph: implement --set-latest
 - commit-graph: implement git commit-graph read
 - commit-graph: implement 'git-commit-graph write'
 - commit-graph: implement write_commit_graph()
 - commit-graph: create git-commit-graph builtin
 - graph: add commit graph design document
 - commit-graph: add format document

 Precompute and store information necessary for ancestry traversal
 in a separate file to optimize graph walking.

 Reroll exists, but it appears that there will be a further reroll.
 cf. <1519698787-190494-1-git-send-email-dstolee@microsoft.com>


* ot/ref-filter-cleanup (2018-02-21) 2 commits
  (merged to 'next' on 2018-03-02 at 3b4c39a4b5)
 + ref-filter: get rid of goto
 + ref-filter: get rid of duplicate code

 Code cleanup.

 Will merge to 'master'.


* ma/config-page-only-in-list-mode (2018-02-21) 3 commits
 - config: change default of `pager.config` to "on"
 - config: respect `pager.config` in list/get-mode only
 - t7006: add tests for how git config paginates

 In a way similar to how "git tag" learned to honor the pager
 setting only in the list mode, "git config" learned to ignore the
 pager setting when it is used for setting values (i.e. when the
 purpose of the operation is not to "show").

 Is this ready for 'next'?


* pw/add-p-recount (2018-03-05) 9 commits
  (merged to 'next' on 2018-03-06 at 68952f9bb0)
 + add -p: don't rely on apply's '--recount' option
 + add -p: fix counting when splitting and coalescing
 + add -p: calculate offset delta for edited patches
 + add -p: adjust offsets of subsequent hunks when one is skipped
 + t3701: add failing test for pathological context lines
 + t3701: don't hard code sha1 hash values
 + t3701: use test_write_lines and write_script
 + t3701: indent here documents
 + add -i: add function to format hunk header
 (this branch is used by pw/add-p-select.)

 "git add -p" has been lazy in coalescing split patches before
 passing the result to underlying "git apply", leading to corner
 case bugs; the logic to prepare the patch to be applied after hunk
 selections has been tightened.

 Will merge to 'master'.


* bp/untracked-cache-noflush (2018-02-28) 2 commits
  (merged to 'next' on 2018-03-02 at 709887971b)
 + untracked cache: use git_env_bool() not getenv() for customization
 + dir.c: don't flag the index as dirty for changes to the untracked cache

 Writing out the index file when the only thing that changed in it
 is the untracked cache information is often wasteful, and this has
 been optimized out.

 Will merge to 'master'.


* nd/diff-stat-with-summary (2018-02-27) 2 commits
  (merged to 'next' on 2018-03-06 at d543f92f5e)
 + diff: add --compact-summary
 + diff.c: refactor pprint_rename() to use strbuf

 "git diff" and friends learned "--compact-summary" that shows the
 information usually given with the "--summary" option on the same
 line as the diffstat output of the "--stat" option (which saves
 vertical space and keeps info on a single path at the same place).

 Will merge to 'master'.


* nd/parseopt-completion (2018-03-06) 44 commits
 - SQUASH???
 - completion: simplify _git_notes
 - completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
  (merged to 'next' on 2018-03-02 at d72a6525fd)
 + completion: use __gitcomp_builtin in _git_worktree
 + completion: use __gitcomp_builtin in _git_tag
 + completion: use __gitcomp_builtin in _git_status
 + completion: use __gitcomp_builtin in _git_show_branch
 + completion: use __gitcomp_builtin in _git_rm
 + completion: use __gitcomp_builtin in _git_revert
 + completion: use __gitcomp_builtin in _git_reset
 + completion: use __gitcomp_builtin in _git_replace
 + remote: force completing --mirror= instead of --mirror
 + completion: use __gitcomp_builtin in _git_remote
 + completion: use __gitcomp_builtin in _git_push
 + completion: use __gitcomp_builtin in _git_pull
 + completion: use __gitcomp_builtin in _git_notes
 + completion: use __gitcomp_builtin in _git_name_rev
 + completion: use __gitcomp_builtin in _git_mv
 + completion: use __gitcomp_builtin in _git_merge_base
 + completion: use __gitcomp_builtin in _git_merge
 + completion: use __gitcomp_builtin in _git_ls_remote
 + completion: use __gitcomp_builtin in _git_ls_files
 + completion: use __gitcomp_builtin in _git_init
 + completion: use __gitcomp_builtin in _git_help
 + completion: use __gitcomp_builtin in _git_grep
 + completion: use __gitcomp_builtin in _git_gc
 + completion: use __gitcomp_builtin in _git_fsck
 + completion: use __gitcomp_builtin in _git_fetch
 + completion: use __gitcomp_builtin in _git_difftool
 + completion: use __gitcomp_builtin in _git_describe
 + completion: use __gitcomp_builtin in _git_config
 + completion: use __gitcomp_builtin in _git_commit
 + completion: use __gitcomp_builtin in _git_clone
 + completion: use __gitcomp_builtin in _git_clean
 + completion: use __gitcomp_builtin in _git_cherry_pick
 + completion: use __gitcomp_builtin in _git_checkout
 + completion: use __gitcomp_builtin in _git_branch
 + completion: use __gitcomp_builtin in _git_apply
 + completion: use __gitcomp_builtin in _git_am
 + completion: use __gitcomp_builtin in _git_add
 + git-completion.bash: introduce __gitcomp_builtin
 + parse-options: let OPT__FORCE take optional flags argument
 + parse-options: add OPT_xxx_F() variants
 + parse-options: support --git-completion-helper

 Teach parse-options API an option to help the completion script,
 and make use of the mechanism in command line completion.

 Will merge to 'master'.


* pc/submodule-helper-foreach (2018-02-02) 5 commits
 - submodule: port submodule subcommand 'foreach' from shell to C
 - submodule foreach: document variable '$displaypath'
 - submodule foreach: clarify the '$toplevel' variable documentation
 - submodule foreach: document '$sm_path' instead of '$path'
 - submodule foreach: correct '$path' in nested submodules from a subdirectory

 Expecting a response to review comments
 e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>


* tg/worktree-add-existing-branch (2018-02-05) 3 commits
 - worktree: teach "add" to check out existing branches
 - worktree: be clearer when "add" dwim-ery kicks in
 - worktree: improve message when creating a new worktree

 "git worktree add" learned to check out an existing branch.

 Expecting a reroll.
 cf. <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com>
 cf. <CACsJy8BEKYqW+Ne_WY2RBaSbb9OKcjREtrawStj=eJsVsia_Jw@mail.gmail.com>
 The general idea is good, just end-user facing messages are found
 suboptimal.


* nd/worktree-move (2018-03-06) 8 commits
  (merged to 'next' on 2018-03-06 at a26271e7de)
 + t2028: fix minor error and issues in newly-added "worktree move" tests
  (merged to 'next' on 2018-03-02 at 5c514dfc92)
 + worktree remove: allow it when $GIT_WORK_TREE is already gone
 + worktree remove: new command
 + worktree move: refuse to move worktrees with submodules
 + worktree move: accept destination as directory
 + worktree move: new command
 + worktree.c: add update_worktree_location()
 + worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Will merge to 'master'.


* cl/send-email-reply-to (2018-03-06) 2 commits
 - send-email: support separate Reply-To address
 - send-email: rename variable for clarity
 (this branch uses np/send-email-header-parsing.)

 "git send-email" learned "--reply-to=<address>" option.

 Will merge to 'next'.


* js/rebase-recreate-merge (2018-02-23) 12 commits
 - rebase -i: introduce --recreate-merges=[no-]rebase-cousins
 - pull: accept --rebase=recreate to recreate the branch topology
 - sequencer: handle post-rewrite for merge commands
 - sequencer: make refs generated by the `label` command worktree-local
 - rebase: introduce the --recreate-merges option
 - rebase-helper --make-script: introduce a flag to recreate merges
 - sequencer: fast-forward merge commits, if possible
 - sequencer: introduce the `merge` command
 - sequencer: introduce new commands to reset the revision
 - git-rebase--interactive: clarify arguments
 - sequencer: make rearrange_squash() a bit more obvious
 - sequencer: avoid using errno clobbered by rollback_lock_file()

 "git rebase" learned "--recreate-merges" to transplant the whole
 topology of commit graph elsewhere.

 Will merge to 'next'.


* bw/protocol-v2 (2018-03-02) 36 commits
 - SQUASH???
 - remote-curl: don't request v2 when pushing
 - remote-curl: implement stateless-connect command
 - http: eliminate "# service" line when using protocol v2
 - http: don't always add Git-Protocol header
 - http: allow providing extra headers for http requests
 - remote-curl: store the protocol version the server responded with
 - remote-curl: create copy of the service name
 - pkt-line: add packet_buf_write_len function
 - transport-helper: introduce stateless-connect
 - transport-helper: refactor process_connect_service
 - transport-helper: remove name parameter
 - connect: don't request v2 when pushing
 - connect: refactor git_connect to only get the protocol version once
 - fetch-pack: support shallow requests
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
 - test-pkt-line: introduce a packet-line test helper
 - protocol: introduce enum protocol_version value protocol_v2
 - transport: store protocol version
 - connect: discover protocol version outside of get_remote_heads
 - connect: convert get_remote_heads to use struct packet_reader
 - transport: use get_refs_via_connect to get refs
 - upload-pack: factor out processing lines
 - upload-pack: convert to a builtin
 - pkt-line: add delim packet support
 - pkt-line: allow peeking a packet line without consuming it
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.


* ls/checkout-encoding (2018-03-06) 8 commits
 - convert: add round trip check based on 'core.checkRoundtripEncoding'
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: check for detectable errors in UTF encodings
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).

 Expecting a reroll; it is almost there, though.
 cf. <570D707A-DD9E-4397-8155-E8B3C3D09760@gmail.com>


* en/rename-directory-detection (2018-02-27) 29 commits
  (merged to 'next' on 2018-03-06 at d42470f86e)
 + merge-recursive: ensure we write updates for directory-renamed file
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

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* ot/cat-batch-format (2018-02-12) 23 commits
 . cat-file: update of docs
 . cat-file: tests for new atoms added
 . for-each-ref: tests for new atoms added
 . ref-filter: unifying formatting of cat-file opts
 . ref-filter: make populate_value() internal again
 . cat-file: reuse printing logic from ref-filter
 . ref-filter: make valid_atom general again
 . ref-filter: make cat_file_info independent
 . cat-file: move skip_object_info into ref-filter
 . ref_filter: add is_atom_used function
 . ref-filter: get rid of mark_atom_in_object_info()
 . cat-file: start reusing populate_value()
 . ref-filter: rename field in ref_array_item stuct
 . ref-filter: make populate_value() global
 . cat-file: start use ref_array_item struct
 . ref-filter: reuse parse_ref_filter_atom()
 . cat-file: start migrating formatting to ref-filter
 . cat-file: split expand_atom() into 2 functions
 . cat-file: move struct expand_data into ref-filter
 . ref-filter: make valid_atom as function parameter
 . cat-file: reuse struct ref_format
 . ref-filter: add return value to some functions
 . ref-filter: get rid of goto

 Teach "cat-file --batch" to reuse the formatting machinery shared
 by for-each-ref, branch --list, and tag --list.

 Discarded, as a rebooted effort is beginning elsewhere.
 Allocates flex-array on stack, etc.
 cf. <58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com>
