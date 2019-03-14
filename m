Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D9B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCNS7P (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 14:59:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727348AbfCNS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 14:59:15 -0400
Received: (qmail 31094 invoked by uid 109); 14 Mar 2019 18:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 18:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25561 invoked by uid 111); 14 Mar 2019 18:58:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 14:58:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 14:57:58 -0400
Date:   Thu, 14 Mar 2019 14:57:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
Message-ID: <20190314185758.GB26250@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
 <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1903141410360.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903141410360.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 02:17:18PM +0100, Johannes Schindelin wrote:

> >  2. is there a way to cleanly avoid the three-line duplicate?
> [...]
> Peff tried with a function, but I think that this would actually be a
> really appropriate occasion for a well-placed `goto`:

I worried that a goto would be too confusing/ugly. But I am OK with it
if you are.

-Peff
