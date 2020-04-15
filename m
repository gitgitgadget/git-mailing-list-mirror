Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4351C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A02208E4
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414735AbgDOPrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:47:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:54584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1414913AbgDOPrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:47:14 -0400
Received: (qmail 12691 invoked by uid 109); 15 Apr 2020 15:47:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 15:47:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4395 invoked by uid 111); 15 Apr 2020 15:57:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 11:57:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 11:47:11 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Bannister <adam.bannister@portswigger.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Media query - Git flaw
Message-ID: <20200415154711.GD2464307@coredump.intra.peff.net>
References: <CAJQu+bp9SrzaMBuMv1UC8y8rJGn15MAsVogSCm_DNDKRMji1+Q@mail.gmail.com>
 <xmqqwo6g7p55.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo6g7p55.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 08:19:18AM -0700, Junio C Hamano wrote:

> > What is your advice to Git users?
> 
> Release is announced and users are urged to upgrade, like you wrote
> on your article at The Daily Swig.

There's a little more detail and some workarounds discussed in the
advisory at:

 https://github.com/git/git/security/advisories/GHSA-qm7j-c969-7j4q

-Peff
