Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4341F453
	for <e@80x24.org>; Thu,  1 Nov 2018 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeKBCVz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 22:21:55 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:41241 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeKBCVz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 22:21:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42mBjj1W2Jz5tmW;
        Thu,  1 Nov 2018 18:18:01 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8C93B221C;
        Thu,  1 Nov 2018 18:18:00 +0100 (CET)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] tests: optionally skip `git rebase -p` tests
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.63.git.gitgitgadget@gmail.com>
 <39734e4805cbd695cd69e7c1a3016de629ac9b3c.1541016115.git.gitgitgadget@gmail.com>
 <xmqqh8h1tjg9.fsf@gitster-ct.c.googlers.com>
X-Mozilla-News-Host: news://nntp.gmane.org
Message-ID: <da1d00b5-8516-6185-60cf-cc7738daa1a3@kdbg.org>
Date:   Thu, 1 Nov 2018 18:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8h1tjg9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.18 um 07:12 schrieb Junio C Hamano:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> The `--preserve-merges` mode of the `rebase` command is slated to be
>> deprecated soon, ...
> 
> Is everybody on board on this statement?  I vaguely recall that some
> people wanted to have something different from what rebase-merges
> does (e.g. wrt first-parent history), and extending perserve-merges
> might be one way to do so.

Maybe you are referring to my proposals from a long time ago. My 
first-parent hack did not work very well, and I have changed my 
workflow. --preserve-merges is certainly not a feature that *I* would 
like to keep.

The important question is whether there are too many users of 
preserve-merges who would be hurt when it is removed. It is irrelevant 
whether preserve-merges is a good base for extensions because it can 
easily be resurrected if the need arises.

> I do not mind at all if the way forward were to extend rebase-merges
> for any future features.  To me, it is preferrable having to deal
> with just one codepath than two written in different languages.
> 
> I just want to make sure we know everybody is on board the plan that
> we will eventually remove preserve-merges, tell those who want to
> use it to switch to rebase-merges, and we will extend rebase-merges
> when they raise issues with it saying that they cannot do something
> preserve-merges would have served them well with rebase-merges.

-- Hannes
