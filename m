Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F04C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1598720656
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0MNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:13:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:40730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726390AbgD0MN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 08:13:29 -0400
Received: (qmail 11791 invoked by uid 109); 27 Apr 2020 12:13:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 12:13:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22484 invoked by uid 111); 27 Apr 2020 12:24:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 08:24:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 08:13:28 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>
Subject: Re: Compilation errors in git.pu/refs/reftable-backend.c
Message-ID: <20200427121328.GA1725867@coredump.intra.peff.net>
References: <575af27b-3823-2db5-ad3b-3c6cd7a95faa@web.de>
 <CAFQ2z_O7z2prvnE+v-0nzC3=2mmUBHgFVF+iRqRn-7QyRQxOqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQ2z_O7z2prvnE+v-0nzC3=2mmUBHgFVF+iRqRn-7QyRQxOqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 02:05:12PM +0200, Han-Wen Nienhuys wrote:

> On Mon, Apr 27, 2020 at 6:34 AM Torsten Bögershausen <tboegi@web.de> wrote:
> >
> > Folks, after the integration of the reftable branch:
> > Merge branch 'hn/reftable' into pu
> 
> thanks, I'll fix that.
> 
> I don't understand why Git doesn't enforce this, though.  Couldn't
> -Wdeclaration-after-statement be added to the Makefile if the compiler
> supported it?

Try building with "make DEVELOPER=1" (or putting DEVELOPER=1 in your
config.mak), which will turn on warnings and enable -Werror. See
config.mak.dev for the complete list.

-Peff
