Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F208B1F453
	for <e@80x24.org>; Wed,  1 May 2019 20:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEAUfs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 16:35:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726125AbfEAUfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 16:35:47 -0400
Received: (qmail 24698 invoked by uid 109); 1 May 2019 20:35:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 20:35:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22473 invoked by uid 111); 1 May 2019 20:36:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 16:36:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 16:35:45 -0400
Date:   Wed, 1 May 2019 16:35:45 -0400
From:   Jeff King <peff@peff.net>
To:     Priscila Gutierres <priscila.gutierres@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jean-Noel Avila <jn.avila@free.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Contributing with documentation/translation
Message-ID: <20190501203545.GA13372@sigill.intra.peff.net>
References: <CAHtYWY4g4BYDr_z7pfS-p=aX_YkVo4HzGR1Dsytn4RkzBo0GjA@mail.gmail.com>
 <CACsJy8DHH_PqZ9DQ5jpA_4AuLmVXmt3F3x6nYVGqZ1pNWnC5+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DHH_PqZ9DQ5jpA_4AuLmVXmt3F3x6nYVGqZ1pNWnC5+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 05:11:38PM +0700, Duy Nguyen wrote:

> On Wed, May 1, 2019 at 1:10 AM Priscila Gutierres
> <priscila.gutierres@gmail.com> wrote:
> >
> > Hi
> > I want to contribute to git by creating and/or translating
> > documentation. Where may I find the info to do this?
> 
> For translation, you could start at po/README. That's mostly UI
> translation. I think some team actually started document translation
> too [1], but I don't know the status.

+cc Jean-Noel, who is working on this. It looks like translations will
be done through Weblate:

  https://hosted.weblate.org/projects/git-manpages/translations/

There's some more discussion in:

  https://public-inbox.org/git/1992944.NOdEsaAZKb@cayenne/

There are also translations of the "Pro Git" book. This isn't strictly
"Git documentation", but it is CC-licensed and we show it on
git-scm.com. Details are at:

  https://github.com/progit/progit2/blob/master/TRANSLATING.md

-Peff
