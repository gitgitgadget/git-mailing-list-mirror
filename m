Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFB52018F
	for <e@80x24.org>; Sat, 16 Jul 2016 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbcGPQgX (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 12:36:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:50704 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbcGPQgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 12:36:21 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M4002-1b6NUH46Fe-00rZSB; Sat, 16 Jul 2016 18:36:04
 +0200
Date:	Sat, 16 Jul 2016 18:36:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
In-Reply-To: <20160716150835.GA24374@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607161834420.28832@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com> <alpine.DEB.2.20.1607141750190.6426@virtualbox> <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com> <alpine.DEB.2.20.1607161507250.28832@virtualbox>
 <20160716150835.GA24374@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1wNTDYIPM1OM5wlFPX/lev6t6Z0JlA0eqAxoIOW2LWjEcOajXug
 cHKpX1z4N0MxqWOmzAoQ1jV2CPSTknMUFE46i6TRX/vyrRG4OGNCXo8Wzc4KBv0Tl0RVCQ0
 ZRR/ohXwdnw09k7V4Tk109syeIxSuChX/WDAwRc1VEGUUd7ifH0vqX8sD4AurdJDohzmJ57
 Cq2mnN0xEmEo+Q09HvO8w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LFpwwGd0ecU=:mezHWGLZ2BbiCF7f4q6G//
 mtEl3OZSSeu1NEwj/kB+8/GI5G5NascVo0utGkezeRzP4yKHb2DhyGsX71jANRLnZpGZVIxm3
 zADxabaJjzzEgE/y4myQu1+d3NMXuc5Tv4ViCNXca9lUc7bLG6Zqre9mDByZE+6y83vpM0nhj
 5maxts6v5LsCLhevypjGGrZcLtjfI0QFSpBaJIOW6VxsyJ2Yd6gELcZjPv8iUcdyPs1Ot7JP4
 F2SoEdaxW5NhyTOD41fnLWY++YxDz7dCLLt7aPnFHwl9jH56MOWcXmdjIpLtqnsL3zK1O19Dg
 G5rY1np8pR5GA7vSqHDXR67l7pL7Fxz/AUU4J0GJK0dqcW0W1a5GQkooZ1b6pZqd67j+HRI3V
 Dwb4vmlQz7QII8ZMe45bKjyoqy228uKBYvz/69dg46o12NH8QAsacRmqOGS3/Rz/bqJOxR7P8
 Zx0OIxqLHa/qqFxEL4B/an7CjPHWMdrJKGCAAo60uk2QWjIdhiYtvtp4WKx7V//DaVFi4ll45
 JEhtoX/4c0DhTCmiBbLNhnyPU+dWrIFlsCBBQM40DAwkjrsP4UTGh8K3/6owPH9J2veGW4TEt
 YG0KuOpHbURl9THWXaKUw+vZLAQ9aPsybUQxYDIAik2MhWUo/keIuo2wQkNV9BeTMyeK8Yoyi
 KWEyj4zMhTz2/D+Hz1T9PeEVBJXQP7aQxhHa103fHE8p6Aj9HqUCDawCDptaknsOHxRjVwGI0
 Ls5UL04yDXvig5HHbNo3sIYtUAfDNRo+FE8znI2hRntGWLzkV41TJB4YcTYK+HRVMjI25GwbN
 8PeHWzI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Sat, 16 Jul 2016, Jeff King wrote:

> On Sat, Jul 16, 2016 at 03:30:45PM +0200, Johannes Schindelin wrote:
> 
> > As an alternative solution to your problem, you could of course avoid all
> > conditional includes. Simply by adding the include.path settings
> > explicitly to the configs that require them. Now, that would make reasoning
> > and trouble-shooting simple, wouldn't it?
> > 
> > And the most beautiful aspect of it: no patch needed.
> 
> And you can just "cat" the included files directly into your
> .git/config. We don't even need include.path. Or ~/.gitconfig, for that
> matter. But sometimes dynamic things are convenient.

Well, apparently you are not convinced by my argument. I thought it was
pretty sound, but if you disagree, it cannot have been...

So I'll shut up ;-)

Ciao,
Dscho
