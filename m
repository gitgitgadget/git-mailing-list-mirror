Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D82C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955C620842
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgHDWIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:08:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHDWIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:08:34 -0400
Received: (qmail 6492 invoked by uid 109); 4 Aug 2020 22:08:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 22:08:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17002 invoked by uid 111); 4 Aug 2020 22:08:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 18:08:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 18:08:33 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200804220833.GB2022650@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
 <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
 <20200804195830.GA2014743@coredump.intra.peff.net>
 <87imdyxedw.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87imdyxedw.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 12:58:03AM +0300, Sergey Organov wrote:

> >   - we usually don't have a period at the end of our error messages
> 
> Oops, I got the dot from
> 
>   die("--unpacked=<packfile> no longer supported.");
> 
> in the same file. Will fix.

Yeah, there are a few that have snuck in. I wouldn't be opposed to a
patch to fix that one. :)

-Peff
