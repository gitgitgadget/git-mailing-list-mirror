Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139CC47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08D2206CC
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgEERHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 13:07:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:38020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729209AbgEERHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 13:07:38 -0400
Received: (qmail 13539 invoked by uid 109); 5 May 2020 17:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 17:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31787 invoked by uid 111); 5 May 2020 17:07:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 13:07:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 13:07:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] SubmittingPatches: advertise GitHub Actions CI
Message-ID: <20200505170737.GE64077@coredump.intra.peff.net>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <cover.1588695295.git.congdanhqx@gmail.com>
 <48752d8b164bc0b11f4d82016415811a0b2bf08b.1588695295.git.congdanhqx@gmail.com>
 <20200505164740.GB64077@coredump.intra.peff.net>
 <20200505165933.GC927@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505165933.GC927@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 11:59:33PM +0700, Đoàn Trần Công Danh wrote:

> > > +Alternately, you can use GitHub Actions (which supports testing your changes
> > > +on Linux, macOS, and Windows) by pushing into a branch in your fork
> > > +or opening a GitHub's Pull Request against
> > > +https://github.com/git/git.git or a fork of that repository.
> > 
> > Probably "GitHub Pull Request" would be more idiomatic English.
> 
> I guess you're right.
> 
> Well, I'm not native English speaker.
> I was thinking, this kind of Pull Request is specific to GitHub,
> and it's different from git-request-pull(1), So, I use "'s" :)

Using the possessive "'s" would imply you're talking about GitHub's
feature itself. But you're talking about "a" pull request, so I think
you want to just GitHub as an adjective, which would not generally be
possessive. English is quirky. :)

> > When I made a new repository that was not connected, I had to explicitly
> > enable Actions on the site before it would run the workflow file.
> 
> It seems like GitHub Actions will be triggered automatically if GitHub
> finds any files in "$TOPDIR/.github/workflows/*.yml"

It definitely wasn't for me. Try creating a new repo and going to the
"Actions" tab. I get a "Get Started with GitHub Actions" page. If I push
up a copy of git.git's master, then I get "Workflows aren't being run in
this repository" with a big green button to enable.

I'm just not sure if that happens for people who fork git/git instead of
making a new repo. I'm reluctant to delete and remake my fork, but I
guess it wouldn't be too hard to re-create.

I think it's OK to leave it out for now. Even if this is how it works
for a fork, it's not hard to discover what to do if you click the
Actions tab.

-Peff
