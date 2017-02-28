Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68983201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 16:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdB1Qpb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 11:45:31 -0500
Received: from mout.web.de ([212.227.15.3]:61339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbdB1Qp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 11:45:26 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfCyA-1cynNK0K8Q-00Opyk; Tue, 28
 Feb 2017 17:38:40 +0100
Subject: Re: [PATCH 0/6] Use time_t
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f6b57868-0173-48d9-86cb-79780f7e301b@web.de>
Date:   Tue, 28 Feb 2017 17:38:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WcfkCWfjDf/+VNvUfGYqbX4UPsph3Y2Is4tImqpMuqv+dM/DA1K
 u1EOxHd4lz2z9S3GcNz+sHhcyOGJUvW9mYYOQDcQatR6qdyogAijKCTiG+9hF9/wJO0wFuY
 Om6IY/5eGmxvQ0GPRIBocatQINOkUQr+KgtER1ASxJXUsEND6qn9hW6gUNhPikNrYb4i6x8
 Y+w8/864QEfrrBYCrtBrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z0Mir9mqs1k=:AsLkviFZsE/4QIwkkLX64M
 DvT5XZzv5c9iE76ST/4+VvYfp+AxWmog2c3EHal/Gg95F3lNoEN3rNtpkWS4LP8WrgNit+lr5
 mtu2DgaPgmDfTEjDOb1aKgg5FoLXCvIaKXjbHitGr72ThBXNekH/EU2f/seifDX8AsykiV9lY
 kW7ROb5S1JyTAuKTNHIAdaXpCKDDPaAXp0xToUKr7QD6vRYokT2QwINAwhjpTLiSJPjZK09Ki
 gmYWpe6LzgdkmoUj+Quv1dloTSZlLIWRg5Wvj6Zu9lkEmTjsvI7H7gAS/202OY5vGy9UpPp75
 cGjSctgoKFYX2ovTTN6rSrp2Tk4NwbP9iIh/9rsG232DtRuVuGp2egZi/xw7utyXdtC4EQBH8
 iywnzjCZnipRFHg9fk2RKgKGYlLFbrCkO+scTlXEiMD3k3jPrFCjCGIGp6sDuFH6pDoaQrmZm
 zpQPU9TkOeQnwW0MhxUX9/39IRCcfLpBIyRpfun/MSZBxZOJlnjjOYV6/P02NuEZUrgb6D8ts
 dtJ6z2udKeXXrv02JByig0Tl6ic07q7Gdketm2qs5kQ4DAYaONBpKVN609O3fbXPskHUoqmBv
 82a2o8fgYfEaVTNRi5FprmSfU2cwHpCnL85wl5Ob7W3xAAn9BzWNBNWa++2Ytjii+OT3r+Hbz
 UzkNJc5irY9nMBGzoK44Pmab3T6X6df7DHfHjKn9ueF6CSKcmnuQIewfZLSSx9ldVuJh1tvmF
 Hy6k0AnyjucGgBLtekF112iTFB8O89itLMRdX4ln3Zdk3a1ExnfC9F4QffU0Y8p4CWbBpQRJf
 OcJvOjv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.2017 um 15:28 schrieb Jeff King:
> On Mon, Feb 27, 2017 at 10:30:20PM +0100, Johannes Schindelin wrote:
>
>> One notable fallout of this patch series is that on 64-bit Linux (and
>> other platforms where `unsigned long` is 64-bit), we now limit the range
>> of dates to LONG_MAX (i.e. the *signed* maximum value). This needs to be
>> done as `time_t` can be signed (and indeed is at least on my Ubuntu
>> setup).
>>
>> Obviously, I think that we can live with that, and I hope that all
>> interested parties agree.
>
> I do not just agree, but I think the move to a signed timestamp is a big
> improvement. Git's object format is happy to represent times before
> 1970, but the code is not. I know this has been a pain for people who
> import ancient histories into Git.
>
> It looks from the discussion like the sanest path forward is our own
> signed-64bit timestamp_t. That's unfortunate compared to using the
> standard time_t, but hopefully it would reduce the number of knobs (like
> TIME_T_IS_INT64) in the long run.

Glibc will get a way to enable 64-bit time_t on 32-bit platforms 
eventually (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign). 
Can platforms that won't provide a 64-bit time_t by 2038 be actually 
used at that point?  How would we get time information on them?  How 
would a custom timestamp_t help us?

Regarding the need for knobs: We could let the compiler chose between 
strtoll() and strtol() based on the size of time_t, in an inline 
function.  The maximum value can be calculated using its size as well. 
And we could use PRIdMAX and cast to intmax_t for printing.

René
