Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19218201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964911AbdBQXlb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:41:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:57657 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964905AbdBQXla (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:41:30 -0500
Received: (qmail 31919 invoked by uid 109); 17 Feb 2017 23:41:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 23:41:30 +0000
Received: (qmail 8795 invoked by uid 111); 17 Feb 2017 23:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 18:41:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 18:41:28 -0500
Date:   Fri, 17 Feb 2017 18:41:28 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] update-ref: pass reflog message argument to
 delete_refs
Message-ID: <20170217234128.d7uhxu4fjzsc4yjh@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-3-kyle@kyleam.com>
 <20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net>
 <8737fcqtcj.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8737fcqtcj.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 06:40:28PM -0500, Kyle Meyer wrote:

> > For reference, the two things I notice are:
> >
> >   - we prefer test_path_is_missing to "! test -f" these days.
> >
> >   - we don't redirect the output of grep (it's handled already in
> >     non-verbose mode, and in verbose mode we try to be...verbose).
> 
> Would moving cleanup like "rm -f .git/$m" within the test's body using
> test_when_finished also be preferred?

Yeah, that too.  I forgot to mention it.

-Peff
