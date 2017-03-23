Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B41A20964
	for <e@80x24.org>; Thu, 23 Mar 2017 23:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756750AbdCWXt1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 19:49:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50717 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755029AbdCWXt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 19:49:27 -0400
Received: (qmail 30714 invoked by uid 109); 23 Mar 2017 23:49:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 23:49:25 +0000
Received: (qmail 12860 invoked by uid 111); 23 Mar 2017 23:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 19:49:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 19:49:22 -0400
Date:   Thu, 23 Mar 2017 19:49:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170323234922.ot2vqblcnljacdtn@sigill.intra.peff.net>
References: <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
 <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
 <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
 <20170322223441.w32y464jqbnxnzna@LykOS.localdomain>
 <20170322224124.u3eax4ui3y4saxks@sigill.intra.peff.net>
 <20170322225108.wub4bmr63hk2sp33@LykOS.localdomain>
 <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfui3ac2f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 03:00:08PM -0700, Junio C Hamano wrote:

> Santiago Torres <santiago@nyu.edu> writes:
> 
> > This sounds like a helpful addition to implement. We could update/add
> > tests for compliance on this once the feature is addded and fix the
> > ambiguous behavior in the tests now.
> 
> OK, so has everybody agreed what the next step would be?  Is the
> patch below a good first step (I still need to get it signed off)?

Yeah, I think this is the right fix.

> -- >8 --
> Subject: t7004, t7030: fix here-doc syntax errors
> From: Santiago Torres <santiago@nyu.edu>
> 
> Jan Palus noticed that some here-doc are spelled incorrectly,
> resulting the entire remainder of the test as if it were data
> slurped into the "expect" file, e.g. in this sequence

I had trouble parsing this. Perhaps:

  resulting in the entire remainder of the test snippet being slurped
  into the "expect" file as if it were data

-Peff
