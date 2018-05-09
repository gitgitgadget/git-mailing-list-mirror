Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371791F424
	for <e@80x24.org>; Wed,  9 May 2018 13:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934801AbeEINcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 09:32:15 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:40777 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934775AbeEINcO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 May 2018 09:32:14 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 May 2018 09:32:14 EDT
Received: from mxback13g.mail.yandex.net (mxback13g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:92])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 3031A1244A55
        for <git@vger.kernel.org>; Wed,  9 May 2018 16:25:16 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback13g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Mpz0vm7wcr-PFhmr0J1;
        Wed, 09 May 2018 16:25:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1525872315;
        bh=lQBI5Jpgqg3o0G+XszLjD5A9MyowC1e3uZC5lJ1FLjs=;
        h=From:To:Subject:Message-Id:Date;
        b=hRp9mXyei5Q9kDoE6XGIeloMEVM4RpBbtCVH/ESatdmjbt23trO2OgOC01AGvUwv2
         2btEWgZ2X2Ee3CypZblvaaFf/eiC0O9XNUclkV6jPncFNDTEb4C7K8it18NYAm1X9Z
         6l7c+HLodB2M2X6Bf6Ql2AAX5Z2Y2kcyjluYOqD8=
Authentication-Results: mxback13g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web37g.yandex.ru with HTTP;
        Wed, 09 May 2018 16:25:15 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: Can not save changes into stash
MIME-Version: 1.0
Message-Id: <6015131525872315@web37g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 09 May 2018 16:25:15 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How to reproduce:

$ git update-index --skip-worktree conf/local.conf
$ git pull
Updating 0cd50c7..bde58f8
error: Your local changes to the following files would be overwritten by merge:
	conf/local.conf
Please commit your changes or stash them before you merge.
Aborting
$ git stash save
No local changes to save

