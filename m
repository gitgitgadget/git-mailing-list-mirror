Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37CE41F405
	for <e@80x24.org>; Sat, 22 Dec 2018 22:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391306AbeLVWW1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Dec 2018 17:22:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:48658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2391296AbeLVWW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Dec 2018 17:22:27 -0500
Received: (qmail 15954 invoked by uid 109); 22 Dec 2018 22:22:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 22 Dec 2018 22:22:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16579 invoked by uid 111); 22 Dec 2018 22:22:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 22 Dec 2018 17:22:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Dec 2018 17:22:24 -0500
Date:   Sat, 22 Dec 2018 17:22:24 -0500
From:   Jeff King <peff@peff.net>
To:     Issac Trotts <issac.trotts@gmail.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
Message-ID: <20181222222224.GA15914@sigill.intra.peff.net>
References: <20181219083305.2500-1-issac.trotts@gmail.com>
 <CANdyxMyz3u+ajH0X7BPJBPBT0iepWhunA_VA+HEGFrurYghSWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANdyxMyz3u+ajH0X7BPJBPBT0iepWhunA_VA+HEGFrurYghSWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 09:24:10PM -0800, Issac Trotts wrote:

> Hi all, friendly ping. Is there still interest in merging this patch?

Yes, but I think people are largely absent for holidays at this point.
If there hasn't been any movement on it, I'll try to review after Jan
5th (it also wouldn't hurt to re-post around then).

-Peff
