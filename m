Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB56208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeHHRgs (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:36:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727081AbeHHRgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:36:48 -0400
Received: (qmail 30781 invoked by uid 109); 8 Aug 2018 15:16:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Aug 2018 15:16:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25865 invoked by uid 111); 8 Aug 2018 15:16:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 Aug 2018 11:16:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2018 11:16:40 -0400
Date:   Wed, 8 Aug 2018 11:16:40 -0400
From:   Jeff King <peff@peff.net>
To:     Brady Trainor <mail@bradyt.com>
Cc:     git@vger.kernel.org
Subject: Re: Page content is wider than view window
Message-ID: <20180808151639.GA1607@sigill.intra.peff.net>
References: <20180808035854.49D69E450E@mailuser.nyi.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180808035854.49D69E450E@mailuser.nyi.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 07, 2018 at 08:58:51PM -0700, Brady Trainor wrote:

> If I am reading the git book or manual (https://git-scm.com/), and zoom
> in, and/or have browser sized to a fraction of the screen, I cannot see
> all the text, and have to horizontally scroll back and forth to read at
> that zoom.
> 
> This may also be for smaller laptop screens, so those with larger
> desktop monitors may not see this often.
> 
> Can site designer consider this in layout?

Yes, there's work happening already for a visual refresh of the site,
including making the whole thing much more responsive to size changes.
See:

  https://github.com/git/git-scm.com/pull/1179

which shows the work-in-progress, but has stalled a bit lately.

-Peff
