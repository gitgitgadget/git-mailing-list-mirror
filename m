Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECADF20248
	for <e@80x24.org>; Wed, 27 Feb 2019 13:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfB0N6D (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 08:58:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41225 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfB0N6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 08:58:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so13932923eds.8
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A/UnHtMqDI/J38Lo+uMBISuzSzu8+sy31/jy9wEt7Ek=;
        b=fS1/NZG18ljsrOpXpx8OmF0jtPq9wKSZHCdahTkij7oHJRrxHd85d5FBO9rsWKQBVW
         /p9CUYG1InBm8mZ289uEeUWvI9TU+VRXlgav7jXLiIPcC3jbtThvvRmY/rOsJQdfVnPm
         2oU89bx2k/wKafimLd+j3hc2Je/5zFA6M1D3CFwrt+q/KQjmydZ+bkNmIZfc1u7XRQIk
         A7DlCu83S3/r+BevylOUwHI1ITUvzpIdglFyZFt2eefjulT0fkOgyEBQZULNX5zbCJIF
         Fu2j3yS67Ab8RgW4vTaxVXT200gXkB57EFptomYutOUVbR+ll10rpXaginxgYMcpzBz+
         Sa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A/UnHtMqDI/J38Lo+uMBISuzSzu8+sy31/jy9wEt7Ek=;
        b=XlhheG4sqo4odTWMB6pM2JORangwf1VHk9zCBH/oMOdw4Ig6jtgUjyuZrl2WQS0ng0
         XBGmDbY8JCE7H78ojUzdnNiRhbaWjb+70OQIrhebXP+rbKQIu9vp8KjLiyn+p0T2AG3Q
         dn0ttfk3j0SMX9P8YrsGlBChTd1Cq/rLXAAPbau0AWH0WLVf6ShdH44ZT5MAZOy47q2O
         HN8Sk1eOxlpqkQKj02lCdQ+qUZRbbr7chdD0WSbRv2ag8mLTyQNIWF9Hu9cb+YEKrk96
         MJcOGX8scR34cQN6rPisuqpdqOr9jYLW0lyaf/rpONsFi0Qa0sdHktXkpy7VpJ0T3Mm+
         /Yaw==
X-Gm-Message-State: AHQUAuY/bkbotR94jjd3XzrcdiDT9PlrKXOkMbCQFHpJ+yOSzWR4qMVK
        oDG+zWB4lQeYqNecXj1TjYInHybRgYILfBzVyH0+DSLyUg0=
X-Google-Smtp-Source: AHgI3IbOwQ/+l1xYUJK3TgcHiiMTWeB/iJCKZTSWQi9i8+oenS1w9HphWerxEN3U3BfmzQGDXZdTnjws96FeJcnVgUs=
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr1635514ejq.196.1551275881220;
 Wed, 27 Feb 2019 05:58:01 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Feb 2019 14:57:49 +0100
Message-ID: <CAP8UFD2WkuFC0J2TnrK+cWUoo=Hw5M-N-g6JCW2wbzwoi8rFQA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 48
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        David Pursehouse <dpursehouse@collab.net>,
        Elijah Newren <newren@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 48th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/02/27/edition-48/

Thanks a lot to the contributors: David Pursehouse and Luca Milanesio!

Enjoy,
Christian, Jakub, Markus and Gabriel.
