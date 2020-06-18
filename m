Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A8C433E2
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B757B214DB
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="NLivtkK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgFRIgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:36:47 -0400
Received: from huan9.mail.rambler.ru ([81.19.78.8]:38990 "EHLO
        huan9.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgFRIgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=o+kjAzMw9jZsa2zWmwwrAu390DkrtJQYYqELSxlfOjg=; b=NLivtkK7xF/6K+iD9TznBSHx6D
        H4faGgzz3OojvuzG7frOdv29WRvMUoZqQlcrmD7Ca292abpoHm2WmTCVCNzhhPRsyFvdH9SCydy/q
        L4b2x5oMOWMjYEPqaup987uGsgmVNyeu4mfwDOiUOHmilbAgPjDdHkZKs265vHNdYiLk=;
Received: from [UNAVAILABLE] ([194.190.114.28]:54894 helo=localhost)
        by huan9.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlq2N-0003M9-An
        for git@vger.kernel.org; Thu, 18 Jun 2020 11:36:43 +0300
Date:   Thu, 18 Jun 2020 11:38:25 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     Git <git@vger.kernel.org>
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200618083825.GB20837@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
 <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz>
 <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
 <20200617201037.GA86579@google.com>
 <20200617201709.GB86579@google.com>
 <CANgJU+WbPgSTxQ=G3sFSvNFQ1cL3onYk5yKLBR=3AqWeEUCfZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANgJU+WbPgSTxQ=G3sFSvNFQ1cL3onYk5yKLBR=3AqWeEUCfZQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 09:57:42AM +0200, demerphq wrote:
> Ultimately if I was the decision maker here I would be choosing terms
> that are as workflow agnostic as I can find. "main", "master" and
> "primary" are not workflow agnostic, they are if anything a bit
> workflow opinionated. "trunk" on the other hand seems pretty
> self-descriptive and doesn't have much baggage. It's bark is worse
> than its byte however. :-)

The most workflow agnostic name is "branch". it is so neutral that you want to
change it ASAP :-).

-- 
Олег Неманов (Oleg Nemanov)
