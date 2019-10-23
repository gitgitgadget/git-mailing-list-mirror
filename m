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
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B131F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 05:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfJWFa5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 01:30:57 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44487 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJWFa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 01:30:57 -0400
Received: by mail-wr1-f43.google.com with SMTP id z9so20469019wrl.11
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n5f3RaVA4xJ7++MTAi/wB9e7qZixNvy42k1ecZXE/8A=;
        b=LXkqJZyjK4T2phdVpvt7CcKzzARWujikDGg6B+9LQJoP6F2nizDs7WBwzYXxy8g58A
         3KwkAOUnY1E6D8ovIMOclEBkIz446ItcUTv7PPsD4CXHcaT9NMS+DvHEa+vu7gIzmQjl
         Nxehqd8l8ISu3sOhPLMAzfdNTf+7PRrZFRs63RaaD0me/BufFRybmE2cR9UulHucNb9q
         hD0V3lH9505HGEmybuW/S5EaHlje6DGKt+o1h/ncvIsPOsCewvmhvUOYcvdIPXjVjqDX
         ULJs1Kqfwne/h3PxvaBGIAAGwiz05ZinuzDalG2s6S5v3c1o2Z907xeoNVEhPEvdK403
         uBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n5f3RaVA4xJ7++MTAi/wB9e7qZixNvy42k1ecZXE/8A=;
        b=ufuhVKYHVnfZzRlQfrYbJD/rAOacAjCWEe9jlu6O3DERBGWi5rtsnEEa+UICc1pC4L
         flHiSOkoRMw3rBLrY1uHTveVMMTHpVD7ODQLaf9ZU7eFlXU5Gm/DcZm4UbuFkSI5/yFW
         flgWZqugyT+teEiKEzAWHN1fjwbB+HhaiT9Ezfjgf0VN9nCiRZuKdzhyi5wdHNyy5tg0
         M04JWW7GisfrdUt10LoPW06zoijr6+1oY4xr50fUPBiVas+GAhwh392qofa/QWW7qdB8
         utT595W2lVRWR78ZCj+h2ZwdbWq76KcUZDAfvyW2TXsz1Quz+OTBSWgRD0ck3S9KtP3E
         rxXQ==
X-Gm-Message-State: APjAAAV30sfST+48vPsqVf1fciQLmrEJBc7dOwiyoQu7Xy/veBcJxsWD
        x7FGOnjl61hpwDzZbjkhzhwgQnBR
X-Google-Smtp-Source: APXvYqzKw8wB1FMppbwiBonClczxnUAs8CCiWYrISagcLcOZMoRYlbFdFa1yCfwSIWc7fl4g73huQg==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr6457347wra.271.1571808653467;
        Tue, 22 Oct 2019 22:30:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm16839424wml.26.2019.10.22.22.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 22:30:52 -0700 (PDT)
Message-Id: <pull.405.v3.git.1571808652.gitgitgadget@gmail.com>
In-Reply-To: <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
References: <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 05:30:51 +0000
Subject: [PATCH v3 0/1] [Outreachy] config: move documentation to config.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation from Documentation/technical/api-config.txt into
config.h as it's easier for the developers to find the usage information
beside the code instead of looking for it in another doc file, also
documentation/technical/api-config.txt is removed because the information it
has is now redundant and it'll be hard to keep it up to date and
synchronized with the documentation in config.h

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Heba Waly (1):
  config: move documentation to config.h

 Documentation/technical/api-config.txt | 319 -----------------------
 config.h                               | 335 +++++++++++++++++++++++++
 2 files changed, 335 insertions(+), 319 deletions(-)
 delete mode 100644 Documentation/technical/api-config.txt


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-405%2FHebaWaly%2Fconfig_documentation-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-405/HebaWaly/config_documentation-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/405

Range-diff vs v2:

 1:  1a9aa33b46 ! 1:  d6cbb3197a config: move documentation to config.h
     @@ -3,7 +3,12 @@
          config: move documentation to config.h
      
          Move the documentation from Documentation/technical/api-config.txt into
     -    config.h
     +    config.h as it's easier for the developers to find the usage information
     +    beside the code instead of looking for it in another doc file, also
     +    documentation/technical/api-config.txt is removed because the information
     +    it has is now redundant and it'll be hard to keep it up to date and
     +    syncronized with the documentation in config.h
     +
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
       diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
     @@ -341,8 +346,7 @@
      +
      +/**
      + * The config API gives callers a way to access Git configuration files
     -+ * (and files which have the same syntax). See linkgit:git-config[1] for a
     -+ * discussion of the config file syntax.
     ++ * (and files which have the same syntax).
      + *
      + * General Usage
      + * -------------

-- 
gitgitgadget
