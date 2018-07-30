Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B097F1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3RS2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40133 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeG3RS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so4707063pff.7
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddTE0Ok7IMDD6KirZv1dBgWyO62hw+FW9ALu7L8iRUQ=;
        b=qXMHr8kqUT6RsxtvmrfktHPJAF/YL+lUeauDu8bPlQG9Vkpf64EvtZFbiOFFvZYzkx
         kZv4+58hGCT/8Uvf4ChMPkxa3j6QcbeNpjl9PLYwS5WdR8G3+Fbyi1jPf/qvTgzzw9Mn
         Yq7osD62e2Bvk2Z3b1eJWpO2xZIpYqyDHWOv7RMomteqOUIeJ7Nrd5RTok1jJTvKr5Jr
         nxMHFxhns0+XdfRI2giBgsZFprP6G9SWYCNuarVBBWQyxjdzJMuGbANhEaqGDWiWhQaC
         3AIErfRsyjyDoO5O0nLz8tdVoISx5M7vHKhZmhBhUQa2/goV7l78ux4dBHddpNAHOMgE
         5cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddTE0Ok7IMDD6KirZv1dBgWyO62hw+FW9ALu7L8iRUQ=;
        b=SMGJTK7GvrJRvVt+pNknHi2EkS/j3KbJgcHP3DNMWmjLoOx+UgGnXSMxNeNx2QExdZ
         NG5xcK3yHRc+1VO3lyK7jg0UTbcGx+WAb/ADlCbGl5FD4DUXKL2GLRL++UBmFBW9YKjq
         Zdcoy9y1NDgIk7SziF2f0tfB84qavG02QxkqMeJ/jhegp2rhQd8UttLUrOgbSNgG3zop
         sEmR08jq6EKVo9NMfPtv9ZadKr26P9uNtHzKqoY2opRS9oDqc+cMyEaWwNR4uMz6eoYX
         ZwyTvUPkBL9DgFFdErJFgZ3ZU0SZS+9D/AdfIrPnEu8JGncq7gaCg/GhqQntKoLt7L62
         DYwA==
X-Gm-Message-State: AOUpUlHnZPiUVsF2PaLgh+E/QmsMy5T4566AF8ARabaOYTzj03y+xyPD
        Dl22Bnc2dpefi7RoFNqdhHAcaRUX
X-Google-Smtp-Source: AAOMgpfMadUn6kooJpDzpUyHPy2vbTV/qs23EFnDnHDKom4nLJy+yvIk1y41TuXroeSLImeQhUDf4Q==
X-Received: by 2002:a65:5a49:: with SMTP id z9-v6mr17058616pgs.244.1532965374976;
        Mon, 30 Jul 2018 08:42:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id j1-v6sm32829048pfk.125.2018.07.30.08.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:54 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:54 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:39 GMT
Message-Id: <384b08836390e32e71842d6d547c13500b963d0d.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/9] vscode: wrap commit messages at column 72 by default
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

When configuring VS Code as core.editor (via `code --wait`), we really
want to adhere to the Git conventions of wrapping commit messages.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index ba9469226..face115e8 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -17,6 +17,10 @@ cat >.vscode/settings.json.new <<\EOF ||
 {
     "C_Cpp.intelliSenseEngine": "Default",
     "C_Cpp.intelliSenseEngineFallback": "Disabled",
+    "[git-commit]": {
+        "editor.wordWrap": "wordWrapColumn",
+        "editor.wordWrapColumn": 72
+    },
     "files.associations": {
         "*.h": "c",
         "*.c": "c"
-- 
gitgitgadget

