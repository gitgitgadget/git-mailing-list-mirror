Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12BE20248
	for <e@80x24.org>; Tue, 19 Mar 2019 00:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCSAzM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 20:55:12 -0400
Received: from avasout01.plus.net ([84.93.230.227]:53067 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCSAzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 20:55:12 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 631xhciCFxtva631yhycTo; Tue, 19 Mar 2019 00:55:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fYDTNHYF c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=BCjA09oAAAAA:8 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=aEpkAFv85XjFz-S3OxAA:9
 a=QEXdDO2ut3YA:10 a=jYKBPJSq9nmHKCndOPe9:22 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v8 10/11] sequencer.c: define describe_cleanup_mode
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
 <4edca9db0b2a32621a7622b5b709db23b2512d1e.1552817044.git.liu.denton@gmail.com>
 <CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5b97cc72-a318-bd70-3a8d-4fd48537b2b6@ramsayjones.plus.com>
Date:   Tue, 19 Mar 2019 00:55:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPUXuD/Vbk17ZDu32F7AqOyCCPSY5vx2CDIGbWqloO7DJqYrVMUh6m3OPed73jsLKQVchKW3WcA6nV+w20acCLM0yPLMNyJ4Ogh5qP4PANuCnHzJpCNe
 slneJ2d+aJnKTkM6UYbtLdSiaaO/hAfP73ULGYZPFMjTYBtQH/cy7iX9iwjmrFF/+Ggfmoh94jmnxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/03/2019 20:04, Eric Sunshine wrote:
> On Sun, Mar 17, 2019 at 6:16 AM Denton Liu <liu.denton@gmail.com> wrote:
>> Define a function which allows us to get the string configuration value
>> of a enum commit_msg_cleanup_mode. This is done by refactoring
>> get_cleanup_mode such that it uses a lookup table to find the mappings
>> between string and enum and then using the same LUT in reverse to define
>> describe_cleanup_mode.
>>
>> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> 
> These two Reviewed-by: lines should be dropped for a couple reasons.
> 
> First, neither Junio nor I reviewed _this_ version of the patch.
> 
> Second, a Reviewed-by: is given explicitly (not taken). When a
> reviewer has thoroughly read and understood a patch and considers it
> problem-free, he or she may say explicitly "Reviewed-by: <me>",
> stating satisfaction that the patch seems worthy of inclusion in the
> project. If he sees fit, Junio may then pick up that Reviewed-by: at
> the time he queues the patch in his tree.
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

I was similarly surprised to see this SOB line as well. There was
nothing copyright-able in the 'squash patch' I sent, so I don't
think this is warranted. (A 'Helped-by:' at _most_, I would think).
;-)

ATB,
Ramsay Jones
