Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178A7C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 14:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCUOix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCUOiu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 10:38:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977EB4FA83
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 07:38:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so60580451edd.5
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679409525;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C8j2DTOwFnDeRYC7GpeSs8MJx6SyCt43GrXjFkQVO3w=;
        b=c/Qbq/NVuXZnYD8JM9IynUlFanAaOvOD4gYeOcypQRvP2Y1EsTwz3ZKhUU4Sciy3jz
         FrTku/kJnbgBUVHNS5VgiMvf5hBWZBr3MlRgbFoJx0Eqkt92O/dB8w1Kjkq2nwO/qjVy
         DQlHJzpjYZTIgqtyu5bc+P+KJ7EZGQClYwlKnKnbdpXhI3AFLhTERzaz4rElDxXh1g39
         /R7we0QUZoyWkF9dwo0qd9T5jC++DLEz6vNV/ysgWvlIsdu/Gn95qa4qRaOAtJrFlECc
         b3GVguKdbjos/l+rBtQ5u+d1/8mk+SCACOYJuy3+tYjTDv5b5WARHR9PQY9MIFbX2qqE
         pg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409525;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8j2DTOwFnDeRYC7GpeSs8MJx6SyCt43GrXjFkQVO3w=;
        b=iWmdeYgb9NhDZlm7QxiPAorSsuLoAM/aOQuuRDjaPm+rfP6k04jXnRjYLoH2JNP7bG
         oBacKRIo30o5+Fm0pdFsOkVaaC8lQ00JnNNJwxsmR4eFhttBQ/x4JVsWhh1UDBp6LhJ8
         SIHLXROym2nvAPp+1dqdumo/Cv1eOz+b2bSvHj9ZaE5BSVgb9tFSg49JUnwLvxhqNCqa
         Ad48hF8Ts7Ipx9t0dO5q/Mw6FdyK+aPffJyx9EAzmaOgCETRcI0WFG5DzVKyCMyr8fvX
         4u/29KrPgDh+JWGwYNheSmhgUOa07c0Un0vOCsxr13yt5Z0vk6toK6e5x9wSKP+5+4Vq
         IbTg==
X-Gm-Message-State: AO0yUKUt1U0FDk+tIUNo58spG7ZGSOGJHV39WH89pIorm6UGNaAFwTpZ
        eGY6v4RB4yl08AVn0ySJOvLpA1HnzmVhSwhCn0jIeKbeit4=
X-Google-Smtp-Source: AK7set/9iBFlmnZFuDl5vBRyEhNHRAcuhvDc8CAd244zb8yb6so+ZAp06AFTHbv4mDSNqhcfI46vxpgyrRWJDHseQCE=
X-Received: by 2002:a17:906:e85:b0:8b1:7569:b526 with SMTP id
 p5-20020a1709060e8500b008b17569b526mr1414514ejf.11.1679409525560; Tue, 21 Mar
 2023 07:38:45 -0700 (PDT)
MIME-Version: 1.0
From:   Edwin Fernando <edwinfernando734@gmail.com>
Date:   Tue, 21 Mar 2023 14:38:34 +0000
Message-ID: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
Subject: [GSoC] Intro and Micro-project
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I am Edwin, a first year undergrad in the department of computing,
Imperial College London. This is my first message to this mailing
list! I want to work on the micro-project "avoiding pipelines in test
scripts".
I'm really excited to work on such a massive project (ie, git, not the
microproject) and be in contact with the people who put it all
together. I'm curious about how software development works at this
scale, since it feels quite different from the small projects I've
used to work on. I use bash quite frequently for automating tasks, and
I have experience in C, through a uni project of making an assembler.

I found and looked at a few places with pipes. I have a few thoughts
and questions on making a change. Firstly (if this is relevant), how
do I ensure that the file I write the std output to doesn't have a
name clash with other such files made during tests?

I will follow up with an email of the proposed patch.
Regards,
Edwin.
