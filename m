Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FCF1F462
	for <e@80x24.org>; Wed, 22 May 2019 04:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfEVEBE (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 00:01:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:35710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725385AbfEVEBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 00:01:04 -0400
Received: (qmail 13660 invoked by uid 109); 22 May 2019 04:01:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 May 2019 04:01:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19432 invoked by uid 111); 22 May 2019 04:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 May 2019 00:01:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 May 2019 00:01:00 -0400
Date:   Wed, 22 May 2019 00:01:00 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [PATCH v3] grep: provide sane default to grep_source struct
Message-ID: <20190522040100.GA31212@sigill.intra.peff.net>
References: <20190516214444.191743-1-emilyshaffer@google.com>
 <20190522003402.77767-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522003402.77767-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 05:34:02PM -0700, Emily Shaffer wrote:

> I think Peff and Jonathan are right. If someone does want to hack away
> on something in the very early stages, the BUG() line gives a pretty
> clear indicator of what to modify to make it work.
> 
> I also moved the BUG() to grep_source_1() to keep it close to the error
> itself and reflowed the commit message.

Thanks. This version looks good to me (though if you took any of
Jonathan's suggestions in the other part of the thread that would be
fine with me, too).

-Peff
