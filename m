Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8022E1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 02:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeGJCQC (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 22:16:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:53070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932620AbeGJCQB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 22:16:01 -0400
Received: (qmail 17025 invoked by uid 109); 10 Jul 2018 02:16:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 02:16:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19038 invoked by uid 111); 10 Jul 2018 02:16:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 22:16:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 22:15:59 -0400
Date:   Mon, 9 Jul 2018 22:15:59 -0400
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 2/6] refs/refs-internal.h: avoid forward declaration
 of an enum
Message-ID: <20180710021558.GB10248@sigill.intra.peff.net>
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-3-dev+git@drbeat.li>
 <20180709184632.GA9601@sigill.intra.peff.net>
 <a3e6c187-74a5-1858-b207-b52d409b11be@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3e6c187-74a5-1858-b207-b52d409b11be@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 09:30:12PM +0200, Beat Bolli wrote:

> > Other than this minor quibble, the whole series looks good to me, modulo
> > the existing review.
> 
> Ooosp, I've just sent the non-RFC reroll without this change.
> 
> Junio, would you squash this into [1/6] and [2/6], please (if you agree,
> of course :-)

:) I'd be happy with that squash, but not the end of the world if it
doesn't make it. Thanks for the whole series.

-Peff
