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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBA81F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfI3Jzj (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38214 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfI3Jzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so11987817wmi.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PwAFlDQ5FlWkf4x5wuYtwAm/soXttcp6NKf0ywJLbFQ=;
        b=HFhPxNNQOxR0gypOR7RPBhrBu1ZQiiKIiMjsVmRfMGCFag8x8dmECCUoSglUOx9IU2
         wr7x2B3M8cnchTcwovHnokbTaBCsGzYKGSRrerxR00IzbLysMx8ABHna13Bw4BK6UzRR
         mxZpVMNvYMtsJ6PW0U3WmtHRUofh0FXkRnHeDH0PoOFEQh90o9mgqrIA9ou+WtZbE4/J
         YRwe9Z4d5SRJ31Rxw6RXWyV636kgyjxFXML+kNtCLk6nTLMpdYEB78fqjs5bu4L/t2nf
         blXdfxOLYh8XS15KanLOSYv5QxEWn5Jf/LkUeKSYDXdYZRaM6PucnzfeLGEhA4GHFNwE
         MwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PwAFlDQ5FlWkf4x5wuYtwAm/soXttcp6NKf0ywJLbFQ=;
        b=hyWDcRhJggj4ofzqToS6mnMvLstP4k7pbW2pdEwUg4rsn1HyA1emuGPghm8Ec7McBY
         l4o7kNIZaICgK2vqd30tru0ecJNmRRJDkG6RqXa0UFob+LibKqIP6k4E/a33B80q+1vu
         glsmbyCyHIVaYmOOx8PCY4HptiCZsio24dPhUupetbBPtPaF9Y4RArh0HEnDI/Ehu85K
         J7bm39OsoSOr41gQYxeOx3Gyn9OVopUJ+65TluBpuEVRR97PQpnpIpvrddVZwcQ679/D
         8vvM8e9+rQMK2+e9EmhLz/d9n+k1LabLBa7HGaSJ751hHQ9xBo4to2zkQtnXgCDQBc3U
         z22g==
X-Gm-Message-State: APjAAAUf7iORIBk2nmkhfzaNrMHn1X9zF1UviSmw/I02Kgewmsa5NMdb
        URV07qOdQr0XRVXkvMdFdvYIuENj
X-Google-Smtp-Source: APXvYqxBzMKOOyQnA4/mH+tJJMzZZAUl8jFO3BnhX2EaOcacFMhLwyZLBqhjiSOMpxUkGX6p8NwegQ==
X-Received: by 2002:a1c:9c96:: with SMTP id f144mr16990203wme.96.1569837333695;
        Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm33687229wma.24.2019.09.30.02.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:20 GMT
Message-Id: <0345b08f542b1ba950882be2932e1643890bf8d2.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/13] compat/win32/path-utils.h: add #include guards
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

This adds the common guards that allow headers to be #include'd multiple
times.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/path-utils.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
index 0f70d43920..8ed062a6b7 100644
--- a/compat/win32/path-utils.h
+++ b/compat/win32/path-utils.h
@@ -1,3 +1,6 @@
+#ifndef WIN32_PATH_UTILS_H
+#define WIN32_PATH_UTILS_H
+
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
 int win32_skip_dos_drive_prefix(char **path);
@@ -18,3 +21,5 @@ static inline char *win32_find_last_dir_sep(const char *path)
 #define find_last_dir_sep win32_find_last_dir_sep
 int win32_offset_1st_component(const char *path);
 #define offset_1st_component win32_offset_1st_component
+
+#endif
-- 
gitgitgadget

