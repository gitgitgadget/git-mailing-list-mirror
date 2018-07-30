Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0DD1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeG3RSY (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:24 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:44948 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3RSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:24 -0400
Received: by mail-pl0-f47.google.com with SMTP id m16-v6so5723223pls.11
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/gK+7vB63iu3xbqyNOcBljPoPjsz8CnoZH1JDiH8aVY=;
        b=nsn1DNVvRmYEzXRyn6U85SN37vXT94b2GBHqLGIcw5jPWQfLGVMfTxjif3BwDw2t77
         LjwUNrjYNN+O92yNF21ylOaBy/Zq+kLG8+vZD0yMG2kvqpg6RZN5jkRksKnBpPVmQd38
         D1UqnOa+3ggCVqXYmlecwPm2aK/VAlP4Sb84mQOeUsVjtaSD5uoHlWxZXcvzemufFgLB
         7VMndfH9Kv11sNmtYIgyrp4qAsEnfKIGuAgEC4u+FwndF4HYE+Q0TL48x9Vb/IfA0+ZU
         tN1OH7H4SMe5PDihfG4LL/GRhA5r1DNEYp1ngoVzLsQfgAg/cNrp4SII+Gb7Jn/i59zv
         Uk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/gK+7vB63iu3xbqyNOcBljPoPjsz8CnoZH1JDiH8aVY=;
        b=LaNP96A2pKi2g0UWhx1AsM/Sb/4WMyL2zlriK4V/v/lDDgedtwf0euQYNeV7h8BMLY
         aJi3QY7qcruLdzA0Q9WWdwPoBYFJoLaQ+q0h9rvjR+HcIiuh129N32tOAs24FONqhjX3
         YhOEGTgYwK0o3kI2Pkt/AHI+bjAgQi6HlHfBh1Jf1FJpor0jv9OApwwdi4EKSpy5RY1k
         pU970+BDQ5otNnAPit08wYf5W91zI3Mc2IRU2IWsh80N35MGwrVTUzSwcVY6WSRMc8wv
         a0ByphbcyB9iAXDYaMkPgPSWN9GMInDy9MBtQplzYycS6o1tJ1xT5g8/hKAaPE6pn4Pc
         wnnA==
X-Gm-Message-State: AOUpUlH0Ld9g3Hq4q7L97dzToi9r5FPkZhJsVTCXpHz4DTn4MF9XilCv
        dbHTKjjgsuVbJo0K4JZq6y113QQ3
X-Google-Smtp-Source: AAOMgpfj5yqxGrRcePEi+4Ege0d5wNuklibqQ39plg9ts3J8WZ82h96nYsiR+tcxzNqEsyX0KkPqGw==
X-Received: by 2002:a17:902:4906:: with SMTP id u6-v6mr10860401pld.44.1532965370628;
        Mon, 30 Jul 2018 08:42:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p26-v6sm21065791pfi.183.2018.07.30.08.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:49 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:49 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:36 GMT
Message-Id: <105b50c62667640d0ed45cba1cf730bc3f2237da.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/9] cache.h: extract enum declaration from inside a struct
 declaration
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

While it is technically possible, it is confusing. Not only the user,
but also VS Code's intellisense.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 89a107a7f..2380136f6 100644
--- a/cache.h
+++ b/cache.h
@@ -1425,18 +1425,20 @@ extern void *read_object_with_reference(const struct object_id *oid,
 extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
+enum date_mode_type {
+	DATE_NORMAL = 0,
+	DATE_RELATIVE,
+	DATE_SHORT,
+	DATE_ISO8601,
+	DATE_ISO8601_STRICT,
+	DATE_RFC2822,
+	DATE_STRFTIME,
+	DATE_RAW,
+	DATE_UNIX
+};
+
 struct date_mode {
-	enum date_mode_type {
-		DATE_NORMAL = 0,
-		DATE_RELATIVE,
-		DATE_SHORT,
-		DATE_ISO8601,
-		DATE_ISO8601_STRICT,
-		DATE_RFC2822,
-		DATE_STRFTIME,
-		DATE_RAW,
-		DATE_UNIX
-	} type;
+	enum date_mode_type type;
 	const char *strftime_fmt;
 	int local;
 };
-- 
gitgitgadget

