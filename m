Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2978D2023D
	for <e@80x24.org>; Wed, 24 May 2017 09:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163306AbdEXJ5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 05:57:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:57371 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758949AbdEXJ5R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 05:57:17 -0400
Received: (qmail 18833 invoked by uid 109); 24 May 2017 09:57:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 09:57:16 +0000
Received: (qmail 9640 invoked by uid 111); 24 May 2017 09:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 05:57:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2017 05:57:15 -0400
Date:   Wed, 24 May 2017 05:57:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/15] retain blob info for git diff HEAD:foo HEAD:bar
Message-ID: <20170524095715.wgkft6fofjop5jco@sigill.intra.peff.net>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
 <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
 <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
 <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
 <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
 <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
 <xmqqefvfht29.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefvfht29.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 11:44:46AM +0900, Junio C Hamano wrote:

> Patches around [PATCH 06-08/15] made some unexpected (at least to
> me) turns but the series told a coherent story, building on top of
> what has been achieved in the previous steps.

Yeah, those patches are not technically required for the rest of it. The
"strbuf" conversion for oc->path is just something I've wanted to fix
for a long time. It made sense to me to do it before teaching
handle_dotdot() to look at oc->path (because the interface to do so
changed a bit).

-Peff
