Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588A51F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfGPODP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:03:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32935 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPODP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:03:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so16841351wme.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A99TgSLfOomrYXjaYx4iuB+ybqBUCAck4r2gufbCpsc=;
        b=r8KCGbd0x7xjM3kN6keDYqHvUxOJ2SRx4xncpSbp/euj3veBBLAvcFNka/yzS4OrtS
         OA5SgjoRI+iqfs2ogDAacVIe8LPtnI/bWj1qfO4BF0lxJPsEWP87r/a2xCDCkbD5o+6M
         lMknXS1c5nJQnnuKIEknexD75/ueAI+8nBJf2Jk/EYuxta2ppHvqinVxlLjKkwRhMD7k
         hhe7PjefRV0pympUCKOEEqs7GZANapsevpoKHLCABEcxWzT97ajpQSIMfxal6Ciw54pJ
         hRNmVsOhNIUHDMnXMa24TT24cDDCvqU1qOSraQiE9azk6jltnLdkr3YUJ2xU+WNMs1+3
         mClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A99TgSLfOomrYXjaYx4iuB+ybqBUCAck4r2gufbCpsc=;
        b=Akcrl9H3YqCHIZ65CfYHB1Ke6EsFCsXTme3BCZNnjIL4vJX3lRDusrwxEmW27XoX2Y
         NerKh9l3wrgZ9UVATXb7eeaVIXzlaAVPqP4XRdCFQzN7c03W1OZQfd5hG4g30F8/YRgr
         Km5khFQBxESvZ89SwkiLmEzbDb1w5/EdExxA5v5Jj8VdL2hHEINZ9EKgc2ZvugZ7lrqe
         2dVOc5ZeXhecZp6+nBG+LG3I1VMr+ZkdDeIxR6wtOD7yGDdQMnCaGHX4gDfeeUzpzscz
         hshCmPSDiUoWgkNFCKT7bRL64DZViNvQNeRVuoMWxMOXsFIwqX3OT5L9MGdbCCPSJztq
         9LYw==
X-Gm-Message-State: APjAAAU5a92PmVnRdwOl8bEstiX+05PJU1ZnHBSFzAGSBOZ3yF7mLmIT
        YjoAkdgjgsTIzWKekidq31NUVeMP
X-Google-Smtp-Source: APXvYqwNrTArD5l/jZOEOaAS2I0ATLyhlHCFDaxVhFJUEBE901MafyHdHoUCTmFDklNNcUdLc8XemA==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr29613925wmf.35.1563285793252;
        Tue, 16 Jul 2019 07:03:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm35444765wrq.45.2019.07.16.07.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:03:12 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:03:12 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:03:11 GMT
Message-Id: <bc9e45488c27452155e57336354d3e935fbc3c5d.1563285791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.220.git.gitgitgadget@gmail.com>
References: <pull.220.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: support spawning programs containing spaces in
 their names
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

On some older Windows versions (e.g. Windows 7), the CreateProcessW()
function does not really support spaces in its first argument,
lpApplicationName. But it supports passing NULL as lpApplicationName,
which makes it figure out the application from the (possibly quoted)
first argument of lpCommandLine.

Let's use that trick (if we are certain that the first argument matches
the executable's path) to support launching programs whose path contains
spaces.

We will abuse the test-fake-ssh.exe helper to verify that this works and
does not regress.

This fixes https://github.com/git-for-windows/git/issues/692

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c         | 8 +++++---
 t/t0061-run-command.sh | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9b6d2400e1..6d7fc07a48 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1437,7 +1437,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	si.hStdOutput = winansi_get_osfhandle(fhout);
 	si.hStdError = winansi_get_osfhandle(fherr);
 
-	if (xutftowcs_path(wcmd, cmd) < 0)
+	if (*argv && !strcmp(cmd, *argv))
+		wcmd[0] = L'\0';
+	else if (xutftowcs_path(wcmd, cmd) < 0)
 		return -1;
 	if (dir && xutftowcs_path(wdir, dir) < 0)
 		return -1;
@@ -1466,8 +1468,8 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	wenvblk = make_environment_block(deltaenv);
 
 	memset(&pi, 0, sizeof(pi));
-	ret = CreateProcessW(wcmd, wargs, NULL, NULL, TRUE, flags,
-		wenvblk, dir ? wdir : NULL, &si, &pi);
+	ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL, TRUE,
+		flags, wenvblk, dir ? wdir : NULL, &si, &pi);
 
 	free(wenvblk);
 	free(wargs);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index ebc49561ac..015fac8b5d 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -210,4 +210,10 @@ test_expect_success MINGW 'verify curlies are quoted properly' '
 	test_cmp expect actual
 '
 
+test_expect_success MINGW 'can spawn with argv[0] containing spaces' '
+	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" ./ &&
+	test_must_fail "$PWD/test-fake-ssh$X" 2>err &&
+	grep TRASH_DIRECTORY err
+'
+
 test_done
-- 
gitgitgadget
