Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD880C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B319B2073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 17:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHJRVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:21:16 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53067 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgHJRVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 13:21:16 -0400
Received: from panel-Aspire-1425P (unknown [IPv6:2a01:e0a:562:1540:a670:ff22:ed7e:bd05])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 4E83113F8CD;
        Mon, 10 Aug 2020 19:20:39 +0200 (CEST)
Message-ID: <1597080038.3096.1.camel@free.fr>
Subject: Re: git bug
From:   PANEL Christian <ch.panel@free.fr>
To:     =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Mon, 10 Aug 2020 19:20:38 +0200
In-Reply-To: <c223cb39-501f-8ed1-9b82-2f7c2cb22886@web.de>
References: <1596725319.6764.7.camel@free.fr>
         <5387a5b7-4551-53a0-abdb-e26cc2702536@web.de>
         <20200807000226.GA12088@coredump.intra.peff.net>
         <c223cb39-501f-8ed1-9b82-2f7c2cb22886@web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

thanks a lot.
It was exactly what I was seaching (and havent' read yet ;) )

best regards

Le lundi 10 août 2020 à 07:56 +0200, René Scharfe a écrit :
> Am 07.08.20 um 02:02 schrieb Jeff King:
> > 
> > On Thu, Aug 06, 2020 at 10:23:54PM +0200, René Scharfe wrote:
> > 
> > > 
> > > So "file" is no longer ignored.  Committing the .gitignore change
> > > doesn't change that:
> > > 
> > >   $ git add .gitignore
> > >   $ git commit -m 2nd
> > >   [master d4c95a1] 2nd
> > >    1 file changed, 1 deletion(-)
> > >   $ git status
> > >   On branch master
> > >   Untracked files:
> > >     (use "git add <file>..." to include in what will be committed)
> > >   	file
> > > 
> > >   nothing added to commit but untracked files present (use "git add" to track)
> > > 
> > > Which steps did you take to arrive at a different result?
> > Perhaps also:
> > 
> >   git check-ignore -v file
> > 
> > would be helpful for seeing why Git thinks it might be ignored (e.g.,
> > another wildcard rule that happens to match it).
> Right.  And there is more than one possible place to specify files to be
> ignored.  E.g. you can use info/exclude in your Git directory (i.e.
> .git/info/exclude by default) for repository-specific patterns don't
> want to share.  See https://git-scm.com/docs/gitignore or the manpage
> of gitignore(5) for more details.
> 
> René

