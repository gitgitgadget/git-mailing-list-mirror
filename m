Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1928C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2802469C
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nowsci.com header.i=@nowsci.com header.b="pxqRzHBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgARQec (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 11:34:32 -0500
Received: from mail.nowsci.com ([172.104.14.39]:52204 "EHLO mail.nowsci.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgARQec (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 11:34:32 -0500
X-Virus-Scanned: Yes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nowsci.com; s=mail;
        t=1579365268; bh=lFb1Xila55k/26GrrLsVn7X4bZoCrZ5qusmKmZ0LqZQ=;
        h=Subject:From:To:Cc:In-Reply-To:References;
        b=pxqRzHBN1FC1QVivPk31ZVH/e0kWjRe57wrCA2VeE3HkwRjp+qSqJz3ok6o8dmEjZ
         jYpRWNTVfH4g8gjtuJb5iVwSF6J2Cg+voF+vFKA6OFd2AIeSOyws970hK0yGE6stSZ
         VGkWp/v+7E79ZtAalqNE6VREEfwNTZi131WrnG0o=
X-Virus-Scanned: Yes
Message-ID: <bb0e232924305697596743d3fa93d5bf3b0e8d4d.camel@nowsci.com>
Subject: Re: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
From:   Ben Curtis <nospam@nowsci.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, phillip.wood@dunelm.org.uk,
        Ben Curtis via GitGitGadget <gitgitgadget@gmail.com>
Date:   Sat, 18 Jan 2020 11:34:20 -0500
In-Reply-To: <17b57e7f-7f3c-abab-1da6-d2e5c9ff893d@gmail.com>
References: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
         <17b57e7f-7f3c-abab-1da6-d2e5c9ff893d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2020-01-17 at 20:01 +0000, Phillip Wood wrote:
> Hi Ben
> 
> On 17/01/2020 13:45, Ben Curtis via GitGitGadget wrote:
> > From: Ben Curtis <nospam@nowsci.com>
> > 
> > In 116a408,
> 
> That commit is no longer in pu, it has been replaced by 430b75f720 
> ("commit: give correct advice for empty commit during a rebase", 
> 2019-12-06). There is now a preparatory commit 8d57f75749 ("commit:
> use 
> enum value for multiple cherry-picks", 2019-12-06) which replaces
> the 
> booleans with an enum. I need to reroll the series 
> (pw/advise-rebase-skip) that contains them, if you've got any
> comments 
> please let me know.
> 
> Best Wishes
> 
> Phillip
> 

Hi Phillip,

Thank you for the feedback, I assume that means my patch is no longer
required?

Also, is there a formal issue assignment method with `git`? I hopped on
this particular issue on GitGitGadget to get my feet wet here but was
not sure if there was a separate maintained list to track overlap like
the above.

Thanks!
Ben

