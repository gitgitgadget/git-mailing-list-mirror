Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17FE1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJaDem (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:34:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46174 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDem (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so6276884pfb.13
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iiUzv0lMqbt2nDoL0o1L/u53ukaVjLHG406q+XaliHY=;
        b=G0GqRsWXUsUUJkvSTt9aizW2X5MT94xRuWA1YpGAQwXIfIUbPutPU6hG/V7zHuFsDM
         asrwzFQGExWwOYgf6eSAjWqPa3yDUzXITrmueAldHB3hy8xL2I+paFo5I80VwQVVSleD
         AMtT7sRjJl74qEKGBqFAfQLveaK9TM+2I3x+cngKprtkMt6nhMzvweIuvNWRoOpPFA/6
         rERyIh0fMIPiS3WIBqc3M3xCNWR4i+IHbB8KmXzZPHljgD5qGTp+eLU6e5pB+kyOjZB7
         hCxfjCymwHUdnJCDQ1TsDEwpwIt2I8CDP4phBG/TAo95XmKuRviN6rEYD0iABg8bACll
         X1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iiUzv0lMqbt2nDoL0o1L/u53ukaVjLHG406q+XaliHY=;
        b=EgSp6pgu9en8i+TrVnCesnKg3fRHBTuWatGeM66tL91r4pvrY8Qx46yANx+p+ovEcd
         kWTCzZa606T8ab58UPoibRM6sh+NiAzQLuE8FvtUpfFJRUaS8N9ywOHmEooo3f1y7HPq
         l5hwiPDZIMiAohsxV1K3Z2d/Odtx7O+j4tfpFGfY96SFHmoHbTsH5PuuE6EvZvDyRCL9
         YMGwIrZyQMJp+REQ1ZU/EjopJ//jgJX2t/qm+D+ZEtsG0oSj1Nktl4MsOEObSxcqefmY
         4S3bIwqABraW6UIn3sjSGSpS/QRyxvYr6xL/zhF+bkd+o9XDjYSQ9w1aiY64FY4J5DAf
         lYLQ==
X-Gm-Message-State: AGRZ1gJypDsZlEh42BrNqJoUINXKgemN1MNhehtdPqbL2YaHBRwEK0vq
        M8R/Mlwt2RWu/l3SuMiha/Y0M0J/
X-Google-Smtp-Source: AJdET5eyyUzlstzC9sFIth5vAV+TVHW7s0WYQ/PfNcObL6+8K8sGybQCKeMS+NyAAiE+9+Zs07PTQg==
X-Received: by 2002:a62:5a47:: with SMTP id o68-v6mr4155330pfb.31.1540924804274;
        Tue, 30 Oct 2018 11:40:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id t26-v6sm32448621pfa.158.2018.10.30.11.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:40:03 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:40:03 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:39:56 GMT
Message-Id: <660c740fbc190274e1e124672d87abdada97ec2b.1540924800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.62.git.gitgitgadget@gmail.com>
References: <pull.62.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/4] config: rename `dummy` parameter to `cb` in
 git_default_config()
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

This is the convention elsewhere (and prepares for the case where we may
need to pass callback data).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 4051e3882..3687c6783 100644
--- a/config.c
+++ b/config.c
@@ -1448,13 +1448,13 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_default_config(const char *var, const char *value, void *dummy)
+int git_default_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "core."))
 		return git_default_core_config(var, value);
 
 	if (starts_with(var, "user."))
-		return git_ident_config(var, value, dummy);
+		return git_ident_config(var, value, cb);
 
 	if (starts_with(var, "i18n."))
 		return git_default_i18n_config(var, value);
-- 
gitgitgadget

