Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0BEC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206AF20A8B
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgEFQ2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:28:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:39098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729414AbgEFQ2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:28:00 -0400
Received: (qmail 22955 invoked by uid 109); 6 May 2020 16:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 May 2020 16:27:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8835 invoked by uid 111); 6 May 2020 16:27:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 May 2020 12:27:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 May 2020 12:27:58 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH] docs: document credential.helper allowed values
Message-ID: <20200506162758.GC1275237@coredump.intra.peff.net>
References: <20200505231226.1280264-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505231226.1280264-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 11:12:26PM +0000, brian m. carlson wrote:

> gitcredentials(7) already mentions several possible invocations that one
> can use as the value for credential.helper.  However, many people are
> not aware that there are other options than a simple credential helper
> name, so let's place some explanatory text in the documentation for
> credential.helper as well.
> 
> We still refer the user to gitcredential(7) for additional explanations
> and helpful examples.

Yeah, this seems like an improvement to me.

-Peff
