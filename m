Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8451F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJTUtj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40839 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUtj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so33086507ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmZc/ioNqREdJ93qnMcNG6ezpJI8mT09GpEeyQ9cjxE=;
        b=C1TKQwtH2WudNyySwHgI3j0cxtuSU46pnKfbpjJMJV11tHyYl+VNj4vULCBKCZQqTv
         TmAtX0YUeQBtPoSlflYhjQoqFSbT3mmpa1DAr/bcpoa/6eHko+3UrxJu3WwjfVHFQqmV
         Z+I1Ul5Aym5KLpoe9iXILKGcYhWOn2GVjC6cV2ROAduoBlAzhSaXCCSZHsfWaLPjuw7+
         UPryqaFVsRAUpRc1gjyqbzR0KplnOORVgt7tcQl/qm1KMpw+a7+8w3u1d5577C4e6dhM
         X+cqD6eEwBoatA5GJNPYyH3cbDtL6ab4vWYXiO/g9+Oyo6EcvGlAXzSXqm8KCMGT58CL
         QTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmZc/ioNqREdJ93qnMcNG6ezpJI8mT09GpEeyQ9cjxE=;
        b=Cp1Wo/YGFwWZW5/7zHi4fMKpkfvqGCi0i95ZfCZeScQOgJdWgqVcGxRxr+TuuS0QlZ
         u3XwixiCS5d0yWYlPy8D0Qb/lsXgO64G2mravm1vWZFTGnWm5bts/g8lF7B5KsUUd2fS
         AJGol5BvrfLaDAgrzfFeqVepy0WPejebS+DH1Y19VyDvX2xBtC2MkHTWJhR99pxM3P0d
         D+y5V2KL4p2hXdL9StnbU77CK4Cx6vS6zTiZDPpLCFuCcSIWGlbQDcIpN+oBKlah6O7K
         deZWIA+BDYCl+3nMfRNBvY2VlYbU/NiNdIgsF6UeNT0bIMieCDanKRFGJhWLCkbOV2sO
         jKWw==
X-Gm-Message-State: AGRZ1gL8h57QljeAE+BOPDXlZcYnmg6EnbHThjsMaaA3RX7h/PcXeqWW
        GLCaYI886sTjGBK7xlEwWYzwpr1m
X-Google-Smtp-Source: AJdET5d9rghvO5ZJQOO/Of6Su4kTkGvE5SW5ysz5NqF9VtV153GcWts+kfA0my7ER3wZKRE6G5dN2A==
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr899914ljd.94.1540039156300;
        Sat, 20 Oct 2018 05:39:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/59] config.txt: move difftool.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:06 +0200
Message-Id: <20181020123848.2785-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt          | 15 +--------------
 Documentation/difftool-config.txt | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/difftool-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1509dd25e..f38e0a8334 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -321,20 +321,7 @@ include::completion-config.txt[]
 
 include::diff-config.txt[]
 
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-difftool.<tool>.cmd::
-	Specify the command to invoke the specified diff tool.
-	The specified command is evaluated in shell with the following
-	variables available:  'LOCAL' is set to the name of the temporary
-	file containing the contents of the diff pre-image and 'REMOTE'
-	is set to the name of the temporary file containing the contents
-	of the diff post-image.
-
-difftool.prompt::
-	Prompt before each invocation of the diff tool.
+include::difftool-config.txt[]
 
 fastimport.unpackLimit::
 	If the number of objects imported by linkgit:git-fast-import[1]
diff --git a/Documentation/difftool-config.txt b/Documentation/difftool-config.txt
new file mode 100644
index 0000000000..6762594480
--- /dev/null
+++ b/Documentation/difftool-config.txt
@@ -0,0 +1,14 @@
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+difftool.<tool>.cmd::
+	Specify the command to invoke the specified diff tool.
+	The specified command is evaluated in shell with the following
+	variables available:  'LOCAL' is set to the name of the temporary
+	file containing the contents of the diff pre-image and 'REMOTE'
+	is set to the name of the temporary file containing the contents
+	of the diff post-image.
+
+difftool.prompt::
+	Prompt before each invocation of the diff tool.
-- 
2.19.1.647.g708186aaf9

