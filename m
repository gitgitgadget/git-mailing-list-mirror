Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD8C1FF40
	for <e@80x24.org>; Thu, 15 Dec 2016 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbcLOAW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 19:22:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:56804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933070AbcLOAW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 19:22:28 -0500
Received: (qmail 2470 invoked by uid 109); 15 Dec 2016 00:22:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 00:22:28 +0000
Received: (qmail 30712 invoked by uid 111); 15 Dec 2016 00:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 19:23:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 19:22:24 -0500
Date:   Wed, 14 Dec 2016 19:22:24 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v10 0/6] transport protocol policy configuration
Message-ID: <20161215002224.k7uatnh6lwdrxrow@sigill.intra.peff.net>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 02:39:49PM -0800, Brandon Williams wrote:

> v10 of this series fixes the following:
> * A few updates to the commit messages in order to better convey the reasoning
>   behind the a few of the patches.
> * Additional test to verify that curl redirects respect configured protocol
>   policies.
> * Patch added by Jeff King to make http alternates respect configured
>   protocol policies.

Thanks, this one looks fine to me.

-Peff
