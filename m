Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E9C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC38420829
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="oWUw4Hrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgGaIRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:17 -0400
Received: from huan9.mail.rambler.ru ([81.19.78.8]:57824 "EHLO
        huan9.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbgGaIRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=AiNdIwvBBfVdrKtxPWKbAF4YFFLfL0fMhgf+t6690sk=; b=oWUw4Hrt/MAdGcD7ulhNoaymTX
        62y2HQ8TgjjVG14MIqEe/jH1MxzJJSWmN6S1abWrXJy4DxEV21fXRePHlhz6XnKMsRczcT/G3FLb4
        l29VpIzOv0SV27AkD3tXnykp7fyM/OzJCruBNWter8Ua8KJ/oLQMGBG3FEAsVSgC2wuY=;
Received: from [UNAVAILABLE] ([194.190.114.28]:45482 helo=localhost)
        by huan9.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1k1QE7-0002iU-E3
        for git@vger.kernel.org; Fri, 31 Jul 2020 11:17:15 +0300
Date:   Fri, 31 Jul 2020 11:19:25 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200731081925.GA5533@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <20200729203856.GA519065@google.com>
 <20200730081743.GA24210@legohost>
 <20200731005721.GC240563@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731005721.GC240563@coredump.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 08:57:21PM -0400, Jeff King wrote:
> On Thu, Jul 30, 2020 at 11:17:43AM +0300, lego_12239@rambler.ru wrote:
> > On Wed, Jul 29, 2020 at 01:38:56PM -0700, Jonathan Nieder wrote:
> > > The commit message describes its intent
> > >   commit 489947cee5095b168cbac111ff7bd1eadbbd90dd
> > >   Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > >   Date:   Tue Jun 23 22:33:23 2020 +0000
> > > 
> > >       fmt-merge-msg: stop treating `master` specially
> > > 
> > >       In the context of many projects renaming their primary branch names away
> > >       from `master`, Git wants to stop treating the `master` branch specially.
> > 
> > Wow. Jonathan, you are a good student of Goebbels! "many projects" :-D.
> > You lie. These are few but very noisy projects. Don't kid youself.
> 
>   - the text you are responding to isn't even Jonathan's; it was a
>     quoted commit message to give context.

Yes. It's my mistake. Sorry.

>   - if you really do want re-open the argument about whether projects
>     are interested in changing branch names, it might help to provide
>     some actual data. Most of the data-less points (on both sides) have
>     already been made in past discussions.

Most of the actual data have already been made, but polytics won out over
common sense.

-- 
Олег Неманов (Oleg Nemanov)
