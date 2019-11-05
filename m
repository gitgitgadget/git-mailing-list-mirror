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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E6B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfKEXbf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:31:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37200 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:31:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so17603101wrv.4
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Mt9gb6aKJh1SHCMgA94F87+sV9p+cIOce7MqMA95Aoc=;
        b=G/TpJXZ7sQ8bPKQvw435PmSJEU1Sw6UVgnvCBD2hq0xTRzVP/lj21dYsAyVMHsCsxf
         WWTxY92WWSqjQ+GwORKydezlZokGCQpCceiuVuI1e4zFbM6arv5DxSDPV+iVzXTQwUyi
         e/RXzQI+C5s0M4sqmOZ343Qp2vONfLpVSEDVT3rxHkyW1xsYRoYFoyOpJuTVDBRNkRXs
         gCMkFXM11lXs//eX/X5OiBYDwos1IK2gaWfZkkSbreYiwcpMtW9z3zqCMhIrm9TL2VSO
         LnEScgLElvQgE5IlO+vbiWcVTDRxVOhJCIjg8+h0wLGEWLcW02u19QYjb1HgYDYXlr76
         XFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mt9gb6aKJh1SHCMgA94F87+sV9p+cIOce7MqMA95Aoc=;
        b=avVXxKrqdA5+JdKWgus6f9U8xX8IHwrQRfOVSR5K3rixwgFT1cqXYKsjcswyNjqh6g
         as5zzTmW8BGHpRQciymF+U5cvj2gyHs4C5FT60yN/9YeMX1lwO+Ef/1ejhaDCFA55kID
         Ebnj+7cil/syAxG3AecIIzUKcxpACrWmIq6EmSUQQQKLHT7J5iqUEMuJgJ/v69KhBFgE
         LK8K/tclpFtirLOURzjKnxzDtmmxuROL98CYA0cNIBo4fe88IQUt6OcLZTyqrk60c3wB
         W5WYj3m6wZ0rwxFDq+Bv8mK48tRgZ7WwnXYE6/kY0/a8QG/pSOgAETbXr/I0srTXv1pP
         FxJg==
X-Gm-Message-State: APjAAAUR3f1tEPWFbE2Og96sxGtUK1VksBgsut18bVpUcYbraHawGltd
        TqaSjjKNX5GNb5kfLnr4HWbhFXp0
X-Google-Smtp-Source: APXvYqyPqZ+PKg/8iP9zA+E5lXXnKdFqvl9NwhwjA+p9ujNfm55FQn7s+8H4bvyxU5G35kE1fWJpWw==
X-Received: by 2002:adf:ee84:: with SMTP id b4mr28629125wro.31.1572996693278;
        Tue, 05 Nov 2019 15:31:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm907213wmb.34.2019.11.05.15.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:31:32 -0800 (PST)
Message-Id: <pull.454.git.1572996692.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:31:29 +0000
Subject: [PATCH 0/3] Other doc fixes
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

In addition to the pile of spelling fixes in my other pull request, here are
some simple documentation fixes other than spelling errors (remove repeated
word, '.' vs '->', missing hyphen).

Elijah Newren (3):
  git-filter-branch.txt: correct argument name typo
  hashmap: fix documentation misuses of -> versus .
  name-hash.c: remove duplicate word in comment

 Documentation/git-filter-branch.txt | 2 +-
 hashmap.h                           | 6 +++---
 name-hash.c                         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-454%2Fnewren%2Fother-doc-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-454/newren/other-doc-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/454
-- 
gitgitgadget
