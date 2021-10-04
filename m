Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975CC4332F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E35C6139D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhJDH5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:57:54 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47559 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhJDH5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:57:53 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 983CA24000B;
        Mon,  4 Oct 2021 07:56:02 +0000 (UTC)
Date:   Mon, 4 Oct 2021 13:26:00 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Sashank Bandi <bandi.rao999@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
Message-ID: <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com>
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
 <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
 <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sashank,


On 03/10/21 08:03PM, Sashank Bandi wrote:
> Hey!
> Is there any way to reach Pratyush Yadav ?
> This thread has been stale for days.

Sorry, I couldn't find time to catch up on this because its been busy at 
$DAYJOB.

Anyway, git-gui does have some basic dark mode support, though I have 
seen reports that it does not work very well. You can change the Tk 
theme and it should enable dark mode on git-gui as well. See [0] for 
some more info. I am not very familiar with how Tk theming would work on 
Windows.

I think it would be nice if we can have a theme picker in the options 
menu though, so that is something you might want to look into.

[0] https://lore.kernel.org/all/20201008082004.5643-1-serg.partizan@gmail.com/

> 
> On Tue, Sep 28, 2021 at 8:51 AM Sashank Bandi <bandi.rao999@gmail.com> wrote:
> >
> > On Mon, Sep 27, 2021 at 11:39 PM David Aguilar <davvid@gmail.com> wrote:
> > > Have you tried git cola? [1]
> > Yes, I did try it.
> >
> > > Git GUI is useful because it's built in, but from a usability
> > > perspective cola has many advantages.
> > But it is just too much for my very light usage. I want something
> > light and embedded in Git for Windows itself.
> >
> > > .. and beyond these rather small differences, git cola even has image
> > > diffs[2]. That alone is a killer feature.
> > It is a really great feature. But it isn't useful for me in my projects.
> >
> > I have looked at tortoise Git, Git Cola, lazygit and some others too
> > but Git GUI seems perfect for my usage, except dark mode.

-- 
Regards,
Pratyush Yadav
