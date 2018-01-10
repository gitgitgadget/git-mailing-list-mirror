Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3211FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 08:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeAJIVA (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 03:21:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:39814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751965AbeAJIU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 03:20:59 -0500
Received: (qmail 18460 invoked by uid 109); 10 Jan 2018 08:21:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 08:21:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13539 invoked by uid 111); 10 Jan 2018 08:21:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 03:21:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 03:20:57 -0500
Date:   Wed, 10 Jan 2018 03:20:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] revision: get rid of the flag leak_pending
Message-ID: <20180110082057.GG16315@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 06:41:18PM +0100, René Scharfe wrote:

> The flag leak_pending is weird, let's get rid of it.
> 
> Changes from v1: Everything.

I left a few comments, but didn't see any show-stoppers (which is good,
because this is already in 'next' ;) ). Any I didn't comment on looked
fine to me.

-Peff
