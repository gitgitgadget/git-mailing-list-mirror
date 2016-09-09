Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE2020705
	for <e@80x24.org>; Fri,  9 Sep 2016 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbcIIPck (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 11:32:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:63751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbcIIPcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 11:32:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0McEI3-1bRXEA4B55-00JaBN; Fri, 09 Sep 2016 17:32:30
 +0200
Date:   Fri, 9 Sep 2016 17:32:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true"
 + "pull.rebase = preserve" - "user.email"
In-Reply-To: <xmqqvaz7x6vv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091731540.129229@virtualbox>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com> <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com> <20160729181121.GB14953@sigill.intra.peff.net> <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com> <20160729223134.GA22591@sigill.intra.peff.net>
 <xmqqvaz7x6vv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fYs2iC0ZEoy8BYvnlnqZdJVX66SJUlujjEWzbk/idB+lOMRqBzP
 hfYDXgHqe4lSuczxFxj39H1XuSUc4EaPJDsq21oBFPdpytug00Lc5820xJJLBPaOwlPVSP1
 WhIlwifUEhFUi7zBoWE9+yXMv+1P7wR+zxs+irzcyAjU4+W6YfoLCNKDIV7P3kz2qGbbc5e
 qe8AEuk1ZSpdJUqgWJvuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WedDLgZDlas=:yOEqRXrwgjyPOZOYq0sVev
 Ur+KCel97wyEBotynIHGxH4nJ6ScGV/dEScNu6bDpzYPNYjToys0YtRiAXJjjmPCdl7Pjankp
 rTbUUllAlDwoiJitJohwCfuqryi9ZrJoZEeFKYpI0PX4AsCinsgDcZb5BIimacAxHGfiFUdbJ
 RK9tlZ9JU+3D45g39K1MJtb8+jidLMYbBqxgbxh9hz6dI1Px0iaL4nJ0d1nKULKy60uhG15f8
 iptVrB9c6EOokjUlDdOZNddhh/ciJ0+rRX30RmW80HeCMgnfbtzn4o74W+Lu4Vi1hBMS8rbfb
 bmQRUGyoAYIMhjHKLRwwc9v+5G3mUZr5UPyI3An8KmflcaSH+lmPgtNFxIF/mtI5AfQV7CRWT
 Lr/poi4pY+X+Vs/eK/+Axx0huCDRgIojlFIbaLNOamxllN9hV0L+MQIy1psimeQvF1MQEb+By
 kSo33BPBwG5YJLApebcGqcpbTlkyTsCUIOsXyBYPrP+HxoRzRcz07Jp3nQfaZUAjA+wZ9iO/2
 DyRdkfPs3HouHG4gtE0PySzkWDqhItSDRqt8UmnUR46QjSdHDbheVzNj0mi5xK5K/Lyj3hhy+
 utdRGnCl+LjJ3Q1YCX6RU3/TVnTA94HJ+7bHfCAqS+2xk78EEQw88vAHfaBQfUmNHiderwoG8
 IlUnyYzGRvw/aIle0/2iz6UnI4WNQaGpndf7piwxWC9fUOCstHTYj6x3UzAxJLl4xnDeX062k
 22rvyj59trtVlw/qHLN/ZIQghp/tr4wZR6uO6C40OVwTkCCdO2zL9rT3f0/G/OMmlMFlXGujb
 g4mUa0P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Aug 2016, Junio C Hamano wrote:

> Earlier, Peff sent this patch (slightly buried in a discussion) on
> "rebase -i" in <20160729223134.GA22591@sigill.intra.peff.net>.
> 
> > Subject: rebase-interactive: drop early check for valid ident
> >
> > Since the very inception of interactive-rebase in 1b1dce4
> > (Teach rebase an interactive mode, 2007-06-25), there has
> > been a preemptive check, before looking at any commits, to
> > see whether the user has a valid name/email combination.
> >
> > This is convenient, because it means that we abort the
> > operation before even beginning (rather than just
> > complaining that we are unable to pick a particular commit).
> >
> > However, it does the wrong thing when the rebase does not
> > actually need to generate any new commits (e.g., a
> > fast-forward with no commits to pick, or one where the base
> > stays the same, and we just pick the same commits without
> > rewriting anything). In this case it may complain about the
> > lack of ident, even though one would not be needed to
> > complete the operation.
> >
> > This may seem like mere nit-picking, but because interactive
> > rebase underlies the "preserve-merges" rebase, somebody who
> > has set "pull.rebase" to "preserve" cannot make even a
> > fast-forward pull without a valid ident, as we bail before
> > even realizing the fast-forward nature.
> >
> > This commit drops the extra ident check entirely. This means
> > we rely on individual commands that generate commit objects
> > to complain. So we will continue to notice and prevent cases
> > that actually do create commits, but with one important
> > difference: we fail while actually executing the "pick"
> > operations, and leave the rebase in a conflicted, half-done
> > state.
> >
> > In some ways this is less convenient, but in some ways it is
> > more so; the user can then manually commit or even "git
> > rebase --continue" after setting up their ident (or
> > providing it as a one-off on the command line).
> >
> > Reported-by: Dakota Hawkins <dakotahawkins@gmail.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> To which, I responded (referring to the last paragraph):
> 
>     Yup, that is the controvercial bit, and I suspect Dscho's original
>     was siding for the "set up ident first, as you will need it anyway
>     eventually", so I'll let others with viewpoints different from us to
>     chime in first before picking it up.
> 
> Do you have a preference either way to help us decide if we want to
> take this change or not?

I have no strong preference. I guess that it does not hurt to go with the
patch, and it would probably help in a few cases.

Ciao,
Dscho
