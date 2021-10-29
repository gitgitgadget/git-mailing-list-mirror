Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BFC4332F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15A060F23
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJ2OXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:23:48 -0400
Received: from cvs.openbsd.org ([199.185.137.3]:19263 "EHLO cvs.openbsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231328AbhJ2OXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:23:47 -0400
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id a4d3deee;
        Fri, 29 Oct 2021 08:21:18 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     rsbecker@nexbridge.com
cc:     "'Alejandro Colomar \(man-pages\)'" <alx.manpages@gmail.com>,
        "'Libc-alpha'" <libc-alpha@sourceware.org>,
        "'linux-man'" <linux-man@vger.kernel.org>, git@vger.kernel.org,
        tech@openbsd.org
Subject: Re: Is getpass(3) really obsolete?
In-reply-to: <00e401d7cccf$ccde0d40$669a27c0$@nexbridge.com>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com> <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com> <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com> <63238.1635515736@cvs.openbsd.org> <00e401d7cccf$ccde0d40$669a27c0$@nexbridge.com>
Comments: In-reply-to <rsbecker@nexbridge.com>
   message dated "Fri, 29 Oct 2021 10:18:04 -0400."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4441.1635517278.1@cvs.openbsd.org>
Date:   Fri, 29 Oct 2021 08:21:18 -0600
Message-ID: <73029.1635517278@cvs.openbsd.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> wrote:

> > > getpass() is obsolete in POSIX.2. However, some platforms still are on
> POSIX.1,
> > so replacing it instead of providing a configure detection/switch for it
> might
> > cause issues.
> > 
> > 
> > The community finally had the balls to get rid of gets(3).
> > 
> > getpass(3) shares the same flaw, that the buffer size isn't passed.
> > This has been an issue in the past, and incorrectly led to
> readpassphrase(3)
> > 
> > readpassphrase(3) has a few too many features/extensions for my taste, but
> at
> > least it is harder to abuse.
> 
> readpassphrase is not generally supported. This will break builds on many
> platforms.

Of course moving forward takes a long time.  If a better API is supplied
then there is a choice in 10 years.  If a better API is not supplied,
then 10 years from now this conversation can get a reply.



