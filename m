Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3031F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbeGWOyV (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36999 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbeGWOyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so447581pgq.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddTE0Ok7IMDD6KirZv1dBgWyO62hw+FW9ALu7L8iRUQ=;
        b=QAEkXmogpqVkwzkBvW41gk2+WEfT6RorXRLIK4rqTpJvfHRkxtx0tHH0XX62K+LsUf
         jDr1f+vPY8gLHBfNnmmQdYxfdDJW4YJv4+lgkG59Jf4fOtlJFe5jW0XlU+crVro6qnpe
         liJyAJwoGpQbIOwuG++SFbABbHoZM9xuJB4CDnCxkUoVT8rX6vQa7bQKP3HKBGHc3Rgv
         3arXMmIWARMkWp0mxFr3XScsYW8q2LqCqhsdELQF5Evq50GGDJV4fQw6a0uCxrLd1Axw
         qbTFKjQtbjwaiwNmHtRpvivtNQlMnprLAXx9jgCqhyHpdEyjxUF8wdt/D/UUZatvIJ6D
         vI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddTE0Ok7IMDD6KirZv1dBgWyO62hw+FW9ALu7L8iRUQ=;
        b=g3e6GkGiA5enJI1f+piKzPPSw/LYKO3E3V9q2+tqZONDuvDY4nzVZeEaTNTGk+1Lwt
         rfdEsqIWrUmwKEn2jOM6g8E825rOLGnidcaEUQdbw945bRn/BJYUUA+nvApApGP03ocK
         YUomstt4y+SToivDzF0uikidwBmPmI3rrv5/BsbH9pzDhYsOFt62Nibod7kCT68XP9+g
         yjaoGBCcLmYGGaM/ARpjfqTjKeLk8e+RdHieGBmG82XCIrIYx9pdLHvnBJLXmmCqEsxk
         Zk61zJzdx4iMhT5H8s4U/PYvmojf9salHvcXzm7OoxAlxwj9iPgtwMkKIE+Izs+Ak1Ah
         X44Q==
X-Gm-Message-State: AOUpUlEmnZkd6sF3np5ycLsP6vdSchs9so1umGUf9hESephJJ078It4u
        joyMEVCbGCQQ8oT7Zwc6Trb6Xjok
X-Google-Smtp-Source: AAOMgpfCGvnq1hc0Ph/PebP5kPhuO5bK8EpJjkMDzo2xji2IBfq8LYNJbKjACh3YYfzOd80GFyyxAA==
X-Received: by 2002:a63:4506:: with SMTP id s6-v6mr12719448pga.422.1532353976820;
        Mon, 23 Jul 2018 06:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id u13-v6sm12405467pfm.121.2018.07.23.06.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:56 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:56 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:42 GMT
Message-Id: <08212c57e5c088b4f2de3cc97d3305069c551613.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/9] vscode: wrap commit messages at column 72 by default
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

