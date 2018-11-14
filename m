Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0391F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeKOCgB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:36:01 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41268 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOCgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:36:00 -0500
Received: by mail-pg1-f175.google.com with SMTP id 70so7594489pgh.8
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yy4nigKKZpgnU4xJHGacEUOU08cSb1SS5qaLPu1X+uA=;
        b=Z0f+YiK5c8oI3pCh3L5duneO7QALiO8GFpzTjoxmrAOsUfSwbVzIXpFVcczXEp1r9L
         nqwIRQiXXaZZds57SYZeiJjQbuQxIq7SOif9dEQBizwJgR1+yFR5T3SOIhZYEomtFj+L
         0B/WbUs/HHJ556rNFMoONzhkirl320SgvC2/ckBTaRk78Di0EZNic+w6S0oylmCALjNQ
         Y9pn6fLIvrsBiquJbOlVepXSPuyQytlNFb6k1JFWEaU2RjvTQfTo3PCH9fSW0zYVnAN2
         y97fwALF5cToB2ZqB0OlzZPr0nu/fSN4HWxODXGK8pw4rA3rVThBXN+Qkrb9HjfSrOjH
         0LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yy4nigKKZpgnU4xJHGacEUOU08cSb1SS5qaLPu1X+uA=;
        b=a0bFWLvIjQtXkdJl6kQAYf8/qgIgE23CNFclshG144azqqjatWsdNghIsxrX+GC1kY
         F7hie3t7SBitvF7hirwlBrrLTzaifDFRgyUMBSk+ym7lSAxBuOZAOsRvBNL9TLwjw4PP
         CAq2TYHPr/1Vg52w1GsTaUutO2oOhdbIx6zqhEjTWVpAbdsSxMUmYxIGo9+3FtNOrV3/
         gfFekIgoouql7B8jaIOd65cOz3iV/6QofYhBcNlD3o2ZQ82JEpQEW61ze9DZRBQLl+GT
         1PdNU5Z1yBXoXB5XsfukzILeKkgEGngMtaY9XtqtakDyre/ypc9XkC79O7XNipYlY4Az
         B03w==
X-Gm-Message-State: AGRZ1gKR96JfBBr1TfX1fnH95x8XYMumV8oSBd+yC5FEH9liL4f0Eiwk
        uZljBISf/J+IrZO/MAk8x+5VR993
X-Google-Smtp-Source: AJdET5fz97EtdgXq2MPaCycdSPByOf2hBabXHQl8DpZyPqn6zmcryiaST2iSiiLnS456w0k30NhF3w==
X-Received: by 2002:a63:d52:: with SMTP id 18-v6mr2404788pgn.107.1542213125336;
        Wed, 14 Nov 2018 08:32:05 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id b62-v6sm26744706pfa.159.2018.11.14.08.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:32:04 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:32:04 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:31:56 GMT
Message-Id: <3b68e0fe8aeb53e39df9862a5db3b414ed578824.1542213121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.v2.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
        <pull.73.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/5] tests: fix GIT_TEST_INSTALLED's PATH to include
 t/helper/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We really need to be able to find the test helpers... Really. This
change was forgotten when we moved the test helpers into t/helper/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index aba66cafa2..93883580a8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -957,7 +957,7 @@ elif test -n "$GIT_TEST_INSTALLED"
 then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
-	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
+	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
 	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
-- 
gitgitgadget

