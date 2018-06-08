Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8D31F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeFHWBE (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:01:04 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50575 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFHWBE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:01:04 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 412bvd2czxz5tlJ;
        Sat,  9 Jun 2018 00:01:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 459563B5;
        Sat,  9 Jun 2018 00:01:00 +0200 (CEST)
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
Date:   Sat, 9 Jun 2018 00:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.06.2018 um 18:00 schrieb Thomas Braun:
> I for my part would much rather prefer that to be a compile time
> option so that I don't need to check on every git update on windows
> if  this is now enabled or not.

This exactly my concern, too! A compile-time option may make it a good 
deal less worrisome.

-- Hannes
