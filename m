Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BAC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE884613D0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFKQzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:55:44 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:45100 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhFKQzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 12:55:43 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4G1n3q2Yflz5tlF;
        Fri, 11 Jun 2021 18:53:42 +0200 (CEST)
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net> <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org> <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <60c3724de35b4_3ad920839@natae.notmuch>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <763be21c-c87e-6b02-8ca4-256c3c804995@kdbg.org>
Date:   Fri, 11 Jun 2021 18:53:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <60c3724de35b4_3ad920839@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.06.21 um 16:25 schrieb Felipe Contreras:
> Personally I have never experienced what you posted, so maybe there's
> something else happening behind the scenes.

I have to do a lot of criss-cross merges lately.

> Maybe merge-ort changed something.

It produces the same result.

-- Hannes
