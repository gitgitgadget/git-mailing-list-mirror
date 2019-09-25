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
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D371F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442791AbfIYIgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:36:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46384 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442788AbfIYIgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:36:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so5531858wrv.13
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sUOsx4qaav9oV6r/02W+yv61w+tWGC5sf+4eoSXDHvA=;
        b=eEHKmI42alB7e5wpUGqG26RC+DzMmwRyMHO9ukZnc558L5Qv99iQpA0zJErKYAv97x
         Rj+jZ7tGJqmRZabLDdt0pNyhvfBmFXhZvvmYiyNxn0o2WL2B0wuAbD8JHue/hd8A8biL
         SKNoX2G+6U1+vCN5JtGia4dvm/hkqnEJvJ51KZF34qz1wC1WTiZZD5p0YV1rJxDa1iIO
         K7vW2fS2esLivXXvQ2luHzF0tP6CXacgBsmiwYx+AOjFmiluv+1PCgPnP7Wah44mdIca
         dAc0Z9Al+wh3NZpRae5tEGCxGHgr3aOxxX7gZ2WpErJzu5PqMwe8aIQZWPMTZDFBzUWI
         gNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sUOsx4qaav9oV6r/02W+yv61w+tWGC5sf+4eoSXDHvA=;
        b=OKMMAlZ5M9iLZs70S7PZ8hCQl0Rdf3DGJDlvC7bREjMhwIaym9g3kWbD8ZIX8CXwFE
         OzDbdSQwoB0hn5y+CF9OK5iB12LKsqVCpzFalKodDHpK8EdTmXBB/bisi5lDruwF8lyQ
         CBYjWKcZ1OfxvDqOlM8XZt/5FH4gLxTvIiicG2pRPxQAFS3U7yOgYwbxDHMBEpx3U0tF
         MkBYW3LffsbPT0AlDyaT9ECI4pl6SyjyubPVxKEP2t4jKz3KSU4irYJcM1BCJL0IvpII
         lriWyrVvxHmx6IrXK6TNZkgK4SCMvYu5hsIcHBMmexQ9Mjv9KCKwHnb7p9QXv3PDt41f
         BxYg==
X-Gm-Message-State: APjAAAXBoj2Gx2hQ+iEE3x/WFGsR0jtBOWqALboUf1mY4iFS3Z0I/0x4
        boklK5UlOnzhi33p2ADO9EAdk3Ta
X-Google-Smtp-Source: APXvYqxG/j/9d2hagY8IQfD6U2RP+q4Fv6yNC4zwcEOS78QascidjLh3HeAi4rKXS0h3tepEfSJo+A==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr5108266wrp.389.1569400561959;
        Wed, 25 Sep 2019 01:36:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21sm1726389wmb.46.2019.09.25.01.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 01:36:01 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:36:01 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Sep 2019 08:35:58 GMT
Message-Id: <a95cdf1e944a1bae56aca7ef460d86a5ccf79fb9.1569400558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.352.git.gitgitgadget@gmail.com>
References: <pull.352.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] diffcore_rename(): use a stable sort
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

During Git's rename detection, the file names are sorted. At the moment,
this job is performed by `qsort()`. As that function is not guaranteed
to implement a stable sort algorithm, this can lead to inconsistent
and/or surprising behavior: a rename might be detected differently
depending on the platform where Git was run.

The `qsort()` in MS Visual C's runtime does _not_ implement a stable
sort algorithm, and it even leads to an inconsistency leading to a test
failure in t3030.35 "merge-recursive remembers the names of all base
trees": a different code path than on Linux is taken in the rename
detection of an ambiguous rename between either `e` to `a` or
`a~Temporary merge branch 2_0` to `a` during a recursive merge,
unexpectedly resulting in a clean merge.

Let's use the stable sort provided by `git_sort()` to avoid this
inconsistency.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diffcore-rename.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9624864858..248f2be430 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -585,7 +585,7 @@ void diffcore_rename(struct diff_options *options)
 	stop_progress(&progress);
 
 	/* cost matrix sorted by most to least similar pair */
-	QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
+	QSORT_STABLE(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
 
 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
 	if (detect_rename == DIFF_DETECT_COPY)
-- 
gitgitgadget
