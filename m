Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F74202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 07:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754914AbdIHH2C (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 03:28:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:60550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754655AbdIHH2B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 03:28:01 -0400
Received: (qmail 22738 invoked by uid 109); 8 Sep 2017 07:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 07:28:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6398 invoked by uid 111); 8 Sep 2017 07:28:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:28:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 03:27:59 -0400
Date:   Fri, 8 Sep 2017 03:27:59 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/10] files_initial_transaction_commit(): use a
 transaction for packed refs
Message-ID: <20170908072758.d3qvwsrm5t54kc63@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <92b29defc3c4ddb65a948b7d142ded941eaccefd.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92b29defc3c4ddb65a948b7d142ded941eaccefd.1503993268.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 10:20:30AM +0200, Michael Haggerty wrote:

> Used a `packed_ref_store` transaction in the implementation of
> `files_initial_transaction_commit()` rather than using internal
> features of the packed ref store. This further decouples
> `files_ref_store` from `packed_ref_store`.

Very nice to see these couplings going away.

Minor nit: s/Used/Use/ in the commit message.

-Peff
