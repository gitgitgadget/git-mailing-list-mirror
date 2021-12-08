Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E9C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhLHMdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbhLHMd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:33:29 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4AFC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:29:58 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z18so2579033iof.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hFA8nP3deyCqtT77DaithffHSsI0kZ+Yd5ORjP4xpEw=;
        b=EoBJNL4yX1Zfx7qaaAlaRYijwbuycfX7MIMlrwbbHmlk29AoF4/Xr2xEB9TuTIFhoX
         SNTSoTYCYp4uiEXt9zkhLKRr2Q3OCZX5+vdKhAejkEachdoLzc+ZoekbRTlTFVvs2d12
         e1v1f6FOU8l2EBcWhOTMhVcxufHtyuxDge2dFrpdQc82QSPO52mtR/ExDu3UA6kEVkA9
         90zX2GS3B3WzojJUJ1hK9MFwPBv8QqWan84gzqvUGqk7gue8G0vJvT7Bg99FubuzeKjp
         HqBGO8y0D88u55+uXMzKb8Bt54xNVJ2q079ZZWTqICgr3RpDbHwSSaQ+aBT4lSseXy1X
         iidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hFA8nP3deyCqtT77DaithffHSsI0kZ+Yd5ORjP4xpEw=;
        b=TIkEWQBI/Fdh8Li/krzEpZq73QqMlQ2N6xCh7ENh8xBogi+cwNd3+Ql/7Rr9Q2hV5J
         t1XB5e07dJn2dBi8zLRMW4RfBRWIHrcjwal4b+O8AB1NKdaduCv6u/u67d60Hh0CCJqZ
         /CViL31fP1/twH1px7Q7hPgkJOU7y+K21/qS1DYFnvCOzz20m4EJgBaW8+ErZFxygSDc
         yfQtZqAZfpWRFEU14XSV6/N0sTwOXG98ExHG8hrAqWDtr9B3YiOTVKpw62OeRkwh+WDA
         uv3gX07lTcOQ9wxberihlDfpSab8BfAQZCSKaJQMKH47SC+ccdZyJ0GwVPs4yVA05cFq
         pLMw==
X-Gm-Message-State: AOAM533hcfIFCYpxm6n3KrQdaP7KhQCyDtw0mCVrOZ3hvBTfUlWVoE23
        wXQpxwAPJQ0zHJ27Z1dXZ76/lK6tVLkTW4+X7Mc=
X-Google-Smtp-Source: ABdhPJz6s1ZD65g1c8IX6sVsqflWNvmDtsMQLBpX+M0wcluIE1Z3kNWiX0E2OqBL7nu9a3tsNjTsFbhHlZVqUK5WJ5Y=
X-Received: by 2002:a05:6602:1604:: with SMTP id x4mr6719390iow.84.1638966597483;
 Wed, 08 Dec 2021 04:29:57 -0800 (PST)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 8 Dec 2021 13:29:49 +0100
Message-ID: <CAGr--=KQWNE-V1pR06nBrvKtF9EdYLZyR5P=SuQQOFSNkt0H0Q@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     bandi.rao999@gmail.com
Cc:     Johannes.Schindelin@gmx.de, bagasdotme@gmail.com, davvid@gmail.com,
        git@vger.kernel.org, me@yadavpratyush.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just wanted to give a BIG +1 to this issue. I have all my applications
switched to dark mode and a light filter installed on my computer, but
every time I open git-gui it really is a big flash to my eyes. I
started using other clients because of this but I prefer the workflow
I've had with git-gui over the alternatives.

What is a quick and easy way to apply a "dark" theme to git-gui in Windows 10?

Best regards,
Birger
