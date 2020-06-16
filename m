Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F10C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F8120734
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 11:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BKG1uexW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgFPL3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:29:53 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:59547 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgFPL3x (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Jun 2020 07:29:53 -0400
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::22])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id F1B7C3380368;
        Tue, 16 Jun 2020 14:29:49 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback8o.mail.yandex.net (mxback/Yandex) with ESMTP id nnoNgRTLM9-TnriKi42;
        Tue, 16 Jun 2020 14:29:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1592306989;
        bh=PclG5eo54WVev8cU0lEKr70ZZwjI7ZEcApkayioKK18=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=BKG1uexW8f2JFbsbjH/qHTQeKu5ALrW4C6zHjRnQnEmA4v5qlsQBZ/z8mb7KnfWJS
         28vdqyJs/mSsfBLfQK6n0APDcMZuKHaDIMjamIZVHsTPlYbelPuamuvgNM3a1BRmsg
         FaYpQh13HQRzMBQRrqWn+Lk1uXri6tpUhEO10cLs=
Authentication-Results: mxback8o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-cb2cfd73be11.qloud-c.yandex.net with HTTP;
        Tue, 16 Jun 2020 14:29:49 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Alex Smith <alexsmith@gmail.com>,
        "sergio.a.vianna@gmail.com" <sergio.a.vianna@gmail.com>
Cc:     "don@goodman-wilson.com" <don@goodman-wilson.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "simon@bocoup.com" <simon@bocoup.com>
In-Reply-To: <20200616100424.39718-1-alexsmith@gmail.com>
References: <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com> <20200616100424.39718-1-alexsmith@gmail.com>
Subject: Re: Rename offensive terminology (master)
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 16 Jun 2020 14:29:49 +0300
Message-Id: <1109121592306913@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



16.06.2020, 13:31, "Alex Smith" <alexsmith@gmail.com>:
> Whether or not any patch would be accepted, the damage is already done.
> From now on, people will judge you if you dare to use the name "master" anywhere
> and this is incredibly sad. These people are literally bullying us into
> submission in the name of political correctness where no harm was actually
> done.
>
> This sickens me.

I guess their next move might be to force sound engineers to rename master channel and
derived term "mastering" into something more politically correct.
