Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D261F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfJKQCh (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:02:37 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40649 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:02:37 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iIxNC-0001A0-5k; Fri, 11 Oct 2019 17:02:35 +0100
Subject: Re: [PATCH] git-rev-list.txt: prune options in synopsis
To:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
 <20191011060457.GC20094@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c9e7fbd6-7ad6-bce9-1e17-6391ab3e0630@iee.email>
Date:   Fri, 11 Oct 2019 17:02:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011060457.GC20094@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2019 07:04, Jeff King wrote:
> On Fri, Oct 04, 2019 at 05:13:08PM -0700, Denton Liu wrote:
>
>> The synopsis section in git-rev-list.txt has grown to be a huge list
>> that probably needs its own synopsis. Since the list is huge, users may
>> be given the false impression that the list is complete, however it is
>> not. It is missing many of the available options.
>>
>> Since the list of options in the synopsis is not only annoying but
>> actively harmful, replace it with `[<options>]` so users know to
>> explicitly look through the documentation for further information.
>>
>> While we're at it, update the optional path notation so that it is more
>> modern.
> Yes, thank you! This has bugged me for a while. I suspect there are
> other pages that could use similar treatment, but I don't mind at all
> doing it incrementally.
>
> (One of them is git-branch, where I think the synopsis should focus on
> showing the major modes and not listing every possible branch-listing
> option).
>
> -Peff
I'd agree that simplifying the rev-list page is good.

Another case, of a different style, is that of `git bundle --all` which 
does need mentioning that particular rev-list option as a major usage (I 
couldn't manage to understand the three layers of man page that needed 
reading).

I had proposed a patch many years ago [1] but the feedback wasn't 
positive, though my SO question continues [2] to get votes.

Philip

[1] 
https://public-inbox.org/git/1348010734-664-2-git-send-email-philipoakley@iee.org/
[2] 
https://stackoverflow.com/questions/11792671/how-to-git-bundle-a-complete-repo

