Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F7C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392BB2054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="KEhE8Jfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEMVBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:01:10 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:59422 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgEMVBJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:01:09 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2020 17:01:08 EDT
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 1E4295F80932
        for <git@vger.kernel.org>; Wed, 13 May 2020 23:54:46 +0300 (MSK)
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 190E17F20017
        for <git@vger.kernel.org>; Wed, 13 May 2020 23:54:46 +0300 (MSK)
Received: from vla4-2e76570dd7f5.qloud-c.yandex.net (vla4-2e76570dd7f5.qloud-c.yandex.net [2a02:6b8:c17:c8b:0:640:2e76:570d])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id 38AIDuawxM-sk5qiqJf;
        Wed, 13 May 2020 23:54:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1589403286;
        bh=WDHzIEcsbJUL9IA+DdC8a5r/s5/tug5ns8AwBav43Lk=;
        h=To:Subject:From:Date:Message-Id;
        b=KEhE8JfgCetnP8u++EHF7Sc+kMgzOGvzXETaEKh/n0kcSasjYY9Hqb9ryQ0CsuZVY
         Fr9cmh0i0D//xilmpMi0lrlSZwsooUaCHfZtgHS5a7lrUe1FN5RTr5phzElIUjG2ir
         G8VaH2BISJaW0uQMPXbGxjVZJmqFpu4U5T8Md3F0=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by vla4-2e76570dd7f5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id gkWAIkS3k7-sjX4TPep;
        Wed, 13 May 2020 23:54:45 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Denis Efremov <someden@ya.ru>
Mime-Version: 1.0 (1.0)
Subject: Update git version for apt-get
Message-Id: <D9813694-67FF-403B-8C7D-8DF013C96D98@ya.ru>
Date:   Wed, 13 May 2020 23:54:44 +0300
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (17E262)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=EF=BB=BFIs there some plans to update git version for apt-get from 2.11.0 t=
o higher (maybe 2.13)? It will be very helpful for a lot of cases with docke=
r images.=

