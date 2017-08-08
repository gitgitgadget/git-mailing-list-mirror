Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A196020899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbdHHW2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:28:09 -0400
Received: from mout.web.de ([212.227.15.14]:64838 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbdHHW2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:28:08 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCIUL-1doFWL01Cr-0099tc; Wed, 09
 Aug 2017 00:28:00 +0200
Subject: Re: [PATCH] t4062: stop using repetition in regex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
 <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
 <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
 <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6e721fde-0c6d-1539-b4fb-110aac47989b@web.de>
Date:   Wed, 9 Aug 2017 00:27:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RguiN1e+7yBcvvy3A4aiZv2g8Rj3WLXJDQiI2N/Zc3OwIAn6R2g
 QMr2buxuUZAnKoSmE4VFzJg21xeQc+3FZsrBuhaKfb893u+v8paiUrTu2ypI5NGZnXCNO7W
 w2q+kVWYx9zVGBtA/UhzAVG5E0YpqBRIad0HXKqUlfW8e5UuKAslKjRfKv//9gDJI91NcXA
 5qe/t74MEV5GggAVnP9uQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nCSm1YaOEnE=:CstntVp7P1LC0Uv6CXdSmg
 d4hYHeDZxJhf+MJ8Rn4S+Y4AF+yP013zz+WyxdDsoQJS29CdMeCLWkFxdWMP9xXtTa4tpV+Ga
 YpJ3/XxrAWd0GY65YqlUwc4wDDXFDb1APMbBo4fkMYq4bt3pTWWEkJKO6wfx3xmK/i9F9fQ6a
 4g2K2/o548jeb/ZXco4ylBMEa9Q2ivbEopkE4OrhGrbYabv7+gZQ+Qc9s87RKViIS0wb4L4Xt
 67snV7Ne0XrHRBVmfcuoOh5s6X1tUhJf3c7okTXrG+FTJlTYzrV+q1qnQTkVwEi0yJjAbWRnR
 gKUOfM5HySvBE4AYJFmcgHoStluh4s0hjT+7r00Am0weugnI/k92dmuZo4Fyv4h3bGt6Y8GLE
 jlXhISbaCI7SbWPaK8D3CvKaP731vn53mdczjAeBmwNTuzOqxKD/H04ALocPTxu177IYQ77hN
 6byNFjlqcCwjOnYiI0FwINHyqBBJZlPTY7ds1O9ZWWIMmkgA/dGwca3HpgrmMepOyC4J6+6Do
 9fUgQxj/GUuafR+/kA5T9Sn1H/e47w6tfKA7JOqYprogoGBX9l1Od4vXWUsoS3+A5DKXbaM+h
 p5vu8VSX/2rmbgNbc318h1g7peoXhlnyBRK5OyYeMMpu0FycCEFUfPhX1AgGs1YPSvhLu0Ym2
 5vc9klWcN7cE5XIRT/vWIHXxqnFU5RuvgpctbXJw0RepsIhB5KI1AimKrJVxAh8/1F+0ZKbo2
 DEUanLHxg0lFjDJ3xAivWpakz/tWDKotf8+BIg255Qytd6JsL8zdZUMeMzVaiOqFANK5jASZl
 kjeDE4EedfdBrjGCtLo8klSc85a6ftcid8XFkb+RnSplWquy10=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 00:09 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 08.08.2017 um 16:49 schrieb Johannes Schindelin:
>>> Hi René,
>>>
>>> On Tue, 8 Aug 2017, René Scharfe wrote:
>>>
>>>> OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
>>>> That's the minimum acceptable value according to POSIX.  In t4062 we use
>>>> 4096 repetitions in the test "-G matches", though, causing it to fail.
>>>>
>>>> Do the same as the test "-S --pickaxe-regex" in the same file and search
>>>> for a single zero instead.  That still suffices to trigger the buffer
>>>> overrun in older versions (checked with b7d36ffca02^ and --valgrind on
>>>> Linux), simplifies the test a bit, and avoids exceeding OpenBSD's limit.
>>>
>>> I am afraid not. The 4096 is precisely the page size required to trigger
>>> the bug on Windows against which this regression test tries to safeguard.
>>
>> Checked with b7d36ffca02^ on MinGW now as well and found that it
>> segfaults with the proposed change ten out of ten times.
> 
> That is a strange result but I can believe it.
> 
> The reason why I find it strange is that the test wants to run
> diff_grep() in diffcore-pickaxe.c with one == NULL (because we are
> looking at difference between an initial empty commit and the
> current commit that adds 4096-zeroes.txt file), which makes the
> current blob (i.e. a page of '0' that may be mmap(2)ed without
> trailing NUL to terminate it) scanned via regexec() to look for the
> search string.
> 
> I can understand why Dscho originally did "^0{4096}$"; it is to
> ensure that the whole page is scanned for 4096 zeroes and then the
> code would somehow make sure that there is no more byte until the
> end of line, which will force regexec (but not regexec_buf that knows
> where the buffer ends) to look at the 4097th byte that does not exist.
> 
> If you change the pattern to just "0" that is not anchored, I'd expect
> regexec() that does not know how big the haystack is to just find "0"
> at the first byte and happily return without segfaulting (because it
> does not even have to scan the remainder of the buffer).
> 
> So I find Dscho's concern quite valid, even though I do believe you
> when you say the code somehow segfaults.  I just can not tell
> how/why it would segfault, though---it is possible that regexec()
> implementation is stupid and does not realize that it can return early
> reporting success without looking at the rest of the buffer, but
> somehow I find it unlikely.
> 
> Puzzled.

Good point.  Valgrind reports:

==57466== Process terminating with default action of signal 11 (SIGSEGV): dumping core
==57466==  Access not within mapped region at address 0x4027000
==57466==    at 0x4C2EDF4: strlen (vg_replace_strmem.c:458)
==57466==    by 0x59D9F76: regexec@@GLIBC_2.3.4 (regexec.c:240)
==57466==    by 0x54D96E: diff_grep (diffcore-pickaxe.c:0)
==57466==    by 0x54DAC3: pickaxe_match (diffcore-pickaxe.c:149)

And you can see in our version in compat/regex/regexec.c:241 that the
first thing regexec() does is calling strlen().

So to avoid depending on that implementation detail we'd need to use
a search string that won't be found (e.g. "1") or with unlimited
repetition (e.g. "0*"), right?

René
