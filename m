Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A68C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3A20665
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfK0UEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:04:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55230 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfK0UEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:04:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9804A1F463;
        Wed, 27 Nov 2019 20:04:21 +0000 (UTC)
Date:   Wed, 27 Nov 2019 20:04:21 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over public-inbox.org
Message-ID: <20191127200421.GA27456@dcvr>
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <20191127125343.GA27983@sigill.intra.peff.net>
 <20191127125936.GA9877@dcvr>
 <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 27 Nov 2019, Eric Wong wrote:
> > Jeff King <peff@peff.net> wrote:
> > > Since lore.kernel.org now has the same archive as public-inbox.org and
> > > may have more longevity going forward[1], let's recommend people use it
> > > for finding or referencing messages.
> > >
> > > [1] https://public-inbox.org/git/20191120195556.GA25189@dcvr/
> > >       or if you like:
> > >     https://lore.kernel.org/git/20191120195556.GA25189@dcvr/
> 
> One of the things I appreciate most about https://public-inbox.org/git is
> that you can clone it. I just tried this with
> https://lore.kernel.org/git/...
> 
> $ git clone https://lore.kernel.org/git/  lore-git
> Cloning into 'lore-git'...
> warning: You appear to have cloned an empty repository.

Oops, that's a usability issue I hope to fix at some point.

> Is this something other people also care about?

Instructions are actually at the bottom:

   git clone --mirror https://lore.kernel.org/git/0 git/git/0.git

The "0" is the "epoch", and larger repos have multiple epochs,
roughly 1GB each. https://lore.kernel.org/lkml/ has 0..7, right now.
