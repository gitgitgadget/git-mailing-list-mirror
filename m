Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0356620899
	for <e@80x24.org>; Tue,  8 Aug 2017 15:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbdHHPTd (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 11:19:33 -0400
Received: from mout.web.de ([212.227.15.3]:50419 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdHHPTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 11:19:31 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mb8d1-1duiFX25cJ-00Kf7Z; Tue, 08
 Aug 2017 17:18:32 +0200
Subject: Re: [PATCH] t4062: stop using repetition in regex
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, David Coppa <dcoppa@openbsd.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
 <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
Date:   Tue, 8 Aug 2017 17:18:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:v26e0IBXdesiWelBw5u4s9j3xFPn4Eb0Mpu+eSeMIN/iJe11lw6
 6BJIgBp4uBzGlwU2Ab3/bLuPgdlci94PBpQXPdJYREI6XCcpFGQ7DAXKLNxfrbitgUBEWFH
 QgfONxhSkx+Uz8fA3yLCf/kuH1jRszsID3QViTwvXiaixcL/uzbO5Z2ywA9c1+KzAf5+9a0
 Lrik16M4BM5qRgk6NGC5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TMrpt6TD8VE=:h7zuTfjXfwW+FsHOvj0yw4
 tBZdig/DEjvdiI5eMNXieOXpi6AjN5jJIh2Lvff9S+UX4oooCJdt21vAiS3Wq68zS2smJakIb
 yoOXZHTZsN3Z32z2ihXRjiLiXmnlBl0lut6AX1T9wBQcD4fRnETO0v5ZwszWlA7thoMxzDGW0
 Z5Qgi2tYQiZBlvLLwbhT2XjvTf4sOkt1ZhJRZ8x9Kn0D39jVHuWY4wlbyFL8GnusycNEyy3O3
 A3cnGU1tBIKn4Q8ln6F/uRYE4UhRZFNwqphZjjNHXDQXB1LoiTgJ97Bx5sYep0a8hwUpvZDJL
 +CeZy59oUIX6LtK002DewLUH3zatyWPw9lGrDtcgEUN/xXamfljDd87nZFurU9jkQSD7JJDJJ
 iJFi5VeWp/ehudCTAC4ZhQ23I8gi+kYp2SghAJ8iAFODSJC3bsa4v0+2Prj02HUgTP7DCvcCK
 3RjxAUAy3A0X3pH1gQbSLKQpZeWpdcKEBdjV5e3rZxT+G9C28P9kzYNZz0aJWznYPxACPvrrl
 cBhFNNH8QpGkWBaILPjHcLLGo7FF96ZYFebq+ZSBTCxSIfEp7cqsMB+m//rglnoDIdvdW8zoe
 m57j/490FyqOZV699vZCEn+msa+1Mb9FjHDqSjLiIRniXGcVnQsOihFdsQ1RaK3To3Xk6EcPW
 UdBwQlFVUTzFkUvn2JX6LC7yxfgjxbZ7HdOIqiF3FykEZWBEockc82gDbvV8Xclisd9Rv+9JJ
 iOsqzE2b9UQkHjhQHhnyONP7jr4RMcpO8g82SDVXnCCrGhF9cLkVf1pYWer5qU1l0B7p7/Dtq
 IqeY3R372dVUaCY9IeXDknB42mWniZE8qjxbDLIrYlVw44G1+4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.2017 um 16:49 schrieb Johannes Schindelin:
> Hi René,
> 
> On Tue, 8 Aug 2017, René Scharfe wrote:
> 
>> OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
>> That's the minimum acceptable value according to POSIX.  In t4062 we use
>> 4096 repetitions in the test "-G matches", though, causing it to fail.
>>
>> Do the same as the test "-S --pickaxe-regex" in the same file and search
>> for a single zero instead.  That still suffices to trigger the buffer
>> overrun in older versions (checked with b7d36ffca02^ and --valgrind on
>> Linux), simplifies the test a bit, and avoids exceeding OpenBSD's limit.
> 
> I am afraid not. The 4096 is precisely the page size required to trigger
> the bug on Windows against which this regression test tries to safeguard.

Checked with b7d36ffca02^ on MinGW now as well and found that it
segfaults with the proposed change ten out of ten times.

You get different results?  How is that possible?  The search string is
NUL-terminated in each case, while the point of the test is that the
file contents isn't, right?

> Maybe simply disable the test on OpenBSD instead? Or guard the {4096}
> behind the MINGW prereq.

It's easy to build a long search string with two repetitions or by using
a longer string as the base, if necessary.  But first we need to find out
why regexec() doesn't overflow in your case.  My build uses the version
from compat/.  Why would it stop before reaching a NUL?  That sounds like
a different and serious bug.

Thanks,
René
