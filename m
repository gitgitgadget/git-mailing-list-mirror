Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29BD1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 07:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKNHlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 02:41:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:47206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725852AbfKNHlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 02:41:18 -0500
Received: (qmail 22714 invoked by uid 109); 14 Nov 2019 07:41:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 07:41:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1745 invoked by uid 111); 14 Nov 2019 07:44:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 02:44:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 02:41:17 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Should we auto-close PRs on git/git?
Message-ID: <20191114074117.GB17186@sigill.intra.peff.net>
References: <20191109020037.GB60198@google.com>
 <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
 <20191113011020.GB20431@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 01:04:35PM +0100, Johannes Schindelin wrote:

> > We talked a while ago about having GitGitGadget operate on git/git,
> > rather than on a separate mirror. That would automatically help at least
> > one class of PR-opener: people who want their patches to reach the list
> > but didn't realize they should be using gitgitgadget/git.
> >
> > I don't remember what the technical blockers are for getting that set
> > up, but it seems like a strictly nicer outcome than auto-closing their
> > PR.
> 
> Okay, here are a couple of technical challenges, off the top of my head:
> [...]
> Not an easy, nor a small project, I am afraid.

Yow. That's a lot more involved than I was hoping for.

Thanks for writing it up. Some of the points raised were interesting. I
do think we'd want git/git (the repository) to remain read-only if
possible. If GitHub's permissions model is a limiting factor here, let
me know and I can try to bring it to the attention of the right people.

-Peff
