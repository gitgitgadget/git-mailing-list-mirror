Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F0420281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbdJCAsV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:48:21 -0400
Received: from avasout07.plus.net ([84.93.230.235]:56733 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdJCAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:48:20 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id GooH1w0030M91Ur01ooJek; Tue, 03 Oct 2017 01:48:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=ZdlO4LmE-fkoEcewqMkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
 <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <72995d24-d337-39c0-0abd-64bce1c22028@ramsayjones.plus.com>
Date:   Tue, 3 Oct 2017 01:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/10/17 14:44, Pranit Bauva wrote:
[snip]
>> Look for []-ed comments in the commit messages for a note of
>> the changes I made to your original patches, in patches #2,
>> #4, #7-9, #11-12 and #14.
>>
>> The commits I added, which are just WIP, are as follows:
>>
>>   $ git log --oneline bisect~12..bisect
>>   7d7117040 (raj/bisect, bisect) bisect--helper: convert to struct object_id
>>   188ea5855 bisect--helper: add the get_bad_commit() function
>>   b75f46fb4 bisect--helper: add a log_commit() helper function
>>   4afc34403 bisect--helper: reduce the scope of a variable
>>   62495f6ae bisect--helper: remove useless sub-expression in condition
>>   964f4e2b0 bisect--helper: set correct term from --term-new= option
>>   62efc099f bisect--helper: remove redundant assignment to has_double_dash
>>   d35950b92 bisect--helper: remove redundant goto's
>>   b33f313ac bisect--helper: remove space just before \n in string
>>   3eb407156 bisect--helper: remove some unnecessary braces
>>   c2b89c9b8 bisect--helper: add some vertical whitespace
>>   8c883701c bisect--helper: fix up some coding style issues
>>   $
>>
>> Again IIRC, there are a couple of bug fixes in these commits ...
> 
> There is actually a major bug in the later part of previous series
> mostly in the bisect-next which actually caused delays. I think you
> have fixed it in your commit 682d0bff0. Although I would need to have
> a closer look at it. In original series, I did get a sigserv, and as
> you mention it in the commit that you have fixed it.

Yes, I also meant to tidy that up by removing some, now
redundant, initialisation later in that function.

Note, that wasn't the only bug! (I have probably forgotten
some of them, but look at 964f4e2b0, for example).

ATB,
Ramsay Jones

