Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C94320226
	for <e@80x24.org>; Thu,  4 Aug 2016 07:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbcHDHMz (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 03:12:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:54588 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932102AbcHDHMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 03:12:54 -0400
Received: (qmail 11010 invoked by uid 102); 4 Aug 2016 07:06:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:06:09 -0400
Received: (qmail 10456 invoked by uid 107); 4 Aug 2016 07:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:06:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 03:06:04 -0400
Date:	Thu, 4 Aug 2016 03:06:04 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/8] xdl_change_compact(): rename some local variables
 for clarity
Message-ID: <20160804070604.ggxjqibryqtrwntn@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ea7d76b1a97f3ab8d83ed8ba7570c2bec1195501.1470259583.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea7d76b1a97f3ab8d83ed8ba7570c2bec1195501.1470259583.git.mhagger@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:00:29AM +0200, Michael Haggerty wrote:

> * ix -> i
> * ixo -> io
> * ixs -> start
> * grpsiz -> groupsize

After your change, I immediately understand three of them. But what is
"io"?

-Peff
