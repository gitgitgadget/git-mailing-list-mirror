Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA3BC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340392074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="AIZzkcw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgG3IPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:15:39 -0400
Received: from huan10.mail.rambler.ru ([81.19.78.9]:52412 "EHLO
        huan10.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgG3IPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=Ibxewch3mjxK36kYps8anr/+nihvcINWJT6Ber11r7c=; b=AIZzkcw62xn4vmexw2nlCGfydL
        VDHrngJcL690ADkjQzd5pA6eIacsRxYheAy8DZO08hbIFiFdKPIMEH+TPGE7jvYxVjzJrE27EevzJ
        LCy8YpUXI7tKrN/agycVxAKE9Olynp+Kf7uYiESvuJ8Q7cwii3MKrWetAV6XvjCSFtWA=;
Received: from [UNAVAILABLE] ([194.190.114.28]:36930 helo=localhost)
        by huan10.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1k13iv-00039o-Tu
        for git@vger.kernel.org; Thu, 30 Jul 2020 11:15:34 +0300
Date:   Thu, 30 Jul 2020 11:17:43 +0300
From:   lego_12239@rambler.ru
To:     Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200730081743.GA24210@legohost>
Reply-To: lego_12239@rambler.ru
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <20200729203856.GA519065@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729203856.GA519065@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 01:38:56PM -0700, Jonathan Nieder wrote:
> The commit message describes its intent
> 
>   commit 489947cee5095b168cbac111ff7bd1eadbbd90dd
>   Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>   Date:   Tue Jun 23 22:33:23 2020 +0000
> 
>       fmt-merge-msg: stop treating `master` specially
> 
>       In the context of many projects renaming their primary branch names away
>       from `master`, Git wants to stop treating the `master` branch specially.

Wow. Jonathan, you are a good student of Goebbels! "many projects" :-D.
You lie. These are few but very noisy projects. Don't kid youself.

-- 
Олег Неманов (Oleg Nemanov)
