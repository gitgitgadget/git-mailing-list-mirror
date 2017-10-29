Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40BF72055E
	for <e@80x24.org>; Sun, 29 Oct 2017 02:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdJ2CZZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 22:25:25 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:54196 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdJ2CZY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 22:25:24 -0400
Received: by mail-qk0-f171.google.com with SMTP id y23so12455073qkb.10
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xm0XO5C8FuSVHmsIMydVc2Ob8KYr7ejclny5UQVYFWo=;
        b=Q/UZqVZIxRbVNl6R3ccCfyigdVSTQPv7LyXwCnMk3HZdYjrHBMgnWMkFck9/La66Uo
         2bnuWQKGhDZvj1i1LocJI3jvWCB00SjCqc7DHekB6a0Oj3pgGRF+Q9482VXia5AyVPFp
         yyxozNZgDCSRcezBEZZAV0jP6hg9b5G/VQokEhI92A6wffCYBIQa422dLYXRxA6yWpJq
         /X4wsCK2kejkyXv8g0nU532biYM6TD1xPIrbZcwK5X6JJG1uvb4z3kXZ3UvYbvioutcG
         d2oBuzZtZfKztPnSEfK7Ig2LhA2PBsLbCnbgvS4lXlS5k+4qeukkj2lgSaM8/c+4JtX8
         Md3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xm0XO5C8FuSVHmsIMydVc2Ob8KYr7ejclny5UQVYFWo=;
        b=iZplV92iw5LX8mpJCZp0Y7DylPpVMaWUDXNdZ677oCsyahrGrrXQ5kG5awF+ytlC8r
         Ew9gk/OyfpTUE8g7Mea+Ww8HimLVqtYaJT4epKzWmJy+Wa9pzP1vi8gm5rA6YrFb5BOZ
         zn9DVK9xKKrKXaj9c7mdvIERINMyHcufYaiKyHzQlqESErkS+gFj+vDY4bsB3kAsRq0K
         y/m/yWoFihoVMFw/TxWQKgD0vBOZe/3G0Spw/5fTaozjhHpOQn0+7qvnG8NaFd7dFH4f
         t7msjNurvZYIX7Ck0F+wnKUO/lUhUzM6KKsANULjXbL2PKee3td4XsgnQf65+RaocY8/
         7QVw==
X-Gm-Message-State: AMCzsaWa16Eb4j0aMWBuuhnmUBeknjuTI7NqLUsF2qzKgzr1peaKG5Wx
        krNmO8P+PKeXRqieQ0FefP8RH+IIYXUjy5PAh30=
X-Google-Smtp-Source: ABhQp+Satpi4XjPuu8a+T5+JeqPVyjz9su9gqjgp2XBPsioDHQXUwI12gZgpNRobQDBp2yeKxi13BdkmYSje6+Qh2b0=
X-Received: by 10.55.40.19 with SMTP id o19mr7779477qkh.146.1509243923490;
 Sat, 28 Oct 2017 19:25:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.138.51 with HTTP; Sat, 28 Oct 2017 19:25:22 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 29 Oct 2017 10:25:22 +0800
Message-ID: <CANYiYbEwcFZNULu2ZvOmrzm6bw4ye_9anS+MaMwJkwYUGV+=Wg@mail.gmail.com>
Subject: [GIT PULL] l10n updates for 2.15.0 round 2 with Catalan updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jordi Mas <jmas@softcatala.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull this last time l10n update for Git 2.15.0. It contains
squash merge of
[PR#267][1] and [PR#268][2].

The following changes since commit 1165e3c317b51a3f47afe1a5762b92cac695fe5c:

  Merge branch 'jx/zh_CN-proposed' of github.com:jiangxin/git
(2017-10-24 10:11:48 +0800)

are available in the Git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.15.0-rnd2.1

for you to fetch changes up to 3f86f684b4f3de31e08b0aa24b6c1e61ce2971b5:

  l10n: Update Catalan translation (2017-10-29 10:04:12 +0800)

----------------------------------------------------------------
l10n for Git 2.15.0 round 2 with Catalan updates

----------------------------------------------------------------
Jordi Mas (1):
      l10n: Update Catalan translation

 po/ca.po | 181 +++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 123 insertions(+), 58 deletions(-)

[1]: https://github.com/git-l10n/git-po/pull/267
[2]: https://github.com/git-l10n/git-po/pull/268

--
Jiang Xin
