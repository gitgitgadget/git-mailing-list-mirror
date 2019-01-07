Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000B3211B4
	for <e@80x24.org>; Mon,  7 Jan 2019 23:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfAGXeR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 18:34:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43364 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXeR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 18:34:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so2203714wrs.10
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=Gwk/qWwEwuSPUUERwNLYOSD0HGomn6dedn0XYA07tHk=;
        b=hNYdnOCAmQuPR3uq9PN7izTxEb8y3ulheZigW4zEfsBAfYqRZKGQNE0R4/YZe0CXDg
         aXcmhtH5LybmA5BUFgQ8dJbQpYII622O+Qpdl9LmJNI9Z8GM+3qCKi2qzhR59QLS1sTX
         2NykfU3QzGia1Snji0EIWaGR2zFHva2c76Fo9B1HPC9tDVzM1BhGw94OqBXG2cQZZe+l
         9MQMV9GhbE6hmVC9w9HdUCXe9T814626PksqHfcBbvVzA3nnCzbxqBFOWz4NdjjoVPBw
         55WEJU/jPW4WZ668Xqyo5Im96BnEnnFLzuqqHHtPx24m4hmttsWhfBydmFHfkA0Ox6lg
         /D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=Gwk/qWwEwuSPUUERwNLYOSD0HGomn6dedn0XYA07tHk=;
        b=hR5QdKHqh6M0W8Ozi+8NjwWo7vqBqsUiEAxiqX+GL6cjqaV8c3DrYHuxmNVy+Or31n
         +s7ZMJPHPhh39oB7WRoWKjYTNcHoTt6W/uVbeYgdyywTNaFCHRUyzgdk5xY/R2tvrYnB
         i8aalUWshyNO43HYqNFYXhmdB6787u7QkzvJH4nwO5y1vVJS5lpFp0D34drxjtkun4ix
         vnUV/4okUpgZ0mti04rzTAIkX6rGLn93EOb1j0Euz/vUPw+jvaRWHmG16g0//60FFlWP
         EezH6KoirYHuCYgi3ZbIMaMWehgxysgyoRO5GWhkkwMMW9ovKHR5xtSezbX9oFzGGHUa
         aTig==
X-Gm-Message-State: AJcUukf6i54+U6EcnmOYIEmem2yMQDTfb/JzoHgGT3TCHMN+G2d9ktyJ
        p3WJWL9fFyJQtudCsFQCN6cG9cEfBlrLvA==
X-Google-Smtp-Source: ALg8bN6uI1qaHdw9zZXcjMQnvyt2xplh+7K06AZyHJ52nZcQ/deblZ1FKZLz+0AIAJVWOVYPeowsFA==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr54597502wro.194.1546904051743;
        Mon, 07 Jan 2019 15:34:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 198sm6446402wmt.36.2019.01.07.15.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 15:34:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2019, #01; Mon, 7)
X-master-at: ecbdaf0899161c067986e9d9d564586d4b045d62
X-next-at: d81d796ee0c49eae40e3f85467a8e6b18022bcea
Date:   Mon, 07 Jan 2019 15:34:10 -0800
Message-ID: <xmqq7efg6o0d.fsf@gitster-ct.c.googlers.com>
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

The 'master' branch now has the first batch of topics (many of which
have been cooking in 'next' during the pre-release freeze).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/push-dwim-dst (2018-11-14) 7 commits
  (merged to 'next' on 2018-12-28 at d9f618de10)
 + push doc: document the DWYM behavior pushing to unqualified <dst>
 + push: test that <src> doesn't DWYM if <dst> is unqualified
 + push: add an advice on unqualified <dst> push
 + push: move unqualified refname error into a function
 + push: improve the error shown on unqualified <dst> push
 + i18n: remote.c: mark error(...) messages for translation
 + remote.c: add braces in anticipation of a follow-up change

 Originally merged to 'next' on 2018-11-18

 "git push $there $src:$dst" rejects when $dst is not a fully
 qualified refname and not clear what the end user meant.  The
 codepath has been taught to give a clearer error message, and also
 guess where the push should go by taking the type of the pushed
 object into account (e.g. a tag object would want to go under
 refs/tags/).


* en/fast-export-import (2018-11-17) 11 commits
  (merged to 'next' on 2018-12-28 at a1b09cf515)
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

 Originally merged to 'next' on 2018-11-18

 Small fixes and features for fast-export and fast-import, mostly on
 the fast-export side.


* en/merge-path-collision (2018-12-01) 11 commits
  (merged to 'next' on 2018-12-28 at b50d3eee25)
 + t6036: avoid non-portable "cp -a"
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

 Originally merged to 'next' on 2018-12-01

 Updates for corner cases in merge-recursive.


* fc/http-version (2018-11-09) 1 commit
  (merged to 'next' on 2018-12-28 at 56bcbb0fa9)
 + http: add support selecting http version

 Originally merged to 'next' on 2018-11-18

 The "http.version" configuration variable can be used with recent
 enough cURL library to force the version of HTTP used to talk when
 fetching and pushing.


* jk/loose-object-cache (2018-11-24) 10 commits
  (merged to 'next' on 2018-12-28 at 5a5faf384e)
 + odb_load_loose_cache: fix strbuf leak
 + fetch-pack: drop custom loose object cache
 + sha1-file: use loose object cache for quick existence check
 + object-store: provide helpers for loose_objects_cache
 + sha1-file: use an object_directory for the main object dir
 + handle alternates paths the same as the main object dir
 + sha1_file_name(): overwrite buffer instead of appending
 + rename "alternate_object_database" to "object_directory"
 + submodule--helper: prefer strip_suffix() to ends_with()
 + fsck: do not reuse child_process structs

 Originally merged to 'next' on 2018-11-24

 Code clean-up with optimization for the codepath that checks
 (non-)existence of loose objects.


* mk/http-backend-kill-children-before-exit (2018-11-26) 1 commit
  (merged to 'next' on 2018-12-28 at 81188d93c3)
 + http-backend: enable cleaning up forked upload/receive-pack on exit

 Originally merged to 'next' on 2018-11-29

 The http-backend CGI process did not correctly clean up the child
 processes it spawns to run upload-pack etc. when it dies itself,
 which has been corrected.


* nd/checkout-dwim-fix (2018-11-14) 1 commit
  (merged to 'next' on 2018-12-28 at 3183c9305b)
 + checkout: disambiguate dwim tracking branches and local files

 Originally merged to 'next' on 2018-11-18

 "git checkout frotz" (without any double-dash) avoids ambiguity by
 making sure 'frotz' cannot be interpreted as a revision and as a
 path at the same time.  This safety has been updated to check also
 a unique remote-tracking branch 'frotz' in a remote, when dwimming
 to create a local branch 'frotz' out of a remote-tracking branch
 'frotz' from a remote.


* nd/i18n (2018-11-12) 16 commits
  (merged to 'next' on 2018-12-28 at 8e2de8338e)
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

 Originally merged to 'next' on 2018-11-18

 More _("i18n") markings.


* nd/the-index (2018-11-12) 22 commits
  (merged to 'next' on 2018-12-28 at 6bbd3befbe)
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
 (this branch is used by md/list-objects-filter-by-depth.)

 Originally merged to 'next' on 2018-11-18

 More codepaths become aware of working with in-core repository
 instance other than the default "the_repository".


* sd/stash-wo-user-name (2018-11-19) 1 commit
  (merged to 'next' on 2018-12-28 at 99197ef5a1)
 + stash: tolerate missing user identity
 (this branch is used by ps/stash-in-c.)

 Originally merged to 'next' on 2018-11-19

 A properly configured username/email is required under
 user.useConfigOnly in order to create commits; now "git stash"
 (even though it creates commit objects to represent stash entries)
 command is exempt from the requirement.


* sg/clone-initial-fetch-configuration (2018-11-16) 3 commits
  (merged to 'next' on 2018-12-28 at 82e104f221)
 + Documentation/clone: document ignored configuration variables
 + clone: respect additional configured fetch refspecs during initial fetch
 + clone: use a more appropriate variable name for the default refspec

 Originally merged to 'next' on 2018-11-18

 Refspecs configured with "git -c var=val clone" did not propagate
 to the resulting repository, which has been corrected.

--------------------------------------------------
[New Topics]

* ab/proto-v2-fixes (2018-12-14) 5 commits
 - tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
 - builtin/fetch-pack: support protocol version 2
 - tests: mark & fix tests broken under GIT_TEST_PROTOCOL_VERSION=1
 - tests: add a special setup where for protocol.version
 - tests: add a check for unportable env --unset

 This is (just a part of) v2, and I see v3 posted on the list, but
 it seems that v3 needs further updates.
 cf. <20181218124852.GD30471@sigill.intra.peff.net>

 I'll drop the whole thing and wait for an update.


* jn/stripspace-wo-repository (2018-12-26) 1 commit
 - stripspace: allow -s/-c outside git repository

 "git stripspace" should be usable outside a git repository, but
 under the "-s" or "-c" mode, it didn't.

 Will merge to 'next'.


* ma/asciidoctor (2018-12-26) 3 commits
 - git-status.txt: render tables correctly under Asciidoctor
 - Documentation: do not nest open blocks
 - git-column.txt: fix section header

 Some of the documentation pages formatted incorrectly with
 Asciidoctor, which have been fixed.

 Will merge to 'next'.


* nd/worktree-remove-with-uninitialized-submodules (2019-01-07) 1 commit
 - worktree: allow to (re)move worktrees with uninitialized submodules

 "git worktree remove" and "git worktree move" refused to work when
 there is a submodule involved.  This has been loosened to ignore
 uninitialized submodules.

 Will merge to 'next'.


* sb/submodule-unset-core-worktree-when-worktree-is-lost (2018-12-26) 4 commits
 - submodule deinit: unset core.worktree
 - submodule--helper: fix BUG message in ensure_core_worktree
 - submodule: unset core.worktree if no working tree is present
 - submodule update: add regression test with old style setups

 The core.worktree setting in a submodule repository should not be
 pointing at a directory when the submodule loses its working tree
 (e.g. getting deinit'ed), but the code did not properly maintain
 this invariant.

 Will merge to 'next'.


* so/cherry-pick-always-allow-m1 (2019-01-07) 4 commits
 - t3506: validate '-m 1 -ff' is now accepted for non-merge commits
 - t3502: validate '-m 1' argument is now accepted for non-merge commits
 - cherry-pick: do not error on non-merge commits when '-m 1' is specified
 - t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks

 "git cherry-pick -m1" was forbidden when picking a non-merge
 commit, even though there _is_ parent number 1 for such a commit.
 This was done to avoid mistakes back when "cherry-pick" was about
 picking a single commit, but is no longer useful with "cherry-pick"
 that can pick a range of commits.  Now the "-m$num" option is
 allowed when picking any commit, as long as $num names an existing
 parent of the commit.

 Technically this is a backward incompatible change; hopefully
 nobody is relying on the error-checking behaviour.

 Will merge to 'next'.


* cy/completion-typofix (2019-01-03) 1 commit
 - completion: fix typo in git-completion.bash

 Typofix.

 Will merge to 'next'.


* cy/zsh-completion-SP-in-path (2019-01-03) 2 commits
 - completion: treat results of git ls-tree as file paths
 - zsh: complete unquoted paths with spaces correctly

 With zsh, "git cmd path<TAB>" was completed to "git cmd path name"
 when the completed path has a special character like SP in it,
 without any attempt to keep "path name" a single filename.  This
 has been fixed to complete it to "git cmd path\ name" just like
 Bash completion does.

 Will merge to 'next'.


* ds/commit-graph-assert-missing-parents (2019-01-02) 1 commit
 - commit-graph: writing missing parents is a BUG

 Tightening error checking in commit-graph writer.

 Will merge to 'next'.


* ed/simplify-setup-git-dir (2019-01-03) 1 commit
 - Simplify handling of setup_git_directory_gently() failure cases.

 Code simplification.

 Will merge to 'next'.


* es/doc-worktree-guessremote-config (2018-12-28) 1 commit
 - doc/config: do a better job of introducing 'worktree.guessRemote'

 Doc clarification.

 Will merge to 'next'.


* ew/ban-strncat (2019-01-02) 1 commit
 - banned.h: mark strncat() as banned

 The "strncat()" function is now among the banned functions.

 Will merge to 'next'.


* jk/dev-build-format-security (2019-01-07) 1 commit
 - config.mak.dev: add -Wall, primarily for -Wformat, to help autoconf users

 Earlier we added "-Wformat-security" to developer builds, assuming
 that "-Wall" (which includes "-Wformat" which in turn is required
 to use "-Wformat-security") is always in effect.  This is not true
 when config.mak.autogen is in use, unfortunately.  This has been
 fixed by unconditionally adding "-Wall" to developer builds.

 Will merge to 'next'.


* jp/author-committer-config (2019-01-02) 2 commits
 - DONTMERGE
 - Add author and committer configuration settings

 Four new configuration variables {author,committer}.{name,email}
 have been introduced to override user.{name,email} in more specific
 cases.

 Expecting a reroll.
 cf. <xmqq1s5uk6qh.fsf@gitster-ct.c.googlers.com>


* js/rebase-am (2019-01-03) 4 commits
 - built-in rebase: call `git am` directly
 - rebase: teach `reset_head()` to optionally skip the worktree
 - rebase: avoid double reflog entry when switching branches
 - rebase: move `reset_head()` into a better spot

 Instead of going through "git-rebase--am" scriptlet to use the "am"
 backend, the built-in version of "git rebase" learned to drive the
 "am" backend directly.

 Waiting for a review response.
 Looked almost ready.


* ms/packet-err-check (2019-01-02) 2 commits
 - pack-protocol.txt: accept error packets in any context
 - Use packet_reader instead of packet_read_line

 Error checking of data sent over the pack-protocol has been
 revamped so that error packets are always diagnosed properly.


* os/rebase-runs-post-checkout-hook (2019-01-02) 2 commits
 - rebase: run post-checkout hook on checkout
 - t5403: simplify by using a single repository

 "git rebase" internally runs "checkout" to switch between branches,
 and the command used to call the post-checkout hook, but the
 reimplementation stopped doing so, which is getting fixed.


* rb/hpe (2019-01-03) 5 commits
 - compat/regex/regcomp.c: define intptr_t and uintptr_t on NonStop
 - git-compat-util.h: add FLOSS headers for HPE NonStop
 - config.mak.uname: support for modern HPE NonStop config.
 - transport-helper: drop read/write errno checks
 - transport-helper: use xread instead of read

 Portability updates for the HPE NonStop platform.

 Will merge to 'next'.


* sg/test-bash-version-fix (2019-01-03) 2 commits
 - Merge branch 'sg/test-bash-version-fix'
 - test-lib: check Bash version for '-x' without using shell arrays
 (this branch is used by sg/stress-test.)

 The test suite tried to see if it is run under bash, but the check
 itself failed under some other implementations of shell (notably
 under NetBSD).  This has been corrected.

 Will merge to 'next'.


* sm/http-no-more-failonerror (2019-01-03) 2 commits
 - Unset CURLOPT_FAILONERROR
 - Change how HTTP response body is returned

 Waiting for clarifications.


* tg/t5570-drop-racy-test (2019-01-07) 2 commits
 - Revert "t/lib-git-daemon: record daemon log"
 - t5570: drop racy test

 An inherently racy test that caused intermittent failures has been
 removed.

 Will merge to 'next'.


* tt/bisect-in-c (2019-01-02) 7 commits
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 More code in "git bisect" has been rewritten in C.


* ja/doc-build-l10n (2019-01-07) 1 commit
 - Documentation/Makefile add optional targets for l10n

 Prepare Documentation/Makefile so that manpage localization can
 reuse it by overriding and tweaking the list of build products.

 Will merge to 'next'.


* jk/loose-object-cache-oid (2019-01-07) 5 commits
 - sha1-file: modernize loose header/stream functions
 - sha1-file: modernize loose object file functions
 - http: use struct object_id instead of bare sha1
 - update comment references to sha1_object_info()
 - sha1-file: fix outdated sha1 comment references
 (this branch uses rs/loose-object-cache-perffix.)

 Code clean-up.

 Will merge to 'next'.


* mm/multimail-1.5 (2019-01-07) 1 commit
 - git-multimail: update to release 1.5.0

 Update "git multimail" from the upstream.

 Will merge to 'next'.


* po/git-p4-wo-login (2019-01-07) 1 commit
 - git-p4: fix problem when p4 login is not necessary

 "git p4" update.

 Will merge to 'next'.


* rs/loose-object-cache-perffix (2019-01-07) 4 commits
 - object-store: retire odb_load_loose_cache()
 - object-store: use one oid_array per subdirectory for loose cache
 - object-store: factor out odb_clear_loose_cache()
 - object-store: factor out odb_loose_cache()
 (this branch is used by jk/loose-object-cache-oid.)

 The loose object cache used to optimize existence look-up has been
 updated.

 Will merge to 'next'.


* rs/sha1-file-close-mapped-file-on-error (2019-01-07) 1 commit
 - sha1-file: close fd of empty file in map_sha1_file_1()

 Code clean-up.

 Will merge to 'next'.

--------------------------------------------------
[Cooking]

* lt/date-human (2019-01-02) 3 commits
 - t0006-date.sh: add `human` date format tests.
 - Add 'human' date format documentation
 - Add 'human' date format

 A new date format "--date=human" that morphs its output depending
 on how far the time is from the current time has been introduced.
 "--date=auto" can be used to use this new format when the output is
 goint to the pager or to the terminal and otherwise the default
 format.

 The design around "auto" may need to be rethought.
 The tests need to be updated, too.
 cf. <20190104075034.GA26014@sigill.intra.peff.net>
 cf. <a5412274-028f-3662-e4f5-dbbcad4d9a40@iee.org>


* ds/midx-expire-repack (2019-01-02) 7 commits
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' verb
 - midx: refactor permutation logic
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use


* ds/push-sparse-tree-walk (2018-12-11) 6 commits
 - pack-objects: create GIT_TEST_PACK_SPARSE
 - pack-objects: create pack.useSparse setting
 - revision: implement sparse algorithm
 - pack-objects: add --sparse option
 - list-objects: consume sparse tree walk
 - revision: add mark_tree_uninteresting_sparse


* js/rebase-i-redo-exec (2018-12-11) 3 commits
 - rebase: introduce a shortcut for --reschedule-failed-exec
 - rebase: add a config option to default to --reschedule-failed-exec
 - rebase: introduce --reschedule-failed-exec


* md/list-objects-filter-by-depth (2018-12-28) 4 commits
 - tree:<depth>: skip some trees even when collecting omits
 - list-objects-filter: teach tree:# how to handle >0
 - Merge branch 'nd/the-index' into md/list-objects-filter-by-depth
 - Merge branch 'sb/more-repo-in-api' into md/list-objects-filter-by-depth
 (this branch uses sb/more-repo-in-api; is tangled with jt/get-reference-with-commit-graph.)


* nd/backup-log (2018-12-10) 24 commits
 - FIXME
 - rebase: keep backup of overwritten files on --skip or --abort
 - am: keep backup of overwritten files on --skip or --abort
 - checkout -f: keep backup of overwritten files
 - reset --hard: keep backup of overwritten files
 - unpack-trees.c: keep backup of ignored files being overwritten
 - refs: keep backup of deleted reflog
 - config --edit: support backup log
 - sha1-file.c: let index_path() accept NULL istate
 - backup-log: keep all blob references around
 - gc: prune backup logs
 - backup-log: add prune command
 - backup-log: add log command
 - backup-log: add diff command
 - backup-log: add cat command
 - backup-log.c: add API for walking backup log
 - add--interactive: support backup log
 - apply: support backup log with --keep-backup
 - commit: support backup log
 - update-index: support backup log with --keep-backup
 - add: support backup log
 - read-cache.c: new flag for add_index_entry() to write to backup log
 - backup-log: add "update" subcommand
 - doc: introduce new "backup log" concept


* nd/style-opening-brace (2018-12-10) 1 commit
 - style: the opening '{' of a function is in a separate line

 Code clean-up.

 Will merge to 'next'.


* sg/stress-test (2019-01-07) 8 commits
 - test-lib: add the '--stress' option to run a test repeatedly under load
 - test-lib-functions: introduce the 'test_set_port' helper function
 - test-lib: set $TRASH_DIRECTORY earlier
 - test-lib: consolidate naming of test-results paths
 - test-lib: parse command line options earlier
 - test-lib: parse options in a for loop to keep $@ intact
 - test-lib: extract Bash version check for '-x' tracing
 - test-lib: translate SIGTERM and SIGHUP to an exit
 (this branch uses sg/test-bash-version-fix.)

 Flaky tests can now be repeatedly run under load with the
 "--stress" option.

 Will merge to 'next'.


* tg/checkout-no-overlay (2019-01-02) 8 commits
 - checkout: introduce checkout.overlayMode config
 - checkout: introduce --{,no-}overlay option
 - checkout: factor out mark_cache_entry_for_checkout function
 - checkout: clarify comment
 - read-cache: add invalidate parameter to remove_marked_cache_entries
 - entry: support CE_WT_REMOVE flag in checkout_entry
 - entry: factor out unlink_entry function
 - move worktree tests to t24*

 "git checkout --no-overlay" can be used to trigger a new mode of
 checking out paths out of the tree-ish, that allows paths that
 match the pathspec that are in the current index and working tree
 and are not in the tree-ish.

 Will merge to 'next'.


* jk/proto-v2-hidden-refs-fix (2018-12-14) 3 commits
 - upload-pack: support hidden refs with protocol v2
 - parse_hide_refs_config: handle NULL section
 - serve: pass "config context" through to individual commands

 The v2 upload-pack protocol implementation failed to honor
 hidden-ref configuration, which has been corrected.

 Will merge to 'next'.


* la/quiltimport-keep-non-patch (2018-12-14) 1 commit
 - git-quiltimport: Add --keep-non-patch option

 "git quiltimport" learned "--keep-non-patch" option.

 Will merge to 'next'.


* sb/submodule-fetchjobs-default-to-one (2018-12-14) 1 commit
 - submodule update: run at most one fetch job unless otherwise set

 "git submodule update" ought to use a single job unless asked, but
 by mistake used multiple jobs, which has been fixed.

 Will merge to 'next'.


* cb/openbsd-allows-reading-directory (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at 9d865107fd)
 + config.mak.uname: OpenBSD uses BSD semantics with fread for directories

 BSD port update.

 Will merge to 'master'.


* cb/t5004-empty-tar-archive-fix (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at 39f4cf94ce)
 + t5004: avoid using tar for empty packages

 BSD port update.

 Will merge to 'master'.


* cb/test-lint-cp-a (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at d13e6cfcb0)
 + tests: add lint for non portable cp -a

 BSD port update.

 Will merge to 'master'.


* hb/t0061-dot-in-path-fix (2018-12-03) 1 commit
  (merged to 'next' on 2019-01-04 at 789f990c4e)
 + t0061: do not fail test if '.' is part of $PATH

 Test update.

 Will merge to 'master'.


* hn/highlight-sideband-keywords (2018-12-04) 1 commit
  (merged to 'next' on 2019-01-04 at b039601533)
 + sideband: color lines with keyword only

 Lines that begin with a certain keyword that come over the wire, as
 well as lines that consist only of one of these keywords, ought to
 be painted in color for easier eyeballing, but the latter was
 broken ever since the feature was introduced in 2.19, which has
 been corrected.

 Will merge to 'master'.


* js/commit-graph-chunk-table-fix (2018-12-14) 3 commits
 - Makefile: correct example fuzz build
 - commit-graph: fix buffer read-overflow
 - commit-graph, fuzz: add fuzzer for commit-graph

 The codepath to read from the commit-graph file attempted to read
 past the end of it when the file's table-of-contents was corrupt.


* jt/get-reference-with-commit-graph (2018-12-28) 1 commit
 - revision: use commit graph in get_reference()
 (this branch uses sb/more-repo-in-api; is tangled with md/list-objects-filter-by-depth.)

 Micro-optimize the code that prepares commit objects to be walked
 by "git rev-list" when the commit-graph is available.

 Needs to be rebuilt when sb/more-repo-in-api is rewound.


* md/exclude-promisor-objects-fix-cleanup (2018-12-06) 1 commit
  (merged to 'next' on 2019-01-04 at c15362832d)
 + revision.c: put promisor option in specialized struct

 Code clean-up.

 Will merge to 'master'.


* bw/mailmap (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 02b6e83231)
 + mailmap: update brandon williams's email address

 Will merge to 'master'.


* do/gitweb-strict-export-conf-doc (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 5249c9386a)
 + docs: fix $strict_export text in gitweb.conf.txt

 Doc update.

 Will merge to 'master'.


* en/directory-renames-nothanks-doc-update (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at cb7134b54c)
 + git-rebase.txt: update note about directory rename detection and am

 Doc update.

 Will merge to 'master'.


* fd/gitweb-snapshot-conf-doc-fix (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 7ba71fca17)
 + docs/gitweb.conf: config variable typo

 Doc update.

 Will merge to 'master'.


* km/rebase-doc-typofix (2018-12-10) 1 commit
  (merged to 'next' on 2019-01-04 at c89f646e8f)
 + rebase docs: drop stray word in merge command description

 Doc update.

 Will merge to 'master'.


* nd/indentation-fix (2018-12-09) 1 commit
  (merged to 'next' on 2019-01-04 at 738b17d365)
 + Indent code with TABs

 Code cleanup.

 Will merge to 'master'.


* tb/use-common-win32-pathfuncs-on-cygwin (2018-12-26) 1 commit
  (merged to 'next' on 2019-01-04 at c3b2b1f3c3)
 + git clone <url> C:\cygwin\home\USER\repo' is working (again)

 Cygwin update.

 Will merge to 'master'.


* tb/log-G-binary (2018-12-26) 1 commit
  (merged to 'next' on 2019-01-04 at a713ef389c)
 + log -G: ignore binary files

 "git log -G<regex>" looked for a hunk in the "git log -p" patch
 output that contained a string that matches the given pattern.
 Optimize this code to ignore binary files, which by default will
 not show any hunk that would match any pattern (unless textconv or
 the --text option is in effect, that is).

 Will merge to 'master'.


* dl/merge-cleanup-scissors-fix (2018-11-21) 2 commits
 - merge: add scissors line on merge conflict
 - t7600: clean up 'merge --squash c3 with c7' test

 The list of conflicted paths shown in the editor while concluding a
 conflicted merge was shown above the scissors line when the
 clean-up mode is set to "scissors", even though it was commented
 out just like the list of updated paths and other information to
 help the user explain the merge better.

 Kicked out of 'next', to replace with a newer iteration.
 cf. <cover.1545745331.git.liu.denton@gmail.com>


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
  (merged to 'next' on 2019-01-04 at 6a07e5b905)
 + tree-walk: support :(attr) matching
 + dir.c: move, rename and export match_attrs()
 + pathspec.h: clean up "extern" in function declarations
 + tree-walk.c: make tree_entry_interesting() take an index
 + tree.c: make read_tree*() take 'struct repository *'

 The traversal over tree objects has learned to honor
 ":(attr:label)" pathspec match, which has been implemented only for
 enumerating paths on the filesystem.

 Will merge to 'master'.


* ab/commit-graph-progress-fix (2018-11-20) 1 commit
  (merged to 'next' on 2019-01-04 at 405a1a2cf5)
 + commit-graph: split up close_reachable() progress output

 Will merge to 'master'.


* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* nd/checkout-noisy (2018-11-20) 2 commits
  (merged to 'next' on 2019-01-04 at 480172d3d7)
 + t0027: squelch checkout path run outside test_expect_* block
 + checkout: print something when checking out paths

 "git checkout [<tree-ish>] path..." learned to report the number of
 paths that have been checked out of the index or the tree-ish,
 which gives it the same degree of noisy-ness as the case in which
 the command checks out a branch.

 Will merge to 'master'.


* en/rebase-merge-on-sequencer (2019-01-07) 8 commits
 - rebase: implement --merge via the interactive machinery
 - rebase: define linearization ordering and enforce it
 - git-legacy-rebase: simplify unnecessary triply-nested if
 - git-rebase, sequencer: extend --quiet option for the interactive machinery
 - am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
 - t5407: add a test demonstrating how interactive handles --skip differently
 - rebase: fix incompatible options error message
 - rebase: make builtin and legacy script error messages the same

 "git rebase --merge" as been reimplemented by reusing the internal
 machinery used for "git rebase -i".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 I am personally not yet quite convinced if this is worth pursuing.


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.


* js/smart-http-detect-remote-error (2019-01-07) 3 commits
 - remote-curl: die on server-side errors
 - remote-curl: tighten "version 2" check for smart-http
 - remote-curl: refactor smart-http discovery

 Some errors from the other side coming over smart HTTP transport
 were not noticed, which has been corrected.


* nb/branch-show-other-worktrees-head (2019-01-07) 4 commits
 - branch: add an extra verbose output displaying worktree path for checked out branch
 - branch: mark and color a branch that is checked out in a linked worktree differently
 - SQUASH???
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.
 

* ot/ref-filter-object-info (2018-12-28) 6 commits
 - ref-filter: add docs for new options
 - ref-filter: add tests for deltabase
 - ref-filter: add deltabase option
 - ref-filter: add tests for objectsize:disk
 - ref-filter: add check for negative file size
 - ref-filter: add objectsize:disk option

 The "--format=<placeholder>" option of for-each-ref, branch and tag
 learned to show a few more traits of objects that can be learned by
 the object_info API.

 Will merge to 'next'.


* sb/diff-color-moved-config-option-fixup (2018-11-14) 1 commit
  (merged to 'next' on 2019-01-04 at 46de5f42d1)
 + diff: align move detection error handling with other options

 Minor inconsistency fix.

 Will merge to 'master'.


* md/list-lazy-objects-fix (2018-12-06) 1 commit
  (merged to 'next' on 2019-01-04 at 93bd38fff9)
 + list-objects.c: don't segfault for missing cmdline objects

 "git rev-list --exclude-promisor-objects" had to take an object
 that does not exist locally (and is lazily available) from the
 command line without barfing, but the code dereferenced NULL.

 Will merge to 'master'.


* sb/more-repo-in-api (2018-12-28) 23 commits
 - t/helper/test-repository: celebrate independence from the_repository
 - path.h: make REPO_GIT_PATH_FUNC repository agnostic
 - commit: prepare free_commit_buffer and release_commit_memory for any repo
 - commit-graph: convert remaining functions to handle any repo
 - submodule: don't add submodule as odb for push
 - submodule: use submodule repos for object lookup
 - pretty: prepare format_commit_message to handle arbitrary repositories
 - commit: prepare logmsg_reencode to handle arbitrary repositories
 - commit: prepare repo_unuse_commit_buffer to handle any repo
 - commit: prepare get_commit_buffer to handle any repo
 - commit-reach: prepare in_merge_bases[_many] to handle any repo
 - commit-reach: prepare get_merge_bases to handle any repo
 - commit-reach.c: allow get_merge_bases_many_0 to handle any repo
 - commit-reach.c: allow remove_redundant to handle any repo
 - commit-reach.c: allow merge_bases_many to handle any repo
 - commit-reach.c: allow paint_down_to_common to handle any repo
 - commit: allow parse_commit* to handle any repo
 - object: parse_object to honor its repository argument
 - object-store: prepare has_{sha1, object}_file to handle any repo
 - object-store: prepare read_object_file to deal with any repo
 - object-store: allow read_object_file_extended to read from any repo
 - packfile: allow has_packed_and_bad to handle arbitrary repositories
 - sha1_file: allow read_object to read objects in arbitrary repositories
 (this branch is used by jt/get-reference-with-commit-graph and md/list-objects-filter-by-depth.)

 The in-core repository instances are passed through more codepaths.


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


* ps/stash-in-c (2019-01-04) 27 commits
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
 . alias: detect loops in mixed execution mode

 Two (or more) aliases that mutually refer to each other can form an
 infinite loop; we now attempt to notice and stop.

 Discarded.
 Reverted out of 'next'.
 cf. <87sh0slvxm.fsf@evledraar.gmail.com>


* gl/bundle-unlock-before-aborting (2018-11-14) 1 commit
 . bundle: rollback lock file while refusing to create an empty bundle

 Superseded by jk/close-duped-fd-before-unlock-for-bundle


* js/remote-archive-v2 (2018-09-28) 4 commits
 . archive: allow archive over HTTP(S) with proto v2
 . archive: implement protocol v2 archive command
 . archive: use packet_reader for communications
 . archive: follow test standards around assertions

 The original implementation of "git archive --remote" more or less
 bypassed the transport layer and did not work over http(s).  The
 version 2 of the protocol is defined to allow going over http(s) as
 well as Git native transport.

 Retracted; reverted out of next.
 cf. <20181114195142.GI126896@google.com>


* ab/format-patch-rangediff-not-stat (2018-11-24) 1 commit
 . format-patch: don't include --stat with --range-diff output

 The "--rangediff" option recently added to "format-patch"
 interspersed a bogus and useless "--stat" information by mistake,
 which is being corrected.

 Reverted out of 'next'.


* jc/postpone-rebase-in-c (2018-11-26) 1 commit
 . rebase: mark the C reimplementation as an experimental opt-in feature

 People seem to be still finding latent bugs in the "rebase in C"
 reimplementation.  For the upcoming release, use the scripted
 version by default and adjust the documentation accordingly.

 Reverted out of 'next'.
