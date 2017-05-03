Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F29B207F8
	for <e@80x24.org>; Wed,  3 May 2017 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbdECUEI (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 16:04:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:44859 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932481AbdECUDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 16:03:49 -0400
Received: (qmail 12750 invoked by uid 109); 3 May 2017 20:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 20:03:47 +0000
Received: (qmail 27729 invoked by uid 111); 3 May 2017 20:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 May 2017 16:04:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 May 2017 16:03:45 -0400
Date:   Wed, 3 May 2017 16:03:45 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Cloning a custom refspec does not work as expected
Message-ID: <20170503200345.mjxvcv4o4wce3ddr@sigill.intra.peff.net>
References: <CAHGBnuMUrNFv30d+pjheiCAikM89XshQTFuDXBzu+EcxNY_94w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHGBnuMUrNFv30d+pjheiCAikM89XshQTFuDXBzu+EcxNY_94w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2017 at 02:16:47PM +0200, Sebastian Schuberth wrote:

> I'd assume that this would work:
> 
> $ git clone -c remote.origin.fetch=+refs/changes/*:refs/remotes/origin/changes/*
> https://gerrit.googlesource.com/git-repo
> 
> In fact, this *does* add the custom refs correct to .git/config, but
> they are not fetched during the clone. I can manually fix that by
> doing
> 
> $ cd git-repo
> $ git fetch
> 
> afterwards, but the whole point is to avoid exactly that separate step.
> 
> Is this a code bug or documentation bug?

I think it's a code bug. More discussion in:

  http://public-inbox.org/git/robbat2-20170225T185056-448272755Z@orbis-terrarum.net/

-Peff
