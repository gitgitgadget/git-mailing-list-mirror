Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD01211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 06:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAFGHu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 01:07:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:55720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726258AbfAFGHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 01:07:50 -0500
Received: (qmail 693 invoked by uid 109); 6 Jan 2019 06:07:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 06 Jan 2019 06:07:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27058 invoked by uid 111); 6 Jan 2019 06:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 06 Jan 2019 01:07:28 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2019 01:07:48 -0500
Date:   Sun, 6 Jan 2019 01:07:48 -0500
From:   Jeff King <peff@peff.net>
To:     Xheroz 128 <kenneth.951218@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git extra hook, pre-upload
Message-ID: <20190106060748.GA3935@sigill.intra.peff.net>
References: <754B8F69-BD83-4EBB-9E86-6DF845624B1B@gmail.com>
 <87k1jqem1p.fsf@evledraar.gmail.com>
 <20190103072940.GA24925@sigill.intra.peff.net>
 <A842150D-2A45-4ABB-9B0F-DF516F7A2737@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A842150D-2A45-4ABB-9B0F-DF516F7A2737@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[re-add git@vger cc]

On Sat, Jan 05, 2019 at 01:47:11PM +0900, Xheroz 128 wrote:

> Thank you for all your replies. I have read the thread from 2011 and
> understand the reason of the insecure part using pre and post upload
> hooks.
> But for my project I would still like to use pre-upload hook. But I do
> not know how to enable the ALLOW_INSECURE_HOOKS in my system. How to
> configure it?

We never actually merged that patch, so there is no such build-time knob
in Git. I.e., you can either use the uploadpack.packObjectsHook feature,
or you will have to make a custom patch yourself.

-Peff
