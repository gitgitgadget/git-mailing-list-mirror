Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304E620357
	for <e@80x24.org>; Wed, 12 Jul 2017 23:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750954AbdGLXES (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:04:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34565 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdGLXEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:04:16 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so4615429pge.1;
        Wed, 12 Jul 2017 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KlgOAdPb4aFVvkCJ3vU7ZfomYqAMESqMKuE5xzyGfWM=;
        b=J1nBHE9nx+RIok1gVTsw711xvCJchdoFaTu5b04uaLzTzME12K8lMU+CjlE5utOGcc
         e/5iiEDbuX2O0E3bPxwVqD6fiQ3uzXOsQxckslRNN9VPQijQzxovYBjM45NygDD4uw85
         GXPZQ2OHNm2Zd2YTkesWGP5y3PcbpizTYKWo1XYJKAi/BvoIPoXD2zT4aDmi6AaJOhNM
         3xMQAmLMLdscxbbY1ctf28wXJ9NPlepZTIQ/nC3cD+w3kKa8g0euElhwtFxl3DR5VXNL
         mXKwsghUoh5xcQSpi2VugIHbWrjuQ7DyIQ6LDX9YEcrCTsKJw8SRT0tiy9q5+smZE4Bo
         CFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KlgOAdPb4aFVvkCJ3vU7ZfomYqAMESqMKuE5xzyGfWM=;
        b=BZKIDp6Bl6BjCjGq5GzPQF77dthmPvTdyPnEG8QOjZ0qrglnfqiR0XcvziIPhiKUYL
         Pa2PXNxT1Xfk/A9fbgmm4jHTQnh2pUwN6nXbBQagbRvymSevlMTTSmS2AusOa3+3E08a
         +1ffNMzpEQ6p7ROdv+uktCBkxuFnbum+q7NjsBFpyh0iJXSzihxDeYWfB9oXxIm8oFTd
         pCcl8YgSB2WcjSuDP0tkY/YtX7cKU/nWLQsBgyu0qA1EtyV4XxpP9nVTO6OIalvdpWB8
         u8D6NRwZ79fhkNSFqeZVhVA7MQpVWhBoVA3FKWTcq2Xg5RgB3QMEzNFkP/wwmTzdJrtH
         FWKQ==
X-Gm-Message-State: AIVw111ZbcD3LD4F74aTmh3g3yY9Blvo/yKhPy346x4Ous0/wUlWj/KA
        tSAH076DoIBhvWHwlmY=
X-Received: by 10.99.63.206 with SMTP id m197mr6114183pga.170.1499900655247;
        Wed, 12 Jul 2017 16:04:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id o13sm6745119pgr.40.2017.07.12.16.04.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 16:04:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.13.3
Date:   Wed, 12 Jul 2017 16:04:13 -0700
Message-ID: <xmqqinixz28i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.13.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.13.3'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.13.3 Release Notes
=========================

Fixes since v2.13.2
-------------------

 * The "collision detecting" SHA-1 implementation shipped with 2.13.2
   was still broken on some platforms.  Update to the upstream code
   again to take their fix.

 * The 'diff-highlight' program (in contrib/) has been restructured
   for easier reuse by an external project 'diff-so-fancy'.

 * "git mergetool" learned to work around a wrapper MacOS X adds
   around underlying meld.

 * An example in documentation that does not work in multi worktree
   configuration has been corrected.

 * The pretty-format specifiers like '%h', '%t', etc. had an
   optimization that no longer works correctly.  In preparation/hope
   of getting it correctly implemented, first discard the optimization
   that is broken.

 * The code to pick up and execute command alias definition from the
   configuration used to switch to the top of the working tree and
   then come back when the expanded alias was executed, which was
   unnecessarilyl complex.  Attempt to simplify the logic by using the
   early-config mechanism that does not chdir around.

 * "git add -p" were updated in 2.12 timeframe to cope with custom
   core.commentchar but the implementation was buggy and a
   metacharacter like $ and * did not work.

 * Fix a recent regression to "git rebase -i" and add tests that would
   have caught it and others.

 * An unaligned 32-bit access in pack-bitmap code ahs been corrected.

 * Tighten error checks for invalid "git apply" input.

 * The split index code did not honor core.sharedrepository setting
   correctly.

 * The Makefile rule in contrib/subtree for building documentation
   learned to honour USE_ASCIIDOCTOR just like the main documentation
   set does.

 * A few tests that tried to verify the contents of push certificates
   did not use 'git rev-parse' to formulate the line to look for in
   the certificate correctly.

 * After "git branch --move" of the currently checked out branch, the
   code to walk the reflog of HEAD via "log -g" and friends
   incorrectly stopped at the reflog entry that records the renaming
   of the branch.

 * The rewrite of "git branch --list" using for-each-ref's internals
   that happened in v2.13 regressed its handling of color.branch.local;
   this has been fixed.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.13.2 are as follows:

A. Wilcox (1):
      subtree: honour USE_ASCIIDOCTOR when set

Alejandro R. Sedeño (1):
      ref-filter.c: drop return from void function

Andreas Heiduk (2):
      doc: do not use `rm .git/index` when normalizing line endings
      doc: clarify syntax for %C(auto,...) in pretty formats

Christian Couder (3):
      read-cache: use shared perms when writing shared index
      t1301: move modebits() to test-lib-functions.sh
      t1700: make sure split-index respects core.sharedrepository

David Aguilar (1):
      mergetools/meld: improve compatibiilty with Meld on macOS X

James Clarke (1):
      pack-bitmap: don't perform unaligned memory access

Jeff King (10):
      diff-highlight: split code into module
      add--interactive: handle EOF in prompt_yesno
      add--interactive: quote commentChar regex
      reflog-walk: skip over double-null oid due to HEAD rename
      reflog-walk: duplicate strings in complete_reflogs list
      reflog-walk: don't free reflogs added to cache
      reflog-walk: include all fields when freeing complete_reflogs
      branch: only perform HEAD check for local branches
      branch: use BRANCH_COLOR_LOCAL in ref-filter format
      branch: set remote color in ref-filter branch immediately

Johannes Schindelin (8):
      discover_git_directory(): avoid setting invalid git_dir
      config: report correct line number upon error
      help: use early config when autocorrecting aliases
      t1308: relax the test verifying that empty alias values are disallowed
      t7006: demonstrate a problem with aliases in subdirectories
      alias: use the early config machinery to expand aliases
      sequencer: print autostash messages to stderr
      t5534: fix misleading grep invocation

Junio C Hamano (5):
      t3420: fix under GETTEXT_POISON build
      t1450: use egrep for regexp "alternation"
      submodule--helper: do not call utf8_fprintf() unnecessarily
      Prepare for 2.13.3
      Git 2.13.3

Kaartic Sivaraam (2):
      t7508: fix a broken indentation
      builtin/commit.c: fix a typo in the comment

Marc Branchaud (1):
      auto-correct: tweak phrasing

Phillip Wood (3):
      rebase -i: add test for reflog message
      rebase: add regression tests for console output
      rebase: add more regression tests for console output

Ralf Thielow (1):
      l10n: de.po: fix typo

René Scharfe (4):
      pretty: recalculate duplicate short hashes
      apply: check git diffs for missing old filenames
      apply: check git diffs for invalid file modes
      apply: check git diffs for mutually exclusive header lines

Stefan Beller (2):
      t4005: modernize style and drop hard coded sha1
      merge-recursive: use DIFF_XDL_SET macro

Ævar Arnfjörð Bjarmason (1):
      sha1dc: update from upstream

