Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22951F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeJ0PEJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37853 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeJ0PEI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so2479808lfa.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nb9O4ECxblqOyTLJsxaP/VcrF8Q9d4BpIMbcMUJqzQU=;
        b=p8sdPe7wiR+fj3yn4XMl9nQ1vAVdq8h4EhZEKaLpcTYnpAiPowy+dYvPlEHT3BCVmM
         LKIx1hKo1oTwE0HTlmfsFxQXC0rnm4eTEZbK5MSWkgVG0P2lyYd61IQHBtHJw+FBuVUR
         oqTj+aky4AInzTtIZEDD3aV7C6OhNjExFixwdI4Jf+GKw+cTNS+bOKOh9uYTlnqndGY8
         6NVJwKhfTUnBcCaPB4SI7USkNPk9rnGZbQECTcchk1EutVZC1Dg5ehm3Ov3+YpzDi/4D
         JY6Ld0lSg8MXxtZixDvMLLkb7HlUU6ur2aUGmAv1G0qZo3O8n8CVr2k63B1ofWerwh8G
         LuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nb9O4ECxblqOyTLJsxaP/VcrF8Q9d4BpIMbcMUJqzQU=;
        b=hjLD97+YzU2Qv67JEbgmHiZO6UN8P044jmm1+lQ6L32cDh80qzJHTedZnyd8Ds9M3y
         XpHb20H+PUl3Q9C4OPGyxzWw/p5YeFimGtNU1N3xtyfV6MrUlNL7M2dPOft0UHQvXVBD
         2GfT6uxX7GJoE5/FbM8+H35e0427AQd/dZIl0h6OBl2zbPgDKZOXaYnTsRGuIA5oov8D
         gAxmyvWsBVFPPcp+9RY1cJi9l3iiSk4GVti/rKZWYf2cT1N/5S3L3gLARub1fDfnVf2n
         W4HytJW0qX/JDgdiW1KA8xfIdBKs8yc0qezAI0pdWUu/V+KHz28IAPdayp7GTTZC6mLN
         2/LA==
X-Gm-Message-State: AGRZ1gLOAoiJp1sDnguchSaea0Ifgaoofg34HK1NUA0QzBcrtsHl0j1C
        8LVqw9JJpeCtwW19biLhPezG3TCq
X-Google-Smtp-Source: AJdET5da20feVrvArcqz4rUJ36COYbmRHHoZEelAzwcgbbIimSTm5xH5WlEifRLLM2h4eGrXk224NA==
X-Received: by 2002:a19:4287:: with SMTP id p129mr2882483lfa.135.1540621453176;
        Fri, 26 Oct 2018 23:24:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/78] config.txt: move column.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:47 +0200
Message-Id: <20181027062351.30446-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 56 +--------------------------------
 Documentation/config/column.txt | 55 ++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/config/column.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 399c23e0c5..0618a7d974 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -311,61 +311,7 @@ include::config/clean.txt[]
 
 include::config/color.txt[]
 
-column.ui::
-	Specify whether supported commands should output in columns.
-	This variable consists of a list of tokens separated by spaces
-	or commas:
-+
-These options control when the feature should be enabled
-(defaults to 'never'):
-+
---
-`always`;;
-	always show in columns
-`never`;;
-	never show in columns
-`auto`;;
-	show in columns if the output is to the terminal
---
-+
-These options control layout (defaults to 'column').  Setting any
-of these implies 'always' if none of 'always', 'never', or 'auto' are
-specified.
-+
---
-`column`;;
-	fill columns before rows
-`row`;;
-	fill rows before columns
-`plain`;;
-	show in one column
---
-+
-Finally, these options can be combined with a layout option (defaults
-to 'nodense'):
-+
---
-`dense`;;
-	make unequal size columns to utilize more space
-`nodense`;;
-	make equal size columns
---
-
-column.branch::
-	Specify whether to output branch listing in `git branch` in columns.
-	See `column.ui` for details.
-
-column.clean::
-	Specify the layout when list items in `git clean -i`, which always
-	shows files and directories in columns. See `column.ui` for details.
-
-column.status::
-	Specify whether to output untracked files in `git status` in columns.
-	See `column.ui` for details.
-
-column.tag::
-	Specify whether to output tag listing in `git tag` in columns.
-	See `column.ui` for details.
+include::config/column.txt[]
 
 commit.cleanup::
 	This setting overrides the default of the `--cleanup` option in
diff --git a/Documentation/config/column.txt b/Documentation/config/column.txt
new file mode 100644
index 0000000000..76aa2f29dc
--- /dev/null
+++ b/Documentation/config/column.txt
@@ -0,0 +1,55 @@
+column.ui::
+	Specify whether supported commands should output in columns.
+	This variable consists of a list of tokens separated by spaces
+	or commas:
++
+These options control when the feature should be enabled
+(defaults to 'never'):
++
+--
+`always`;;
+	always show in columns
+`never`;;
+	never show in columns
+`auto`;;
+	show in columns if the output is to the terminal
+--
++
+These options control layout (defaults to 'column').  Setting any
+of these implies 'always' if none of 'always', 'never', or 'auto' are
+specified.
++
+--
+`column`;;
+	fill columns before rows
+`row`;;
+	fill rows before columns
+`plain`;;
+	show in one column
+--
++
+Finally, these options can be combined with a layout option (defaults
+to 'nodense'):
++
+--
+`dense`;;
+	make unequal size columns to utilize more space
+`nodense`;;
+	make equal size columns
+--
+
+column.branch::
+	Specify whether to output branch listing in `git branch` in columns.
+	See `column.ui` for details.
+
+column.clean::
+	Specify the layout when list items in `git clean -i`, which always
+	shows files and directories in columns. See `column.ui` for details.
+
+column.status::
+	Specify whether to output untracked files in `git status` in columns.
+	See `column.ui` for details.
+
+column.tag::
+	Specify whether to output tag listing in `git tag` in columns.
+	See `column.ui` for details.
-- 
2.19.1.647.g708186aaf9

