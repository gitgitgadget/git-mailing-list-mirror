Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EDE1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 07:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934947AbeCAHms (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 02:42:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:42350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933286AbeCAHms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 02:42:48 -0500
Received: (qmail 16279 invoked by uid 109); 1 Mar 2018 07:42:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 07:42:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12623 invoked by uid 111); 1 Mar 2018 07:43:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 02:43:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 02:42:45 -0500
Date:   Thu, 1 Mar 2018 02:42:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, bmwill@google.com, avarab@gmail.com
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
Message-ID: <20180301074245.GF31079@sigill.intra.peff.net>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180208103356.GA30524@sigill.intra.peff.net>
 <xmqqk1uwkdp4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1uwkdp4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 01:27:03PM -0800, Junio C Hamano wrote:

> Somehow this topic has been hanging without getting further
> attention for too long.  It's time to wrap it up and moving it
> forward.  How about this?
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Wed, 28 Feb 2018 13:21:09 -0800
> Subject: [PATCH] untracked cache: use git_env_bool() not getenv() for customization
> [...]

This looks good to me. Thanks for tying up the loose end.

-Peff
