Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E1EE49A3
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHTAgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjHTAfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:35:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B3C3B52
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 17:03:18 -0700 (PDT)
Received: (qmail 26822 invoked by uid 109); 20 Aug 2023 00:03:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 20 Aug 2023 00:03:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23195 invoked by uid 111); 20 Aug 2023 00:03:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Aug 2023 20:03:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Aug 2023 20:03:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2023, #06; Fri, 18)
Message-ID: <20230820000316.GA601058@coredump.intra.peff.net>
References: <xmqq8ra7u5jn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8ra7u5jn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 07:31:08PM -0700, Junio C Hamano wrote:

> Git 2.42 will be released early next week.

Since the release is soon, I just wanted to call your attention to:

  https://lore.kernel.org/git/20230819235342.GA600744@coredump.intra.peff.net/

which fixes a very minor regression. It's small enough that I suspect
nobody would even notice, but the fix is small and obvious enough that
it is probably OK to apply between -rc2 and the release.

-Peff
