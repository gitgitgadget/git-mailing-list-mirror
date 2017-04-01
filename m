Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25511FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 06:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdDAGUE (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 02:20:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:55260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdDAGUD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 02:20:03 -0400
Received: (qmail 22695 invoked by uid 109); 1 Apr 2017 06:20:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 06:20:03 +0000
Received: (qmail 15922 invoked by uid 111); 1 Apr 2017 06:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 02:20:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 02:20:00 -0400
Date:   Sat, 1 Apr 2017 02:20:00 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/20] Separate `ref_cache` into a separate module
Message-ID: <20170401062000.3j2jblntkfqd4cd4@sigill.intra.peff.net>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 04:10:58PM +0200, Michael Haggerty wrote:

> * I added a long blurb about the removal of an internal consistency
>   check in the commit message for
> 
>       [18/20] commit_packed_refs(): use reference iteration

Thanks, the explanation there makes sense.

I think this version addresses all of my comments.

-Peff
