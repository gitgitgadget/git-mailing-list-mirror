Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36890C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377995AbiFPRTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378221AbiFPRTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 13:19:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86241483BA
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 10:19:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so2758392wrb.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=h6dmI96dKgxRKn4/jtUlQaH6ejgykzz6fCzP1o7ka2g=;
        b=UqACbAq1R8Z+lMQyTU7FaDVnC7Z29e37SRCXjI5ZaRWphwdRkoDpvrOQycRmn8CLdQ
         j0uTPxnD8N5kMl1LfZGNIs8aZ33QkO1WG0milHltiDh8eTDEh/yK01N8yKLsQ2J9dTgI
         Cv67Qwai/rFAmIe+eL8n3bJ3LI3fkOs/G7rcREbfZGDFbsZsXuUufJRD8B2RGLReTXYC
         /CM27Xz/CZhTHWMq3ThXvFU1pNx6rdBzVuiMt5Ul8FE289VIU8sCKMtQbTwFa7pCHzr3
         TY7L7geAK5PtBMzMJz71jv5Ketz6C37VYuhUZAvRbqdMJJz7iK7H0cw8sr/YiD6mIiwr
         TipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h6dmI96dKgxRKn4/jtUlQaH6ejgykzz6fCzP1o7ka2g=;
        b=J21WVl9yS9UzeQVYHU0d2Q+2hRPaChZBz94MgyUY3X7Jw9Ah4vnNOQK7lSVwfDT3c7
         awRF0jDs7sum0DgnXEe7SjoJa5Ar4+jWaATs7iKZRCy7mOcmqzNEvTow4UqwYMjz/8dn
         J6XWi93n8fy/+GpzsAHDJOUIp+DMloII1Cu7N88GqHg8meWKr1f16MT7AGnga1RyLA1f
         Y22AmelIwgghLOrUqokYibE8d29XnaS6fschzj4o8EWuEAh2j8l5CXuwMyocYpnFtgIS
         nNC0fOxOqGpCwC6ow+4LJRnQkF5/r7hL7Pi0RcPiiblpd3jUeFKGtxhQVPhGbPXruzzk
         NHaQ==
X-Gm-Message-State: AJIora8GOx7kLcBnBR5JJu8dcpzEpQLKW6KJOH8RVeC7T5CsZwR1RSR8
        dNsf4r+lxewECWMfh1rjnfnGVN964W2LWQ==
X-Google-Smtp-Source: AGRyM1vimHnien+3WEJ5A/XU6/1BlqwA1RXlmxKqm2ouGRAd8AtllQkj6sYmdaEs6rjRoOcMgEz8Yg==
X-Received: by 2002:a5d:59a7:0:b0:218:5584:e3b1 with SMTP id p7-20020a5d59a7000000b002185584e3b1mr5650411wrr.421.1655399940548;
        Thu, 16 Jun 2022 10:19:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b0039c7f790f6asm6364182wms.30.2022.06.16.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:18:59 -0700 (PDT)
Message-Id: <pull.1277.git.git.1655399939066.gitgitgadget@gmail.com>
From:   "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 17:18:58 +0000
Subject: [PATCH] builtin/rebase: remove a redundant space in l10n string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>, Fangyi Zhou <me@fangyi.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fangyi Zhou <me@fangyi.io>

Found in l10n.

Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
    builtin/rebase: remove a redundant space in l10n string
    
    Found in l10n.
    
    Signed-off-by: Fangyi Zhou me@fangyi.io

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1277%2Ffangyi-zhou%2Ffix-rebase-extra-space-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1277/fangyi-zhou/fix-rebase-extra-space-v1
Pull-Request: https://github.com/git/git/pull/1277

 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 640b6046a5a..70aa7c842f3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1206,7 +1206,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges\n"
-			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
+			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
 			"which is no longer supported; use 'merges' instead"));
 
 	if (action != ACTION_NONE && total_argc != 2) {

base-commit: 4f6db706e6ad145a9bf6b26a1ca0970bed27bb72
-- 
gitgitgadget
