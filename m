Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD7C388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B086E20791
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uGYuLgpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgJ2BFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:05:05 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:36080 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729214AbgJ1WFr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Oct 2020 18:05:47 -0400
X-Greylist: delayed 1943 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:05:47 EDT
Received: from mxback13j.mail.yandex.net (mxback13j.mail.yandex.net [IPv6:2a02:6b8:0:1619::88])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 2FF26350012A;
        Wed, 28 Oct 2020 15:13:12 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback13j.mail.yandex.net (mxback/Yandex) with ESMTP id zSzDzh39p4-DBmS93lS;
        Wed, 28 Oct 2020 15:13:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1603887191;
        bh=0yDrU5vKvIe8QMr94pMxz6dFgg+9aVTPnTwQ2ew/N04=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=uGYuLgprjlxgm/8n2uv13OELlEDE1QayyB95Til1/efsv7vpgOdPLeajxaRCZ/B9o
         Aycsx9SiMJCdDHGH4AHFUeuljPoxGGcAvogCgJG5xyqM8X9xTacRc8nNghUR2UWi1A
         Gcn0jj1CoqYKnNk4Lrdz7lUMi7hEa0YMLm9mjK9g=
Authentication-Results: mxback13j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-636ea6dfd460.qloud-c.yandex.net with HTTP;
        Wed, 28 Oct 2020 15:13:11 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Filipp Bakanov <filipp@bakanov.su>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
Subject: Re: Proposal: "unadd" command / alias.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 28 Oct 2020 15:13:11 +0300
Message-Id: <3956141603887148@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



27.10.2020, 23:10, "Filipp Bakanov" <filipp@bakanov.su>:
> Hi! I suggest to add "unadd" command, that will undo a git add command.
>
> git unadd path/to/file
>
> It will be an alias to:
>
> git reset HEAD -- path/to/file

It can be done in shorter way: git reset path/to/file

>
> The motivation is that I always forget syntax and have to google each
> time I want to undo accidentally added files. Unadd is just much
> easier to remember and quite obvious.


-- 
Regards,
Konstantin
