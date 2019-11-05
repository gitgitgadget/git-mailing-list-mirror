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
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CDE1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbfKERHt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32937 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388983AbfKERHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id s1so22365789wro.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IsKcVhKff21OVr95jQyKG45l5ImvG820E3RIIfx5AKE=;
        b=HIABqFDKrbqkyTP51L1P50usmAhG5kwK4jqw84m/dThcoBCk4Gd6bA/TI6+IFbHpzR
         1miyBbi/G++Bil4A/rspLW1uDMBeAOJWPd0qwgeiLmpmt/ZUtd1mAjuPiJRQdfVQHVDs
         e6zToRywn0v53S5NDX4UPBRwY+HidXb7NgQtQ/mqxLUFZKvye5AJrvKM8nkJqMiPRJX2
         odpLDIsY7l/mTKfC0pMoluIal2u9AFs6RgQm91jxo/oj66CoUisOcVE5UeyS8qQzuIqK
         NWjXLmygZH9of2fAopTfCwtR1a9funSiQEmpWTz3jiTFgf6qXSDSwoQEBIq7Oa6OoOdh
         bLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IsKcVhKff21OVr95jQyKG45l5ImvG820E3RIIfx5AKE=;
        b=flq5nv3z3OTHtdecE7wKhpSRxvmIfdfrEnXIr0Ch7lvzFMtZ7BzXwqqmXON1kICXPx
         3D4lB1eTB0+9EVwqeA+vfQCwzExhUf7IESonXBJmT7UyGQJIOcgymfNeyTSfhoSTd4Zt
         wSz+xiV5eITCZwnw3wIDGUs9VoWtHIU/+/ASGoCLe8Il2j8MMHOwbo23TfFGRYf7/vNG
         sGgNtE/2OApdrEq5rZB1RhmJTHTNGVZx7yDC+jYHaWbdL4SN8l3XBirbf6U5Q413r8Z5
         LRq4sc/gV0oUEpcSQFuBh4Nr651IunjT6CDHBUpqOI4cA4U2cxlJL0k+BP+3JtCaTG8V
         sEmg==
X-Gm-Message-State: APjAAAWcA6Xi+bpIbLVr0LtYjEMhBY2C5k1e3z0psqtqAlz3hlIrOctX
        hrcxYA7Uxmfe3dC/JPbxw4NjsKg2
X-Google-Smtp-Source: APXvYqwHQU265qs8nwn/jt+1xNmFU7g7mMdRYctWbA1CzCknYeQN3R036PJqoA1Hhu4ieaw0/M137w==
X-Received: by 2002:adf:de86:: with SMTP id w6mr29019595wrl.220.1572973661979;
        Tue, 05 Nov 2019 09:07:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm21323785wrc.73.2019.11.05.09.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:41 -0800 (PST)
Message-Id: <f5b8f1cd1c410e5a6c6e3ce61a16bac077ff716a.1572973653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:28 +0000
Subject: [PATCH v2 09/11] sha1dc: fix trivial comment spelling error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Also submitted upstream at:
  https://github.com/cr-marcstevens/sha1collisiondetection/pull/52

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sha1dc/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 9d3cf81d4d..63cd5c923a 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -72,7 +72,7 @@
 /* Not under GCC-alike or glibc */
 #elif defined(_BYTE_ORDER) && defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
 /*
- * *BSD and newlib (embeded linux, cygwin, etc).
+ * *BSD and newlib (embedded linux, cygwin, etc).
  * the defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN) part prevents
  * this condition from matching with Solaris/sparc.
  * (Solaris defines only one endian macro)
-- 
gitgitgadget

