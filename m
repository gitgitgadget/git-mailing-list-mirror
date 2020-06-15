Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B7C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 22:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A36207D4
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 22:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RrSj9wpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFOWll (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:41:41 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:45835 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgFOWlk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 18:41:40 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 18:41:39 EDT
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 7B06C4D4022B
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 01:33:35 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9j.mail.yandex.net (mxback/Yandex) with ESMTP id 2fdJ87o3xD-XZj8lDno;
        Tue, 16 Jun 2020 01:33:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1592260415;
        bh=WEGBY71IjJy1iXKNucJMeEoQBV/aMUJQQwHYlFw/4ho=;
        h=Message-Id:Date:Subject:To:From;
        b=RrSj9wpglbOOClDNY5TbylEkpVgKiom7OGHFmVJAbaos1T1FkvQfloYNzH61rIAiK
         1yo6qOCv6KlLxlilPYBpUHDMY4I32l8BDuJwmBaadxhD6OwH6S2gRz6ks5hpNOJgGg
         wz63gSURhGmqq4EV+24vMqEz2jWfKWWN8SiRd4Y8=
Authentication-Results: mxback9j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt2-c3952fd46804.qloud-c.yandex.net with HTTP;
        Tue, 16 Jun 2020 01:33:34 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Job: implement visualization of intraline differences in git-gui
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 16 Jun 2020 01:33:34 +0300
Message-Id: <1468141592259947@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'd like to see [1] implemented, however maintainer of git-gui doesn't have
a time to work on this feature. Is anyone here willing to take it?

[1] https://github.com/prati0100/git-gui/issues/31
