Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639CC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382187AbiD3ESP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379881AbiD3ER4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C85506EE
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so18724273ejb.6
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9ltjhMmfk+bIp4Wo0KYJMRqgKKGp5RYbkY19gXo0RM=;
        b=Dpjws8rfsTIsCJ6AAYWGzi31VE4Ct2lvKthe7MOyQWMcBfmde6DJjQkup5YZD4WBnz
         1Q64Vo9ie9h3DWk0lxZIm0Eyq27taSRP8ytuPsuiZ7fc99uPVssQf+/uP6YBF0rF/RCt
         y9EyDBorZiJ3DxfVi11cuVBAG7RZApHbPmVsr2/WMZpZWzT4ShT4tRMdtdMNNzi24cuK
         wKSvpaCRcQK9fqxLjaVyxGCJogypUjh4b/MkvVTRlxi0WKebUVarSpappqmQU8nqsY3V
         b6R4nQqEt4W8WvsWRv0ejDeY0qFtZCaYKaZWF8chsyK5V20WzOJTv/EIJzwxym2vec0j
         URoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9ltjhMmfk+bIp4Wo0KYJMRqgKKGp5RYbkY19gXo0RM=;
        b=8CaagtRNb3BKzQDeoF7p8wxxw6dRhVhW1R8Cr8DRw602s2ZO0rNIKPXDxAvzdLFwfz
         lZ45Mpv0/CYYXrpabZFr5avIR00dXeyCq53271SMLt/tqHGGbNvFOnSlxI7mIhv5mpe0
         uvi0u7Xdt95Wjx8th6t0m4+fffT0NWKONUtwr9tEvxBe4o9pRpXtooz2qGf4uIQuSHLv
         an0lTam51ai+mkf1otccGg9nHWUqJsZiRqANlJ8OUYV+4/bkQhC8G2r7yuAAPWlyqjM4
         cBQ64RncGSYH6dRIihMk59mmk9vJ6PkvhG1WsuAjxO6UENEeJJIc8Se0kzyqfgFDo4QN
         sMWQ==
X-Gm-Message-State: AOAM532J1PzXHOf5+o+kD/F1ogu8u8RE+sHn1CK7BDMS5LpxLOGh/B2M
        cspXK1qL2Wo2iQ5Is9gzAij2uFYVk98=
X-Google-Smtp-Source: ABdhPJzwkyk8Ly9y53LmwNqP1Bg/bwKIcUM1UgM/OIZRXe/JMqQhiKYqhUCA6YjnmQH37iFrxVfGEQ==
X-Received: by 2002:a17:906:c149:b0:6df:f047:1698 with SMTP id dp9-20020a170906c14900b006dff0471698mr2361160ejc.16.1651292071312;
        Fri, 29 Apr 2022 21:14:31 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:30 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/23] builtin/diff.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:53 +0000
Message-Id: <20220430041406.164719-11-gitter.spiros@gmail.com>
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
 builtin/diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index bb7fafca61..3397f44d5a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -352,7 +352,7 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 			othercount++;
 			continue;
 		}
-		if (map == NULL)
+		if (!map)
 			map = bitmap_new();
 		bitmap_set(map, i);
 	}
-- 
2.35.1

