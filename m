Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093E1207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 17:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756077AbdD0Rgg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 13:36:36 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:41766 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752533AbdD0Rgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 13:36:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wDPJK4NLRz5tlH;
        Thu, 27 Apr 2017 19:36:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D4E531C7;
        Thu, 27 Apr 2017 19:36:32 +0200 (CEST)
Subject: Re: [PATCH 00/26] Address a couple of issues identified by Coverity
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <966db3c1-a2e4-1309-e178-b885d2a1108f@kdbg.org>
Date:   Thu, 27 Apr 2017 19:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:19 schrieb Johannes Schindelin:
> I recently registered the git-for-windows fork with Coverity to ensure
> that even the Windows-specific patches get some static analysis love.
>
> While at it, I squashed a couple of obvious issues in the part that is
> not Windows-specific.

Thanks for the fish. I'd looked at the series and had a few comments.

Hunting memory leaks is the way to insanity. Never again am I going to 
help with this. I prefer to rewrite this codebase to C++ and have 
leak-free code by design.

Thanks,
-- Hannes

