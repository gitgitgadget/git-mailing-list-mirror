Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22AC41F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeI1LVj (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 07:21:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:34786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726060AbeI1LVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 07:21:39 -0400
Received: (qmail 30284 invoked by uid 109); 28 Sep 2018 04:59:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 04:59:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9962 invoked by uid 111); 28 Sep 2018 04:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Sep 2018 00:59:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2018 00:59:45 -0400
Date:   Fri, 28 Sep 2018 00:59:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v3 2/4] transport.c: extract 'fill_alternate_refs_command'
Message-ID: <20180928045945.GB25850@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <9479470cb1d5bdf8ee140d723fb913b9a95d3a32.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9479470cb1d5bdf8ee140d723fb913b9a95d3a32.1538108385.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 09:25:39PM -0700, Taylor Blau wrote:

> To list alternate references, 'read_alternate_refs' creates a child
> process running 'git for-each-ref' in the alternate's Git directory.
> 
> Prepare to run other commands besides 'git for-each-ref' by introducing
> and moving the relevant code from 'read_alternate_refs' to
> 'fill_alternate_refs_command'.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  transport.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Same as before, but moving the slightly modified code. Makes sense.

-Peff
