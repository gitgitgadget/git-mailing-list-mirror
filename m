Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA79C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328E3611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhECUeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:34:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:43494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECUd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:33:58 -0400
Received: (qmail 7461 invoked by uid 109); 3 May 2021 20:33:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:33:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7279 invoked by uid 111); 3 May 2021 20:33:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:33:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:33:03 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 9/9] docs: document symlink restrictions for dot-files
Message-ID: <YJBd/9rSkLQ68ECy@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI13DTkOpDRP4YGa@coredump.intra.peff.net>
 <CAPig+cTmL3R=xB_zjFLZkZ3X4pOABj-OvLsbDsW91WKCv-bjHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTmL3R=xB_zjFLZkZ3X4pOABj-OvLsbDsW91WKCv-bjHA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 01, 2021 at 03:16:09PM -0400, Eric Sunshine wrote:

> Just a really microscopic nit... feel free to ignore...
> 
> > diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> > @@ -1247,6 +1247,13 @@ to:
> > +NOTES
> > +-----
> > +
> > +Note that Git does not follow symbolic links when accessing a
> > +`.gitattributes` file in the working tree. This keeps behavior
> > +consistent when the file is accessed from the index or a tree versus
> > +from the filesystem.
> 
> We're in the "NOTES" section, so it feels redundant to begin the
> sentence with "Note that".

Thanks. I think it's a good suggestion. I agree it's pretty minor, but
I'm going to re-roll anyway to drop the test_i18ngrep, so I'll reword
this, too.

-Peff
