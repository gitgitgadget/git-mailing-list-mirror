Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C72B1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966566AbeF1O2p (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:28:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:58218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966493AbeF1O2o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:28:44 -0400
Received: (qmail 14091 invoked by uid 109); 28 Jun 2018 14:28:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 14:28:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20193 invoked by uid 111); 28 Jun 2018 14:29:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 10:29:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 10:28:42 -0400
Date:   Thu, 28 Jun 2018 10:28:42 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180628142842.GC15799@sigill.intra.peff.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <xmqqlgb0goui.fsf@gitster-ct.c.googlers.com>
 <20180627205843.GM20217@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627205843.GM20217@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 04:58:43PM -0400, Todd Zullinger wrote:

> I tend to think that the default should be to build
> documentation that is accurate for that build, but since
> it's something I'll set once for my package builds it's not
> a big deal either way to me.

To be clear, I think so, too. I'd just like to have a single knob that
generic builds can set so that:

  - the decision is only "is this generic", and the exact generic text
    is still inside the source files

  - it would cover this case and similar cases going forward

-Peff
