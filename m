Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258261FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbdA3Vqp (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:46:45 -0500
Received: from mout.web.de ([212.227.17.11]:64506 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbdA3Vqo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:46:44 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lz376-1cTnZs0Y5o-0148Sv; Mon, 30
 Jan 2017 22:46:36 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301637570.3469@virtualbox>
 <9bcae427-d654-a671-4368-030150168102@web.de>
 <alpine.DEB.2.20.1701301806591.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6760493c-3684-b8bb-2c01-6621b8417246@web.de>
Date:   Mon, 30 Jan 2017 22:46:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301806591.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:U0Ea53cAFGOeUctYEQCD8ny4whGUmOUUgPSSDYoYW3bIBbwLIR6
 bftZiIyvGLNiK5NRiHrqrt6RQ3TYdTyTBjhlQFM175Z3JT0LecO36YXRloG9BDb7rTno6f5
 c4EMNlJraazyU5B+o2I3mBiwscSuPYpHvjE83ZyFbmtCMHx9ui3yaMAqVdbrGRsGW1ieeG7
 twnlqmhL3ptXFmOVK+3nQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kcCJxF7JqqI=:7J0zwfy3slRGWv+upTp/Op
 X3MUVs33EuW55XVjiSc5sd5zfTVKqDmeHGeOCgTDtr7pgbGOEARu4P5b24q8pA3vEBT0/7Ns3
 MjcgB0YGi3aSleM2BfKjDMhQkMKHsvPTTAUHjdERzsNigRELDpFr0njXZ4ooZ46K4JCtWgd8Z
 XA2ZpCS+zlskJJvOSjJ6QjrXW7kiO02LOosfbJxD9PBHMdBPmxJ8S40FeX29+UoIxbo5V7IHa
 md64GQbYbVx++7F6p3tApVGMjQ95WOdBAcgFVLB1SXDlUE83VPVc1+2bQy2PTca0y9tqiTHEw
 wVWUfCQLxzls0vh0Ow13VvTWMLKnnaAFYkHLabLaC+ni83bifOwXNO2ZBMlbMgXvqcCzYwBnB
 N8PuwZkdft1uA80Ih8BApsCYo8cCGz26Zd3v3aTDTsF/VQ4tXpl6X+P1CzV9lVqvOemYzGCXO
 A8J2ixrmisJ75fp2SvykoQ12i/HPqXkLpB6NYtl/IyLZV155let+0EDgARuN0mWJpW7jn0znq
 9pTYIzRNlekwkdadVjK+m7MZVr0ANQl5PvjpbtmaLUqQxG+rjvDVO/FT147veB6BxYtZlDfue
 JIWmJc/7wixzwUEyBxwhVugnFC+YM0Z7SSDYkIrljH6OontqWZdk3rB7F7hITPVzbhfj61NGi
 VJKoSon+y/yp0DvI415XbTcqnF5PAfn/zN1/fog8KBKLvuVPBna9RpalC+dDL/N9wWApPJ6hB
 lpLCE0TxLjoBvaG311M3wZJM4i97dqHaZ8HpWQOSGL/2jdWaS3zc7JB23aSeaW3pxnuhU+SqQ
 O0JlINH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 21:48 schrieb Johannes Schindelin:
> So I tried to verify that Visual C optimizes this well, and oh my deity,
> this was not easy. In Debug mode, it does not optimize, i.e. the memcpy()
> will be called, even for simple 32-bit integers. In Release mode, Visual
> Studio's defaults turn on "whole-program optimization" which means that
> the only swapping that is going on in the end is that the meaning of two
> registers is swapped, i.e. the SWAP() macro is expanded to... no assembler
> code at all.
>
> After trying this and that and something else, I finally ended up with the
> file-scope optimized SWAP() resulting in this assembly code:
>
> 00007FF791311000  mov         eax,dword ptr [rcx]
> 00007FF791311002  mov         r8d,dword ptr [rdx]
> 00007FF791311005  mov         dword ptr [rcx],r8d
> 00007FF791311008  mov         dword ptr [rdx],eax

This looks good.

> However, recent events (including some discussions on this mailing list
> which had unfortunate consequences) made me trust my instincts more. And
> my instincts tell me that it would be unwise to replace code that swaps
> primitive types in the straight-forward way by code that relies on
> advanced compiler optimization to generate efficient code, otherwise
> producing very suboptimal code.

I don't know how difficult it was to arrive at the result above, but I 
wouldn't call inlining memcpy(3) an advanced optimization (anymore?), 
since the major compilers seem to be doing that.

The SWAP in prio-queue.c seems to be the one with the biggest 
performance impact.  Or perhaps it's the one in lookup_object()?  The 
former is easier to measure, though.

Here's what I get with CFLAGS="-builtin -O2" (best of five):

$ time ./t/helper/test-prio-queue $(seq 100000 -1 1) dump >/dev/null

real    0m0.142s
user    0m0.120s
sys     0m0.020s

And this is with CFLAGS="-no-builtin -O2":

$ time ./t/helper/test-prio-queue $(seq 100000 -1 1) dump >/dev/null

real    0m0.170s
user    0m0.156s
sys     0m0.012s

Hmm.  Not nice, but also not prohibitively slow.

> The commit you quoted embarrasses me, and I have no excuse for it. I would
> love to see that myswap() ugliness fixed by replacing it with a construct
> that is simpler, and generates good code even without any smart compiler.

I don't see a way to do that without adding a type parameter.

René
