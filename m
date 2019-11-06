Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5A71F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfKFESN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:18:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34408 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbfKFESM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:18:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id v3so1366536wmh.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 20:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LtKStO62ho4S0eACk8n1sznmKWu/UCMDGSHSMKBx1y8=;
        b=LrHXOSP3Z26xJsk2+n1eQV8EEevmEUI1Pgli9hEdnMt1o2w2RXBFDoxEI0wPK6FpAy
         zxO6+zIPpafzt0fv3bTJTZ5SuuooaX9MmTeiir8xIfP3+YE2fDjk2g6bv2R8Egxsqekb
         edYKo8dX7S9UPWIbkRpzLHu6a+vbPiZJYmUQFKX1xlwHZDkmBqoZ2pYvy4oApZ6MA8GL
         Sudeu2nRwFW2tN9xYdU45Bq80qrAUa4QyauPrqFiJi/DIPTUWbBu8fHHd+o+lloNQl/w
         oPjIAITqSH+VupCMFXQMznIIEFSXUr/vVO8UaZmTY5W4APcFRVypSC5ScjKlj2nwrvhn
         StKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LtKStO62ho4S0eACk8n1sznmKWu/UCMDGSHSMKBx1y8=;
        b=Tk3DUod4XUH5ThEH+2my1s7nl7GrQwN5lkWnne9x4REmvexLQ+CIcIR6Wo5rAjt3ST
         tnqqqkwo55Yuf3tUj2A0r9NIKv14U0/PiemauPK3TaueCGqmK2dZ7IYpKqz2/zDCHZUV
         ftjexHLlJw5mb2asYJcG6x7awrXguTO6uJp6RuOdg5yzk9ZoUX0eAFCeBTGfkCwX9mpF
         3JDVwnyVJwcKIjuMv/cFX25fFBF/cFyIqJhntgljk+DiFf6H3AtLK4ffXA+Qvxj2fIDn
         5s1jt0C74CvcsMwFaedh8LA2qLJ3jVpgI+qR+Wzm+elTqnyEfnlgIUDGR0thUg029FXy
         QArA==
X-Gm-Message-State: APjAAAX5eiRMvnosljiSF1AmYBGkHxjUSSJ9hH/5gDmpc7SSmtPj0YWQ
        flgKn4f1E8Co4Vwjln0Mt0XFtxFJ
X-Google-Smtp-Source: APXvYqxAUqSWlvJLmmEdBh0g595fq4yfoTLoPoU++RmV4shMS8eamaAEKLsKrt2UABzo0S9UK4feUg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr522071wmg.45.1573013890803;
        Tue, 05 Nov 2019 20:18:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm21750600wrl.86.2019.11.05.20.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 20:18:10 -0800 (PST)
Message-Id: <5729dd380708da7b40805f75c5d475ff4c0b28c5.1573013889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.448.git.1573013889.gitgitgadget@gmail.com>
References: <pull.448.git.1573013889.gitgitgadget@gmail.com>
From:   "Nathan Stocks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 04:18:09 +0000
Subject: [PATCH 1/1] t: fix typo in test descriptions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nathan Stocks <cleancut@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Nathan Stocks <cleancut@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nathan Stocks <cleancut@github.com>

Fix two test descriptions which stated "git -ls-files" when the actual
command being tested was "git ls-files".

Signed-off-by: Nathan Stocks <cleancut@github.com>
---
 t/t3060-ls-files-with-tree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 44f378ce41..52ed665fcd 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -47,7 +47,7 @@ test_expect_success setup '
 	git add .
 '
 
-test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
+test_expect_success 'git ls-files --with-tree should succeed from subdir' '
 	# We have to run from a sub-directory to trigger prune_path
 	# Then we finally get to run our --with-tree test
 	(
@@ -57,7 +57,7 @@ test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
 '
 
 test_expect_success \
-    'git -ls-files --with-tree should add entries from named tree.' \
+    'git ls-files --with-tree should add entries from named tree.' \
     'test_cmp expected output'
 
 test_done
-- 
gitgitgadget
