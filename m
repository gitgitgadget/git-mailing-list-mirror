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
	by dcvr.yhbt.net (Postfix) with ESMTP id C51811F731
	for <e@80x24.org>; Wed, 31 Jul 2019 20:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfGaUGp (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:06:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaUGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:06:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so62117445wma.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pjBqjcx8O/52Ym4ItTxxHvX76u0NHjuJOEAjIa65kio=;
        b=AoBbNIX1xf3DtTLkNP8qngxql2Xe1g+bkbprDQRhu/cY0vOEjNWNx+N9aiOEwo2SIq
         oa0Q/iWVQa41jRDlaSbgF4VVIOfiIkJNtNcfBKhdVuF88Y2+4+eFvUBQNJTIvGJrMOqC
         4ExD0gxeM4EIJ8fZSy6oynSUdX/TY6uycQCjXv9J+ProAUImwAQ377z0QPtDT6jlpuPr
         2HzuOWJln4LKVDzVJbS9r3FwIf0ZAQAb3In0QPjD+1UiFpxsT17EpSFKR5hCYGkO9Xf0
         /eqI3usN6H8F8Ej6Pi9X6pw4MD2vlfCoXlV5G6mmrfyrFXPOYCXcUKIUXTYdt1fHi8Y+
         wgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pjBqjcx8O/52Ym4ItTxxHvX76u0NHjuJOEAjIa65kio=;
        b=isFMPLXnNBKEdOP9HOkjNjtS5AF+fv+jTDSniT15wiGw3k3ilMuk6d0jJx78oH5tcT
         qU3BJ2SRGmErIuR/OSgjWkJ8EKnCgJJRRVCMYJjVmm+U69QQySa9P5ywKVDiPlYCWL8R
         6eaqE3RnqRngF7op0FplWbXAoPZoExKplsZcFnTEXXC0DefUTQdNHUIn2RM1068tSChx
         0QhNmRVKUFDMmBiPaKsRFSFsjgP1OSnX843bpEr0F+T9qoUrbPR4h7GPVt+kPRW9oXZo
         BZ8axfBdJl5PokWr7uaEqeMs2Vl6bzNHLxj/JcNRnoxYj21KoK7RQIYJfNcoBc9EnQJP
         6qgQ==
X-Gm-Message-State: APjAAAWhjZcYNs4pG+TExFwuePCTo2AS9rcBz9JJ6mnZEBou4hWDYr5u
        c3cBaV1U0rChBJIh+x05dbQRljhS
X-Google-Smtp-Source: APXvYqwSJiakmThb0TYW5iUsrxgGBZ7ICMLcEpEmnzvI0Bl9FE5nAI2Fm31fyNzxqokjFAkv3WDD0g==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr108289274wmh.129.1564603602421;
        Wed, 31 Jul 2019 13:06:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm60548025wrt.31.2019.07.31.13.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:06:42 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:06:42 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 20:06:40 GMT
Message-Id: <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.300.v2.git.gitgitgadget@gmail.com>
References: <pull.300.git.gitgitgadget@gmail.com>
        <pull.300.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] config: work around bug with includeif:onbranch and
 early config
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

Since 07b2c0eacac (config: learn the "onbranch:" includeIf condition,
2019-06-05), there is a potential catch-22 in the early config path: if
the `include.onbranch:` feature is used, Git assumes that the Git
directory has been initialized already. However, in the early config
code path that is not true.

One way to trigger this is to call the following commands in any
repository:

	git config includeif.onbranch:refs/heads/master.path broken
	git help -a

The symptom triggered by the `git help -a` invocation reads like this:

BUG: refs.c:1851: attempting to get main_ref_store outside of repository

Let's work around this, simply by ignoring the `includeif.onbranch:`
setting when parsing the config when the ref store has not been
initialized (yet).

Technically, there is a way to solve this properly: teach the refs
machinery to initialize the ref_store from a given gitdir/commondir pair
(which we _do_ have in the early config code path), and then use that in
`include_by_branch()`. This, however, is a pretty involved project, and
we're already in the feature freeze for Git v2.23.0.

Note: when calling above-mentioned two commands _outside_ of any Git
worktree (passing the `--global` flag to `git config`, as there is
obviously no repository config available), at the point when
`include_by_branch()` is called, `the_repository` is `NULL`, therefore
we have to be extra careful not to dereference it in that case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c                | 3 ++-
 t/t1309-early-config.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index ed7f58e0fc..3900e4947b 100644
--- a/config.c
+++ b/config.c
@@ -275,7 +275,8 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	int flags;
 	int ret;
 	struct strbuf pattern = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	const char *refname = !the_repository || !the_repository->gitdir ?
+		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	const char *shortname;
 
 	if (!refname || !(flags & REF_ISSYMREF)	||
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 413642aa56..0c37e7180d 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -89,4 +89,9 @@ test_expect_failure 'ignore .git/ with invalid config' '
 	test_with_config "["
 '
 
+test_expect_success 'early config and onbranch' '
+	echo "[broken" >broken &&
+	test_with_config "[includeif \"onbranch:refs/heads/master\"]path=../broken"
+'
+
 test_done
-- 
gitgitgadget
