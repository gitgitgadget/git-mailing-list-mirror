Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 966481F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbeKOB25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 20:28:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43421 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbeKOB25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 20:28:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so7934398plb.10
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rthGrkGz8nNG75/xBjpGzOvz+mwzwq6sulUzx2a6pQk=;
        b=KBb69PfwjK4mqAm5zyfmpTJPm1E3pL21gKKZWLu0Umn1gWEfYIE+/fYu1ZW5gB2HEZ
         fFFjPP1in0MAykPH7hFmjp46sfGBnDquoAaKhKAiSI8piZ2+/6sLXAfMO1X/yntlPr7G
         GNt4ZrCyKqZZ7F/HEqZGLmWm8lDYRyjHj6MW/6ZIecCpB2OLC9Z4ZvoHcrSS2ELAGLVT
         ET280N05TcvBiu+b1ghM8Usd9PSrvAPK5L6TFNOTC+xsXM69FDDWr0JgwZanjPzY1ZCa
         frbTVO8sfVG5viFKawIhJPOosJM1L8iqqUNxnvc21OZbMnHc7Tw/cH2pV50m/HxKxoxZ
         jVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rthGrkGz8nNG75/xBjpGzOvz+mwzwq6sulUzx2a6pQk=;
        b=izMHS5gwGd3+3p8QFtZJb9mTI3Ylrarr77wD+6f75kEIgaG6UUfKPQ88VP8epWst6f
         GyERSPR2Q/sMwdPqCsm4LZIpb8MlKhHnu0N6frRmk1dGfOw7fUm6WfeiUZ64ZKEZXLGE
         o9u9NtBB0omRSWZ7bMsXDuqf0rMMkdS9UJT2uiqA4wehNpMfkBd8H28Cyewcbf0lYIp2
         +7iXclw2NWJvJxKvQQ5ch3j6dwbGeDK92ICOcts3MiEt9jYLtfJOtZPHyZRoIpu9Dl36
         4pTEBv006bWMessvR56vyA240Nz2U/h6/JuwbxKArCKmabBF33Vlqju9ncYyNyDipeBb
         Xf+Q==
X-Gm-Message-State: AGRZ1gK3iT/6HSTOfLNtQqEg05L3PUXgSE45IvjQlAjO02RIcYr5gqFl
        ZafvWnrC9Edkwc2uN17jZCq1f4Zm
X-Google-Smtp-Source: AJdET5fJ1kMobPeMtB3d6v1Bbw8FtkiLnLa28E5UfASYiGa2bb55AnuSHlBzGXIkLSigTgRvi7D3Bw==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr2332360plt.33.1542209116262;
        Wed, 14 Nov 2018 07:25:16 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id t21sm14289744pgg.24.2018.11.14.07.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:25:15 -0800 (PST)
Date:   Wed, 14 Nov 2018 07:25:15 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 15:25:11 GMT
Message-Id: <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.79.v2.git.gitgitgadget@gmail.com>
References: <pull.79.git.gitgitgadget@gmail.com>
        <pull.79.v2.git.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Ga=C3=ABl=20Lhez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] bundle: cleanup lock files on error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ga=C3=ABl=20Lhez?= <gael.lhez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Ga=C3=ABl=20Lhez?= <gael.lhez@gmail.com>

When an user tries to create an empty bundle via `git bundle create
<bundle> <revlist>` where `<revlist>` resolves to an empty list (for
example, like `master..master`), the command fails and warns the user
about how it does not want to create empty bundle.

However, the `.lock` file was still open and on Windows that means
that it could not be deleted properly. This patch fixes that issue.

This closes https://github.com/git-for-windows/git/issues/790

Signed-off-by: Gaël Lhez <gael.lhez@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle.c                | 7 ++++---
 t/t5607-clone-bundle.sh | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bundle.c b/bundle.c
index 1ef584b93b..4e349feff9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -457,10 +457,11 @@ int create_bundle(struct bundle_header *header, const char *path,
 	object_array_remove_duplicates(&revs.pending);
 
 	ref_count = write_bundle_refs(bundle_fd, &revs);
-	if (!ref_count)
-		die(_("Refusing to create empty bundle."));
-	else if (ref_count < 0)
+	if (ref_count <= 0)  {
+		if (!ref_count)
+			error(_("Refusing to create empty bundle."));
 		goto err;
+	}
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs)) {
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 348d9b3bc7..f84b875950 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -71,4 +71,8 @@ test_expect_success 'prerequisites with an empty commit message' '
 	git bundle verify bundle
 '
 
+test_expect_success 'try to create a bundle with empty ref count' '
+	test_expect_code 1 git bundle create foobar.bundle master..master
+'
+
 test_done
-- 
gitgitgadget
