Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DFD1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeJWEZ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:25:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:49508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725758AbeJWEZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:25:59 -0400
Received: (qmail 11284 invoked by uid 109); 22 Oct 2018 20:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Oct 2018 20:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9071 invoked by uid 111); 22 Oct 2018 20:05:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Oct 2018 16:05:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2018 16:06:01 -0400
Date:   Mon, 22 Oct 2018 16:06:01 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
Message-ID: <20181022200601.GC9917@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-3-peartben@gmail.com>
 <045b78ce-230e-86fe-6e5a-684bf9e93fbc@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <045b78ce-230e-86fe-6e5a-684bf9e93fbc@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 08:13:32PM +0100, Ramsay Jones wrote:

> >  -q::
> >  --quiet::
> > -	Be quiet, only report errors.
> > +--no-quiet::
> > +	Be quiet, only report errors. The default behavior respects the
> > +	`reset.quiet` config option, or `--no-quiet` if that is not set.
> 
> Sorry, I can't quite parse this; -q,--quiet and --no-quiet on the
> command line (should) trump whatever rest.quiet is set to in the
> configuration. Is that not the case?

That is the case, and what was meant by "the default behavior" (i.e.,
the behavior when none of these is used). Maybe there's a more clear way
of saying that.

-Peff
