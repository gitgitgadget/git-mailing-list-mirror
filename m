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
	by dcvr.yhbt.net (Postfix) with ESMTP id 109EE1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 01:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfJNBbm (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 21:31:42 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34110 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfJNBbm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 21:31:42 -0400
Received: by mail-wr1-f42.google.com with SMTP id j11so17690294wrp.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ExBtnuMgH6SPEDeFB3WhVhTfYRcS10CS4uwEgyKXsIg=;
        b=HZFdkb78VhX1zXuLXCj1NT/Njjn2XSZuTu2ZwIQS8vAQCd5+kMsgow62jrL7HKOgUS
         sGV8S43gsArMBbV+Z5eiX7sK9FRxa8rjfXRCM1Ukj7O07WSfvOcv2uXb3UJbTI/v0Jfy
         HFX3HHT9VCbdp7+bfbp7ZojPSpSUo2YfguvbvEx3evshDSPrlxxINgfQVMenjMgS8qiK
         ie/ZV7i3dxOybb+iclHDKPZPAZ3X79pjS5JDyW7Mtaqq/eWp7pQvPbXwLaJaFKAsLnvD
         9LlZojz5VDB+enzdR9zB9tSthdaURBEJ4wyEMss2XiJzmXIwyx+oV5bUg8YYi1I3uLke
         iGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ExBtnuMgH6SPEDeFB3WhVhTfYRcS10CS4uwEgyKXsIg=;
        b=GdLjgESyCtLkr0O99NyeEVn9TOEQFA6kY+E4/p9ECfNajVIHbnNdEt990AyTX7cg+R
         4uvgdEyBIQtIkaVWg0+7anbdsyCdqvvm+cF57YmDemJzMuYFWmGiGBF4RKzyy5w1a/Xi
         pl8YKsstmkuSLzsxtyLt/Bp35uAa4lkluYhUdiPgXkl3jbuQtB6AV/qOelb1tXwuf2+C
         jZDdx/Xoh8eYj+wtmotbADmYwQTdqwrI3XqPNBJ2T4lGrupL8DuVRwE/YtW2Qd37o3sO
         sFuetBFQ76j15uDWhD0TiEfrwbibo/I7VSz9LDQwD807LXdjvecxg3ATXoPo1f99Zi7g
         j1xw==
X-Gm-Message-State: APjAAAXIX3EaOXh9vLCOVkIMEEBEQY8WWaswt2pEz8BNMVbsGo4YnTrm
        O8xSy6rhhVoMmE/x89SLTgdsxQBx
X-Google-Smtp-Source: APXvYqz0mVRR11KpXbVisfmAmUNi15gV8k0L7DdJKP3jky6+PMmgIMp8jemFM9bviQU+n3Mss/ygWA==
X-Received: by 2002:a5d:6241:: with SMTP id m1mr24595555wrv.213.1571016699968;
        Sun, 13 Oct 2019 18:31:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm15365599wru.33.2019.10.13.18.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 18:31:39 -0700 (PDT)
Message-Id: <pull.396.git.1571016698.gitgitgadget@gmail.com>
From:   "KIDANI Akito via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Oct 2019 01:31:37 +0000
Subject: [PATCH 0/1] git-gui: Improve Japanese translation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed word order in Japanese translation.

kdnakt (1):
  Improve Japanese translation

 git-gui/po/ja.po | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


base-commit: 08da6496b61341ec45eac36afcc8f94242763468
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-396%2Fkdnakt%2Ftranslation-ja-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-396/kdnakt/translation-ja-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/396
-- 
gitgitgadget
