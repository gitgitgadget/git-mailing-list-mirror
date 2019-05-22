Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9001F462
	for <e@80x24.org>; Wed, 22 May 2019 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfEVKQY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 06:16:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41892 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEVKQX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 06:16:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so3021718edd.8
        for <git@vger.kernel.org>; Wed, 22 May 2019 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1rLsltxCe0KQuVuZyGLA6hAjSltolb8BIgQ8SRMOV1k=;
        b=hiqxxOIx+EyGZ1s5ATJoY1zrpwh7GI+yJwsix8jyphj33qqY3iUfts3OgG518quJ/J
         yVc34QTZmfI5OIPNF8OmfFHCjPfDbO3QSGW2R3m2GPWndfiC976G140i2wsCWUbwaAgw
         8mdXHl2noGb+qXOce6czimhq5Ffn8etQXBU+ALE216S7H6GpEckqRg9FgpfkljA3/5SW
         kFDWQf0VgKHqUPLZJaBez+WPrSNXOBRYd/i9WTnIciUzpunn0Kb27OIspce9+VROqQ+d
         h7CwRpDYWQXmOXfdwMAAijU5RPikYklVQ10vB++IwPYX+SB7km90rdQMem0YUYBKJBVj
         EXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1rLsltxCe0KQuVuZyGLA6hAjSltolb8BIgQ8SRMOV1k=;
        b=I6jyOfsLbA98XZQPDk8CIgGQCV+Qz0f3R6ysVrXwe2mE1jgJm8NfPWc/O0PD2i5XVT
         D9pfHnXlbbfNWj0BP1b6goFSAkXu07aiROONjbkvC2gDpyh01Cbkgv6n4rGgS0Ol1lWv
         xbYd5FovF7v0aNQnv/2GNHL58sk0Yn34F6hXkB03Bkc2Aofrd1mRLxUyeVAqwjzjsg3r
         u4XilPX4KKagvYuSP2r0wmscvB2qcTodX0HGcGA6IqghHEUR3uzn2E36+UuHF80WwxUA
         m5YIrfywBGDu8VWELs0vzeGKJg5K8u6tWgUsOsQy9zsH8nLzve2d5UZJu8I9gI5msn+Z
         Dn5Q==
X-Gm-Message-State: APjAAAUgVIbq16kLS5LPdXTenX7E8yYekKYC+n/eEtSsau2hVPoXRM7z
        E0RBCjltQ2Im9kVLGeri2D0xZTRxQGK0jMw+YJ2osTyHuQs=
X-Google-Smtp-Source: APXvYqyrsg5A4sXW2HdD3Q/TV5qdtNNkfDKCNrMvWKne30JXq5wZ9px2JKn68LNL4tSUxyWST32iJSEGYVber4leQfc=
X-Received: by 2002:a50:94ed:: with SMTP id t42mr89462403eda.288.1558520181800;
 Wed, 22 May 2019 03:16:21 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 22 May 2019 12:16:09 +0200
Message-ID: <CAP8UFD3rhdoarZPc9q0VSWVFivXaQx99scio4G-tDX6Pbbuhig@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 51
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        David Pursehouse <dpursehouse@collab.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 51th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2019/05/22/edition-51/

Thanks a lot to David Pursehouse, Luca Milanesio and Denton Liu who
contributed this month!

Enjoy,
Christian, Jakub, Markus and Gabriel.
