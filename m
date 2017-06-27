Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E6620401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbdF0UeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:34:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33795 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdF0UeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:34:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so3050066wmg.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7rpbtAFfQBSMxlqDZt9+adANfPtQLyBgRoY6tgIRDhU=;
        b=PJ95a/gZS8tza7DVU4u4gxe9M94WVWVf6u/7kUurDBOKXB+mXFaG/xAmYduwz4+XlQ
         e//myg770OBUZClcwCZGqk5FPkWqz5mFVoJX5St9y9qNdxsL/NWrKoViJb5YQ4K0V+wL
         mo1M+hfoQO739kJTNlhu8Z4NeZJfw6jDU/hi6xlDO29j6ZL1hRs1BQQytwgcm96eVrVm
         PRiCyu93/yoPy/HfD+uU2wjSIzAnoMnuEaYU90u8gCylXrpiFSbnenSMj9FBr+LWM3RD
         wtr20xJNQXUCR3E6//vtxBj99UY2mJokeZMea6cCmxbBiVvLoJv7VfkujqyU8c/afc+C
         KMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7rpbtAFfQBSMxlqDZt9+adANfPtQLyBgRoY6tgIRDhU=;
        b=JRfp4qUIUYo6y/oEb1khr1yz3VhwY+tNpbgSWIRCjk2SfGRXO+GZDsIE2Sp6Lr/FXP
         yItMfAarmp4hWqHiKWM5H5LjlvGtnRRvzWd038ZMsI1y0qFnsdON5UKORLLiPBI+7zhR
         DM8IielZ1J9LAGGxRpPMbyclPzr0YcLFjrA6mWKnqUKQr7HUDMXt/0vX9JVnr0xjcBcF
         96S0Bn3kD9ymdcklpy8ezvrVNzxnDU10y7k/Z7rp71R0r3GCiSOZJZ9YiTXmrCTkhbax
         /D4dZYtOAZndy8cmh/Zc6tcBgUNiBb3OS7nSKIMTiduLZwAqosmg3Lm/k0Bb0BXzWZlk
         ZY1g==
X-Gm-Message-State: AKS2vOz+4PcjL5LW5wZu1hVh8zvVmTx4fgbFfErhjJgfNKQQgasTnNxD
        hYo6S7zWSDKvn2yo
X-Received: by 10.28.24.213 with SMTP id 204mr4885416wmy.15.1498595661629;
        Tue, 27 Jun 2017 13:34:21 -0700 (PDT)
Received: from zwielicht.port1024.net (ip92341f15.dynamic.kabel-deutschland.de. [146.52.31.21])
        by smtp.gmail.com with ESMTPSA id l20sm194665wre.25.2017.06.27.13.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 13:34:21 -0700 (PDT)
From:   Silvio Fricke <silvio.fricke@gmail.com>
To:     git@vger.kernel.org
Cc:     Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH 1/1] ls-remote: remove "-h" from help text
Date:   Tue, 27 Jun 2017 22:34:11 +0200
Message-Id: <c49b244848de20ad058a46023aeb266f4b361e4a.1498591103.git.silvio.fricke@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <cover.1498591103.git.silvio.fricke@gmail.com>
References: <cover.1498591103.git.silvio.fricke@gmail.com>
In-Reply-To: <cover.1498591103.git.silvio.fricke@gmail.com>
References: <cover.1498591103.git.silvio.fricke@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This regression was fixed in 91a640ffb6d9 ("ls-remote: a lone "-h" is
asking for help") and the wrong help text was introduced in ba5f28bf79ea
("ls-remote: use parse-options api").
This patch removes the "-h" on the help text.

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 builtin/ls-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index b2d7d5ce6..cd54f7e98 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -56,7 +56,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-- 
2.13.2

