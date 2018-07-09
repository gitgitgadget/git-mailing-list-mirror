Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467D11F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933255AbeGIVru (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:47:50 -0400
Received: from s019.cyon.net ([149.126.4.28]:50798 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933118AbeGIVrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Mu7nftuPZYnA32GYua1RHG8yy636vrSUbqMxOjXTCRs=; b=vfcW0Dx8+SaY5KPSJBp3AKXJdU
        sEOsLtjX6PkauwKp+59Tu04XJPAi8u4VnCdXN9A3G2mQgr4bPSspdnFNs0job68Nu1m2JMHZ0a7B0
        irg4qDWlC6cx11wIhfzTnSKXNamayqC0Pnpseyo8yV/jVqdcUOhSiAgCU8qJxdhcQGZKmVIK+DiTa
        zdVircV3cKxU6dxXCQrI9xRhGpCjRXxvPvg705yqeIqXrZZOKz+1thGLiBFTOrf26YwnAAD+icqD8
        4ZxTgsB1h1EEyX2uBjacGv3XWoMLW75WOK3DFogiDlkv0AiiydhF3xoWlXGzAZYNzj06WEOyltIB2
        OkvmyY1A==;
Received: from [10.20.10.233] (port=25956 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fce0Y-00DNe6-OV; Mon, 09 Jul 2018 23:47:48 +0200
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180709192537.18564-1-dev+git@drbeat.li>
 <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <0306f303-81c1-af5a-4b4f-007f948dc563@drbeat.li>
Date:   Mon, 9 Jul 2018 23:47:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
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

On 09.07.18 23:45, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> While developing 6aaded550 ("builtin/config: work around an unsized
>> array forward declaration", 2018-07-05), I have compiled Git with
>> CFLAGS="-std=c99 -pedantic".
> 
> Nicely done.  
> 
> With these 6 patches and the USE_PARENCE_AROUND_GETTEXT_N hack, the
> forward decl of the unsized static array you dealt with separately
> becomes the only remaining violation in the codebase, which is good.
> 
> Will queue.  Thanks.

Thanks!

Beat
