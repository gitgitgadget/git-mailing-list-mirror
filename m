Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6193C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831FF2075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKZV4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:56:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57038 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfKZV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 16:56:49 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1AD371F463;
        Tue, 26 Nov 2019 21:56:49 +0000 (UTC)
Date:   Tue, 26 Nov 2019 21:56:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
Message-ID: <20191126215648.GA18872@dcvr>
References: <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
 <20191113011020.GB20431@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
 <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
 <20191121105414.GA16238@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
 <20191125143023.GF494@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The biggest obstacle is that at least one of those Pipelines requires
> access to a clone of public-inbox.org/git, and cloning that is rather
> expensive. Even a shallow fetch would be super expensive, by virtue of
> _all_ the mails being blobs reachable from the tip commit's tree.

Fwiw, lore.kernel.org/git/$EPOCH.git ought to be somewhat cheaper,
but it's a different (more scalable) format which requires SQLite:

	https://public-inbox.org/public-inbox-v2-format.html

https://lore.kernel.org/git

(and I'm not going to pay extortionist .org fees to keep
 public-inbox.org when it comes up for renewal in 2023,
 maybe everyone can use Tor .onions by then :> )
