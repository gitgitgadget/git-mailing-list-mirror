Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D556A1F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdAaVDU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 16:03:20 -0500
Received: from mout.web.de ([212.227.15.14]:57532 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbdAaVDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 16:03:17 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0hws-1cKhvd2gTm-00unlc; Tue, 31
 Jan 2017 22:03:11 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301637570.3469@virtualbox>
 <9bcae427-d654-a671-4368-030150168102@web.de>
 <alpine.DEB.2.20.1701301806591.3469@virtualbox>
 <6760493c-3684-b8bb-2c01-6621b8417246@web.de>
 <alpine.DEB.2.20.1701311305030.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <676ed19c-0c4e-341e-ba30-1f4a23440088@web.de>
Date:   Tue, 31 Jan 2017 22:02:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701311305030.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:R0uGVyzk0wa1Xw5ktVJJNc2hClol6sOJ0/H/ccm3CddRjjSG3bl
 cg7il5z41s1vPLHYfHNbVPo+oACIGqEDRiSQwuyVqlfdoukTJOzbzUI1pcNkRDI+0lLd8k/
 0G1TQlrOKh7HoPEAX5FO/sPLn2EYOASGVBG9//V+szdsYIr879gkJ3XKyjF7TqXSSl0Usff
 sdvRYMny5CvHeavKDWA9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b1q3Vt0fdlc=:wi/WsnUyTHlgsSgw3fnP5T
 7TikHZ3l8+GzWpkPXt95AYQRUv9Oe4J84XEtma2RShVrheP9XSAC6W3reTcFhWrpu29uo2tR/
 ZhmyjfZvZsFlECzNjkpyIEbQ8QeC7aowua+AS1kArkKnYyrCwqffLceO0FhFla2dKhNPB5DIU
 blfAUpGr2xIDubtTSlvMhn6qB7W4yE8VemAXqVcwY7x3gQV/fT6tW0DiLiP/VveVM/0hQhrmL
 w5YjxpJGYPCQC9bPNtIPr5zBRV240NXbiMJQPx84N+vQ4yRLxBBmuZVS5X9piCbPOxN8lciOq
 elcwCmkkiNB/Ot3Q7VdQW4FLHdvAnD0qKmYH7xhny2amE4j5NL1WmqIWiyF3i5lThcF3SQwf8
 qSiWsrBrTEh7/WZVWNq+8mDAQWgU0AoXI5QeIhQDn/YeMkyR61LMrvCIJz+QmCMxsYU+wHJBa
 /OddOAHvXH/KjJ8GJleIIjpXngQTTTPBoertWRjN4jWT2M3an1oIaJjZudUlkGecSFD8iUHu5
 krqws7GxDXv1+sIymxDJTIu1IYmwdygvrNEfoaEmxwRYwd+0hGNA4wJH3AGxot0YNavtD467j
 k42DNJTnQe1kwvYUrnAyn27Lv9lMed047xBtYuoJsLn9HbdtKHJmJe5TCzFdON5FJmL9FV8hq
 FfSXrcjC9jmAc4dvAGIPwCPrUUCqjaTiVxiNP/jCQcHiG7jsNhwoD+YoAeC+tj77MBuPzhEJ+
 LYhiCruHiUE80TzHfMDlwQJUAGlPkt/hJ4sgWRI+63BMymuyEf5LyVoh6LcZfw5vl37FH8Rx8
 x1zAZED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.01.2017 um 13:13 schrieb Johannes Schindelin:
> Hi René,
>
> On Mon, 30 Jan 2017, René Scharfe wrote:
>
>> Am 30.01.2017 um 21:48 schrieb Johannes Schindelin:
>>
>>> The commit you quoted embarrasses me, and I have no excuse for it. I
>>> would love to see that myswap() ugliness fixed by replacing it with a
>>> construct that is simpler, and generates good code even without any
>>> smart compiler.
>>
>> I don't see a way to do that without adding a type parameter.
>
> Exactly. And you know what? I would be very okay with that type parameter.
>
> Coccinelle [*1*] should be able to cope with that, too, mehtinks.

Yes, a semantic patch can turn the type of the temporary variable into a 
macro parameter.  Programmers would have to type the type, though, 
making the macro only half as good.

> It would be trivially "optimized" out of the box, even when compiling with
> Tiny C or in debug mode.

Such a compiler is already slowed down by memset(3) calls for 
initializing objects and lack of other optimizations.  I doubt a few 
more memcpy(3) calls would make that much of a difference.

NB: git as compiled with TCC fails several tests, alas.  Builds wickedly 
fast, though.

> And it would even allow things like this:
>
> #define SIMPLE_SWAP(T, a, b) do { T tmp_ = a; a = b; b = tmp_; } while (0)
> ...
> 	uint32_t large;
> 	char nybble;
>
> 	...
>
> 	if (!(large & ~0xf)) {
> 		SIMPLE_SWAP(char, nybble, large);
> 		...
> 	}
>
> i.e. mixing types, when possible.
>
> And while I do not necessarily expect that we need anything like this
> anytime soon, merely the fact that it allows for this flexibility, while
> being very readable at the same time, would make it a pretty good design
> in my book.

Such a skinny macro which only hides repetition is kind of attractive 
due to its simplicity; I can't say the same about the mixed type example 
above, though.

The fat version isn't that bad either even without inlining, includes a 
few safety checks and doesn't require us to tell the compiler something 
it already knows very well.  I'd rather let the machine do the work.

René
