Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D64DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 21:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLOVlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 16:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhLOVlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 16:41:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623BC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 13:41:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so16918159wms.3
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 13:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jzDYbHIK1ubgAWB9Ybyg/Zv2osVEj3oo0mQG58iAvFw=;
        b=gZQSF+sPCfXeDjw97r6kBpkuwGT4jvx+QHWNefNaxoV/Sh/eAjnHhjcOyUx+sCQKvb
         OugYrymU2YyKQOLDYkVvc7TPn9GjAKhigpin16y7NngNbHHpP/sETL4CsA+nO/FK5kAw
         jCpcRRtNcOLA/q5p76nzGeEoFz8TrE20KTV9FJftpMWHCMngG7sVV8V5IYp5hX/v+1Cb
         EgFI4j1jGrx/125o1EpmkwiFx6iya63Mn8QyuiRj2EM0pakn3PVXofm4Sc3KvAYAOKYz
         suVEMUq3LOdS0hS85dzouaCR+96XuC8WTH8fWoVITH8VU4yckV/2wckY8Gt5NyPYg4ze
         lGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jzDYbHIK1ubgAWB9Ybyg/Zv2osVEj3oo0mQG58iAvFw=;
        b=GaSShJCnZlZiohX5kJYG+62WdkxQL5G/UMSow1W35NEx0KFHXxAdVql2B/c5Mki2Nh
         gPYv07B737bTs+My47Giiwle0lmcURl8UMfhOtoc7TM3EQPYWcXvtGRs3cjFIiRLEANE
         SVLpcZND4p4yvdKov9vF0b3I3ZBEYy7fEn9Sl7ASlr49o37IClrC6KodaE+l6JRptXrO
         aQNYOAZV5MR1kUpRQfjSW7cL7j4Ldf9iE+cgRFyrg/3ukoxZ3t6F4TwMMzsNjViwIDCG
         fLuDzRd3m5RZkZx+9UtKBtOABb/kAABXBA6xOj16np71E2c8NVMPAxOp3KGUSfSnoxjB
         p6qA==
X-Gm-Message-State: AOAM532zKUs10IEB4r2yy680ZFMzweDJ5wre5mJMeeUoY4HgwaoqSMl1
        eEaFu6VJ1zCtDPNVShLLSW4vKnw0Ors=
X-Google-Smtp-Source: ABdhPJxdzCpdK3BuE7aft39eB3ZdxOAFwQcCu1CSGnxWrtbbF6DLQHgyibxFtuHeiiSdTmtGgndJLA==
X-Received: by 2002:a05:600c:4f92:: with SMTP id n18mr1981905wmq.123.1639604469474;
        Wed, 15 Dec 2021 13:41:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm2890183wmq.46.2021.12.15.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:41:09 -0800 (PST)
Message-Id: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
From:   "kashav madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 21:41:08 +0000
Subject: [PATCH] help: add space after autocorrect prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     kashav madan <kshvmdn@gmail.com>, Kashav Madan <kshvmdn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kashav Madan <kshvmdn@gmail.com>

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
---
    help: add space after autocorrect prompt

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1166%2Fkashav%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1166/kashav/master-v1
Pull-Request: https://github.com/git/git/pull/1166

 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 973e47cdc30..8435858ce86 100644
--- a/help.c
+++ b/help.c
@@ -643,7 +643,7 @@ const char *help_unknown_cmd(const char *cmd)
 		else if (autocorrect == AUTOCORRECT_PROMPT) {
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
-			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
+			strbuf_addf(&msg, _("Run '%s' instead? (y/N) "), assumed);
 			answer = git_prompt(msg.buf, PROMPT_ECHO);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||

base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
-- 
gitgitgadget
