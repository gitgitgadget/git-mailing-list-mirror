Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994BA1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbdCJQUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:20:52 -0500
Received: from mout.web.de ([212.227.15.14]:59385 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754157AbdCJQUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:20:47 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfAbI-1cSSsF1qWm-00orH8; Fri, 10
 Mar 2017 17:20:27 +0100
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Jeff King <peff@peff.net>
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
 <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
Date:   Fri, 10 Mar 2017 17:20:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RvT8TFQktnvhhz4AhaSpVbdqv+7cCWXoTjj+juUkqhasiL7DlVj
 O/y3CY4zUbjBaNVQFPeoPLlkNixovfcfIOLZXEBII0+DfoZknEdtfgrjGJfvlJbQQggbk+p
 ILGHIqFw0Yjk6b9fx/sjtEAyz/q8LYmfq5AF6h0zBmVMURlS1qsthUUZG9SdYeBOrFsNi6H
 GyLsNJPOXrhRjwfIYBAxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/u9qLObdnfM=:4oY/j6x90sd5pbwF4hPas0
 s10O5J+QdvkFznnOTarumxLnAdtQqRfWZ3E7wkT4cTEkOkowhULBesZwAaSgB2qZkKGrw5I8b
 6SQNRfNAu6MicVZKef0nuZz6oFcTu/Ib1FmMVlpB1QZx2jH8+1Uiuxb5g919vN1oIbrfAf4RZ
 eDRAG8g/0wiNtesFVYvkXFAzsdiW2X4iqSmBcIeERM5MKdp4mB3wpKcBcUH34z96NYOvnv+cv
 3OQGijd1BWZFrq7Nbc/W94cQK/i3x/TRBT4RDBdK4o+ay04Zlp/TAwSeD/rCNOd5Yl7oxAFn8
 vp8JYFAsg46tee4LPCfSHz2sqMb7d6NChxaLxgDYfpOLD0yGepgEIFL37FZ36H1o0Wibz0WKl
 gMK8PXbgOAQ4fnfr/1um/PGLT8OKqsMUkB+D2Ysi8jFTe/C/+81EEbvCubAV7vHkx/B4cdpzm
 jJnkzpIdTLsL4K7dVX68QnwWHl1HVBSqfEwmd9GodoA+n3wm9zIuQIOaT3lPqJaWQ2YpoW7Df
 2uk+vH53YH2XmPf3R6swori963Zp3auNhdazaqrZ+aVWqozzl9iFqxvdAghsncxw95dQjCdfC
 NMb6pWC4T0f6NUFjY+kDBQnDBR9Ings3GlrkKpDzZOVVj4e5sT5r/xv8+ndqYTKKOoxTxgkpi
 lhJWFx7N7HrrMFt7wUji7n9X6E7TgYX2nDQSMwkJv6w3/6OLqfUKJGzmo3/w/645+9Uplp3E5
 LD88lsviyEJMUyyaRH8tNitWKNMPfvf3CLwwkPJO3WXDrFdzJtqNtZeo8H5K7kUzt9WPK2hhd
 MJezTSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.2017 um 09:18 schrieb Jeff King:
> On Fri, Mar 10, 2017 at 01:14:16AM +0100, René Scharfe wrote:
>
>>>   2. Ones which just copy a single object, like:
>>>
>>>        memcpy(&dst, &src, sizeof(dst));
>>>
>>>      Perhaps we should be using struct assignment like:
>>>
>>>        dst = src;
>>>
>>>      here. It's safer and it should give the compiler more room to
>>>      optimize. The only downside is that if you have pointers, it is
>>>      easy to write "dst = src" when you meant "*dst = *src".
>>
>> Compilers can usually inline memcpy(3) calls, but assignments are
>> shorter and more pleasing to the eye, and we get a type check for
>> free.  How about this?
>
> Yeah, I mostly wasn't sure how people felt about "shorter and more
> pleasing". It _is_ shorter and there's less to get wrong. But the
> memcpy() screams "hey, I am making a copy" and is idiomatic to at least
> a certain generation of C programmers.
>
> I guess something like COPY(dst, src) removes the part that you can get
> wrong, while still screaming copy. It's not idiomatic either, but at
> least it stands out. I dunno.

Yes ...

> I think this misses the other two cases: (*dst, src) and (*dst, *src).

... and that's why I left them out.  You can't get dst vs. *dst wrong 
with structs (at least not without the compiler complaining); only safe 
transformations are included in this round.

René
