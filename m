Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089771F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfBKXq2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:46:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:40750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727312AbfBKXq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:46:28 -0500
Received: (qmail 17503 invoked by uid 109); 11 Feb 2019 23:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Feb 2019 23:46:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19010 invoked by uid 111); 11 Feb 2019 23:46:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 18:46:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 18:46:26 -0500
Date:   Mon, 11 Feb 2019 18:46:26 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: fix non-portable pattern bracket expressions
Message-ID: <20190211234626.GA13301@sigill.intra.peff.net>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
 <20190211195803.1682-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211195803.1682-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 08:58:03PM +0100, SZEDER Gábor wrote:

> Use a '!' character to start a non-matching pattern bracket
> expression, as specified by POSIX in Shell Command Language section
> 2.13.1 Patterns Matching a Single Character [1].

Just when I think I know every little gotcha in the shell, I learn
another one. :) Thanks for fixing this, and for digging up the POSIX
reference.

-Peff
