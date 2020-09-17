Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20FFC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CE9206DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgIQOwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:52:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60048 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgIQOvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:51:43 -0400
Received: (qmail 1032 invoked by uid 109); 17 Sep 2020 14:51:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 14:51:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9407 invoked by uid 111); 17 Sep 2020 14:51:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 10:51:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 10:51:42 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <20200917145142.GA3076467@coredump.intra.peff.net>
References: <20200916200203.GA37225@coredump.intra.peff.net>
 <20200917132047.GA14771@pflmari>
 <20200917133153.GA3038002@coredump.intra.peff.net>
 <20200917133525.GE8079@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917133525.GE8079@pflmari>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 03:35:25PM +0200, Alex Riesen wrote:

> Jeff King, Thu, Sep 17, 2020 15:31:53 +0200:
> > On Thu, Sep 17, 2020 at 03:20:47PM +0200, Alex Riesen wrote:
> > 
> > > Affecting the transfers initiated by fetch and push,
> > > the option allows to control network operations similar
> > > to --ipv4 and --ipv6 options.
> > > 
> > > Suggested-by: Jeff King <peff@peff.net>
> > > Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> > 
> > I think this misses some of the excellent suggestions from Junio
> > (naming, and the ability to override from the command line).
> 
> It does, sorry. Also the suggestions to the issue of consistently passing the
> options to helper programs haven't been collected.
> Haven't had the time yet.

No problem, and no rush. I just wanted to make sure those bits didn't
get overlooked.

-Peff
