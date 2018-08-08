Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1285208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 11:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeHHOJS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 10:09:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41442 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHHOJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 10:09:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so1022653pfn.8
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=B1FofVA7cyfo1YdJKD1/a/bchmTp7JD38HDeu8J2HMg=;
        b=jjn0xG9heXP6Q5VmD+9BNb/nhGDpYplnTiI6KlDvQqpNc4i1XNp+V9cxhOtwauZneB
         NBiz/Gom/uFsfjQTJAqf1aqL+4zXZwxiBhLqFgjkXGdEhywGV5I+9OC9VfjAdqUQzLHU
         MOdf9exOPxHLP5Up3P2AYV5lwmJTQ2cl6EQ83laP6WFu7FGZkL4/+4SMYrspzNAc9+Bs
         qvGkH5FpoZ7eRZtJFT54iAEm/E7Y1Bg+GAPW6uCCrIUwLLJI+1MAD0VjM9ARTgigBawE
         Mxa1kY28kB+tfJk3JP5B7leoPSNH9tTeeazVnNDbnC7x/t+iqEs5VPgW1O/kkgMnZwtE
         0N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B1FofVA7cyfo1YdJKD1/a/bchmTp7JD38HDeu8J2HMg=;
        b=Y56hcHVABsVtvNpz1zQQA7lgd9Vl8S5LbPAljWrxSGYUFOGYTja2Cno5Hkl+JeFQnc
         urG/sxFgbKGJaFBAZrwuC1a1J/mgDd1bYaUHEC28nG6ibJLT4a7j7KPBi6LjFHgvm8/c
         NtsYyL+Nd/d80HuZ4Yl8cUy84luhhXQ02q0Qar68hUoUkTaek6C0sOmEmRyVnOWqzVPl
         54udLQPNb8XdACymCg8QRlgIVF3FUL35VLsWvIJmGiLqHPPIkHlqFJ6LjJCM0VBuGCTC
         SGGIy9v+ogqpinS9vZTcwwr73icZbsOy5NY7I78twS051JscbXZpQDCGq5Rhf+mJ29O2
         E9LA==
X-Gm-Message-State: AOUpUlHdyX4utwOMuWmsqM+ZpMLlBdMOY3YSjht2IUGIMzhuOgDRvvga
        RfQG3aWvMX9z1Ky+W1RwP+bvMnHQ
X-Google-Smtp-Source: AA+uWPyxGgOCuWZa6c9zowQWJk8FU8lzaGBFCIyi2erm7XaQf1yH6EFmzWfWr7O1Hq32ytray844gg==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr2636865pfc.70.1533728997924;
        Wed, 08 Aug 2018 04:49:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id c85-v6sm6890429pfd.110.2018.08.08.04.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 04:49:57 -0700 (PDT)
Date:   Wed, 08 Aug 2018 04:49:57 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Aug 2018 11:49:53 GMT
Message-Id: <pull.16.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix two grammar errors related to the word "save"
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

I stumbled over the one in git-compat-util.h while working on an unrelated
bug fix, and then got curious whether there are other places where we use 
save instead of safe, too. Turns out we do not, but there was another
grammar error where a spurious . interrupted a sentence.

Johannes Schindelin (2):
  git-compat-util.h: fix typo
  remote-curl: remove spurious period

 git-compat-util.h | 2 +-
 remote-curl.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-16%2Fdscho%2Fsave-typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-16/dscho/save-typos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/16
-- 
gitgitgadget
