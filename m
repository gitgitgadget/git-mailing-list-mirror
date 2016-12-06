Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEA91FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbcLFUnS (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 15:43:18 -0500
Received: from avasout05.plus.net ([84.93.230.250]:33646 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbcLFUnR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 15:43:17 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id GkjD1u0040srQBz01kjFCy; Tue, 06 Dec 2016 20:43:15 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Qskc5h6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=nOaW6VbsxleJ2ph5UMsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
 <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
 <xmqqbmwq5k7k.fsf@gitster.mtv.corp.google.com>
 <20161206140259.lly76xkvsj7su3om@sigill.intra.peff.net>
 <xmqqwpfc2a7g.fsf@gitster.mtv.corp.google.com>
 <20161206182648.sxoftkd4hjhvenaf@sigill.intra.peff.net>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2435294e-9852-d215-0a9c-a73a2b522ff2@ramsayjones.plus.com>
Date:   Tue, 6 Dec 2016 20:43:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161206182648.sxoftkd4hjhvenaf@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/12/16 18:26, Jeff King wrote:
> On Tue, Dec 06, 2016 at 10:17:55AM -0800, Junio C Hamano wrote:
> 
>> Yup, that is what I meant to say with "that is already possible" and
>> we are on the same page.  As all three of us seem to be happy with
>> just dropping --abbrev and letting describe do its default thing (as
>> configured by whoever is doing the build), let's do so.
>>
>> -- >8 --
>> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Date: Sun, 4 Dec 2016 20:45:59 +0000
>> Subject: [PATCH] GIT-VERSION-GEN: do not force abbreviation length used by 'describe'
> 
> Thanks, this is a nice summary of the discussion, and the patch is
> obviously correct.

Yep, looks very good to me! (I had started to write a commit
message for this patch, when your email arrived. Needless to
say, but your message is much better than mine!)

Thanks!

ATB,
Ramsay Jones

