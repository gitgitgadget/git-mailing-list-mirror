Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6DAC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E096A2078D
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgEEQrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:47:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:37940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729119AbgEEQrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:47:41 -0400
Received: (qmail 13404 invoked by uid 109); 5 May 2020 16:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 16:47:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31480 invoked by uid 111); 5 May 2020 16:47:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 12:47:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 12:47:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] SubmittingPatches: advertise GitHub Actions CI
Message-ID: <20200505164740.GB64077@coredump.intra.peff.net>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <cover.1588695295.git.congdanhqx@gmail.com>
 <48752d8b164bc0b11f4d82016415811a0b2bf08b.1588695295.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48752d8b164bc0b11f4d82016415811a0b2bf08b.1588695295.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 11:26:39PM +0700, Đoàn Trần Công Danh wrote:

> From 889cacb689 (ci: configure GitHub Actions for CI/PR, 2020-04-11),
> GitHub Actions was introduced as an alternative CI system for Git
> project.
> 
> Let's advertise it to Git's contributors to help them test Git on
> various platforms before submitting to Git.

I think this makes sense. Two things:

> +Alternately, you can use GitHub Actions (which supports testing your changes
> +on Linux, macOS, and Windows) by pushing into a branch in your fork
> +or opening a GitHub's Pull Request against
> +https://github.com/git/git.git or a fork of that repository.

Probably "GitHub Pull Request" would be more idiomatic English.

Do people need to enable Actions on their forks for the branch push to
work? I didn't need to for my fork of git/git, but I'm not sure if that's
because I was playing with Actions months ago and forgot, or if having
actions enabled on the parent repo makes it work.

When I made a new repository that was not connected, I had to explicitly
enable Actions on the site before it would run the workflow file.

-Peff
