Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1842B2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 13:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbcGFNQk (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 09:16:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:60220 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078AbcGFNQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 09:16:39 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfmZs-1axleQ1ytQ-00NCxu; Wed, 06 Jul 2016 15:16:10
 +0200
Date:	Wed, 6 Jul 2016 15:16:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Michael J Gruber <git@drmicha.warpmail.net>
cc:	Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Over-/underquoting, was Re: [PATCH] revert: clarify seemingly bogus
 OPT_END repetition
In-Reply-To: <d1e0e688-a309-2a01-4ee2-c1af9d71cea0@drmicha.warpmail.net>
Message-ID: <alpine.DEB.2.20.1607061514200.6426@virtualbox>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de> <20160705202820.GA14496@sigill.intra.peff.net> <20160705204447.GB14496@sigill.intra.peff.net> <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
 <alpine.DEB.2.20.1607060857240.6426@virtualbox> <d1e0e688-a309-2a01-4ee2-c1af9d71cea0@drmicha.warpmail.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NkL4xF65SSLiWn598iZBztjcgg46tmtQ/CpPf+nUCpIfkFnO27s
 1ymdLqVzFpCFLRX2vEjLEUzKeECsFFaBURl9kj24QVu6/N7Jsr9NrBUF0M1VIU2Ig1g2CNA
 QiJDULHsCRR0Dro8X3muKW85sQvKZZYmtWyDoHyTAkJXXq+o2lBytbVUVSoiISRYWSTwa7f
 tRExjow/I3yUq2IeA2Q8g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XOPj9NvrWB8=:JD4QjinmQJJo+7rHH3hurl
 oTAR2fyTbIeKKgfOQooChiqv26uMZ+5ih/XupgfigR4EbrbR2PxNtVOqEnOIyMI2dMSAutkIJ
 9QmdP7TC8Jkj/OhK1skOR6l3jFI57O0DJqj9cT6yyau5ubGnyobQF8K/2J8hBUrhMyT8a2PGS
 yrY23VI39lmI8rYu6J1L3hDi1uT2aP6K9XShpq1Aqr3GydSGMIY8Q137c1r+ypbgbd4rESZGY
 EKMnhL5kdIlI/FeaMRTGUko9unAe3ygIOYwiSrDy1d3iRCjsKLL1vqKRueCR28pRZML+sKgtU
 ygeMG/kbPBT1tkI3TzD1yANZVQeWLaubve07irbEDm9ONIKJL264Lz4KoXy2zPTR0osufffGk
 u2lxmuj/F2SQHxNxbbDSocrrrtzzYIAHRVzAGAKWjGMgNkTxHwpPfC0Q8XAd3jRGE/K62sRDC
 u3gtgs16wniOOUTzWPxDcWYmpcTdFKHdtQ7kyk93fQSMcOrzCXfY9y37/zzqeFuITwfQXQ4l3
 VALE2B3L2FCZujEr84E4jkfUko3qbLlgy0TQmh9ncSICf+d4hWZdJ3GX/WKa/qi+ekvEaXnCY
 dyqesSHiQbeDkKEFM1BZdc+0X6S8P3DLOjYwEG2aSzxm8+23tyeJcfEtJDVPDoxbQNZSMOE/p
 U6csxzhrM5vcSwXBTHGGSTvzbgrLFidBwQI2icl/KtqthwFsPLyv3/eo7bw3tXzqFvCqPIgOk
 1bicNOAQdI/Hv3o54kKsdwwB3AogefPUFg6tww1wUVtOP+4qGuPX/K1RJkJUzxE7/Oo6PdW7t
 Bj/AeMF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Michael,

On Wed, 6 Jul 2016, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 06.07.2016 09:01:
> 
> > BTW Jacob, would you terribly mind cutting the quoted parts properly (I
> > cut 112 lines)? It may not seem like much, but I seem to spend more and
> > more of my email time budget on skimming unaddressed remainders of quoted
> > mails, and I would much rather spend that time on something productive.
> 
> OTOH, I often have to look up the original message because people cut
> too much, or because they take one sentence out of context.

And others quote too much. In your case, the reference to Peff's patch was
not at all what you referred to.

> It is not unheard of that a MUA can collapse and expand properly quoted
> parts on request...

Sure. Show me some kick-ass, scriptable mail client and I will have a
look.

Ciao,
Johannes
