Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7FA202F2
	for <e@80x24.org>; Sun, 19 Nov 2017 10:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdKSKDD (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 05:03:03 -0500
Received: from mout.web.de ([212.227.15.14]:64988 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdKSKDC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 05:03:02 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MF3iV-1eNGCc2Fw3-00GG7B; Sun, 19
 Nov 2017 11:02:53 +0100
Subject: Re: [PATCH 1/6] t4051: add test for comments preceding function lines
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
 <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
 <CAPig+cQTzBYLqHw5TRYFajTK2Uq2fE=q=h=b=VA43zdJs0_CMA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bde81d14-a955-4ea4-5799-2a95511d8215@web.de>
Date:   Sun, 19 Nov 2017 11:02:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQTzBYLqHw5TRYFajTK2Uq2fE=q=h=b=VA43zdJs0_CMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:DPUfuunQpx7ZxHGPQLFOJwuSOx7D/tbcSEybkZkkH9zOwekxbsl
 AasfuZtsZHVDHhjw+YyQ38NJr3Px13mF/SEYshASZGNaDtQFQ1PNASbiAY5pwZG8ZMGPFBK
 T+6YN59rkx0duvjmGApUD3pPAUpJvvhpEsbaWMDYAF4L+L2Xvp8eaOUjjptrRmxYZWX5ng0
 LLVyVYX1/y8XsXVxC019Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tDA960hj1QE=:KISk/xJzx9FM/UnbSoFXop
 HnSB/7HmIt1Uz4w4ed3+xGfZxqrV5auiAZm3oJ1mWRXtXApC7MU9EdPNduzMvX7n9np2+wKRc
 nZmyq0/CGiv7h/FOuU7/thpCn+t5hv6wVufrkY6eyhMqiYE0ufU//L73RbdXifxgS5Hp/ue26
 zyrTVUYFMf2Bi3bpdqLG1YM1G+VidPhgDeyNNpxSjHG49G0VbvSEysybnB5gHFdjrtqUnGGXD
 VdrXlPLxbhEJe/wG45ZdEkvQNLqxa8kk+eTAzCaQ3mW10PFuVvIVhG35c33CGft68ugYCm2ai
 WICBFA/ruVCmqdr23TkTulsqPdL5QMGZTYehpCyA5W5S/g1g0FC8f6m3ayI+SyJtkr1MRpNpC
 BLrPvg4SOnMUAueKVLN8S364F7uWAHyirw3VAYevvEquCg+mHXKStE9zSgBw1qWGgZj/CTsEv
 pPm7yua46+y3cIIQLN8iQ5egWsbBumX/ITDvsf9OpWDonSH0yqxWikNYcjtDFlH9jAfqImdw7
 VFQDJsxmr0V8SG4AuxK/EKioPeHwnVetwcKg7SRQ/UtykS5il+Jid4pggvhRGyGd33uhNh53M
 MKudeaOzRzd0zEN7Kc9VflT0yyf4SeIHipXSP77IaTIV4HAV42yZXrF+RXNPdxwKlPNO4vXJI
 CAsWQPiM4IXaX/utkRNFzbsTKG2ak/eH0FHUBjGXp4zrJxKa66GSUHmY1qqUx0r0kI5Rf1CV8
 erD5SxYos0S8vElnKey6Xgl/XHU7DL7CXQl5m/V4vARXlXmLM9+KRC32MvmDgP53SD0akovAl
 QO7KGirlXCQdck3/QDXF7W3fwZl4VRLaV8LLU2O4TOuXzCcxmg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.2017 um 02:18 schrieb Eric Sunshine:
> On Sat, Nov 18, 2017 at 1:04 PM, René Scharfe <l.s.r@web.de> wrote:
>> When showing function context it would be helpful to show comments
>> immediately before declarations, as they are most likely relevant.  Add
>> a test for that.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
>> @@ -85,6 +85,10 @@ test_expect_success 'setup' '
>>> +test_expect_failure ' context includes comment' '
>> +       grep "^ .*Hello comment" changed_hello.diff
>> +'
> 
> This shows only that the the "* Hello comment." line is in the context
> but says nothing about the entire comment block being included (which
> patch 3/6 implements). Perhaps the test could be more thorough?

You say that as if it was a bad thing.  That line represents 33% of
your suggested full-comment metric, i.e. more than nothing.  But more
importantly it's the actual comment payload.  The leading "/*" line is
included as a consequence of the employed heuristic, but a more
refined one might omit it as it doesn't actually contain any comment.

Not sure if we actually want to tweak our heuristic further, but the
test is meant to check only if the interesting part is present and
give leeway regarding other implementation details.

> 
>> diff --git a/t/t4051/hello.c b/t/t4051/hello.c
>> index 63b1a1e4ef..73e767e178 100644
>> --- a/t/t4051/hello.c
>> +++ b/t/t4051/hello.c
>> @@ -1,4 +1,7 @@
>>
>> +/*
>> + * Hello comment.
>> + */
>>   static void hello(void)        // Begin of hello
>>   {
