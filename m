Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E8C1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbcIHHUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:39937 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751346AbcIHHUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:20:35 -0400
Received: (qmail 32349 invoked by uid 109); 8 Sep 2016 07:20:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 07:20:32 +0000
Received: (qmail 12001 invoked by uid 111); 8 Sep 2016 07:20:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 03:20:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 03:20:29 -0400
Date:   Thu, 8 Sep 2016 03:20:29 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] diff_flush_patch_id: stop returning error result
Message-ID: <20160908072029.rwsa5b6zgwwe37ly@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net>
 <5c4276ad-19ed-1481-41cf-3d506ef9c7c6@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c4276ad-19ed-1481-41cf-3d506ef9c7c6@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 01:51:05AM +0100, Ramsay Jones wrote:

> 
> 
> On 07/09/16 23:04, Jeff King wrote:
> > All of our errors come from diff_get_patch_id(), which has
> > exactly three error conditions. The first is an internal
> > assertion, which should be a die("BUG") in the first place.
> > 
> > The other two are caused by an inability to two diff blobs,
>                                            ^^^^^^^^^^^^^^^^^
> Huh? ... to diff two blobs?

Sorry. English my getting worse be to seems.

Will fix in a re-roll.

-Peff
