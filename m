Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E4CC433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B12B23101
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391101AbhALJfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:35:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:53162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387724AbhALJfO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:35:14 -0500
Received: (qmail 7278 invoked by uid 109); 12 Jan 2021 09:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jan 2021 09:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11319 invoked by uid 111); 12 Jan 2021 09:34:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jan 2021 04:34:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jan 2021 04:34:33 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 19/20] pack-revindex: hide the definition of
 'revindex_entry'
Message-ID: <X/1tKaIXxj9u/QfM@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <7c0e4acc845d1135e684188b2ccc61cf358994dc.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c0e4acc845d1135e684188b2ccc61cf358994dc.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:18:01PM -0500, Taylor Blau wrote:

> Now that all spots outside of pack-revindex.c that reference 'struct
> revindex_entry' directly have been removed, it is safe to hide the
> implementation by moving it from pack-revindex.h to pack-revindex.c.

That was a lot of patches to get here, but this is a very nice outcome. :)

-Peff
