Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5448A1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGWOyO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33935 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbeGWOyN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so112361pfi.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xazFtdNcukCsVMyFxaCLiFGjsNU0eD8OdgKrJVfT8mM=;
        b=hXUxPz734RGKlZ2dNLLRe11yjGORXwbwfgyoahMM6XellwlnkDMtFcPrVFmz93A4Y5
         PE4iNZeF4q1pfOaOVxP6yeAYuwm5Mr99NtyLmRlF38JnlXrrFwDxqTnYEK/86WM+n88N
         eXXSgvXuqDa355nGMAy/U16DeqpPmchTvehaNwhbAWpOHKKCA3N2lpRnORK5+VhAxW7f
         ymgRQ54caDpbV4m73p0oQiBKVVtq54LqI46EqA2zEGl7ivufR/CoD2z3IgRjp7kb9dgx
         pzf49YdjCYq/FKqrdOHo2ufJ7dxJILch2FebDfwF4qSc9HxTKO/RrVkMptIkPjKL6ELl
         oaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xazFtdNcukCsVMyFxaCLiFGjsNU0eD8OdgKrJVfT8mM=;
        b=o8SxpCuzEcl6njIZF+P2CGRvNGcrnvCs3VigZOd3fzDG7/hSdmFOVlucpfkyhI7X4B
         XkbADlsvUvaj51muRZZycvt8+FRtXf3su3/hcd48x9LwPTL+S/VGxKIvs7vMKWj6F9mG
         kHMptlii98539JoNE3l2JSuSRUc/ZvWaE4tu+zGtEfclbvZQg4SE0pzvB0CQ144DYpBn
         7Y4x/wyTn5QevH4lLV1tu4Ia8MO90qBcFA4tmAekxLKyxaqZ1PzN7C5yo6iaG/U6un10
         f6vuhWxz4q3OFq7b+IsN49V0IMfzPubcJRXWJztckYAL/yd/QzHTuM/kftTnHoOJkRAg
         NzkA==
X-Gm-Message-State: AOUpUlElPCTJe4aryQsOeQHHnBN3bvqdbXy2iWs9T0q1XxvE3LNODk90
        lGG27iVucZYXM5ELwwK9v8Xgv9ow
X-Google-Smtp-Source: AAOMgpdVt5mh1Zwr50OB+F6DmiLIL3pfvZ5Mcz2WKBSTxXKQUvCTuP54b7NPloeDHQ9gEgNAWaPdYg==
X-Received: by 2002:a62:129a:: with SMTP id 26-v6mr13398684pfs.102.1532353971371;
        Mon, 23 Jul 2018 06:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id d11-v6sm12685714pfo.135.2018.07.23.06.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:50 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:50 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:38 GMT
Message-Id: <3770bd855c6f3e69acfe418ea7fe5b40454e4dfb.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/9] vscode: hard-code a couple defines
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

