Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791081F404
	for <e@80x24.org>; Tue, 14 Aug 2018 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHNRun (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:50:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728880AbeHNRun (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:50:43 -0400
Received: (qmail 24924 invoked by uid 109); 14 Aug 2018 15:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 15:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22876 invoked by uid 111); 14 Aug 2018 15:03:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 11:03:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 11:03:10 -0400
Date:   Tue, 14 Aug 2018 11:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Thomas Rast via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v6 11/21] range-diff: add tests
Message-ID: <20180814150309.GD3441@sigill.intra.peff.net>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
 <pull.1.v6.git.gitgitgadget@gmail.com>
 <1477c58e4c0c9e1d5836ffcb9bcb7360b1a5df0d.1534159977.git.gitgitgadget@gmail.com>
 <20180813183504.GD13316@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1808141652460.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808141652460.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 04:53:51PM +0200, Johannes Schindelin wrote:

> > > These are essentially lifted from https://github.com/trast/tbdiff, with
> > > light touch-ups to account for the command now being named `git
> > > range-diff`.
> [...]
> > Just noticed while reading the whole series again (hopefully for the
> > last time :)), do we need Thomas Rast's Sign-off here, as he is
> > credited as the author here? 
> 
> Hmm. I hoped that my commit message was enough to indicate that while he
> is the author, I assembled this. Maybe I should move him to the footer, as
> an Original-Authored-By:?

I think the "Author" field is actually distinct from the copyright
provenance. In this case it ought to be perfectly fine to add your
signed-off-by under the DCO's point b:

  The contribution is based upon previous work that, to the best
  of my knowledge, is covered under an appropriate open source
  license and I have the right under that license to submit that
  work with modifications [...]

This is based on the tests in tbdiff, which is explicitly GPL'd by
Thomas. So your signoff certifies that, which is fine.

As for the author field, IMHO it serves two purposes:

  - to give credit where it is due

  - so that people digging in history know who to contact for
    questions/problems

In this case it probably makes sense for it to be you, as you'd take
responsibility for the code in _this_ project. And as you note, you can
give credit in the commit message (the only unfortunate thing is that
most automated statistics would not credit Thomas, but in theory they
could by mentioning him in the trailer).

-Peff
