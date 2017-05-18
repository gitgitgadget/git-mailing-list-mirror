Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D692027D
	for <e@80x24.org>; Thu, 18 May 2017 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934024AbdERPmQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 11:42:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:54253 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934008AbdERPmO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 11:42:14 -0400
Received: (qmail 10454 invoked by uid 109); 18 May 2017 15:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 15:42:02 +0000
Received: (qmail 18118 invoked by uid 111); 18 May 2017 15:42:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 11:42:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 11:42:00 -0400
Date:   Thu, 18 May 2017 11:42:00 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-scm.com status report
Message-ID: <20170518154159.s2ysocfzlf2ffgqg@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
 <CAJZjrdXCYwbH4wtY44UiEQii+r47a-coTwLd0qYzhV3VZwyd1A@mail.gmail.com>
 <20170517020334.ncp3c6meak4mkp2j@sigill.intra.peff.net>
 <469A925D-E5E4-4B9D-8AE2-A23DBA3595AE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <469A925D-E5E4-4B9D-8AE2-A23DBA3595AE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 02:06:16PM +0200, Lars Schneider wrote:

> > I haven't ever tried to do this in the local development environment.
> > The production site currently just use a cloud-hosted ES (Bonsai). They
> > have free "Sandbox" plans for testing, so you could probably use that as
> > a test resource after setting up the relevant environment variables. Or
> > alternatively, I think ElasticSearch folks produce binary builds you can
> > try, and you could host locally.
> > 
> > There's a rake job that inserts documents into the search index (see
> > lib/tasks/search.rake).
> 
> Disclaimer: I am jumping in here without much knowledge. Feel free
> to ignore me :-)
> 
> In our TravisCI builds we create the AsciiDoc/Doctor documentation
> already. Couldn't we push that result to some static hosting service?
> Would that help in any way with git-scm.com?

Not really. The site builds the asciidoctor documentation already via an
automated job. This question was just about putting it into the search
index (which also happens in production with an automated job; this is
just about setting up the search database).  So I don't think there's
any real problem to be solved with respect to generating pages.

-Peff
