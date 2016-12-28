Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67211FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 06:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbcL1GnA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 01:43:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:60895 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbcL1Gm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 01:42:59 -0500
Received: (qmail 4953 invoked by uid 109); 28 Dec 2016 06:42:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 06:42:58 +0000
Received: (qmail 16126 invoked by uid 111); 28 Dec 2016 06:43:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 01:43:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 01:42:55 -0500
Date:   Wed, 28 Dec 2016 01:42:55 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Javantea <jvoss@altsci.com>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, aneesh.kumar@gmail.com
Subject: Re: Gitview Shell Injection Vulnerability
Message-ID: <20161228064255.f4akjdsq24r2hqn7@sigill.intra.peff.net>
References: <20161227082922.8B7A813893D@mail.altsci.com>
 <CAGZ79kbOjpi4SBLPVaKXJ+L8VN+0N=ZqgDcHeYydkKsS20yR1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbOjpi4SBLPVaKXJ+L8VN+0N=ZqgDcHeYydkKsS20yR1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 10:45:58AM -0800, Stefan Beller wrote:

> > I expect that things that start their life in the contrib/ area
> > to graduate out of contrib/ once they mature, either by becoming
> > projects on their own, or moving to the toplevel directory.  On
> > the other hand, I expect I'll be proposing removal of disused
> > and inactive ones from time to time.
> 
> Maybe it's time for a spring cleanup and remove some old (dead?)
> projects from contrib?

Yeah, that was my thought on reading the vulnerability report: "that's
still around?". Looks like it hasn't had a substantive commit since
2007. But I dunno, maybe it's just finished, and doesn't need any more
changes. :)

-Peff
