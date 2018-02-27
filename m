Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A4E1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeB0XrI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:47:08 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35892 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeB0XrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:47:07 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id qoxceAYBbshmQqoxdefZj1; Tue, 27 Feb 2018 23:47:05 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=eJ89ckh1 c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=d52jGl4dsc0oubC2YgQA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
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
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <192d4ee4-dbdd-3e47-b45c-8d1f7b69b9af@ramsayjones.plus.com>
Date:   Tue, 27 Feb 2018 23:47:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lm2ozq3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMLXEnRk7fBVz+SawWPWUZnMHPLyDiobTDgqE6FrEjtW/zFc26l9TZvtzf5bIwtYzoCQ0sSJ9J0wi+G2XQfVxzFYckjzgIy5Ig6zW2PT6XUR7klsKlyt
 p9S3lJmaA+8YlJZ1G4QxKv5mfVgtXjm9SODtkSarR9LrgNpqKTYA+VXnRlj2Bm2V+lLVtNG+bAaAsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/02/18 22:05, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> OK, somehow I had the version from Ramsay on a topic branch that was
>> not merged to 'pu'.  Here is the replacement for 2/2 I'd be queuing.
>>
>> We'd need SZEDER to sign it off (optionally correcting mistakes in
>> the log message) if we are going with this solution.
>>
>> Thanks.
> 
> I guess I missed Ramsay's v2 which already did this
> 
> <550fb3f4-8d25-c5c4-0ecd-3a4e61ea13f4@ramsayjones.plus.com>

Yes, and as I said in the cover letter, I wasn't too sure that
I had passed that patch along correctly. ;-)

> so I'll use that version.  We still want sign-off from Szeder,
> though.

I would be happy with either version, or maybe Szeder would like
to tweak the commit message. In any event, it would be good to
get sign-off from Szeder.

Thanks!

ATB,
Ramsay Jones


