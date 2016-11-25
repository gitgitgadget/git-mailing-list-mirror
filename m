Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E1F203EC
	for <e@80x24.org>; Fri, 25 Nov 2016 17:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933052AbcKYRmC (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 12:42:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:60550 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933018AbcKYRmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 12:42:00 -0500
Received: from virtualbox ([95.208.59.208]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6fXs-1cxsBr1UxQ-00wVLB; Fri, 25
 Nov 2016 18:41:31 +0100
Date:   Fri, 25 Nov 2016 18:41:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611251841030.117539@virtualbox>
References: <cover.1479938494.git.johannes.schindelin@gmx.de> <cover.1480019834.git.johannes.schindelin@gmx.de> <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de> <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ecUrUIil3fHNHbRs7+MRuu833fO92c4rBbc+Iapzn8gLyHMskp4
 cAUwaFSL/XOi6dc4oRQqJBXCBU5/spbjVqMNlj2D2uHeZRj+/KsXzNmbb4qMkBPYekaRlfR
 Gh3XzcrH2A0pMxZQAKaA4V3Pt4Z87KdARK2iDjYISlL4Iy9C9NXL4ob+k9Td6KIdeaW3xOV
 DZuVWEeltn5pj0maggq5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PA3b9zSAXuM=:ci6Ub8wmRFGIW3D9/qBbMU
 rhYr14HFZ/mEN8HBK0/1GCQTS/UBXUGjzZpEBbCofyqfMj6on0lKnPw2hyuIBkojoq8K3B9+u
 g4pbkzV1GE6ibKU+6vhqL2NxCvo6Dsmu43kBBcAtg7HHLLJ1qbOhgRGewEsuYFgTsu7bbbwHz
 ZQqwdxBn0YCWpig0lvpY6yr/mJ2q4apWPYqe2gyKhEb7lkus9kUtbubRZNGJt7J6FgOmmLdhX
 g8/cGEclV/LjhtxTeFmHM3EDg9jz/g+oqsGXcwpCxbRGaqpHjO+0FrUC2SlN6TXjyOmz8XKff
 Ncn25qgaJq7drcg2SOEZLM+PPJm7N+AmHQP8WX4LSYMTjGZ2eUGu800284VHO8+HyfGFT6YZ5
 b5NfwjlmdU12vgB1spBMOC46KyJCj7k5+aF/2JZ+ezbT6GgSYSRLUVQ9zikoxeJAtjjE1JPtG
 SWTi4D/6aaFtJpiSUagDXQo3PZy71PV4jrVI+8dlZ2x53vzZZVLPttGV9lvl1fZgPNtJFwSU8
 XaP6/61lBDo+92e9Xk40tEHIFpBUT3TBaHAp4yKVuugg70MwS0Ti8DXTjuAaLSPtcv0DzUzlG
 /06ytz38fsKHWNpAF7Fkfh7JGN1Wt07UPLXPwEDlU0OMonVCLYn5MYnCBWFXf2yOYaMpKsSf9
 VtRGqYJ419jwRvgNFWK7GQEdVwpIBjkof2h5lpIlldRIXRGkluSwDaNshiAnlWHSLjCKUzemj
 kb2r9Pg8L6r8FMuPO1MpVcN78bW2b+t5TgHBYbIVzXLTwbl5kzlBSHr49xTju4JboNIWlOxZL
 VyvLrqc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 25 Nov 2016, Jeff King wrote:

> On Fri, Nov 25, 2016 at 12:05:00PM +0100, Johannes Schindelin wrote:
> 
> > > I would have expected it to just be a build-time flag, like:
> > > 
> > >   make BUILTIN_DIFFTOOL=Yes test
> > 
> > That works for Git developers.
> > 
> > I want to let as many users as possible test the builtin difftool.
> > Hopefully a lot more users than there are Git developers.
> > 
> > Which means that I need a feature flag in production code, not a build
> > time flag.
> 
> Ah, I didn't realize that was a requirement. If this is going to be part
> of a release and real end-users are going to see it, that does make me
> think the config option is the better path (than the presence of some
> file), as it's our standard way of tweaking run-time behavior.

So how do you easily switch back and forth between testing the old vs the
new difftool via the test suite?

Ciao,
Dscho
