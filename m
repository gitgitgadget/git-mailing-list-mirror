Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A4181FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 16:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbcLAQKI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:10:08 -0500
Received: from avasout06.plus.net ([212.159.14.18]:54857 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbcLAQKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:10:06 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2016 11:10:06 EST
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id Eg6r1u0010srQBz01g6scp; Thu, 01 Dec 2016 16:06:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=6jp5xOHDhjXj1-ze_J0A:9 a=QEXdDO2ut3YA:10 a=9V0Q_xL71dEA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/6] http: make redirects more obvious
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090428.pweq7slwujbne5hg@sigill.intra.peff.net>
Cc:     Jann Horn <jannh@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5a47c032-755d-ad11-390f-22ae19ca584a@ramsayjones.plus.com>
Date:   Thu, 1 Dec 2016 16:06:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161201090428.pweq7slwujbne5hg@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/12/16 09:04, Jeff King wrote:
> We instruct curl to always follow HTTP redirects. This is
> convenient, but it creates opportunities for malicious
> servers to create confusing situations. For instance,
> imagine Alice is a git user with access to a private
> repository on Bob's server. Mallory runs her own server and

Ahem, so Mallory is female? (-blush-) :(

ATB,
Ramsay Jones

