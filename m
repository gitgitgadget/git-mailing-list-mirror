Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BEA20248
	for <e@80x24.org>; Thu, 18 Apr 2019 16:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbfDRQBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 12:01:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:33934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733067AbfDRQBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 12:01:18 -0400
Received: (qmail 2413 invoked by uid 109); 18 Apr 2019 16:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 16:01:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2114 invoked by uid 111); 18 Apr 2019 16:01:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 12:01:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 12:01:16 -0400
Date:   Thu, 18 Apr 2019 12:01:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
Message-ID: <20190418160115.GA8054@sigill.intra.peff.net>
References: <pull.168.git.gitgitgadget@gmail.com>
 <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
 <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
 <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
 <20190415145042.GA27540@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904181505520.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904181505520.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 03:06:56PM +0200, Johannes Schindelin wrote:

> > What about command-line options that influence the outcome? It sounds
> > like this is the same problem we have in lots of other places (like say,
> > compiler flags being updated), that we solve by generating the proposed
> > file output unconditionally and comparing it to what's on disk.  E.g.,
> > see the way GIT-CFLAGS or GIT-BUILD-OPTIONS is generated.
> 
> *Sigh*
> 
> I really did not want to do that because I thought it would be tedious and
> more complicated and result in a longer patch.
> 
> Well, don't you know. The patch is actually *a lot* shorter now. So much
> so that range-diff thinks it is a different commit ;-)

:) Great. I looked at the result in your v2 and it looks good to me.

-Peff
