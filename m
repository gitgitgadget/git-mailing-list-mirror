Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC5C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24B32086A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbgBKT43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:56:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:57866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727955AbgBKT42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:56:28 -0500
Received: (qmail 9471 invoked by uid 109); 11 Feb 2020 19:56:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 19:56:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1513 invoked by uid 111); 11 Feb 2020 20:05:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 15:05:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 14:56:27 -0500
From:   Jeff King <peff@peff.net>
To:     Aleksey Midenkov <midenok@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git tedious verbosity
Message-ID: <20200211195627.GF2127797@coredump.intra.peff.net>
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
 <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
 <20200211195549.GE2127797@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211195549.GE2127797@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 02:55:49PM -0500, Jeff King wrote:

> On Tue, Feb 11, 2020 at 05:19:53PM +0300, Aleksey Midenkov wrote:
> 
> > Nice info, thanks. Does that disable maintenance messages like:
> > 
> > Updated 1 path from the index
> 
> I don't think it does. Usually how this works is that we add new
> messages which we think might be helpful, enable them by default (since
> users aren't likely to find out about them if they never see them!), and
> then if they turn out to be annoying or verbose, add an advice.* config
> option to allow people to avoid them.
> 
> The message quoted above is a relatively new one, and I don't think it's
> hit that third step yet. Patches welcome. :)

Oh, and if you want to see the complete list, look for "advice.*" in
"git help config".

-Peff
