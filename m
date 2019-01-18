Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5301C1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 15:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfARPJa (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 10:09:30 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38144 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfARPJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 10:09:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so11374257ede.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FIyLCbey3PbXvVqkh1z5koLrEsdzO2fqsBTPCaHKMFk=;
        b=msXSrC5i0uCODRx4UkoS9NHIMO1z8srmShbqhP7SGQ/z3YY0PfIfRK04LGEe/D/RYV
         cQwm/urxQxCp2A8ZvRZHD/Mzw8ecNJ3tnHqAknw8D3JVIfUw03k51VcsBLmcpBaXBTve
         YQNdn6uDzgWF0liiPltgkn61qRF6PcMGQsmS9U2RX+8UL+ntis1QpakYymLOZA0nVNoM
         kfoYbZC0BL2UukvQCWPcGOyxVEJ61jxf+OWqS98pDVup1cuLbdZ807pxFUqry5/bZeMz
         rFkdB+zHvmuQBt1DnHw+htirgjnKkJp7Q+LLe1y3diZkdGVJwSgx4PiTNjhMpRflAcfO
         UnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FIyLCbey3PbXvVqkh1z5koLrEsdzO2fqsBTPCaHKMFk=;
        b=gZzOTylRx7LaBRrYNPIRCpY25ybPtbgAwTt3tXwIqeyIsaozDyhtrvTPj6XZBLskmu
         tgSDwxVZ6u8yGrY/cqcVFcbbSHyoK2/EPAg54Z4beITAOUVkmOv4p8a8peyVoVb2Akbs
         xgkEJWBNPvx9kljIUz77XvaO0jRS9pggcqe2FCjiZu367Jw5JZMXzyY2zyXRnImjShYa
         4Me7cMoavHBb/3Ec3X7Ig9ALS2KWtLpfmLSKKTK/kRpWAO30Me7CVqkJKKhA+KctcUWu
         rXy+CeBBFU+Vak+CizUPasM4/VvRyCvkaaMpt4wf1UY146UG0CD0NWn3Zzvb+iMlmmSh
         Uelw==
X-Gm-Message-State: AJcUukehayL6LEHEetmh3o5jqt6Mpvbi7uglcuo9c2U/n2xhSvqF5U38
        gItvHyfsHrtbckTPq8mhyqwfp660
X-Google-Smtp-Source: ALg8bN7ryLajKN6FWu8fpTV1TUC+Bqw8Avn8DuINrI2H7QcWcmdcbjuDiecv+7buXHwbhM4qlNY7vQ==
X-Received: by 2002:a50:cc04:: with SMTP id m4mr16534862edi.171.1547824166670;
        Fri, 18 Jan 2019 07:09:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p36sm7280927edc.78.2019.01.18.07.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:09:25 -0800 (PST)
Date:   Fri, 18 Jan 2019 07:09:25 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 15:09:20 GMT
Message-Id: <3a68f1c509a357447bddf8bae6f1685b47673f89.1547824162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.v2.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
        <pull.24.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/4] rebase: avoid double reflog entry when switching
 branches
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

When switching a branch *and* updating said branch to a different
revision, let's avoid a double entry in HEAD's reflog by first updating
the branch and then adjusting the symbolic ref HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index efa90ca894..5c827b2f03 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -438,10 +438,11 @@ static int reset_head(struct object_id *oid, const char *action,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = create_symref("HEAD", switch_to_branch, msg.buf);
+		ret = update_ref(reflog_orig_head, switch_to_branch, oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
-			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
-					 UPDATE_REFS_MSG_ON_ERR);
+			ret = create_symref("HEAD", switch_to_branch,
+					    reflog_head);
 	}
 
 leave_reset_head:
-- 
gitgitgadget

