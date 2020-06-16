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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F54C433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B270F20679
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="h+HgGRoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgFPOvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:51:14 -0400
Received: from huan6.mail.rambler.ru ([81.19.78.5]:42628 "EHLO
        huan6.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOvN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=oLfS8mBkQr7GIoFAiSDp8u6cAgTxQiPujoCaiVGUnmE=; b=h+HgGRoJJoxHRRKN18reI+/n6G
        zXJHm9nmlsw5M1wI7ypLIe5j3wjIe6gDABwXiE3dllfSZaTb+am65w9hK4TYSTDPMQOc7zd7EHjvg
        SSLoPa+ZeWyGob2cLdRTw7roPq9HRbFqGAf8FzIxFGcJJOX6cuoqX0ieJ3hI621ah2Ew=;
Received: from [UNAVAILABLE] ([194.190.114.28]:36318 helo=localhost)
        by huan6.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlCve-0001DE-Nv
        for git@vger.kernel.org; Tue, 16 Jun 2020 17:51:10 +0300
Date:   Tue, 16 Jun 2020 17:52:52 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616145207.GA13998@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616143107.GL666057@coredump.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 10:31:07AM -0400, Jeff King wrote:
> stopping at configurability is the least risky thing there. But it's
> clear that a lot of projects are interested in changing their names, so

Jeff, where do you get your statistics? github, for example, have around
100 million repos. How many of them want to do it?

> > > My interpretation thus far is that 'main' is the planned replacement for
> > > 'master'. Consensus seems to have formed around this name [5], but if that's
> > > incorrect--or there are yet-unvoiced opinions that you would like to share--now
> > > is the time to discuss further.
> 
> My opinion is that "main" is the best suggestion I've heard.

I have a better suggestion, imho. Let's make "master" a default name. Thus:

1. we willn't break utilities and user hopes; this is a backward compatibility.
2. we will see how many projects really need this "feature".

I think backward compatibility is a reasonable and useful thing. And if this is
not a political-driven changes, i see no technical reason to not do so.

-- 
Олег Неманов (Oleg Nemanov)
