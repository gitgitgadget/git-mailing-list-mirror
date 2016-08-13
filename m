Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2AB20193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbcHMJTz (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:19:55 -0400
Received: from mout.web.de ([212.227.15.3]:56147 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbcHMJTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:19:54 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MUVrX-1bgvBG1hVz-00RJbK; Sat, 13 Aug 2016 11:19:25
 +0200
Subject: Re: [PATCH] correct FLEXPTR_* example in comment
To:	Jeff King <peff@peff.net>
References: <57AEE1E1.3080901@web.de>
 <20160813090947.uj6hurji5o6cwxge@sigill.intra.peff.net>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AEE61A.4000804@web.de>
Date:	Sat, 13 Aug 2016 11:19:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160813090947.uj6hurji5o6cwxge@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:98tBuc+l4nPTgokMHZ2Ozmv4GQ9ajRjSHpWUBdBreDzfIZL9MQg
 f4sAMs1wutqWtRQJ+WafOUFQzpmWU24mhK0NoGZ+9sOSoGTcN+n/NDbF+BMeE77aITBn1Pc
 Ti3Y3MINnYSzqbvs1A6/4t0Zfuf6vhomGShpTinRFFYjmj32xttuYADdiQNtGPT56zAGdq9
 2+WAxju/D2SZCxsbMcDLw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Cno3x04rWvo=:HV7RvaUQDCjNJPInmKHeFV
 DlnFLEQJT+MTD0gFgnbli6rjLKktSmxoUw/oN3nFlupb6Mi1Aonysj/ePs+mN5WasxH/dX8Bl
 8QYWAuP0i+qosfs2Jr0V+DBApttERS1dTGDrWFOBzLqSOMbFGuEQ3ZhgPTZ0sA8bJ3Z5BxJrC
 /gAM7+0XGlLYo36ehxSVYdhs3eDBUw88xk2xEJrPbctE7PMLoExCfxERMxMQEt8K9nMpNFv5y
 IMC3Zq82MjX7ULoD1HDiYG4mj8N4z62QRfX476D28/JLIWWXQ9McoxOqnEZVb5NuJbPeHAoX6
 TgQXX+5aEUZPnWDvvVeXfNSg79c9zyxGOBA35iYFQJiBbd2CQ+kJGImYcuxk81ggwyAWKY82O
 7rRF97grwhdjIW0moRHuYaQOiJi/LXCq40IOI01034ZOg8wY+MUlHaXNC7VcOB5gEpNziHEAg
 Gr74UiIFr8HLogenbTcdOe2yGnvMTn9/CM/M+i4suuPVA1oR551q9AcVbpUx/04KrWtlcg4W3
 er4yvh/9ZqWlQHCR4HvE10qGzop7lPZjjdNN7P08yDb3Zaq4RBgGAECd3JshGGXqDdbjTpNOh
 USdQFQQJvUqw3iOzNRu7/0iM4LZ7znXL+FCy5GqWHYzMhmpm/oQfREVyRxU1MYfDugCokX5MJ
 JPPiSvgy4VfAJb3pcziU94j25joVmpbM+DxDtBZvrnyiELMnpBOhLWmCg76zN4en7DILth/Yc
 yXh85qea7+JLngEZ27/zTiuopSG2y7INqLV2wEDKaNyW2m2CVbehqUGMZ24m/BVWH44owLZUJ
 gO2RTKa
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 13.08.2016 um 11:09 schrieb Jeff King:
> On Sat, Aug 13, 2016 at 11:01:21AM +0200, René Scharfe wrote:
>
>> This section is about "The FLEXPTR_* variants", so use FLEXPTR_ALLOC_STR
>> in the example.
>
> Oops, yeah. Your patch is clearly an improvement.
>
> Since this is obviously an easy mistake to make (using one form rather
> than the other), I wondered if the compiler would catch it.
>
> I think it would catch an accidental use of FLEXPTR instead of FLEX,
> because it involves an attempted assignment of an array. But I don't
> think we would catch the reverse; we'd just write the data directly on
> top of the pointer. That would probably crash immediately at runtime, so
> if you exercise the code at all in tests, it is OK. But something to be
> aware of.
>
> I suppose it could assert(sizeof((x)->flexname) == FLEX_ALLOC) or
> something, but I'm not sure if it is worth worrying about.

A compilation error or warning would be nice.  I scratched my head quite 
a bit before figuring out that the example was wrong.  Copy&paste from a 
reputable source must be correct, right? :)

René

