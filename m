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
	by dcvr.yhbt.net (Postfix) with ESMTP id E39CF1F4C0
	for <e@80x24.org>; Mon,  4 Nov 2019 20:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfKDUEL (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:04:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44741 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfKDUEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:04:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so13114481pfn.11
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=my6aVG3DlfjCVcAHaEWnywsR3E6kPtPcwKmxnpYJJp0=;
        b=TR2n+zmGm7dgJlyu4+JR5+exy7IYEBzd77QU1C7i62ShXNVrL6d2ZpKu9XnHCfT5B3
         m4jGTl0Kp5R7KphBfAE4wVrOdAINtRpG28vGl839I6f5Ere/vBEhX3vmgs0WSduOInZ9
         gssAgclvlx6BnvAxDyzcZXeWHcSJerNRf3ymxPk/A8xhAS5FQZNtPQW+HTVmBuXhrhN4
         La1OZB+fF8sa/gWbg2eZeir5LIi2hI+MHF5RifeA+ZcUu7pvKj0z4XpkaBWAJ1k7ciZq
         w2IGh/3VczoLQCvud8CspgeefBWgS8izCGElE13bFYSECKkHFy3MpWfeW1JDjBhQF/fd
         /pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=my6aVG3DlfjCVcAHaEWnywsR3E6kPtPcwKmxnpYJJp0=;
        b=HroSWMvRp8NqnYmBhOQKXCqypfecfwy2bot+jrzj310tRrI3hMNuW2FtFQJmB0JqaG
         7NGoYWlYVqrOD1ypWGD3Ues4zwzbjtLveoofYIs8zkxc/Bquyp6xDrJJX7dGUna49LiB
         2/zthMMqZN90P0EXsjAr4vKQqH8Enm9dgaAV/Vlt/JDa4iRCpTRzYOerL4DGpm1JtxBq
         au067xaCIGJgXHhjqw2At343nlCyahTWowGF2pkOhyHlXjs0Fyv/p+pkBJZQ82wWlSKj
         gIrLFR4OtGxloCC4ffyPFiN66q2lJqV5Z5gqL5/IMWxdp0pmoxv4qZbej3Rzf0pe1de9
         3f8g==
X-Gm-Message-State: APjAAAUSQO3JcKoeDx5uXRRlu5ZDPXNntntH/2WZ9gryjKy+RTsAKhkh
        5JYvfjdzobrIck1grSz8dG3hIlp3
X-Google-Smtp-Source: APXvYqySFhgupeYWEQQb9XkMs6VQrdHx+4bilY90rceyji1Lc1fdXFbXZEB7mAIkDI+D5b0LW8mxbQ==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr33788572pfd.49.1572897849778;
        Mon, 04 Nov 2019 12:04:09 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id r13sm21521156pfg.3.2019.11.04.12.04.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:04:09 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:04:07 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 8/8] SubmittingPatches: use `--pretty=summary`
Message-ID: <0b861a47890a3d1e193d520f4678d017aac87207.1572897736.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git was taught the `--pretty=summary` option, it is no longer
necessary to manually specify the format string to get the commit
summary. Teach users to use the new option while keeping the old
invocation around in case they have an older version of Git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 1a60cc1329..6969ecca45 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -153,6 +153,12 @@ with the subject enclosed in a pair of double-quotes, like this:
 The "Copy commit summary" command of gitk can be used to obtain this
 format, or this invocation of `git show`:
 
+....
+	git show -s --pretty=summary <commit>
+....
+
+or, on an older version of Git without support for --pretty=summary:
+
 ....
 	git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
 ....
-- 
2.24.0.rc2.262.g2d07a97ef5

