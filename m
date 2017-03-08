Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E00202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 14:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbdCHOBP (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 09:01:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:40436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753634AbdCHOBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 09:01:14 -0500
Received: (qmail 22483 invoked by uid 109); 8 Mar 2017 14:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 14:01:12 +0000
Received: (qmail 519 invoked by uid 111); 8 Mar 2017 14:01:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 09:01:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 09:01:11 -0500
Date:   Wed, 8 Mar 2017 09:01:11 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
Message-ID: <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net>
 <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 02:43:00PM +0100, Sebastian Schuberth wrote:

> > Hrm. Isn't "all" the default? That's what git-diff(1) says (but I've
> > never used the feature myself).
> >
> > That would imply to me that there's another config option set somewhere
> > (perhaps in the repo-level config). What does:
> >
> >   git config --show-origin --get-all diff.ignoresubmodules
> >
> > say?
> 
> It says:
> 
> file:/home/seschube/.gitconfig  all

OK, that looks right, so my guess is probably the wrong direction.
Peeking at the code, it looks like there may be some per-submodule
magic, but I don't know how it all works. So I'll stop looking and wait
for somebody more clueful to respond.

-Peff
