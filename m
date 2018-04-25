Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C221F424
	for <e@80x24.org>; Wed, 25 Apr 2018 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeDYTbv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 15:31:51 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:60643 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeDYTbv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 15:31:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40WVgn5tGpz5tlL;
        Wed, 25 Apr 2018 21:31:49 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 30DA810B;
        Wed, 25 Apr 2018 21:31:49 +0200 (CEST)
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
To:     phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <36d622ac-f07d-7fd9-65dd-94f88b0e2f56@talktalk.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <523dfe75-45a2-d780-2581-1bdc076dd659@kdbg.org>
Date:   Wed, 25 Apr 2018 21:31:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <36d622ac-f07d-7fd9-65dd-94f88b0e2f56@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2018 um 11:21 schrieb Phillip Wood:
> On 24/04/18 17:59, Johannes Sixt wrote:
>>
>> In modern setups, less, the pager, uses alternate screen to show
>> the content. When it is closed, it switches back to the original
>> screen, and all content is gone.
> 
> Are you setting LESS explicitly in the environment?
> 
>  From the git config man page:
> When the LESS environment variable is unset, Git sets it to FRX (if LESS 
> environment variable is set, Git does not change it at all).
> 
>  From the less man page the X option:
> Disables  sending the termcap initialization and deinitialization 
> strings to the terminal.  This is sometimes desirable if the 
> deinitialization string does something unnecessary, like clearing the 
> screen.
> 
> So with the default setup the output should remain on the screen.

Right. But I have LESS=RS because I do *not* want it to remain on screen 
by default.

-- Hannes
