Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27411F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeAEVjS (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:39:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:54803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbeAEVjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:39:17 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MVsUW-1eQrZf2V0C-00X3L7; Fri, 05 Jan 2018 22:39:11 +0100
Date:   Fri, 5 Jan 2018 22:39:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
In-Reply-To: <20180105204427.GA6515@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1801052228270.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com> <20180103222821.GA32287@sigill.intra.peff.net> <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com> <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com> <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com> <CAK2k7nSWoNX+Y5dhLqLVzhzE12f3MgZo0R8xrHYKFwxCL+9mEg@mail.gmail.com> <nycvar.QRO.7.76.6.1801052118410.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <20180105204427.GA6515@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dY+rYUdcjMzbus26Bl9JODYFJZ51M5HwgaS2Gq4dc0sdh1q+uNA
 FN2R8nPhqhopjJW2qECTwpxdmM1dahftu6UrjcRExZdYeRuvizMSYvRkn1ikyPHr8LmUBoz
 b3JuJsAy1L8jf2QPQVqHLKl72aV1wonWcmfRP5aULHqzhf7Oy39+b1oRtBQfKO7pUJHQX3e
 tMQxuWiYgGmbluPjza+sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/iAXxNn4gPw=:F9ifioAutAOW4eiZV7CJww
 QGQNlFk3DlRmQKxuzSXMxyxTW1FjtczqaZ/l+o18I5TYWEYif4mS9TCJOHitheTP9sjshtHTD
 CWL172dmi6rSmWxjGuHoDoI9U0IWMuo0sMi8BdiaojiJAY5nVQj2WbuvL7rf/ThvqrVd1BFcF
 RtDT7e8OmODF7BEFcNopGJVn51lTAg9p2D82ee++V5OkYiRNDe0jx33GVnW4bkE2DjtymXE2n
 jVvgKtgpmo9aQVOfycGeph2xXPp2U98Rwa/w1ag47l+MHt0ae3ew/h3C2Q+F3k+TeTZJg8QiQ
 5Wz+nqQLwZF5xToAWfuUW3baQTjpVCx1i58qwcNNAegPpRIzV4TeAzjNXoxgvBzi1AqXmvrzG
 F1A8WMP/uu7mlwg96PPGEQOOKE81oHLY8hIYJp6uYc6iUi/K3mCuoW/+SiFDHesTUj4z1pifD
 mOa0uEtvKJ1KJfcJu1ogtLphoj1YEDUV/LUmCn4YiKvI+smCIml8eoCzTwHNc2eH4feh4WeU1
 d6ic7QqeelHaWDVN1wzWu0/+KU5wLN1CW+/nsF9kr25Yu+AFNcTvfj5w5jcz5hA2GYEVeF2nu
 dtpVV3+MusF5NBPoIJDKyp3NjFZzJX1QRnoCJsKQAWBL4fNB9uyhwTxLXZbrSMIEtNddR8nCv
 lZXuZnW4v1oO4XrQbIdlQpdLgh5zndMQ/PS4BG2WAGfcPt2tvzc4Y0ctzCcGIbKz9AKl5zBGq
 Zls+p/h84X+uuY76tayI2fjjur3KRMN5Y4QBfoMjoAgvs/FoOBWLmgV3eOfU8U+7F/8fM2BOi
 QAO0Rd88UGAG4IZIyG5qgrRu5mykwp6OkCbD3HxbBBHw86zefKJBeMQ2tbcMGAyKrsI7p3z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 5 Jan 2018, Jeff King wrote:

> On Fri, Jan 05, 2018 at 09:22:07PM +0100, Johannes Schindelin wrote:
> 
> > On Fri, 5 Jan 2018, Isaac Shabtay wrote:
> > 
> > > Done: https://github.com/git-for-windows/git/pull/1421
> > > 
> > > I added credit to Jeff in the PR's description.
> > 
> > Sadly, the PR's description won't make it into the commit history, and the
> > authorship really should have been retained.
> > 
> > I found Peff's topic branch in his fork and force-pushed, to demonstrate
> > what I wanted to have. Currently the test suite is running (I test 64-bit
> > builds of the three major platforms Windows, macOS and Linux), and once
> > that is done and passed, I will merge the Pull Request.
> 
> I think the discussion has ended at "don't do anything else", but note
> that Junio and I were musing on whether to update the series around the
> dir_exists() function.

I briefly looked over this discussion and got the same impression.

> Which would then create headaches for you later when you try to merge a
> subtly-different series that makes it upstream.

Subtly-different is not a big problem. It is typically solved by `git
rebase --skip` ;-)

> Like I said, I think we've resolved not to do anything, but I wanted to
> point out a potential pitfall with this kind of "pick up a topic early"
> strategy (I'm intimately familiar with this pitfall because I do it all
> the time for the fork we run on our servers at GitHub).

Thanks for your concern.

And not to worry, I have plenty of expertise, won over the years, in
dealing with subtly different variants of patches having been accepted
upstream and conflicting with patches that were carried in Git for
Windows.

Ciao,
Dscho
