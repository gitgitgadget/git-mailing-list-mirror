Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720932037F
	for <e@80x24.org>; Mon, 22 Apr 2019 15:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfDVP2p (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:28:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:36824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726943AbfDVP2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 11:28:45 -0400
Received: (qmail 31304 invoked by uid 109); 22 Apr 2019 15:28:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 15:28:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32349 invoked by uid 111); 22 Apr 2019 15:29:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 11:29:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 11:28:42 -0400
Date:   Mon, 22 Apr 2019 11:28:42 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #04; Mon, 22)
Message-ID: <20190422152842.GC1633@sigill.intra.peff.net>
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
 <20190422145237.v5xjelebyjxb3uko@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422145237.v5xjelebyjxb3uko@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 10:52:38AM -0400, Santiago Torres Arias wrote:

> On Mon, Apr 22, 2019 at 03:10:30PM +0900, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> > 
> > You can find the changes described here in the integration branches
> > of the repositories listed at
> 
> Hi,
> 
> This is the second what's cooking that's gone by without mention of the
> RFC patch regarding verify_tag[1]. Is this due to lack of interest or is
> this an error on my side (f.e., did I forget to send something?).

I think anything marked "RFC" that does not get much discussion is
likely to get overlooked by a busy maintainer. :) I had your patch on my
todo list, and I just wrote up some comments in that thread.

-Peff
