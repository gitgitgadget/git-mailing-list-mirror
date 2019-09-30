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
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC1E1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfI3Jzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36470 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbfI3Jze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so10522318wrd.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnMTIPjZvbP+6ylmBnfB+NxC7dfryopwFIX8J+o4KjU=;
        b=Jd2GiQxPsAlsswioa1X/tWkvEwgKyHfNq1iJFCkEAuPN/CL1ed8sqtfTI3sMZiXDOY
         B2y8d9Q7N+zB+6H8k0nNV9LlMNeWOr+h6m2qxoD+UcS3PXizGmu/DSgDZexcT/fRcBic
         WFRGRjXn824qCRRqDU62xU3MRl6CpljpoR9inJ1NfvySMFFhGOC+5ePmM45QQkhBkFhq
         hEMXNp3zk07ATglAqGmQ2HVHyhe8wZWjCCBstywudB8S2RLnBEMzEQA/4uPoYL4L739Q
         cRuw7gISiXMrVwaLUVAKnZShyTcz5CtZjf9jhuHpl9mJO6kFM7M1T+TcXFVLFjUn5ShB
         YHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YnMTIPjZvbP+6ylmBnfB+NxC7dfryopwFIX8J+o4KjU=;
        b=QptqcK95QcObtmhuJCuiMv5kVWbiikZpQr2uJN5jeWo+LyrO9YxCWQYU85YfUUDvhb
         +cjeto4Z93gtX543WZ9M7wE74OdE8LUhiM9he2NHm5eYFhncwUrsxQ8lauAI5fvVFOGN
         68tLSDq8meV8zJixWNBaDHGGDoivH56m6JoBwVNAnSxd7IHe0mj7igIjSVWiN4qNpCR7
         mCxFlY5aeu7aanpJrQ1Sg0Jjww0SWAkMsZWEYIsLVie5fJ/OreqehLGwHSphpSt/3JS0
         upCzi5YzYF79mRwhvdwYaSoRxWyizga6k2oVANhAJ/0M3RSuXYz+QHX4T4y89eBDB1XZ
         QHDA==
X-Gm-Message-State: APjAAAU8bOPvIeDItnCNeugsBYbcks3Cfbki/FrnHIflJS+l78LPCtyr
        q3BR5aQ3CkRhbH6pFdEU/VjR+APu
X-Google-Smtp-Source: APXvYqxG4rWwc3M+epBZ/Msjp0aDD+tg87sVwzqaJ9EJ5jmxBPd66PUtSnBrFNjVX7kb7qx5BPkUGA==
X-Received: by 2002:a5d:6844:: with SMTP id o4mr13041763wrw.188.1569837333022;
        Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm11175350wrt.59.2019.09.30.02.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:32 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:32 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:19 GMT
Message-Id: <8512a3e96db80aa1474d679d544679abf811188c.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/13] winansi: use FLEX_ARRAY to avoid compiler warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSVC would complain thusly:

    C4200: nonstandard extension used: zero-sized array in struct/union

Let's just use the `FLEX_ARRAY` constant that we introduced for exactly
this type of scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index cacd82c833..54fd701cbf 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -546,7 +546,7 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 typedef struct _OBJECT_NAME_INFORMATION
 {
 	UNICODE_STRING Name;
-	WCHAR NameBuffer[0];
+	WCHAR NameBuffer[FLEX_ARRAY];
 } OBJECT_NAME_INFORMATION, *POBJECT_NAME_INFORMATION;
 
 #define ObjectNameInformation 1
-- 
gitgitgadget

