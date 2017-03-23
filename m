Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0467720958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbdCWThZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:37:25 -0400
Received: from mout.web.de ([212.227.15.4]:52295 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdCWThY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:37:24 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrYLd-1cAhJS47Wn-013Pz6; Thu, 23
 Mar 2017 20:36:32 +0100
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170323155012.6148-1-szeder.dev@gmail.com>
 <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
 <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
 <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4424eeeb-7eea-ed41-c031-ba7915cb93ab@web.de>
Date:   Thu, 23 Mar 2017 20:36:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:dkOTrUDByIYlZkkz81H91P3+/jEKYQN6Y8EL5ba0RXxB2q5TddZ
 +lQK3Fdxxlw4sSxeZpTwfsVz4bgGrTP8fu0taUlzTHvQ6stIpfnbWXQQm0KX9G6QDjhNxIb
 f7juYE4L9cY09lS2WBjP7aZ8q+bhT55VdKMMAXLJMUfo4Oy3rjaS23iuOyHrfeHIjkglaLw
 a8MCopXxvq3WvrxtBleqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g8lFbSG0nH4=:R1hOAnSWNN9yzrTMLGcauj
 JSknHdoKwtgtIBrt8zhJHsQ1KafbRAstDHMPA/66SfNri3qlO69FaYkdOSgsEWsQqBFMJ1R4x
 7L62R3y/wj1r7+5w2lMWJEpI4RDXsJOWTYqndYOE/voqCv5wckNmn3x4q0jAqz8sVXn+h0ws7
 L9rnCngMO5aU2viBeOsPIvKXzmhRnlH8q20WkCzB3DHdLpepPs2tG7UG+ZolqVSjgmBuaL2ol
 CiYpWwd1pA2t8MLVDIBYeYIHDrzZcU4yxHoYWjPUQgSKjMnruvt4OQ8KzW/k1H5+w0+wTnmW7
 s3iAxG823KsTC5SxNRQaVT7+h+7EcKqTEA3YxPIsM4EZ78g+RZnR9CTD9TaQXk3SzHmS4MCNT
 +yw6Z6GajR/pA/vhl7dMMiSa8Sr2W+h1CQ/NQU/lTf2TWUK+ZOfBzY05ENlvX1B461/1hzgED
 RQg7Hwy5F4pm+MdaDlAvSpr2UW2Azt6UJtlyq2FFQKhW8thJl4dyxDqZj2FV5hbK1ixG3Jc+q
 uQRQ5xh7rddH8D5W0RTYnk0Pk17T1gZWdybQoN6X1lm69CuKEn2MdB9GghsmvnqKKAAk5lx7c
 ZYmMV/P533l97frKe/lcwMUIH2Eqz4Hj3G8KHBwjzelQAuvBNThIVjkE37aR2mc8MXaTrR6Xe
 70noIe1nRjVcxWJ+U72TtdVXa0dC6LuWHLKjhQI46xs5m85SLyMP9yJPCGxAH2eKpZErDlunT
 3ScwWeN+8shCABGFV2IFQ3KnPk8qFW41+p28llngckMUb8HfCR9qhZm3+xvsqHcimGzLvPVyW
 GEqelm4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.03.2017 um 20:33 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Mar 23, 2017 at 08:18:26PM +0100, René Scharfe wrote:
>>
>>> Am 23.03.2017 um 16:50 schrieb SZEDER Gábor:
>>>> This eliminates three magic numbers.
>>>>
>>>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>>>> ---
>>>>  refs.c | 10 +++++-----
>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/refs.c b/refs.c
>>>> index e7606716d..0272e332c 100644
>>>> --- a/refs.c
>>>> +++ b/refs.c
>>>> @@ -366,11 +366,11 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
>>>>
>>>>  const char *prettify_refname(const char *name)
>>>>  {
>>>> -	return name + (
>>>> -		starts_with(name, "refs/heads/") ? 11 :
>>>> -		starts_with(name, "refs/tags/") ? 10 :
>>>> -		starts_with(name, "refs/remotes/") ? 13 :
>>>> -		0);
>>>> +	if (skip_prefix(name, "refs/heads/", &name) ||
>>>> +	    skip_prefix(name, "refs/tags/", &name) ||
>>>> +	    skip_prefix(name, "refs/remotes/", &name))
>>>> +		; /* nothing */
>>>> +	return name;
>>>
>>> Nice, but why add the "if" when it's doing nothing?
>>
>> It's short-circuiting in the conditional.
>
> I think René meant this:
>
>      /* just for side effects */
>      skip_prefix(name, "refs/heads/", &name) ||
>      skip_prefix(name, "refs/tags/", &name) ||
>      skip_prefix(name, "refs/remotes/", &name);
>
>      return name;
>
> which still short-sircuits, even though I do think it looks
> strange; "correct but strange".

Yes.  At least to me it looks less strange than the same lines wrapped 
in "if ... /* nothing */".

René
