Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE6FC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjCVRMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCVRL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:11:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FF60434
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:11:56 -0700 (PDT)
Received: (qmail 9702 invoked by uid 109); 22 Mar 2023 17:11:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:11:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15689 invoked by uid 111); 22 Mar 2023 17:11:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:11:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:11:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>,
        Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
Message-ID: <20230322171155.GA4296@coredump.intra.peff.net>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230320230507.3932018-1-gitster@pobox.com>
 <20230321182252.GJ3119834@coredump.intra.peff.net>
 <xmqqh6udhnvi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6udhnvi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 01:04:49PM -0700, Junio C Hamano wrote:

> So, I am not quite sure I am sold on the idea of rewriting
> everything to use gettimeofday(2).

I'm not sure I am either. :) All your points are fair. Let's forget
about my suggestion.

-Peff
