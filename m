Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72291F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfAUJNt (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:13:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42223 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfAUJNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so15941628edw.9
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j+7JffoxNBIVZ3QpeyLd0isG5DGXw98QOCaM9TGCpzo=;
        b=gCbGc/U+I/5kaeGSbwWdZW4qY++54YBHSZTlYpNWEKEAtuEqrmKjZav0qdwrifk+6w
         /zpVEpV4yHVDSbC9nVpYGMsX2EpmQNCrCs98UM8eYnCtEOcuSr0U7IGYyZVA3lRyJk06
         SMVCjfTeXQz3zpNRRJ1MijBgzGOK03/RmvLsSGzFL546YWlYHgRadc+ZsrHKR00JLA7/
         XQDU6TUURF3E4sg99aAKl2m7G3JWRo0xHv2CMKX4x5cWhHXakoMPam0u3QIDEKuQfKX3
         pLnPo/4vNt0mz82V/tAJDVmQVbCLje2Y3Hsbv2nPvlKGR9vPlYrCtxT2hBmW4mpxJVOe
         z06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j+7JffoxNBIVZ3QpeyLd0isG5DGXw98QOCaM9TGCpzo=;
        b=Yfol8B81GEmNQk0Xya9gEA+ByRB0QMHlp/w4OCyTLL3k+3dd2uXPY+ynbQF6EuO4W3
         WvPuSiUzO0a0v4JVJ5Wi485MOflgHe2QSlc2Lwk/i2zAU0QcCArYGKzFpDkJeHoB/wTJ
         mUC1lbMPeMNoaXwwh+zRBQtoGNo8fJUdB2WQukon8jO3LVW8nNCwJnu3Ut3lhY6+hOJf
         zURzEQHs1/g0+T1R8Pxs2OanAFNJN5BVaKLWFsLJ7zjR6RZ319aCQJe1/9yK3qOwXQ/n
         WEnLZg8OU/oNmIeuxJNaNFA26X+JA+2m/U0aBz56sIjohFAcCqO/+b5mucpTRTapOOjC
         HEeg==
X-Gm-Message-State: AJcUukfoHk6qjfjjL5uMdDrtvh16fV0nQWQ8mCP+eVx0s5IDZShJfqzR
        CDXsZlrQTS9/1j20hxqfNujqG3J/
X-Google-Smtp-Source: ALg8bN5k0/5wB3bsqIV8Oxxe3k2HtQZdOSxJG+tSNl+FQQRCXvmbIbPZs0McWvIfCYbkeW3gguO5KA==
X-Received: by 2002:a50:ccdd:: with SMTP id b29mr25930358edj.102.1548062026205;
        Mon, 21 Jan 2019 01:13:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t24sm8913874edb.7.2019.01.21.01.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 01:13:45 -0800 (PST)
Date:   Mon, 21 Jan 2019 01:13:45 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 09:13:38 GMT
Message-Id: <aede733318bb6fccc1c3d16adf442135d3cb0692.1548062019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v3.git.gitgitgadget@gmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
        <pull.103.v3.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/7] t3701-add-interactive: test add_i_show_help()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Add test to t3701-add-interactive to verify that add_i_show_help()
outputs expected content.
Also, add it before changing git-add--interactive.perl's help_cmd
to demonstrate that there are no changes introduced by the
conversion to C.
Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
to force colored output on Windows.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65dfbc033a..14e3286995 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-\EOF &&
+
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
+	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
+	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
+	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
+	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
+	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> 
+	Bye.
+	EOF
+	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
+	test_decode_color <actual.colored >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
gitgitgadget

