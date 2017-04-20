Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924DF207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947063AbdDTVGO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:06:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:37246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946895AbdDTVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:06:12 -0400
Received: (qmail 1879 invoked by uid 109); 20 Apr 2017 21:06:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:06:12 +0000
Received: (qmail 9577 invoked by uid 111); 20 Apr 2017 21:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:06:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:06:10 -0400
Date:   Thu, 20 Apr 2017 17:06:10 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
Message-ID: <20170420210610.lxfc6kqrsq5i67nz@sigill.intra.peff.net>
References: <20170420205214.GB4989@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420205214.GB4989@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 09:52:14PM +0100, Thomas Gummerer wrote:

> I just tried to run the test suite with GIT_TEST_SPLIT_INDEX=YesPlease
> and noticed that a few tests are broken both in pu and master.
> [...]
> Bisecting between master and v2.10.0 leads me to the merge commit
> 94c9b5af70 ("Merge branch 'cc/split-index-config'", 2017-03-17).

Hmm. It looks like the fix from:

  http://public-inbox.org/git/20170329080820.8084-1-chriscool@tuxfamily.org/

hasn't been merged yet. That would possibly explain the problems on
master, but I think it _is_ in pu. So maybe this is something else.

-Peff
