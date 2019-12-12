Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA6C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31759214D8
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 22:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfLLWCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:02:17 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:15910 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbfLLWCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 17:02:17 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ifWXG-0002ic-Be; Thu, 12 Dec 2019 22:02:15 +0000
Subject: Re: git checkout --autostash and git branch --autopop
To:     Denton Liu <liu.denton@gmail.com>, rottis@fea.st
Cc:     git@vger.kernel.org
References: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
 <20191212180901.GA35927@generichostname>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e7850a51-4396-4698-ed98-62f991e33992@iee.email>
Date:   Thu, 12 Dec 2019 22:02:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191212180901.GA35927@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2019 18:09, Denton Liu wrote:
> Hi rottis,
>
> On Thu, Dec 12, 2019 at 02:19:50PM +0200, rottis@fea.st wrote:
>> Similar to the 'git rebase --autostash', running 'git checkout --autostash' would automatically stash uncommitted changes for the
>> current branch.  then running 'git branch --autopop' would automatically apply an automatic stash when switching to a branch that had one.
> I currently have a WIP version of this feature but I haven't had enough
> time to polish it off (tests and docs). The last RFC round can be seen
> here[1] if you want to test it out. It seems to work well enough for
> personal use.
>
> [1]: https://lore.kernel.org/git/cover.1571246693.git.liu.denton@gmail.com/
Isn't this meant to be something similar to the --no-merge option for 
checkout. That is: I am where I am, but really I want this to be on 
branch X. Or is the --no-merge option meant to be something else?
--
Philip
