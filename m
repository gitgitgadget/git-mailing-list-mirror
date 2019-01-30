Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084111F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfA3TvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:21 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43790 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfA3TvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:17 -0500
Received: by mail-ed1-f52.google.com with SMTP id f9so608511eds.10
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=amx/A/oh1jjJNyw647hdHNb6HojmsHnaVjrPX6ixGTvlnZhSarrGjX8YlVptFi0FNB
         kYXfnGCwMkBGgbVfm5JXuTSa38Q0fnvutIHQqypPTS19Sg9tV+WMLRwDuIZCUPjFrCZN
         +k4AIQOsrFbVSkzqcPfR+KZYXkag17l4vG/KE8By5M7gVaWJP9p4VF/naif/20/2xJkR
         y0RaC/FwNN65pliR7ZtVU1ONGBmWFf+JfFiTTWBLuSkLFqs0Xd4PzeJ3IJ13FSEpXpBY
         LUCa49hA4WE2L5Jx7X3COL0QV49iXW1LE89KrZqq/su1HqyjdgYmFFJy3SlDeB/zDnf2
         frlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=GknarOe9O+9wA+utUdG+wSdYRBOUQ5tt8RK6U14S/C3trtKHnLBVDeTJgxMlBFstqn
         Xzyin/iPquBnX92rGXNEb5seT84c9m9KeX6EKfjVyMlUXEPTppO1p+Qprh6JP+xGmRhs
         /4D83/c8UT7aa/dSLK8StuV7yH9x2rYa+QV4g94e++ffFu8C/3SQRWMzGQc1n/cGqNYX
         hroIIBhwA2WjVMZbWnKDxD0DRGhiTX1XYBTdnmMJWHKbu7QgrOqrlEd+FNbVsKKlk+Tm
         +xYw09SvJGFlTxrI07Y1fhnoIiB6eMZHe6hXXNOxCTtlsyvYIVxCIPicp0EYkNnhUSHi
         O8ug==
X-Gm-Message-State: AJcUukczWbe+233Pdkua6s6J1en4DDwhLKNtLU18u+Oc2EzhPryuqp7U
        Kwt54qcJnaWmO/SXK2gm9RVBCWf8
X-Google-Smtp-Source: ALg8bN7Ov40ly3jAOMWC86R0ggf9ulGSltC7ivMsyKNmROQxRySPjxnMkr3/BHAuQ5w/zhkYUlcuVg==
X-Received: by 2002:a50:90c6:: with SMTP id d6mr32152052eda.15.1548877875365;
        Wed, 30 Jan 2019 11:51:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm726354edb.41.2019.01.30.11.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:14 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:14 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:51:01 GMT
Message-Id: <e46e92bc7cfea388e0d15dfca7831e47b92a5854.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 12/14] trace2:data: add subverb to reset command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/reset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..b65b4a66db 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,6 +340,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		trace2_cmd_subverb("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -356,6 +357,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (pathspec.nr)
+		trace2_cmd_subverb("path");
+	else
+		trace2_cmd_subverb(reset_type_names[reset_type]);
+
 	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
 		setup_work_tree();
 
-- 
gitgitgadget

