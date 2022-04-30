Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CDC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiD3ESX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382173AbiD3ER5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7383443494
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so18665268ejo.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErjLOPyTsUZkND1eEj01rxCRiFS99M1onXETeRo/2UA=;
        b=c/bMsflciAigFaCPr1n46lE6NMK9UtLVRMczzNco1mKAS5nZXExggXBv+Z3v7zOxZc
         2RH2zKCev6QTDwgrkWgHNAx7J5/ZepHnVIMH4DXdyHh6vFR/KV4JXZLiID3wtQRZsaKG
         FD1Np9nyzjFy28KlUkskW+NvcGv6j8124gpQijGTaBG/M3Dfj/pXN2JF3F801e6O+POY
         YFATzarYHb/ifS8zC/1TWyn4U88jcosPsHxdnUNVWNDDQo7VPgB9geap0I+ZOkOEicVE
         xAPLDEAMQdTZyBJAw4MyKLLyFsOUoZwbNM8qZXUu3UmUot8RiLUsoxznzh6BUsQB5tI8
         d81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErjLOPyTsUZkND1eEj01rxCRiFS99M1onXETeRo/2UA=;
        b=RKstek2zCx/Gq/Icj++J1blMo0H+IKPwk2naSIt/9IsHcQOkZNTADFHe3vHyxYrNPq
         skCDYjidtWKUC1qZY0ha8AI/CNkkp46DCGxtTo/2mGhNy2MlR/Sc1wchY6vpXde8CBjl
         RFmmtl7y1KYsPpJp1sxZpjRwmu9RArP9eQB8fuYwcCQcWKlyBPfE/vKRTpyW3XzB5inn
         lHVN46l34QLaw8VH2sSlXhkEteBFaPgzkqFrAfohJmqh1csBSQchUDtC7/S1N/5pidtk
         VtCgN24LGY2YpGhC9y33MyA9hq4CnRAV/Hrfav0s5yDhsLNuPWVG0Xvj/q4UeexvVImX
         3hkA==
X-Gm-Message-State: AOAM531ESxnYA8drZLdKHU7l5XSv37aElQglByHztwB2exNk4yEF/LEE
        BfdOm/2y8eoLJZtEqDKB/C0MiVQF1wo=
X-Google-Smtp-Source: ABdhPJzev0buCOxfi+2pJSCLXg1+HgiknaF3tcIOWTA4EjcAS84+fROS24XYd9ghnIxVDFvDDaK4kw==
X-Received: by 2002:a17:907:6286:b0:6da:6e24:5e43 with SMTP id nd6-20020a170907628600b006da6e245e43mr2268441ejc.449.1651292075777;
        Fri, 29 Apr 2022 21:14:35 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:35 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 14/23] builtin/ls-remote.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:57 +0000
Message-Id: <20220430041406.164719-15-gitter.spiros@gmail.com>
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
 builtin/ls-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index d856085e94..df44e5cc0d 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -114,7 +114,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	transport = transport_get(remote, NULL);
-	if (uploadpack != NULL)
+	if (uploadpack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 	if (server_options.nr)
 		transport->server_options = &server_options;
-- 
2.35.1

