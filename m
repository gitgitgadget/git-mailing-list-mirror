Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17F81F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfBTLlk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45202 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfBTLlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id d9so19542039edh.12
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eLZr6XbEi6IFLapSpTdzGa65KK9aRG/EP7+DRL9Hje8=;
        b=va9F2Kr6c9mNce73zoAMq8NWyeXkjMSB3R+TVeDc9TfscCMgy2E8c2Tmd47AZ8t1nM
         56ICRq9186kdHrw91OnvlUDnSsENCwn3/fgwsfH9cl2ZnU5+RZHQ8+hNf2Pgnk6xg8DZ
         YWlE17fJpV8KiW7l9bExb+onQEoRkS0XNchIhT8d0GDBjI/tRTaNxxPSD99ImKT8zt21
         R/vF8yIJoRzi/SmpxtLwulDkw+KkZDwAhgUpDbTlryAeXrzYlQpk6tfeN8Uwd70HQ7J2
         Y7miH9rot6j2yoT4bh+bEN+AmRNdA7PFF8QECdUkQPMxF3JRAXMIl+KwG4sNJQRF/woW
         XZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eLZr6XbEi6IFLapSpTdzGa65KK9aRG/EP7+DRL9Hje8=;
        b=oU9I/cmBMiUxjddX9bLbSTlEdOXqioeyRTLEUmyJ8ZTpPkOWJ3lee8VChojlriE/rk
         FIPDAV7DVNYcwIj6cJ+LKahvndIGOG+b0+k2nOpqjoVmqv9Op0ysc104UNVdMwuPdTdq
         StpJlNyG9EKAqs5JmAcZB9wMlyOLpIqDyQzcaPrSIVP0YQzmFwBkf3DDYJ207kNPrztK
         cvBABXwH32SnlZfOSDCyU9shj9zJOvGgZVp1pzAzXVbZFKv+uwcSZUSStXdDk3T2lAiq
         Ccg45EkcpD+49bRCUcfA5MpKoDCqx8chSaCu0PtFv9oBcxv8EFXrsyTUELExvbJdE2A3
         F77A==
X-Gm-Message-State: AHQUAubtPnn0btEg9TTX4YJXcAqiC5SG+iWKYR+9EtT7HyWCpIxxz8xa
        G+F/xVNF4cuiq2yn0gmessSx2jmn
X-Google-Smtp-Source: AHgI3IZtSHCOAjQfBnKBytqfljKvVPEJFzmD0VF1Z9EwimEKMG+jcvuvWeA5rr+TtTA4Neq18Skl5w==
X-Received: by 2002:a50:d9c1:: with SMTP id x1mr27045058edj.276.1550662895662;
        Wed, 20 Feb 2019 03:41:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm4370363ejl.68.2019.02.20.03.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:35 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:35 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:26 GMT
Message-Id: <315ae8b2119c154b155b53085dcaa17612db2938.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 09/10] t3701-add-interactive: test add_i_show_help()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
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

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65dfbc033a..91aaef2932 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-EOF &&
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
+	<BOLD;BLUE>What now<RESET>>$SP
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

