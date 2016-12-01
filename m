Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F23A1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbcLABSj (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:18:39 -0500
Received: from avasout05.plus.net ([84.93.230.250]:42473 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbcLABSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:18:38 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id ERJb1u0020srQBz01RJcJ2; Thu, 01 Dec 2016 01:18:36 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Qskc5h6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=5rxgeBVgAAAA:8 a=1kLRMjsMqGA_qS1awxsA:9
 a=QEXdDO2ut3YA:10 a=u09W0hvIdLUA:10 a=q92HNjYiIAC_jH7JDaYf:22
 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
 <alpine.DEB.2.20.1611301204020.117539@virtualbox>
 <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
 <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
 <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
 <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
 <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
Date:   Thu, 1 Dec 2016 01:18:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/11/16 23:46, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I forgot, we ended up reversing course later and silencing them:
>>
>>   http://public-inbox.org/git/20140505052117.GC6569@sigill.intra.peff.net/
>>
>> By the rationale of that conversation, we should be doing:
>>
>>   warning("%s", "");
>>
>> here.
> 
> I forgot too.  Thanks for digging up that thread.

Yes, I blamed wt-status.c:227 and came up with commit 7d7d68022
as well.

So, by the same rationale, we should remove -Wno-format-zero-length
from DEVELOPER_CFLAGS. yes?

ATB,
Ramsay Jones

