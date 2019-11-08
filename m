Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187AF1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKHQIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 11:08:36 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:31436 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHQIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 11:08:36 -0500
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iT6oM-0006mz-3j; Fri, 08 Nov 2019 16:08:34 +0000
Subject: Re: No Checkout / Read Only config Flag
To:     Ingo Wolf <ingo.wolf@gmx.de>, Git List <git@vger.kernel.org>
References: <f3378b7b-c745-58db-55ed-c2c2a6818734@gmx.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <baf800ba-d92c-74be-d590-56f3bb4c6c44@iee.email>
Date:   Fri, 8 Nov 2019 16:08:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f3378b7b-c745-58db-55ed-c2c2a6818734@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/2019 21:34, Ingo Wolf wrote:
> Hi,
>
> is there a readonly / no checkout flag in the git configs?
>
Not that I'm aware of, but the use-case isn't clear, and is perhaps 
contrary to actually having a version management system
> I use Git to trace / Backup some worktrees and would like to prevent
> changing them accidentally with git.
>
How would such 'accidents' happen? What's the size of the worktree and 
how do you do such an accidental commit?

I could see that if you are changing hundreds of files within a commit, 
and only one or two files need preserved, then did a `git add -A` you 
would include any changes to those one or two special files, which 
needed special attention.

This feels similar but not quite the same as previous discussions about 
'precious' files (the latter commonly being untracked/ignored, but 
shouldn't be removed/cleaned).

Technology won't solve the human error modes..., though a clear use case 
can help.
-- 
Philip

