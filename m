Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364041F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 08:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407258AbfJYI6g (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 04:58:36 -0400
Received: from forward103p.mail.yandex.net ([77.88.28.106]:59208 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392171AbfJYI6g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Oct 2019 04:58:36 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 04:58:35 EDT
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 1816D18C180A
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 11:53:15 +0300 (MSK)
Received: from mxback9q.mail.yandex.net (mxback9q.mail.yandex.net [IPv6:2a02:6b8:c0e:6b:0:640:b813:52e4])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 15C227080004
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 11:53:15 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GZCMGv7xK5-rENCtEtV;
        Fri, 25 Oct 2019 11:53:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1571993594;
        bh=ReWHMm24/aptguS6ApFPwoysoHtdY9JxnU65p4Zzj8U=;
        h=Message-Id:Date:Subject:To:From;
        b=tO1xaUujdQWX5wJcaIqtCz32THVvfwhIuoKjsxKRyocg116+vmli0WYj11xxcDbj0
         mFi1KGbATTSFZDnQ86oV4THUpTo7XKbSUw9V6DSRCJnndguZ2IxOkUzo/vqUBn+pnA
         5CWyilJerSGwAEcyhsfReHeMIBKp/CzbDcAAh908=
Authentication-Results: mxback9q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-d97dbca235a9.qloud-c.yandex.net with HTTP;
        Fri, 25 Oct 2019 11:53:14 +0300
From:   =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
To:     git@vger.kernel.org
Subject: .git/binary
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 25 Oct 2019 11:53:14 +0300
Message-Id: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it possible to add a `.git/binary` configuration file like` .gitignore` to the `git` system with a list of files stored in a single (current) state.

-- 
zvezdochiot

