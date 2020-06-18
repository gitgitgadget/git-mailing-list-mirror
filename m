Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9BFC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE220890
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgFRQpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:45:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:36318 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgFRQpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 12:45:55 -0400
Received: (qmail 20428 invoked by uid 109); 18 Jun 2020 16:45:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2020 16:45:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16512 invoked by uid 111); 18 Jun 2020 16:45:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2020 12:45:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Jun 2020 12:45:54 -0400
From:   Jeff King <peff@peff.net>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: do not use "slave branch" nomenclature
Message-ID: <20200618164554.GA616157@coredump.intra.peff.net>
References: <20200618163843.22181-1-bonzini@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618163843.22181-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 06:38:43PM +0200, Paolo Bonzini wrote:

> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Git does not have slave branches and has never had.  Independent
> of any future change to the naming of branches, remove the sole
> appearance of the term.

I think this is a sensible change, though note that something simpler
was proposed recently:

  https://lore.kernel.org/git/20200610165441.iktvzuwz44sbytfg@chatter.i7.local/

and the review suggested using a name that is even more meaningful to
the test case (so we not just remove the unwanted names, but make the
test easier to follow).

-Peff
