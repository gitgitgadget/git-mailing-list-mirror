Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F2020A21
	for <e@80x24.org>; Wed, 13 Sep 2017 11:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdIMLUU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 07:20:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:36502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752025AbdIMLUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 07:20:16 -0400
Received: (qmail 32465 invoked by uid 109); 13 Sep 2017 11:20:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 11:20:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12924 invoked by uid 111); 13 Sep 2017 11:20:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 07:20:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 07:20:13 -0400
Date:   Wed, 13 Sep 2017 07:20:13 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] commit-template: change a message to be more intuitive
Message-ID: <20170913112013.sk7bqarq2ktrva67@sigill.intra.peff.net>
References: <20170912105536.6094-1-kaarticsivaraam91196@gmail.com>
 <20170913102915.GA21499@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913102915.GA21499@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 12:29:15PM +0200, Kevin Daudt wrote:

> On Tue, Sep 12, 2017 at 04:25:36PM +0530, Kaartic Sivaraam wrote:
> > It's not possible to 'touch' the cut-line that is shown when the
> > user requests a patch in his commit template.
> > 
> 
> Touching something can also mean to disturb or change something, which
> is the meaning being used here, so it is not an incorrect use of the
> word.
> 
> > So, make the sentence more intuitive.
> 
> I can understand however that it might be not so clear for people with
> less fluency in English.

I agree with both of your points. It is very clear to me as a native
speaker, but I can see how it might not be for everyone.

Interestingly, the change here:

> > -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
> > +	const char *explanation = _("Do not edit the line above.\nEverything below will be removed.");

actually seems less clear to me. I think of "edit" as "modify". But
obviously it also should not be removed. Perhaps

  Do not modify or remove the line above.

would be the most clear. Or perhaps it is overly verbose.

-Peff
