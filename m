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
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DD91F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfGaPSo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35096 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfGaPSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so70136443wrm.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MMXQch05rMO7GUhkmG0DNNcDUvt4OP38I3rq03J1BuM=;
        b=fc+KHUY8o+6EsBUpraN+sWu/ZR6BBibLVIibh4rf/Yrgo8sTSs0pgHq/p76vvibqgR
         B6YTGY/sgw/HfvvgYkERZqEfEKf03uJ+HpujrjgGP/+j/BbMfjK9SdXpGnznhaiVi0HE
         7S3iWf+gpf55TVwu1f0v9b1cFtw9OZoArjEvgn+vb8q12ksFbKL0GMDc/4Ysxbrd3GW8
         j/rcEFH1sZGloLeC/3D/PsV40/fHyj42QR+KoLpWUrLQC2diPAu2xOfFMHKfvaVX2bl7
         gDjeuTNPUl1J+mW2ZAK09O9RmIh+D2zIbIEvRJ2ODU3IoJaQfNIFRaipKAsy6eNUVB62
         sVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MMXQch05rMO7GUhkmG0DNNcDUvt4OP38I3rq03J1BuM=;
        b=BWQfU6e7x6uNZPvtd+MwLcJ4WKcyt9IhCKIf4ZqWxHK0gcgiBtjh9MSl9XpzADQACx
         0FbxYjrpqQp2uNPiSK4jRDT9pMuwiUSu0iDKh3+/U4prqe5ad61+90Mvfae1LnO5ikeC
         yQK4DpptRnYQ61Wvw8I6UcAYtUME++4ph4FSUyl00IgYhb7C8l7gHlaSGG0u84Tia9Zb
         13EaNVQDc+kzck4XYTiKCrtpxSy7b8WhwyoVzH4QLRwy4ONXvIW0aLp/Z4/g2isQUbIC
         QJr4HR5sr+JHKu+FPolVTOgAMbz5v/S1nbDHKKFpnWyafpilmqyqrxHbkZ3sVHAPTcM/
         jq0g==
X-Gm-Message-State: APjAAAXVMZ1HnxKzg7NnNI2fLNhge23/ZjTp2A7upLJp3c+600yCAJ8N
        ra8e1+4DlSXnumr2b4oh6B/5tsSb
X-Google-Smtp-Source: APXvYqy4ckZJ2RFeZZcoKFF7SPXawM06H/xROk0WmcPvCjAV+vCuFoLygSf6bZ4NHnOX631Q/YKSUA==
X-Received: by 2002:adf:e446:: with SMTP id t6mr136745236wrm.115.1564586322509;
        Wed, 31 Jul 2019 08:18:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm73408885wmh.35.2019.07.31.08.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:42 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:42 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:26 GMT
Message-Id: <b3daf078e8804dc7bb9099fa1a0b723c8357ac76.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/16] t3427: add a clarifying comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The flow of this test script is outright confusing, and to start the
endeavor to address that, let's describe what this test is all about,
and how it tries to do it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index d8640522a0..3a2ae7b55d 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -11,6 +11,34 @@ commit_message() {
 	git log --pretty=format:%s -1 "$1"
 }
 
+# There are a few bugs in the rebase with regards to the subtree strategy, and
+# this test script tries to document them.  First, the following commit history
+# is generated (the onelines are shown, time flows from left to right):
+#
+# master1 - master2 - master3
+#                             \
+# README ---------------------- Add subproject master - master4 - files_subtree/master5
+#
+# Where the merge moves the files master[123].t into the subdirectory
+# files_subtree/ and master4 as well as files_subtree/master5 add files to that
+# directory directly.
+#
+# Then, in subsequent test cases, `git filter-branch` is used to distill just
+# the commits that touch files_subtree/. To give it a final pre-rebase touch,
+# an empty commit is added on top. The pre-rebase commit history looks like
+# this:
+#
+# Add subproject master - master4 - files_subtree/master5 - Empty commit
+#
+# where the root commit adds three files: master1.t, master2.t and master3.t.
+#
+# This commit history is then rebased onto `master3` with the
+# `-Xsubtree=files_subtree` option in three different ways:
+#
+# 1. using `--preserve-merges`
+# 2. using `--preserve-merges` and --keep-empty
+# 3. without specifying a rebase backend
+
 test_expect_success 'setup' '
 	test_commit README &&
 	mkdir files &&
-- 
gitgitgadget

