Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D76A1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfA0KFG (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 05:05:06 -0500
Received: from forward101j.mail.yandex.net ([5.45.198.241]:38123 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbfA0KFG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Jan 2019 05:05:06 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jan 2019 05:05:05 EST
Received: from mxback19g.mail.yandex.net (mxback19g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:319])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id D96781BE14B7
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 12:58:58 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback19g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zSauaP4mlI-ww9mrZa7;
        Sun, 27 Jan 2019 12:58:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1548583138;
        bh=QEs5E6bEg4oQbFUBKekNdr1qF9APngtYg3c87rF/7pE=;
        h=From:To:Subject:Date:Message-Id;
        b=efFM2Kqe4ct13qAY/Bsj0PIqzGHNYSF4ym9Mx6rpwbo6HQPvmqEvvD/984EACwxmu
         5y2QJRYNhxq+DC9M3ILps47jgLRd4ewXtvtp79fNCru1HzDGFEmIdBJqqzmtV1gzwU
         IqU7LADcBqK0rS5rHNxQxj9LAvfqFdrGH/TZKt+w=
Authentication-Results: mxback19g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva8-37fc2ad204cd.qloud-c.yandex.net with HTTP;
        Sun, 27 Jan 2019 12:58:58 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: unclear docs
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 27 Jan 2019 12:58:58 +0300
Message-Id: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Could somebody please explain what 'core.autocrlf overrides core.eol' means given that we have the following statement in core.eol docs:
"Sets the line ending type to use in the working directory for files that have the text property set when core.autocrlf is false".

I would like to know which line endings I'm supposed to get in the working tree if I have core.autocrlf=false and '* text=auto' in .gitattributes on windows. I get CRLFs  which is consistent with the last quote but I don't understand what 'core.autocrlf overrides core.eol' means in this case.

Links:
https://git-scm.com/docs/git-config#git-config-coreeol
https://git-scm.com/docs/gitattributes#_checking_out_and_checking_in


