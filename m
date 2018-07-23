Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2F31F597
	for <e@80x24.org>; Mon, 23 Jul 2018 17:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbeGWSua (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 14:50:30 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:44721 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387994AbeGWSua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 14:50:30 -0400
Received: by mail-qt0-f201.google.com with SMTP id o18-v6so1027022qtm.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=kX8N9Na/QzMFaAbfa28GmAbEmVvxXz+jgcDO6hrVp+E=;
        b=KGC/s391bbA3dvmlz7rLzAv5UcPLFnOaAfZFr7k2YmJVT9d67s7a10PeYagR1r8Cuc
         c0ijx/ZRYlPBFQqNXMhNBOi/kj73yfnw0r01Cc8rC3n1z+TPntqUeNzdzG8m8MN0liyd
         x+al4fVewuwwDe60LF9pxBHszd0M6A8Ev4BPGyyyBC65mZRYpuPXCmRRDbj2sEgbdTkv
         NLTNuhrsENDXlzdcyfeBkAAO8tJtAAHUm+QOtg2fyKleRBu0Zkz0b0OrAUYl9SsgBPP/
         gFmVTgjTssPYsCU/ecd6wVI2cbm0C1q7wLNj9yHimBkyXIuBA7rmgWfYgwtLJVpOva52
         fmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=kX8N9Na/QzMFaAbfa28GmAbEmVvxXz+jgcDO6hrVp+E=;
        b=rsvaScKEngZ+H6r7BGAuvuVDlO/JXMdD90qiDnWyX8wx2lSSiXKpsBz3luKSU1ALdc
         nStD0w2HV6sGAP70nFD4Z3BZ55ouN4NM7nepphHoX+MKwnYyvNtGYEVtTDzazCELemQJ
         Qamy9i+qkfV1HayTc1SdfRKDhl/nyM06F8jKcVt/GH71X2CoWmtTrvvLta+wyIaW8jfh
         gLgPWGf5dYvTnKV05XB1ajH9Si0yz98XPmcZgpqxYEMGefw5MBXu3t+JzXPFGDYLd4Pq
         fPhiGsxzQAMA91V3gQkKezBf1n2SFgdwDVkcOyVvqTFzxFRlj9Cb36E102olbHRiKcML
         2Nfw==
X-Gm-Message-State: AOUpUlHX0ugZfeBcKBOIJwG8Q1czTx/oczwQ2ziygg78ALis8d4IqmwU
        eMSxwUuwpdkJ0EOjbkfE05xgiW+vwdOTu5kkfZ0fSH2TL7K/QC+iQxwNo0hAdr4FtYcVbvMTRs1
        sD5ln+ecHv4tVCs35p5ktXrKy7tsuzDXp3eir1y+lxBfxYagAIl+Tbf3cuQ==
X-Google-Smtp-Source: AAOMgpfKhpb+28+cZch++bUfYthYSUl6BSw+aicCh6pyjqYak+IRaZ5jenJjMDTTvZ6/TIwAkpVaJhSkHdU=
MIME-Version: 1.0
X-Received: by 2002:a0c:f648:: with SMTP id s8-v6mr7249148qvm.40.1532368090636;
 Mon, 23 Jul 2018 10:48:10 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:48:07 -0700
Message-Id: <20180723174807.28903-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] pack-protocol: mention and point to docs for protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/pack-protocol.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 7fee6b780a..25acd9edb1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -50,7 +50,8 @@ Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
 
 Servers that receive any such Extra Parameters MUST ignore all
 unrecognized keys. Currently, the only Extra Parameter recognized is
-"version=1".
+"version" with a vlue of '1' or '2'.  See protocol-v2.txt for more
+information on protocol version 2.
 
 Git Transport
 -------------
-- 
2.18.0.233.g985f88cf7e-goog

