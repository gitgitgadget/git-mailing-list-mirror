Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C064B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQEzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:55:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 00:55:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so11441392pge.0
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eyWBzAhEsfNbITJS8ySsJ06Hy3HEuv8Cn05uRslF1dk=;
        b=d/oHDxcR7Cm9+i9tmKvo1RTbBZBkASEfSnYLcqihEx1UDljI1EYWeHfehs6LqpNlOv
         6cLIJSHqRQDkmY0Syoz3bqrPCl534E6MWiCtWJlazUSWFuelvNL35J8KS2VsA6Ew2Z+P
         5brykwL03HbK8dGvylJuVRPNvPVpR4V3ndxwt4GUDUs0rblEDZ60t5B4cKcKgcgb/FWZ
         MNPKSlqS38/NZzZqMT18sIGbHD+RJZfQVi6Ys+9eJXiQo1rNmqQcg8kiEH37Np+0BCbP
         9Opy9Jdws0ogh5sz2sjH2EOEUOz7GrZc7e3b4d0tWFMVyP8xh4LMGraMuC+Iy5buGjJi
         TVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eyWBzAhEsfNbITJS8ySsJ06Hy3HEuv8Cn05uRslF1dk=;
        b=AY1izuEBSIZ1+cHFE6EPbKZVq98WZCQz0ohsuHLUu6d26daeYL3vLQsvPChfWK7DKy
         IIpoVI6nFWx06ujuEyqp6gHx19o747GjzDX/KPe+0eYPDTMUy2afD3M0AAh2cNB/Ns3/
         hYCQKgc/cKW7U+qjv8zOJtoplTsHuDPNaWHXuqBLiPeRq4Eu8hj10h58xM9ot8puAjjg
         eEXTrfJLuVxXwWAtYNWMZR6zwdjXqEYHXQKDoat1WUkolYPfl/SwOp50zOBeFYB7ol9r
         zyZc24EFTSBxSF0I9kzsVzKkWn3cztrW+gLtWi1hD0owzVc77gosFlV8JW/JnPds2q6s
         AKRQ==
X-Gm-Message-State: ABuFfojshHw1oE6uzX9gBe40w1Yjh5+ZVpDk2tGKCdc+8se6wLOSU5J3
        RsqDNIgidCsvbFD2Zj1r+vbKGQzc
X-Google-Smtp-Source: ACcGV61fiXmHgHIHHdSkrX9YhSgl0W2dNF//5rAlIZGlXkCRMMuV/Jq+bx7CvX+VLFhH8LTeHnM84Q==
X-Received: by 2002:a62:de05:: with SMTP id h5-v6mr23819807pfg.258.1539723771690;
        Tue, 16 Oct 2018 14:02:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id q8-v6sm16996016pgv.65.2018.10.16.14.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:02:50 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:02:50 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 21:02:44 GMT
Message-Id: <eb6d10133ac9b1977db81ff9c243e77639226f85.1539723766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.47.git.gitgitgadget@gmail.com>
References: <pull.47.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] pack-objects (mingw): demonstrate a segmentation fault
 with large deltas
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

There is a problem in the way 9ac3f0e5b3e4 (pack-objects: fix
performance issues on packing large deltas, 2018-07-22) initializes that
mutex in the `packing_data` struct. The problem manifests in a
segmentation fault on Windows, when a mutex (AKA critical section) is
accessed without being initialized. (With pthreads, you apparently do
not really have to initialize them?)

This was reported in https://github.com/git-for-windows/git/issues/1839.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5321-pack-large-objects.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/t5321-pack-large-objects.sh

diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
new file mode 100755
index 0000000000..c36c66fbb4
--- /dev/null
+++ b/t/t5321-pack-large-objects.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Johannes Schindelin
+#
+
+test_description='git pack-object with "large" deltas
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-pack.sh
+
+# Two similar-ish objects that we have computed deltas between.
+A=01d7713666f4de822776c7622c10f1b07de280dc
+B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+
+test_expect_success 'setup' '
+	clear_packs &&
+	{
+		pack_header 2 &&
+		pack_obj $A $B &&
+		pack_obj $B
+	} >ab.pack &&
+	pack_trailer ab.pack &&
+	git index-pack --stdin <ab.pack
+'
+
+test_expect_failure 'repack large deltas' '
+	printf "%s\\n" $A $B |
+	GIT_TEST_OE_DELTA_SIZE=2 git pack-objects tmp-pack
+'
+
+test_done
-- 
gitgitgadget

