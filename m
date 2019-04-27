Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDF21F453
	for <e@80x24.org>; Sat, 27 Apr 2019 19:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfD0TZ0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 15:25:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38020 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 15:25:26 -0400
Received: by mail-io1-f66.google.com with SMTP id y6so5701366ior.5
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FsNyioq0jLLjn8Jeb9CS1R0qao5IKBCe3JoieSxAamI=;
        b=ACPRtwYXn8Rq1AjTPpYMQTQcYP+egd3fIv2rW5EGCXPTM+IR8cowAV00Wqp+ghKY7g
         a7d88v898sUXgOQT6j0IHaIoOk6SBj4eb7iDJAofEl23mZs2qUGySbURJc2iZReS5/sz
         YesZYfK1PspHuwWOlW4QgPyfAwo24zFmJur8zVJUu+eQeHKgwEmOVPMSko3USXxyoe8b
         mOdWX19to03o1qaiIavB/RoXFtzOFuy7NHJPG2Os8hj4NO7FjAwQukSzfFJntGtt7Ew7
         1AMESbl7yGXXoOcNOe+T5nL+Sm0wa/HQguGVAG/QHXirSjGdK1xncMR9HpEw695Q79PM
         EDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FsNyioq0jLLjn8Jeb9CS1R0qao5IKBCe3JoieSxAamI=;
        b=sT1dxG3YwrK/36FBvlFza041jNq6vwv8PchXDMJ60LzpagQMpPWXvMrI6gb13m9+Df
         wtWQyNObygryvWNcHtCsXTwm7t4w+2HW5qebEHAUWup222aHLvH5DR2yddxGYNEsASiD
         TKa8dVTRmkYt7U8DRXdelmeUWKwp9dmLdrACr/vVsYLvpawzw0crXy3kKcjVHI+Kw+vn
         5vwtqOnPLqUtYHwMZPi95vEzg9TYy/zBcfIEjQ7tKfpIZY0HyZsMBavaS1kURIu2IOc+
         PQc1kxNYQPG1HURJSexAgi3rZ33s/xMsP5FJfUp9No4V4V3oFhKal25JFSCQMcyekut0
         oIUw==
X-Gm-Message-State: APjAAAVfAYkrsTPFFL2WeWnN/wpsAZWaZvqD8YWpGAlpyugCkhDJFNuH
        DZnMzFbyizneF4a7UEUllZyCEf2Vog4=
X-Google-Smtp-Source: APXvYqxps+Zayvi44yYHbW7RXpHAnY6ugCoyqmnEARUpw2TjNJCdRWe7O7L0PbP79iuNDGRhawVRLw==
X-Received: by 2002:a6b:c9d0:: with SMTP id z199mr13524007iof.223.1556393125439;
        Sat, 27 Apr 2019 12:25:25 -0700 (PDT)
Received: from archbookpro.localdomain (mobile-107-77-160-125.mobile.att.net. [107.77.160.125])
        by smtp.gmail.com with ESMTPSA id g4sm6038476ioc.9.2019.04.27.12.25.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 12:25:24 -0700 (PDT)
Date:   Sat, 27 Apr 2019 15:25:22 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] git-format-patch.txt: document --no-notes option
Message-ID: <48b6331d75c0e7cd2e435ae912f2b19f7f2f6b43.1556388260.git.liu.denton@gmail.com>
References: <cover.1556388260.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556388260.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally, git-format-patch uses the `handle_revision_opt` parser. The
parser handles the `--no-notes` option to negate an earlier `--notes`
option, but it isn't documented. Document this option so that users are
aware of it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..2c3971390e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -22,7 +22,8 @@ SYNOPSIS
 		   [--rfc] [--subject-prefix=Subject-Prefix]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
-		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--[no-]cover-letter] [--quiet]
+		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--progress]
@@ -263,6 +264,7 @@ material (this may change in the future).
 	for details.
 
 --notes[=<ref>]::
+--no-notes::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
 +
-- 
2.21.0.1033.g0e8cc1100c

