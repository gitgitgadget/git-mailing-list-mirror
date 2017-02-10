Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4B21FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbdBJP62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:58:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:52979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbdBJP5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:57:43 -0500
Received: (qmail 13256 invoked by uid 109); 10 Feb 2017 15:56:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 15:56:54 +0000
Received: (qmail 29259 invoked by uid 111); 10 Feb 2017 15:56:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 10:56:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 10:56:52 -0500
Date:   Fri, 10 Feb 2017 10:56:52 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Store submodules in a hash, not a linked list
Message-ID: <20170210155651.lecjrzmoux5mcm5d@sigill.intra.peff.net>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 12:16:10PM +0100, Michael Haggerty wrote:

> This is v2 of the patch series, considerably reorganized but not that
> different codewise. Thanks to Stefan, Junio, and Peff for their
> feedback about v1 [1]. I think I have addressed all of your comments.
> 
> Changes since v1:

I read through these and didn't didn't see any problems.

The reordering and new commits made sense to me.

-Peff
