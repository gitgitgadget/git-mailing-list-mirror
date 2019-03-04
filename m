Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BF820248
	for <e@80x24.org>; Mon,  4 Mar 2019 14:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfCDOQr (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 09:16:47 -0500
Received: from forward102p.mail.yandex.net ([77.88.28.102]:57130 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbfCDOQr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Mar 2019 09:16:47 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 09:16:46 EST
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 6814B1D41B7B
        for <git@vger.kernel.org>; Mon,  4 Mar 2019 17:09:32 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id rAp0eKcGuf-9Wd0Vnmn;
        Mon, 04 Mar 2019 17:09:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1551708572;
        bh=oZiEJ1ZblhqIUsZe1RfkeceUIOogdbysju+JMLdXivI=;
        h=To:Subject:From:Date:Message-Id;
        b=ocgF2VidLs98UJZK1+a+OhBuFb9Q93qRzNqZmuQ2Dno1rjC0Kk1eJfHucfPcRdFur
         Yx5O6X2xz4hhYhb8xJOOOhy7y+yExtWwqhRphGX9/35Wr7qofCRh1dhzd1iKTyKUYV
         uL9tnmFFIxF1x5bfzhbZjForNzMgQu7HB/aiLyGQ=
Authentication-Results: mxback3j.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id MB0z5b4URw-9Vmek6Qp;
        Mon, 04 Mar 2019 17:09:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   =?utf-8?B?0J7Qu9C10LMg0KHQsNC80L7QudC70L7Qsg==?= <splarv@ya.ru>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: small fix for git-diff man page
Message-Id: <51ADB663-BF46-454B-A281-03B54F9C3424@ya.ru>
Date:   Mon, 4 Mar 2019 17:09:31 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small pull request.

https://github.com/git/git/pull/580

Git diff can work with a tree in the form git diff tree..tree too, only
the form git diff commit...commit can't accept a tree instead of a =
commit.

Also added useful example about using a tree with git diff.

But what is strange. I changed only one asciidoc file. But my pull =
request can not pass an integration checks. =C2=ABGit.git =
(Documentation)=C2=BB is successfully passed, but =C2=ABgit.git =
(linux-gcc)=C2=BB, =C2=ABgit.git=C2=BB, =
=C2=ABcontinuous-integration/travis-ci/pr=C2=BB  and I don=E2=80=99t see =
reason for it.=
