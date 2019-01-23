Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FB81F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfAWOkV (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39873 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfAWOkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so1876512edt.6
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=bsztkRWHkRvvTjxoZ8Zzi6cRMnnXJdcmGDRzSiTE/PLbbrjWlqTxcKYzojFcd7ND9a
         8MTpxMfEuqIUlWXXYIqCek7odjTSABmpm6Ex7yOHIuVzhOe3EfyAkTsPDw7PtSSBE0/L
         jXUclDtFLKQ2mRmVOOibCG/OwbRWLII9yiNLsB9b3AUnb3xkl2Oa2SJJeDP4WeNxTnhu
         nz3w6otkawtfLwbq2fYXOFoVyt0tbI3+V6AwZEmAT02RkvHzlnfAVIf/lMlKg2tP3dQ0
         GvYMJ5HDFZhqohkOB0mYjZE/khKTg5Kds4M/huYwsehnNRkFpMFu64KYMLKTxii7Anbu
         HwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lCqeYJ5kfLqoi2oIKKtYTdsgfR0s8LiDnVTc/mVzstc=;
        b=ofoSbmRCgGDerzx6BIB4/oe5jQ4zbR/pCp0Ol6/jsYd0qBBiZECI2m7XcHTqF8sw6g
         u1FM8E9DjYb22SvDI3ceHGRZBaMPD7Vtq1DvmJZbY7kcTR++lLaho4cycta6MHJhLZSA
         8/1gnOk/IuWTcM1uFejbpWoGfT9i4ULBkzMQVtdLKjvj42znvTydWFwbDC4hYKrrlyHQ
         jL2MjjIrFbYFpDWbkJzI25szXAEygRPO90pZsb7axScb26Xr1IB8H3YVyl+m0VPY08xB
         ulKT493vfAGO7BRLYAYjHqi2v4t1OIhTk46BHwtMQ9cvUgkTfNi+9V32+okpShWnKVC3
         3W9Q==
X-Gm-Message-State: AJcUukdqV2LSwGKJb4DcnihzVMQwSFjVfvvCYTyBHWqW3999WiwBVbfh
        TXBfWB/4lyRBNJnMj12ndLdhkBq/
X-Google-Smtp-Source: ALg8bN5trHad4fVZH5iCmwyXn+koWPW8HlftxFgfPthTZM4p24R1ohVixoOmTiwi4jEG2WZei3jQuQ==
X-Received: by 2002:a50:b623:: with SMTP id b32mr2910520ede.55.1548254418371;
        Wed, 23 Jan 2019 06:40:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm9866974edq.51.2019.01.23.06.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:17 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:17 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:56 GMT
Message-Id: <6c9eb4e33e1e98210ed5efe7b52fe1a827b2c3ac.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 05/21] ci: use a junction on Windows instead of a symlink
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

Symbolic links are still not quite as easy to use on Windows as on Linux
(for example, on versions older than Windows 10, only administrators can
create symlinks, and on Windows 10 you still need to be in developer
mode for regular users to have permission), but NTFS junctions can give
us a way out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 80d72d120f..74d838ea01 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,7 +5,10 @@
 
 . ${0%/*}/lib.sh
 
-ln -s "$cache_dir/.prove" t/.prove
+case "$CI_OS_NAME" in
+windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
+*) ln -s "$cache_dir/.prove" t/.prove;;
+esac
 
 make
 make --quiet test
-- 
gitgitgadget

