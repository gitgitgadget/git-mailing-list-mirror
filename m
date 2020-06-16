Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFEC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB3C20882
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="JKfsMmFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFPOZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:25:22 -0400
Received: from huan10.mail.rambler.ru ([81.19.78.9]:56392 "EHLO
        huan10.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=1V3C1kTyGWtp2Dh/S+YbEIKpS6w0Wuymf3xPlgJ2RKE=; b=JKfsMmFORWc7s8FPgznkbM6lY/
        pQu0GUTXt5diisqH1fWxGuH1gZzygUFp2BTxsmhpqC1DCIa00Xd6B1r0GaG2wpKM1bj2JN/fHe6Rg
        eyZTVGSp8Ii8MsF1K4F0hY4F9YTClnNyFDU4pcpsPYkbxuwGH/6kOjfwCmi1FX4p/K2w=;
Received: from [UNAVAILABLE] ([194.190.114.28]:40904 helo=localhost)
        by huan10.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlCWe-0003Wt-BL
        for git@vger.kernel.org; Tue, 16 Jun 2020 17:25:20 +0300
Date:   Tue, 16 Jun 2020 17:27:01 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616142651.GA27946@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
 <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 09:30:54AM -0400, Konstantin Ryabitsev wrote:
> Let's leave emotionally charged rhetoric and discuss this like 
> reasonable human beings.

If we were all reasonable human beings, then this "useful" feature
would wait in order until other really useful things to be done.

> Here are facts:
> 2. Branch naming is entirely the choice of individual repository 
>    maintainers. Some prefer not to have a "master" branch, and it's not

Some :-)? This "some" are very few people/projects and no one of them have
serious reasons to do it(it pampering).

>    simply because of "political correctness" reasons as everyone 
>    insists:

You are simply lie, because i don't think that you don't understand that this
statement is wrong. If so, why this "useful" feature didn't appear earlier? So
many people/projects suffer without it all time until today, isn't it?

>    - they may prefer to have "stable" and "development" branches

And what do stop from doing this now? Existent master branch?

>    - they may want to use localized names for all their naming 
>      conventions (using Cyrillic, Hanzi, Kana, whatever)

No. They wann't. Tell you as cyrillic user, some conventions exist that
branches and tags should be in ASCII(no one with a sane mind want to
not to do so). And if you want to make a public repo and collaborate
with others you will use ASCII in any case. Otherwise nobody understand you.

>    - they may be goofing off (there's a furry-related repository on 
>      GitHub with the main branch called "yiffed")

Hm... Is this a technical reason?
So, i've read some fantasies and nothing that looks like technical reasons for
such changes.

> 3. In your example, "millions and billions" of scripts are already wrong 
>    if they assume that there is always a "master" branch. However, it

May be they assume this, because about 15 years master branch was *always*
here, didn't think about it :-D? And nobody told that somebody will come and
break it somewhen.

> 4. In Git, local branch names do not need to map to remote branch names.  
>    Your local branch "upstream" can track remote branch "development".  
>    If the remote branch gets renamed, you simply update your 
>    configuration and continue without change.

We have so little problems and difficulties, that yet another one willn't
make our life more hard.

-- 
Олег Неманов (Oleg Nemanov)
