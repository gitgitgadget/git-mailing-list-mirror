Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FCEC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203DB206D8
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEOSFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:05:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:47868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726023AbgEOSFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:05:55 -0400
Received: (qmail 25744 invoked by uid 109); 15 May 2020 18:05:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 May 2020 18:05:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13953 invoked by uid 111); 15 May 2020 18:05:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2020 14:05:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 May 2020 14:05:53 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 03/13] upload-pack: move 'struct upload_pack_data' around
Message-ID: <20200515180553.GC3692649@coredump.intra.peff.net>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515100454.14486-4-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 12:04:44PM +0200, Christian Couder wrote:

> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's move 'struct upload_pack_data' and the
> related upload_pack_data_init() and upload_pack_data_clear()
> functions towards the beginning of the file, so that this struct
> and its related functions can then be used by upload_pack() in a
> followup commit.

Obviously a pure movement (hooray for --color-moved yet again). Looks
good.

-Peff
