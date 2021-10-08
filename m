Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5368C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A180B60F90
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhJHSQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:16:58 -0400
Received: from colin.muc.de ([193.149.48.1]:44348 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S231308AbhJHSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 14:16:57 -0400
Received: (qmail 13492 invoked by uid 3782); 8 Oct 2021 18:15:00 -0000
Received: from acm.muc.de (p2e5d5cb1.dip0.t-ipconnect.de [46.93.92.177])
 (using STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Fri, 08 Oct 2021 20:15:00 +0200
Received: (qmail 8688 invoked by uid 1000); 8 Oct 2021 18:15:00 -0000
Date:   Fri, 8 Oct 2021 18:15:00 +0000
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: How do I get the file contents from an arbitrary revision to
 stdout?
Message-ID: <YWCKpH5ER1Z9Xm3E@ACM>
References: <YWCFFcNeNVTYcELN@ACM>
 <20211008180123.ls62virahqthgpmb@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008180123.ls62virahqthgpmb@meerkat.local>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Konstantin.

On Fri, Oct 08, 2021 at 14:01:23 -0400, Konstantin Ryabitsev wrote:
> On Fri, Oct 08, 2021 at 05:51:17PM +0000, Alan Mackenzie wrote:
> > Hello, git.
> > 
> > I want to get a file's content from a particular revision onto stdout for
> > backup purposes.  I can't see how to do this.  Help me, please!
> > 
> > Let's say the file is foo.c, and I want to get the version from the head
> > revision of bar-branch.

> git show bar-branch:foo.c

Thank you indeed.  That works just right!

> -K

-- 
Alan Mackenzie (Nuremberg, Germany).
