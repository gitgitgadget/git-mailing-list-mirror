Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7CC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 14:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiANOxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 09:53:53 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:36164 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241883AbiANOxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 09:53:52 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n8Nxe-0000vD-8s;
        Fri, 14 Jan 2022 14:53:51 +0000
Message-ID: <851ecd86-02d0-b078-1c90-ebe75ad46926@iee.email>
Date:   Fri, 14 Jan 2022 14:53:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: feature request: add [-f|--from <rootbranch>] to git stash branch
Content-Language: en-GB
To:     Colin Kennedy <colin@mrkennedy.ca>, git@vger.kernel.org
References: <2a4f90e9-9abb-40b6-a6f3-a676567e4fc0@www.fastmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <2a4f90e9-9abb-40b6-a6f3-a676567e4fc0@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, some minor comments, in-line.

On 13/01/2022 16:29, Colin Kennedy wrote:
> Current syntax of git stash branch is:
>
> branch <branchname> [<stash>]
>
> Proposed syntax is:
>
> branch <branchname> [-f|--from <rootbranch>] [<stash>]

Just to say that the `-f` is typically reserved/used for the --force
option if available.
>
> the from flag specifies a branch from which the new branch should be derived.
>
> Example usage:
>
> git stash branch remove-commented-code --from main
>
> This simplifies a workflow which is common for me. I am working N-commits deep in some feature branch when I discover a low hanging fruit. Dealing with this low hanging fruit is not appropriate for the current feature branch. It's most appropriate to deal with "directly" on a fresh branch from main. Because I am untidy, 
Maybe an example that shows the level of untidiness might help to
clarify the suggestion, as to what is included/not included, and how it
makes it easy later when the stash is recovered.

> I often have a bit of mess in between my staging area, and unstaged changes, and this creates friction when I attempt to stash this low hanging fruit, pop back to main, create the new branch, pop the stashed low hanging fruit, etc etc.
>
> The proposed flag gives a one-liner to apply stashed patches wherever, no matter your current location, which I think is an improvement.
>
> Happy to have feedback on the flag. Happy for someone else to implement it. Also happy to consider taking a crack at it myself if it seems like something people would be happy to include. (NB: I haven't written or even read any c, or c++ for that matter, in probably 15 years. So, you know).
>
> thanks,
> Colin

