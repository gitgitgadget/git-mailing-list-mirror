Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721DE604E9
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbhJFLlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:41:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48713 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhJFLlI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 07:41:08 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D04CC40003;
        Wed,  6 Oct 2021 11:39:14 +0000 (UTC)
Date:   Wed, 6 Oct 2021 17:09:12 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Sashank Bandi <bandi.rao999@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
Message-ID: <20211006113912.n7xpnuzd25256cjm@yadavpratyush.com>
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
 <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
 <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
 <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com>
 <CABkJDHGdzOFW5yP43LZtuUrV7WsDTvAi+kxka84-5P7ShbV9FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkJDHGdzOFW5yP43LZtuUrV7WsDTvAi+kxka84-5P7ShbV9FQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10/21 08:39PM, Sashank Bandi wrote:
> On Mon, Oct 4, 2021 at 1:26 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > Sorry, I couldn't find time to catch up on this because its been busy at
> > $DAYJOB.
> Well, I hope you got a little time for this thread.
> 
> > Anyway, git-gui does have some basic dark mode support, though I have
> > seen reports that it does not work very well. You can change the Tk
> > theme and it should enable dark mode on git-gui as well. See [0] for
> > some more info. I am not very familiar with how Tk theming would work on
> > Windows.
> I am not even familiar with Tcl/Tk language itself. But from what I
> have found, the Tk uses "vista" theme which is Windows-only default
> theme.

Does the Windows installation come with any other themes? You can use 
`ttk::style theme names` to list all available themes.

> 
> > I think it would be nice if we can have a theme picker in the options
> > menu though, so that is something you might want to look into.
> Yes, I thought of adding a menu between "Tools" and "Help". It will
> contain 3 options(system, light, dark) as I said before.

I think it would be better to put it in the "options" dialog.

> 
> > [0] https://lore.kernel.org/all/20201008082004.5643-1-serg.partizan@gmail.com/
> Well, this works only for Linux as Windows doesn't use X Server. But
> we can use `ttk::style theme use` for it all over the application.

Right.

> 
> My plan is to use a new theme, that is based on default, but can
> imitate the look of [0].

I don't mind carrying themes in the git-gui repo since Tk theming 
support is not very well documented or standardized. But please do be 
careful of licence compatibility when porting code.

> 
> [0]: https://github.com/TkinterEP/ttkthemes/blob/master/ttkthemes/png/equilux/equilux.tcl

-- 
Regards,
Pratyush Yadav
