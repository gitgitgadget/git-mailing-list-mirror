Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AC91F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 11:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdBCL6U (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 06:58:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:48761 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdBCL6T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 06:58:19 -0500
Received: (qmail 20818 invoked by uid 109); 3 Feb 2017 11:58:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 11:58:18 +0000
Received: (qmail 26198 invoked by uid 111); 3 Feb 2017 11:58:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 06:58:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2017 12:58:15 +0100
Date:   Fri, 3 Feb 2017 12:58:15 +0100
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Eric Wong <e@80x24.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-scm.com status report
Message-ID: <20170203115814.vxn33ivuhrnxmkzf@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170202043610.GA12738@starla>
 <CAJZjrdUGsp5-HsA0Hxk4Qo+2s6crLbu-LuX=ECuC2QpM6HCWgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdUGsp5-HsA0Hxk4Qo+2s6crLbu-LuX=ECuC2QpM6HCWgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2017 at 12:54:53AM -0600, Samuel Lijin wrote:

> In theory, you could also dump the build artifacts to a GH Pages repo
> and host it from there, although I don't know if you would run up
> against any of the usage limits[0]. The immediate problem I see with
> that approach, though, is that I have no idea how any of the dynamic
> stuff (e.g. search) would be replaced.

I've talked with Pages people and they say it shouldn't be a big deal to
host. The main issue is that it's not _just_ a static site. It's a site
that's static once built, but a lot of the content is auto-generated
from other sources (git manpages, Pro Git and its translations, etc).

So there's work involved in moving that generation step to whatever the
new process is (it's fine if it's running "make" locally after a Git
release and pushing up the result).

> A question: there's a DB schema in there. Does the site still use a DB?

It does use the database to hold all of the bits that aren't checked
into Git. So renderings of the manpages, the latest release git version,
etc. AFAIK, it's all things that I would be comfortable committing into
a git repository.

-Peff
