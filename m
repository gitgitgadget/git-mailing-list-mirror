Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC5120401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFXMWu (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:22:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750817AbdFXMWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:22:49 -0400
Received: (qmail 1393 invoked by uid 109); 24 Jun 2017 12:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23550 invoked by uid 111); 24 Jun 2017 12:22:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:22:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:22:47 -0400
Date:   Sat, 24 Jun 2017 08:22:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5 2/2] strbuf: change an always NULL/""
 strbuf_addftime() param to bool
Message-ID: <20170624122247.zcds2qkle6xg5ior@sigill.intra.peff.net>
References: <20170624121023.2636-2-avarab@gmail.com>
 <20170624121452.7952-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170624121452.7952-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 12:14:52PM +0000, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Jun 24, 2017 at 2:10 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > Thanks. Docs fixed per your suggestion. I sent a v4 of 1/2 too, but
> > that's unchanged, just thought it was simpler than having just one
> > patch have a v4...
> 
> Urgh, mistake on my end, sent v3 again as v4. Here's v5 with the
> *actual* fixes. Sorry.

Heh, I skimmed over v4 again and thought "this looks good", but the one
thing I _didn't_ read was the final hunk that actually changed from v3.
Yikes.  So much for my code review skills.

-Peff
