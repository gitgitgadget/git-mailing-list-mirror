Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC00D1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 07:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeFIHET (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 03:04:19 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:14235 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbeFIHES (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 03:04:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 412qyT1dT3z5tlJ;
        Sat,  9 Jun 2018 09:04:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BD5563B5;
        Sat,  9 Jun 2018 09:04:16 +0200 (CEST)
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
 <20180609065132.GD30224@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <208bcf92-cc23-d63d-3dfc-441e960e1e02@kdbg.org>
Date:   Sat, 9 Jun 2018 09:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180609065132.GD30224@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.2018 um 08:51 schrieb Jeff King:
> I actually think this could be useful for normal users, too. We have
> GIT_TRACE for dumping debug output, and we sometimes ask users to turn
> it on to help diagnose a problem (not to mention that we use it
> ourselves).

The BIG difference is in "we ask the users". Asking for a trace is a 
one-shot thing; this telemetry thing is obviously intended for long-term 
survaillance.

> AFAICT this telemetry data is the same thing, but for performance. When
> somebody says "why does this command take so long", wouldn't it be nice
> for us to be able to tell them to flip a switch that will collect data
> on which operations are taking a long time?

Why do we need long-term survaillance to answer this question and why 
can it not be made a mode of GIT_TRACE?

-- Hannes
