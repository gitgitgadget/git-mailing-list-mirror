Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DCCC77B7F
	for <git@archiver.kernel.org>; Sat,  6 May 2023 16:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjEFQAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjEFQAc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 12:00:32 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEB13842
        for <git@vger.kernel.org>; Sat,  6 May 2023 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=rL9g3ROwFR9xUOvjBXyMou6rA8Vy6R5xy5K2X1WFW7s=; b=boCeYX
        L7oR5DrD0Xv3fqQ5tFxI3jpoj2E+jEHMgm3ojBxvrXA+qifU9Js/vrPHaGpNQK+O7TtIdh02m2ZUV
        aqw/s0iOTPF8acgmUuXC634QAhs7dU3lRAfZKcwRSUB0zSXqN+NI+yNPb8bulJZVP1mb42yHeqRPx
        3y9zdQjDKXY=;
Received: from 88-110-117-142.dynamic.dsl.as9105.com ([88.110.117.142] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pvKKe-0004aY-F3;
        Sat, 06 May 2023 17:00:24 +0100
Message-ID: <fce603aa-ceb7-d601-6a19-657e36d9059c@iee.email>
Date:   Sat, 6 May 2023 17:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] gitk: handle long command-lines
Content-Language: en-GB
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
 <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/2023 10:17, Johannes Schindelin wrote:
> Hi Pau & Junio,
>
> this patch series saw a positive review from Junio (thank you! I know that
> you try to stay away from Tcl code, so I appreciate the effort very much),
> but apart from that it simply languished on the mailing list for more than
> two months now.
>
> Paul, is there anything I can do to help you integrate this into `gitk`?
> Or is it time to pass over `gitk` maintenance to the Git project?
>
> Ciao,
> Johannes

I just tripped over this problem while trying to de-stack my Git backlog
https://github.com/git-for-windows/git/issues/4408 "sdk gitk interaction".

>
> On Tue, 24 Jan 2023, Johannes Schindelin via GitGitGadget wrote:
>
>> These patches have been cooking for such a long time in Git for Windows that
>> you might think they turned into broth. Yummy broth, to be sure. But broth.
>> 'Tis beyond time for the patches to make it upstream.
>>
>> Johannes Schindelin (1):
>>   gitk: prevent overly long command lines
>>
>> Nico Rieck (1):
>>   gitk: escape file paths before piping to git log
>>
>>  gitk | 36 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>>
>> base-commit: 465f03869ae11acd04abfa1b83c67879c867410c
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1469%2Fdscho%2Fgitk-long-cmdline-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1469/dscho/gitk-long-cmdline-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1469
>> --
>> gitgitgadget
>>

If there was a way to un-stick this [1] it would be great.

Philip
[1]
https://lore.kernel.org/git/pull.1469.git.1674559397.gitgitgadget@gmail.com/
