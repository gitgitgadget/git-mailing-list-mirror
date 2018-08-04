Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D1F1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 22:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeHEAUh (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 20:20:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34395 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeHEAUg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 20:20:36 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so4057083plo.1
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6O/HW5QGflCusTdrDFRrbYSo+Rk8+yBhgC1wIwOsYZE=;
        b=f1CK6fVdfo/srl4nTdlEYGDspKgCHbSEPKPOzUGNyR7FBKhjfvt5mLiT2NdCbIZ23w
         LrokcTGCWCwlTf14ue2kpH+II5m/ZKu3X617xNOLxG+lBE607DMRbxybv9l9a/p//fOs
         v18qzU82UAio66zHpKvuWjdEccrl8OqifwpiHJya93vA80ZXZJCBr96oD5g5/0FMZmxo
         E+WiFFnVGaENz2BYCdbpaE0mzHcvoFK+z7pFjtkBvvozIVaAdBQrZbyjELHQZ5M/eyhd
         LhV6S7/IeQguE/aZvXJujqfpUTJP/v2aME+EX5GytUTh2iDcwM/7GqWflqj7+RUznJjI
         ALrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6O/HW5QGflCusTdrDFRrbYSo+Rk8+yBhgC1wIwOsYZE=;
        b=Uu0tx+f3pfk6ejamTdn5fbPqGSn2bD4gBPiyRwBu+QbHRjtQWuh/M1UHeoycPVmWWd
         GAMc+7gcDTozd/v439tyeeH8DNcKeRYC058KoVshapPUdUfmkn7wiCzV1Ex+Cvt2ECyW
         j100UVR11Fr6K6jrgmURQRSLu1m0Bv8drZneVVbbvaTzP2+Md1eB8jWGdcEW/ofj3d0k
         +GKAak/n3a6I5fCV5BpKz4sNCtHgTDjwyAyIEt5G84ge9ay0VD6lLI8f9R6d2NcirbvQ
         O9AYx9fuTjpKPuzjWHp0V60oO++0gwUl7/td7ThU5lnP2uv6yF1iSVO1C5h025O3qqcO
         vZpQ==
X-Gm-Message-State: AOUpUlEDsLaWWqy8a9Q0mFJrki1DDUbT4RKvBr7Wt9vfcVUke/BMvpza
        P72j655WY6ElycBDj9vaiL+pJIdd
X-Google-Smtp-Source: AAOMgpfEX6iUBX5eBKxD+sJbljzD1UH+vukCLWN/IeT+Y17ArBx2kOiX2tYCAA0K0aecL+ChjetSsA==
X-Received: by 2002:a17:902:5a82:: with SMTP id r2-v6mr8415996pli.315.1533421106110;
        Sat, 04 Aug 2018 15:18:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f20-v6sm8091113pgv.27.2018.08.04.15.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 15:18:25 -0700 (PDT)
Date:   Sat, 04 Aug 2018 15:18:25 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 22:18:18 GMT
Message-Id: <7f92d92154143127734a638e41e064adce46a2e2.1533421100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.15.git.gitgitgadget@gmail.com>
References: <pull.15.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] line-log: adjust start/end of ranges individually
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When traversing commits and adjusting the ranges, things can get really
tricky. For example, when the line range of interest encloses several
hunks of a commit, the line range can actually shrink.

Currently, range_set_shift_diff() does not anticipate that scenario and
blindly adjusts start and end by the same offset ("shift" the range).

This can lead to a couple of surprising issues, such as assertions in
range_set_append() (when the end of a given range is not adjusted
properly, it can point after the start of the next range) or even
segmentation faults (when t_end in the loop of dump_diff_hacky_one()
points outside the valid line range).

Let's fix this by adjusting the start and the end offsets individually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index 72a5fed66..d8d09b5ee 100644
--- a/line-log.c
+++ b/line-log.c
@@ -427,7 +427,7 @@ static void range_set_shift_diff(struct range_set *out,
 				 struct diff_ranges *diff)
 {
 	unsigned int i, j = 0;
-	long offset = 0;
+	long offset = 0, start_offset;
 	struct range *src = rs->ranges;
 	struct range *target = diff->target.ranges;
 	struct range *parent = diff->parent.ranges;
@@ -438,7 +438,13 @@ static void range_set_shift_diff(struct range_set *out,
 				- (target[j].end-target[j].start);
 			j++;
 		}
-		range_set_append(out, src[i].start+offset, src[i].end+offset);
+		start_offset = offset;
+		while (j < diff->target.nr && src[i].end > target[j].end) {
+			offset += (parent[j].end-parent[j].start)
+				- (target[j].end-target[j].start);
+			j++;
+		}
+		range_set_append(out, src[i].start+start_offset, src[i].end+offset);
 	}
 }
 
-- 
gitgitgadget

