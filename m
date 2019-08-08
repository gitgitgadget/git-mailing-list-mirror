Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D0A1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbfHHOTH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403816AbfHHOTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so9265200wrq.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DFKO2Y6RdYqqFC92luOo3NuQfAXk9PB9nYMaKON8O0M=;
        b=MVj71Ba7jiaYLwWL8b/i3H/fjfK5aj2ARGxyi1HphMhD18Z7UUAWBYAf0Bg//2eMx2
         b1gob+z7/KmwhfVy1AhVI5f1pPgwVMM61ZHwV1zFPl2sEJu+x/3Bfvgr15aZwAJiwmAG
         X3PJjUBb5LKrk3JwZYVJf4dyNXDbotmrt2lNdwZP0QBy9UIvB2MmY85/gdurGR9nBlLc
         jlxEgiqynUv3RZTBEx+jWG5ur3K3o+aMfYP107tyrCPQRj5YY9jafs7HpEgzBAf9Yynx
         /IHHobvRcxKCGHai4IZokRbq7shhFB0a5Uh+MFa+MbSo70cyrsYzSYZX9UV/XYtkW2ue
         BJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DFKO2Y6RdYqqFC92luOo3NuQfAXk9PB9nYMaKON8O0M=;
        b=m29dGsXlUafnbT4BirVDOJQZjveAXZKbFSR4K7cwGoGs0r+3KxQv7AxoddI/U7pMdu
         O2CRC+q5aX9cI7lFNDmUrSMsXKeuoF1+2N+CbqRSPjVAJ9caiu0gG1vMCauy3y+01bDp
         ZCbuTfS9ymSNVBiWXpnJFr1iJEQNAvm6eedSzVHFBhCVZiWT0GC57oWzBubXCIPdSPik
         J/1GTIpr3MJ8QZkOOEtYOOW648BFGODhNRSxqhgJpFHa6SS2kcP5JXZQrs8SMUz5AbJw
         mdA5WXE4FesC0dTKhBLjY0pZH/nlGs7q+Y7hp5MBhIHFNu0+4Azo8lF5eLeLGbGpQPVX
         BhUQ==
X-Gm-Message-State: APjAAAXcugbpfEPCXNQdr7SfeR6tAy9/mAol6GJc4M64g4+Iuf7UN6vV
        EkG1YW/bnP77A8LuC2ZQowYbDDJp
X-Google-Smtp-Source: APXvYqzm3GrdJesA5Gs6TO886SJxeoP6h2kU1WmxC2YVqOJBSdoa4Ale/7qOD/HUw3YZ6hTXPbXqSw==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr17236927wru.339.1565273942694;
        Thu, 08 Aug 2019 07:19:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm2273125wmj.4.2019.08.08.07.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:19:02 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:19:02 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:55 GMT
Message-Id: <d5b5a70c1b0012e1fca29cdcbefa9df2155bb34b.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/7] trace2: trim trailing whitespace in normal format
 error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Avoid creating unnecessary trailing whitespace in normal
target format error messages when the message is omitted.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_normal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 47a1882557..213724d5cb 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -142,8 +142,11 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
 {
 	struct strbuf buf_payload = STRBUF_INIT;
 
-	strbuf_addstr(&buf_payload, "error ");
-	maybe_append_string_va(&buf_payload, fmt, ap);
+	strbuf_addstr(&buf_payload, "error");
+	if (fmt && *fmt) {
+		strbuf_addch(&buf_payload, ' ');
+		maybe_append_string_va(&buf_payload, fmt, ap);
+	}
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
-- 
gitgitgadget

