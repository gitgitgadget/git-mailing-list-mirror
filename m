Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D85C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbiD3ER6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbiD3ERz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3743494
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g23so11043141edy.13
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjqV85PaAutsk++HgCN216zejZCJ957aydexbqCLzhE=;
        b=bW8mEo18Jcx6tDqIchYh4papEb+RI3KSlMWvxBaQeHzt/MmVovuJw4u9viqwmjOuKy
         b7HFdhrNTr3UIiyICxRAamyIo0WvomiH3Hv8Xymi0cSJwNN1CtWFH/AWPlDvS+EVcHza
         mcAvBJgX9cPaZmLavhpsreukipys7Q7fURModwRyyKBeSX9jsaCPf1jLWQRKcct7m+mE
         g5XRcBoHLM33Rpuq2FtYP7cEPx8/D+jsDmLoolDsqLfhARCXErHqITxr7DBEtq8yNc6x
         Va1MQNW+De/8y5YYU2iKd1ZnQrdaDqb2MV84k5HCHVdWZTGnQBnzWwtHfY8KYKXacGoB
         r9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjqV85PaAutsk++HgCN216zejZCJ957aydexbqCLzhE=;
        b=CFfQsrkm1z3bzawYkBn0vVuN91jDvBsRE9gBO9xXPUqVxL05ETKWf4HAP6ZaHHl7+W
         nwpYskkDjrtFzu5f0omUuuR+yZ6XWS2ETm4+MDVpLRwVaeA1V/5UB8NKJFtKnHJ2uFER
         GxAifUdOiEahpF5v/U8ldKgml/i/tom6+BTyX3zv6B8SBTho8G2JipkRtCGz4PYqHoZJ
         3GeEZgDJiHM+w6TuKhhsnYWmamJt7V7CaPuhpvQoD/Gm9xCCeF7AkzaYwnt+VasfWdpI
         0iaJXt3BibP/Ak0BLk0cub7IgyRbH4v8Lb5zJ6g4habKkH0Y5e4eKaHSSiZrHsEuOcEP
         aJjQ==
X-Gm-Message-State: AOAM53143jGw9BXSDZzZRvsrFXgjlOKObpX/XO+cn8+SOK5OFR+shimz
        MhZMSkih12xtNbLjqFJHjVx+jMypLTI=
X-Google-Smtp-Source: ABdhPJypku7MpS/BXjjVSR3lefRgrk+2D6mrA8VbeyLhNlLaVGIkeIDPOtIEDBE9DtnnlvqZjxQb2A==
X-Received: by 2002:a50:bae7:0:b0:425:c0fa:e0a7 with SMTP id x94-20020a50bae7000000b00425c0fae0a7mr2744306ede.104.1651292069237;
        Fri, 29 Apr 2022 21:14:29 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:28 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/23] builtin/clone.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:51 +0000
Message-Id: <20220430041406.164719-9-gitter.spiros@gmail.com>
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
 builtin/clone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5231656379..05b004bc0d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1106,10 +1106,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
 	 */
-	if (option_origin != NULL)
+	if (option_origin)
 		remote_name = xstrdup(option_origin);
 
-	if (remote_name == NULL)
+	if (!remote_name)
 		remote_name = xstrdup("origin");
 
 	if (!valid_remote_name(remote_name))
-- 
2.35.1

