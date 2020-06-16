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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CEC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B3020707
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="HTtn+p9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgFPR0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:26:10 -0400
Received: from huan5.mail.rambler.ru ([81.19.78.4]:39048 "EHLO
        huan5.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFPR0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=7D3S4hwFhfrmUizz6KgAY81MMTyHevvtQLfCs+G+4vI=; b=HTtn+p9ZWRLsd+yLbXP28KiXsI
        pAZTx5VrRxaMyUjA5kLWvogtx9qtjfjSNZOaUhCwnVj31x/r3HGY/ATzyr/LZJIlcvNwfCx2sS4Rh
        +fNVB1za7CGT8QTJjceoZ33W7lACPsVpGoNImjaJhlDIksSbUBEk7K+vqr4JPWOJAzps=;
Received: from [UNAVAILABLE] ([194.190.114.28]:44494 helo=localhost)
        by huan5.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlFLc-0006CR-K7
        for git@vger.kernel.org; Tue, 16 Jun 2020 20:26:08 +0300
Date:   Tue, 16 Jun 2020 20:27:49 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616172749.GB18874@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
 <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <20200616142651.GA27946@legohost>
 <20200616160349.t65we3jkpq7hqwra@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616160349.t65we3jkpq7hqwra@chatter.i7.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 12:03:49PM -0400, Konstantin Ryabitsev wrote:
> It doesn't matter how few repositories need it. If you've been on this 
> list, you would have seen patches being submitted and accepted that fix 
> bugs in corner cases that can't possibly be experienced by the vast 
> majority of Git users.

"master" branch is not the bug. There is nothing to fix here. There is
need to fix something in somebody heads, not in the code.

> For the same reason any other useful feature didn't appear earlier.  
> Nobody has brought it up or spent enough time considering it.

This feature isn't considered enough time. It like a rocket.

> > No. They wann't. Tell you as cyrillic user, some conventions exist that
> > branches and tags should be in ASCII(no one with a sane mind want to
> > not to do so). And if you want to make a public repo and collaborate
> > with others you will use ASCII in any case. Otherwise nobody understand you.
> 
> 1C scripting language is written entirely in Russian. Many official

1C is a bad example and you know this :-).

> Russian sites use .рф domain names. If someone wants to make all their 
> branch names in Cyrillic, why should we prevent them from doing so?

Because there are no such people. You try to fix non-existent problem.

> > May be they assume this, because about 15 years master branch was *always*
> > here, didn't think about it :-D? And nobody told that somebody will come and
> > break it somewhen.
> 
> Very soon we'll break git hashes from being sha1 by default. Just 
> because they've been sha1 for the past 15 years doesn't mean we 
> shouldn't or can't do it.

Hm. No. Replacing of sha1 have technical reasons and this change have not.
If "master" name will stay as a default, this change will make at least
some sense.

Somebody, may be you, told here that this "amazing feature" can be easily
configured with help of configuration files in any distros. So, let's
set "master" name a default and github(i'm shure it have at least one competent
admin that can edit a config file of git) change this setting by itself.
It's logically correct to set default to a value that *most* users want and
give a minority a way to change this setting.

-- 
Олег Неманов (Oleg Nemanov)
