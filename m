Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26B420229
	for <e@80x24.org>; Wed,  9 Nov 2016 10:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbcKIK6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 05:58:22 -0500
Received: from mout.web.de ([212.227.15.14]:62860 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbcKIK6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 05:58:21 -0500
Received: from birne12.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lw0vl-1cu7qi0AO5-017pwV; Wed, 09 Nov 2016 11:51:09
 +0100
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-2-larsxschneider@gmail.com>
 <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
 <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
 <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
 <11cc8bbd-2e67-f53a-c8f4-2244409fd6af@web.de>
 <0966CBE3-2F08-4B89-9716-4EEE3CE2526E@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        gitster@pobox.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <1fdc5333-79a8-7c1d-f7e5-e8150d0ad9cc@web.de>
Date:   Wed, 9 Nov 2016 11:51:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <0966CBE3-2F08-4B89-9716-4EEE3CE2526E@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:nAZItEicZl6yOiTVygESkXZ2R+dex+665gtaRBtj6/5ydJY6JB2
 YrHg13HlqV8o5lBUBjSw064lu21zDmvo31U7Sw9uEjhht58dsvE9pGe+B0ThcB6szV/3LF2
 0J18CNXbabQtm07HfxYhhPw9YwUx4VAhtezVlxW1HS6Al+gultWg7QDxjK0OONQS2oi2TqI
 3RelyP1asXxm4NkviY7mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XBQzjKBjV7U=:MKuAe+TeOmIu/MBe7Plf/X
 40lw3/ocI/Y7pvkRgDPrakzalmQJmbq3bpAuI2osrwTi/bJV5OqKT9fChr+/gJQ0srbcWoPN2
 SSPt6/Gxd9JQ7UVCxux82cq4JdV+DpVPUPybw7XxEPPI55XBQFMX2eDXlfkbeEz6SxUZBTTAC
 UxaQA/sKrHynnr7SBXPbvW1oY2jl9SIBKmSLnyGs3SAQ1JEhvDka7A15a0DEakOeC93zMguaq
 XOGOR9l4KgkReKDlvecN+p36cIUWrv5KoVFlruAe2B5Xz1Qn9lherddkcAOTwYcE+A6s3zqQl
 3hqlWRg9dJw1fqtEu8B4PS0lXjVs/Ncy/tXbZgE3KNHrgpwD5/BYLnuLuBsAmMIY75KA8QtzY
 Q9B6TpYuQXm8Yp6w7t5P/yeT5KmWiLkLENSnOCh/wVPwJASOGQ1OeN8BiXjBTVF/3JMtoa9/a
 j3OyUfQJ81spnTAvDftIBEwABRhnEnDYezcmLRC9+DO6Ciw//exkiTfNGZRQT9r9MYvoZNxml
 Jb2enVAfed03T8XN1cUtHqfFCPhGVN+J47gOxx5mFGl+0si7vvod9p0hpOkghjqGcExTsCrh7
 65mW5W/7M/uVq6Uz+xchD+ANtRdvIjZOnVkHedZ0956PhgjNwd0EZhMBWxx/dCJP9Rz13fkc9
 A2jsb1HRD4V3f9sP3eTxNU68DnFHgHMmKQAvoNHs7UCkMn3WuELfRoV6wSQuzAvuC8wWtPUC9
 /qSOIwlHwOHY0bEDE6FzT+WKVoVDVVd/2oQ629LIM05WR6HqFouKedZQLcfP3KVChW3GNckzd
 klB0m8yy/kTNwbEZC7+HB/ynf2BEp0WXfGGVmMesOfnAjYXWmpxbMoGxTACEdid/81CazVsCq
 y7xr2zEdCZUjT65OWHmvdWEaOzYesK85okIulbrRg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.11.16 10:29, Lars Schneider wrote:
> 
>> On 09 Nov 2016, at 09:18, Torsten Bögershausen <tboegi@web.de> wrote:
>>
>> On 07.11.16 18:26, Jeff King wrote:
>>> On Sun, Nov 06, 2016 at 08:35:04PM +0100, Lars Schneider wrote:
>>>
>>>> Good point. I think I found an even easier way to achieve the same.
>>>> What do you think about the patch below?
>>>>
>>>> [...]
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 9d6c245..f53fcc9 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -1047,6 +1047,7 @@ ifeq ($(uname_S),Darwin)
>>>> 		endif
>>>> 	endif
>>>> 	ifndef NO_APPLE_COMMON_CRYPTO
>>>> +		NO_OPENSSL = YesPlease
>>>> 		APPLE_COMMON_CRYPTO = YesPlease
>>>> 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>>>> 	endif
>>>
>>> That is much simpler.
>> []
>> I don't know if that is a correct solution.
>>
>> If I have Mac OS 10.12 and Mac Ports installed, I may want to use
>> OPENSSL from Mac Ports.
> 
> Can't you define `NO_APPLE_COMMON_CRYPTO` in that case? 
> I think if you use OpenSSL then you don't need the Apple crypto lib, right?

After re-reading the Makefile: that makes sense :-)

Do you want to send a new patch ?

Feel free to omit
"Original-patch-by: Torsten Bögershausen <tboegi@web.de>"




