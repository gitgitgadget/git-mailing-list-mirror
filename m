Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E5BC10F00
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC9120675
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gCkwPouX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCGOhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:37:21 -0500
Received: from forward101j.mail.yandex.net ([5.45.198.241]:43340 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgCGOhV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Mar 2020 09:37:21 -0500
Received: from mxback18g.mail.yandex.net (mxback18g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:318])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 4A9E21BE100B
        for <git@vger.kernel.org>; Sat,  7 Mar 2020 17:37:19 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback18g.mail.yandex.net (mxback/Yandex) with ESMTP id ERYhurkofn-bI3G2kYd;
        Sat, 07 Mar 2020 17:37:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583591838;
        bh=7eDm1hFDsypA4q6OpSJY+ZPBiib3GahxL8Uc3WoD5yg=;
        h=Message-Id:Date:Subject:To:From;
        b=gCkwPouXwLt1mU4R4WOMCwI5DPEf91/lMFebA2UHbd8AbnsHDPLt8EMxZREPfbIX5
         sVVrLWGw2qZ2VgkSZrIT+mKMNv4ObRSChN5v6LC/hLuLJgPwEWorlA/tEvydoSfmgs
         OsrLp0xY/AZXlvzCOYDYkbN/fj9k43Qejmz8SCBc=
Authentication-Results: mxback18g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-ace8bd7a4730.qloud-c.yandex.net with HTTP;
        Sat, 07 Mar 2020 17:37:18 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     git@vger.kernel.org
Subject: [Feature request] Worktree and reflinks
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 07 Mar 2020 17:37:18 +0300
Message-Id: <1128221583591276@myt5-2a1eccb4c218.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It would be great, if git worktree add could automatically use reflinks (when underlying FS supports them) when checking out new worktree when the same files with the same contents already exist in the main tree.

-- 
Regards,
Konstantin

