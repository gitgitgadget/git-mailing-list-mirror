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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2B21F454
	for <e@80x24.org>; Sun,  3 Nov 2019 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKCDwA (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 23:52:00 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36794 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfKCDv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 23:51:59 -0400
Received: by mail-wr1-f41.google.com with SMTP id w18so13391306wrt.3
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEaKPnCQ6RpcUSlQS+3BESyKg6sCw/lGdYUcStj4bmk=;
        b=j4RHP3E5uhv3b/OU/ZJmNXNUqa2YKb+w4BrpUoXtG/3qqNqLOjE5ullXuc4y3kkcZH
         bek2JcYCJXshEU6idd7r+9LFzHm2m5ABZ9W5WMnl1VjkhySMTe6qN1xNXMaoksBcSJfE
         1/2ba1IVxERR54XaKXWXzw7qvUTqwQXLok6i5Nj8GzXO69gIE7WHuZDrJnOwQ4sTOh1q
         1Hv9+9i0RwkhFghrG1BZnnU16ULL3kWeVEGt8OQUUHMO61bamNN6+78l5seh8KDXwWKk
         XxzXoBarjpCWREo4KBriEUGoF13HdUtLK7pc3a9wIV+/y8bu5tLksTRYxMvrRd6dbdwZ
         KeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEaKPnCQ6RpcUSlQS+3BESyKg6sCw/lGdYUcStj4bmk=;
        b=P/neZq2fCN/CP5iLE/c0breEByZ3lQ+k+Gck4ldaTD2VApcG07OqmGmo1EuMOA9fY6
         BVq0vrYkX9MTP8OBTArhArYgsGUeojWldtGi3dxDzym4a31RPPqwqyDwUveXzVwZPTI0
         diC6+hgBLLaLIWmWzP4yXolLxB7lFRNQBWrPDpBwbLPL71cjzt6NUPutrp6DXrDr472d
         XbC5hDXrOVBg5sdzlxLwUiOY8+7BhO7NtAhDLkS95PGu7qZ2BktzKomrAbs13mdbMEFw
         L2vvV1HHqRHy9qtMOMftr51jPCdfdK9R/mllfo2m5WWFEV3GzxEXn0uAShvNqpiE/3DN
         7dow==
X-Gm-Message-State: APjAAAUAzfOPUOmIj0KIsw/kof9TonOPMMmGlJhXEfjwYFOOwzN+9iBg
        c8P6Jl3fuq74jbBw7MXllZq6liJl
X-Google-Smtp-Source: APXvYqw/g26MDbCa74vF5e2S+rvYg2dG7JRCq7SZD1tmj6V3qZ+XWg8tE3h56ZIORIUZs8ybKLNXmw==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr300197wrx.128.1572753117701;
        Sat, 02 Nov 2019 20:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 200sm20026652wme.32.2019.11.02.20.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 20:51:57 -0700 (PDT)
Message-Id: <43fcfe9b00bb0a32fc305d7816d3afd23bc6aa3a.1572753114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.442.git.1572753114.gitgitgadget@gmail.com>
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
From:   "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 03:51:52 +0000
Subject: [PATCH 3/5] remove-annotate: comment out annotate BUILDIN_OBJS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abimbola Olaitan <craftwordltd@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abimbola <craftwordltd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abimbola <craftwordltd@gmail.com>

Signed-off-by: Abimbola <craftwordltd@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 41f0fcb78f..a632505ad9 100644
--- a/Makefile
+++ b/Makefile
@@ -1033,6 +1033,7 @@ LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
+// BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
-- 
gitgitgadget

