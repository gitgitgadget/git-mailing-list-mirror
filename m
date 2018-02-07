Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D891F404
	for <e@80x24.org>; Wed,  7 Feb 2018 12:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeBGMyX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 07:54:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:43506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753539AbeBGMyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 07:54:23 -0500
Received: (qmail 6656 invoked by uid 109); 7 Feb 2018 12:54:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 12:54:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29834 invoked by uid 111); 7 Feb 2018 12:55:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 07:54:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 07:54:15 -0500
Date:   Wed, 7 Feb 2018 07:54:15 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
Message-ID: <20180207125415.GA16314@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
 <87eflxyqrn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eflxyqrn.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 12:37:32PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >   however, while there is no link for the "worktree" command, there
> > does in fact exist a similarly-named web page
> > https://git-scm.com/docs/git-worktree.
> 
> It is an official site, of the git project. The project is legally
> managed by the SFC which owns the domain, Github happens to host it (for
> free) for us.

Actually, this isn't accurate anymore. The costs are covered by
donated services from a few companies. I've been meaning to write this
up (and thank them!), and will probably send something out around the
contributor summit.

> It's not fully auto-generated so stuff like git-worktree doesn't get
> added automatically, I just added a PR for that:
> https://github.com/git/git-scm.com/pull/1133

Thanks for doing that. I'm also open to auto-generating the index if we
can come up with well-organized output.

-Peff
