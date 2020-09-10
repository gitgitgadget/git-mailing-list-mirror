Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27193C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADD5214F1
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 12:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgIJMmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:42:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbgIJMkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 08:40:09 -0400
Received: (qmail 20111 invoked by uid 109); 10 Sep 2020 12:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 12:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18453 invoked by uid 111); 10 Sep 2020 12:39:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 08:39:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 08:39:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] quote_path() clean-ups
Message-ID: <20200910123944.GD57925@coredump.intra.peff.net>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 01:52:18PM -0700, Junio C Hamano wrote:

> So, this is an alternative approach to tackle the same issue
> <xmqq4ko8yxp9.fsf@gitster.c.googlers.com> tried to address.  It
> ended up to be more involved than I would have liked, but it was
> primarily because it needed some function signature changes.

This looks like an improvement to me. I left a few minor comments that
might be worth addressing, and a few whose resolution is probably "well,
we _could_ do that but it's not worth spending more time on this".

-Peff
