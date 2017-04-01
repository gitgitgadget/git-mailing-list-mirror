Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D8F2096C
	for <e@80x24.org>; Sat,  1 Apr 2017 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdDAV1D (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 17:27:03 -0400
Received: from avasout04.plus.net ([212.159.14.19]:33430 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdDAV1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 17:27:02 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id 39Sz1v00422aPyA019T0Qz; Sat, 01 Apr 2017 22:27:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=bepvpspafNCoAMrKtugA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
To:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9b9a6cc2-a7d4-a7b8-0483-5aefdf926ca7@ramsayjones.plus.com>
Date:   Sat, 1 Apr 2017 22:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/03/17 17:01, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This version literally only contains a few commit message changes and
>> one minor comment changes relative to v1. The code is identical. I
>> wasn't sure whether it is even worth sending this patch series to the
>> ML again; Junio, if you'd prefer I just send a link to a published
>> branch in such cases, please let me know.
> 
> The review on the list is not about letting me pick it up, but is
> about giving reviewing contributors a chance to comment.  I think
> for a series this important ;-) it is good that you are giving it
> multiple exposures so that people who were offline the last time can
> have a chance to look at it, even if the update is minimum.
> 
>> This patch series is also available from my GitHub fork [2] as branch
>> "separate-ref-cache". These patches depend on Duy's
>> nd/files-backend-git-dir branch.
> 
> I am getting the impression that the files-backend thing as well as
> this topic are ready for 'next'.  Please stop me if I missed something
> in these topics (especially the other one) that needs updating
> before that happens.

Hmm, are these branches 'tangled' with nd/prune-in-worktree?
(I think they were at one point, but maybe not now?).

I sent Duy some comments on that branch (an unused function and
a 'plain integer used as NULL pointer' warning).

ATB,
Ramsay Jones


