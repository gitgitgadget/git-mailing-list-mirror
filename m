Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5778820248
	for <e@80x24.org>; Wed,  6 Mar 2019 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfCFTGd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 14:06:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:41296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727302AbfCFTGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 14:06:33 -0500
Received: (qmail 26903 invoked by uid 109); 6 Mar 2019 19:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 19:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16205 invoked by uid 111); 6 Mar 2019 19:06:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 14:06:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 14:06:31 -0500
Date:   Wed, 6 Mar 2019 14:06:31 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
Message-ID: <20190306190630.GB18239@sigill.intra.peff.net>
References: <20190305214423.27820-1-jn.avila@free.fr>
 <20190305223655.GA27535@sigill.intra.peff.net>
 <xmqq4l8hszj7.fsf@gitster-ct.c.googlers.com>
 <20190305230227.GA22901@sigill.intra.peff.net>
 <20190305231142.GA359@sigill.intra.peff.net>
 <xmqqy35ssx7v.fsf@gitster-ct.c.googlers.com>
 <43445278-ec9f-f3f4-89bf-cf99906fc617@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43445278-ec9f-f3f4-89bf-cf99906fc617@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 09:07:11AM +0100, Jean-Noël Avila wrote:

> TBH, I discovered this while diving into the rendering on manpages for
> the localized version because asciidoctor issued a warning, and pushed
> this patch for "cultural" knowledge (sometimes, automatic linefeed
> triggers unintended behaviors). But, as Peff noted, this may not be a
> good idea to render these documents at all on git-scm.com.

Ah, that makes sense. I do think this is an interesting gotcha, and I'm
glad to have learned about it. So even if we don't apply your patch and
it serves as an interesting report, I think it was still worth it.

(Though I am also happy to see it applied since you went to the trouble
to make it).

-Peff
