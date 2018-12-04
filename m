Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0980C211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 05:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeLDFnr (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 00:43:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34314 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 00:43:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so13705918ljd.1
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 21:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIIeupaFfjSGAhcc7kI0fQUYHgpU04XbafnmX5VdyoA=;
        b=dhpSzpQh8EDYF/jN+dZnGu+uZPYtgA2kTgfpriUKZo+X506d71qw2eFDm3o7I+hgmA
         T4uw6Rk3yBKPkK30oSAUrbFBnAikazOMxVIIUtHsm6VQ/4UuY7aGRtCMnDPyjEvSdw7H
         nS2o+yWnlvidLIHvor57fy07cVQisoGHllfUE+oEFGr4UcAmHvcYPq+5azQ33aq9JuIs
         tIAY137Nn/NYtBFQII1pmSfQZF0uyIhVC0aqLN85Q0PBG/PbutVVXYYiVcomK+f0/sDA
         BEy1ENkf2seMOtq4XjYntYCUlZA4FUuo3lzAEmLEX9lw58BxO4hx0hzR32UeAZGW43ls
         fb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIIeupaFfjSGAhcc7kI0fQUYHgpU04XbafnmX5VdyoA=;
        b=lc2NOndD3BQgozC5Fiuq0sX2v4THFuHvX6IRhNIT4UviGaTzX7a+Bwu0ScY5dl+hnA
         cZqFI9q8nV2PjGHhgSS/JDou3o3eB6VdjTLl43z575UExwoAaNMfuCvMivlVfKeq9FL2
         EsEonB6XobgcyYMWEQliUHZo5EUaKrz0fixHkPJvLpI5sbVC/uVszHW+7LinnEyKceU1
         sZ2IeBo9TOSZt98G9rxFgtH9TdX9shpmlrYWuNHbiLSkXkn91eto/5qBspIkvY4n8uV+
         u24TtLG1WUWVz1xhyuLW/fMT+x6cPAbmKheyqqIcAwvGeCMS/VdT6g3hXlVGV38zpqIp
         RuIg==
X-Gm-Message-State: AA+aEWYmd8Td9d4sljmXNHc7eRDlgxzDg4VWnG4ShDgViUE9zbaLrsLa
        zKdQmpFDj6GlNDqrHWVGR5WiUpV5
X-Google-Smtp-Source: AFSGD/Xtw6l1aqqH6ekxy312GfXE0u6JrWeEVHP2z+h/kKw1HxKtz4Z542BZFnpvPYKBFr0l3th8FA==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr11610658lji.167.1543902223660;
        Mon, 03 Dec 2018 21:43:43 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m77sm2779217lfg.3.2018.12.03.21.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:43:42 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 3/3] RelNotes 2.20: drop spurious double quote
Date:   Tue,  4 Dec 2018 06:43:19 +0100
Message-Id: <a5e2df91b4a5bcc6bcdf5000c006d11546492f5b.1543901498.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gc81af441bb
In-Reply-To: <cover.1543901498.git.martin.agren@gmail.com>
References: <xmqq36reghdk.fsf@gitster-ct.c.googlers.com> <cover.1543901498.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have three double-quote characters, which is one too many or too few.
Dropping the last one seems to match the original intention best.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/RelNotes/2.20.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index 1a5bbd2e91..659474f7c3 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -578,7 +578,7 @@ Fixes since v2.19
 
  * "git rev-parse --exclude=* --branches --branches"  (i.e. first
    saying "add only things that do not match '*' out of all branches"
-   and then adding all branches, without any exclusion this time")
+   and then adding all branches, without any exclusion this time)
    worked as expected, but "--exclude=* --all --all" did not work the
    same way, which has been fixed.
    (merge 5221048092 ag/rev-parse-all-exclude-fix later to maint).
-- 
2.20.0.rc2.1.gc81af441bb

