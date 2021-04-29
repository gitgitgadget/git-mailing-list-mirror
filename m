Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E6C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFE561446
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhD2D63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 23:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhD2D62 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 23:58:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D50C06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 20:57:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so97755183ejy.7
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 20:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rocket.chat; s=google;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gD/5SWkI+4lERfNynirQTBpPmKt8OtG56LmVdINN9x4=;
        b=nagW7pHRETnHS3Rr5aQQpwlx1xtwwYz085PIPDlKxjrlD7uyIcH1PyGLZ1uoXeBaPu
         Qk4q2YobLQHyizsZOS7Wh2+fSBIkQU/sCIKMPj40jXj+HadDup6WdQQe8eskZ3DhyEUZ
         7VqwGXCkIirOUZ5qMbYnSud5ugoRAcfRlCxeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=gD/5SWkI+4lERfNynirQTBpPmKt8OtG56LmVdINN9x4=;
        b=t0RmsoJihJ33etkCb7QKWcjeufCQQI4/BqhpkZhpUOCiyaor5exePxuGi63w6lkyAi
         VISs1ZDAzetOmhIvYgeqRe/6SpCF+31Xy/rYNHfrj5JfIXZUxIT65WG3dzUXT2kZazZQ
         YGCKC11WMzIB328FVNBJTWfNNsBI0Y9JWPz6mzKuMzFtvdq74ZZ8fdPtoEIoAgyrQsDB
         PeBNcDuGPTmX//A70GL5cVJrGdMpYi7xwhkrhIpKYQHne0mZotOMBdDirRBiqtU38h3G
         5ZSroaWi8HKTiWCcYoUFvC5ba8P0jd9dqC/mnpCCPtzefjM7hgkQI8FSgxDdK28Smr0O
         3rsQ==
X-Gm-Message-State: AOAM532VW+Zk6TFBlonREVT8QLI1LtWvsR4yzeef0EpYQZ5xSwTjFnI/
        KeiY94PJX1Zaa5lmNzIElulqIvuZWV+IPMgnSvCz4+tJKRxn4n1z
X-Google-Smtp-Source: ABdhPJx6Uj/3BXtHq3B0fXXw4APfnsoY8Arfe64YsLSX/j7bAO7kLcsIMR3Qfw/GlhFGN0RwOiguVwO+iyCbcx00gC4=
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr16516137ejz.219.1619668625773;
 Wed, 28 Apr 2021 20:57:05 -0700 (PDT)
Received: from 1097237787419 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Apr 2021 20:57:05 -0700
MIME-Version: 1.0
Sender: Nick Vidal <nick.vidal@rocket.chat>
From:   Nick Vidal <nick.vidal@rocket.chat>
Date:   Wed, 28 Apr 2021 20:57:05 -0700
X-Google-Sender-Auth: liE3PidMLSYmqKrShbuaifAhwZ8
Message-ID: <CAALpVAsse7SvMTY7_wRmZvXAM7Y_mYYEcgsNwPg8jMDzjVW3Vw@mail.gmail.com>
Subject: GSoC Student Engagement
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is Nick Vidal from Rocket.Chat

We=E2=80=99ve been part of GSoC for 5 years now, and as a way to celebrate =
and
give back to the open source community, this year we are reaching out
to other GSoC organizations to provide assistance on setting up
Rocket.Chat to engage with students (pro bono).

Rocket.Chat is a leading open source chat platform, and we=E2=80=99ve been
using the platform itself to engage with our own GSoC students. With
Rocket.Chat, it=E2=80=99s possible to create private/public channels for ea=
ch
student/project so that mentors and students can communicate, share
ideas, and keep track of progress both asynchronously and in real
time. It=E2=80=99s also possible to create integrations to display pull
requests, mergers, and issues directly on these channels.

Please let me know if you would be interested in trying Rocket.Chat to
engage with your GSoC students. Myself and the Community Engagement
team are at your full disposal to help. Our mission is to serve the
open source community!

Kind regards,
Nick

--
Rocket.Chat
https://rocket.chat
