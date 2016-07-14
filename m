Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7FE20196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbcGNSlu (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:41:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:44805 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751161AbcGNSlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:41:49 -0400
Received: (qmail 9586 invoked by uid 102); 14 Jul 2016 18:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:41:49 -0400
Received: (qmail 7094 invoked by uid 107); 14 Jul 2016 18:42:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:42:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 14:41:46 -0400
Date:	Thu, 14 Jul 2016 14:41:46 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, dwwang@google.com,
	e@80x24.org, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCHv5 0/4] Push options
Message-ID: <20160714184146.GE16497@sigill.intra.peff.net>
References: <20160714173920.22001-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160714173920.22001-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 10:39:16AM -0700, Stefan Beller wrote:

> Jeff wrote:
> > Junio wrote:
> >> I think those extra knobs can come later.  If we are not going to
> >> limit with max_options in the end, however, wouldn't it be more
> >> natural for the initial iteration without any configuration not to
> >> have hard-coded max_options at all?
> >
> > Yeah, I am OK with adding restrictive knobs later as a separate topic.
> > As Stefan notes, upstream does not have the other knobs anyway, and IIRC
> > the push-options feature is not even enabled by default.
> 
> * now it actually is not a default. ;)

Hmm. So that is a downside for people who have implemented separate DoS
protection only in that upgrading git will open a new "hole" that they
need to plug. But that is their problem, not upstream git's.

-Peff
