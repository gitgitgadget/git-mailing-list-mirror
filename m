Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40EF2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdJCXMq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:12:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751135AbdJCXMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:12:45 -0400
Received: (qmail 25774 invoked by uid 109); 3 Oct 2017 23:12:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 23:12:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12932 invoked by uid 111); 3 Oct 2017 23:12:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 19:12:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 19:12:42 -0400
Date:   Tue, 3 Oct 2017 19:12:42 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     git@vger.kernel.org
Subject: Re: "man git-config", "--list" option misleadingly refers to "config
 file" (singular)
Message-ID: <20171003231242.oem4equq6cvicxcw@sigill.intra.peff.net>
References: <20171003063434.Horde.nbQwMWrv0wS_naxhawU5YlG@crashcourse.ca>
 <20171003134954.cptlpaipmiulfgug@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710031653360.8461@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710031653360.8461@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 04:54:32PM -0400, Robert P. J. Day wrote:

> > It does that by default, or it lists the contents of a specific file
> > if given (either by --file, or with --system, --global, or --local).
> >
> > So I agree it's not quite accurate, but you probably want some
> > phrasing that leaves this unsaid (the actual rules are described
> > earlier in the description section). Maybe just refer to it as the
> > "config source" or something?
> 
>   i think the simplest phrasing is, "List all variables set in the
> current configuration, along with their values."
> 
>   sound fair?

Yes, sounds reasonable to me.

-Peff
