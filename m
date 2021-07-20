Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24EC636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E76E6100C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhGTTV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:21:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:55292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233642AbhGTTVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:21:20 -0400
Received: (qmail 4751 invoked by uid 109); 20 Jul 2021 20:01:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jul 2021 20:01:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26724 invoked by uid 111); 20 Jul 2021 20:01:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jul 2021 16:01:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Jul 2021 16:01:54 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
Message-ID: <YPcrslQNmqvlBYpX@coredump.intra.peff.net>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
 <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
 <CAN0heSoz8KmmtX8LVcY2wBM6Fm4TAYwDmQGPE8wpdZTmWRVzWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoz8KmmtX8LVcY2wBM6Fm4TAYwDmQGPE8wpdZTmWRVzWA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 09:34:43PM +0200, Martin Ågren wrote:

> On Thu, 15 Jul 2021 at 00:25, Jeff King <peff@peff.net> wrote:
> > -       Use the given config file instead of the one specified by GIT_CONFIG.
> > +       For writing options: write to the specified file rather than the
> > +       repository `.git/config`.
> > ++
> > +For reading options: read only from the specified file rather than from all
> > +avialable files.
> 
> s/avialable/available/

Thanks. You'd think that I would have gotten the part cut-and-paste from
earlier right. :)

I double-checked the rest of the series for other spelling errors but
didn't see any. This is marked for merging to next, but hasn't made it
yet. So if you get this in time, Junio, can you please squash this into
the first patch?

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 193fef2867..6c78ad1c13 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -147,7 +147,7 @@ See also <<FILES>>.
 	repository `.git/config`.
 +
 For reading options: read only from the specified file rather than from all
-avialable files.
+available files.
 +
 See also <<FILES>>.
 

-Peff
