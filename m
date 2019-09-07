Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85511F4BA
	for <e@80x24.org>; Sat,  7 Sep 2019 04:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406459AbfIGEkY (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 00:40:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:42660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726049AbfIGEkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 00:40:23 -0400
Received: (qmail 27902 invoked by uid 109); 7 Sep 2019 04:40:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 04:40:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9377 invoked by uid 111); 7 Sep 2019 04:42:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 00:42:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 00:40:22 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190907044021.GA24463@sigill.intra.peff.net>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com>
 <20190904032609.GD28836@sigill.intra.peff.net>
 <20190906232947.GJ11334@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906232947.GJ11334@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 11:29:47PM +0000, brian m. carlson wrote:

> On 2019-09-04 at 03:26:10, Jeff King wrote:
> > On Tue, Sep 03, 2019 at 08:51:19PM +0200, Martin Ågren wrote:
> > > When I posted v1, it turned into quite a thread [1] on AsciiDoc vs
> > > Asciidoctor vs Asciidoctor 2.0 and differences in rendering. (I am on
> > > Asciidoctor 1.5.5.)
> > 
> > Yes, sadly I still can't format the docs at all with 2.0.10 (which is
> > what ships in Debian unstable).
> 
> I'll look into this.  I requested the upgrade in sid.
> 
> If it's the lack of DocBook 4.5 support, then I'll probably need to
> patch xmlto for that.  DocBook 5 has been around for a decade now, so
> it's time for xmlto to support it properly.

Yes, it's the docbook45 thing. Switching to docbook5 lets asciidoc run,
but then xmlto chokes.

-Peff
