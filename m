Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAA5C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F0F20661
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEGUyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:54:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726268AbgEGUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:54:37 -0400
Received: (qmail 2719 invoked by uid 109); 7 May 2020 20:54:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:54:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22034 invoked by uid 111); 7 May 2020 20:54:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:54:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:54:35 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/4] credential: update gitcredentials documentation
Message-ID: <20200507205435.GA39802@coredump.intra.peff.net>
References: <20200505013908.4596-1-carenas@gmail.com>
 <20200506214726.81854-1-carenas@gmail.com>
 <20200506214726.81854-4-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506214726.81854-4-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 02:47:25PM -0700, Carlo Marcelo Arenas Belón wrote:

> +While it is possible to override all attributes, well behaving helpers
> +should refrain from doing so for anyone other than username and password.

The earlier versions said "any attributes other than..." which I think
is a bit more precise than "anyone".

Other than that, this looks good to me.

-Peff
