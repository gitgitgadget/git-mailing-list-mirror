Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F02C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245D2173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jZZZF5nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRL0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:26:47 -0500
Received: from forward105p.mail.yandex.net ([77.88.28.108]:33729 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgBRL0r (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Feb 2020 06:26:47 -0500
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 06:26:46 EST
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id F186B4D4179B
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 14:19:53 +0300 (MSK)
Received: from mxback9q.mail.yandex.net (mxback9q.mail.yandex.net [IPv6:2a02:6b8:c0e:6b:0:640:b813:52e4])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id D93B87F2001D
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 14:19:53 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9q.mail.yandex.net (mxback/Yandex) with ESMTP id VvrM8PvyIm-JruSoRT5;
        Tue, 18 Feb 2020 14:19:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1582024793;
        bh=UY7e4a+QGmnk5v6vjAeaOgleKZzV8+GoOFJwB2WzQt8=;
        h=Message-Id:Date:Subject:To:From;
        b=jZZZF5nYWTe35AshDwavLY3wqumGbjHa2c/WZRwcfJAQZ3qfTALdDWvOCZgGqgsBn
         /ZUCJ4JcbU5F9yzplEFXKr276wp0YLf7Qxx8TlKOtBFnnysS+G3NN9Z1beFU5rrJUy
         UJG0vQHo899mkrXAEflwUP9LAHoNp4azde5dOSjc=
Authentication-Results: mxback9q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-a6eaa355d163.qloud-c.yandex.net with HTTP;
        Tue, 18 Feb 2020 14:19:53 +0300
From:   =?utf-8?B?0KHQtdGA0LPQtdC5INCh0LXRgNCz0LXQtdCy?= 
        <nevercu@yandex.ru>
To:     git@vger.kernel.org
Subject: Question git
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 18 Feb 2020 14:19:53 +0300
Message-Id: <3982961582024793@vla1-a6eaa355d163.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I have a repo - WORK.git. There are some brunches. Сan i view all commits working repo and all branches at the same time? Sorry for bad english.
