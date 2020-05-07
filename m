Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED3C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64B120661
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEGU7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:59:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:40992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbgEGU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:59:10 -0400
Received: (qmail 2774 invoked by uid 109); 7 May 2020 20:59:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:59:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22078 invoked by uid 111); 7 May 2020 20:59:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:59:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:59:09 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] credential: documentation updates for maint
Message-ID: <20200507205909.GA38308@coredump.intra.peff.net>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200506162712.GB1275237@coredump.intra.peff.net>
 <20200506232848.GB75901@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506232848.GB75901@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 04:28:48PM -0700, Carlo Marcelo Arenas Belón wrote:

> Subject: [RFC PATCH 5/4] credential: document encoding assumptions for values
> 
> Because of the similarity on the names of the keys with what is defined
> in RFC3986 is easy to assume the same rules would apply here.
> 
> Make sure that the format and encoding is well defined to avoid helper
> developers assuming incorrectly.

I'm not sure this really clarifies anything, because it just says "no
assumptions can be made". Which I guess is a statement, but I'm not sure
what I'd do with it as a helper developer.

-Peff
