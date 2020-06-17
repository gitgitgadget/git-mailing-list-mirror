Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D2C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BED208D5
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="aQ/uqw+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFQHsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:48:01 -0400
Received: from huan7.mail.rambler.ru ([81.19.78.6]:41090 "EHLO
        huan7.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQHsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 03:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=zm90rucxgT2MXVHurV5/dfE/wA/xJJvO17F0sS+TKog=; b=aQ/uqw+F12u66f+irPwcPpFXHi
        sjxgv3YOC1V47hKEAeVwp29fE0XwvYL81XnRPT6qvP2H5AZtPmCyrpen6iQEgkY6pIqbRSCG72R4V
        bsvIo21sNAuvUyt9al9QWWJnzNdJhoxrbtmChfh6H+/FuyHxnOIs11PFMdZjI9bwIqrQ=;
Received: from [UNAVAILABLE] ([194.190.114.28]:46054 helo=localhost)
        by huan7.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlSnf-0004z5-7w
        for git@vger.kernel.org; Wed, 17 Jun 2020 10:47:59 +0300
Date:   Wed, 17 Jun 2020 10:49:40 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200617074940.GB18445@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200616210701.22924-1-zeevriend@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616210701.22924-1-zeevriend@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 11:07:01PM +0200, ZeeVriend wrote:
> First I want to thank you for the time. I think the change is good and discussion about inclusive really necessary.
> Let me tell you I have Congolese ancestry. Today I develop in Brussels, Belgium - the irony you see, is not :-)
> Second let me tell you the new master name 'main' is not so good chosen. In french 'main' LITERALLY means 'hand'. The recent
> history in Congo will explain why this is bad. Not long ago slaves in Congo because of Belgian rulers. Very sad history, because
> hands were cut off! Many Africans today still have family from then. My grandparents can tell me horrible stories when I visit :-(
> I think you can see now why 'hand' or 'main' is very offensive to us. I can tell you, for French Africans this is MORE offensive
> than 'master'! Because this reason, we do not want to be reminded of hands while using git.
> Third I can suggest 2 more neutral alternatives. First one is 'default', which has almost same meaning in French. Second alternative
> is 'zero' or 'branch0'. I like this one more, because it has an exact same meaning in French! Also it is very neutral and programmers

No-no. Please. "branch" is sounds bad for cyrillic hear and has bad
associations. Like a "брань". "zero" is like a "nothing" or "looser".


-- 
Олег Неманов (Oleg Nemanov)
