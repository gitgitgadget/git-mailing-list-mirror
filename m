Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D0C209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 14:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbdINOlX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 10:41:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:38856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751277AbdINOlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 10:41:23 -0400
Received: (qmail 22060 invoked by uid 109); 14 Sep 2017 14:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 14:41:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28996 invoked by uid 111); 14 Sep 2017 14:41:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 10:41:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 10:41:20 -0400
Date:   Thu, 14 Sep 2017 10:41:20 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [PATCH v2] commit-template: change a message to be more intuitive
Message-ID: <20170914144120.oqx2trhccweiu7qo@sigill.intra.peff.net>
References: <e656d1b4-c95e-e51d-5f48-bb3450580fa4@gmail.com>
 <0102015e7b585037-5f88e775-2696-49ec-8dd9-5e1635a34607-000000@eu-west-1.amazonses.com>
 <862e71a1-2dee-4a20-d828-69a0547fa5ec@grubix.eu>
 <2480c33b-7e44-5c7c-cd31-feae9168b9dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2480c33b-7e44-5c7c-cd31-feae9168b9dc@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 07:47:51PM +0530, Kaartic Sivaraam wrote:

> > > -	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
> > > +	const char *explanation = _("Do not modify or remove the line above.\nEverything below will be removed.");
> > I don't want to complicate things. But now - due to the repeated usage
> > of "remove" - these two sentences seem to be connected by an invisible
> > "or else" ("will" vs. "would" not withstanding). i.e. "or else
> > everything below will be removed, too", which is wrong. Before, they
> > were separated more clearly.
> 
> At least I don't think they are connected by an invisible "or else" because
> they appear on different lines,

You could switch out the second "removed" for "ignored", which I think
has the same meaning but avoids repeating the same word. So:

  # ------------------------ >8 ------------------------
  # Do not modify or remove the line above.
  # Everything below will be ignored.

(I might say "everything below it" to be more precise).

I dunno. We are deep in bikeshed territory here, and I admit I don't
overly care that much in the first place.

-Peff
