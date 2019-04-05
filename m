Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D1120248
	for <e@80x24.org>; Fri,  5 Apr 2019 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDEWV5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 18:21:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:49284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbfDEWV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 18:21:57 -0400
Received: (qmail 19752 invoked by uid 109); 5 Apr 2019 22:21:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 22:21:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30747 invoked by uid 111); 5 Apr 2019 22:22:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 18:22:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 18:21:55 -0400
Date:   Fri, 5 Apr 2019 18:21:55 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Progress display fixes
Message-ID: <20190405222154.GB10787@sigill.intra.peff.net>
References: <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190405004539.31467-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405004539.31467-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 02:45:35AM +0200, SZEDER Gábor wrote:

> This patch series fixes two progress display issues by breaking
> progress bars longer than the width of the terminal and by properly
> cleaning up the previously shown progress bar.
> 
> Changes since v2, following Eric's and Peff's suggestions:
> 
>   - Remove return statements that just became unnecessary in patch
>     1/4.
> 
>   - Use size_t helper variables to store intermediate results of
>     calculations based on length of strings.

Thanks, I have no more nits to pick.

-Peff
