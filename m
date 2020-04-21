Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DBC55183
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA23320B1F
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDUAGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:06:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:33626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725897AbgDUAGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 20:06:20 -0400
Received: (qmail 16506 invoked by uid 109); 21 Apr 2020 00:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Apr 2020 00:06:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3160 invoked by uid 111); 21 Apr 2020 00:17:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Apr 2020 20:17:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Apr 2020 20:06:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vd@FreeBSD.org
Subject: Re: [PATCH] diff-tree.c: load notes machinery when required
Message-ID: <20200421000619.GB2879931@coredump.intra.peff.net>
References: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
 <20200416045630.GA21547@coredump.intra.peff.net>
 <20200421000531.GA31800@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421000531.GA31800@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 06:05:31PM -0600, Taylor Blau wrote:

> Here is an updated version of the patch that should be ready for
> queuing.
> 
> -- 8< --
> 
> Subject: [PATCH] tempfile.c: introduce 'create_tempfile_mode'

Er, right patch?

-Peff
