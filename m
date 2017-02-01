Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF60E1F6BD
	for <e@80x24.org>; Wed,  1 Feb 2017 00:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdBAAoG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 19:44:06 -0500
Received: from avasout05.plus.net ([84.93.230.250]:36336 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdBAAoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 19:44:05 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id fCk21u0020srQBz01Ck344; Wed, 01 Feb 2017 00:44:03 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Hr8GIwbS c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=8R5MD0_VnzVZw1_F-YgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/5] add SWAP macro
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301637570.3469@virtualbox>
 <9bcae427-d654-a671-4368-030150168102@web.de>
 <alpine.DEB.2.20.1701301806591.3469@virtualbox>
 <6760493c-3684-b8bb-2c01-6621b8417246@web.de>
 <alpine.DEB.2.20.1701311305030.3469@virtualbox>
 <676ed19c-0c4e-341e-ba30-1f4a23440088@web.de>
Cc:     Git List <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <30d81b1c-1acc-4e4d-4f52-e056bbf7b3e2@ramsayjones.plus.com>
Date:   Wed, 1 Feb 2017 00:44:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <676ed19c-0c4e-341e-ba30-1f4a23440088@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/01/17 21:02, René Scharfe wrote:
[snip]
>> It would be trivially "optimized" out of the box, even when compiling with
>> Tiny C or in debug mode.
> 
> Such a compiler is already slowed down by memset(3) calls for initializing objects and lack of other optimizations.  I doubt a few more memcpy(3) calls would make that much of a difference.
> 
> NB: git as compiled with TCC fails several tests, alas.  Builds wickedly fast, though.

Hmm, a couple of years ago, I used tcc to build git and it worked
just fine (and it passed all tests). Prompted by this note, I just
built tcc from the current mob branch (@5420bb8) and built git OK,
but, yes, lots of tests now fail. :(

ATB,
Ramsay Jones


