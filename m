Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE9C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F961051
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbhIBJUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:20:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:37262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245121AbhIBJUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:20:05 -0400
Received: (qmail 21826 invoked by uid 109); 2 Sep 2021 09:18:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:18:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22861 invoked by uid 111); 2 Sep 2021 09:18:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:18:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:18:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 0/2] send_ref buffering
Message-ID: <YTCW+yeQ47OcnEMO@coredump.intra.peff.net>
References: <xmqqy28htrc6.fsf@gitster.g>
 <20210901125442.34446-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901125442.34446-1-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 02:54:40PM +0200, Jacob Vosmaer wrote:

> Changes:
> - pkt-line.h comment
> - fwrite argument order
> 
> Jacob Vosmaer (2):
>   pkt-line: add stdio packet write functions
>   upload-pack: use stdio in send_ref callbacks

Thanks, this version looks good to me.

-Peff
