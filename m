Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905A01F461
	for <e@80x24.org>; Wed, 26 Jun 2019 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZSIX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 14:08:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:51390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726271AbfFZSIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 14:08:23 -0400
Received: (qmail 4481 invoked by uid 109); 26 Jun 2019 18:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jun 2019 18:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32504 invoked by uid 111); 26 Jun 2019 18:09:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Jun 2019 14:09:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2019 14:08:21 -0400
Date:   Wed, 26 Jun 2019 14:08:21 -0400
From:   Jeff King <peff@peff.net>
To:     "Pugh, Logan" <Logan.Pugh@austintexas.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "liu.denton@gmail.com" <liu.denton@gmail.com>
Subject: Re: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Message-ID: <20190626180821.GA23857@sigill.intra.peff.net>
References: <20190625213545.GA23411@sigill.intra.peff.net>
 <BL0PR0901MB4466FF7338C085ADBBF594898AE30@BL0PR0901MB4466.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR0901MB4466FF7338C085ADBBF594898AE30@BL0PR0901MB4466.namprd09.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 11:09:08PM +0000, Pugh, Logan wrote:

> > Or in your case I suppose even better would just be an
> > option like "--if-not-configured-just-use-regular-diff". Then it would
> > do what you want, without impacting users who do want the interactive
> > setup.
> 
> If such an option was considered I would be in favor of it. Maybe call 
> it "--no-tutorial" or perhaps "--diff-fallback".
> 
> But having fixed my app, I'm content with the status quo too, now.

Yeah, those are definitely better names. :)

I think we're on the same page about a good path forward, then. I don't
plan to work on this myself, but maybe it would be a good #leftoverbits
candidate for somebody wanting to get started on modifying Git.

-Peff
