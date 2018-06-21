Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CA11F516
	for <e@80x24.org>; Thu, 21 Jun 2018 17:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeFURp0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 13:45:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:50908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932844AbeFURpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 13:45:25 -0400
Received: (qmail 31864 invoked by uid 109); 21 Jun 2018 17:45:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Jun 2018 17:45:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8364 invoked by uid 111); 21 Jun 2018 17:45:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Jun 2018 13:45:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2018 13:45:23 -0400
Date:   Thu, 21 Jun 2018 13:45:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
Cc:     git-mailing-list <git@vger.kernel.org>
Subject: Re: Git not creating new directory when cloning
Message-ID: <20180621174523.GB30249@sigill.intra.peff.net>
References: <CAKepmagD1VgRx+79rS9Swe8OL8SOwvRn6Yn-u_FCUy-OCUMeFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKepmagD1VgRx+79rS9Swe8OL8SOwvRn6Yn-u_FCUy-OCUMeFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 12:04:11PM -0400, Jack Adrian Zappa wrote:

> Hi, I was trying to clone a repo into a non-existent directory. but it
> gave me a failure:
> 
> $  git clone  https://github.com/jelera/vim-javascript-syntax.git
> ~/.vim/bundle/vim-javascript-syntax
> fatal: destination path
> '/home/username/.vim/bundle/vim-javascript-syntax' already exists and
> is not an empty directory.

That exact command works just fine for me. Are you absolutely sure that
the directory did not exist?

Which version of Git are you using?

> > The name of a new directory to clone into. The "humanish" part of
> > the source repository is used if no directory is explicitly given
> > (repo for /path/to/repo.git and foo for host.xz:foo/.git). Cloning
> > into an existing directory is only allowed if the directory is
> > empty.
> 
> Which to me, implies that the directory doesn't have to exist prior to
> cloning.  So is this a bug or a misunderstanding?

Correct, in general it should _not_ exist.

-Peff
