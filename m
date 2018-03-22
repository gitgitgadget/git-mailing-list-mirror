Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6086C1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 22:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeCVWLY (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 18:11:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36240 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCVWLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 18:11:19 -0400
Received: by mail-wr0-f193.google.com with SMTP id d10so10234827wrf.3;
        Thu, 22 Mar 2018 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Qgp9NQlFEBfztmLygjUxe0+ISVjNQZJFK8ZAkLVRuRc=;
        b=QhpQXSy6x2ujn6P/ZS60TpCXlERsRn/ArfiE5vwXGjGONF8aFLavdPSAYwCu04Akgt
         hKNHjERWRag2XRCUt8x+8xEov0kCqmQJFVF9UY5CPIESQ8UJcqO3Y3xjR5rUiF8xL/uX
         GQnrmima1YrQxchy5uaLMh46HEybXJdx7Vqj+fVzy6TiXifScBH5eSBqJj83pO7k+f5K
         pH1Ze6JeRa+SAPMZrcG7/+ps64PK/EYJWxK6SEdcpKNKLMxCwYs8HPoxMrQZVjT5/be4
         zm5zP45MP1RoN93i4p1QzK69pN04B7rPSwirt+8Pwjqmx2i1HJkRn/sWZW3wLv1Db6aM
         ECFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Qgp9NQlFEBfztmLygjUxe0+ISVjNQZJFK8ZAkLVRuRc=;
        b=er2hWqmqzjr1w4iTzePojnqlw2JY0SWYRH0u9caQtsYOV2FqXR8n4getIo0Wfoexeo
         ma4exNgME0h/zzOo/FzKdCxJVJYdbfjUiH5qv8l0CCZ38BUqy3k4ncLeumqMnAxzLZp3
         XcDUUS1qcUPSIhIoVxYnZD9U5eeCyXTsrT9ToRlWzFW2dU2PnNaJfUkdhiSy+zpjQBSc
         9cSq1cf3RsaThEsK65jukGri3vYpxzHecQoQE8i1OIVAVIurdfeEs5eog2RFhdcKvFmS
         d4jsKijB2l0T9v+9uTYsD0aS2uXX6nBUOLXnKzGUVZZa6SbmAXnaCWLAEehq8osUjtbt
         BiRA==
X-Gm-Message-State: AElRT7FqlG/oI15tTeM+Me+65Ks2BP5fOQK7/3j58NKpdad0D+fc/Jhb
        J9Le1P+Y0vXpRnnpks3U76OAEktR
X-Google-Smtp-Source: AG47ELskUZFjWjVM7sJQ6FdcTR/Zu0Ze3AOouPrf3stc3q1TzJdoL/ISh0Jd0VzOeJmBgscesfkK8Q==
X-Received: by 10.223.184.188 with SMTP id i57mr20931848wrf.105.1521756677300;
        Thu, 22 Mar 2018 15:11:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l17sm7387943wrh.58.2018.03.22.15.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 15:11:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.16.3
Date:   Thu, 22 Mar 2018 15:11:16 -0700
Message-ID: <xmqq4ll7lq0r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.16.3 is now available at
the usual places.  It merges many small fixes and documentation
updates that have been in the 'master' branch for a few weeks.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.16.3'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.16.3 Release Notes
=========================

Fixes since v2.16.2
-------------------

 * "git status" after moving a path in the working tree (hence making
   it appear "removed") and then adding with the -N option (hence
   making that appear "added") detected it as a rename, but did not
   report the  old and new pathnames correctly.

 * "git commit --fixup" did not allow "-m<message>" option to be used
   at the same time; allow it to annotate resulting commit with more
   text.

 * When resetting the working tree files recursively, the working tree
   of submodules are now also reset to match.

 * Fix for a commented-out code to adjust it to a rather old API change
   around object ID.

 * When there are too many changed paths, "git diff" showed a warning
   message but in the middle of a line.

 * The http tracing code, often used to debug connection issues,
   learned to redact potentially sensitive information from its output
   so that it can be more safely sharable.

 * Crash fix for a corner case where an error codepath tried to unlock
   what it did not acquire lock on.

 * The split-index mode had a few corner case bugs fixed.

 * Assorted fixes to "git daemon".

 * Completion of "git merge -s<strategy>" (in contrib/) did not work
   well in non-C locale.

 * Workaround for segfault with more recent versions of SVN.

 * Recently introduced leaks in fsck have been plugged.

 * Travis CI integration now builds the executable in 'script' phase
   to follow the established practice, rather than during
   'before_script' phase.  This allows the CI categorize the failures
   better ('failed' is project's fault, 'errored' is build
   environment's).

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.16.2 are as follows:

Ben Peart (1):
      fsmonitor: update documentation to remove reference to invalid config settings

Brandon Williams (1):
      oidmap: ensure map is initialized

Christian Ludwig (1):
      t9001: use existing helper in send-email test

Eric Sunshine (2):
      git-worktree.txt: fix missing ")" typo
      git-worktree.txt: fix indentation of example and text of 'add' command

Eric Wong (2):
      fsck: fix leak when traversing trees
      git-svn: control destruction order to avoid segfault

Genki Sky (1):
      test-lib.sh: unset XDG_CACHE_HOME

Jeff King (10):
      t5570: use ls-remote instead of clone for interp tests
      t/lib-git-daemon: record daemon log
      daemon: fix off-by-one in logging extended attributes
      daemon: handle NULs in extended attribute string
      t/lib-git-daemon: add network-protocol helpers
      daemon: fix length computation in newline stripping
      t0205: drop redundant test
      git-sh-i18n: check GETTEXT_POISON before USE_GETTEXT_SCHEME
      commit: drop uses of get_cached_commit_buffer()
      revision: drop --show-all option

Jonathan Tan (2):
      http: support cookie redaction when tracing
      http: support omitting data from traces

Juan F. Codagnone (1):
      mailinfo: avoid segfault when can't open files

Junio C Hamano (2):
      worktree: say that "add" takes an arbitrary commit in short-help
      Git 2.16.3

Kaartic Sivaraam (2):
      Doc/gitsubmodules: make some changes to improve readability and syntax
      Doc/git-submodule: improve readability and grammar of a sentence

Mathias Rav (1):
      files_initial_transaction_commit(): only unlock if locked

Motoki Seki (1):
      Documentation/gitsubmodules.txt: avoid non-ASCII apostrophes

Nguyễn Thái Ngọc Duy (12):
      t2203: test status output with porcelain v2 format
      Use DIFF_DETECT_RENAME for detect_rename assignments
      wt-status.c: coding style fix
      wt-status.c: catch unhandled diff status codes
      wt-status.c: rename rename-related fields in wt_status_change_data
      wt-status.c: handle worktree renames
      read-cache.c: change type of "temp" in write_shared_index()
      read-cache.c: move tempfile creation/cleanup out of write_shared_index
      diff.c: flush stdout before printing rename warnings
      read-cache: don't write index twice if we can't write shared index
      completion: fix completing merge strategies on non-C locales
      gitignore.txt: elaborate shell glob syntax

Ramsay Jones (2):
      config.mak.uname: remove SPARSE_FLAGS setting for cygwin
      Makefile: suppress a sparse warning for pack-revindex.c

Randall S. Becker (1):
      hashmap.h: remove unused variable

René Scharfe (2):
      describe: use strbuf_add_unique_abbrev() for adding short hashes
      cocci: simplify check for trivial format strings

Robert P. J. Day (2):
      t/: correct obvious typo "detahced"
      Correct mispellings of ".gitmodule" to ".gitmodules"

SZEDER Gábor (11):
      travis-ci: build Git during the 'script' phase
      t5541: add 'test_i18ngrep's missing filename parameter
      t5812: add 'test_i18ngrep's missing filename parameter
      t6022: don't run 'git merge' upstream of a pipe
      t4001: don't run 'git status' upstream of a pipe
      t5510: consolidate 'grep' and 'test_i18ngrep' patterns
      t5536: let 'test_i18ngrep' read the file without redirection
      t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
      t: validate 'test_i18ngrep's parameters
      t: make 'test_i18ngrep' more informative on failure
      t: document 'test_must_fail ok=<signal-name>'

Stefan Beller (5):
      t/lib-submodule-update.sh: clarify test
      t/lib-submodule-update.sh: fix test ignoring ignored files in submodules
      unpack-trees: oneway_merge to update submodules
      submodule: submodule_move_head omits old argument in forced case
      Documentation/git-status: clarify status table for porcelain mode

Stefan Moch (2):
      t7001: add test case for --dry-run
      mv: remove unneeded 'if (!show_only)'

Thomas Gummerer (3):
      read-cache: fix reading the shared index for other repos
      split-index: don't write cache tree with null oid entries
      travis: run tests with GIT_TEST_SPLIT_INDEX

Todd Zullinger (1):
      doc: mention 'git show' defaults to HEAD

Yasushi SHOJI (1):
      bisect: debug: convert struct object to object_id

brian m. carlson (1):
      docs/interpret-trailers: fix agreement error

Ævar Arnfjörð Bjarmason (2):
      commit doc: document that -c, -C, -F and --fixup with -m error
      commit: add support for --fixup <commit> -m"<extra message>"

