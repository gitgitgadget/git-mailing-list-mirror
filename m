Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FA120401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdFUTbK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:31:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:47894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751093AbdFUTbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:31:10 -0400
Received: (qmail 6463 invoked by uid 109); 21 Jun 2017 19:31:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 19:31:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26747 invoked by uid 111); 21 Jun 2017 19:31:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 15:31:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 15:31:07 -0400
Date:   Wed, 21 Jun 2017 15:31:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        David Turner <dturner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] docs: update 64-bit core.packedGitLimit default
Message-ID: <20170621193107.pqjti44pc6xiip4u@sigill.intra.peff.net>
References: <20170420204118.17856-1-dturner@twosigma.com>
 <20170420210254.f4ykyi46bso5uj3o@sigill.intra.peff.net>
 <20170621135130.6724hnoovcjfduto@sigill.intra.peff.net>
 <CAGZ79kZLcNdN0TsrHwm8YoAXx7tjWoWV29j=xyQFgUuNPouUOw@mail.gmail.com>
 <20170621180618.6yc433nwpi4d5wof@sigill.intra.peff.net>
 <xmqqvanpp4n5.fsf@gitster.mtv.corp.google.com>
 <20170621185307.xu6rcnj2y3jvdati@sigill.intra.peff.net>
 <xmqqefudp2n3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefudp2n3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 12:22:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Of course, the best alternative is retaining access to the packs, which
> > is what typically happens now on 64-bit systems (it's just that the
> > packedGitLimit was set pointlessly low). I'm not sure if you're asking
> > in general, or as a last-ditch effort for 32-bit systems.
> 
> As the last-ditch effort for 32-bit boxen.  But at this point in
> time we probably do not care about them too deeply?

Right, that was my general feeling. Especially as this is an issue only
for people hosting large and very active repositories (so "upgrade to a
better platform" is an easier pill to swallow for a few servers rather
than the whole of the Git population).

-Peff
