Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3B01F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGIUZ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:25:26 -0400
Received: from s019.cyon.net ([149.126.4.28]:34698 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeGIUZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lszdJZ0RKuHBJRKr6Vi3pE2gFPh1rWGQRL+v8/xaDIg=; b=jFMn432+ef5m9ccFEIc1PxHph6
        MUx/snf5etyviURKsWXXlSFzisH5C4OdQtoFnnF3o1kfbFmCT3q2jm1aIrak+8wPI07FV3mbM2vx0
        fc5u7xEcqEmRVM1O21+uQuZgkyYgb67oh8o7LeuFymvk3cBm/NHBl2bs3sKle/SXat6CnEIKfa4Du
        jNjs/kOMNzilRG3S8au8+ohwO2CkroG82XZdbHmf74B+v+IMe0Fbf9/EDEmxUR0h0abq1vpjCcd3x
        UM1wc326qLagNM/ubIohkh69QymaLygTdKRJzUR1FQedNVRrak/Yic9SQSto03ZhGABiV9+DrYUy0
        gkXqVG9w==;
Received: from [10.20.10.233] (port=34188 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fccip-00D17z-95; Mon, 09 Jul 2018 22:25:24 +0200
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180709192537.18564-1-dev+git@drbeat.li>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <402c2b4a-0cd3-05d0-7f19-a218558cbb61@drbeat.li>
Date:   Mon, 9 Jul 2018 22:25:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709192537.18564-1-dev+git@drbeat.li>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.07.18 21:25, Beat Bolli wrote:
> While developing 6aaded550 ("builtin/config: work around an unsized
> array forward declaration", 2018-07-05), I have compiled Git with
> CFLAGS="-std=c99 -pedantic".
> 
> This series fixes a few compiler warnings when compiling with these
> options.

As a small aside, I have also compiled all of Git with -std=c11 using
gcc 8.1. This didn't turn up any new warnings, so we're looking pretty
future-proof in this regard.

Cheers,
Beat
