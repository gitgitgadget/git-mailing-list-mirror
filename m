Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182391F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeGCL02 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42382 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeGCL0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id v9-v6so874755pff.9
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=B1q4Dfl56WsjZXaKaXbNJpC3Nyu87aeXNU7yZ0988lE=;
        b=sTnLV48rdHdm3ghqynmvR1vNKissM5QXh94Tl+SfGf5Gl9ueMm6mx79w94bRaKFh0U
         oCHUtLLLk4alSGDUZlott1nHRR+Tns58zyoOxoUDnl1FMO7gGQGHRi7RIJNtkcwngT8w
         Cu0o2BmEz5cPzTyH67PZ48G7Dx/ZACG4DhZiRu7cUiDqpaKCDsxmUUkypuzeCF4/GPdn
         H+gdXcANYJu058dJWB+Z2QSzqCy8heDl32MR+tSHmWmiRiIF02ihqHtGMasACwVVcytF
         sOeLgaNNnvNGjUEWZ/olLwuXrNa2UYPoj5Xk5PDA7BHZVa7mO/5Kl1yqV3RAq5aO2GEI
         0MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=B1q4Dfl56WsjZXaKaXbNJpC3Nyu87aeXNU7yZ0988lE=;
        b=UhdQ3Z1+IyjzqEZxdb0YqPF3B0FAymX+NtKe9y0svySVpLYrivcxN/rvp/sci+LwUo
         3YnHMxfEEGvnlWzP3r7azs9uEW3fl4AQHizjdfKm1qVpsC4eZTRchqVn803DEuA3K3Ns
         lPiTcpeHjEL9ub/8v5cOosqUP2NztcM8hvdPW49orjeCElTlM7pJJ7lQObnwKOpM/CIs
         JnSJP5AB//ZZgVeZDBv/aZdF06GR/xBcUgk/VxqVSpFRxSOA0YGs1uGv54M2E27y1he/
         yUEL1JEYwCCnIRoz15dQMC3j9aVmjnvbbUn0LY1xNrQjHEinqNWiBfDYdD0use7AHqy2
         3XTQ==
X-Gm-Message-State: APt69E1Yb1kkYEMINmspL98fLjGAjPd7bz7YjeKdsAcmQYQW9E8Jnv++
        wZ0Q/MOsDojXw95rdLsUJTqS3g==
X-Google-Smtp-Source: ADUXVKJ22xGJCYBbXcWFzl3XmLfp4vpvytqspdUG6L4U8XjPoK1JCoi0huTxMBKjmhJH38wQSXxwIg==
X-Received: by 2002:a63:2dc2:: with SMTP id t185-v6mr25701848pgt.204.1530617183961;
        Tue, 03 Jul 2018 04:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id h12-v6sm2011741pfi.114.2018.07.03.04.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:23 -0700 (PDT)
Message-Id: <ef997bb8b372c614a832bb84d456237e2b0c2294.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 6 May 2018 17:35:03 +0200
Subject: [PATCH v3 10/20] range-diff: do not show "function names" in hunk
 headers
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

We are comparing complete, formatted commit messages with patches. There
are no function names here, so stop looking for them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index 0e0e77106..8df73da4e 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -9,6 +9,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "pretty.h"
+#include "userdiff.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -306,6 +307,10 @@ static void output_pair_header(struct strbuf *buf,
 	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
+static struct userdiff_driver no_func_name = {
+	.funcname = { "$^", 0 }
+};
+
 static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
@@ -315,6 +320,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
+	spec->driver = &no_func_name;
 
 	return spec;
 }
-- 
gitgitgadget

