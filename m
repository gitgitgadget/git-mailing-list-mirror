Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75A51F462
	for <e@80x24.org>; Sun, 28 Jul 2019 22:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfG1WTG (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 18:19:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:53626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726097AbfG1WTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 18:19:06 -0400
Received: (qmail 15854 invoked by uid 109); 28 Jul 2019 22:19:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 28 Jul 2019 22:19:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24640 invoked by uid 111); 28 Jul 2019 22:20:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jul 2019 18:20:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Jul 2019 18:19:05 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 0/5] system header cleanup
Message-ID: <20190728221904.GA21379@sigill.intra.peff.net>
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
 <20190728200724.35630-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190728200724.35630-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 28, 2019 at 01:07:19PM -0700, Carlo Marcelo Arenas Belón wrote:

> This series is a reroll of jk/no-system-includes-in-dot-c with
> cb/xdiff-no-system-includes-in-dot-c applied on top with minor
> fixes for the commit message based on feedback from Johannes
> and the example put forward by Peff with his own patches.
> 
> The changes proposed shouldn't affect any systems (except for
> the 3rd one) and that has since shown to also be needed
> in Alpine Linux (because of _XOPEN_SOURCE redefinition).
> 
> The last 2 patches are new to the series and just cleanup
> the dependency list in xdiff.

Thanks, these all look good to me.

-Peff
