Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93ED91F428
	for <e@80x24.org>; Thu, 30 Aug 2018 08:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeH3MUp (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:20:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:33702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727622AbeH3MUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:20:45 -0400
Received: (qmail 14704 invoked by uid 109); 30 Aug 2018 08:19:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 08:19:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24740 invoked by uid 111); 30 Aug 2018 08:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 04:19:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 04:19:45 -0400
Date:   Thu, 30 Aug 2018 04:19:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180830081945.GB10224@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
 <20180830033000.GD665@sigill.intra.peff.net>
 <20180830072049.dgsjn3537xzo6qcm@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830072049.dgsjn3537xzo6qcm@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 07:20:49AM +0000, Eric Wong wrote:

> > At the very least, I think if we plan to reference without an http URL
> > that we would use something like URI-ish, like <mid:ABC@XYZ>. That gives
> > tools a better chance to say "OK, I know how to find message-ids"
> > (though I still think that it's much less helpful out of the box
> > compared to an http URL).
> 
> That would be awesome if somelike like <mid:ABC@XYZ> could be a
> standard and adopted (likewise with <git:$object_id>).
> 
> I haven't checked, but are there existing/similar RFCs?
> Surely somebody has tried to get <git:$object_id>
> adopted by now, right?

There's https://tools.ietf.org/html/rfc2392. They even call it "mid:".  :)

I don't know of any git URI scheme, though it's similar in spirit to
magnet: links. Those are a bit verbose, though, because they're really a
meta-format for a bunch of different content-addressable schemes.

-Peff
