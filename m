Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48731F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfBLAFc (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:05:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:40846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727606AbfBLAFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:05:32 -0500
Received: (qmail 18452 invoked by uid 109); 12 Feb 2019 00:05:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19190 invoked by uid 111); 12 Feb 2019 00:05:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:05:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:05:30 -0500
Date:   Mon, 11 Feb 2019 19:05:30 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] protocol-capabilities.txt: document symref
Message-ID: <20190212000530.GC13301@sigill.intra.peff.net>
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 03:52:24PM -0800, Josh Steadmon wrote:

> In 7171d8c15f ("upload-pack: send symbolic ref information as
> capability"), we added a symref capability to the pack protocol, but it
> was never documented. Adapt the patch notes from that commit and add
> them to the capabilities documentation.

Good catch, and your explanation (especially the SHOULD/MAY bits) looks
good.

I think this is obsoleted by v2, which will send symref info along with
each ref. I don't know if it's worth mentioning that here (the v2 docs
discuss it, but I don't know if this capabilities document is clear
about which ones apply only to v0).

-Peff
