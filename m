Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAA5C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382195AbiD3ES3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbiD3ER6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54C488A5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so18704869ejd.9
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ0fLCsxIheyHQMUr0wpmTX3ugCBZnvtYQXjDY3S/hs=;
        b=k7mHTXj4NPn1waMuVSASzZy/DS/8DQ8bDz7cNMokLAUgVrT1WY+YsnWVJvKUK2ss9Z
         bTxn/slsQiwP1ecf/2ZexOZBwyq8Nngg4XW0RJ4OKIjVbmF2nU6uhRUTFS6K647YbCn7
         Exo52QfiGhCNAOM6K4Jt0Ct1lbuSqCh5ELWi3WSG34f2wuR4YnzcxidveI2RiPnSo8A1
         nJ8S6m/48GbCBro/MTuqXTf1hoq5UA/fbJGBFqU67sIGsEqzLb1PtXmX5RBgJPvmdFsR
         DsQOpFsyM6+GeGvGbJu/3SwGpM23z/ikzx4Oqf1h08qhNHuS3OxF/cUz6KhAmz2QOPDX
         QOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ0fLCsxIheyHQMUr0wpmTX3ugCBZnvtYQXjDY3S/hs=;
        b=GKb+Xdjsw/R9F6HiZFamEJjzj2L9AuUa6XEkkUjEBRQYaqScqlXzTPtepeGYrK2z07
         pRkbPR/UByxTZfyWPOjapGYn5z+ODfWkw+CZz9DowK08obANincCQEA66CKySfal/0ZV
         vIwSUhfytjK0MfdgHZayZNDztyu6NzQCHX/pLBEGLhGLquUuFqA49OaWmH9cBbJyVSaO
         srGz8iF0u63yIjevqt+f3rMZuTIPQDDdWQHAPevf0E748TUx6p8N4UMP8JKCHhi43FGl
         312mWDkdLs84JBHZ4duryjrHaTjBm3jeeYRUPU92U1RA7uFsgzZKVYluIHpZqX8ao1oI
         0Itg==
X-Gm-Message-State: AOAM5306jx9rcclkoN4MQlKZr11ZGSRyhpZxXHb3fD9QKn1VCyCxie92
        zbMFMhG8W+DYqznXmx/Ieb/AwzwJGVE=
X-Google-Smtp-Source: ABdhPJwgjzjV4KzbfD47UYxWbWfdh+h07y19rzOwlLaHAcN/lHLOPG3Gx4k9p+hc50AWDhiLEjn4tw==
X-Received: by 2002:a17:907:8b13:b0:6f3:9216:b73e with SMTP id sz19-20020a1709078b1300b006f39216b73emr2466116ejc.188.1651292076930;
        Fri, 29 Apr 2022 21:14:36 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:36 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 15/23] builtin/mailsplit.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:58 +0000
Message-Id: <20220430041406.164719-16-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430041406.164719-1-gitter.spiros@gmail.com>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adhere to the git coding style which requires "Do not explicitly compute an
integral value with constant 0 or '\ 0', or a pointer value with constant NULL."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/mailsplit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 30952353a3..73509f651b 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -120,7 +120,7 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 	for (sub = subs; *sub; ++sub) {
 		free(name);
 		name = xstrfmt("%s/%s", path, *sub);
-		if ((dir = opendir(name)) == NULL) {
+		if (!(dir = opendir(name))) {
 			if (errno == ENOENT)
 				continue;
 			error_errno("cannot opendir %s", name);
-- 
2.35.1

