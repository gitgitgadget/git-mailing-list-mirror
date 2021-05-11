Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE89C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C41761585
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEKTK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:10:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKTKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:10:25 -0400
Received: (qmail 24200 invoked by uid 109); 11 May 2021 19:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 19:09:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27005 invoked by uid 111); 11 May 2021 19:09:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 15:09:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 15:09:17 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJrWXfmaNVIL/TzT@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
 <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
 <609a3a5a7aa08_5d5d32088@natae.notmuch>
 <877dk5tovj.fsf@evledraar.gmail.com>
 <609ad46776dec_6011e208d7@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <609ad46776dec_6011e208d7@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 02:00:55PM -0500, Felipe Contreras wrote:

> > > > It's not too hard to install an updated gem, but not quite as nice
> > > > as using the system package (it also makes things weird for
> > > > building the stable Debian package itself, which would want to
> > > > rely only on other packages; but of course any proposed change to
> > > > the doc toolchain would be for new versions, and would not get
> > > > backported there anyway).
> 
> Doing `gem install` solves the problem for whomever wants to build the
> latest git in Debian stable.
> 
> Building Debian stable packages is something else.

Perhaps I wasn't clear with the "but of course" part of my statement. It
was meant to rebut the earlier half of the parenthetical. I.e., drawing
that same distinction as "we don't have to worry about packaging Debian
stable here".

-Peff
