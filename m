Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3690D1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeG3RSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32972 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3RSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so7478736pgv.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xazFtdNcukCsVMyFxaCLiFGjsNU0eD8OdgKrJVfT8mM=;
        b=RYWrJeZTUMrbrfnaBpUCp0k0efwJjqTnAD9JTs1pGYHHro521TZt35fa+GUxRX8q2h
         8z6ubjzhSjXG8/RHBYhunPWTlN8lb+ne3xzCoWia5xk3IZm3epShxGg+JelVt0EVfdXc
         yn7RECJSiE2SBUfdgDGsmPEWB8zugI/8QQYlNn/WebgL0RrzbArTMAyvzKEk62CJVDoY
         b4kqbngUS4dV+dm1cyLPwjoBMg42tRdqR2jLHg2Wsuo5IibX66LZSns7oNk/q/XW8hKp
         oQI3mFLScZq2n3yL4oQhUOKAuJZsruPItzcLVxX9ybPfkuyb4MYD8hbuUyo5DvqpkRjc
         U1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xazFtdNcukCsVMyFxaCLiFGjsNU0eD8OdgKrJVfT8mM=;
        b=ggc89bJc2XFUchUpUDPxUTyWJK64fkiXVpl8K8kHbC1anmWcQoyIr15IntHLh5DJeo
         RUs2NQPIL9Pslz/8zEJJHA+EJxP5cJMNfIt649iKXbEl1JjoicZavMa+wUJ/h0OAcSES
         rjwl1zcUd2yAkYqkDrDuSSkTD0xb37Evh5uusw1e1R5xIwFhSyUAb++i5Uf68GMINLXm
         zXxprykbKGRZ2pyMKpkH5LCeBiASj4p7tVFZjtpRM3mbdCvVK7CXnDoZbqdzZ8bMJeDi
         03i3dVJLOUKhlXi2cq0V0mi+/F7sYPaQHAxEIGsUIeRmPryxITtwQWYzm07p2NXIdOWb
         R1Dg==
X-Gm-Message-State: AOUpUlGaJ+mXejP7VKwjRH7g4EqFC+1WFZIlS35qtBILpY2mzJYFBSEd
        chSnhr6PFYieeGGNypEAWfRvSolS
X-Google-Smtp-Source: AAOMgpew2vwMRGqiaJAwU25LyZY/ykpufQPweur12uzx/sSG74DBHZzOBblZ5H/cFuktV4e26AtyPA==
X-Received: by 2002:aa7:82c3:: with SMTP id f3-v6mr18281668pfn.136.1532965369194;
        Mon, 30 Jul 2018 08:42:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id o4-v6sm35709085pgq.16.2018.07.30.08.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:48 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:48 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:35 GMT
Message-Id: <6c8b5a4f2234e1340859cafe29bb49b846ca140d.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/9] vscode: hard-code a couple defines
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

Sadly, we do not get all of the definitions via ALL_CFLAGS. Some defines
are passed to GCC *only* when compiling specific files, such as git.o.

Let's just hard-code them into the script for the time being.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 3cc93243f..494a51ac5 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -115,7 +115,19 @@ include Makefile
 vscode-init:
 	@mkdir -p .vscode && \
 	incs= && defs= && \
-	for e in $(ALL_CFLAGS); do \
+	for e in $(ALL_CFLAGS) \
+			'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+			'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
+			'-DBINDIR="$(bindir_relative_SQ)"' \
+			'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"' \
+			'-DDEFAULT_GIT_TEMPLATE_DIR="$(template_dir_SQ)"' \
+			'-DETC_GITCONFIG="$(ETC_GITCONFIG_SQ)"' \
+			'-DETC_GITATTRIBUTES="$(ETC_GITATTRIBUTES_SQ)"' \
+			'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
+			'-DCURL_DISABLE_TYPECHECK', \
+			'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
+			'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
+			'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'; do \
 		case "$$e" in \
 		-I.) \
 			incs="$$(printf '% 16s"$${workspaceRoot}",\n%s' \
-- 
gitgitgadget

