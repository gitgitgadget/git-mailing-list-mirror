Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62ADC33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C9320658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBCLpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:45:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:51208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726278AbgBCLpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 06:45:50 -0500
Received: (qmail 2146 invoked by uid 109); 3 Feb 2020 11:45:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 11:45:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24149 invoked by uid 111); 3 Feb 2020 11:53:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 06:53:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 06:45:49 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] git-filter-branch.txt: use {caret} for ^
Message-ID: <20200203114549.GA4157558@coredump.intra.peff.net>
References: <20200202193319.1966-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200202193319.1966-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 02, 2020 at 08:33:19PM +0100, Martin Ågren wrote:

> In this paragraph, we have a few instances of the '^' character, which
> we give as "\^". This renders well with AsciiDoc ("^"), but Asciidoctor
> renders it literally as "\^". Dropping the backslashes renders fine
> with Asciidoctor, but not AsciiDoc... Let's use "{caret}" instead, to
> avoid these escaping problems.

Makes sense.

The source is pretty ugly to read both before and after, though. I
wonder if using a literal like `5*10^5` would be even nicer. That makes
the source pretty readable, and the output would put it in <tt> or
similar. Which maybe is a little funny, but kind of makes sense to me
typographically as a kind of "this is math" style.

-Peff
