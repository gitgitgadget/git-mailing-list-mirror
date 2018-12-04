Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68EE2211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 05:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLDFnl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 00:43:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36230 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 00:43:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so13704141ljk.3
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 21:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NChe3RuKGarSbs/ptRQHbQG647PlgGrbzCq+DwYaYbU=;
        b=sK7QiiBCU7vRmG2sZAbHXQ+9sR6KOYIy43f1vF4PPBnusGaUi8IDD3DHaMNMTJJ7SW
         8GNRc8Li4YWC4CO2xA4JtHipH3czb7zYSG14SgkDgBdJkiV7T8L0VKOiZ248ilPtSN9l
         StG4Yv5VaWl5INiFFSwSkJvmIz23dWgbVkK5fIwHYO3YusRulkHz9DrXkVwPdlJtrTjQ
         7Spi7mDk7HmKJqb+vNkBSourFGC/eesH1eJ7uQp+BvoPdph2ByGtLkDycF4XzzjEMrZl
         Qb1IAd7i7w5yN/BJ9jB3Fs/W7yNLQonnVAX1xUxOcZYDdYj9OuEJ3cp0VI3JGZVVdfpX
         BUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NChe3RuKGarSbs/ptRQHbQG647PlgGrbzCq+DwYaYbU=;
        b=ml8p6iAIO0913wU7GRwjIWarQ+iGsHaZgNm/C6h0gC8d3xBo6/fi4iMyRfaXrltXZN
         b8j1FATkM8kIzfbsDXFRnSy6qjUnF5DDV5IadsMX9PPeamvg91rMgwbhXeyadeWzjkdy
         vYtfrlZvAysHQOkccYkmQlRZnsTiX95hP/57q0B9xnAFy9yaXfcELAd5lT2BAVHLylNW
         3xdaym2magqrXhYLxUspZIMSrJtJ3SGUudifkMtoDBHjXTf5YuNqNMZpmNIl0K3Dh5TP
         +sBEjATrZm85mGxmmQzRVJlDhXpQLj7q9XVBCAZl8AFtiHHU56dg7hqAdGDO5rdRrxfP
         Ej0Q==
X-Gm-Message-State: AA+aEWanM6ZH3Z0m3jxPbvFfLmvIhrTXSvMcT6REI6TJaRb9Ed5Vlr/3
        nkTD2kCGJHLjMhvILsE0FF24ZcW3
X-Google-Smtp-Source: AFSGD/VDST8nZjSvo1MVQYhsckirtYSI1tIT96ipCh8fLzOQxwKxmFlRdvAAKPDXrtdittMWwiIwpA==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr11844024ljg.155.1543902219295;
        Mon, 03 Dec 2018 21:43:39 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m77sm2779217lfg.3.2018.12.03.21.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:43:38 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 1/3] RelNotes 2.20: move some items between sections
Date:   Tue,  4 Dec 2018 06:43:17 +0100
Message-Id: <961bfc2ad69e6a27ad68c6a4f0e92232f13c33f8.1543901498.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gc81af441bb
In-Reply-To: <cover.1543901498.git.martin.agren@gmail.com>
References: <xmqq36reghdk.fsf@gitster-ct.c.googlers.com> <cover.1543901498.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some items that should be in "Performance, Internal Implementation,
Development Support etc." have ended up in "UI, Workflows & Features".
Move them, and do s/uses/use/ while at it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/RelNotes/2.20.0.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index b1deaf37da..f4e79c4cfb 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -137,11 +137,6 @@ UI, Workflows & Features
    command line, or setting sendemail.suppresscc configuration
    variable to "misc-by", can be used to disable this behaviour.
 
- * Developer builds now uses -Wunused-function compilation option.
-
- * One of our CI tests to run with "unusual/experimental/random"
-   settings now also uses commit-graph and midx.
-
  * "git mergetool" learned to take the "--[no-]gui" option, just like
    "git difftool" does.
 
@@ -185,6 +180,11 @@ UI, Workflows & Features
 
 Performance, Internal Implementation, Development Support etc.
 
+ * Developer builds now use -Wunused-function compilation option.
+
+ * One of our CI tests to run with "unusual/experimental/random"
+   settings now also uses commit-graph and midx.
+
  * When there are too many packfiles in a repository (which is not
    recommended), looking up an object in these would require
    consulting many pack .idx files; a new mechanism to have a single
-- 
2.20.0.rc2.1.gc81af441bb

