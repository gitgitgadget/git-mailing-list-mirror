Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFEE1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 20:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbfGRURp (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 16:17:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:39670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2391161AbfGRURp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 16:17:45 -0400
Received: (qmail 30077 invoked by uid 109); 18 Jul 2019 20:17:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Jul 2019 20:17:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20358 invoked by uid 111); 18 Jul 2019 20:18:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Jul 2019 16:18:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jul 2019 16:17:43 -0400
Date:   Thu, 18 Jul 2019 16:17:43 -0400
From:   Jeff King <peff@peff.net>
To:     Doug Ilijev via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Fix rendering of text in angle brackets in README.md
Message-ID: <20190718201742.GA22038@sigill.intra.peff.net>
References: <pull.289.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.289.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 12:08:45PM -0700, Doug Ilijev via GitGitGadget wrote:

> Markdown incorrectly interpreted <commandname> as an HTML tag; use backticks
> to escape Documentation/git-<commandname>.txt to ensure that it renders the
> text as intended.
> 
> An alternative would be to HTML-escape the angle-brackets, at the cost of
> readability of the markdown in plaintext form. I opted for the backticks to
> preserve plaintext readability.

Yeah, I think backticks are the best solution; they match what we do
later in that same paragraph.

This kind of "an alternative..." explanation would go very well in the
actual commit message, too. :) Other than that nit, the patch looks good
to me.

-Peff
