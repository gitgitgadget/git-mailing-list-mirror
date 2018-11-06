Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E775F1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 14:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbeKGASx (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 19:18:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35133 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbeKGASx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 19:18:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so6325419plp.2
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mIotpF8vqodFOT9JRWHZ38oxjoGqa7FJkWrtAlpfEwg=;
        b=jWPMVlAI/g0wCIbxsQlYBzSpQ1tv9gadx/0CIqoSxP4dFazW87KdXRN5Kc/X2XUImT
         m3mJBoMni0K9+fISSJTEM9DOboI2+EpBH7/zm5u3IwzWsjAHykB7zDbx2G+QI6Y+dlAn
         mxB4P0LI4gvpnUDs9lXPzJszRnjWtR+4qAMClcjwfZER75WXPbsNAJ8AC5Jf/Armqoxf
         PiMpJE7ou4eldNgJJIx1pTi4NjbjuU9kXyfsaofaIGjGq6ZuQTNzWKNII1vpuIIKqlQG
         7763y9ErUWOjlauhE+tCth8Gw+2BvKZKI1LsQ8bimt84QM4ECJWpOEBlFYh1Ejaj9eIq
         eT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mIotpF8vqodFOT9JRWHZ38oxjoGqa7FJkWrtAlpfEwg=;
        b=QuAosQv3ozoDDMk+yyoM1tnmv4e6OXxJKTX+rO24H/tKdX9HTNhLvCsBxrRlZUfPaI
         QyLOdV39arQTkUQu0wnqMnLO+c3bVPPBD6E1M7zXtSS9vhrPCjrbpayIyFfBGgX/qZ+J
         c5abGZMg5sz+hFAoSl+8YGPj93Z/spYaB+1/OTIwPQ8/09yNdyLoTUh5gP1vyCZWClS8
         s6vXr0aVvx6DTL/VvcbsS75wKng+P8XvKzrIyURUWq35nKYSW1WGlpum8OME5GqtGIEC
         glIOyUOPyMOLpD1yijZfRs6hcBNw6mZ3XQ8uqy084bzY5hjm+X0eRl/gHcvQRCBvbnGC
         VxLA==
X-Gm-Message-State: AGRZ1gIyhg2j3SyfDPnUCzSm6w44+RhtW2Eouxhs+cNabtj500C9CIRN
        Gv6k3xksLlUHs0it+Joa/Yx+CScn
X-Google-Smtp-Source: AJdET5cTzi871SchsIehBDTy1TXGdwpNlDtJcFFyppbA7+/X2wej/FH0iOhwhW69rSj//cnGJFGlsg==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr26758551plg.108.1541515998271;
        Tue, 06 Nov 2018 06:53:18 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id i12-v6sm63625065pfe.7.2018.11.06.06.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:53:17 -0800 (PST)
Date:   Tue, 06 Nov 2018 06:53:17 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 14:53:14 GMT
Message-Id: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.git.gitgitgadget@gmail.com>
References: <pull.66.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
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

On Windows, an absolute POSIX path needs to be turned into a Windows
one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/path.c b/path.c
index 34f0f98349..a72abf0e1f 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
 #include "path.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "exec-cmd.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
 
 	if (path == NULL)
 		goto return_null;
+#ifdef __MINGW32__
+	if (path[0] == '/')
+		return system_path(path + 1);
+#endif
 	if (path[0] == '~') {
 		const char *first_slash = strchrnul(path, '/');
 		const char *username = path + 1;
-- 
gitgitgadget
