Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2915C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929E721707
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BK/r3gMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbgFSQOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:50 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:46696 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394455AbgFSQOt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 12:14:49 -0400
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 3C286940499;
        Fri, 19 Jun 2020 19:14:42 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback14o.mail.yandex.net (mxback/Yandex) with ESMTP id KsI1WrIa5o-EfV0WBYx;
        Fri, 19 Jun 2020 19:14:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1592583281;
        bh=AP3m5fsNnhwFybU379Mojx/BOhpeMYMkisZ+fuNVLv0=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=BK/r3gMcRlqcj/SnTPud5vEVzZLSZuK0tr/K0RJMOYwvVfU5q3uX94PpLZw0ZUE2B
         5WfccFrPaW9wDVYnsnVG+XwHykcy0XEdInF+YdH2Cvfe71TumsxJhpqJJISl1yZ44c
         v8RyJK4/3z/Unm5cf05ZjfRkKtrwsCKTldPRZR8c=
Authentication-Results: mxback14o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-e9d1d6a5422a.qloud-c.yandex.net with HTTP;
        Fri, 19 Jun 2020 19:14:41 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <87h7v7xf1n.fsf@igel.home>
References: <87h7v7xf1n.fsf@igel.home>
Subject: Re: Bogus error from git log --full-diff
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 19 Jun 2020 19:14:41 +0300
Message-Id: <585541592583234@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



19.06.2020, 18:59, "Andreas Schwab" <schwab@linux-m68k.org>:
> If you have log.follow=true, then git log --full-diff doesn't work any
> more, giving a bogus error:
>
> $ ./git -c log.follow=true log --full-diff .
> fatal: --follow requires exactly one pathspec

I've reported this issue in February on this very list and didn't get any reaction from developers.
Seems like it's not considered to be a bug.

-- 
Regards,
Konstantin

