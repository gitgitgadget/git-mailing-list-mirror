Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D461F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKMBKV (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:10:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:46040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726979AbfKMBKV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:10:21 -0500
Received: (qmail 10525 invoked by uid 109); 13 Nov 2019 01:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Nov 2019 01:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21141 invoked by uid 111); 13 Nov 2019 01:13:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 20:13:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 20:10:20 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Should we auto-close PRs on git/git?
Message-ID: <20191113011020.GB20431@sigill.intra.peff.net>
References: <20191109020037.GB60198@google.com>
 <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 08:11:06PM +0100, Johannes Schindelin wrote:

> > To that end, I wonder if we should add an Action to automatically
> > close PRs on that repo. It looks like
> > https://github.com/dessant/repo-lockdown would do the trick. We could
> > close incoming PRs automatically with a kind, maybe more succinct or
> > prescriptive version of the prefill text encouraging folks to open the
> > exact same PR against gitgitgadget/git instead.
> 
> I am rather certain that that would not be a good thing to do.
> 
> There are some people who open git/git PRs solely for the PR builds,
> others to facilitate code review, and yet others just because it is the
> intuitively obvious way to contribute to Git.

We talked a while ago about having GitGitGadget operate on git/git,
rather than on a separate mirror. That would automatically help at least
one class of PR-opener: people who want their patches to reach the list
but didn't realize they should be using gitgitgadget/git.

I don't remember what the technical blockers are for getting that set
up, but it seems like a strictly nicer outcome than auto-closing their
PR.

-Peff
