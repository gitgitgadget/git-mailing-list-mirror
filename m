Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3DDD1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 04:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJDLBh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 07:01:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726730AbeJDLBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 07:01:37 -0400
Received: (qmail 28832 invoked by uid 109); 4 Oct 2018 04:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 04:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21405 invoked by uid 111); 4 Oct 2018 04:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 00:09:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 00:10:18 -0400
Date:   Thu, 4 Oct 2018 00:10:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] drop vcs-svn experiment
Message-ID: <20181004041018.GA1526@sigill.intra.peff.net>
References: <20180817190310.GA5360@sigill.intra.peff.net>
 <20180818052605.GA241538@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180818052605.GA241538@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 10:26:05PM -0700, Jonathan Nieder wrote:

> > Of course, I could be completely wrong about people using this. Maybe
> > svn-fe builds are just completely broken on my system, and maybe people
> > really do use testsvn::. But if so, they certainly aren't talking about
> > it on the mailing list. :)
> 
> My take:
> 
>  - svn-fe works fine and has been useful to me, though its Makefile
>    could likely be simplified and made more user-friendly
> 
>  - I've benefited from the test coverage of having this in-tree
> 
>  - testsvn:: is a demo and at a minimum we ought not to install it
>    with "make install"
> 
>  - keeping this in-tree for the benefit of just one user is excessive,
>    so removing it is probably the right thing
> 
>  - it would be nice if the commit removing this code from Git includes
>    a note to help people find its new home
> 
> Would you mind holding off until I'm able to arrange that last bit?

Any further thoughts / movement on this? Not urgent, but I saw you
mention it in another thread, and it's on my "to be decided" pile.

-Peff
