Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CAC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F8460FE6
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHQR4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:56:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:63727 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhHQR4p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:56:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6CC673F47F6;
        Tue, 17 Aug 2021 13:56:11 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4A6BC3F40F5;
        Tue, 17 Aug 2021 13:56:11 -0400 (EDT)
Subject: Re: [RFC PATCH] fsmonitor: fix building with NO_PTHREADS
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com
References: <20210817082310.2157-1-carenas@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a5468146-aa26-62a1-2c7e-e35fa73ff041@jeffhostetler.com>
Date:   Tue, 17 Aug 2021 13:56:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210817082310.2157-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/17/21 4:23 AM, Carlo Marcelo Arenas Belón wrote:
> something similar will be needed for the NO_UNIX_SOCKETS, since the
> system setting for support of FSMONITOR_DAEMON_BACKEND is not enough
> to cover for the code dependencies.
> 
> alternatively FSMONITOR_DAEMON_BACKEND could be used to imply support
> was requested AND code dependencies are covered, but this setup at
> least allows for building and uses the "mock" implementation.
> 
> since the enum is needed for the fallback code, had to be moved outside
> of the #ifdef
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
 > ...


Thanks, I'll incorporate this into my next version.
BTW, what platform did you detect this on?

Jeff

