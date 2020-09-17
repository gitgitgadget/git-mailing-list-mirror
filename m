Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D53C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0502083B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgIQNCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:02:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgIQNBz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 09:01:55 -0400
Received: (qmail 418 invoked by uid 109); 17 Sep 2020 13:01:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 13:01:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8313 invoked by uid 111); 17 Sep 2020 13:01:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Sep 2020 09:01:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Sep 2020 09:01:39 -0400
From:   Jeff King <peff@peff.net>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Has there been a change in Git Mailing List settings?  From list
 as sender to originator as sender?
Message-ID: <20200917130139.GB3024501@coredump.intra.peff.net>
References: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR02MB408170D1A71FB8C0E82A14789C3E0@AM0PR02MB4081.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 10:11:17AM +0000, Kerry, Richard wrote:

> Has there been a change in Git Mailing List settings?
> Up until sometime late yesterday, messages from the list came from
> git-owner@vger.kernel.org, on behalf of the originator.  Now messages
> are coming directly from the originator.  This means my Inbox rules
> have stopped working.
> 
> Is this a deliberate change?  Unexpected change in mailing list
> software?  Will it be changed back?

Not to my knowledge. The smtp-level envelope from on all of the messages
I've received is git-owner@vger.kernel.org. Is there some other
mechanism you might be filtering on?

(If you're not already, a reliable way to detect list messages is by the
List-ID or X-Mailing-List headers, both of which are sent by the list
software).

This may be further complicated, though, by the fact that the convention
on this list is to cc people in responses. So you may receive a non-list
copy of such a response. Though I don't see you cc'd on a lot of
responses lately.

-Peff
