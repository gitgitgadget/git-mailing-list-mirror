Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3E81F597
	for <e@80x24.org>; Wed,  1 Aug 2018 00:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbeHAClu (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 22:41:50 -0400
Received: from mout.web.de ([212.227.15.3]:37339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbeHAClu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 22:41:50 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MW6Ib-1fQipL3QD3-00XIB7; Wed, 01
 Aug 2018 02:58:46 +0200
Subject: Re: git merge -s subtree seems to be broken.
To:     Jeff King <peff@peff.net>, George Shammas <georgyo@gmail.com>
Cc:     git@vger.kernel.org
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <20180731155027.GA16910@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bef616af-6b1a-d96a-8c24-841137ecf506@web.de>
Date:   Wed, 1 Aug 2018 02:58:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731155027.GA16910@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qoJ3990WB5dT4HKDUAI8D8rmWvEQ1AN/XPmmoAHPi1prE0dpt21
 gPY30UMDr6SudtVDt17W7kIvKNEMZu8J6T/SH1e7LZPuMiJOqO0t5lZr2pdy8DJwkkOvYjd
 R9oKpxG4WwzqTbABU6P4cU3U7k/BJL8V5yRuUSZpLiLkqAZu9MA/Vv0Y/FTfl4kLQmIuCW3
 YuDMeZIbbUrIMDEA7v/fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0s8oOZCGDko=:3nRl+EXlYky2KiVF7UhTmt
 IdfQJU5uCu9KR8ejqzoSP2TkS/xrXbmv9h8Y5DjCuKvAB6gxRxA8z+5xlxAnwAgGe0fLDKCzf
 3sgfaJsNj+/czIVUiMsCu4iSmdgsAe/zqHIQl7S6VdG5HOfbgm20SBI5onvLwj9D/SL3tryIp
 XoorVkCL7yDV5rWEgauoYCvssMiczAtj6ILXbdSURAVk40r8a6gPCUJFtla+RNijMjPQ8i2v7
 n5Fyr2/NLJpVvIK2gxqoWLh4EDEDNY5++BZlJm1DmAjwK/REgAzeZRRxB/rSCyU8BwkSETx+O
 buf1xD00vTLuzhIDGZ2xuiOgdKi7t9Qnp/doPUTDPGA1V1l4k1Ko8saHKBtGUDomHZzsj16oY
 /xzf7QVikspCfBvEx5JY0te340PfoA4bcOg0aTjsjzEoKXSJa3B+bID+Gq9IprDfbDIXm0Yzb
 VgnjqBXSPkoVw1Ywgv3d/FQ0qbVL1HH1P3sizDmroAx4DVOa/Q7jhrHLZmNx/V4bhd1YFS9M3
 vxYb9KevrxDapZ7L2mstIwRh85cSzSbn9zmU2iQtjMCbr2oBrEBjXaqa1zJF/loaBwTJBKdHv
 EBvEhNZSwNOTNpJdPavcRqvhCni3X3oK6+PeDNVU2Z76V+f6JzGjRL+WSD2FrKsq09Pxfh5hh
 UCmAMRTcDl9LxLhJavt680domPPdjBoaUrxoEOPQJ34Wbk9Oxopo32HaSXBADKMwOKn19K1m7
 LYQLzryiGMYIV3LdkdD1SByf+f4w5+rv0G9hluZ6iGydXyu7e8hgk7Mub3Qp3J/Th8gCPyiKg
 3WhBC1N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.07.2018 um 17:50 schrieb Jeff King:
> On Tue, Jul 31, 2018 at 11:03:17AM -0400, George Shammas wrote:
> 
>> Bisecting around, this might be the commit that introduced the breakage.
>>
>> https://github.com/git/git/commit/d8febde
>>
>> I really hope that it hasn't been broken for 5 years and I am just doing
>> something wrong.
> 
> Unfortunately, I think it has been broken for five years.

I don't remember this change at all. :-(  Sorry for the trouble, everyone.
I should feel ashamed, but I'm only staring in bewilderment.

René
