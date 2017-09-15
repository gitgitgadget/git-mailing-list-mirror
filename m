Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F4020286
	for <e@80x24.org>; Fri, 15 Sep 2017 07:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdIOHAF (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 03:00:05 -0400
Received: from ikke.info ([178.21.113.177]:52198 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbdIOHAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 03:00:04 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A97A444012D; Fri, 15 Sep 2017 08:43:24 +0200 (CEST)
Date:   Fri, 15 Sep 2017 08:43:24 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
Message-ID: <20170915064324.GC21499@alpha.vpn.ikke.info>
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915063740.GB21499@alpha.vpn.ikke.info>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 08:37:40AM +0200, Kevin Daudt wrote:
> On Thu, Sep 14, 2017 at 09:43:12PM -0500, A. Wilcox wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> > 
> > Hi there,
> > 
> > While bumping Git's version for our Linux distribution to 2.14.1, I've
> > run in to a new test failure in t6500-gc.sh.  This is the output of
> > the failing test with debug=t verbose=t:
> 
> This is a new test introduced by c45af94db 
> (gc: run pre-detach operations under lock, 2017-07-11) which was
> included in v2.14.0.
> 
> So it might be that this was already a problem for a longer time, only
> just recently uncovered.
> 

Adding Jeff King to CC
