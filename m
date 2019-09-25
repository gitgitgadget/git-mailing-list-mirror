Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146BC1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfIYUjZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:39:25 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:38020 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfIYUjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:39:25 -0400
Received: by mail-pf1-f169.google.com with SMTP id h195so138509pfe.5
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbOT7VPurQKAYH2qJZvdAPiDxDOf/hLJ4yqvEVMzlHI=;
        b=prKtSZT+FKzaJYuEzP5iUxj+1GueGzoesIKHRMYUcLs1hIU9O4N+57yVqT7NogSYzi
         AyUGtRUkwq9dvyd7F8Xa2i99EK/RhOqn4gskhTQwINmvgjkaurkrYQ1F1Mw/zMclwIbP
         APX5IgolqBBTbYpBdGDFV586QpmepdR1300pdo4MTTmUYH7kkGckmnWKqkWdqpf04Jlu
         /VxQJlhMSfEZ1z0VD0SxmDAYqtwcRq2a+Hfvanq4IGHllBIcP0pqZTN8M6IMMN8OTOKc
         N32xtZuGB5wlvZEPN9zE1wOB3rueOaPPDb1E5X41/XQCJX7HbvIyjI8l7IsuAG17bZtw
         NFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbOT7VPurQKAYH2qJZvdAPiDxDOf/hLJ4yqvEVMzlHI=;
        b=fG7t5jm07aGR45K1fiO78+4zNZWPMXIMA7mXdLiJ9iVRksMEIa6hxEgUcEvKsfGVp0
         Jjqu05RWL0xKuBi4PPJyRoSRINIt4+9MkBVAplovDRqY4mEb2p/6MEE0zoSPHAYMl4wp
         b6nQVLjj4bC0bt1En/hUJTIw09Pc7Lvu9w/NgwnIXGsV/49rFF+MbYSPelPI0idMaiVE
         k+GM+6LntBCWmg3IIPyo8XYdSOxH3plZmYvKyGxMCQO0nUCgojEMkPk6zgZpL1NC0ZnQ
         YoLgf3BZFLdeYe8c0Yry7k/QGjWnSu2tda0NQgsHUKdQaclt3LtXb7j5Y2w7wH3tQbSQ
         GfsA==
X-Gm-Message-State: APjAAAX1DOxMavgqunRbzSuHCaVc8hWfAfsmf/O4LFtMj55gjsOVa/Mt
        MwCPWYfqbTJy0dGuxfMGqP8=
X-Google-Smtp-Source: APXvYqyPgq8DjWJwOdX8sCAx+rlgV294DI3adOyjirpQ7lwJaKJ7PdZLSt74dq/ATN6dpjsg3Zv8Aw==
X-Received: by 2002:a63:ff18:: with SMTP id k24mr1242202pgi.427.1569443963933;
        Wed, 25 Sep 2019 13:39:23 -0700 (PDT)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id u9sm5440705pfl.138.2019.09.25.13.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:39:22 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:39:19 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
Message-ID: <20190925203919.GA89135@generichostname>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163504.14566-5-newren@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

I ran into a segfault on MacOS. I managed to bisect it down to
404ebceda0 (dir: also check directories for matching pathspecs,
2019-09-17), which should be the patch in the parent thread. The test
case below works fine without this patch applied but segfaults once it
is applied.

	#!/bin/sh

	git worktree add testdir
	git -C testdir checkout master
	git -C testdir fetch https://github.com/git/git.git todo
	bin-wrappers/git -C testdir checkout FETCH_HEAD # segfault here

Note that the worktree part isn't necessary to reproduce the problem but
I didn't want my files to be constantly refreshed, triggering a rebuild
each time.

I also managed to get this backtrace from running lldb at the segfault
but it is based on the latest "jch" commit, 1cc52d20df (Merge branch
'jt/merge-recursive-symlink-is-not-a-dir-in-way' into jch, 2019-09-20).

	* thread #1, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x8)
	  * frame #0: 0x00000001000f63a0 git`do_match_pathspec(istate=0x0000000100299940, ps=0x000000010200aa80, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, flags=0) at dir.c:420:2 [opt]
		frame #1: 0x00000001000f632c git`match_pathspec(istate=0x0000000100299940, ps=0x0000000000000000, name="Gitweb/static/js/lib/", namelen=21, prefix=0, seen=0x0000000000000000, is_dir=0) at dir.c:490:13 [opt]
		frame #2: 0x00000001000f8315 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=17, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1990:9 [opt]
		frame #3: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=14, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
		frame #4: 0x00000001000f82e9 git`read_directory_recursive(dir=0x00007ffeefbfe278, istate=0x0000000100299940, base=<unavailable>, baselen=7, untracked=<unavailable>, check_only=0, stop_at_first_file=0, pathspec=0x0000000000000000) at dir.c:1984:5 [opt]
		frame #5: 0x00000001000f60d1 git`read_directory(dir=0x00007ffeefbfe278, istate=0x0000000100299940, path="Gitweb/", len=7, pathspec=0x0000000000000000) at dir.c:2298:3 [opt]
		frame #6: 0x00000001001bded1 git`verify_clean_subdirectory(ce=<unavailable>, o=0x00007ffeefbfe8c0) at unpack-trees.c:1846:6 [opt]
		frame #7: 0x00000001001bdc1d git`check_ok_to_remove(name="Gitweb", len=6, dtype=4, ce=0x0000000103e70de0, st=0x00007ffeefbfe438, error_type=ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o=0x00007ffeefbfe8c0) at unpack-trees.c:1901:7 [opt]
		frame #8: 0x00000001001bdb01 git`verify_absent_1(ce=<unavailable>, error_type=<unavailable>, o=<unavailable>) at unpack-trees.c:1964:10 [opt]
		frame #9: 0x00000001001bafc0 git`verify_absent(ce=<unavailable>, error_type=<unavailable>, o=<unavailable>) at unpack-trees.c:1052:11 [opt] [artificial]
		frame #10: 0x00000001001bbc3c git`merged_entry(ce=0x0000000100605fb0, old=0x0000000000000000, o=0x00007ffeefbfe8c0) at unpack-trees.c:2013:7 [opt]
		frame #11: 0x00000001001bd2b7 git`call_unpack_fn(src=<unavailable>, o=<unavailable>) at unpack-trees.c:522:12 [opt]
		frame #12: 0x00000001001bca16 git`unpack_nondirectories(n=2, mask=2, dirmask=<unavailable>, src=0x00007ffeefbfe5d0, names=<unavailable>, info=0x00007ffeefbfe718) at unpack-trees.c:1029:12 [opt]
		frame #13: 0x00000001001bad1a git`unpack_callback(n=2, mask=2, dirmask=0, names=0x0000000102007390, info=0x00007ffeefbfe718) at unpack-trees.c:1229:6 [opt]
		frame #14: 0x00000001001b8be2 git`traverse_trees(istate=0x0000000100299940, n=2, t=<unavailable>, info=<unavailable>) at tree-walk.c:497:17 [opt]
		frame #15: 0x00000001001ba80f git`unpack_trees(len=2, t=0x00007ffeefbfebe0, o=0x00007ffeefbfe8c0) at unpack-trees.c:1546:9 [opt]
		frame #16: 0x000000010001a443 git`merge_working_tree(opts=0x00007ffeefbfee38, old_branch_info=0x00007ffeefbfeca0, new_branch_info=0x00007ffeefbfeda0, writeout_error=0x00007ffeefbfeccc) at checkout.c:704:9 [opt]
		frame #17: 0x000000010001a08c git`switch_branches(opts=0x00007ffeefbfee38, new_branch_info=0x00007ffeefbfeda0) at checkout.c:1057:9 [opt]
		frame #18: 0x0000000100018df0 git`checkout_branch(opts=<unavailable>, new_branch_info=<unavailable>) at checkout.c:1426:9 [opt]
		frame #19: 0x0000000100017b90 git`checkout_main(argc=0, argv=0x00007ffeefbff570, prefix=0x0000000000000000, opts=0x00007ffeefbfee38, options=<unavailable>, usagestr=<unavailable>) at checkout.c:1682:10 [opt]
		frame #20: 0x0000000100016f2d git`cmd_checkout(argc=2, argv=0x00007ffeefbff568, prefix=0x0000000000000000) at checkout.c:1731:8 [opt]
		frame #21: 0x00000001000026f6 git`run_builtin(p=0x000000010024c710, argc=2, argv=0x00007ffeefbff568) at git.c:444:11 [opt]
		frame #22: 0x0000000100001a36 git`handle_builtin(argc=2, argv=0x00007ffeefbff568) at git.c:673:3 [opt]
		frame #23: 0x000000010000235c git`run_argv(argcp=0x00007ffeefbff4ec, argv=0x00007ffeefbff4d8) at git.c:740:4 [opt]
		frame #24: 0x0000000100001794 git`cmd_main(argc=2, argv=0x00007ffeefbff568) at git.c:871:19 [opt]
		frame #25: 0x00000001000a4405 git`main(argc=<unavailable>, argv=0x00007ffeefbff560) at common-main.c:52:11 [opt]
		frame #26: 0x00007fff783053d5 libdyld.dylib`start + 1

Sorry for the information dump, I haven't had the time to properly look
into the issue but I just wanted to make sure that you're aware.

Thanks and hope this helps,

Denton
