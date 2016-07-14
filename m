Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE91720195
	for <e@80x24.org>; Thu, 14 Jul 2016 07:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbcGNHus (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 03:50:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:52863 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbcGNHur (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 03:50:47 -0400
Received: from virtualbox ([89.204.154.227]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lta9E-1bDno72KuK-010xGP; Thu, 14 Jul 2016 09:50:35
 +0200
Date:	Thu, 14 Jul 2016 09:50:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqqvb09z5p7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607140945520.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <20160712140427.GB613@sigill.intra.peff.net> <alpine.DEB.2.20.1607131329510.6426@virtualbox> <xmqqlh1534qk.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607132105091.6426@virtualbox>
 <xmqqvb09z5p7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MMTOAgaGpldtJkDOBISry7MLriMEtt9Y0+3AwwiTeLrIVASPDa/
 4HmwmaqhnduVkcVo9Fku44FCjWIxyzVAFhKMQSnhnReQSZtaT5RULqJTDeAlSp6p0WML57s
 ocMDb5wqIQ925YDwa2QHcCb4ZGIuKG1LRdoQn+QfR9iRevJY4iewKUmuiABFyFYBUB4hEnN
 zIJq8l4Z/vzyzrXdaQNQA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fETQiXVPX7Y=:Ggs3oWQiC/40WDmnr3oenN
 AGUHcOerZDRFmey4+eloHCsMpriGbtRQjWpF2x+DDS4a6z6dZ+fs4pTnCn5oYEhZCe2SBi3t+
 WxU17vhq/oaQik3ZV3UlpYiFxQp30Z7U6ykxSsbq/OWSfyAQIkpIREzWxWg0dYUbZyTR/bgLu
 FduU9Rj8iDcqAI11gceIbFsrtCdXe9gmh7qGIvzInl1fVuUG/pvdp+eN75OBJ9QRMtooa0Yb5
 Xj/mWr5C5u3DibhN1wd7Cw0JhAbJgvOVd3PB396/4yaeH3g83cBkQ44HcGQP++KlZZoD/0d7G
 NiDgXnExKN6wH/x+CcaiHnCWIbbtsVozk4GYRWXn8bxeVYBu52Sx8kPtgTDIftG05a0N9mEJN
 +ApWK47dEXXVOoVprL0maJPPMonfAcRjcxF8EA6S4Pin32UjOS+wPSG9ZlumyBI4qbc9DMV/g
 fTkLqlZkAHKB0/6yI2s/6ZwCEPPw745ohq0zOtv2bnXeNLaI6NnM9RM8fR39qtk3C6C2T740e
 9Y3KF+0/cc/Va73jDZnyVSPgxuBlOyelYbcp9D1Q4K+I26+bgAQDAhHNSN2DhRBas4IaQi1Zs
 6AY3gCWhc/Is6cjDPBq5Quza0rGWZqVwm/kOaVF2XkE01O1NBNwLtReWEA4gnibWE4UycRN/V
 4Y50+L/yAlmJntvs2sfFM36qNw64mNUCoan0u3iWa+ORLWNbLPrZic4my7RMV2zKrGEd1DDQb
 nSYV24jY1nKXH6OAtou8YnL7WQL5rlgiKhJMvacxB24XaJ0VhSbf0zbUqUTDQkaPzdYrvxv2o
 78kDu+b
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I was hoping to hear from you sooner and do v2.9.2 with your t0006
> >> workaround with lazy-prereq changes from Peff (i.e. "Makes sense!"
> >> above), so that you do not have to do two releases in a row (i.e.
> >> skipping v2.9.1 saying "Git for Windows skipped that one because it
> >> was not quite right; this release fixes the issue" in your v2.9.2
> >> announcement).
> >
> > I am sorry that you expected me to be more available. It is a pretty
> > crazy week already (and trying to get a Git for Windows v2.9.1 out of
> > the door after dropping everything else on Tuesday morning added quite
> > a bit to the load), so I am at times unable to even read the Git
> > mailing list.
> 
> Actually these back-and-forth was an attempt to help you reduce the load
> by not having to worry about the t0006 workaround.  Checking your inbox
> would have been quicker than writing another of your own version.

In this instance, you're correct. I made it a habit of not checking the
inbox at all when in the zone, though. Certainly when the time zone
difference virtually guarantee that your work hours and mine do not
overlap (the announcement of Git v2.9.1 arrived around 4h after I logged
off for the day, for example).

> > As I am more concerned with Jeff Hostetler's patch now (the "very
> > verbose porcelain status"; I merged the Pull Request after seeing no
> > comments on his mail, but then Peff provided some good feedback, so
> > now I am not quite certain how to go about it: revert, or wait if the
> > 2nd iteration is acceptable and take that), so I am not immediately
> > releasing any version, anyway.
> 
> As I said, I'd be waiting for a reroll of that to queue on 'pu', but as
> a new feature, it won't appear in any of the v2.9.x releases.

Yes, the feature will appear in some v2.9.x release: in Git for Windows.

Ciao,
Dscho
