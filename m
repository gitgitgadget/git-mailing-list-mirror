Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E4620D11
	for <e@80x24.org>; Mon,  5 Jun 2017 01:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdFEB0s (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 21:26:48 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36066 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdFEB0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 21:26:46 -0400
Received: by mail-pg0-f46.google.com with SMTP id a70so5893697pge.3;
        Sun, 04 Jun 2017 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bQUuvfgWjYFeRPC4Qj/EEWVdTwpiCYVgtnWL5H2dcUo=;
        b=SnIZThsnbD2DVWXeYApS+mT1MFQODpbKa3WUFM52PbSVh9zqAUAlywDSCk7IpHhHDH
         wuxfUHlp/dwwiD2OU+UY8HcGsInEYxU4F62+N+fxvCG3bgm/BChGBj/ZhbevZIpXl3Q8
         VwA1/yaNgmtXGh/E+bvysuMfYetmv6AJ9kQMAeMSAd3TgHx88yR8dPnPpFbZCkrHAXEh
         cb/grPY0yqn4rzn8JAu4mcc1uFL8PABWvsxHyNXgHbA1V+scbN0B9xFmxzAYOqUcxPW8
         hDc0CL8gXpliV5aJ29/2quYndmROAJ7vsiD/SH/vy2b4xUyUwdLuixU8EbeacWXc1BTV
         RV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bQUuvfgWjYFeRPC4Qj/EEWVdTwpiCYVgtnWL5H2dcUo=;
        b=jRNURsx+CrFYsmTQScroYEPaG8vHojCBq5OPnWkX2oZhi3SC+JNwJUrBWGIWyEKLVX
         Cwh9K4xtE+ir/5FG/AcNpFW9l9PeENPfrR0irzR5BBqwvL5lw0wl+WOnkUzqXH0cTdvm
         FLH3T+uvBbr5VRl3w9QW1J/D0ULUwT4iVABk+uZoqDmyJyFxWDuzWjHGdknRVg+sMEF4
         JE2a52SurSpS0zoFaDEAavX1ayjnUPnM7sAhlWKvmBpX6KFc9WDx2lyaLXb+PAc/xfxs
         w5hbMg5ljYysJKhChhdVU+H0rhhmUavUgLpbTBH6jGdJ2W5+slejKHDCBfUWo41KSRDE
         Zshw==
X-Gm-Message-State: AODbwcDVFm/dmMLSeMhVFrxb7aHthfnoFdmyMiizGpe4YfRilWHdfg2a
        6aCmX4h8LtPVJNrE7/o=
X-Received: by 10.84.232.3 with SMTP id h3mr12255280plk.42.1496626005166;
        Sun, 04 Jun 2017 18:26:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id o2sm53691880pgq.44.2017.06.04.18.26.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 18:26:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.13.1
Date:   Mon, 05 Jun 2017 10:26:42 +0900
Message-ID: <xmqqlgp7usvh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.13.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.13.1'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.13.1 Release Notes
=========================

Fixes since v2.13
-----------------

 * The Web interface to gmane news archive is long gone, even though
   the articles are still accessible via NTTP.  Replace the links with
   ones to public-inbox.org.  Because their message identification is
   based on the actual message-id, it is likely that it will be easier
   to migrate away from it if/when necessary.

 * Update tests to pass under GETTEXT_POISON (a mechanism to ensure
   that output strings that should not be translated are not
   translated by mistake), and tell TravisCI to run them.

 * Setting "log.decorate=false" in the configuration file did not take
   effect in v2.13, which has been corrected.

 * An earlier update to test 7400 needed to be skipped on CYGWIN.

 * Git sometimes gives an advice in a rhetorical question that does
   not require an answer, which can confuse new users and non native
   speakers.  Attempt to rephrase them.

 * "git read-tree -m" (no tree-ish) gave a nonsense suggestion "use
   --empty if you want to clear the index".  With "-m", such a request
   will still fail anyway, as you'd need to name at least one tree-ish
   to be merged.

 * The codepath in "git am" that is used when running "git rebase"
   leaked memory held for the log message of the commits being rebased.

 * "pack-objects" can stream a slice of an existing packfile out when
   the pack bitmap can tell that the reachable objects are all needed
   in the output, without inspecting individual objects.  This
   strategy however would not work well when "--local" and other
   options are in use, and need to be disabled.

 * Clarify documentation for include.path and includeIf.<condition>.path
   configuration variables.

 * Tag objects, which are not reachable from any ref, that point at
   missing objects were mishandled by "git gc" and friends (they
   should silently be ignored instead)

 * A few http:// links that are redirected to https:// in the
   documentation have been updated to https:// links.

 * Make sure our tests would pass when the sources are checked out
   with "platform native" line ending convention by default on
   Windows.  Some "text" files out tests use and the test scripts
   themselves that are meant to be run with /bin/sh, ought to be
   checked out with eol=LF even on Windows.

 * Fix memory leaks pointed out by Coverity (and people).

 * The receive-pack program now makes sure that the push certificate
   records the same set of push options used for pushing.

 * "git cherry-pick" and other uses of the sequencer machinery
   mishandled a trailer block whose last line is an incomplete line.
   This has been fixed so that an additional sign-off etc. are added
   after completing the existing incomplete line.

 * The shell completion script (in contrib/) learned "git stash" has
   a new "push" subcommand.

 * Travis CI gained a task to format the documentation with both
   AsciiDoc and AsciiDoctor.

 * Update the C style recommendation for notes for translators, as
   recent versions of gettext tools can work with our style of
   multi-line comments.

 * "git clone --config var=val" is a way to populate the
   per-repository configuration file of the new repository, but it did
   not work well when val is an empty string.  This has been fixed.

 * A few codepaths in "checkout" and "am" working on an unborn branch
   tried to access an uninitialized piece of memory.

 * "git for-each-ref --format=..." with %(HEAD) in the format used to
   resolve the HEAD symref as many times as it had processed refs,
   which was wasteful, and "git branch" shared the same problem.

 * "git interpret-trailers", when used as GIT_EDITOR for "git commit
   -v", looked for and appended to a trailer block at the very end,
   i.e. at the end of the "diff" output.  The command has been
   corrected to pay attention to the cut-mark line "commit -v" adds to
   the buffer---the real trailer block should appear just before it.

 * A test allowed both "git push" and "git receive-pack" on the other
   end write their traces into the same file.  This is OK on platforms
   that allows atomically appending to a file opened with O_APPEND,
   but on other platforms led to a mangled output, causing
   intermittent test failures.  This has been fixed by disabling
   traces from "receive-pack" in the test.

 * "foo\bar\baz" in "git fetch foo\bar\baz", even though there is no
   slashes in it, cannot be a nickname for a remote on Windows, as
   that is likely to be a pathname on a local filesystem.

 * The "collision detecting" SHA-1 implementation shipped with 2.13
   was quite broken on some big-endian platforms and/or platforms that
   do not like unaligned fetches.  Update to the upstream code which
   has already fixed these issues.

 * "git am -h" triggered a BUG().

 * The interaction of "url.*.insteadOf" and custom URL scheme's
   whitelisting is now documented better.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.13.0 are as follows:

Andreas Heiduk (4):
      Documentation: fix reference to ifExists for interpret-trailers
      Documentation: fix formatting typo in pretty-formats.txt
      doc: filter-branch does not require re-export of vars
      doc: rewrite description for rev-parse --short

Brian Malehorn (1):
      interpret-trailers: honor the cut line

Jean-Noel Avila (3):
      usability: don't ask questions if no reply is required
      read-tree -m: make error message for merging 0 trees less smart aleck
      git-filter-branch: be more direct in an error message

Jeff King (14):
      am: fix commit buffer leak in get_commit_info()
      am: simplify allocations in get_commit_info()
      am: shorten ident_split variable name in get_commit_info()
      pack-objects: disable pack reuse for object-selection options
      t5310: fix "; do" style
      docs/config: clarify include/includeIf relationship
      docs/config: give a relative includeIf example
      docs/config: avoid the term "expand" for includes
      docs/config: consistify include.path examples
      t5400: avoid concurrent writes into a trace file
      ref-filter: resolve HEAD when parsing %(HEAD) atom
      revision.c: ignore broken tags with ignore_missing_links
      am: handle "-h" argument earlier
      docs/config: mention protocol implications of url.insteadOf

Johannes Schindelin (31):
      mingw: avoid memory leak when splitting PATH
      winansi: avoid use of uninitialized value
      winansi: avoid buffer overrun
      add_commit_patch_id(): avoid allocating memory unnecessarily
      git_config_rename_section_in_file(): avoid resource leak
      get_mail_commit_oid(): avoid resource leak
      difftool: address a couple of resource/memory leaks
      status: close file descriptor after reading git-rebase-todo
      mailinfo & mailsplit: check for EOF while parsing
      cat-file: fix memory leak
      checkout: fix memory leak
      split_commit_in_progress(): simplify & fix memory leak
      setup_bare_git_dir(): help static analysis
      setup_discovered_git_dir(): plug memory leak
      pack-redundant: plug memory leak
      mktree: plug memory leaks reported by Coverity
      fast-export: avoid leaking memory in handle_tag()
      receive-pack: plug memory leak in update()
      line-log: avoid memory leak
      shallow: avoid memory leak
      add_reflog_for_walk: avoid memory leak
      remote: plug memory leak in match_explicit()
      name-rev: avoid leaking memory in the `deref` case
      show_worktree(): plug memory leak
      submodule_uses_worktrees(): plug memory leak
      Fix build with core.autocrlf=true
      git-new-workdir: mark script as LF-only
      completion: mark bash script as LF-only
      t3901: move supporting files into t/t3901/
      Fix the remaining tests that failed with core.autocrlf=true
      t4051: mark supporting files as requiring LF-only line endings

Johannes Sixt (2):
      mingw.h: permit arguments with side effects for is_dir_sep
      Windows: do not treat a path with backslashes as a remote's nick name

Jonathan Nieder (2):
      credential doc: make multiple-helper behavior more prominent
      clone: handle empty config values in -c

Jonathan Tan (3):
      sequencer: add newline before adding footers
      docs: correct receive.advertisePushOptions default
      receive-pack: verify push options in cert

Junio C Hamano (6):
      apply.c: fix whitespace-only mismerge
      checkout: fix memory leak
      doc: replace more gmane links
      read-tree: "read-tree -m --empty" does not make sense
      Prepare for 2.13.1; more topics to follow
      Git 2.13.1

Kyle Meyer (1):
      config.txt: add an entry for log.showSignature

Lars Schneider (6):
      travis-ci: build documentation with AsciiDoc and Asciidoctor
      travis-ci: parallelize documentation build
      travis-ci: unset compiler for jobs that do not need one
      travis-ci: check AsciiDoc/AsciiDoctor stderr output
      travis-ci: setup "prove cache" in "script" step
      travis-ci: add job to run tests with GETTEXT_POISON

Phillip Wood (3):
      rebase -i: fix reflog message
      rebase -i: silence stash apply
      rebase -i: add missing newline to end of message

Ramsay Jones (1):
      t7400: add !CYGWIN prerequisite to 'add with \\ in path'

René Scharfe (2):
      checkout: check return value of resolve_refdup before using hash
      am: check return value of resolve_refdup before using hash

SZEDER Gábor (1):
      docs/config.txt: fix indefinite article in core.fileMode description

Sahil Dua (1):
      branch test: fix invalid config key access

Stefan Beller (1):
      t5531: fix test description

Sven Strickroth (1):
      doc: use https links to Wikipedia to avoid http redirects

Thomas Gummerer (1):
      completion: add git stash push

Torsten Bögershausen (1):
      t0027: tests are not expensive; remove t0025

brian m. carlson (1):
      builtin/log: honor log.decorate

Ævar Arnfjörð Bjarmason (6):
      config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX
      doc: replace a couple of broken gmane links
      tests: fix tests broken under GETTEXT_POISON=YesPlease
      sha1dc: update from upstream
      tag: duplicate mention of --contains should mention --no-contains
      C style: use standard style for "TRANSLATORS" comments

