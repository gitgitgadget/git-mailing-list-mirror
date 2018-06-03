Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072101F403
	for <e@80x24.org>; Sun,  3 Jun 2018 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeFCKoZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 06:44:25 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:36249 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbeFCKoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 06:44:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40zF7C20gCz5tlB;
        Sun,  3 Jun 2018 12:44:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3D4741CA5;
        Sun,  3 Jun 2018 12:44:22 +0200 (CEST)
Subject: Re: how exactly can git config section names contain periods?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Jeff King <peff@peff.net>, Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
 <20180601210731.GA20974@sigill.intra.peff.net>
 <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8fe323a2-60ae-8382-ed0e-bfe772052b7f@kdbg.org>
Date:   Sun, 3 Jun 2018 12:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.2018 um 11:53 schrieb Robert P. J. Day:
> if i wanted to do something this admittedly awkward, would using
> periods give me some benefit related to, i don't know, regex matching,
> as compared to using a different character? or am i just way
> overthinking this? is anyone out there actually taking advantage of
> multi-level subsections?

There is nothing wrong with having all of these

     git config foo.a.b.c.key value
     git config foo.a.b.c value
     git config foo.a.b.key value

in a single configuration file, I think. There is nothing special there. 
They're three different settings in two different (sub-)sections.

-- Hannes
