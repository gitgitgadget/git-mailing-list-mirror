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
	by dcvr.yhbt.net (Postfix) with ESMTP id 033FE1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbfJDPJc (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52380 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbfJDPJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so6222607wmh.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PwAFlDQ5FlWkf4x5wuYtwAm/soXttcp6NKf0ywJLbFQ=;
        b=Eb+ai2QBNsAnZwd+zER74usy5zXHjcBtELv71wsXsfPXGknG5iWZDldovn2IPKTg6i
         VJmrxB3s/j7LTwk3Dxig4X54UswtDck9c0awMB+XntVc3BO34UyJbGJmqvEdFilOKN5b
         J4Be8C5XHpG17S7MLfjI8xodbpSJ1Uw5dhob7lvAUCeRcSpbXfXUxNIoy3Eegi0FxSOj
         xTbjKNNTwL6Y+BvB4R1im35gkIpLPxyOVClpW5E2OmGxHTaGzzqbWqXPhvFNsUpYK+at
         1Eb7KzWSN71/Xpl4nzP5jQs4gVuorHlcPSB+ffUk0GVF6X5pPcqeP6953WvlZlUj6vn/
         WbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PwAFlDQ5FlWkf4x5wuYtwAm/soXttcp6NKf0ywJLbFQ=;
        b=sZEPDKUWw9p1ARPeMjv7NgSRvRwKZMfYxpvDgXVwA2nmeCxmgTrLvDAqrNqJi3Tamc
         DODn43ysqeJ6umtMbioM28q4PtoXqdyr43/ofgrWqj8JoJSHnaLC4cY1ZeH23VrKMWhd
         UFEfVtKzvV4aFfdmDlASduFrVh9HTMTUTFEyxtwGEMAndm8kLjMjS1ewyJ17i5NkcYsR
         uzuayDCBq9liXaREH/4ny0k9vf/aCwau2ajAj7xHDKDlz0+RpB+STLDliC/fy1MFW9eW
         XkYOLko7xnbAgKINA7vxkE6GjTfTTwGFRHGoKazP9b/hZUIHoo5xS8K6CuNWUE7byqgt
         qvtg==
X-Gm-Message-State: APjAAAVq1xA/jCFC2jND9E1yqwccYeXasmAexhkidot5faItWq1gEM0P
        KvIgF5QFIr62f43uh0+5Z9BySAKf
X-Google-Smtp-Source: APXvYqzis8rmshyCY4sN+rqi5T1hqckjZlkC3ylRnskWSDJ16x67bFjJHv3GkaoIGCVPE/jrpfjLrg==
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr11153561wmg.30.1570201768921;
        Fri, 04 Oct 2019 08:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4sm5852939wrm.13.2019.10.04.08.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:28 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:28 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:13 GMT
Message-Id: <cd96d7ff70d129543ff6b482b98f0827929525d1.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/13] compat/win32/path-utils.h: add #include guards
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

