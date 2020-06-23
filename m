Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4779C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C942120716
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbgFWKAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:00:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:39722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731976AbgFWKAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 06:00:16 -0400
Received: (qmail 8993 invoked by uid 109); 23 Jun 2020 10:00:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 10:00:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13489 invoked by uid 111); 23 Jun 2020 10:00:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 06:00:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 06:00:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #04; Mon, 22)
Message-ID: <20200623100015.GA3386564@coredump.intra.peff.net>
References: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 22, 2020 at 05:54:02PM -0700, Junio C Hamano wrote:

> * jk/fast-export-anonym (2020-06-22) 4 commits
>   (merged to 'next' on 2020-06-22 at b517b2f707)
>  + fast-export: allow dumping the path mapping
>  + fast-export: refactor path printing to not rely on stdout
>  + fast-export: anonymize "master" refname
>  + fast-export: allow dumping the refname mapping
> 
>  The way refnames are anonymized has been updated and a way to help
>  debugging using the anonymized output hsa been added.
> 
>  Will merge to 'master'.

This graduated much faster than I expected. I really did mean my "I'll
look at this other direction" literally. I should have something to show
later today. :)

The two techniques could complement each other, but I think the other
one might be sufficient, and seems to be coming out a little cleaner.

-Peff
