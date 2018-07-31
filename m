Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9239C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeGaWWU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:22:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726580AbeGaWWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:22:20 -0400
Received: (qmail 5153 invoked by uid 109); 31 Jul 2018 20:40:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 20:40:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5732 invoked by uid 111); 31 Jul 2018 20:40:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 16:40:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 16:40:13 -0400
Date:   Tue, 31 Jul 2018 16:40:13 -0400
From:   Jeff King <peff@peff.net>
To:     George Shammas <georgyo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, l.s.r@web.de,
        git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180731204012.GB9442@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
 <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
 <20180731172304.GA16977@sigill.intra.peff.net>
 <20180731190459.GA3372@sigill.intra.peff.net>
 <CAF1Ko+FHsvmqzwVHh+fEnk=UGUftNW8VkFwaWTSKu3xYprb+wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF1Ko+FHsvmqzwVHh+fEnk=UGUftNW8VkFwaWTSKu3xYprb+wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 03:52:26PM -0400, George Shammas wrote:

> This is the fastest I ever seen an open source project respond to an issue
> I reported. Thanks for being awesome!

You're welcome. My speed is an inverse to how embarrassingly long we
carried the bug for. ;)

> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  match-trees.c | 43 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)

Sorry, I meant to actually add a:

  Reported-by: George Shammas <georgyo@gmail.com>

here.

-Peff
