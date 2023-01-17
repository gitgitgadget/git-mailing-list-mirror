Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8647DC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 09:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjAQJfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 04:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjAQJeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 04:34:23 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F15189
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 01:34:21 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4b718cab0e4so414614767b3.9
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+AV6axbTYulTIut+ItHdy8/TAXuIOi61u9E0T1INOOY=;
        b=f0GwYJP73Rebyg4HaFKXIdTL/VQrV1yS/ZpWfUt++51e47OXCPwsbvQa4+SyBt1o6u
         YePCDZkMoNzivSM1BNhlg5CYhhObFaZoME8oDPIB1Es9di/segB9MZmtsMCFm8L6KXPs
         DMETMiwYKtzSy+YWxFqmiH7vu8TIUZhangjCAC1YidKDm8rqq/FhP3aiuHTJKksn3hS8
         uG6iDIfz3BX92dKMUnrQ7YYCvuG1rmH8JP1exU3ezJnDxJuold3XvO+Z5wDYYMn/CTDX
         hFTqK5GR7c3PGEhuzOjgHSsOfxkgW0MG0Zs3R/ALTRFxFmYJ94vq6KLDiMZ6oWyipGtx
         tB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AV6axbTYulTIut+ItHdy8/TAXuIOi61u9E0T1INOOY=;
        b=FvJwVP7lr+ihmswF2TyAh0q3EW/xkjxUuR/w6iJKcl3L4jqmWyi121TXBh8m97yCvz
         JXytD/ZFU2axHF4NxxpSqfYvKMVBAFWLgPMZ3vKLYAK59ZhiFh9ue0me/4wnnI5COjc4
         ZZCioOldWoEa1ohpunpB3zoOGnB6YVeXZhxOC7XuYTRnZsr2sqzLDcY4ceHQ6LSpF+ni
         D5XWfRDjPIx4DKy7NHAzDcGav8Pej/bj2MZ3jwhOn7W8aPb6S81cofjly6l/5H8iV3jd
         uOKMtqckZ12mkxGAiOAYLrHaWZEOd6/OGjzoI7iM9JDhPsOxTWTwn3w19cPxYGmSuLHU
         BEtg==
X-Gm-Message-State: AFqh2kpN7l/VzxY+8xPKIrbt/Pbt1KRxUiFxN7Aumh0a2oWbgxk+d5SM
        bLJzkxdHIZ2MID54dUMeFLw7XdRJItBwveHS6ys2rLzmrnI=
X-Google-Smtp-Source: AMrXdXsJP9rKSL3qTiRF36MHTOOZcSjtZKVjHdQathh2SzAnFVuy7y5//LXE40AVq/c1DR4sNO1dn3YgXmLgURtk15k=
X-Received: by 2002:a0d:ea91:0:b0:47b:772:83bc with SMTP id
 t139-20020a0dea91000000b0047b077283bcmr305329ywe.311.1673948060861; Tue, 17
 Jan 2023 01:34:20 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Jan 2023 10:34:10 +0100
Message-ID: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
Subject: GSoC 2023
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

GSoC Org Applications open next week on Monday, January 23rd at 1800
UTC and close on Tuesday, February 7th at 1800 UTC.

I am interested in mentoring and being an org admin for Git again this
year, so I plan to apply for Git soon.

The GSoC contributor application deadline is April 4 - 18:00 UTC, so
(co-)mentors and org admins are already welcome to volunteer. We also
need project ideas to refresh our idea page from last year
(https://git.github.io/SoC-2022-Ideas/).

There will be a GSoC Meetup in Brussels during FOSDEM weekend on
Saturday, February 4th in the evening. I won't be there but if you are
around, interested and haven't received the link to register directly
from Google, let me know so I can send it to you.

Best,
Christian.
