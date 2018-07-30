Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8914F1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeG3RS1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:27 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:34332 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3RSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:25 -0400
Received: by mail-pl0-f49.google.com with SMTP id f6-v6so5741137plo.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VueOAmOgRUvHgNEc4qFJVjXHocplKMGlsfnTDD0z7SY=;
        b=YRB9FQvpa0K95C7NOKe9Rxsakl37BA50miREY8pQTlM3Zlx19JCjr37Hhg8so394vL
         yY7VfdStzQ0v52AzUZGLS0l0lj3wED8a/XCN7mbG0g+c55ZKIRVJTwK+6eWYyzmNe7We
         3WKiJwyoiUHj8FAb+7goyc60QKBmUQw8O7N1PdKiFTYfwxswSGaDzsC0mSfFTJ7PPD9Y
         kd14pJzODX8Qy+ek5YFGxnaKR30RdsiASzeR8pPzzB6Mu08E3uqgivnDlGVWMUrdOvfY
         Pz2brdPxVAcrs7dU1VrMGg2eUgR7Np97Z15ojHHyrADeFdch5r62/LmgiBncbIaqAYnD
         1D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VueOAmOgRUvHgNEc4qFJVjXHocplKMGlsfnTDD0z7SY=;
        b=GrB6+dWUGuWl7pyiQPjakxpEhyaV2dlkSnC2AFlmw3v4cZxzTgmAeFn/V6iJjCQgZL
         yq3++7zJsBRWKp0W2kQUJsP+RevcXUWewvuvB75vb9ofCTcqHHsmAcG+0jhVFTEF6mT1
         hzgB7g6rICC+gFmErRl6rwvJI1oW7jEguwEAzW/jWwvzwxvTJFyIXor18C883MZ0AhXk
         DqKsBSBWIC/9JUQqdxM2FQQdBal6FeJJWyRLq3BkIoF5AGDixbM2BBH0+6EMm+8hocjv
         XFN7NvX7+SuF7lFi+GOD+ntTMUN2dHykPDwc/wM41EZ5j5p4qh41/XDWdyxVRWI2Heok
         9pUA==
X-Gm-Message-State: AOUpUlE6QibbC4WdqCXEbRV0mgkNNz3S4W6ss3Mn26FfHMf/csv/qgIw
        rBex1q79qTLlBZzzqJVgylT3rAYB
X-Google-Smtp-Source: AAOMgpcWnFDfAw6vGxiquZZHMknD7ejxe70nSwOQObRsbxi3eUjUGpijCZtlv0GeO0ecJvmz3W3rpw==
X-Received: by 2002:a17:902:24e:: with SMTP id 72-v6mr16838197plc.74.1532965372095;
        Mon, 30 Jul 2018 08:42:52 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 85-v6sm38091852pgd.81.2018.07.30.08.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:51 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:51 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:37 GMT
Message-Id: <4b95b1e2a3eb3d3c26dc3fdc5cd880792a5f048e.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/9] mingw: define WIN32 explicitly
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

This helps VS Code's intellisense to figure out that we want to include
windows.h, and that we want to define the minimum target Windows version
as Windows Vista/2008R2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 684fc5bf0..2be2f1981 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -528,7 +528,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	BASIC_CFLAGS += -DPROTECT_NTFS_DEFAULT=1
+	BASIC_CFLAGS += -DWIN32 -DPROTECT_NTFS_DEFAULT=1
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
-- 
gitgitgadget

