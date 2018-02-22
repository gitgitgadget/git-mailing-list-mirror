Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A811F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBVAbp (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:31:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53983 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBVAbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:31:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id t74so687364wme.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=WP7xZ2XRdpK4/4tR1pfCvY8wtfgkqRouRBs194qWTNA=;
        b=J5kCyT6J/sRSNLqxosmfMWj8FrTsays4FRt6y13pnU9l6TPbi/hGLVvxbZKOcMAD9o
         s8DXLbU4pftnV5K6lLBEJhIvSKbvlnEQeQfmINh/GSuYU5s9FPiy4LKYPQs4zAQxkOMk
         a14fb0+kBqCT04aiZ5wUwHV8do6RuHW3hoaWpq7TgZP88WfYeAGjlGb/toAid97oc/UI
         rTOd4NB4erRtkiGagYZwl7nso2ADHVFb8Kq5tfLW9itN9+VdZKxTpCOwXtzeq8dpiR18
         L1RCrKMqcsAClZ1OJcyRxEVNF7DeszcgujQuwU2m80QjavzEdSuQfk83f/fVRgVvFKy5
         P92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=WP7xZ2XRdpK4/4tR1pfCvY8wtfgkqRouRBs194qWTNA=;
        b=C09dSFNHuy3qWgpS6uVimr3cKEs/rZaWVNb+wwNYy2V+8Zv1awEpeX8fVkYH9lIoWg
         yPOLcF32WXzYyjH7XZ/jeRYWSRGKf7meiKiNpMNHbiG79Qgs050ePZutzP/qbatoZfRQ
         DF1xCC/v9aUlzUWH2dID1wnL8Ep4gQguvgLWV0t/xmcxgR1mA29oZc1V2Po8/6LKeSJm
         tjjwZr9yvkIpSz6jrNF7AveIRXNU2AjNFGfxB6Wxkkv8mHw86rYEUOyK4c8+vnvLiVVN
         Iv16PgcKMLdKcopRrsCCa66UuumUoY+dnsuuuqXTsTLTj82qRkiqNhRKiTS2nDLIAQ0a
         GXbQ==
X-Gm-Message-State: APf1xPAOSYmuw4cag3FiS6FDzg5opbuZScagdBoJoQ4/TRi4+GFFfT/5
        1/drRY0St1nZkDqKrvcbF1aqv5KD
X-Google-Smtp-Source: AH8x224VKp4iueCe0/h8ncxK4Eb3p7rPA6cRersh6Dp6+XVOozefyh/CZGI8rmCdBugJbqrRGj0snA==
X-Received: by 10.28.237.23 with SMTP id l23mr3510734wmh.113.1519259498125;
        Wed, 21 Feb 2018 16:31:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q12sm29923631wrg.37.2018.02.21.16.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:31:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2018, #03; Wed, 21)
X-master-at: e3a80781f5932f5fea12a49eb06f3ade4ed8945c
X-next-at: 2e18187dfdb805eb42926ca430828b89b45f5da7
Date:   Wed, 21 Feb 2018 16:31:36 -0800
Message-ID: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
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

* ab/sha1dc-build (2017-12-08) 3 commits
  (merged to 'next' on 2018-02-08 at ba9ff2b836)
 + sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
 + Makefile: under "make dist", include the sha1collisiondetection submodule
 + Makefile: don't error out under DC_SHA1_EXTERNAL if DC_SHA1_SUBMODULE=auto

 Push the submodule version of collision-detecting SHA-1 hash
 implementation a bit harder on builders.


* ab/wildmatch-tests (2018-01-30) 10 commits
  (merged to 'next' on 2018-02-08 at f999a3d732)
 + wildmatch test: mark test as EXPENSIVE_ON_WINDOWS
 + test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
 + wildmatch test: create & test files on disk in addition to in-memory
 + wildmatch test: perform all tests under all wildmatch() modes
 + wildmatch test: use test_must_fail, not ! for test-wildmatch
 + wildmatch test: remove dead fnmatch() test code
 + wildmatch test: use a paranoia pattern from nul_match()
 + wildmatch test: don't try to vertically align our output
 + wildmatch test: use more standard shell style
 + wildmatch test: indent with tabs, not spaces

 More tests for wildmatch functions.


* bc/hash-algo (2018-02-09) 13 commits
  (merged to 'next' on 2018-02-09 at 4437f3f132)
 + hash: update obsolete reference to SHA1_HEADER
  (merged to 'next' on 2018-02-08 at 18f36d12ed)
 + bulk-checkin: abstract SHA-1 usage
 + csum-file: abstract uses of SHA-1
 + csum-file: rename sha1file to hashfile
 + read-cache: abstract away uses of SHA-1
 + pack-write: switch various SHA-1 values to abstract forms
 + pack-check: convert various uses of SHA-1 to abstract forms
 + fast-import: switch various uses of SHA-1 to the_hash_algo
 + sha1_file: switch uses of SHA-1 to the_hash_algo
 + builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
 + builtin/index-pack: improve hash function abstraction
 + hash: create union for hash context allocation
 + hash: move SHA-1 macros to hash.h

 More abstraction of hash function from the codepath.


* cc/perf-aggregate (2018-02-02) 3 commits
  (merged to 'next' on 2018-02-08 at d8f074e6fb)
 + perf/aggregate: sort JSON fields in output
 + perf/aggregate: add --reponame option
 + perf/aggregate: add --subsection option

 "make perf" enhancement.


* en/merge-recursive-fixes (2018-01-19) 3 commits
  (merged to 'next' on 2018-02-08 at c254292070)
 + merge-recursive: add explanation for src_entry and dst_entry
 + merge-recursive: fix logic ordering issue
 + Tighten and correct a few testcases for merging and cherry-picking
 (this branch is used by en/rename-directory-detection.)


* gs/rebase-allow-empty-message (2018-02-07) 1 commit
  (merged to 'next' on 2018-02-08 at 9d81a2496c)
 + rebase: add --allow-empty-message option

 "git rebase" learned to take "--allow-empty-message" option.


* jc/worktree-add-short-help (2018-01-17) 1 commit
  (merged to 'next' on 2018-02-08 at 9f59ca72ab)
 + worktree: say that "add" takes an arbitrary commit in short-help

 Error message fix.


* jt/fsck-code-cleanup (2018-01-23) 1 commit
  (merged to 'next' on 2018-02-08 at 199ad41486)
 + fsck: fix leak when traversing trees

 Plug recently introduced leaks in fsck.


* kg/packed-ref-cache-fix (2018-01-24) 6 commits
  (merged to 'next' on 2018-02-08 at 370f06a565)
 + packed_ref_cache: don't use mmap() for small files
 + load_contents(): don't try to mmap an empty file
 + packed_ref_iterator_begin(): make optimization more general
 + find_reference_location(): make function safe for empty snapshots
 + create_snapshot(): use `xmemdupz()` rather than a strbuf
 + struct snapshot: store `start` rather than `header_len`

 Avoid mmapping small files while using packed refs (especially ones
 with zero size, which would cause later munmap() to fail).
 A change to a binsearch loop to work around picky complers was
 unnecessarily hard to reason about, but it should do.


* lw/daemon-log-destination (2018-02-05) 1 commit
  (merged to 'next' on 2018-02-08 at da91bd56f4)
 + daemon: add --log-destination=(stderr|syslog|none)

 The log from "git daemon" can be redirected with a new option; one
 relevant use case is to send the log to standard error (instead of
 syslog) when running it from inetd.


* nd/format-patch-stat-width (2018-02-02) 2 commits
  (merged to 'next' on 2018-02-08 at c03e8a084e)
 + format-patch: reduce patch diffstat width to 72
 + format-patch: keep cover-letter diffstat wrapped in 72 columns

 "git format-patch" learned to give 72-cols to diffstat, which is
 consistent with other line length limits the subcommand uses for
 its output meant for e-mails.


* nd/ignore-glob-doc-update (2018-02-02) 1 commit
  (merged to 'next' on 2018-02-08 at 22ba92e49b)
 + gitignore.txt: elaborate shell glob syntax

 Doc update.


* nd/trace-index-ops (2018-02-02) 1 commit
  (merged to 'next' on 2018-02-08 at 91e362b26a)
 + trace: measure where the time is spent in the index-heavy operations


* po/object-id (2018-01-30) 12 commits
  (merged to 'next' on 2018-02-08 at 701311e8ea)
 + sha1_file: rename hash_sha1_file_literally
 + sha1_file: convert write_loose_object to object_id
 + sha1_file: convert force_object_loose to object_id
 + sha1_file: convert write_sha1_file to object_id
 + notes: convert write_notes_tree to object_id
 + notes: convert combine_notes_* to object_id
 + commit: convert commit_tree* to object_id
 + match-trees: convert splice_tree to object_id
 + cache: clear whole hash buffer with oidclr
 + sha1_file: convert hash_sha1_file to object_id
 + dir: convert struct sha1_stat to use object_id
 + sha1_file: convert pretend_sha1_file to object_id

 Conversion from uchar[20] to struct object_id continues.


* rs/cocci-strbuf-addf-to-addstr (2018-02-02) 1 commit
  (merged to 'next' on 2018-02-08 at 0016008a97)
 + cocci: simplify check for trivial format strings


* sb/pull-rebase-submodule (2018-01-25) 1 commit
  (merged to 'next' on 2018-02-08 at 38fa97f855)
 + builtin/pull: respect verbosity settings in submodules

 "git pull --rebase" did not pass verbosity setting down when
 recursing into a submodule.


* sg/test-i18ngrep (2018-02-08) 9 commits
  (merged to 'next' on 2018-02-08 at e83eb33909)
 + t: make 'test_i18ngrep' more informative on failure
 + t: validate 'test_i18ngrep's parameters
 + t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
 + t5536: let 'test_i18ngrep' read the file without redirection
 + t5510: consolidate 'grep' and 'test_i18ngrep' patterns
 + t4001: don't run 'git status' upstream of a pipe
 + t6022: don't run 'git merge' upstream of a pipe
 + t5812: add 'test_i18ngrep's missing filename parameter
 + t5541: add 'test_i18ngrep's missing filename parameter

 Test fixes.


* tg/reset-hard-show-head-with-pretty (2018-02-02) 1 commit
  (merged to 'next' on 2018-02-08 at 596a4ec00d)
 + reset --hard: make use of the pretty machinery

 The way "git reset --hard" reports the commit the updated HEAD
 points at is made consistent with the way how the commit title is
 generated by the other parts of the system.  This matters when the
 title is spread across physically multiple lines.

--------------------------------------------------
[New Topics]

* bp/fsmonitor (2018-02-14) 1 commit
  (merged to 'next' on 2018-02-14 at 5c508858fb)
 + fsmonitor: update documentation to remove reference to invalid config settings

 Doc update for a recently added feature.

 Will merge to 'master'.


* jk/sq-dequote-on-bogus-input (2018-02-14) 1 commit
  (merged to 'next' on 2018-02-14 at 75d4f1eaf8)
 + sq_dequote: fix extra consumption of source string

 Code to unquote single-quoted string (used in the parser for
 configuration files, etc.) did not diagnose bogus input correctly
 and produced bogus results instead.

 Will merge to 'master'.


* jk/test-hashmap-updates (2018-02-14) 6 commits
  (merged to 'next' on 2018-02-14 at a61a9bd8f0)
 + test-hashmap: use "unsigned int" for hash storage
 + test-hashmap: simplify alloc_test_entry
 + test-hashmap: use strbuf_getline rather than fgets
 + test-hashmap: use xsnprintf rather than snprintf
 + test-hashmap: check allocation computation for overflow
 + test-hashmap: use ALLOC_ARRAY rather than bare malloc

 Code clean-up.

 Will merge to 'master'.


* nd/am-quit (2018-02-14) 1 commit
  (merged to 'next' on 2018-02-21 at 9a9cb40c2f)
 + am: support --quit

 "git am" has learned "--quit" option, in addition to the existing
 "--abort" option; having the pair mirrors a few other commands like
 "rebase" and "cherry-pick".

 Will merge to 'master'.


* nd/tilde-expand-opt-file-value (2018-02-14) 2 commits
 - init-db: change --template type to OPTION_FILENAME
 - parse-options: expand $HOME on filename options

 "git cmd --opt=~u/path/to/file" did not tilde-expand "~u" part to
 the path to the home directory of user 'u'

 Will discard.
 This may make the resulting whole more confusing, though.
 cf. <87wozffavp.fsf@evledraar.gmail.com>


* rd/typofix (2018-02-14) 2 commits
  (merged to 'next' on 2018-02-14 at e770601de4)
 + Correct mispellings of ".gitmodule" to ".gitmodules"
 + t/: correct obvious typo "detahced"

 Typofix.

 Will merge to 'master'.


* jc/allow-ff-merging-kept-tags (2018-02-16) 1 commit
 - merge: allow fast-forward when merging a tracked tag

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

 Will merge to 'next'.


* ab/perl-fixes (2018-02-15) 2 commits
 - perl: move CPAN loader wrappers to another namespace
 - perl: *.pm files should not have the executable bit

 Only the first few of a series of several small patches.

 Expecting a reroll.


* ab/simplify-perl-makefile (2018-02-15) 1 commit
 - Makefile: generate Git(3pm) as dependency of the 'doc' and 'man' targets

 Hotfix for a topic already in 'master'.

 Will merge to 'next'.


* es/worktree-add-post-checkout-hook (2018-02-15) 1 commit
  (merged to 'next' on 2018-02-21 at 6ef6a130bf)
 + worktree: add: fix 'post-checkout' not knowing new worktree location

 "git worktree add" learned to run the post-checkout hook, just like
 "git clone" runs it upon the initial checkout.

 Will merge to 'master'.


* sb/status-doc-fix (2018-02-15) 1 commit
  (merged to 'next' on 2018-02-21 at 5e68f3dac8)
 + Documentation/git-status: clarify status table for porcelain mode

 Docfix.

 Will merge to 'master'.


* tk/apply-dev-null-verify-name-fix (2018-02-15) 2 commits
  (merged to 'next' on 2018-02-21 at dab449203b)
 + apply: handle Subversion diffs with /dev/null gracefully
 + apply: demonstrate a problem applying svn diffs

 Many places in "git apply" knew that "/dev/null" that signals
 "there is no such file on this side of the diff" can be followed by
 whitespace and garbage when parsing a patch, except for one, which
 made an otherwise valid patch (e.g. ones from subversion) rejected.

 Will merge to 'master'.


* gs/test-unset-xdg-cache-home (2018-02-16) 1 commit
  (merged to 'next' on 2018-02-21 at 9aec46d404)
 + test-lib.sh: unset XDG_CACHE_HOME

 Test update.

 Will merge to 'master'.


* tg/worktree-create-tracking (2018-02-16) 2 commits
  (merged to 'next' on 2018-02-21 at 3e00a10cd8)
 + git-worktree.txt: fix indentation of example and text of 'add' command
 + git-worktree.txt: fix missing ")" typo

 Hotfix for a recent topic.

 Will merge to 'master'.


* jk/push-options-via-transport-fix (2018-02-20) 2 commits
  (merged to 'next' on 2018-02-21 at a037cbfa2b)
 + remote-curl: unquote incoming push-options
 + t5545: factor out http repository setup

 "git push" over http transport did not unquote the push-options
 correctly.

 Will merge to 'master'.


* tz/do-not-clean-spec-file (2018-02-17) 1 commit
  (merged to 'next' on 2018-02-21 at c1336418a8)
 + Makefile: remove *.spec from clean target

 We no longer create any *.spec file, so "make clean" should not
 remove it.

 Will merge to 'master'.


* bw/doc-submodule-recurse-config-with-clone (2018-02-21) 1 commit
 - submodule: indicate that 'submodule.recurse' doesn't apply to clone

 Doc update.

 Will merge to 'next'.


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
 (this branch uses jt/binsearch-with-fanout.)


* ot/ref-filter-cleanup (2018-02-21) 2 commits
 - ref-filter: get rid of goto
 - ref-filter: get rid of duplicate code

--------------------------------------------------
[Stalled]

* np/send-email-header-parsing (2017-12-15) 1 commit
 - send-email: extract email-parsing code into a subroutine

 Code refactoring.

 Undecided but inclined to drop.  A "refactor" without the code that
 benefit from the refactoring is hard to tell from code churn whose
 only effect is potential to introduce bugs.


* sg/travis-build-during-script-phase (2018-01-08) 1 commit
 - travis-ci: build Git during the 'script' phase

 So... what do we want to do with this thing?


* jh/status-no-ahead-behind (2018-01-24) 4 commits
 - status: support --no-ahead-behind in long format
 - status: update short status to respect --no-ahead-behind
 - status: add --[no-]ahead-behind to status and commit for V2 format.
 - stat_tracking_info: return +1 when branches not equal

 "git status" can spend a lot of cycles to compute the relation
 between the current branch and its upstream, which can now be
 disabled with "--no-ahead-behind" option.

 At v5; is this ready for 'next'?


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

--------------------------------------------------
[Cooking]

* bp/name-hash-dirname-fix (2018-02-08) 1 commit
  (merged to 'next' on 2018-02-14 at 2f564fb4b3)
 + name-hash: properly fold directory names in adjust_dirname_case()

 "git add" files in the same directory, but spelling the directory
 path in different cases on case insensitive filesystem, corrupted
 the name hash data structure and led to unexpected results.  This
 has been corrected.

 Will merge to 'master'.


* jk/doc-do-not-write-extern (2018-02-08) 1 commit
  (merged to 'next' on 2018-02-14 at e55b5127de)
 + CodingGuidelines: mention "static" and "extern"

 Devdoc update.

 Will merge to 'master'.


* jk/gettext-poison (2018-02-08) 2 commits
  (merged to 'next' on 2018-02-14 at cca3719a59)
 + git-sh-i18n: check GETTEXT_POISON before USE_GETTEXT_SCHEME
 + t0205: drop redundant test

 Test updates.

 Will merge to 'master'.


* js/fix-merge-arg-quoting-in-rebase-p (2018-02-08) 1 commit
  (merged to 'next' on 2018-02-14 at 27ebf001a1)
 + rebase -p: fix incorrect commit message when calling `git merge`.

 "git rebase -p" mangled log messages of a merge commit, which is
 now fixed.

 Will merge to 'master'.


* js/packet-read-line-check-null (2018-02-08) 2 commits
  (merged to 'next' on 2018-02-14 at 6ba237b284)
 + always check for NULL return from packet_read_line()
 + correct error messages for NULL packet_read_line()

 Some low level protocol codepath could crash when they get an
 unexpected flush packet, which is now fixed.

 Will merge to 'master'.


* sb/color-h-cleanup (2018-02-13) 1 commit
 - color.h: document and modernize header
 (this branch is used by sb/blame-color.)

 Devdoc update.

 Will merge to 'next'.


* ab/untracked-cache-invalidation-docs (2018-02-09) 2 commits
  (merged to 'next' on 2018-02-14 at 11d2d07c4a)
 + update-index doc: note the caveat with "could not open..."
 + update-index doc: note a fixed bug in the untracked cache
 (this branch uses nd/fix-untracked-cache-invalidation.)

 Doc update to warn against remaining bugs in untracked cache.

 Will merge to 'master'.


* as/ll-i18n (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-14 at b30154a04c)
 + Mark messages for translations

 Some messages in low level start-up codepath have been i18n-ized.

 Will merge to 'master'.


* bc/doc-interpret-trailers-grammofix (2018-02-13) 1 commit
  (merged to 'next' on 2018-02-14 at 940e6dc7a5)
 + docs/interpret-trailers: fix agreement error

 Docfix.

 Will merge to 'master'.


* jk/t0002-simplify (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at a7a24f5f29)
 + t0002: simplify error checking

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

 Waiting for discussion to conclude.


* ot/cat-batch-format (2018-02-12) 23 commits
 - cat-file: update of docs
 - cat-file: tests for new atoms added
 - for-each-ref: tests for new atoms added
 - ref-filter: unifying formatting of cat-file opts
 - ref-filter: make populate_value() internal again
 - cat-file: reuse printing logic from ref-filter
 - ref-filter: make valid_atom general again
 - ref-filter: make cat_file_info independent
 - cat-file: move skip_object_info into ref-filter
 - ref_filter: add is_atom_used function
 - ref-filter: get rid of mark_atom_in_object_info()
 - cat-file: start reusing populate_value()
 - ref-filter: rename field in ref_array_item stuct
 - ref-filter: make populate_value() global
 - cat-file: start use ref_array_item struct
 - ref-filter: reuse parse_ref_filter_atom()
 - cat-file: start migrating formatting to ref-filter
 - cat-file: split expand_atom() into 2 functions
 - cat-file: move struct expand_data into ref-filter
 - ref-filter: make valid_atom as function parameter
 - cat-file: reuse struct ref_format
 - ref-filter: add return value to some functions
 - ref-filter: get rid of goto

 Teach "cat-file --batch" to reuse the formatting machinery shared
 by for-each-ref, branch --list, and tag --list.

 Allocates flex-array on stack, etc.
 cf. <58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com>


* rj/sparse-updates (2018-02-12) 2 commits
  (merged to 'next' on 2018-02-14 at 072df8ed5b)
 + Makefile: suppress a sparse warning for pack-revindex.c
 + config.mak.uname: remove SPARSE_FLAGS setting for cygwin

 Devtool update.

 Will merge to 'master'.


* rs/check-ignore-multi (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at 43cb0704af)
 + check-ignore: fix mix of directories and other file types

 "git check-ignore" with multiple paths got confused when one is a
 file and the other is a directory, which has been fixed.

 Will merge to 'master'.


* sb/describe-blob (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at 23e4c13944)
 + describe: confirm that blobs actually exist

 "git describe $garbage" stopped giving any errors when the garbage
 happens to be a string with 40 hexadecimal letters.

 Will merge to 'master'.


* sg/doc-test-must-fail-args (2018-02-12) 1 commit
  (merged to 'next' on 2018-02-14 at 28662d145b)
 + t: document 'test_must_fail ok=<signal-name>'

 Devdoc update.

 Will merge to 'master'.


* sg/t6300-modernize (2018-02-13) 1 commit
 - t6300-for-each-ref: fix "more than one quoting style" tests

 Test update.

 Will merge to 'next'.


* xz/send-email-batch-size (2018-02-12) 1 commit
 - send-email: error out when relogin delay is missing

 "git send-email" learned to complain when the batch-size option is
 not defined when the relogin-delay option is, since these two are
 mutually required.

 Will merge to 'next'.


* pw/add-p-recount (2018-02-20) 9 commits
 - add -p: don't rely on apply's '--recount' option
 - add -p: fix counting when splitting and coalescing
 - add -p: calculate offset delta for edited patches
 - add -p: adjust offsets of subsequent hunks when one is skipped
 - t3701: add failing test for pathological context lines
 - t3701: don't hard code sha1 hash values
 - t3701: use test_write_lines and write_script
 - t3701: indent here documents
 - add -i: add function to format hunk header

 "git add -p" has been lazy in coalescing split patches before
 passing the result to underlying "git apply", leading to corner
 case bugs; the logic to prepare the patch to be applied after hunk
 selections has been tightened.

 Will merge to 'next'.


* pw/add-p-single (2018-02-13) 3 commits
 - add -p: improve error messages
 - add -p: only bind search key if there's more than one hunk
 - add -p: only display help for active keys

 "git add -p" used to offer "/" (look for a matching hunk) as a
 choice, even there was only one hunk, which has been corrected.
 Also the single-key help is now given only for keys that are
 enabled (e.g. help for '/' won't be shown when there is only one
 hunk).

 Will merge to 'next'.


* bp/untracked-cache-noflush (2018-02-05) 1 commit
 - dir.c: don't flag the index as dirty for changes to the untracked cache

 Writing out the index file when the only thing that changed in it
 is the untracked cache information is often wasteful, and this has
 been optimized out.

 Waiting for the discussion to finish.
 cf. <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>


* jc/blame-missing-path (2018-02-07) 1 commit
  (merged to 'next' on 2018-02-14 at 883d266e1e)
 + blame: tighten command line parser

 "git blame HEAD COPYING" in a bare repository failed to run, while
 "git blame HEAD -- COPYING" run just fine.  This has been corrected.

 Will merge to 'master'.


* jt/binsearch-with-fanout (2018-02-15) 2 commits
  (merged to 'next' on 2018-02-15 at 7648891022)
 + packfile: refactor hash search with fanout table
 + packfile: remove GIT_DEBUG_LOOKUP log statements
 (this branch is used by ds/commit-graph.)

 Refactor the code to binary search starting from a fan-out table
 (which is how the packfile is indexed with object names) into a
 reusable helper.

 Will merge to 'master'.


* nd/diff-stat-with-summary (2018-02-02) 2 commits
 - diff: add --stat-with-summary
 - diff.c: refactor pprint_rename() to use strbuf

 Waiting for the discussion to finish.


* nd/parseopt-completion (2018-02-09) 41 commits
 - completion: use __gitcomp_builtin in _git_worktree
 - completion: use __gitcomp_builtin in _git_tag
 - completion: use __gitcomp_builtin in _git_status
 - completion: use __gitcomp_builtin in _git_show_branch
 - completion: use __gitcomp_builtin in _git_rm
 - completion: use __gitcomp_builtin in _git_revert
 - completion: use __gitcomp_builtin in _git_reset
 - completion: use __gitcomp_builtin in _git_replace
 - remote: force completing --mirror= instead of --mirror
 - completion: use __gitcomp_builtin in _git_remote
 - completion: use __gitcomp_builtin in _git_push
 - completion: use __gitcomp_builtin in _git_pull
 - completion: use __gitcomp_builtin in _git_notes
 - completion: use __gitcomp_builtin in _git_name_rev
 - completion: use __gitcomp_builtin in _git_mv
 - completion: use __gitcomp_builtin in _git_merge_base
 - completion: use __gitcomp_builtin in _git_merge
 - completion: use __gitcomp_builtin in _git_ls_remote
 - completion: use __gitcomp_builtin in _git_ls_files
 - completion: use __gitcomp_builtin in _git_init
 - completion: use __gitcomp_builtin in _git_help
 - completion: use __gitcomp_builtin in _git_grep
 - completion: use __gitcomp_builtin in _git_gc
 - completion: use __gitcomp_builtin in _git_fsck
 - completion: use __gitcomp_builtin in _git_fetch
 - completion: use __gitcomp_builtin in _git_difftool
 - completion: use __gitcomp_builtin in _git_describe
 - completion: use __gitcomp_builtin in _git_config
 - completion: use __gitcomp_builtin in _git_commit
 - completion: use __gitcomp_builtin in _git_clone
 - completion: use __gitcomp_builtin in _git_clean
 - completion: use __gitcomp_builtin in _git_cherry_pick
 - completion: use __gitcomp_builtin in _git_checkout
 - completion: use __gitcomp_builtin in _git_branch
 - completion: use __gitcomp_builtin in _git_apply
 - completion: use __gitcomp_builtin in _git_am
 - completion: use __gitcomp_builtin in _git_add
 - git-completion.bash: introduce __gitcomp_builtin
 - parse-options: let OPT__FORCE take optional flags argument
 - parse-options: add OPT_xxx_F() variants
 - parse-options: support --git-completion-helper

 Teach parse-options API an option to help the completion script,
 and make use of the mechanism in command line completion.

 Will merge to 'next'.


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


* nm/tag-edit (2018-02-07) 1 commit
 - tag: add --edit option

 "git tag" learned an explicit "--edit" option that allows the
 message given via "-m" and "-F" to be further edited.

 Will merge to 'next'.

* sm/mv-dry-run-update (2018-02-07) 2 commits
 - mv: remove unneeded 'if (!show_only)'
 - t7001: add test case for --dry-run

 Code clean-up.

 Will merge to 'next'.


* ab/fetch-prune (2018-02-09) 17 commits
 - fetch: make the --prune-tags work with <url>
 - fetch: add a --prune-tags option and fetch.pruneTags config
 - fetch tests: add scaffolding for the new fetch.pruneTags
 - git-fetch & config doc: link to the new PRUNING section
 - git remote doc: correct dangerous lies about what prune does
 - git fetch doc: add a new section to explain the ins & outs of pruning
 - fetch tests: fetch <url> <spec> as well as fetch [<remote>]
 - fetch tests: expand case/esac for later change
 - fetch tests: double quote a variable for interpolation
 - fetch tests: test --prune and refspec interaction
 - fetch tests: add a tag to be deleted to the pruning tests
 - fetch tests: re-arrange arguments for future readability
 - fetch tests: refactor in preparation for testing tag pruning
 - remote: add a macro for "refs/tags/*:refs/tags/*"
 - fetch: stop accessing "remote" variable indirectly
 - fetch: trivially refactor assignment to ref_nr
 - fetch: don't redundantly NULL something calloc() gave us

 Clarify how configured fetch refspecs interact with the "--prune"
 option of "git fetch", and also add a handy short-hand for getting
 rid of stale tags that are locally held.


* bw/c-plus-plus (2018-02-14) 38 commits
 - fixup! diff: rename 'this' variables
 - replace: rename 'new' variables
 - trailer: rename 'template' variables
 - tempfile: rename 'template' variables
 - wrapper: rename 'template' variables
 - environment: rename 'namespace' variables
 - diff: rename 'template' variables
 - environment: rename 'template' variables
 - init-db: rename 'template' variables
 - unpack-trees: rename 'new' variables
 - trailer: rename 'new' variables
 - submodule: rename 'new' variables
 - split-index: rename 'new' variables
 - remote: rename 'new' variables
 - ref-filter: rename 'new' variables
 - read-cache: rename 'new' variables
 - line-log: rename 'new' variables
 - imap-send: rename 'new' variables
 - http: rename 'new' variables
 - entry: rename 'new' variables
 - diffcore-delta: rename 'new' variables
 - diff: rename 'new' variables
 - diff-lib: rename 'new' variable
 - commit: rename 'new' variables
 - combine-diff: rename 'new' variables
 - remote: rename 'new' variables
 - reflog: rename 'new' variables
 - pack-redundant: rename 'new' variables
 - help: rename 'new' variables
 - checkout: rename 'new' variables
 - apply: rename 'new' variables
 - apply: rename 'try' variables
 - diff: rename 'this' variables
 - rev-parse: rename 'this' variable
 - pack-objects: rename 'this' variables
 - blame: rename 'this' variables
 - object: rename function 'typename' to 'type_name'
 - object_info: change member name from 'typename' to 'type_name'

 Avoid using identifiers that clash with C++ keywords.  Even though
 it is not a goal to compile Git with C++ compilers, changes like
 this help use of code analysis tools that targets C++ on our
 codebase.

 Is the 'fixup!' cleanly squashable to the problematic one, or does
 this series require another reroll to get it in a good enough shape?


* nd/rebase-show-current-patch (2018-02-12) 3 commits
 - rebase: introduce and use pseudo-ref REBASE_HEAD
 - rebase: add --show-current-patch
 - am: add --show-current-patch

 The new "--show-current-patch" option gives an end-user facing way
 to get the diff being applied when "git rebase" (and "git am")
 stops with a conflict.

 Will merge to 'next'.


* nd/worktree-move (2018-02-12) 7 commits
 - worktree remove: allow it when $GIT_WORK_TREE is already gone
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20180124095357.19645-1-pclouds@gmail.com>


* cl/send-email-reply-to (2018-01-17) 2 commits
 - send-email: support separate "Reply-To" address
 - send-email: rename variables for "In-reply-to" to $foo_in_reply_to

 "git send-email" learned "--reply-to=<address>" option.

 May want to get the log messages updated.
 cf. <CAN0heSqxmLoh33i65JPhyQbmPaAcJcwrTCO+ZD4eb+qh8Pf8+w@mail.gmail.com>


* js/rebase-recreate-merge (2018-02-12) 12 commits
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

 Is this ready for 'next'?


* bw/protocol-v2 (2018-02-07) 35 commits
 - remote-curl: don't request v2 when pushing
 - remote-curl: implement stateless-connect command
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
 - upload-pack: support shallow requests
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
 - pkt-line: introduce struct packet_reader
 - pkt-line: introduce packet_read_with_status

 The beginning of the next-gen transfer protocol.


* ls/checkout-encoding (2018-02-15) 7 commits
 - convert: add round trip check based on 'core.checkRoundtripEncoding'
 - convert: add tracing for 'working-tree-encoding' attribute
 - convert: add 'working-tree-encoding' attribute
 - utf8: add function to detect a missing UTF-16/32 BOM
 - utf8: add function to detect prohibited UTF-16/32 BOM
 - strbuf: add xstrdup_toupper()
 - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()

 The new "checkout-encoding" attribute can ask Git to convert the
 contents to the specified encoding when checking out to the working
 tree (and the other way around when checking in).

 Expecting a reroll.
 The code and general design looked ready.  The documentation needs
 to be refined to unconfuse general audience.
 cf. <xmqq1shk7o2y.fsf@gitster-ct.c.googlers.com>


* sb/blame-color (2018-02-13) 3 commits
 - builtin/blame: highlight recently changed lines
 - builtin/blame: add option to color metadata fields separately
 - builtin/blame: dim uninteresting metadata
 (this branch uses sb/color-h-cleanup.)

 Expecting a reroll.
 cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
 error messages are funny, can segfault, ...


* nd/fix-untracked-cache-invalidation (2018-02-07) 5 commits
  (merged to 'next' on 2018-02-08 at 23bd5a5d2d)
 + dir.c: ignore paths containing .git when invalidating untracked cache
 + dir.c: stop ignoring opendir() error in open_cached_dir()
 + dir.c: fix missing dir invalidation in untracked code
 + dir.c: avoid stat() in valid_cached_dir()
 + status: add a failing test showing a core.untrackedCache bug
 (this branch is used by ab/untracked-cache-invalidation-docs.)

 Some bugs around "untracked cache" feature have been fixed.

 Will merge to 'master'.
 Seems to uncover bad untracked cache information a bit too loudly,
 for which there is ab/untracked-cache-invalidation-docs topic.
 cf. <87d11omi2o.fsf@evledraar.gmail.com>
 They have to graduate together.


* en/rename-directory-detection (2018-02-14) 29 commits
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

 Rename detection logic in "diff" family that is used in "merge" has
 learned to guess when all of x/a, x/b and x/c have moved to z/a,
 z/b and z/c, it is likely that x/d added in the meantime would also
 want to move to z/d by taking the hint that the entire directory
 'x' moved to 'z'.  A bug causing dirty files involved in a rename
 to be overwritten during merge has also been fixed as part of this
 work.

 Will merge to 'next'.
