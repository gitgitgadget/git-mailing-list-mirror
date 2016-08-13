Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E9C2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbcHMR0X (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 13:26:23 -0400
Received: from mout.web.de ([212.227.15.14]:61740 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbcHMR0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 13:26:22 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LhhVB-1auuHy3RUP-00mrnV; Sat, 13 Aug 2016 19:26:03
 +0200
Subject: Re: [PATCH] correct FLEXPTR_* example in comment
To:	Jeff King <peff@peff.net>
References: <57AEE1E1.3080901@web.de>
 <20160813090947.uj6hurji5o6cwxge@sigill.intra.peff.net>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AF582A.3050406@web.de>
Date:	Sat, 13 Aug 2016 19:26:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160813090947.uj6hurji5o6cwxge@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Wo8f8E+VmBGDO+dliDarxlwa0PKieUFH8lSy1cNFzovQ4T3ue/8
 d+Rcb0KJMbm9L4Q0Ao6nT5HcLRmfO+ULPotIt34TkiiOz1vk8FPm99Q8YnDU/t79pDcCHpr
 ejbgn0DHK8o0FeG7baEa6NufurzUUaxXKk6duT7r/P7VO3FZvGLq5iGDKCNoDnZ3E3QX8Dp
 xcOpB4HyvUBn4TF8R0/zw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2oP0e1WMA7g=:jqPdScQdzdLuD9ylVWUkaP
 LLFZ40ED1hpPJFwGX719SfXMiVxlkSUd8Q1lsuB931Rb3LTx4O+iuR2ngV3awTTASnk+8pp+I
 ePpwhXrRTj/zcojTpf+ppacI8EFey4u43Fyt1tvo1yZHIdktXRwd7yrW31fJ0Szuy/ZGgFvvD
 3onAixBvFF19uYvQVV435w5L+6N4Hq7k+QRo2KRi55U56XpgKtACa/JaMfkwKEAF/6LqEH899
 XQCdbfXOR/4Ke26BuQqq0p/yEI5VDqAa5aZ0cTGtNdzrGmIUGLWLzsLXQZJ8CCPSR1sK/uY6K
 Nx9WpyZ9gDJpfMD9Sn/gp8LrxCGrF66RGDkR9t6WzH3zTXt65rkBbn0eshlcMf7LzXJsvV9Fm
 uFYhl8tD6P11pUjLUAeqq9j7GYLY9KnLT+FfYRrUAqGkPzWrr4CK9r0SrAX8IitBOOhX/J6hv
 XU3/gcUAf2If2F3nhxsKItmpME/ROPo5xDMEGHL7aJ9rV+b+EdX6JH2+b7uHmt9Z03qycocYq
 0u1/j57nCSTXcTAFILTxoiVKlUSDO4kmrhIotZnF19gZeivhT5b0KXFMKWVR2mYru3c5OznL4
 Ye9LCWrSiy/n8pmwunv70EUEXe4ar7BRadOqTsax9Fe8+hJQjBTtZ82RCJXUaCB4zL0YiC48V
 BkAX2AeiBPzPBuGVksN+LvIgXbOTTIsd7DOKciGfKASTmZF2mea6wbcyvrYhsbmkczjbtvsZ1
 mXlSDRZ9M2ZHEdEOOxEVXcr6G9LNAbYTOH4O/fNenvTvQmZs5eQBuuiZ05dUqKeQi7e9Bbp2E
 aMXYfMd
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 13.08.2016 um 11:09 schrieb Jeff King:
> On Sat, Aug 13, 2016 at 11:01:21AM +0200, René Scharfe wrote:
>
>> This section is about "The FLEXPTR_* variants", so use FLEXPTR_ALLOC_STR
>> in the example.
>
> Oops, yeah. Your patch is clearly an improvement.
>
> Since this is obviously an easy mistake to make (using one form rather
> than the other), I wondered if the compiler would catch it.
>
> I think it would catch an accidental use of FLEXPTR instead of FLEX,
> because it involves an attempted assignment of an array.

Gcc 5.4 reports "invalid use of flexible array member".

> But I don't
> think we would catch the reverse; we'd just write the data directly on
> top of the pointer. That would probably crash immediately at runtime, so
> if you exercise the code at all in tests, it is OK. But something to be
> aware of.

No hint at compile time, segfaults at runtime.

> I suppose it could assert(sizeof((x)->flexname) == FLEX_ALLOC) or
> something, but I'm not sure if it is worth worrying about.

You can't use sizeof with an actual flexible array.  It only works if 
FLEX_ARRAY is defined as 1 (for platforms without native support), and 
perhaps also if it's 0.

offsetof(struct x, arr) == sizeof(struct x) won't work either because of 
padding.

I have no idea what you can do with a flexible array that would throw a 
compile error when done with a pointer.

René
