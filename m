Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A56520966
	for <e@80x24.org>; Sun,  2 Apr 2017 14:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdDBOso (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 10:48:44 -0400
Received: from avasout04.plus.net ([212.159.14.19]:54272 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdDBOsn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 10:48:43 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id 3Sog1v00222aPyA01Sohio; Sun, 02 Apr 2017 15:48:42 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=upBmBzoR67wCPQl3rmAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <xmqq1std1lmb.fsf@gitster.mtv.corp.google.com>
 <9b9a6cc2-a7d4-a7b8-0483-5aefdf926ca7@ramsayjones.plus.com>
 <xmqqh927tr6p.fsf@gitster.mtv.corp.google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fe8f84d7-7bcc-f872-4bad-32e5b957bf17@ramsayjones.plus.com>
Date:   Sun, 2 Apr 2017 15:48:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh927tr6p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/04/17 04:38, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>> I am getting the impression that the files-backend thing as well as
>>> this topic are ready for 'next'.  Please stop me if I missed something
>>> in these topics (especially the other one) that needs updating
>>> before that happens.
>>
>> Hmm, are these branches 'tangled' with nd/prune-in-worktree?
>> (I think they were at one point, but maybe not now?).
> 
> Michael's mh/separate-ref-cache builds directly on top of
> nd/files-backend-git-dir topic.
> 
> nd/prune-in-worktree builds directly on top of
> nd/worktree-kill-parse-ref, which in turn builds directly on top of
> nd/files-backend-git-dir.
> 
> In that sense, Michael's series and Duy's later two series are
> "tangled" (i.e. shares some common commits that are still not in
> 'master').  If nd/files-backend-git-dir that is shared among them is
> ever rebased, all of them need to be rebased on top of it
> consistently.
> 
> But if either of nd/prune-in-worktree and nd/worktree-kill-parse-ref
> needs to be rerolled, that can be done independently from Michael's
> series, as long as nd/files-backend-git-dir is solid and unchanging.

I suspected as much (hence the 'maybe not now' comment), but I noticed
that all four branches were merged into 'jch'. So, it seemed possible
to me that they were all being considered for merging into next.

Thanks!

ATB,
Ramsay Jones


