Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9431BC433EC
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3A120709
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgGWScu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:32:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:36466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgGWSct (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 14:32:49 -0400
Received: (qmail 16387 invoked by uid 109); 23 Jul 2020 18:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2020 18:32:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14513 invoked by uid 111); 23 Jul 2020 18:32:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2020 14:32:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Jul 2020 14:32:47 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, bup-list@googlegroups.com,
        Jamie Wyrick <terrifiedquack80@gmail.com>
Subject: Re: [PATCH v3] pack-write/docs: update regarding pack naming
Message-ID: <20200723183247.GD3975154@coredump.intra.peff.net>
References: <20200722214031.116161-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722214031.116161-1-johannes@sipsolutions.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 11:40:31PM +0200, Johannes Berg wrote:

> The index-pack documentation explicitly states that the pack
> name is derived from the sorted list of object names, but
> since commit 1190a1acf800 ("pack-objects: name pack files
> after trailer hash") that isn't true anymore.
> 
> Be less explicit in the docs as to what the exact output is,
> and just say that it's whatever goes into the pack name.
> 
> Also update a comment on write_idx_file() since it no longer
> modifies the sha1 variable (it's const now anyway), as noted
> by Junio.

Sorry, I should have fixed these way back in 1190a1acf800. Thanks for
fixing them. :)

-Peff
