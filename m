Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1C21F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeGCL0U (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:20 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34865 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCL0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:18 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so843572pgp.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=Jpv5jsWQnnpn/UKmCuWDSiF+0m4elAqqCuBuZIU6PuA=;
        b=tBFvnLxZ/zdyUmrwR8ztWnbFFir2BlFaTiqJULwV68bGDrwfJeXAFftU5g5D9m/rjB
         lqAkIBJQrI365JSydvSbg6ioI5ubbJej8nJ2ti4QItS6/jRVyqYznIGcnkAovvhruRnH
         JxSF5xqsR2Nga24/ISQ+CA+k4krCGVnmqYtbt1Pr+2Owhyt+nxmH2u+/xjX4RzeLNiNE
         /7qFIvCPjaiblW4RV6il6oh52oYUOzQLPOizBEHIzMIYS7krNOnMZL8D79TYXU7cKLdH
         X+SYGVkgD4htFiluLc+ntMMpMb2+dbXyTrxVJNBy5Rfz2PymsYhdm7CaSeh9GsJ3eujn
         VOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=Jpv5jsWQnnpn/UKmCuWDSiF+0m4elAqqCuBuZIU6PuA=;
        b=AKw3/7Ppn1hXzC7LP4rwlRiUAhn4qj4ywmwrCnRQol9zhdxYSrlaWr3JnZSnT5rVoH
         9TmAcmzzs5IQn3APwABkl7bmAQRBHPnTK8oq91JQMNG8A5Dyw5ZDxYvmq4igWwavhvn8
         3P2D9vabTA7Bvr+dz3aSrbtyBNOX8rrn0WwFNO/qYtIYjao297JjP5hM6mugNy+8C498
         IIdUqKGZ/h/RFm1k2rrj6pLbM+Zt8OTCkxnyY3KZK+EBMIELyLA5YM0Ku6fdfrDCWTOr
         UTa4Rla+7FmYrYZUOqVGTKtX/d7fgz9mzvsFh6cmCYW4SMNTC6mLJ+L82EYMY1WZVDKU
         duuA==
X-Gm-Message-State: APt69E0TELDz70INLkiRG8QVqtL9WfcCBayiq4AtLMpg9/tjNep5Wab6
        lp16kz+NfwydTC24nKkHZukKAQ==
X-Google-Smtp-Source: ADUXVKKDLslF4P0UtMc1jCMXpqr5QpIF9t8oYhpK7/3QOwEHtse4D85InguGyg8s50Q9JLFiFH2XeQ==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr25320342pgq.382.1530617178128;
        Tue, 03 Jul 2018 04:26:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d9-v6sm1975896pge.68.2018.07.03.04.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:17 -0700 (PDT)
Message-Id: <93ac1931dc6f1ed8b11f0ab38bdd108ae833e5ce.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 2 May 2018 16:49:09 +0200
Subject: [PATCH v3 06/20] range-diff: right-trim commit messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When comparing commit messages, we need to keep in mind that they are
indented by four spaces. That is, empty lines are no longer empty, but
have "trailing whitespace". When displaying them in color, that results
in those nagging red lines.

Let's just right-trim the lines in the commit message, it's not like
trailing white-space in the commit messages are important enough to care
about in `git range-diff`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/range-diff.c b/range-diff.c
index 530f2fc32..8d3b96455 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -85,6 +85,7 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addbuf(&buf, &line);
 				strbuf_addstr(&buf, "\n\n");
 			} else if (starts_with(line.buf, "    ")) {
+				strbuf_rtrim(&line);
 				strbuf_addbuf(&buf, &line);
 				strbuf_addch(&buf, '\n');
 			}
-- 
gitgitgadget

