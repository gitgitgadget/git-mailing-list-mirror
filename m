Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E2C10F1B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 02:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiL1Cna (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 21:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiL1CnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 21:43:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D9CCE30
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 18:43:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h16so13805853wrz.12
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 18:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xG/lAfH5xYraWPoUnfBboPAzeyM64WCEJXUskpTQup4=;
        b=Dk2j7a7901A09Cb14LQgDp6RpYX8FxQu7x9irWia3Cki+Z2QAWqbspF8mRdiU5roWc
         1y5ZUFkKTGl4NtpxxR1Usle+EnR+NXytNQEKH7It/QTql4WrSALYt1QcHJ9/aZ+l0Cam
         mY5Cg82SMhb1CSZK9F7EjMSHMAWZ9ENG/gtHyJmMPyMro+ZALId6baUvG1vmYEb3VY0Q
         aypgKvlxmFL7QzUbn8VJ4HKghPe/LHNtmQyedxHtkmonQmqALtiq/Tr9pQbX64lFwF9f
         L/kfVhYeZXeOd4r8GEkrx4jBqbQSvzy3gAw5cwtSr9H+b5u4l+1UO6P+ChrMohexxh8Z
         H96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG/lAfH5xYraWPoUnfBboPAzeyM64WCEJXUskpTQup4=;
        b=HoFpZE4M5i4f4OfAFQBKIuEKSaZFgsPmN1Mqqtd7CayXijV6+etV8S/Mha844u+9Y0
         6IKKhdiLDlwCJjbcT6xsNPhlGvDli19rboV1WzTkMxtl8UDdkF1RH3wFyd1E+fDgIiqE
         pTlsTLgc/q1opHgcXj4SfuXRO18Ji5cfZXrfM5KqiZGvKO5l3d9iUPbVKKQ7+rN5Eo6Y
         ToOP4QMQw4qmL52cmecKo6RdJARtuiHWljUt/NHFHhZLt2KZHaaAX9AbZGldsNR2mL3f
         6gQhSYU+io49vybHB0/EbFlWm/m9v8Sgek8vKJZxKD4xJwHJLpOo0fTG8mRHm0gUGCBU
         SUqw==
X-Gm-Message-State: AFqh2kqrxbeIoGK7XO/BY5uVx3JsLPKB87lDoMi4E8Z4rzdZwof2TiYM
        IjRnmBzCByQ3npd0H4gOw58+aIJ72np+QDIbRMCJEHGzdd0CFg==
X-Google-Smtp-Source: AMrXdXvKKWYRMzcIJL0Ja1rDG4ZUlitK1W5K2385BRTou4quXAqRXZp+ak+tZmALeDlc4/OmDmLeWiNzZ1OrOkbrpFU=
X-Received: by 2002:a05:6000:cb:b0:242:e27:85f5 with SMTP id
 q11-20020a05600000cb00b002420e2785f5mr757361wrx.308.1672195393423; Tue, 27
 Dec 2022 18:43:13 -0800 (PST)
MIME-Version: 1.0
From:   Jensen Bean <jensen.bean@gmail.com>
Date:   Tue, 27 Dec 2022 19:43:02 -0700
Message-ID: <CANqKdC9yJx+v025dWp9udfrdb3ZUug0WjJZJcKX6vR=wL-=Qew@mail.gmail.com>
Subject: Bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.
What did you do before the bug happened? (Steps to reproduce your issue)
download git
What did you expect to happen? (Expected behavior)
CTRL button to work
What happened instead? (Actual behavior)
CTRL button stops working
What's different between what you expected and what actually happened?
the CTRL button doesn't work when I have git installed
Anything else you want to add:
Deleting git and all its files has been the only thing that works so far
Please review the rest of the bug report below.
You can delete any lines you don't wish to share.
Confusing experience, wasn't sure what to actually do

[System Info]
git version:
git version 2.38.1.windows.1
cpu: x86_64
built from commit: b85c8f604d375d4d773a36842964e8a7ec056aae
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22621
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a
git repository - no hooks to show
git-bugreport-2022-12-25-0152.txt[+] [unix] (01:52 25/12/2022)
