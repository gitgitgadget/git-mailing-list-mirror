Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DF81F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfFNGuz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:50:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40546 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNGuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:50:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so696812otl.7
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yX1Qmm8emDQUl/Y7GVHKDOJwPu4OnooLto8Ip9MCctE=;
        b=KAlmjtwPCgPtwZVi6oExhbvecWmxYwpjbsXNPiAfTG9pTFpWo76PUrxntec4qgv2ty
         lGODD06o3VAwnr3PA5HubV4NwVPm0mS/kuwNNarCNO6tYsQWCrSXvwZw7fU5ycxOU6jC
         LAq2nbErc6YN2t9blCYuOopa4bm19bIgFX4uEhvwyc0k7EaC72ycPqselB6R+s5K6Yrh
         ul75JlkNRkdONlLNm/Np6ghnorD5JLQUBKptPa3LS5hb4bKfkMJEaq4ZA6MASfZbJhbx
         EN2nrnIa7R6++InjLX+1c1yZceU9rSLe82NkITT2bchFUseJm1v/FGJCIursP62cJLC1
         KSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yX1Qmm8emDQUl/Y7GVHKDOJwPu4OnooLto8Ip9MCctE=;
        b=fqYhq02916GQf8u6nND/p3htjvjpFzZlz1FMOd8GZjXALrAlEZTTJ5lRZXxx9h5wRF
         VSLfUN/eQ+0tjrvbgcqMxeMV8jhP4+nvJ8UFa5ztaRijbCu/C5K1CiyomsxP545YLy4o
         pzST1HvEpSRxP549bqSiEXujKm3SxFpeDpBn+ZeTD5iqKd9RXkFnems0KEuGwVGgOOor
         neU+PsqbZT0CwLcSQUGpZP0hA6mP1gzuufDYNK53wpLGboA4Np6nrQWkNj4NBXmjhA9B
         ZZ/Pt+ZXviHOlA0FM1/oX7TlKO9ts2B99GEGtgmv12XlOuqqxZJ+dTh1xCFnbb8AV1Xn
         JO0Q==
X-Gm-Message-State: APjAAAU6BJqLa8auP5mLvNx5Y3tdkV1f0LT3jrT4pMrcNoycB2eM2axQ
        EfKAK9IvTBQUWQTpjiAa/QCVneTj5FE=
X-Google-Smtp-Source: APXvYqz4Gv9b2pOkK48Qea6kWqrALxDSgIYi0un7gzCm/8iMVQ+Tu6SuUyzfm8O6bk5aCEQPCvFgGw==
X-Received: by 2002:a9d:7601:: with SMTP id k1mr9469835otl.254.1560495053723;
        Thu, 13 Jun 2019 23:50:53 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id k17sm902880otl.13.2019.06.13.23.50.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:50:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] contrib: completion: general zsh updates
Date:   Fri, 14 Jun 2019 01:50:46 -0500
Message-Id: <20190614065051.17774-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helo,

These patches are definitely needed, and some of these have been cooking
for years in oh-my-zsh.

Felipe Contreras (5):
  completion: zsh: update installation instructions
  completion: zsh: fix for directories with spaces
  completion: remove zsh hack
  completion: zsh: improve main function selection
  completion: prompt: fix color for Zsh

 contrib/completion/git-completion.bash |  1 +
 contrib/completion/git-completion.zsh  | 33 ++++++++++++--------------
 contrib/completion/git-prompt.sh       | 10 ++++----
 3 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.22.0.rc2.dirty

