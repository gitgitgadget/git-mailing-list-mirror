Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A6441F404
	for <e@80x24.org>; Wed, 28 Feb 2018 15:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeB1Pd7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 10:33:59 -0500
Received: from avasout04.plus.net ([212.159.14.19]:57970 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeB1Pdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 10:33:54 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id r3jreW3wubfBDr3jseQg7l; Wed, 28 Feb 2018 15:33:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=F4V5iJpN c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8
 a=uWZAkBzQyb7RnwYv9-IA:9 a=yoHSg3uWGdrYdID-:21 a=0qIWBEY5YMm0OLqj:21
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
 <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
 <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
 <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
 <20180213100437.15685-1-szeder.dev@gmail.com>
 <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
 <20180213172603.GA10062@sigill.intra.peff.net>
 <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com>
 <xmqq371mqjce.fsf@gitster-ct.c.googlers.com>
 <xmqq4lm2ozq3.fsf@gitster-ct.c.googlers.com>
 <192d4ee4-dbdd-3e47-b45c-8d1f7b69b9af@ramsayjones.plus.com>
 <CAM0VKj=hbT_m21ssF+nedVDrfNiYHu8wd9mUD55mAdNgmnZSgA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ffc3d3dc-6d21-4273-5362-cbf32e7e4e59@ramsayjones.plus.com>
Date:   Wed, 28 Feb 2018 15:33:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKj=hbT_m21ssF+nedVDrfNiYHu8wd9mUD55mAdNgmnZSgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKOI05UuyKZFWgOmmSxkGYzCBaGy9CPmFbeDTHxCn4u4sUvplFter/mnZ0S7Gd4DrE42ia1kg+KiHkwiDPybwfxqUG3pziD1ee3mRujHh00Tnsr8d8hT
 RY1CxdeotcQlMj/peju/DB4k5sSqpAfWXjdQnx91mI9L9zPuWuxb3/QqTp+BY4gsh0CBKWO3zJNskA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/02/18 00:42, SZEDER Gábor wrote:
> On Wed, Feb 28, 2018 at 12:47 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 27/02/18 22:05, Junio C Hamano wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> OK, somehow I had the version from Ramsay on a topic branch that was
>>>> not merged to 'pu'.  Here is the replacement for 2/2 I'd be queuing.
>>>>
>>>> We'd need SZEDER to sign it off (optionally correcting mistakes in
>>>> the log message) if we are going with this solution.
>>>>
>>>> Thanks.
>>>
>>> I guess I missed Ramsay's v2 which already did this
>>>
>>> <550fb3f4-8d25-c5c4-0ecd-3a4e61ea13f4@ramsayjones.plus.com>
>>
>> Yes, and as I said in the cover letter, I wasn't too sure that
>> I had passed that patch along correctly. ;-)
>>
>>> so I'll use that version.  We still want sign-off from Szeder,
>>> though.
>>
>> I would be happy with either version, or maybe Szeder would like
>> to tweak the commit message. In any event, it would be good to
>> get sign-off from Szeder.
> 
> Certainly, here you go:
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

Thanks!

> However, I'm not sure about the authorship and taking credit for the
> patch.  We ended up taking my patch, sure, but I think Ramsay did all
> the real hard work, i.e. writing the commit message and, most
> importantly, realizing that something is wrong with that '...| sort' at
> the end of the line.

No, the patch and the credit are yours, I was just trying to
help out and get the patches moving forward. At most, I would
think a 'Helped-by:' would be sufficient to note my input.

[BTW, my 'Signed-off-by:' on that patch was in the spirit of
the dco section b. - again I wasn't quite sure ...]

ATB,
Ramsay Jones


