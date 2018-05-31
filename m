Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC911FD4F
	for <e@80x24.org>; Thu, 31 May 2018 23:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750728AbeEaXIk (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 19:08:40 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:24284 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeEaXIj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 19:08:39 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40xjnK4vM4z5tlG;
        Fri,  1 Jun 2018 01:08:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DC8E11CA1;
        Fri,  1 Jun 2018 01:08:36 +0200 (CEST)
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
 <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com>
 <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f27d8344-4acb-3e87-3bd9-b23b21c4b82a@kdbg.org>
Date:   Fri, 1 Jun 2018 01:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.05.2018 um 19:27 schrieb Robert P. J. Day:
> On Thu, 31 May 2018, Duy Nguyen wrote:
>> git diff-index is "plumbing", designed for writing scripts. "git
>> diff" on the other hand is for users and its behavior may change
>> even if it breaks backward compatibility.
> 
>    ah, this was a philosophical underpinning i was unaware of. i see
> occasional explanations of git porcelain versus plumbing, but i don't
> recall anyone simply stating that the plumbing is meant to have a
> long-term stability that is not guaranteed for the porcelain.

So, there you have it. ;) Plumbing commands offer long-term stability. 
That is not just philosophical, but practically relevant.

>    in any event, this does mean that, stability issues aside, "git
> diff" would apparently have worked just fine for that hook.

It may have worked just fine. You should still not use it.

Didn't you say that you are teaching git and hooks? Then you should 
teach the right thing, and the right thing is to use plumbing for scripts.

-- Hannes
