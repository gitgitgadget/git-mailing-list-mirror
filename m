Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1FC33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC737206E3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgBALCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:02:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:50290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbgBALCF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:02:05 -0500
Received: (qmail 21021 invoked by uid 109); 1 Feb 2020 11:02:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Feb 2020 11:02:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7997 invoked by uid 111); 1 Feb 2020 11:09:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Feb 2020 06:09:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Feb 2020 06:02:03 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mike McGranahan <mike@mcgwiz.com>, git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
Message-ID: <20200201110203.GA1864964@coredump.intra.peff.net>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 01:37:44PM +0100, Johannes Schindelin wrote:

> If my reading is correct, and we want `git diff-files --color` to respect
> the `diff.wsErrorHighlight` setting, then this patch fixes that:
> [...]
> The bigger question is whether other core developers agree with this? And
> what other `diff.*` settings should be respected by `git diff-files` (and
> of course, `git diff-index`)?

I think you can take my posting of an identical patch elsewhere in the
thread as a "yes". :)

-Peff
