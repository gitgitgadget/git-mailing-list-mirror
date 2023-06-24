Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F349EB64D7
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 01:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFXBSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXBSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 21:18:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563C1715
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 18:18:22 -0700 (PDT)
Received: (qmail 13263 invoked by uid 109); 24 Jun 2023 01:18:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jun 2023 01:18:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8612 invoked by uid 111); 24 Jun 2023 01:18:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jun 2023 21:18:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jun 2023 21:18:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2023, #06; Fri, 23)
Message-ID: <20230624011821.GC95358@coredump.intra.peff.net>
References: <xmqq1qi1aix3.fsf@gitster.g>
 <xmqqo7l59325.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7l59325.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2023 at 04:22:42PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * jk/redact-h2h3-headers-fix (2023-06-17) 1 commit
> >   (merged to 'next' on 2023-06-20 at c1247fd527)
> >  + http: handle both "h2" and "h2h3" in curl info lines
> >
> >  Curl library recently changed how http2 traces are shown and broke
> >  the code to redact sensitive info header, which has been fixed.
> >
> >  Will merge to 'master'.
> >  source: <20230617051559.GD562686@coredump.intra.peff.net>
> 
> Even though this hasn't spent the usual 1 calendar week days in
> 'next', I am inclined to fast-track merge it to 'master' (and
> probably to 'maint'), as GitHub actions CI currently is broken
> with any branch without this fix for macOS jobs.

That makes sense to me. The patch itself is so simple that it seems
low-risk, as well.

-Peff
