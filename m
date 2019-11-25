Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E1C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A80207FD
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfKYOaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:30:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:59972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727666AbfKYOaY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:30:24 -0500
Received: (qmail 26452 invoked by uid 109); 25 Nov 2019 14:30:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 14:30:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19024 invoked by uid 111); 25 Nov 2019 14:34:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 09:34:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 09:30:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
Message-ID: <20191125143023.GF494@sigill.intra.peff.net>
References: <20191109020037.GB60198@google.com>
 <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
 <20191113011020.GB20431@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
 <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
 <20191121105414.GA16238@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 02:50:05PM +0100, Johannes Schindelin wrote:

> > Wow, thanks for working on this! I don't know that I'd call my
> > javascript skills even rudimentary, but I did give it a look. The real
> > challenge to me is not the individual lines of code, but understanding
> > how the Azure Pipelines and GitHub App systems fit together. So I didn't
> > see anything wrong, but I also know very little about those systems.
> 
> I actually spent some quality time with the wiki in the past days to
> remedy that. You can adore the result in all its beauty here:
> 
> https://github.com/gitgitgadget/gitgitgadget/wiki/GitGitGadget's-Azure-Function-and-Azure-Pipelines

Thanks, this was very informative. I have a feeling that some of this
could be done via the new Actions stuff that GitHub has been shipping,
but I have no idea if it would make any of it easier (and certainly I'm
not advocating dropping a working system to chase a new shiny toy).

> All I need is to install the app:
> [...]
> ... which I just did.

Very cool. :)

-Peff
