Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB2D1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 18:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbfJQS2o (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 14:28:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47743 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392448AbfJQS2o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 14:28:44 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 555131BF207;
        Thu, 17 Oct 2019 18:28:42 +0000 (UTC)
Date:   Thu, 17 Oct 2019 23:58:34 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
Message-ID: <20191017182833.rzk6r6egmvpmjtns@yadavpratyush.com>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com>
 <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
 <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com>
 <20191016192819.5fxbwdediomj7gaz@yadavpratyush.com>
 <CAGr--=Ltx2JPexfVSWRrAdT0zHs0RWaZdS7OZD-TWJv2y7K-PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=Ltx2JPexfVSWRrAdT0zHs0RWaZdS7OZD-TWJv2y7K-PA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/19 07:08AM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> On Wed, Oct 16, 2019 at 9:28 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > I mentioned this earlier, and I'll mention this again: I'm not sure
> > whether this feature would be a good thing for the larger population. So
> > this _might_ not end up being accepted depending on how people react to
> > the proposal. I thought I'd let you know to avoid any nasty surprises
> > later.
> 
> Could you please elaborate on why you think the feature might be
> undesired? Why would users not want a staged file to be selected
> automatically?

I have similar arguments to what Philip said in the GitHub link you 
sent. I think software should do what the user tells it to do, and 
should not try to "second guess" them. This second guessing can get 
annoying.

So if I select the commit message buffer, I told the software to select 
it by clicking it. I did not tell it to switch my diff view. This switch 
of view can prove to be disorienting/confusing to a user because they 
did not select any diff. They selected a text box.

At the very least, I think we should have a config option, and it should 
be turned off by default. That said, I'd certainly like to hear what 
other people think on this topic.
 
> FWIW I've also got 2 comments on this in GH[1].
> 
> [1] https://github.com/git-for-windows/git/issues/2341

-- 
Regards,
Pratyush Yadav
