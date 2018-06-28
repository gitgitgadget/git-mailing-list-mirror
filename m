Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F73C1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967727AbeF1SRz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:17:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:58700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966275AbeF1SRy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:17:54 -0400
Received: (qmail 23463 invoked by uid 109); 28 Jun 2018 18:17:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 18:17:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23883 invoked by uid 111); 28 Jun 2018 18:18:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 14:18:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 14:17:51 -0400
Date:   Thu, 28 Jun 2018 14:17:51 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: curious about wording in "man git-config", ENVIRONMENT
Message-ID: <20180628181751.GA3693@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1806260608270.6007@localhost.localdomain>
 <20180626124316.GA15419@sigill.intra.peff.net>
 <alpine.LFD.2.21.1806261250280.6102@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1806261250280.6102@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 12:51:45PM -0400, Robert P. J. Day wrote:

> > I agree it's weird. I think it's trying to mean "behaves as if it
> > was set to", but with the additional notion that the command-line
> > argument would take precedence over the environment (which is our
> > usual rule). But then we should just say those things explicitly.
> >
> > Just looking at mentions of GIT_CONFIG in that manpage and knowing
> > the history, I think:
> 
>   ... snip ...
> 
> i'm just going to admit that i don't quite have the background to know
> how to submit a patch to tidy things up based on Jeff's analysis, so
> I'm going to leave this to someone higher up the food chain.

There's some related discussion going on in:

  https://public-inbox.org/git/20180627045637.13818-1-tmz@pobox.com/

I think it makes sense to wait for that to settle and then I may try to
build on top.

-Peff
