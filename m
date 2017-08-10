Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38396208B8
	for <e@80x24.org>; Thu, 10 Aug 2017 06:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbdHJGIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 02:08:43 -0400
Received: from mout.web.de ([217.72.192.78]:64743 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdHJGIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 02:08:42 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lal6K-1dCuPX1gng-00kPfl; Thu, 10
 Aug 2017 08:08:23 +0200
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
 <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
 <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
 <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
 <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
 <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
 <xmqqh8xg7mhy.fsf@gitster.mtv.corp.google.com>
 <13394372-1494-6650-05ec-0122e02664d3@web.de>
 <xmqqwp6c63bm.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <faa74d6d-90b5-2de1-6478-854d3d52d30e@web.de>
Date:   Thu, 10 Aug 2017 08:08:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp6c63bm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ARxYZZE/nzK8ZIwS7nnr0QItKNnlGaJ6wzTheZvl4/f7d43cBHE
 ZcAwb+83lmYaaTbq1a1XlhN/iYz2jEuuQAUpC/2Jmq9kEBhdi46VjBLFgsWs+zFZsY+pRzx
 FIvxYtzpmWLM7xEdqTAAHfaZPM7vCRC9v4gyjGQl5+BeaXilYM4/s1q3DN426kqOTvRkg09
 LEQ7z2BQwa1wnroSDT4Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eS5i+GN5YR8=:jiTCHvzcPZh5G2ywdBOOL2
 WJEfgiF/ul5QFbmgFjHbTVjM9e/DDkrwZ2ixfMqrmzr6d2SWoVawrQU1zxdQlZpWO35TF/WRy
 TsUWDwLuVDlKj5nhNS088N7/jWDQS6W35h9jbCOFvHMD2oJBNeNgY9WV43q0nOXPNDCcYuKxv
 DbZPOWyjeg55VOzkN6aLy7WyCaz5+MxBFSuvkdof6d8H83Vv+os8eGKdwAtiHt/tvmYfYWxCc
 dY8kV0ItE6mWIers2057dGyhOpnlozhKvwvMLElPI6tUXDGMrxHaChXiOyIN+E/Y5h5ZVcGhV
 ZI/KW8i/qCCerukzALo2YKonL+WAkcaeS2Ta31HddQHDZrT7AWJ/qE8EWaOMUHTfLON0Rkunc
 UH2hKnGSm//428Acn5wo0dsTOpccV2bKf2hbNXpNOaAuPUANDX1YqGq5tq8XP8iScKyc2Hapj
 WedWhmOPxu26A0CxGNYkIB4ydtrBUbAHfG2DIAGSqAI9MI3zl3DpI8Xd6jwz2h75AUff2OQir
 MFn3z12CWS4GydTLZCeKALLvZl5WV51+rhC+PHmdikBizXx3/Jkr4eRYCavpzgH12lmsPxmGL
 /VFbCtqUbGWNzTJJqGPy7QluawxX8aI1wfXSfKwRXerxGRUm/w874x5YLcK2pTQwCp9s1bmE3
 lG01AWeoBMHXcL/MXXDJKbC1zKCgoq+1UXjYaD8mU2gtraMJraW6SLVZ3FnHO1feXdzMZnybn
 UlI1anGW0hzAD0ncAb2onWVU0G039Pj70BzyKwRtPXKlxzQxH8Mya27DH6934L8GLTpLlQxaY
 4QR9ZEtMx+TA2lTFcHY6BPl1BhCPJmpwnz5y4yohIU98v8IpsQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.2017 um 19:47 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> There could be any characters except NUL and LF between the 4096 zeros
>> and "0$" for the latter to match wrongly, no?  So there are 4095
>> opportunities for the misleading pattern in a page, with probabilities
>> like this:
>>
>>    0$                          1/256 * 2/256
>>    .0$         254/256       * 1/256 * 2/256
>>    ..0$       (254/256)^2    * 1/256 * 2/256
>>    .{3}0$     (254/256)^3    * 1/256 * 2/256
>>
>>    .{4094}0$  (254/256)^4094 * 1/256 * 2/256
>>
>> That sums up to ca. 1/256 (did that numerically).  Does that make
>> sense?
> 
> Yes, thanks.  I think the number would be different for "^0*$" (the
> above is for "0$") and moves it down to ~1/30000, but as I said,
> allowing additional false success rate is unnecessary (even if it is
> miniscule enough to be acceptable), so let's take the 64*64 patch.

Ah, right, now I get your calculation in the email I replied to above.
"^0*$" has a probability of 2/255 to produce false positives.

Thanks,
René
