Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 383C1202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 12:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdJ2MCa (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 08:02:30 -0400
Received: from ikke.info ([178.21.113.177]:42332 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdJ2MCa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 08:02:30 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 603E94403A2; Sun, 29 Oct 2017 13:02:28 +0100 (CET)
Date:   Sun, 29 Oct 2017 13:02:28 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] builtin/describe: describe blobs
Message-ID: <20171029120228.GA6065@alpha.vpn.ikke.info>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171028004506.10253-1-sbeller@google.com>
 <20171028004506.10253-3-sbeller@google.com>
 <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
 <CAGZ79kYpPga-aWmJYXCXT1WyvfeEKnwXEXxq2E0YNYanhUw-Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYpPga-aWmJYXCXT1WyvfeEKnwXEXxq2E0YNYanhUw-Xw@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 08:28:54PM -0700, Stefan Beller wrote:
> On Sat, Oct 28, 2017 at 10:32 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > 
> > [..]
> > I wonder whether it would make sense to extend this to tree objects while
> > we are at it, but maybe that's an easy up-for-grabs.
> 
> I can look into incorporating that, too. What is the use case though?
> (Is there any error message, common enough that users want to
> identify trees?)
> 
> Thanks for the review,
> Stefan

Not sure if it's really helpfulp, but sometimes with corrup repos, git
would complain about a certain object missing or corrupt, where it might
be usefull to find out how it's referenced. Not sure though if this
would work in that case, because the repo is already corrupt.

Kevin
