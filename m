Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D2C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 22:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AFC6109E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 22:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhHSW2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:28:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:52650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHSW2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 18:28:40 -0400
Received: (qmail 15290 invoked by uid 109); 19 Aug 2021 22:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Aug 2021 22:28:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32475 invoked by uid 111); 19 Aug 2021 22:28:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Aug 2021 18:28:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Aug 2021 18:28:02 -0400
From:   Jeff King <peff@peff.net>
To:     "Lin, Nathan (GSE)" <jih-tsen.nat.lin@hpe.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: General questions - git archive a .j2 file with keyword
 expansion in the header section
Message-ID: <YR7a8vKrYgFJof0D@coredump.intra.peff.net>
References: <DF4PR8401MB0795EE7D2828A45289295D3892C09@DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DF4PR8401MB0795EE7D2828A45289295D3892C09@DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 09:28:11PM +0000, Lin, Nathan (GSE) wrote:

> Got a question on using git keyword expansion on a .j2 template file.
> Keyword expansion does not seem to work with .j2 file. Please see
> below a snippet of my attempt to archive test.cfg.j2 containing git
> keyword expansions in the header. It works if I changes the .j2 file
> extension to something else, say .yaml. I have not been able to find
> any information about issue. Can you please review and advise? Thank
> you.

Do you have .gitattributes entries that tell Git it should apply the
"export-subst" attribute to any files? If so, does it cover .yaml files,
but not .j2?

-Peff
