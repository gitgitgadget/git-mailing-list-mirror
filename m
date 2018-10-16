Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786551F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJQEzE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:55:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35968 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 00:55:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so12054011pfg.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+0hudgD5U21xaWUm5jU/uM+up9mp8pBozRZkrLKlBd8=;
        b=Nr73Cbm8HH/ZIzsesULAKhGKBGFVymHiX+/ETx5s6INZaQCnz6A2SjoRiiJRCGJVr6
         v7LdKtPWZmyUD7NALYcJuuYncyL/xo3h8aDyjW76s2sjWXU2lj6GAjXNN5vujtC789/m
         skkoUKVFqbbz5HGj5j+Pqcl78vSLAmZwanGuw+fJx96o2UcBp0lCRq9tVeHYRJOs4O/P
         eKffZ0z0/xSZX3snCMwP2iUCPE9XvWGcQZtME5CCU1o6VrtTBF44SvyOB8JZyXHc9UDQ
         6vmi6AE1nQ+iuY5QdN4PJdH3VoHzfGkIAxFqoqzHGNc/9+xZOFG4V0cEAXMQsly3z/lz
         xUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+0hudgD5U21xaWUm5jU/uM+up9mp8pBozRZkrLKlBd8=;
        b=QcE+mDljtFReZOzIm8eB19uYTiXYsoTVyO3qjTblPIyvYAxd4QrqGt/Ez5B5tsfmJ6
         jYuinkD9C/ig6SUyrIwmM2uehRCn14Sa+Q30i0lTGMyCrNYDPhY+I4dY1VVvofJ8eodl
         KYahw/q1h7zZK2ijb8QEQUOcopp7Z1z7iOmuns0jjM5ri6haBlq28WmFGMV+Q1KFMd09
         ryZH+hNbGP4pMm1zBesqXc7Y1x8sjlyZTcMYkFEYAJ+Avt/zOOQk4bN0p+3Qx1/OlXw6
         8vALM1RRmVhNii/4xb7gsuSI0uU6JTz6r4f24wR+hl6361EW700zlhd/Dk9f1tI6odRv
         7ToQ==
X-Gm-Message-State: ABuFfoiWI8NZMXPfPcedgOzA1mPcYgdWmQgLqNLD/QnmP/lffqogXgQx
        sB4TNMaNzUBK1J0+7ZdceLo2IyMH
X-Google-Smtp-Source: ACcGV63bSPXN1TXFq+UwnqMJ2eCfOVq5cvTWJUAJhmvop/T6oIPTDj+9VVC9WnmZDDOwhQqHRqsljQ==
X-Received: by 2002:a63:c54a:: with SMTP id g10-v6mr21277789pgd.201.1539723770224;
        Tue, 16 Oct 2018 14:02:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h32-v6sm6877429pgb.94.2018.10.16.14.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:02:49 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:02:49 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 21:02:43 GMT
Message-Id: <4b752704bd1dd676823d735757e8ed5e48eeba07.1539723766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.47.git.gitgitgadget@gmail.com>
References: <pull.47.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] Fix typo 'detla' -> 'delta'
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pack-objects.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-objects.h b/pack-objects.h
index 2ca39cfcfe..86ee93feb4 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -377,7 +377,7 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 		return e->delta_size_;
 
 	/*
-	 * pack->detla_size[] can't be NULL because oe_set_delta_size()
+	 * pack->delta_size[] can't be NULL because oe_set_delta_size()
 	 * must have been called when a new delta is saved with
 	 * oe_set_delta().
 	 * If oe_delta() returns NULL (i.e. default state, which means
-- 
gitgitgadget

