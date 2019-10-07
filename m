Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B594F1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfJGUIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52845 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfJGUIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so773758wmh.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ece6VVjB0Ab+cwqH63x+BXogFIWNVunbb3YimZA0Fzs=;
        b=vF1fXaFj5/ZMQ1HREHbhACfZjdsB98weCDgjiqze9SdQEzK84H0O8id50tFebiaV5X
         sgb3RU0QtDN6dOV9FfxLoOd58+5epXtTz/eQFkyCJH+FApO9yf6XnGfsRn9WQvn4xC3s
         VqnjEEWv51RWbNktJSFFZDHq+DcF6uTM/aLC84vVLPLGKEVTuiO7s0086ExBnGVe9Hog
         sc6NfocTyL68USHyYT5K6X7SYw4F0m9Hztd5Z8K+f6TKzajl3cLCAXfjvMuY9j3NY/mS
         8714yAmlneP5T1a9yr10jyVCB9qTSOxtufqrR17lmZ3Ah1G/ICvXtrOb2JSDLN5KQNxT
         zpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ece6VVjB0Ab+cwqH63x+BXogFIWNVunbb3YimZA0Fzs=;
        b=YRyJREcUdfi093c6nGKJZexwAPVaOARnGiGi1zJZcCDQSXquRBEqBxdF8DqwC3EHoB
         PcDLGn7LTmQYR4bw64U86bXlyDhZLHaTq4hjsH0q/mW64YVWf2ibD0A6oRBeiP9SrSG8
         N7fA4dJff5x/6vksSN7yx0vMJPokhh3jt7f9zn+LqcUIlMR4mLNA+MV9DxVj23uuEKEK
         af6RdZ3C/ySri5v8fL5R6r/QHgafUfDoCw5oLJH29ww1PWhSfkkozLzJm2/2tk3Hb06T
         Le4pgn6s5Urr5EEUvImqzRRJ28AZd0aJWCJ5vdfBR9kUk5k/BEbqd7m7mX2k+i2jl/8L
         /G1A==
X-Gm-Message-State: APjAAAWwLzKAaJ/X94zYC60DLx1J5uAGhcnqX5Hf8Zo99RKvCFXLOppU
        Tk1SSetXtjHEpGLVz8uettpLrt3o
X-Google-Smtp-Source: APXvYqz7zDo/oeNhSObxqJnVZTUBi+aKOaX7ORnkZCPqWdRumCUESyKSubvB5qUY4LzsFx40PFQS4w==
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr782031wmg.30.1570478924201;
        Mon, 07 Oct 2019 13:08:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm1343878wmi.13.2019.10.07.13.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:43 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:43 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:25 GMT
Message-Id: <7f377c1407274aec87c6261f05bb9a944b659ba0.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 17/17] sparse-checkout: cone mode should not interact with
 .gitignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During the development of the sparse-checkout "cone mode" feature,
an incorrect placement of the initializer for "use_cone_patterns = 1"
caused warnings to show up when a .gitignore file was present with
non-cone-mode patterns. This was fixed in the original commit
introducing the cone mode, but now we should add a test to avoid
hitting this problem again in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index f22a4afbea..ed9355384a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -269,4 +269,11 @@ test_expect_success 'fail when lock is taken' '
 	test_i18ngrep "File exists" err
 '
 
+test_expect_success '.gitignore should not warn about cone mode' '
+	git -C repo config --worktree core.sparseCheckoutCone true &&
+	echo "**/bin/*" >repo/.gitignore &&
+	git -C repo reset --hard 2>err &&
+	test_i18ngrep ! "disabling cone patterns" err
+'
+
 test_done
-- 
gitgitgadget
