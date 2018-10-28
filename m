Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B141F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJ1Pfu (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37013 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJ1Pft (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4-v6so4795436lja.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6URvdzBWtkgiHAB1x19g94d7Z2NG2Xhe7Gk5siCXaes=;
        b=o/4ZHkw/nCwF1aW1+08m5Jse35LBAQF6sAy1dVXA7Y7TlSqSYRP8Pk4Ko5IEnkXGQX
         uN3rJo/dRIwg6RTsftLHNVxewE+fsEUA1+g/kuS6jA6OsYYah4f8ZeBUqnAi+KV511od
         63BkUAE7lvO+Pmn+oOPDwOnibL1tfqoMHqPQ2dkF9bgNMTdbK/6XOu2KAeh9eFR71Adu
         O6PGPfdEUjE91d1oKuAAMaF5tglSWZwAWqdNAVE0PrxBu4AmjrJH6f6TgksBxRmUgv/R
         shJBFXG9oDrbecaEl5eMnS6e3iNMJSTOD6hGJOWOu9cTXNMOe25+Xw5f3M9b8nVQiUaa
         rLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6URvdzBWtkgiHAB1x19g94d7Z2NG2Xhe7Gk5siCXaes=;
        b=D4aewOQhMo/XKCMT+K0TIJHi3JcoDdgYQvI/UGqPfkefRl+HRYOeinwISAqtV4KuBH
         HJZwYcdKQ67vX6EFTiFyowoHabcIx8/pTbIhr/6vRj5neWqGaCFEM04FRo1Id3j1Haqr
         ed7/gcsw32TLXD2gMCJHbcWspYMXgkOsXhn06IyzX+OvpA6/a8VuAiWecrUV2cS7bqW8
         OZZRqPE52LnPCfIjZhJZKTowotO0OpQ0lJdApJLTdSA25l163957tdSF8fa5kpxbwtul
         pqbR5KAxcTFmfTgiW/4HLX+HvvTxncJuhN88xqTykituXbpbAW2rz/DSG1VUOx3mv0E3
         nbHg==
X-Gm-Message-State: AGRZ1gL+sK7liM6n9QXmEuxmGnMBzAC03IfF1RXktG9Uz639ki0V4Zrq
        fP50abp+YW02AeNqvtJQcVEaRpHu
X-Google-Smtp-Source: AJdET5cVAIfA9kjoAqvn0BPE1If/ScplxzvrGDFVdn9dW0emx3T5SMskYusvm1SuTcufwoo8lTPilg==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr6847629ljc.14.1540709525462;
        Sat, 27 Oct 2018 23:52:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/12] archive.c: mark more strings for translation
Date:   Sun, 28 Oct 2018 07:51:48 +0100
Message-Id: <20181028065157.26727-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index 9d16b7fadf..757519a9d6 100644
--- a/archive.c
+++ b/archive.c
@@ -385,12 +385,12 @@ static void parse_treeish_arg(const char **argv,
 		int refnamelen = colon - name;
 
 		if (!dwim_ref(name, refnamelen, &oid, &ref))
-			die("no such ref: %.*s", refnamelen, name);
+			die(_("no such ref: %.*s"), refnamelen, name);
 		free(ref);
 	}
 
 	if (get_oid(name, &oid))
-		die("Not a valid object name");
+		die(_("'%s' is not a valid object name"), name);
 
 	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
@@ -403,7 +403,7 @@ static void parse_treeish_arg(const char **argv,
 
 	tree = parse_tree_indirect(&oid);
 	if (tree == NULL)
-		die("not a tree object");
+		die(_("%s is not a tree object"), oid_to_hex(&oid));
 
 	if (prefix) {
 		struct object_id tree_oid;
@@ -413,7 +413,7 @@ static void parse_treeish_arg(const char **argv,
 		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
 				     &mode);
 		if (err || !S_ISDIR(mode))
-			die("current working directory is untracked");
+			die(_("current working directory is untracked"));
 
 		tree = parse_tree_indirect(&tree_oid);
 	}
-- 
2.19.1.647.g708186aaf9

