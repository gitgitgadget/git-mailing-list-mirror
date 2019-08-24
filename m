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
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4AB1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfHXWKr (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:10:47 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34530 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfHXWKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:10:47 -0400
Received: by mail-wm1-f49.google.com with SMTP id e8so11681596wme.1
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pLLFXCGv5668Am31WrlF04FVVcPLJfKWwB7/EgXET1E=;
        b=CNQV84H0rkXiZe/qnK/2DRvDjFTeMYGyOZMeT1KAgZn03eB+7EP0w3G5tXJ5TxLyZo
         9oXTtXL3lzD7e2WZT7rIXFvCSjMrFU2nWNVg6pxCyxtmSTBHVVTso8q5H+TSR+oNQ+CK
         Gx1bZzfWbzPu23nkF50BJcmET7Zuhq7EQ4HeHh5xQpTfRciR7mnTSByFktZ/21OHghxq
         iNqyiChEMi43Y1ObDE8sz7+eVmrVUwpylgysB2jPL77zB8yhdDDA9zIze+ge0KRqmch2
         P15Wq/ismveeLhPUoFbcqGJdgSqjhSSjMiskMUIz33/QKzp3nYBuZY4kXVrJzD4K+x1q
         90Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pLLFXCGv5668Am31WrlF04FVVcPLJfKWwB7/EgXET1E=;
        b=AWA5tDSzh0izFh3tfR7dfjAiFEyIprNzMRGLEf4fnprmja5vr6FP2eUfEubeH1LE0A
         +PNYu5SPo8sPRne30Tskb2Vl/H9IG4W9CDwrlt00V5DO40fPQk0syIj45pwqlxVVVJZF
         6IomBDagzaNdYgnrsGmFXviCsL20ivRiHkcIe9c3k5n6tK6Zc1PoOO6RwAOqAwK9xPDY
         f2UPKzZ1eFeNBPSxcjGhHY1XoX7TJ1AG/0ujZtxUUjftLs4wU4cfwX3zSoLALMCg4MNr
         v5QfqrXANlcUutMORTtbClF45CrZGfzazFLm+RjrqS+MbvULqnEoxVajdP6Kgj4WpHDe
         OLEQ==
X-Gm-Message-State: APjAAAUIPizl1pF/BBGtpt3FusCDCZlQVBKUPkijxDba5jYqsxKkvEsE
        X3nGYi54qZuATGyZlf4qSu5m36Kp
X-Google-Smtp-Source: APXvYqzqXOe3TU+d8ZtE8p3e1XfiSvMKpH3zudH/ien+Ep8J/me2yf8qrL7vzwu4JkUc1TjZl7D4aA==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr11667894wml.87.1566684645282;
        Sat, 24 Aug 2019 15:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm7130672wrm.31.2019.08.24.15.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:10:44 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:10:44 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:10:41 GMT
Message-Id: <bb29fcd20d3e3f59ed5d65f04148d73770f542b2.1566684643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.141.git.gitgitgadget@gmail.com>
References: <pull.141.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] setup_git_directory(): handle UNC paths correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The first offset in a UNC path is not the host name, but the folder name after that.

This fixes https://github.com/git-for-windows/git/issues/1181

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index ca9e8a949e..a803b3ade3 100644
--- a/setup.c
+++ b/setup.c
@@ -906,7 +906,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
 	const char *gitdirenv;
-	int ceil_offset = -1, min_offset = has_dos_drive_prefix(dir->buf) ? 3 : 1;
+	int ceil_offset = -1, min_offset = offset_1st_component(dir->buf);
 	dev_t current_device = 0;
 	int one_filesystem = 1;
 
-- 
gitgitgadget

