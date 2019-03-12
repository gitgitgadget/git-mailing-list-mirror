Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34AE20248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfCLRjR (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:39:17 -0400
Received: from avasout01.plus.net ([84.93.230.227]:43948 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfCLRjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:39:16 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 3lMvhGKq2cPek3lMwh1a7y; Tue, 12 Mar 2019 17:39:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=R84t5+ZX c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=sV_bWNHCBLNOYcYjau0A:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC/PATCH] packfile: use extra variable to clarify code in
 use_pack()
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e561b83f-cf1c-eef8-7651-8519ce105491@ramsayjones.plus.com>
Message-ID: <b4106d4b-5f9e-4577-c8ed-641df33d4fb5@ramsayjones.plus.com>
Date:   Tue, 12 Mar 2019 17:39:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e561b83f-cf1c-eef8-7651-8519ce105491@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNUikBeoT2mzGt/JmVmXO8LFXjl6kkj41aG7rfjfv62XcHGGWDzyVfOwU+9QyD2ZNdV/8adDaZDheuRMQa2QM1TJKziKP21ZVMCnP4R5zwClTap+NCCx
 l3woFBdo6oSXI3IzGse4Fb2fZR+HAJFTTcobIbeWKS5IOHr+DOdw9riW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/03/2019 16:55, Ramsay Jones wrote:
> From: Jeff King <peff@peff.net>
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Jeff,
> 
> I recently tried (yet again) to tidy up some old branches. When I get
> around to doing a 'git gc; git fsck' I always take a quick look at
> the 'dangling' commits, just before a 'git gc --prune=now'.
> 
> I had no recollection of this commit, from last October, but a quick
> look at the ML archive found this [1] discussion. I obviously thought
> it was worth saving this thought of yours. ;-) So, having deleted this
> already, I did a quick 'format-patch' to see if anyone thinks it is
> worth applying.
> 
> [1] https://public-inbox.org/git/20181013024624.GB15595@sigill.intra.peff.net/#t
> 

Heh, of course I should have tried applying on top of today's
codebase before sending it out! :(

Having just done so, it quickly showed that this patch assumes
that the 'left' parameter to use_pack() has been changed from
an 'unsigned long *' to an 'size_t *' as part of the series
that was being discussed in the above link.

Ah, well, sorry for the noise!

ATB,
Ramsay Jones

