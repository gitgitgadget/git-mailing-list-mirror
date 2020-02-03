Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2931C3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A522070A
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBCIy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:54:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:51088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727491AbgBCIy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 03:54:57 -0500
Received: (qmail 1489 invoked by uid 109); 3 Feb 2020 08:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 08:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23149 invoked by uid 111); 3 Feb 2020 09:03:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 04:03:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 03:54:56 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
Message-ID: <20200203085456.GD2164@coredump.intra.peff.net>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
 <20200201110203.GA1864964@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002012205520.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 01, 2020 at 10:06:43PM +0100, Johannes Schindelin wrote:

> > > If my reading is correct, and we want `git diff-files --color` to respect
> > > the `diff.wsErrorHighlight` setting, then this patch fixes that:
> > > [...]
> > > The bigger question is whether other core developers agree with this? And
> > > what other `diff.*` settings should be respected by `git diff-files` (and
> > > of course, `git diff-index`)?
> >
> > I think you can take my posting of an identical patch elsewhere in the
> > thread as a "yes". :)
> 
> Thank you ;-)
> 
> That answer only applies to the first question, though. The second
> question, whether other `diff.*` settings would like to enjoy the same
> treatment, is still open for debate...

I hoped you would read the other part of the thread where I mused on
that same question. :)

The short of my answer is that I think the color-moved stuff might be a
candidate, but it's sufficiently different that I think it should be
decided on as a separate patch.

-Peff
