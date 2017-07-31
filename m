Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87EF61F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbdGaXgh (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:36:37 -0400
Received: from avasout05.plus.net ([84.93.230.250]:60916 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdGaXgg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 19:36:36 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id rbca1v00118PUFB01bcbFC; Tue, 01 Aug 2017 00:36:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=bjDHj7labMy7a8TtlV8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
Date:   Tue, 1 Aug 2017 00:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/07/17 23:30, Junio C Hamano wrote:
[snip]
> 
> * sd/branch-copy (2017-06-18) 3 commits
>   (merged to 'next' on 2017-07-18 at 5e3b9357ea)
>  + branch: add a --copy (-c) option to go with --move (-m)
>  + branch: add test for -m renaming multiple config sections
>  + config: create a function to format section headers
> 
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.
> 
>  Will cook in 'next'.
> 
>  I personally do not think "branch --copy master backup" while on
>  "master" that switches to "backup" is a good UI, and I *will* say
>  "I told you so" when users complain after we merge this down to
>  'master'.

I wouldn't normally comment on an issue like this because I am
not very good at specifying, designing and evaluating UIs (so
who in their right mind would listen to me). ;-)

FWIW, I suspect that I would not like using this interface either
and would, therefore, not use it. However, I guess the worst that
would happen, is that it would gain another 'wort' (--option) to
turn off the "switches to backup" branch. :-D

I didn't want you to think that the lack of comments on this was
because everybody agreed that it was a good idea.

ATB,
Ramsay Jones


