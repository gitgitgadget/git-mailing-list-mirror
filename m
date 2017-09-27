Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800862047F
	for <e@80x24.org>; Wed, 27 Sep 2017 18:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbdI0SBa (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 14:01:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:52326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751263AbdI0SB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 14:01:29 -0400
Received: (qmail 21977 invoked by uid 109); 27 Sep 2017 18:01:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 18:01:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17444 invoked by uid 111); 27 Sep 2017 18:02:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 14:02:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 14:01:27 -0400
Date:   Wed, 27 Sep 2017 14:01:27 -0400
From:   Jeff King <peff@peff.net>
To:     Toni Uebernickel <tuebernickel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20170927180127.khwqwmv74tsji5im@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
 <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 07:28:49PM +0200, Toni Uebernickel wrote:

> The previous version was v2.13.2.
> I switched back to this version, and it works perfectly fine; without any changes to my system.

Thanks for confirming.

There aren't a lot of changes to the script between v2.13.2 and v2.14.2.
The most plausible culprit is d5addcf522 (add--interactive: handle EOF
in prompt_yesno, 2017-06-21), but I'm scratching my head over how that
could cause what you're seeing.

Are you able to build Git from source and bisect the problem? It would
help to know which commit introduced the problem.

-Peff
