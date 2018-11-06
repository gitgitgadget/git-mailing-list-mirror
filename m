Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606721F453
	for <e@80x24.org>; Tue,  6 Nov 2018 19:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeKGEkb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 23:40:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbeKGEkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 23:40:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id u10-v6so798986pfn.9
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pDOpeZ6cYgGOCNdBCyRWHJdAd3nSNurSkLU3xHuGtfA=;
        b=PZS5wBvEMEuFQsoOc8uPGqGU6TA2PUaAa/K38ekYZbDrRHi52lrsb5huByt+IjZUaI
         PNL7fG+t4wUlDx2Mssyr9c7buAbiiFQQPLcVeO6CWaWsMs3bA9STjxDrTKQe9IhOBaj2
         2Eq5r7UDQtGXQgUu5/Pav0GK8PSLT5lH1MzFPGMEKL9NkAMM9X7vJZfaIG2/36Dm9zar
         5D8iIumNrhiIxZQ68YNt2PCa2/Ltb2yBGAJeL/QTCmosCHod93KDTjPIB/q08L7TVJTn
         BoOyLBV9tXtIKwbYcPSFL/IPYrSOtgS/1krV8V1/HXQKHz0Y4Oo9IAZfoAbgUkRcySII
         IZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pDOpeZ6cYgGOCNdBCyRWHJdAd3nSNurSkLU3xHuGtfA=;
        b=F6qcDvxuRrVF2sAobVcdBgD9pwtU6LpoU2PsAiYZ78I2Ca5fKZhCirjhhWIjULp55g
         eYb1pmGfbt4F8pNjkG6BflPMjhH/RGcD82v0dRfcEAyEsLG/IHENhBuKapqSAgGxj+yv
         l4N0sQmEn2+xWLks08dQAnYD5hU+67e/qzYEMjNKec8R5Gei0deDr7bJpiy08/hvLFZm
         bjhEE1KbApBSoImMOrNm6dV9IvxEbRiKHV6OT5sMp2gCbyOhOH7+bZmgm4+2C5cL1aGF
         MEhi+F7iwgbjUzZuhLwfMs/Z/GZ5W0KWZHX4QTzUHV46FYK3dJGf8PMnadce4zpgQYsA
         4/3Q==
X-Gm-Message-State: AGRZ1gLtanQZGsgvRw4FTonI4kauThdhrVQN91hbEiWIRhIg3yCryeXH
        vN1ipRbo3n7UdLZLuWduNW0/dX28uSY=
X-Google-Smtp-Source: AJdET5eAXLsSi7MEe1r8cD7RFbp8S9Q6R5Nrxw9HMUSdUVJrWfamz4YuRwCp420E66pZjfgHCmtW+A==
X-Received: by 2002:a62:14d4:: with SMTP id 203-v6mr27216334pfu.221.1541531629259;
        Tue, 06 Nov 2018 11:13:49 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id f13-v6sm53405630pfa.109.2018.11.06.11.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 11:13:48 -0800 (PST)
Date:   Tue, 06 Nov 2018 11:13:48 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 19:13:44 GMT
Message-Id: <1ef2c51550c57bddc64426081eac2dde3349fb05.1541531625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.68.git.gitgitgadget@gmail.com>
References: <pull.68.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] send-pack: set core.warnAmbiguousRefs=false
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During a 'git push' command, we run 'git send-pack' inside of our
transport helper. This creates a 'git pack-objects' process and
passes a list of object ids. If this list is large, then the
pack-objects process can spend a lot of time checking the possible
refs these strings could represent.

Remove this extra check by setting core.warnAmbiguousRefs to false
as we call 'git pack-objects'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 send-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index e920ca57df..5055150fe1 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -64,6 +64,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	int i;
 	int rc;
 
+	argv_array_push(&po.args, "-c");
+	argv_array_push(&po.args, "core.warnAmbiguousRefs=false");
 	argv_array_push(&po.args, "pack-objects");
 	argv_array_push(&po.args, "--all-progress-implied");
 	argv_array_push(&po.args, "--revs");
-- 
gitgitgadget
