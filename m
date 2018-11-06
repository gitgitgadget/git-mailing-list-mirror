Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA8C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbeKGAVZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 19:21:25 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:46413 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388887AbeKGAVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 19:21:25 -0500
Received: by mail-pg1-f175.google.com with SMTP id w7so5905214pgp.13
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=q5J+Z+xbkQMK4cEwF/RfcF7dbxRUJLN/Z5wupZbvix4=;
        b=Uir7t98cQS4AQBeZ/AC93EI0FjjJfXSfqbdu/rLIfOdc7ZwxF21t62Em+l5YXcNrah
         zgW0wzgLXgCWAkAElewsAhSYPzJ0ZcKLM7I2vAZFabxNv+mF8zOxxiCf/21MAtOFbPO+
         kCcoe8rPAKNswCCzVxODNr3eMJJq8wkPO8W8gGREv1qDA5S65gAJ8avhaQmaLUgeejwc
         IlPfTq9HJlr5a0XIpqVSwdQfjiQRwu+y36y9zSVR3MH7fvB1C6ahZ54xb3uTndNL5Vtu
         ocbLbqVpQmI22KfRODRrlr4i0K4gKqKfQzNQX5W67wjtaRx64yXH7wFy7vqQ2A9ghTh0
         8cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q5J+Z+xbkQMK4cEwF/RfcF7dbxRUJLN/Z5wupZbvix4=;
        b=gGNqOerGv9AATV9hne5Yj9DbvTMN8RwC+eyfFKjhqhc58RSUGH5Wz4W4n6mvSHoNg9
         mrMIkdVuCJ0CEPwOmGn9JBTrVEvgEGwlMFvpexd6MFMQ7Yhl1NaGXQps+bcOlTH+uUOd
         ZNhcJK/yH6/k4vj/k0gv1yfJO+k7EIZvxhIb61biIvA5JP+2+/zizy6IQiWytzEPQMGb
         JzR82TyRBywto/OQ4FKiW/H3oJh0zoH7h3fQnxRLWABpnHls8vY9LRDWQDDy7EK0niLV
         IUzRClNv3ElWmTvAZoUn3sFiv/TT16hmMZw3qFB6Rc5xcpdQ5TGNfRCbgWSdEUxpFB3K
         tGHg==
X-Gm-Message-State: AGRZ1gJlYMO67nRd9O1JS4CLyYthaDNKU6c/Mfsu4du0BflaDSLWEuTL
        SfDqUQ3d1vfWqubkmVZf/9Q/0alxiP4=
X-Google-Smtp-Source: AJdET5fCEKwkIoCYvYgfoUtTAw8OZnlFQC/8ECRL3vMWNuFOn95IOOTIeLEbSGtRlyVV+AUmDacYOA==
X-Received: by 2002:a63:a441:: with SMTP id c1-v6mr1093168pgp.49.1541516149869;
        Tue, 06 Nov 2018 06:55:49 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id z22-v6sm45788877pgv.24.2018.11.06.06.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:55:49 -0800 (PST)
Date:   Tue, 06 Nov 2018 06:55:49 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 14:55:46 GMT
Message-Id: <pull.67.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Windows: force-recompile git.res for differing architectures
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

This is a patch designed to help maintaining Git for Windows better: when
the same source code is "cross-compiled" for i686 as well as x86_64, we want
to rebuild the whole thing, including the resource file git.res.

Note: regular C files are re-compiled appropriately, as the default prefix
in Git for Windows is /mingw32 or /mingw64 depending on the architecture,
and this difference is manifested in the CFLAGS (which, upon change, trigger
a complete rebuild).

As non-Windows platforms do not even compile these .res files, this patch
should have exactly no effect on non-Windows builds.

Johannes Schindelin (1):
  Windows: force-recompile git.res for differing architectures

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: cd69ec8cde54af1817630331fc441f493866f0d4
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-67%2Fdscho%2Fmingw-git.res-bitness-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-67/dscho/mingw-git.res-bitness-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/67
-- 
gitgitgadget
