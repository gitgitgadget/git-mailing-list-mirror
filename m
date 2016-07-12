Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122B81FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 14:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbcGLOGI (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 10:06:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:43462 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751769AbcGLOGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 10:06:07 -0400
Received: (qmail 4399 invoked by uid 102); 12 Jul 2016 14:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 10:06:07 -0400
Received: (qmail 2979 invoked by uid 107); 12 Jul 2016 14:06:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 10:06:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 10:06:03 -0400
Date:	Tue, 12 Jul 2016 10:06:03 -0400
From:	Jeff King <peff@peff.net>
To:	Anders Kaseorg <andersk@mit.edu>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712140603.GC613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <57843C98.7020200@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57843C98.7020200@mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 08:40:56PM -0400, Anders Kaseorg wrote:

> On 07/11/2016 07:54 PM, Jeff King wrote:
> > Yes, that's somewhat the point of the test.
> > 
> > How does it fail for you (what does it look like with "-v")? We may be
> > able to check for an outcome that matches both cases.
> 
> On Ubuntu i386 and Ubuntu armhf, I get the following verbose output from
> t0006-date.sh:
> 
> 
> expecting success:
> 		echo "$time -> $expect" >expect &&
> 		test-date show:$format "$time" >actual &&
> 		test_cmp expect actual
> 	
> --- expect	2016-07-11 23:20:55.835136188 +0000
> +++ actual	2016-07-11 23:20:55.835136188 +0000
> @@ -1 +1 @@
> -5758122296 -0400 -> 2152-06-19 18:24:56 -0400
> +5758122296 -0400 -> 2038-01-18 23:14:07 -0400

Thank you for this, by the way. Your comment got drowned out by the rest
of the thread, but this would have been very helpful for me in writing a
patch (fortunately Dscho beat me to it, so I did not have to. :) ).

-Peff
