Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA752C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 19:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiG0TUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiG0TTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 15:19:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1036D9F0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 12:12:47 -0700 (PDT)
Received: (qmail 9060 invoked by uid 109); 27 Jul 2022 19:12:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jul 2022 19:12:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2479 invoked by uid 111); 27 Jul 2022 19:12:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jul 2022 15:12:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jul 2022 15:12:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Junio C Hamano <junio@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: ds/midx-with-less-memory
Message-ID: <YuGOLXc3QWqPc8wC@coredump.intra.peff.net>
References: <xmqqh738bq21.fsf@gitster.g>
 <YuBlD3o5bYMg8f6i@coredump.intra.peff.net>
 <xmqqv8risi9w.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8risi9w.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 27, 2022 at 08:10:51AM -0700, Junio C Hamano wrote:

> Nice.  Is this -Wunused-parameter at work?

Yep. I've been offline a bit recently, but I'm hoping to start sending
patches to get that work upstreamed (it's not complicated, it's just a
ton of patches to annotate all of the callbacks, etc, that need to have
unused parameters in them).

-Peff
