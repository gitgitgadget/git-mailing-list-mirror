Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05FBF20248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBVPa4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:30:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:54520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725892AbfBVPa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:30:56 -0500
Received: (qmail 1860 invoked by uid 109); 22 Feb 2019 15:30:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 15:30:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28986 invoked by uid 111); 22 Feb 2019 15:31:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 10:31:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 10:30:54 -0500
Date:   Fri, 22 Feb 2019 10:30:54 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Suggestion] Add Skip for t9020
Message-ID: <20190222153054.GD21524@sigill.intra.peff.net>
References: <004b01d4ca23$faebcad0$f0c36070$@nexbridge.com>
 <20190221205837.GX16125@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221205837.GX16125@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 03:58:37PM -0500, Todd Zullinger wrote:

> > While this is a bit of a hack, it might be useful for skipping t9020 in
> > environments where the svn.remote package is not installed. I can make this
> > into a patch if this style is reasonable - guessing probably not and that
> > the REMOTE_SVN test should go elsewhere if it is called that.
> 
> Jeff King sent an RFC patch which would remove this test and
> the rest of the vcs-svn experiment in August[1].  Jonathan
> Nieder replied as one user who would rather see it moved to
> contrib/, so it was held off.
> 
> Whether that has any impact on adding a way to skip all the
> tests here, I don't know.  Maybe it's a gentle nudge in
> favor of moving them to contrib?

I still hoped we could ditch them completely. :) As part of my
-Wunused-parameter patches, I found that was an easy way to get rid of
some warnings. But I'd be OK if they were in contrib/, too.

-Peff
