Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7579A202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 12:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbdCLMra (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 08:47:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:42833 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755727AbdCLMr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 08:47:29 -0400
Received: (qmail 30502 invoked by uid 109); 12 Mar 2017 12:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 12:47:27 +0000
Received: (qmail 12543 invoked by uid 111); 12 Mar 2017 12:47:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 08:47:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 08:47:25 -0400
Date:   Sun, 12 Mar 2017 08:47:25 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [RFC PATCH] help: add optional instructions for reporting bugs
Message-ID: <20170312124725.ogwame2nm72maffy@sigill.intra.peff.net>
References: <20170309193050.19988-1-sbeller@google.com>
 <20170310181342.GE26789@aiede.mtv.corp.google.com>
 <CAP8UFD0xCCcmd66ChsfxPBFohekucBx3ib4Ayi+KQOXNZFHMjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0xCCcmd66ChsfxPBFohekucBx3ib4Ayi+KQOXNZFHMjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 10:50:50PM +0100, Christian Couder wrote:

> I don't think it's a good idea to add those "hint: ..." and
> "reporting-bugs: ..." lines.
> 
> I think it's better to do things like the following:
> 
> - add `git version -h`
> - add proper documentation for `git version` so that `git help version` works
> - in `git help version` talk about the REPORTING BUGS section in `git help git`
> - add `git version --full` or other such options to also print other
> stuff like the current OS, processor architecture, libc, etc
> - suggest in `git help version` and/or in the REPORTING BUGS section
> in `git help git` that people just copy paste the output of `git
> version --full` in their bug report

I wonder if a "gitbugs(7)" manpage would be a good thing. Then "git help
bugs" would find it.

That still leaves open the question of whether people would find that
documentation, but at least it is less buried than being at the bottom
of the git(1) page.

-Peff
