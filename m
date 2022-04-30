Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212AC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbiD3ERt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiD3ERp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF642E6AC
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so18752979ejn.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqSgevMKrnKOuaMi35EpQEVjNRHj2C99lKB2HFrd3mU=;
        b=mOKYKYxEY0vS72HLSFSdjjA9yCrWJ7aexnTTtt4+wja8vKYnKRbPA6+u+WJrdhkGIT
         UQYtBHhY78QIBVi5TqdVkEixTEd6gwafSqZBIiH72pRIa21lX8FpMduLVJSkHN5rG9S3
         X4BnWIP82TWP6fsiSXtOAq+vNd+BjarVmrAURXk+96ek2YLuxXYJDWBYPB6TW739/prh
         Kn1+N2Hg6/fWek4uuey/JDnim9N03OmkdA90wadvj40id6+VTwIMqhoJSb5LufSg4ea6
         BpGsRs/qndUmh2779DO7fI2m3JpYH5+u1gI8J2I5ubsiIzrYkh0vmy2xArPJguJlX9Zy
         PVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqSgevMKrnKOuaMi35EpQEVjNRHj2C99lKB2HFrd3mU=;
        b=qgAivuI4DCMTTXRYQRgb3LyGd0kmfttwBo33kvjwxNL7q3mBYUxI4WnBt9sGIFmcNu
         LUvW5dilZgFfqDwx5SfJh0BQBloTA4yi7vBgN4YErvPGtyfNcy3pRH8X4OM9QAldT0ya
         7Ma2j2dIr//RWRvTmS5s22bJxckU6zN4g2bcR4L6uBW+915TLXXnylY9ufVI4GONMTwD
         OaqLM5qCYsRp7OZPULfk5rbpin7RJt4qLyZc2Knk9XgMxy9d1qvaCFYM09ZGWKbPW9Y7
         O/oFUk8oAhuYAJC9T27pVijOtdLOVMauNe9/L55Dq0iPm3anTpr1yDBz1CERjVOeQDdA
         19Iw==
X-Gm-Message-State: AOAM5307FjID+jwZLsyPjbVzZXLNQbByCfLo+Xv0VEPsRvGXSHFPLDtX
        JfSiGQswjp+/nWoa85JmffhZAY2oMDk=
X-Google-Smtp-Source: ABdhPJwKa2PpbIq+9UjSA//wRB6wHvEEcut8e7/X0HXMIRFWAyCp/oqMS1k26Y6/FzWuASt+K+TA9Q==
X-Received: by 2002:a17:906:fca:b0:6f3:e2d8:7c57 with SMTP id c10-20020a1709060fca00b006f3e2d87c57mr2316155ejk.320.1651292063068;
        Fri, 29 Apr 2022 21:14:23 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:22 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/23] archive.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:46 +0000
Message-Id: <20220430041406.164719-4-gitter.spiros@gmail.com>
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
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index e29d0e00f6..654ea2a6ed 100644
--- a/archive.c
+++ b/archive.c
@@ -465,7 +465,7 @@ static void parse_treeish_arg(const char **argv,
 	}
 
 	tree = parse_tree_indirect(&oid);
-	if (tree == NULL)
+	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));
 
 	if (prefix) {
-- 
2.35.1

