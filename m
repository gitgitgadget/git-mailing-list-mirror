Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8DC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBPGl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 01:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBPGlz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 01:41:55 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630111BDC
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 22:41:54 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4c24993965eso11647387b3.12
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRkUfPOBulBWonkZA8JqdnnQf3nVuyJ6eykFwrQVhAI=;
        b=kgTBGzYO1jxnsTzgu9A7c9Gz5W7kGq2qIF73PavtybSZkhrFKU82Qwp4rZBgjvbcKZ
         3PPyULvO5THin7dHAF4aCQ0E1Cfal61yOoBjCHYhL8Rx0AixshZw8u7H6t/rRHdsr7FW
         RHwA0GR4EaNykZuIzVRu+mkqGbHyIjLe+dBGDyh9nZoVfyYk0nc93D6Yqs7yrAmc/8PM
         Br0PsT2sTi85m6Qoqd+lwoOF39VW5DJTR2YbYV+0NBSJcVwcsSl9bxJQ0RLlgAf/gWD+
         11W1sRTkxwDgp/quHV+2o5JX1HvsYXrWPUD9HHFQs6QNirm4AgsPvoedUI8Pb9UGpsLI
         QSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRkUfPOBulBWonkZA8JqdnnQf3nVuyJ6eykFwrQVhAI=;
        b=BrGEkeFditFwV5m8tsw6B3AeUR0t5++BcpiQd9BUJNQaDcVN0VszEnsGSaQlloav8P
         BOaWTN31Ynd22Faaq0G7nyByRcx2z/mMfniUlwpBbSVUdc0fwZYIG9Ea5dI3rdYk2zm9
         moaIW+OBOkcxfgQZyLKaa4T+q7Vuzf2eo42/VzxQjxMubBTf1QSQboISQRZFxIF+RWuf
         wBJdaZt/gFbd7PrWbe1DnjrvgOhmXk9HAYdE0pTEmHdOoXWFU9weKUmF50mTzDRKyx6I
         Yk7pwu8iXCh2r3EACTon4DLW7A/9MksN6XgRcLJizpwpR+BIcDnebw0xdnL8BFu3+H+P
         eKSw==
X-Gm-Message-State: AO0yUKUdaZeMXRCzlKhR+CvFPiIoIEqMItE9JTRvnCvAXzOX5dWGcsSV
        aKXBpoVQsv4JDqv8MNx1WVmZGqZXD3oB0/n7nY4pd+oNRR0=
X-Google-Smtp-Source: AK7set/OpAVjrX1kM8HHotJyVTCR+gzI6eB8xE/v9ro+Op/cB2Sr2z0Q/7El/894GEKRQ7wijXmPJ16Tf3kD7TjV9yw=
X-Received: by 2002:a81:c250:0:b0:52e:bcf5:563f with SMTP id
 t16-20020a81c250000000b0052ebcf5563fmr606480ywg.154.1676529713305; Wed, 15
 Feb 2023 22:41:53 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdtemccnp@gmail.com>
Date:   Thu, 16 Feb 2023 14:41:42 +0800
Message-ID: <CAD3upLsCQXrbw2OTtUK6WoVu5PafHSvdNfDTnmmfJG=G2sgbhw@mail.gmail.com>
Subject: Git security vulnerabilities announced
To:     git@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: Git security vulnerabilities announced

Good day from Singapore,

I am sharing this article for more awareness.

Article: Git security vulnerabilities announced
Link: https://github.blog/2023-02-14-git-security-vulnerabilities-announced-3/

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
