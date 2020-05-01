Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E048C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3FE20787
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgEAGTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:19:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:33290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728159AbgEAGTS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:19:18 -0400
Received: (qmail 1815 invoked by uid 109); 1 May 2020 06:19:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 06:19:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15482 invoked by uid 111); 1 May 2020 06:19:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 02:19:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 02:19:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix quoting bug in credential cache example
Message-ID: <20200501061917.GC23665@coredump.intra.peff.net>
References: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
 <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
 <20200501055738.GB23665@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501055738.GB23665@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 01:57:38AM -0400, Jeff King wrote:

> It may be easier to just use double-quotes consistently, even for ones
> that do not need it, to give readers one less thing to wonder about.

So here's a patch that does that. I also noticed a few other
deficiencies in that final example, which are fixed in the second patch.

I hope I'm not stealing Douglas's thunder. :)

  [1/2]: gitcredentials(7): clarify quoting of helper examples
  [2/2]: gitcredentials(7): make shell-snippet example more realistic

 Documentation/gitcredentials.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-Peff
