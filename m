Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38FEC20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 08:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLIImg (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 03:42:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40387 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIImg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 03:42:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so8185553wmf.5
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 00:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:user-agent:date:message-id:mime-version;
        bh=bBiDJSQc2n50fCl6quxflLW2VzwpxY5EqoUSd3Ne6Vo=;
        b=ncoP98gXKbCElpwWeuGX1EM1Elmsas+WEoeBgGTmTvpFXYOcK9r1WiBUCrTl96t4kX
         SCZ76GzaYo9Cz3jv1qby0Oei1WtpPtkK9J9cZ94TDjkNWLbR58MzVuxx5a0JxDn/WuRd
         sCd9+cvA7R9sFhNNrTFwp0XRtDCg8Bg7DPdNxeewgaocTP/9Ufi45ILgGlLsCioApQNk
         abu8a6wCePA9p5CEll0oM3OPYHlnzdrDOiq6Ju4Rzws7xWdf5ofmDlYkpbKW+SI3us/8
         tDiJXZqOI3aN7xQl63nxwmLV7UIIOpHqyZd2MUlN/XOyfy38yxu1cXL6nxF/FxpSViIv
         fF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:user-agent:date
         :message-id:mime-version;
        bh=bBiDJSQc2n50fCl6quxflLW2VzwpxY5EqoUSd3Ne6Vo=;
        b=rSSgEwRSOGgEjk8NnsP0CbDKebd1GufNN6C9jn8RJdBb2R5TdBbd6N9D+lebqKwfv0
         2HHyBVgjYpL+7rrgVRT8TS6km/TWL7jT7cwmOeW1DFjJ35SkedWdpdO8NvK7SsMw8v9S
         b5Kcj/cz9YYuWWaK9fS9cLtrZ8doJn5QhenxrbJ8sggL0n/pLcCDg7NG5KvvJZdCBf0M
         KjkpH59Jus72d8g9WruAsmJqWmdBEDQ/yiIsvDnqi2KdZ7vth2WLGU8VVsHsK/YflEjm
         Jt1HMGJ2uhikBNs1bpaHdI24oSlQrpl/Ss2MZdvsP6JuWyHtU2SZ9FU5Pe4c6SsvvopS
         MiFQ==
X-Gm-Message-State: AA+aEWZ/lKUC+OMHtS+KKrfBfovtxGrT3ankERMfDdKtTZCe42vCsTVr
        EvwcXFsnayQ2QVvpZWkkZoqAP0aJqiwz+0wM
X-Google-Smtp-Source: AFSGD/V382W5jwa7PVJKFvGTe8TFpUfj6tQRSyUagl+m3BnGLGerrTJ79orf30qZGFsDmSGfQGEMnA==
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr6809524wmh.124.1544344950992;
        Sun, 09 Dec 2018 00:42:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l202sm22689836wma.33.2018.12.09.00.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 00:42:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2018, #01; Sun, 9)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
X-master-at: 5d826e972970a784bd7a7bdf587512510097b8c7
X-next-at: bc1bbc6f855c3b5ef7fcbd0f688f647c4e5b208b
Date:   Sun, 09 Dec 2018 17:42:27 +0900
Message-ID: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
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

Git 2.20 has been tagged.  I'd expect that we would slow down to see
how stable it is and queue only the brown-paper-bag fixes for a week
or so, before opening the tree for the next cycle, rewinding the tip
of 'next', etc.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/push-example-in-doc (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-18 at 8fd935a19c)
 + push: change needlessly ambiguous example in error

 An error message that sugggests how to give correct arguments to
 "git push" has been updated.


* ab/replace-graft-with-replace-advice (2018-11-29) 1 commit
  (merged to 'next' on 2018-11-30 at c5d658e075)
 + advice: don't pointlessly suggest --convert-graft-file

 The advice message to tell the user to migrate an existing graft
 file to the replace system when a graft file was read was shown
 even when "git replace --convert-graft-file" command, which is the
 way the message suggests to use, was running, which made little
 sense.


* gh/diff-raw-has-no-ellipses (2018-11-26) 1 commit
  (merged to 'next' on 2018-11-29 at 24a7536f15)
 + doc: update diff-format.txt for removed ellipses in --raw

 "git diff --raw" lost ellipses to adjust the output columns for
 some time now, but the documentation still showed them.


* jc/format-patch-range-diff-fix (2018-11-30) 1 commit
  (merged to 'next' on 2018-11-30 at 26290b1ec1)
 + format-patch: do not let its diff-options affect --range-diff

 "git format-patch --range-diff" by mistake passed the diff options
 used to generate the primary output of the command to the
 range-diff machinery, which caused the range-diff in the cover
 letter to include fairly useless "--stat" output.  This has been
 corrected by forcing a non-customizable default formatting options
 on the range-diff machinery when driven by format-patch.


* js/rebase-reflog-action-fix (2018-11-30) 1 commit
  (merged to 'next' on 2018-11-30 at 93fd2fb920)
 + rebase: fix GIT_REFLOG_ACTION regression

 "git rebase" reimplemented recently in C accidentally changed the
 way reflog entries are recorded (earlier "rebase -i" identified the
 entries it leaves with "rebase -i", but the new version always
 marks them with "rebase").  This has been corrected.


* js/rebase-stat-unrelated-fix (2018-11-30) 1 commit
  (merged to 'next' on 2018-11-30 at a9faaff8c1)
 + rebase --stat: fix when rebasing to an unrelated history

 "git rebase --stat" to transplant a piece of history onto a totally
 unrelated history were not working before and silently showed wrong
 result.  With the recent reimplementation in C, it started to instead
 die with an error message, as the original logic was not prepared
 to cope with this case.  This has now been fixed.


* ma/reset-doc-rendering-fix (2018-11-29) 2 commits
  (merged to 'next' on 2018-11-30 at be718c19e2)
 + git-reset.txt: render literal examples as monospace
 + git-reset.txt: render tables correctly under Asciidoctor

 Doc updates.


* rt/rebase-in-c-message-fix (2018-12-01) 1 commit
  (merged to 'next' on 2018-12-01 at 4428c15a66)
 + builtin/rebase.c: remove superfluous space in messages


* sg/daemon-test-signal-fix (2018-11-27) 1 commit
  (merged to 'next' on 2018-11-30 at b3f7fdf727)
 + t/lib-git-daemon: fix signal checking

 Test fix.


* sg/test-BUG (2018-11-20) 1 commit
  (merged to 'next' on 2018-11-21 at bb81013952)
 + tests: send "bug in the test script" errors to the script's stderr

 test framework has been updated to make a bug in the test script
 (as opposed to bugs in Git that are discovered by running the
 tests) stand out more prominently.


* sg/test-cmp-rev (2018-11-20) 1 commit
  (merged to 'next' on 2018-11-21 at 5d65cb2a76)
 + test-lib-functions: make 'test_cmp_rev' more informative on failure

 Test framework update.


* ss/msvc-strcasecmp (2018-11-20) 1 commit
  (merged to 'next' on 2018-11-21 at 9e45649e6e)
 + msvc: directly use MS version (_stricmp) of strcasecmp

 MSVC update.

--------------------------------------------------
[New Topics]

* cb/openbsd-allows-reading-directory (2018-12-03) 1 commit
 - config.mak.uname: OpenBSD uses BSD semantics with fread for directories

 BSD port update.

 Will merge to 'next'.


* cb/t5004-empty-tar-archive-fix (2018-12-03) 1 commit
 - t5004: avoid using tar for empty packages

 BSD port update.

 Will merge to 'next'.


* cb/test-lint-cp-a (2018-12-03) 1 commit
 - tests: add lint for non portable cp -a

 BSD port update.

 Will merge to 'next'.


* hb/t0061-dot-in-path-fix (2018-12-03) 1 commit
 - t0061: do not fail test if '.' is part of $PATH

 Test update.

 Will merge to 'next'.


* hn/highlight-sideband-keywords (2018-12-04) 1 commit
 - sideband: color lines with keyword only

 Lines that begin with a certain keyword that come over the wire, as
 well as lines that consist only of one of these keywords, ought to
 be painted in color for easier eyeballing, but the latter was
 broken ever since the feature was introduced in 2.19, which has
 been corrected.

 Will merge to 'next'.


* js/commit-graph-chunk-table-fix (2018-12-09) 4 commits
 - SQUASH???
 - Makefile: correct example fuzz build
 - commit-graph: fix buffer read-overflow
 - commit-graph, fuzz: add fuzzer for commit-graph

 The codepath to read from the commit-graph file attempted to read
 past the end of it when the file's table-of-contents was corrupt.


* jt/get-reference-with-commit-graph (2018-12-06) 1 commit
 - revision: use commit graph in get_reference()
 (this branch uses sb/more-repo-in-api.)

 Micro-optimize the code that prepares commit objects to be walked
 by "git rev-list" when the commit-graph is available.

 Will merge to 'next'.


* md/exclude-promisor-objects-fix-cleanup (2018-12-06) 1 commit
 - revision.c: put promisor option in specialized struct

 Code clean-up.

 Will merge to 'next'.


* bw/mailmap (2018-12-09) 1 commit
 - mailmap: update Brandon Williams's email address

 Will merge to 'next'.


* do/gitweb-strict-export-conf-doc (2018-12-09) 1 commit
 - docs: fix $strict_export text in gitweb.conf.txt

 Doc update.

 Will merge to 'next'.


* en/directory-renames-nothanks-doc-update (2018-12-09) 1 commit
 - git-rebase.txt: update note about directory rename detection and am

 Doc update.

 Will merge to 'next'.


* fd/gitweb-snapshot-conf-doc-fix (2018-12-09) 1 commit
 - docs/gitweb.conf: config variable typo

 Doc update.

 Will merge to 'next'.


* km/rebase-doc-typofix (2018-12-09) 1 commit
 - rebase docs: drop stray word in merge command description

 Doc update.

 Will merge to 'next'.


* nd/indentation-fix (2018-12-09) 1 commit
 - Indent code with TABs

 Code cleanup.

 Will merge to 'next'.


* tb/use-common-win32-pathfuncs-on-cygwin (2018-12-09) 1 commit
 - git clone <url> C:\cygwin\home\USER\repo' is working (again)

 Cygwin update.

 Will merge to 'next'.

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

* mk/http-backend-kill-children-before-exit (2018-11-26) 1 commit
  (merged to 'next' on 2018-11-29 at bf2d45062f)
 + http-backend: enable cleaning up forked upload/receive-pack on exit

 The http-backend CGI process did not correctly clean up the child
 processes it spawns to run upload-pack etc. when it dies itself,
 which has been corrected.

 Will cook in 'next'.


* tb/log-G-binary (2018-11-29) 1 commit
 - log -G: ignore binary files

 "git log -G<regex>" looked for a hunk in the "git log -p" patch
 output that contained a string that matches the given pattern.
 Optimize this code to ignore binary files, which by default will
 not show any hunk that would match any pattern (unless textconv or
 the --text option is in effect, that is).

 Expecting an update to the tests.


* dl/merge-cleanup-scissors-fix (2018-11-21) 2 commits
  (merged to 'next' on 2018-11-21 at 217be06acb)
 + merge: add scissors line on merge conflict
 + t7600: clean up 'merge --squash c3 with c7' test

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Will cook in 'next'.


* aw/pretty-trailers (2018-12-09) 7 commits
 - pretty: add support for separator option in %(trailers)
 - strbuf: separate callback for strbuf_expand:ing literals
 - pretty: add support for "valueonly" option in %(trailers)
 - pretty: allow showing specific trailers
 - pretty: single return path in %(trailers) handling
 - pretty: allow %(trailers) options with explicit value
 - doc: group pretty-format.txt placeholders descriptions

 The %(trailers) formatter in "git log --format=..."  now allows to
 optionally pick trailers selectively by keyword, show only values,
 etc.

 How's the doneness of this one?


* nd/attr-pathspec-in-tree-walk (2018-11-19) 5 commits
 - tree-walk: support :(attr) matching
 - dir.c: move, rename and export match_attrs()
 - pathspec.h: clean up "extern" in function declarations
 - tree-walk.c: make tree_entry_interesting() take an index
 - tree.c: make read_tree*() take 'struct repository *'

 The traversal over tree objects has learned to honor
 ":(attr:label)" pathspec match, which has been implemented only for
 enumerating paths on the filesystem.

 Will merge to 'next'.


* ab/commit-graph-progress-fix (2018-11-20) 1 commit
 - commit-graph: split up close_reachable() progress output

 Will merge to 'next'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* en/fast-export-import (2018-11-17) 11 commits
  (merged to 'next' on 2018-11-18 at 87bbbffc95)
 + fast-export: add a --show-original-ids option to show original names
 + fast-import: remove unmaintained duplicate documentation
 + fast-export: add --reference-excluded-parents option
 + fast-export: ensure we export requested refs
 + fast-export: when using paths, avoid corrupt stream with non-existent mark
 + fast-export: move commit rewriting logic into a function for reuse
 + fast-export: avoid dying when filtering by paths and old tags exist
 + fast-export: use value from correct enum
 + git-fast-export.txt: clarify misleading documentation about rev-list args
 + git-fast-import.txt: fix documentation for --quiet option
 + fast-export: convert sha1 to oid

 Small fixes and features for fast-export and fast-import, mostly on
 the fast-export side.

 Will cook in 'next'.


* nd/checkout-dwim-fix (2018-11-14) 1 commit
  (merged to 'next' on 2018-11-18 at 3d714e7719)
 + checkout: disambiguate dwim tracking branches and local files

 "git checkout frotz" (without any double-dash) avoids ambiguity by
 making sure 'frotz' cannot be interpreted as a revision and as a
 path at the same time.  This safety has been updated to check also
 a unique remote-tracking branch 'frotz' in a remote, when dwimming
 to create a local branch 'frotz' out of a remote-tracking branch
 'frotz' from a remote.

 Will cook in 'next'.


* nd/checkout-noisy (2018-11-20) 2 commits
 - t0027: squelch checkout path run outside test_expect_* block
 - checkout: print something when checking out paths

 "git checkout [<tree-ish>] path..." learned to report the number of
 paths that have been checked out of the index or the tree-ish,
 which gives it the same degree of noisy-ness as the case in which
 the command checks out a branch.

 Will merge to 'next'.


* sg/clone-initial-fetch-configuration (2018-11-16) 3 commits
  (merged to 'next' on 2018-11-18 at cae0f3985b)
 + Documentation/clone: document ignored configuration variables
 + clone: respect additional configured fetch refspecs during initial fetch
 + clone: use a more appropriate variable name for the default refspec

 Refspecs configured with "git -c var=val clone" did not propagate
 to the resulting repository, which has been corrected.

 Will cook in 'next'.


* en/rebase-merge-on-sequencer (2018-11-08) 2 commits
 - rebase: implement --merge via git-rebase--interactive
 - git-rebase, sequencer: extend --quiet option for the interactive machinery

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".

 Expecting a reroll.
 cf. <CABPp-BF8RupyfP69iqAVTXxEhBGyzVd-wUgp3y0pf+CbBFAQeg@mail.gmail.com>


* fc/http-version (2018-11-09) 1 commit
  (merged to 'next' on 2018-11-18 at 42f5155095)
 + http: add support selecting http version

 The "http.version" configuration variable can be used with recent
 enough cURL library to force the version of HTTP used to talk when
 fetching and pushing.

 Will cook in 'next'.


* dl/remote-save-to-push (2018-11-13) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 I am personally not yet quite convinced if this is worth pursuing.


* jk/loose-object-cache (2018-11-24) 10 commits
  (merged to 'next' on 2018-11-24 at 5f4f22707d)
 + odb_load_loose_cache: fix strbuf leak
  (merged to 'next' on 2018-11-18 at 276691a21b)
 + fetch-pack: drop custom loose object cache
 + sha1-file: use loose object cache for quick existence check
 + object-store: provide helpers for loose_objects_cache
 + sha1-file: use an object_directory for the main object dir
 + handle alternates paths the same as the main object dir
 + sha1_file_name(): overwrite buffer instead of appending
 + rename "alternate_object_database" to "object_directory"
 + submodule--helper: prefer strip_suffix() to ends_with()
 + fsck: do not reuse child_process structs

 Code clean-up with optimization for the codepath that checks
 (non-)existence of loose objects.

 Will cook in 'next'.


* js/protocol-advertise-multi (2018-11-17) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 How's the doneness of this one?


* js/smart-http-detect-remote-error (2018-11-17) 3 commits
  (merged to 'next' on 2018-11-18 at 5c6edfcb85)
 + remote-curl: die on server-side errors
 + remote-curl: tighten "version 2" check for smart-http
 + remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.

 Will cook in 'next'.


* nb/branch-show-other-worktrees-head (2018-11-12) 2 commits
 - branch: mark and colorize a branch differently if it is checked out in a linked worktree
 - ref-filter: add worktree atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Expecting a reroll.


* nd/the-index (2018-11-12) 22 commits
  (merged to 'next' on 2018-11-18 at 73d1d8594e)
 + rebase-interactive.c: remove the_repository references
 + rerere.c: remove the_repository references
 + pack-*.c: remove the_repository references
 + pack-check.c: remove the_repository references
 + notes-cache.c: remove the_repository references
 + line-log.c: remove the_repository reference
 + diff-lib.c: remove the_repository references
 + delta-islands.c: remove the_repository references
 + cache-tree.c: remove the_repository references
 + bundle.c: remove the_repository references
 + branch.c: remove the_repository reference
 + bisect.c: remove the_repository reference
 + blame.c: remove implicit dependency the_repository
 + sequencer.c: remove implicit dependency on the_repository
 + sequencer.c: remove implicit dependency on the_index
 + transport.c: remove implicit dependency on the_index
 + notes-merge.c: remove implicit dependency the_repository
 + notes-merge.c: remove implicit dependency on the_index
 + list-objects.c: reduce the_repository references
 + list-objects-filter.c: remove implicit dependency on the_index
 + wt-status.c: remove implicit dependency the_repository
 + wt-status.c: remove implicit dependency on the_index

 More codepaths become aware of working with in-core repository
 instance other than the default "the_repository".

 Will cook in 'next'.


* ot/ref-filter-object-info (2018-11-24) 6 commits
  (merged to 'next' on 2018-11-24 at f8505762e3)
 + ref-filter: replace unportable `%lld` format with %PRIdMAX
  (merged to 'next' on 2018-11-18 at ad4c086678)
 + ref-filter: add docs for new options
 + ref-filter: add tests for deltabase
 + ref-filter: add deltabase option
 + ref-filter: add tests for objectsize:disk
 + ref-filter: add objectsize:disk option

 The "--format=<placeholder>" option of for-each-ref, branch and tag
 learned to show a few more traits of objects that can be learned by
 the object_info API.

 Will cook in 'next'.


* sb/diff-color-moved-config-option-fixup (2018-11-14) 1 commit
 - diff: align move detection error handling with other options

 Minor inconsistency fix.

 Will merge to 'next'.


* ab/push-dwim-dst (2018-11-14) 7 commits
  (merged to 'next' on 2018-11-18 at 36567023be)
 + push doc: document the DWYM behavior pushing to unqualified <dst>
 + push: test that <src> doesn't DWYM if <dst> is unqualified
 + push: add an advice on unqualified <dst> push
 + push: move unqualified refname error into a function
 + push: improve the error shown on unqualified <dst> push
 + i18n: remote.c: mark error(...) messages for translation
 + remote.c: add braces in anticipation of a follow-up change

 "git push $there $src:$dst" rejects when $dst is not a fully
 qualified refname and not clear what the end user meant.  The
 codepath has been taught to give a clearer error message, and also
 guess where the push should go by taking the type of the pushed
 object into account (e.g. a tag object would want to go under
 refs/tags/).

 Will cook in 'next'.


* md/list-lazy-objects-fix (2018-12-06) 1 commit
 - list-objects.c: don't segfault for missing cmdline objects

 "git rev-list --exclude-promissor-objects" had to take an object
 that does not exist locally (and is lazily available) from the
 command line without barfing, but the code dereferenced NULL.

 Will merge to 'next'.


* nd/i18n (2018-11-12) 16 commits
  (merged to 'next' on 2018-11-18 at 5215bd2f7d)
 + fsck: mark strings for translation
 + fsck: reduce word legos to help i18n
 + parse-options.c: mark more strings for translation
 + parse-options.c: turn some die() to BUG()
 + parse-options: replace opterror() with optname()
 + repack: mark more strings for translation
 + remote.c: mark messages for translation
 + remote.c: turn some error() or die() to BUG()
 + reflog: mark strings for translation
 + read-cache.c: add missing colon separators
 + read-cache.c: mark more strings for translation
 + read-cache.c: turn die("internal error") to BUG()
 + attr.c: mark more string for translation
 + archive.c: mark more strings for translation
 + alias.c: mark split_cmdline_strerror() strings for translation
 + git.c: mark more strings for translation

 More _("i18n") markings.

 Will cook in 'next'.


* sb/more-repo-in-api (2018-11-14) 23 commits
  (merged to 'next' on 2018-11-19 at e5d2a129da)
 + t/helper/test-repository: celebrate independence from the_repository
 + path.h: make REPO_GIT_PATH_FUNC repository agnostic
 + commit: prepare free_commit_buffer and release_commit_memory for any repo
 + commit-graph: convert remaining functions to handle any repo
 + submodule: don't add submodule as odb for push
 + submodule: use submodule repos for object lookup
 + pretty: prepare format_commit_message to handle arbitrary repositories
 + commit: prepare logmsg_reencode to handle arbitrary repositories
 + commit: prepare repo_unuse_commit_buffer to handle any repo
 + commit: prepare get_commit_buffer to handle any repo
 + commit-reach: prepare in_merge_bases[_many] to handle any repo
 + commit-reach: prepare get_merge_bases to handle any repo
 + commit-reach.c: allow get_merge_bases_many_0 to handle any repo
 + commit-reach.c: allow remove_redundant to handle any repo
 + commit-reach.c: allow merge_bases_many to handle any repo
 + commit-reach.c: allow paint_down_to_common to handle any repo
 + commit: allow parse_commit* to handle any repo
 + object: parse_object to honor its repository argument
 + object-store: prepare has_{sha1, object}_file to handle any repo
 + object-store: prepare read_object_file to deal with any repo
 + object-store: allow read_object_file_extended to read from any repo
 + packfile: allow has_packed_and_bad to handle arbitrary repositories
 + sha1_file: allow read_object to read objects in arbitrary repositories
 (this branch is used by jt/get-reference-with-commit-graph.)

 The in-core repository instances are passed through more codepaths.

 Will cook in 'next'.
 cf. <20181115221254.45373-1-jonathantanmy@google.com>


* en/merge-path-collision (2018-12-01) 11 commits
  (merged to 'next' on 2018-12-01 at 24492e61f1)
 + t6036: avoid non-portable "cp -a"
  (merged to 'next' on 2018-11-18 at 3ec9286e0b)
 + merge-recursive: combine error handling
 + t6036, t6043: increase code coverage for file collision handling
 + merge-recursive: improve rename/rename(1to2)/add[/add] handling
 + merge-recursive: use handle_file_collision for add/add conflicts
 + merge-recursive: improve handling for rename/rename(2to1) conflicts
 + merge-recursive: fix rename/add conflict handling
 + merge-recursive: new function for better colliding conflict resolutions
 + merge-recursive: increase marker length with depth of recursion
 + t6036, t6042: testcases for rename collision of already conflicting files
 + t6042: add tests for consistency in file collision conflict handling

 Updates for corner cases in merge-recursive.

 Will cook in 'next'.


* sd/stash-wo-user-name (2018-11-19) 1 commit
  (merged to 'next' on 2018-11-19 at 0838b091ea)
 + stash: tolerate missing user identity

 A properly configured username/email is required under
 user.useConfigOnly in order to create commits; now "git stash"
 (even though it creates commit objects to represent stash entries)
 command is excempt from the requirement.

 Will cook in 'next'.


* bc/sha-256 (2018-11-14) 12 commits
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


* js/vsts-ci (2018-10-16) 13 commits
 . travis: fix skipping tagged releases
 . README: add a build badge (status of the Azure Pipelines build)
 . tests: record more stderr with --write-junit-xml in case of failure
 . tests: include detailed trace logs with --write-junit-xml upon failure
 . git-p4: use `test_atexit` to kill the daemon
 . git-daemon: use `test_atexit` in the tests
 . tests: introduce `test_atexit`
 . ci: add a build definition for Azure DevOps
 . ci/lib.sh: add support for Azure Pipelines
 . tests: optionally write results as JUnit-style .xml
 . test-date: add a subcommand to measure times in shell scripts
 . ci/lib.sh: encapsulate Travis-specific things
 . ci: rename the library of common functions

 Prepare to run test suite on Azure DevOps.

 Ejected out of 'pu', as doing so seems to help other topics get
 tested at TravisCI.

 https://travis-ci.org/git/git/builds/452713184 is a sample of a
 build whose tests on 4 hang (with this series in).  Ejecting it
 gave us https://travis-ci.org/git/git/builds/452778963 which still
 shows breakages from other topics not yet in 'next', but at least
 the tests do not stall.


* du/branch-show-current (2018-10-26) 1 commit
 - branch: introduce --show-current display option

 "git branch" learned a new subcommand "--show-current".

 I am personally not yet quite convinced if this is worth pursuing.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* ag/sequencer-reduce-rewriting-todo (2018-11-12) 16 commits
 . rebase--interactive: move transform_todo_file() to rebase--interactive.c
 . sequencer: fix a call to error() in transform_todo_file()
 . sequencer: use edit_todo_list() in complete_action()
 . rebase-interactive: rewrite edit_todo_list() to handle the initial edit
 . rebase-interactive: append_todo_help() changes
 . rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
 . sequencer: refactor skip_unnecessary_picks() to work on a todo_list
 . sequencer: change complete_action() to use the refactored functions
 . sequencer: make sequencer_make_script() write its script to a strbuf
 . sequencer: refactor rearrange_squash() to work on a todo_list
 . sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
 . sequencer: refactor check_todo_list() to work on a todo_list
 . sequencer: introduce todo_list_write_to_file()
 . sequencer: refactor transform_todos() to work on a todo_list
 . sequencer: make the todo_list structure public
 . sequencer: changes in parse_insn_buffer()

 The scripted version of "git rebase -i" wrote and rewrote the todo
 list many times during a single step of its operation, and the
 recent C-rewrite made a faithful conversion of the logic to C.  The
 implementation has been updated to carry necessary information
 around in-core to avoid rewriting the same file over and over
 unnecessarily.

 With too many topics in-flight that touch sequencer and rebaser,
 this need to wait giving precedence to other topics that fix bugs.


* sb/submodule-recursive-fetch-gets-the-tip (2018-12-09) 9 commits
 - fetch: ensure submodule objects fetched
 - submodule.c: fetch in submodules git directory instead of in worktree
 - submodule: migrate get_next_submodule to use repository structs
 - repository: repo_submodule_init to take a submodule struct
 - submodule: store OIDs in changed_submodule_names
 - submodule.c: tighten scope of changed_submodule_names struct
 - submodule.c: sort changed_submodule_names before searching it
 - submodule.c: fix indentation
 - sha1-array: provide oid_array_filter

 "git fetch --recurse-submodules" may not fetch the necessary commit
 that is bound to the superproject, which is getting corrected.

 Ready?


* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 - add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.

 Will hold.
 cf. <e5b2900a-0558-d3bf-8ea1-d526b078bbc2@talktalk.net>


* ps/stash-in-c (2018-11-26) 22 commits
 . stash: replace all `write-tree` child processes with API calls
 . stash: optimize `get_untracked_files()` and `check_changes()`
 . stash: convert `stash--helper.c` into `stash.c`
 . stash: convert save to builtin
 . stash: make push -q quiet
 . stash: convert push to builtin
 . stash: convert create to builtin
 . stash: convert store to builtin
 . stash: convert show to builtin
 . stash: convert list to builtin
 . stash: convert pop to builtin
 . stash: convert branch to builtin
 . stash: convert drop and clear to builtin
 . stash: convert apply to builtin
 . stash: mention options in `show` synopsis
 . stash: add tests for `git stash show` config
 . stash: rename test cases to be more descriptive
 . t3903: modernize style
 . stash: improve option parsing test coverage
 . strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
 . strbuf.c: add `strbuf_join_argv()`
 . sha1-name.c: add `get_oidf()` which acts like `get_oid()`

 "git stash" rewritten in C.

 Expecting a reroll, probably on top of the sd/stash-wo-user-name
 topic after it stabilizes, with an escape hatch like the one in
 "rebase in C".


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


* gl/bundle-unlock-before-aborting (2018-11-14) 1 commit
 . bundle: rollback lock file while refusing to create an empty bundle

 Superseded by jk/close-duped-fd-before-unlock-for-bundle


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

 Retracted; reverted out of next.
 cf. <20181114195142.GI126896@google.com>


* ab/format-patch-rangediff-not-stat (2018-11-24) 1 commit
  (merged to 'next' on 2018-11-26 at d9c84916b3)
 + format-patch: don't include --stat with --range-diff output

 The "--rangediff" option recently added to "format-patch"
 interspersed a bogus and useless "--stat" information by mistake,
 which is being corrected.

 Reverted out of 'next'.


* jc/postpone-rebase-in-c (2018-11-26) 1 commit
  (merged to 'next' on 2018-11-26 at c6ae45110f)
 + rebase: mark the C reimplementation as an experimental opt-in feature

 People seem to be still finding latent bugs in the "rebase in C"
 reimplementation.  For the upcoming release, use the scripted
 version by default and adjust the documentation accordingly.

 Reverted out of 'next'.
