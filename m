Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C81C3F2C2
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 22:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82732469F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 22:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgB0W6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:58:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:56712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726845AbgB0W6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 17:58:53 -0500
Received: (qmail 32350 invoked by uid 109); 27 Feb 2020 22:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Feb 2020 22:58:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11486 invoked by uid 111); 27 Feb 2020 23:08:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Feb 2020 18:08:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Feb 2020 17:58:52 -0500
From:   Jeff King <peff@peff.net>
To:     lyle.ziegelmiller@gmail.com
Cc:     'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: ! [remote rejected] master -> master (unpacker error)
Message-ID: <20200227225852.GA1370873@coredump.intra.peff.net>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com>
 <20200216211604.GE6134@camp.crustytoothpaste.net>
 <20200218051956.GA1641086@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002272204150.46@tvgsbejvaqbjf.bet>
 <004201d5edb4$3dc34040$b949c0c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <004201d5edb4$3dc34040$b949c0c0$@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 27, 2020 at 01:24:04PM -0800, lyle.ziegelmiller@gmail.com wrote:

> " But I vividly remember that there used to be a problem even with
> `git.exe`, probably still is a problem on older Windows versions. That might
> be the problem here?"
> 
> I'm using the latest version of Windows 10 and Cygwin's version of git -
> version 2.21.0. This is being executed in a Cygwin window, not a DOS
> terminal.
> 
> All of this stuff used to work.

If you have a version of Git that works and one that doesn't, it might
be worth using git-bisect to find the commit that introduced the
problem. That does imply being able to build from source; I don't know
how hard that is on cygwin.

-Peff
