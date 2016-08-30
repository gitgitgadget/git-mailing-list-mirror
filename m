Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CF61F859
	for <e@80x24.org>; Tue, 30 Aug 2016 08:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbcH3IMB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 04:12:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:35267 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750697AbcH3IL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 04:11:57 -0400
Received: (qmail 22292 invoked by uid 109); 30 Aug 2016 08:11:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 08:11:56 +0000
Received: (qmail 27742 invoked by uid 111); 30 Aug 2016 08:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 04:12:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 04:11:52 -0400
Date:   Tue, 30 Aug 2016 04:11:52 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, gitster@pobox.com
Subject: Re: [PATCH v4 0/3] diff-highlight: add support for --graph option
Message-ID: <20160830081152.rbvwexqqe6jwkue2@sigill.intra.peff.net>
References: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
 <20160829173347.454-1-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160829173347.454-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 10:33:44AM -0700, Brian Henderson wrote:

> How does this look?
> 
> Drawing the graph helped me a lot in figuring out what I was actually testing. thanks!
> 
> Brian Henderson (3):
>   diff-highlight: add some tests.
>   diff-highlight: add failing test for handling --graph output.
>   diff-highlight: add support for --graph output.

These all look good to me. As Junio mentioned, you need to add a
signoff (see the section "Sign your work" in Documentation/SubmittingPatches).

Also, a minor nit, but we don't usually put a "." at the end of our
commit message subjects (not worth a re-roll on its own, but if you are
sending them again anyway...).

-Peff
