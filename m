Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F024C4724C
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6874F20936
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgEFQVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:21:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729251AbgEFQVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:21:55 -0400
Received: (qmail 22861 invoked by uid 109); 6 May 2020 16:21:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 May 2020 16:21:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8725 invoked by uid 111); 6 May 2020 16:21:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 May 2020 12:21:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 May 2020 12:21:53 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 3/4] credential: update gitcredentials documentation
Message-ID: <20200506162153.GA1841928@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200505013908.4596-4-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505013908.4596-4-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 06:39:07PM -0700, Carlo Marcelo Arenas Belón wrote:

> Clarify the expected effect of all attributes and how the helpers
> are expected to handle them and the context where they operate.
> 
> While at it, space the descriptions for clarity, and add a paragraph
> mentioning the early termination in the list processing of helpers,
> to complement the one about the special "quit" attribute.

Yep, these all make sense. One nit:

> +While it is possible to override all attributes, well behaving helpers
> +should refrain to do so for any attributes other than username and
> +password.

"refrain from doing so" would be more idiomatic English.

-Peff
