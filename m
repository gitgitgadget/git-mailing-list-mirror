Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F1C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4602465B
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 13:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLNNQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 08:16:24 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36614 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfLNNQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 08:16:24 -0500
Received: by mail-wm1-f46.google.com with SMTP id p17so1649232wma.1
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 05:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dTf+RE7F7xB6Dr59oYMi0kCT978ESo6kU6Wbyk2J1Rs=;
        b=eDAOxZ+rZ+Ush8joMRITZUIqc/M2UILxgCf8LOnnyRWn8NY/CXKtNjDWkEaEPRyLgp
         nWq7jBOeav/wMDNKNml6jA0BMSLePgUI5DtqLp7kB/saOTcH25n931NkGIVVzZMzUzwh
         MIvlWOgUrZ/KaIylRLhp3ib4nN6zmOLpJHoWxkl/q1OAs9A3vfvAIVK6k7xdesw2sC0B
         zkuIE+L0tcMozFIHzI8k5D85JV4t6P7b4EWOOLOV35wuULuKdK9LVJKOGPK09yYQ/Jwt
         U+DuNGqB+TkxjOJa9iXGBGfUzk0JNFLvLF4YRRsoSmslKZpudYoZVHEHXQ3sBaXCT82h
         jXrw==
X-Gm-Message-State: APjAAAVssMDafHX9ZPc+7O03tkmgV8x8VdSfxCg0GvpN7qwatL0GdZ/2
        V5LWaxh15g0mPIE5ZGT0YsHp6bWo8ccuOsLKDYp1wBPpXS0=
X-Google-Smtp-Source: APXvYqy8CmDrjrW/sIT76zhJ1Qbz6Hcr4uZIBDouGxkfAZRhUQzzVgf3dUzoaKcqrHlJ8s/20OI7BYpavXJuNDVR/fA=
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr18576442wmu.154.1576329382908;
 Sat, 14 Dec 2019 05:16:22 -0800 (PST)
MIME-Version: 1.0
From:   Mikael Simonsson <m@mikaelsimonsson.com>
Date:   Sat, 14 Dec 2019 13:16:12 +0000
Message-ID: <CA+PLxnV8xaoBwOi0Bo0dPLxptw1D-UrLoOTDDvAEcg5Q5kqzbA@mail.gmail.com>
Subject: Re: Bug? git commit fileA tries to delete fileB and other oddities
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git 1.9.5 against this repository seems to work without any
issues, so this looks like a bug in git 2.*.
