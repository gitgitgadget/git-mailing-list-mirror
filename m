Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F2E1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeBGM4w (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 07:56:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:43512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753478AbeBGM4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 07:56:51 -0500
Received: (qmail 6769 invoked by uid 109); 7 Feb 2018 12:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 12:56:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29855 invoked by uid 111); 7 Feb 2018 12:57:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 07:57:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 07:56:49 -0500
Date:   Wed, 7 Feb 2018 07:56:49 -0500
From:   Jeff King <peff@peff.net>
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
Message-ID: <20180207125649.GA16018@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
 <CACsJy8Dt_TjfRk05oNW8DXrdn6s_QV8NQZKnnrgGkj3WTN_=3A@mail.gmail.com>
 <CAPMsMoAOX-c+w6OUaZ-hZ9ideE=K_4UYp7eHO4wcEESm-Z0z6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMsMoAOX-c+w6OUaZ-hZ9ideE=K_4UYp7eHO4wcEESm-Z0z6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 11:34:51AM +0000, pedro rijo wrote:

> The command list under https://git-scm.com/docs doesn't show all the
> commands. It's a manually curated list as we can see at
> 
> - https://github.com/git/git-scm.com/blob/master/app/views/doc/ref.html.erb
> - https://github.com/git/git-scm.com/tree/master/app/views/shared/ref
> 
> I'm not sure if the goal ever was to list all available commands or to just
> list some important existing commands (cc @Peff).
>
> If we want to list all available commands, there's some work that must be
> done in order to automate that, since it's not feasible to manually add
> each new command.

I think we _could_ just add all commands, but there's some value in
organizing them. I'm not sure if there's enough information in git.git
to do that organization. But we could also have a curated list of some
subset of the commands, and then dump the rest in an alphabetized index.

-Peff
