Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B703208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdHaShm (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 14:37:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750996AbdHaShm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 14:37:42 -0400
Received: (qmail 20252 invoked by uid 109); 31 Aug 2017 18:37:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Aug 2017 18:37:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30926 invoked by uid 111); 31 Aug 2017 18:38:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Aug 2017 14:38:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Aug 2017 14:37:35 -0400
Date:   Thu, 31 Aug 2017 14:37:35 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git-scm pages deliver outdated Git docs
Message-ID: <20170831183734.6sukpdpvi23h3d7v@sigill.intra.peff.net>
References: <21957FF0-CABA-4B93-8BD0-42EE28197395@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21957FF0-CABA-4B93-8BD0-42EE28197395@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2017 at 09:28:35AM +0100, Lars Schneider wrote:

> looks like the git-scm pages deliver outdated Git docs (v2.13.1):
> https://git-scm.com/docs/git
> 
> Is this intentional? If not, who should be contacted?

The docs are up-to-date (and a cron job keeps them updated when there
are new releases). I think the issue is just one of presentation. That
manpage in particular hasn't been updated since v2.13.1, so that's the
highest field in the version dropdown. If you switch to:

  https://git-scm.com/docs/git-status

for instance, you'll see "v2.14.0 | git-status last updated in 2.14.0".
It's actually sucked in v2.14.1 (you can tell because that's what's
mentioned as the latest version on the front page), but there were no
manpages updated between v2.14.0 and v2.14.1.

So I think all is working as intended, though there may be room for
improvement in the text used at the top.

I'm happy to take patches here, or you can open an issue or PR at

  https://github.com/git/git-scm.com

-Peff
