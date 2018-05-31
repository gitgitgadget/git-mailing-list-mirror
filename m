Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A471F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeEaF1O (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:27:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:57380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751660AbeEaF1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:27:13 -0400
Received: (qmail 11896 invoked by uid 109); 31 May 2018 05:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9314 invoked by uid 111); 31 May 2018 05:27:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:27:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:27:11 -0400
Date:   Thu, 31 May 2018 01:27:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] config doc: clarify "to a terminal" in color.ui
Message-ID: <20180531052711.GC17068@sigill.intra.peff.net>
References: <20180530210641.19771-1-avarab@gmail.com>
 <20180530210641.19771-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530210641.19771-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 09:06:39PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the documentation added when color.ui=auto was made the default
> in 4c7f1819b3 ("make color.ui default to 'auto'", 2013-06-10) to
> describe "auto" as kicking in when writing to the terminal or a pager,
> not just to the terminal.

Makes sense. Usually the pager only kicks in when we're going to a
terminal in the first place, so the two would be the same thing. But
obviously you can override that with "-p".

-Peff
