Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A05E1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754812AbeBGUOX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:14:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:44194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754266AbeBGUOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:14:19 -0500
Received: (qmail 28369 invoked by uid 109); 7 Feb 2018 20:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 20:14:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2084 invoked by uid 111); 7 Feb 2018 20:15:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 15:15:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 15:14:17 -0500
Date:   Wed, 7 Feb 2018 15:14:17 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
Message-ID: <20180207201417.GB9141@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41>
 <20180207172902.GL1427@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1802071500220.14248@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1802071500220.14248@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 03:03:31PM -0500, Robert P. J. Day wrote:

>   huh ... well, that raises the question, if tla has been unbuildable
> for that long (possibly for other distros), what is the value in
> continuing to support git-archimport?
> 
>   https://www.kernel.org/pub/software/scm/git/docs/git-archimport.html

I don't think that we do really support archimport. It's just that we
tend to leave things sitting around if they're not actively causing us
work, in the off chance that somebody might find them useful.

I'd be OK with declaring archimport dead and unmaintained, and dropping
it totally (I almost did so a few months ago when it _did_ cause me
extra work, because it contained a bunch of shell injections that I
turned up while auditing the whole code base).

-Peff
