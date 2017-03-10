Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B934E202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 00:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbdCJAPO (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 19:15:14 -0500
Received: from mout.web.de ([217.72.192.78]:63834 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753252AbdCJAPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 19:15:12 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJTZX-1cocNm1q9L-0034QX; Fri, 10
 Mar 2017 01:14:57 +0100
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Jeff King <peff@peff.net>, Vegard Nossum <vegard.nossum@oracle.com>
References: <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
 <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <63a6ec61-653d-6307-4739-2ebaa8dbde35@web.de>
Date:   Fri, 10 Mar 2017 01:14:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:nHCt1XFdR39SNLLGBPx4yL8mOtz3+/+AD+bUhR+3iJiaQSWhSDF
 uQV0mPbxB5Smga9j57CAyRg/Ppy1+u1bNZ9r7YbYQhN1FfgYWbKxCadzXUagfIq4d4ZP4X0
 nPefhYJVq2U7lia7NIZ3iFKsTt05KbenDcwAaeVdaLDqAuNofsvhRmVBerRq5B5wyttH+FA
 zMKcol7C/zgog9zHM3CVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AAu4blNcMCg=:hoFNbUg6kiekPKzaHLq/xT
 wbzIFGV7HFJyq37JUu60QbMKh1mbyhRET2iiwMb/9u0RteV13gdA55S6DjJZrRjO/iZPlTzSx
 zYU87Kfu5BeXQ0k1Ovvw/oYNIsKR9OHW3TsuoPjLxDLJKpUecsj7YqUTFkBB2TUxod8/QRuyw
 IkWiZnmTk95BCPTS1y1r1LeFmfxmoOUup/AKf5/bAzaxCHwrRKiJGuIpmEDspuz4OrMqc3kTf
 p9LxqApediYnsMeYrBowmn77YS9NwBxDRjr66hFMDvGErK2OEi92NKAEe/h+AHIEi2oCU7EnO
 mZzU6L/V6Choc7KwTu21ynZTsjWgux0+OnB1Qqfd1ZjsWgithcPm+FP5VJkRLTryB21UTCJDH
 cehuork23au15wTTc3GOmTaDpvmehccf9xwBguLsHQulCWcSfECZcCqji49Yid/t6ssgVZFoL
 A7UAuwmjDMWK3YhPst523zTfu0OqknEZgNgR/+IELKor1nLUovN6tw10Z6H4aZxZK/emzK+uk
 /04lOt1c14S26Iz3/TTCkBdzoRTybktFfsk4VxN/98qTduhuVWuXpOPoxeC8Pbs4I7Sir5wqJ
 TEE9ZKjtrIot0Ho9ect0V9Ixem+bAXSOmOgCpbCV7VK0/In41hK6UXAI3YhuvC4UWsWoKdw53
 1hjoip4yl/0gdK1Tm5lYm8OnXb5JbPlNEfndQjbAzgdC6bYRv/LiQ5y4dqaRhKytHSN2arF14
 iOunvSH4q3Hw6ktycU99vbH0SzgPm0xuWezh/TlxUYHmo3Q9Ak4PwA36/IylMBAp0yA1HgGRe
 llb7hip
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.2017 um 12:36 schrieb Jeff King:
> I grepped for 'memcpy.*sizeof' and found one other case that's not a
> bug, but is questionable.
>
> Of the "good" cases, I think most of them could be converted into
> something more obviously-correct, which would make auditing easier. The
> three main cases I saw were:

>   3. There were a number of alloc-and-copy instances. The copy part is
>      the same as (2) above, but you have to repeat the size, which is
>      potentially error-prone. I wonder if we would want something like:
>
>        #define ALLOC_COPY(dst, src) do { \
>          (dst) = xmalloc(sizeof(*(dst))); \
> 	 COPY_ARRAY(dst, src, 1); \
>        while(0)
>
>      That avoids having to specify the size at all, and triggers a
>      compile-time error if "src" and "dst" point to objects of different
>      sizes.

Or you could call it DUP or similar.  And you could use ALLOC_ARRAY in
its definition and let it infer the size implicitly (don't worry too
much about the multiplication with one):

	#define DUPLICATE_ARRAY(dst, src, n) do {	\
		ALLOC_ARRAY((dst), (n));		\
		COPY_ARRAY((dst), (src), (n));		\
	} while (0)
	#define DUPLICATE(dst, src) DUPLICATE_ARRAY((dst), (src), 1)

But do we even want such a thing?  Duplicating objects should be rare, 
and keeping allocation and assignment/copying separate makes for more 
flexible building blocks.  Adding ALLOC (and CALLOC) for single objects 
could be more widely useful, I think.

René
