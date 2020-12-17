Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AABAC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4461D224D4
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 18:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgLQSzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 13:55:31 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41831 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgLQSzb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 13:55:31 -0500
X-Originating-IP: 103.82.80.43
Received: from localhost (unknown [103.82.80.43])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D9B7840005;
        Thu, 17 Dec 2020 18:54:48 +0000 (UTC)
Date:   Fri, 18 Dec 2020 00:24:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: git-gui patches
Message-ID: <20201217185446.onap43u2fso5km2h@yadavpratyush.com>
References: <b76cf18c-91ff-342b-af26-7b2a67bd6d8a@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76cf18c-91ff-342b-af26-7b2a67bd6d8a@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 17/12/20 07:07PM, Stefan Haller wrote:
> Hi Pratyush,
> 
> I was wondering what your plans are for the git-gui patches that have
> been floating around in the past few weeks.

Sorry for the inactivity recently. Have a lot going on at $DAYJOB.
 
> The most important one for me is this one:
> 
>   <https://lore.kernel.org/git/
>    20201122133233.7077-1 serg.partizan@gmail.com/>
> 
> because it fixes a regression that was introduced in 2.29. I was hoping
> that this could be included in 2.30 to fix the regression (but maybe
> that's too late already).

I need to go through the entire chain and take a close look at it. If I 
have no big objections, I'll merge it in in a few hours.

> 
> Related (and actually on top of that one) is
> 
>   <https://lore.kernel.org/git/
>    20201124212333.80040-1-stefan@haller-berlin.de/>
> 
> which I hope should also be uncontroversial. I think this is a
> considerable improvement, and would be happy to see this included.

This one seems a bit more complicated. I should have reviewed this long 
ago. I'll take a look at it today and see if it is good enough for a 
late merge. If not let's target the next release.
 
> 
> And then we have
> 
>   <https://lore.kernel.org/git/
>    20201122194537.41870-2-stefan@haller-berlin.de/>
> 
> which you said you would apply, but I don't see this in your tree yet.
> Just wanted to make sure that this doesn't fall through the cracks.

This one will go in. I have merged it locally but haven't pushed it out 
yet.
 
There is also the auto-rescan patch [0]. I am almost done with the 
follow-up warning patch I promised. Will post it soon but that will also 
have to wait till the next merge window unfortunately.

Thanks for all the work on git-gui :-)

[0] https://lore.kernel.org/git/e691c62c-7fb2-6a7d-0f02-7c0ab021f738@haller-berlin.de/

-- 
Regards,
Pratyush Yadav
