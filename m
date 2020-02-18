Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA3EC34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AEE2067D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRUdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:33:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:47196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726283AbgBRUdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:33:10 -0500
Received: (qmail 20173 invoked by uid 109); 18 Feb 2020 20:33:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 20:33:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22290 invoked by uid 111); 18 Feb 2020 20:42:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:42:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 15:33:09 -0500
From:   Jeff King <peff@peff.net>
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to
 initialize strbuf
Message-ID: <20200218203309.GA22630@coredump.intra.peff.net>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com>
 <20200218062124.GF1641086@coredump.intra.peff.net>
 <CALH1-XoWmojFZir1JTU490GNHE1CETs4jbjswH316cAWqjF+Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALH1-XoWmojFZir1JTU490GNHE1CETs4jbjswH316cAWqjF+Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 04:19:38PM +0200, Robear Selwans wrote:

> > I notice you put GSoC in your subject line. If you're looking at this as
> > a microproject, IMHO this is _way_ more complicated and subtle than a
> > microproject should be. The goal there is to give something so easy that
> > you get to focus on getting your patches in and interacting with the
> > community. The scope I'd expect is more along the lines of compiling
> > with -Wwrite-strings and cleaning up some of the locations that
> > complain.
> I'm actually planning to keep on contributing to git, so I kind of
> didn't want to
> do something trivial. Despite the fact that I'm planning to apply to
> git for GSoC,
> I'm mostly putting the [GSoC] so that reviewers would go easy on me :D. That
> said, I might actually do the -Wwrite-strings clean-up after this one
> is finished.

OK. If you want to go further, I certainly won't stop you. :)

-Peff
