Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144B61F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeJWFGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34993 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeJWFGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id w186-v6so456227wmf.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnRv7OGUnsjCR+ZGKa5anJYm2OLvka8QLZl86oX7U9g=;
        b=hdA0cUaf2mnUTziXtx0xH6JmSS7puumousN9/FLGlLtlVNWLSv/aK1BJ4XDAomiQkd
         Ekd/Po/YS0l3izXL4W9g1DbxxnuVtdu5RuAdhmxh7QjKT76PAs2rrnr7RSzSMicKhwHQ
         AEodl6zgIIyIflZBIGJMhhHVnaaaLvnhe2SW9NXhymnmNvLUAX/2fbsKfHHR2zgxXLqw
         66tA5tHlWy2ugusezpUvzNnS3vN2hnbU3hd5/2XADJojuMt7N9coK4mnayQn8fLD21Z9
         l0KRmA3A1hCJtsY/6ZcF8jRoAdnyw6COlgvRD1ATw/1wBzf2zwwaL8v9h4z810ftTps6
         JchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnRv7OGUnsjCR+ZGKa5anJYm2OLvka8QLZl86oX7U9g=;
        b=BshkhqDK1Uqu0HeSjjngFTDBIzh6dDHuA5B2VS3HDzOoA68Sw0a3kWrnI5TmHnurPs
         bq6OpFMZpfVNYsN5vp5v99has2ljzO5HcPgqObkj+4BvrIe8mzCT3jUOzNcD6PF55Dut
         TIw8Y/7Tz97R6mPevlx36+D3zVDgasjYv5Wk82qRJk67HvoOnZzNdPbZXTsoRUhutbO9
         wwzvxaB9stsIRhncA+V/rmNWoDeEzxlrQTjZLNy+h9rKy33460MN6OA00ZyKGG/Qiqf0
         qm1wIn9F/HUt2TjfkOUVt1won8cf3B6vG7PrvgutPXI+q4FCU6T0GdpynfI2ZzjJS5Kk
         QHIQ==
X-Gm-Message-State: ABuFfoh6NVYqct9ecRaChKlaUJonLh++QzxT/6gpcOeSDjAaA3NWDUBZ
        TAuG8NlMr3bo01NY9azwXJ4MD2zJ
X-Google-Smtp-Source: ACcGV61Pm1irBt9MsrK1U1xzcLIbMbPh98idzsXGbLjA7OBbfdh2BEOxXLDucCSxh6N6KAmhTX9x8w==
X-Received: by 2002:a1c:c40a:: with SMTP id u10-v6mr17438214wmf.30.1540241185973;
        Mon, 22 Oct 2018 13:46:25 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:25 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 6/6] doc: fix formatting in git-update-ref
Date:   Mon, 22 Oct 2018 22:45:46 +0200
Message-Id: <20181022204546.20354-7-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022204546.20354-1-asheiduk@gmail.com>
References: <20181022204546.20354-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the parapgraph numbers from lines explaining the reflog format
and typeset these lines in monospace.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-update-ref.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index fda8516677..9671423117 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -129,8 +129,8 @@ a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
 symbolic refs before creating the log name) describing the change
 in ref value.  Log lines are formatted as:
 
-    . oldsha1 SP newsha1 SP committer LF
-+
+    oldsha1 SP newsha1 SP committer LF
+
 Where "oldsha1" is the 40 character hexadecimal value previously
 stored in <ref>, "newsha1" is the 40 character hexadecimal value of
 <newvalue> and "committer" is the committer's name, email address
@@ -138,8 +138,8 @@ and date in the standard Git committer ident format.
 
 Optionally with -m:
 
-    . oldsha1 SP newsha1 SP committer TAB message LF
-+
+    oldsha1 SP newsha1 SP committer TAB message LF
+
 Where all fields are as described above and "message" is the
 value supplied to the -m option.
 
-- 
2.19.1

