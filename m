Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5591A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 17:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeJLBU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 21:20:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:37572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726886AbeJLBU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 21:20:28 -0400
Received: (qmail 29434 invoked by uid 109); 11 Oct 2018 17:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 17:52:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587 invoked by uid 111); 11 Oct 2018 17:51:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 13:51:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 13:52:10 -0400
Date:   Thu, 11 Oct 2018 13:52:10 -0400
From:   Jeff King <peff@peff.net>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011175209.GB8825@sigill.intra.peff.net>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <xmqq4ldtgehs.fsf@gitster-ct.c.googlers.com>
 <0f401a50-3c4c-5d09-a8b1-58ae80f5a210@umanovskis.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f401a50-3c4c-5d09-a8b1-58ae80f5a210@umanovskis.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 07:29:58PM +0200, Daniels Umanovskis wrote:

> > Without passing the &flag argument, I do not think there is a
> > reliable way to ask resolve_ref_unsafe() if "HEAD" is a symbolic
> > ref.
> 
> If I'm reading the code correctly, resolve_ref_unsafe() will return
> "HEAD" or NULL if there's no symbolic reference, so anything else would
> indicate a symref, but even in that case checking the flag explicitly is
> definitely better to clearly show intent.

Yes, that matches my understanding, too.

-Peff
