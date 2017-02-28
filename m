Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0934720133
	for <e@80x24.org>; Wed,  1 Mar 2017 06:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdCAGIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 01:08:13 -0500
Received: from mout.web.de ([212.227.17.11]:60288 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdCAGIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 01:08:12 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNs4-1bwHDl0pG4-00mbfO; Tue, 28
 Feb 2017 22:31:53 +0100
Subject: Re: [PATCH 0/6] Use time_t
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
 <f6b57868-0173-48d9-86cb-79780f7e301b@web.de>
 <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702282149160.3767@virtualbox>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6bd6ef64-2749-f17a-aea8-d25b147892c5@web.de>
Date:   Tue, 28 Feb 2017 22:31:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702282149160.3767@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:MazNTTQA1B8nvy3cDmFPWryZrTbO2IID27rFwBvhwUDqiP5helP
 Kmt1tFUWo8mbxbV6n26coHwS6nvSXqX0iIbs6q/ogekEwE/FGsbb13SEN3Cj9EyNWku7zY/
 tZLmCG8hzOD4vvCgSE3oUdXMlbKpIpNyKGgu4pmLWfLtoTXccFS0PtuOTdsmchwyrLlEGCl
 YIrtZT5PkpPjzphSEmhHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CSG9cvjzm90=:7xpB7o+zIlBK5pczW6J3KK
 27pMLSf4dbB0uWbCAVaiFAxM4kshyQXyX+GDxT2X2nRhuZDpY1apTHC8PkD1GVrgCdPYvW4V2
 +xmz142Yp7AdgPAqPUSZRQBJ8zBfNOXE22L1fg37tUiL8NCoDTZqcSvCqUEKWN7+qY56Tvpap
 yom53eKl5V4AefFp8MA9Feh84QhiKZDWPwV+Xvc/ubWjeZL1nJFRu1ywtB7P5wx9bbsQUMP7k
 hzllaS6ht4mIjreRNYsU6LtXKdKBPta6umA59LZ/wMKHeCdcmKimZPJz7lm07ESZG7Vq/9NM6
 uRVS9SLI0NS2MMDDjnvTr5avY7FrZlNYJugPyo9k9AYQ6m9zbRxr8iyccj42oqZz1J0GjW/vM
 kN6KIiHbsKgJgCc91omHtn3X7S2zbYxJ0rPRMjDpNdHISp1gpK741FgedQV13KnssjgJ7n2WP
 ztgHYAvj35W7yzR/eOLSYGNC2nj0kCv4XGAbvpxGEXcpcFSFZs7K+z+PYphVx5rmfZjFjOOOn
 JX4aPeAEPvwMjNST7jUnJoytrVPR0skaSJdKojqgrlsEYB0AFiBnqHUFTgEt9dKZ0LY+uj2Ay
 aIEWH/e8O0BguvPJYPAqRw/LR2F1tVMBi61fH8sLyZxPvXaohh/sASqqG2dOvYKs85fj+Uqbu
 MRcPQPMcm4+6ThFlmYc79azi0mb/qV69Hbvmo9F85As3iwKEnCAd00QlWz8UCafGzUb0pjIQY
 er3Z0LQAjm6VCfWLEfbZDAS0LX45HLJMpqKgj1ABoMWpsCwDWnBRNwJIEBMXMNPhc/jFMOU3C
 MsUBA03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.2017 um 21:54 schrieb Johannes Schindelin:
> Hi Junio,
>
> On Tue, 28 Feb 2017, Junio C Hamano wrote:
>
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Am 28.02.2017 um 15:28 schrieb Jeff King:
>>>
>>>> It looks from the discussion like the sanest path forward is our own
>>>> signed-64bit timestamp_t. That's unfortunate compared to using the
>>>> standard time_t, but hopefully it would reduce the number of knobs
>>>> (like TIME_T_IS_INT64) in the long run.
>>>
>>> Glibc will get a way to enable 64-bit time_t on 32-bit platforms
>>> eventually (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign).
>>> Can platforms that won't provide a 64-bit time_t by 2038 be actually
>>> used at that point?  How would we get time information on them?  How
>>> would a custom timestamp_t help us?
>>
>> That's a sensible "wait, let's step back a bit".  I take it that you are
>> saying "time_t is just fine", and I am inclined to agree.
>>
>> Right now, they may be able to have future timestamps ranging to
>> year 2100 and switching to time_t would limit their ability to
>> express future time to 2038 but they would be able to express
>> timestamp in the past to cover most of 20th century.  Given that
>> these 32-bit time_t software platforms will die off before year 2038
>> (either by underlying hardware getting obsolete, or software updated
>> to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
>> would not be too big a deal to warrant additional complexity.
>
> You seem to assume that time_t is required to be signed. But from my
> understanding that is only guaranteed by POSIX, not by ISO C.
>
> We may very well buy ourselves a ton of trouble if we decide to switch to
> `time_t` rather than to `int64_t`.

True, and time_t doesn't even have to be an integer type.  But which 
platforms capable of running git use something else than int32_t or int64_t?

René
