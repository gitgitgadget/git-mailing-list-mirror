Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3561F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfBFRQR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:17 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33576 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbfBFRQG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:06 -0500
Received: by mail-ed1-f47.google.com with SMTP id t3so1702282edq.0
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ioDtFHTIzlviCcUYUfsHz+hDRR0xugC+voZbLk2CYm0=;
        b=Wug4e63AGwb+H6V+tDXuFllrwYoUKhfgbSRWyzjRpPPhcujDph12B9zQvJFA0HM9sp
         LrGQ1RIWnHTbLHQqYlWnXROR1V4lKFPZ2oq1UaO3AdLO12Y61EDifOtXV0AXteMIHKuN
         Ya44kr0+euT96wwPmdQFTW6avK7h0dOHl+23DSEUxuRgtgw1JTxE+5XGCsF6agYD+1gj
         fFopp/BbBHUYn9kkqzEzYfi2iX1Uwfkrd4V9A9dorDKimXA/nx3lV2ZkGKNyDxrw3iUF
         +Il9GTb3J7u0S07r/Cdy7cWtg+rYJrkSqMIKS915XjXC0jvwfqjO8BqbTRWQdRbVaxvC
         hWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ioDtFHTIzlviCcUYUfsHz+hDRR0xugC+voZbLk2CYm0=;
        b=BK3Uj25lCn9Vsx0jWFAIaMOIJFq32s5yRsZi/OqwaZmdhT3Q/QL0SGhQZKCW9ez/id
         s/HC2WWI/R4FTeaRdTwVtqFa6Tc8nE8TzcNGjmZJVbyRuzjHfS4GXzTsRg+sqB7L96kl
         wA9eReenNIC8RSiwBF90T3YilJ5fWDmJhJaVfp2k3WRs+nJvkR2G2NzaPBlhM4VcHVwg
         xBzy4YtoUixHSy378R++9bOxJLxQtw9gwY3srIRsWc6bhR8Dsp+5FbKSeMTp0eufvIzl
         9XsFUMMLD1AC0tU4HrJ05+xbHcFS7pqcBs2ZdXWBd5b7PxswbF34/nPi6LSBi2spWd9K
         oJmg==
X-Gm-Message-State: AHQUAub9xY6CAT1R+PU10w/qeV2eAqnPdsmBFYpUhF+q0GB//OAyw5W0
        xWsinT+Imgc/WqsPFgYBDAZEUkdh
X-Google-Smtp-Source: AHgI3IYr8uVmYa2jMTIDztDfurghQsV1EkOYZIs8tuLNPLcDKEHVHHNT1NXekOGMHoPgDPYp2+srUQ==
X-Received: by 2002:a05:6402:649:: with SMTP id u9mr7202111edx.10.1549473364812;
        Wed, 06 Feb 2019 09:16:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l51sm6077576edb.36.2019.02.06.09.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:04 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:04 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:48 GMT
Message-Id: <90cec071cfdbd723b27fdbb474532682b579ea9d.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 13/15] trace2:data: add subverb for rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/rebase.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 774264bae8..f5ac4fe2ea 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -850,6 +850,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
+	static const char *action_names[] = { N_("undefined"),
+					      N_("continue"),
+					      N_("skip"),
+					      N_("abort"),
+					      N_("quit"),
+					      N_("edit_todo"),
+					      N_("show_current_patch"),
+					      NULL };
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1039,6 +1047,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
+	if (trace2_is_enabled()) {
+		if (is_interactive(&options))
+			trace2_cmd_mode("interactive");
+		else if (exec.nr)
+			trace2_cmd_mode("interactive-exec");
+		else
+			trace2_cmd_mode(action_names[action]);
+	}
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
-- 
gitgitgadget

