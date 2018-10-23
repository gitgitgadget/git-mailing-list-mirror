Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA981F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJWTOp (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 15:14:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35668 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTOo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:14:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so474998pff.2
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3EJKw6lNrn7P+4dw4VvyXErNmjXA3KgEi+pn0HkpeyY=;
        b=f3hU1JKnnKItJ865k8WNtruSovi2ojtr/bEnR2L1YGVBAZZXuJ4rMm65J+ciX1Wijc
         C3pN9nkgAPPy/HyibLG6Fk0t4L+HHgCRo2elTQ6N6K3l2KJESOOeNSgPQJdNpiOqWbir
         Zj4HlwbnXh8EGWaJsDZpdo+5H2of1ZOQEgr4NjgOqidGZEFTavCGrqVOmO086vgcPqxX
         gAhR4pTTvxcFWZuXt3cZQvxIXU9K5O4NVMvLXIhC1coVqWdm6H2jdqgRKewg09UQFdJ5
         4j8nwbY47eEuZAKWiLqKsmQZw7hdIooxwEkRp9C+Lh/PYhsmC55Q40U7rdp8xyFSM42S
         9Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3EJKw6lNrn7P+4dw4VvyXErNmjXA3KgEi+pn0HkpeyY=;
        b=jyhxjCbELrH0XSZYz9Axb5G3xe5Pw64lQ9NShKkRbm/2xzrMsGmkK0mjK/yPsYTXsW
         RrxSiSZ48s6xni353xrzSkCIez4aOxKO6CU6dLVgCwrdKAXVaTB+hvvTN6aUXkWLi81+
         KMNY+VW+BGfLuXoXCvLW6icQNShrEG47OKxPDbJ/zXeJ0Hw0/AKiwWYmjyir2Gc4RKT7
         LVKOsbaUTbZeX18iMccpAHL9/lQV144NmilBclqqfBUP/6iO1tCiKgmNVs0AKjWp7oIm
         K4Bfcb8t8Gel+qpwQQv91tcyk9tYf9bEukBaC2I+a6kgK+KP6BuWzlzjT4KPLbWO3yIS
         xSuQ==
X-Gm-Message-State: ABuFfoi9MOOHjZov5hiJEQdJfKRoxCiwkNiGOI81p08lvpFLKpnJ00UD
        Ybcwb3YBtJpoezAht9C2JCrtrX1I
X-Google-Smtp-Source: ACcGV61QB1ALsWpFz7nmESsbkwx2QWangLjSxzEZtfaf8sxSiKogmz5opvVsDyZxCrw/z/B39ahSjg==
X-Received: by 2002:a62:5103:: with SMTP id f3-v6mr49122790pfb.107.1540291909909;
        Tue, 23 Oct 2018 03:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id s80-v6sm1404710pfa.114.2018.10.23.03.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:51:49 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:51:49 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:51:46 GMT
Message-Id: <89887345376ccf8813603f10ac51d39527397aee.1540291906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.55.git.gitgitgadget@gmail.com>
References: <pull.55.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: load system libraries the recommended way
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

When we access IPv6-related functions, we load the corresponding system
library using the `LoadLibrary()` function, which is not the recommended
way to load system libraries.

In practice, it does not make a difference: the `ws2_32.dll` library
containing the IPv6 functions is already loaded into memory, so
LoadLibrary() simply reuses the already-loaded library.

Still, recommended way is recommended way, so let's use that instead.

While at it, also adjust the code in contrib/ that loads system libraries.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c                                      | 3 ++-
 contrib/credential/wincred/git-credential-wincred.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 18caf2196..9fd7db571 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1577,7 +1577,8 @@ static void ensure_socket_initialization(void)
 			WSAGetLastError());
 
 	for (name = libraries; *name; name++) {
-		ipv6_dll = LoadLibrary(*name);
+		ipv6_dll = LoadLibraryExA(*name, NULL,
+					  LOAD_LIBRARY_SEARCH_SYSTEM32);
 		if (!ipv6_dll)
 			continue;
 
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 86518cd93..5bdad41de 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -75,7 +75,8 @@ static CredDeleteWT CredDeleteW;
 static void load_cred_funcs(void)
 {
 	/* load DLLs */
-	advapi = LoadLibrary("advapi32.dll");
+	advapi = LoadLibraryExA("advapi32.dll", NULL,
+				LOAD_LIBRARY_SEARCH_SYSTEM32);
 	if (!advapi)
 		die("failed to load advapi32.dll");
 
-- 
gitgitgadget
