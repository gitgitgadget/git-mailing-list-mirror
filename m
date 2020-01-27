Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB142C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84D62467B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA0XML (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:12:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:45798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726205AbgA0XML (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:12:11 -0500
Received: (qmail 4686 invoked by uid 109); 27 Jan 2020 23:12:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 23:12:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2036 invoked by uid 111); 27 Jan 2020 23:19:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 18:19:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 18:12:09 -0500
From:   Jeff King <peff@peff.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
Message-ID: <20200127231209.GC19360@coredump.intra.peff.net>
References: <20200127070238.GA32427@coredump.intra.peff.net>
 <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 10:25:03AM +0100, Bert Wesarg wrote:

> The documentation for push.default mentions that it is used if no
> refspec is "explicitly given". Let's clarify that giving a refspec on
> the command-line _or_ in the config will override it.

Yep, looks good to me.

> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

I don't know that we need my S-o-b anymore. The content in this one is
all you. :) (But certainly I don't mind endorsing it).

-Peff
