Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4446C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18A12051A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgA3PCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:02:31 -0500
Received: from forward106p.mail.yandex.net ([77.88.28.109]:36616 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgA3PCb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Jan 2020 10:02:31 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2020 10:02:31 EST
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 54B6E1C818B3
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 17:56:32 +0300 (MSK)
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 52ED87F20010
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 17:56:32 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id 00vcQuxWyk-uV3WLiMk;
        Thu, 30 Jan 2020 17:56:31 +0300
Received: by vla3-a60e960147e7.qloud-c.yandex.net with HTTP;
        Thu, 30 Jan 2020 17:56:31 +0300
From:   dk@tutunak.com
To:     git@vger.kernel.org
Subject: How to undo git sparse-checkout set only for one directory?
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 30 Jan 2020 17:56:31 +0300
Message-Id: <21812981580396191@vla3-a60e960147e7.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After git sparse-checkout set <dir1> <dir2> <dir3> I want to disable sparse checkout only for one directroy - <dir2>. How can I do that? git sparse-checkout disable will do that for whole repository. 
