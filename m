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
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFAF1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfFYOtm (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45795 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfFYOtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so27511663edv.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DSglU3HprV3qOQP85ARxY9TDB5rasZXGc/9TjR3K0J8=;
        b=Z7hJpbFHm3uColTQIXp7rlNQ5qzlK3+HncHO/Z22uaBB+tDrWRd/oGaYPSCsyAfBE/
         R77LHYXdrVdgF3sUY8Mz/xJf7CGAKhTIuqn7Rh2sGSdPIUUX3XEjYBq8UurKQwZXQmbr
         sQFsg00pgarvV2IbVpZWwv+pUhat1geh+oSRmFVpMvZN6QxCVtnWZb7SvIW+SsYFLlI6
         rZgLFl4vkrsXXBenjo6D2LYYaKmzEynzlLp1x+p0n7fV0JsG2mktasCJeYu4pKk+zuGQ
         WgqQZKJYHN9gVJGfByoP49ria8jteET2bLIaGSXHuFHkg/FLPyuNqh8w0SEyMsVW2SR+
         b4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DSglU3HprV3qOQP85ARxY9TDB5rasZXGc/9TjR3K0J8=;
        b=B2Cgsz2CtEdg8k8nTfvIVQ/CnoFfJXzoA7cMjlkBsAByRcsLS+nY5rsoINznKb96hN
         hIndWdRMukC3nDjs2C1NjFECeZddX6bkHGoMM3iPhLc/PPoglR8uVOHhAXqEV9WLbkAw
         7rzQvkt4IBIwU/ZJoVWvVYG0Ha94N7bEACHz880r5HomzDv7Ab8a4tmYwW30BzKieB5Q
         3KdHjc2eV6dcxi82x9CO0ijISLQdlpFor8AZbNxAZuF72avwM1ogHCbcOU0Nl0DpAfN6
         lRR4H4z4QS4A8q4D8V/sGgvR5AbDGC1fFe2eJZcYo8cgQL38kHEye/80s/QMRFcZYlY4
         ww+w==
X-Gm-Message-State: APjAAAVJIcXlzQ28lJzw2exdtarFJcfGgEKcyofQW/xyZP5RUZYCkNHC
        IyWcrh+Ri4CMJ8u+2ecwOCK/8icN
X-Google-Smtp-Source: APXvYqxR/1Mmo3nT4QLdosOQu/ZLVmhJ8mTro2RChtfrgiSLSbIF2gFOXO+ug9v7G1/33zMY28owyw==
X-Received: by 2002:a17:906:c73c:: with SMTP id fj28mr36132634ejb.136.1561474178300;
        Tue, 25 Jun 2019 07:49:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l38sm4821987eda.1.2019.06.25.07.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:37 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:19 GMT
Message-Id: <f528883d97011128d77061c4976655b80a7e7b14.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 13/20] msvc: fix detect_msys_tty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

The ntstatus.h header is only available in MINGW.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index f4f08237f9..11cd9b82cc 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -544,7 +544,20 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 #ifdef DETECT_MSYS_TTY
 
 #include <winternl.h>
+
+#if defined(_MSC_VER)
+
+typedef struct _OBJECT_NAME_INFORMATION
+{
+	UNICODE_STRING Name;
+	WCHAR NameBuffer[0];
+} OBJECT_NAME_INFORMATION, *POBJECT_NAME_INFORMATION;
+
+#define ObjectNameInformation 1
+
+#else
 #include <ntstatus.h>
+#endif
 
 static void detect_msys_tty(int fd)
 {
-- 
gitgitgadget

