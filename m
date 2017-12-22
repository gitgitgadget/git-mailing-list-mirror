Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1791F404
	for <e@80x24.org>; Fri, 22 Dec 2017 11:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdLVLta (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 06:49:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:61350 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdLVLt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 06:49:28 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1fA6l6333o-00zqFs; Fri, 22
 Dec 2017 12:49:20 +0100
Date:   Fri, 22 Dec 2017 12:49:19 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH] sequencer:
 improve config handling)
In-Reply-To: <1513874528.9646.2.camel@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712221201210.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>   <20171213114621.30250-1-phillip.wood@talktalk.net>  <1513794792.9785.2.camel@gmail.com>  <alpine.DEB.2.21.1.1712211442470.406@MININT-6BKU6QN.europe.corp.microsoft.com>
 <1513874528.9646.2.camel@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GL9cSDpYjTG+wLoYj5EMP/Lv4aXcK69luT3Gt9unboedDmm3l5T
 h8LsShGENgtVNwrQitv34JH76rQZ4WtlagR+YdIxrCLdUtulT7rsY+w8cxYeLrPMK3A6qfH
 rJO+OfUr682kueGH1Sq6H+eLCAdhjPttmxc+zvm240OfZ7bcU50hOfAEo6+K2Ifjfes17Ss
 +2vAonf9jpaNvqfhYvueQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q4GXMC7Hzlo=:69TMhm/pbX+IdYyYb76Mpv
 FkVcJLBFHpvHg2C4or9v5ie1a5kzEREl8PCYBMuyMaMwGC7otHOPhzDxSK3f4Y8Bvqu7EIsMS
 VFxe6s52Y0ZTQVkh/xGuALkXiIh7zmZ/UwhRVgjwMxpHUJLLXmnczJN49/ChQlfiKi8/9CZAV
 vRV2wZC96HabJK37rUeverf6qL+7aRVhlBkxVtPvpacVfZsrvFaMQDZCyPlItDhBV0PJiw5ZO
 tdZmjZurzK9wYSP/VeOd7Heq/NkDBxhWUBN+uWPHGZ1NF70q447aGKRUM1Ck5X3C1Y0usO2Tv
 bvO9rtUJnUZvKrmPy/6rgfAi9/iwmDGt5pkG7ACBdF3LWWjGRtnmsdTruronJRnn3otfxhx0h
 LLAKzS+oENcy3hvoWnXd6HqjvfwFf05SXaqYMIJI9ISMPeXLkJIcK6Ng2j1/LVXblR/Ent0k7
 h+p+JSwRWYQatTjuCiwaTDXfTWGgkAK6d1/JL9CzT6XCn5CDdPJPOVLOa8hRglFQM55kP/WQ5
 Weh5WWX5pXz0n5oyvVatLVQdEI0Y6aDKl3soJZv4lS25tOcwRmmPdcFjejsqtr1Zu8ehmC2es
 nrP1ICx3V86nP6mH3fm31LCOjuGT6dDI/N91CVh7eB4xiZH81fMc4jNV50FJHWbow9CNrMKNV
 t/Xeb10om5PJ7984dxZKS93BOYLZKQUVAx1qsmnnuJEvbZ76YBI3CBcZlS4a4xNq7DxieH2xx
 ia6XV/LmMU0KGhZ2n2hjE4FfyZSq4sV7Mc3aTUtBxICcpu9QlPC/+hCDnJOoJc1C+CGsNS/CP
 OX0t8akrmQSzVXoE0kCfcUxVJdrUzmPBqtHZ8d5gVtwUzsug0U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Thu, 21 Dec 2017, Kaartic Sivaraam wrote:

> Speaking of trace, (thanks to Dscho!) the one I got using 'valgrind'
> (with `--leak-check=full` option) can be found below. I've kept only
> relevant parts of it to avoid unwanted noise of `set -x`. Let me know
> if that's needed too.
> 
> ...
> 
> + git diff-files --quiet --ignore-submodules
> + git diff-index --cached --quiet --ignore-submodules HEAD --
> + test 0 = 1
> + test -z 1
> + valgrind --leak-check=full git rebase--helper --continue
> ==10384== Memcheck, a memory error detector
> ==10384== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
> ==10384== Using Valgrind-3.12.0.SVN and LibVEX; rerun with -h for copyright info
> ==10384== Command: git rebase--helper --continue
> ==10384== 
> ==10384== Invalid free() / delete / delete[] / realloc()
> ==10384==    at 0x4C2CDDB: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==10384==    by 0x24E3F8: read_populate_opts (sequencer.c:1964)
> ==10384==    by 0x24E3F8: sequencer_continue (sequencer.c:2753)
> ==10384==    by 0x1735DC: cmd_rebase__helper (rebase--helper.c:52)
> ==10384==    by 0x11B847: run_builtin (git.c:346)
> ==10384==    by 0x11B847: handle_builtin (git.c:554)
> ==10384==    by 0x11BB05: run_argv (git.c:606)
> ==10384==    by 0x11BB05: cmd_main (git.c:683)
> ==10384==    by 0x11AC0B: main (common-main.c:43)
> ==10384==  Address 0x2a898a is in a r-x mapped file /mnt/Source/Git/git-next/git segment
> ==10384== 
> Successfully rebased and updated refs/heads/public.
> ==10384== 
> ==10384== HEAP SUMMARY:
> ==10384==     in use at exit: 680,882 bytes in 332 blocks
> ==10384==   total heap usage: 717 allocs, 386 frees, 1,709,293 bytes allocated
> ==10384== 
> ==10384== 2,053 (2,048 direct, 5 indirect) bytes in 1 blocks are definitely lost in loss record 75 of 83
> ==10384==    at 0x4C2BADF: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==10384==    by 0x4C2DE5F: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==10384==    by 0x27E0FE: xrealloc (wrapper.c:138)
> ==10384==    by 0x2072A3: add_object_array_with_path (object.c:319)
> ==10384==    by 0x23D745: add_pending_object_with_path (revision.c:163)
> ==10384==    by 0x24030E: add_pending_object_with_mode (revision.c:170)
> ==10384==    by 0x24030E: add_pending_object (revision.c:176)
> ==10384==    by 0x24030E: add_head_to_pending (revision.c:188)
> ==10384==    by 0x280EFA: has_uncommitted_changes.part.17 (wt-status.c:2288)
> ==10384==    by 0x24DF88: commit_staged_changes (sequencer.c:2705)
> ==10384==    by 0x24DF88: sequencer_continue (sequencer.c:2749)
> ==10384==    by 0x1735DC: cmd_rebase__helper (rebase--helper.c:52)
> ==10384==    by 0x11B847: run_builtin (git.c:346)
> ==10384==    by 0x11B847: handle_builtin (git.c:554)
> ==10384==    by 0x11BB05: run_argv (git.c:606)
> ==10384==    by 0x11BB05: cmd_main (git.c:683)
> ==10384==    by 0x11AC0B: main (common-main.c:43)
> ==10384== 
> ==10384== LEAK SUMMARY:
> ==10384==    definitely lost: 2,048 bytes in 1 blocks
> ==10384==    indirectly lost: 5 bytes in 1 blocks
> ==10384==      possibly lost: 0 bytes in 0 blocks
> ==10384==    still reachable: 678,829 bytes in 330 blocks
> ==10384==         suppressed: 0 bytes in 0 blocks
> ==10384== Reachable blocks (those to which a pointer was found) are not shown.
> ==10384== To see them, rerun with: --leak-check=full --show-leak-kinds=all
> ==10384== 
> ==10384== For counts of detected and suppressed errors, rerun with: -v
> ==10384== ERROR SUMMARY: 2 errors from 2 contexts (suppressed: 0 from 0)
> + exit
> 
> 
> I think I didn't mention I've set `commit.gpgsign` to `true` for that
> repo, did I?

Hah! I had troubles to associate the correct line in my versions of Git's
source code (the line numbers alone are only reliable if you also have a
commit from which the Git binaries were built), but I did this free() at
(https://github.com/git/git/blob/cd54ea2b18/sequencer.c#L1975:

	if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
		if (!starts_with(buf.buf, "-S"))
			strbuf_reset(&buf);
		else {
			free(opts->gpg_sign);
			^^^^^^^^^^^^^^^^^^^^^
			opts->gpg_sign = xstrdup(buf.buf + 2);
		}
		strbuf_reset(&buf);
	}

The culprit is that we have these really unclear ownership rules, where it
is not at all clear who is responsible for releasing allocated memory:
caller or callee? (Hannes would not rightfully point out that this would
be a non-issue if we would switch to C++). In C, the common pattern is to
use `const char *` for users that are *not* supposed to take ownership,
and `char *` for users that are supposed to take custody. And in this
instance, `gpg_sign` should be owned by `struct replay_opts` because of
this (https://github.com/git/git/blob/cd54ea2b18/sequencer.h#L38):

	char *gpg_sign;

Technically, using `char *` (instead of `const char *`) does not say
"you're now responsible for de-allocating this memory", of course, but in
practice it is often used like this (and the signature of `free(void *)`
certainly encourages that type of interpreting the `const` qualifier).

But. There is a problem when you set commit.gpgSign = true (see
https://github.com/git/git/blob/cd54ea2b18/sequencer.c#L162-L165):

	if (!strcmp(k, "commit.gpgsign")) {
		opts->gpg_sign = git_config_bool(k, v) ? "" : NULL;
		return 0;
	}

See how a "" is assigned to that field of type `char *`? It should not
even be possible, as the "" is implicitly read-only memory. And it
certainly was never malloc()ed.

So how to solve it? My suggestion would be to use xstrdup("") instead of
"" here.

I spent a little quality time with the code and came up with a patch that
I will send out in a moment.

By the way, Kaartic, thank you so much for focusing on correctness before
focusing on style issues. I know it is harder to review patches for
correctness than it is to concentrate on style issues, but in my mind it
is not only much more work, but also a lot more valuable.

Ciao,
Dscho
