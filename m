Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E712035F
	for <e@80x24.org>; Wed, 26 Oct 2016 00:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbcJZAMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 20:12:20 -0400
Received: from avasout03.plus.net ([84.93.230.244]:53630 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbcJZAMU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 20:12:20 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id 00CF1u0020zhorE010CG3b; Wed, 26 Oct 2016 01:12:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=_8EVDOJEDMS5R0AwHx0A:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Allow stashes to be referenced by index only
To:     Junio C Hamano <gitster@pobox.com>,
        Aaron M Watson <watsona4@gmail.com>
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
 <1477352413-4628-1-git-send-email-watsona4@gmail.com>
 <xmqqshrkqf79.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <353cc9d2-ed54-040c-95f8-9038cfa265f0@ramsayjones.plus.com>
Date:   Wed, 26 Oct 2016 01:12:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqshrkqf79.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/10/16 22:41, Junio C Hamano wrote:
> Aaron M Watson <watsona4@gmail.com> writes:
> 
> Aaron M Watson <watsona4@gmail.com> writes:
> 
>> Instead of referencing "stash@{n}" explicitly, it can simply be
>> referenced as "n".
>> Most users only reference stashes by their position
>> in the stash stask (what I refer to as the "index").
> 
> It is unclear if the first sentence is a statement of the fact, an
> expression of desire, or something else.  With the current codebase,
> it cannot simply be referenced as "n", and you either "wish it were
> possible", or "make it possible to do so", or perhaps little bit of
> both.
> 
> This is why we tend to use imperative mood to give an order to the
> codebase to "be like so" to make it clear.
> 
> Perhaps
> 
>   Instead of referencing "stash@{n}" explicitly, make it possible to
>   simply reference as "n".  Most users only reference stashes by their
>   position in the stash stask (what I refer to as the "index" here).

s/stask/stack/

ATB,
Ramsay Jones

