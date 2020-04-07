Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5FC2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC7220747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgDGOwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:52:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:35774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728855AbgDGOwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:52:33 -0400
Received: (qmail 2184 invoked by uid 109); 7 Apr 2020 14:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Apr 2020 14:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28408 invoked by uid 111); 7 Apr 2020 15:02:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2020 11:02:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Apr 2020 10:52:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josep Torra <n770galaxy@gmail.com>, git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
Message-ID: <20200407145232.GA1839328@coredump.intra.peff.net>
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
 <20200403185804.GA659704@coredump.intra.peff.net>
 <20200403193644.GA662633@coredump.intra.peff.net>
 <xmqq8sjcz6pd.fsf@gitster.c.googlers.com>
 <20200404152032.GC679473@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200404152032.GC679473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 04, 2020 at 11:20:33AM -0400, Jeff King wrote:

> I think the next step is to report it to launchpad folks and let them
> figure it out. I opened a bug there:
> 
>   https://bugs.launchpad.net/launchpad/+bug/1870804

Looks like this is now fixed:

  https://bugs.launchpad.net/turnip/+bug/1870080

-Peff
