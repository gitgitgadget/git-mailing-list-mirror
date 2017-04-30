Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047F51F829
	for <e@80x24.org>; Sun, 30 Apr 2017 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757040AbdD3ReB (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 13:34:01 -0400
Received: from avasout08.plus.net ([212.159.14.20]:59408 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936498AbdD3Rd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 13:33:59 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id EhZw1v0011keHif01hZxAF; Sun, 30 Apr 2017 18:33:57 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=Q9fys5e9bTEA:10 a=EBOSESyhAAAA:8 a=6uQVynK4E7Vvu5YBPncA:9 a=PUjeQqilurYA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in
 path'
To:     Johannes Sixt <j6t@kdbg.org>
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
 <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com>
 <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org>
 <a575542a-e5b6-389f-e240-d5ac5a4b4107@ramsayjones.plus.com>
 <f9dfd9b4-e753-1a53-175e-8f20fe904501@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4238aa44-0d9b-0b47-3bd1-61dee6cd3561@ramsayjones.plus.com>
Date:   Sun, 30 Apr 2017 18:33:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <f9dfd9b4-e753-1a53-175e-8f20fe904501@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/04/17 07:46, Johannes Sixt wrote:
> Am 29.04.2017 um 02:15 schrieb Ramsay Jones:
>> On 28/04/17 20:54, Johannes Sixt wrote:
>>> Am 28.04.2017 um 05:09 schrieb Junio C Hamano:
>>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> t7400.20 does not fail for the MinGW port because the
>>> test case only operates on the file system, but never
>>> checks whether an entry 'sub\with\backslash' is present
>>> in the index.
>>
>> Ah, OK. I only looked at my (64-bit) MSYS2 build, which fails
>> exactly the same as cygwin. Hmm, wait, let me just rebuild on
>> MinGW64 ... indeed it passes (well it passes t7400.20, but it
>> fails on t7400.11, 61, 63, 87 and 89)!
> 
> I don't observe these failures. Are you using a vanila MSYS2 environment?

I am indeed. I thought it would be suitable to use to test some
git patches on MinGW, but it seems I was wrong ... :(

ATB,
Ramsay Jones


