Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A7C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F2E2068E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0Chq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:37:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54468 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfK0Chp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:37:45 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 513871F463;
        Wed, 27 Nov 2019 02:37:45 +0000 (UTC)
Date:   Wed, 27 Nov 2019 02:37:45 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
Message-ID: <20191127023745.GA15031@dcvr>
References: <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
 <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
 <20191121105414.GA16238@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
 <20191125143023.GF494@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
 <20191126215648.GA18872@dcvr>
 <xmqqa78iw0f8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa78iw0f8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > (and I'm not going to pay extortionist .org fees to keep
> >  public-inbox.org when it comes up for renewal in 2023,
> >  maybe everyone can use Tor .onions by then :> )
> 
> Just on this tangent.  Would you be willing to keep the domain and
> keep the service running, if Git Project Leadership Committee pays
> the fee out of the funds we keep at Software Freedom Conservancy?

Maybe...  I'm against the *principle* of paying extortionists;
and I don't think the Git project should encourage them, either.

Promoting + developing a Distributed Hash Table (DHT) for
Message-ID (and git OID) lookups to fight against centralization
would be a better use of time and funds :>

However, if EFF and other .orgs prove effective in keeping
prices reasonable then that's fine, I guess.  I personally
expect to be financially worse off in 2023 than I was in 2013
when I bought the domain, so some help there could be nice :)

The actual cost of running a service is only $20/month in VPS
hosting.  It's a business expense at the moment as I hack on
that machine for clients, and I'm trying to make public-inbox
cheaper and easier to host, too.

But, https://lore.kernel.org/git/ has professionals behind it
and is more scalable.  It's currently missing syntax
highlighting and blob regeneration because that's a PITA to
configure, though...
