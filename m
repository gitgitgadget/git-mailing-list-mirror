Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C87BCA0FE0
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 22:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbjHaWcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHaWcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 18:32:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60443E65
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 15:32:03 -0700 (PDT)
Received: (qmail 26204 invoked by uid 109); 31 Aug 2023 22:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 22:32:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12347 invoked by uid 111); 31 Aug 2023 22:32:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 18:32:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 18:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] format-patch: --rfc honors what --subject-prefix sets
Message-ID: <20230831223201.GB952036@coredump.intra.peff.net>
References: <20230830064646.30904-1-sir@cmpwn.com>
 <xmqqsf808h4g.fsf@gitster.g>
 <20230831212950.GA949706@coredump.intra.peff.net>
 <xmqqv8cuswah.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8cuswah.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 03:04:54PM -0700, Junio C Hamano wrote:

> Sure.  FWIW, I like giving a meaningful name to a thing that is used
> more than once, so my preference is the original minus excess cast.
> 
> Thanks for a review.  Here is a tentative rewrite

Thanks, looks good to me.

-Peff
