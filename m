Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E884D1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 00:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbcIHAvM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 20:51:12 -0400
Received: from avasout07.plus.net ([84.93.230.235]:36323 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcIHAvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 20:51:12 -0400
Received: from [10.0.2.15] ([209.93.82.95])
        by avasout07 with smtp
        id gor71t00423PrXV01or8br; Thu, 08 Sep 2016 01:51:10 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CYlK3/jl c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=49IAGGh7w6lmSFrJPGgA:9 a=QEXdDO2ut3YA:10 a=ifddREelyh0A:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/3] diff_flush_patch_id: stop returning error result
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5c4276ad-19ed-1481-41cf-3d506ef9c7c6@ramsayjones.plus.com>
Date:   Thu, 8 Sep 2016 01:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/09/16 23:04, Jeff King wrote:
> All of our errors come from diff_get_patch_id(), which has
> exactly three error conditions. The first is an internal
> assertion, which should be a die("BUG") in the first place.
> 
> The other two are caused by an inability to two diff blobs,
                                           ^^^^^^^^^^^^^^^^^
Huh? ... to diff two blobs?

ATB,
Ramsay Jones
