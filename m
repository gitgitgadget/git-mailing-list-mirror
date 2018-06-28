Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A48E71F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965906AbeF1Rtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:49:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965837AbeF1Rte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:49:34 -0400
Received: (qmail 22221 invoked by uid 109); 28 Jun 2018 17:49:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 17:49:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23432 invoked by uid 111); 28 Jun 2018 17:49:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 13:49:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 13:49:32 -0400
Date:   Thu, 28 Jun 2018 13:49:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: fix the "built from commit" code
Message-ID: <20180628174932.GE31766@sigill.intra.peff.net>
References: <pull.7.git.gitgitgadget@gmail.com>
 <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com>
 <20180628132314.GA14026@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 06:23:56PM +0200, Johannes Schindelin wrote:

> On Thu, 28 Jun 2018, Jeff King wrote:
> 
> > On Wed, Jun 27, 2018 at 09:35:23PM +0200, Johannes Schindelin via GitGitGadget wrote:
> > 
> > > To prevent erroneous commits from being reported (e.g. when unpacking
> > > Git's source code from a .tar.gz file into a subdirectory of a different
> > > Git project, as e.g. git_osx_installer does), we painstakingly set
> > > GIT_CEILING_DIRECTORIES when trying to determine the current commit.
> > > 
> > > Except that we got the quoting wrong, and that variable therefore does
> > > not have the desired effect.
> > > 
> > > Let's fix that quoting, and while at it, also suppress the unhelpful
> > > message
> > 
> > I had to stare at the code for a bit to figure out what was wrong:
> 
> Do you want me to update the commit message?

I'm OK either way. Probably not worth a re-roll unless you want to be
completionist about commit messages (personally I do not mind
occasionally jumping to the list archive to get historical context and
reviews).

-Peff
