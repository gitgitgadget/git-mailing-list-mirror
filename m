Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE2C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeGRU20 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:26 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:34953 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbeGRU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:25 -0400
Received: by mail-yb0-f202.google.com with SMTP id w3-v6so2993833ybp.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=/CznyWcGeZFbhRWA3FqHnVAzMpRFPLxVnzkIGYgNU2Y=;
        b=sPNbAiGLMMEpFr8Y/prvR4the8gXQT1Le4tCFJsS68H+Hz6N293LnDNIOfr/T9Wfj0
         te8JAoTepe+7zmVyCwIDyt0CSS/xaZ8lZwuPl37lL5ZA8bN5Ni19oKDcezLFjvXVWa/i
         OZcrbZTWTq325JzQLDXzuI4kGqcMrGRRT2eacq+y0ACKsmMhDOi/VKhDAw2pfz6NYZbX
         KKZpCSjI2ga2G+mCnYFVSXMgBgLtmyqGaojEVobj6ntr83vZg22lOse+tL/v1oWKBDgL
         LhEyTGXzWAGl03iK+t05p6cauZ3s76dILLoo7m/0w7rjGyCH/cT/xoSTcigpS2c6cKJ9
         pn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=/CznyWcGeZFbhRWA3FqHnVAzMpRFPLxVnzkIGYgNU2Y=;
        b=hfcPrB2ZY0PzMEmtWnguGfLTZpGWi7rZpgNodjdzunOcqJFD2AuDYzgywGHcbyh1HU
         mOTYRZX2ZlO6uYjmMhogyeo/sViAd2V1ZRWJK9cYhfrBJsEUJJR0HPY8vJbVuu0fYI0P
         2+DMt+uXTN9F/2jzwPXQTbbfxHNN9P5awUoXEpxLw3yF2M2UEeWQvvO8YbWKe2llJ+AH
         6dtM5q6y+WtEqtiQvI3RbgqcY7otitqHUOqHi1/mG20ZFbUkiaXy9T+BgIehm537eGup
         OQGSiRWQzAeucOQwDiR2TzE63nStKb6mDV9OXMTVvqt2JWAoO+NkwBVZKRXhgjVbq5Qa
         p4sA==
X-Gm-Message-State: AOUpUlF86hdCuM98213pBKbugOxnAVTMWZWu4NZxkpOWFQOVHdBsBP03
        wReuUAFWmq4dR9wBHvvXuI0TmkmjhqF8WvobJ3mANRtrf3jLDMAWw44r5+ZU41D/kDfvvcBPoyC
        pLl7YVzLuAt+r7Z71V+1/OS9i/mEadiZK3tVvWen2JI7eQ1/CXpTyk8idzQvm
X-Google-Smtp-Source: AAOMgpcheRyVFk4ZRbnXKc28jqK0BTsFgA+FZitEcU0idxkUdB+LwJiFHlIImGBCdUm115WiE/SIhxfq7fPe
MIME-Version: 1.0
X-Received: by 2002:a81:3a14:: with SMTP id h20-v6mr2257883ywa.48.1531943341532;
 Wed, 18 Jul 2018 12:49:01 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:47 -0700
Message-Id: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 0/6] Resend of origin/sb/submodule-update-in-c
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the compilation issue raised by SZEDER and Stolee,


6:  3c156c79ae7 ! 6:  f82f24e73b6 submodule--helper: introduce new update-module-mode helper
    @@ -10,7 +10,6 @@
         for arbitrary repositories.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
     --- a/builtin/submodule--helper.c
    @@ -74,7 +73,7 @@
     +	determine_submodule_update_strategy(the_repository,
     +					    just_cloned, path, update,
     +					    &update_strategy);
    -+	fprintf(stdout, submodule_strategy_to_string(&update_strategy));
    ++	fputs(submodule_strategy_to_string(&update_strategy), stdout);
     +
     +	return 0;
     +}

Thanks,
Stefan
