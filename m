Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364231F462
	for <e@80x24.org>; Fri, 31 May 2019 20:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfEaUXH (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:23:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38339 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfEaUXG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 16:23:06 -0400
Received: by mail-it1-f194.google.com with SMTP id h9so3148965itk.3
        for <git@vger.kernel.org>; Fri, 31 May 2019 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1e6Ic01pflH6CE1BV9H5GiUI2c/j0PW20898M+daplo=;
        b=YWNG7AUiEDbHR+8rSy1cq8frcj1EG+QHoCr2ZuLgBWRZesPzQ9DAuFvZS1iSjfRyTt
         F6WdQlpVM9GPLsvWa/Cf9rFdklVwQpyVRwXQGV27tGI1M+6YbIRY9Qrpjx1kR0C2CB9P
         k5Bp8CYCeDjHbZ7keJM0JwxnSLXf+xa0FndpZuiyAYWHLxfcMZpM0m2loYq+87FUL5Ru
         LHJfhvPTsH22UxO2pcr3uMAwOsc2bxNPgQfrdIYqt8/Yp8OG/3M5OvL4pb1mExx5zboj
         xGFJF6jAJKPl0rwI4ajadZJ240xjBbGiBjNiSp9G2GQL7XlEt52inomfrpOJDMJ7ZWUY
         qtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1e6Ic01pflH6CE1BV9H5GiUI2c/j0PW20898M+daplo=;
        b=hbhtUrIw4/FYfAwwrCEU62UhcE9Ps2I51VNeQiIPwE77SXvmipktar2tmXLW4PeZ/d
         VAx52MbtUSsoiS4gGtifsPCFp2+BZ76hI/46DWsH/5GJxeS5ICWl/KJwmtqjVg5sZI29
         Ot8rLnOxt9KW7pb6TzEPPbuBYLRZ+lWn4/5tkD+KIzJZgux6a7iTAPzRZd6I7v2kiqIM
         TP9QC0zhqMeTZwRtiHpMgHDi1b2PgA3y1v5GaVmg+i1vTV4b/sfuf9e2YYh7SKtFAsTf
         BE8Z8DduqQJLkIjpzNCTlIr8YV7TW2ET89+OLDeKAey4wOnuS1JsJ//bQavRjrqrG9vc
         Q54Q==
X-Gm-Message-State: APjAAAX7ZlJFeq5gR1oy+7zbJ5Z/dPdHH8UBOMHB+aH+OOmdEywfyl3k
        d5diaF8SS2dWwVbEJaIn7iRspmuf
X-Google-Smtp-Source: APXvYqyMlcCLjH/nkfJ6iPP1eYir1Mx58l7LbkE4Cyh4znwpiA4rTmLC/McExssfjQSWW3GePjmhYw==
X-Received: by 2002:a24:a60b:: with SMTP id q11mr1978614ite.60.1559334185851;
        Fri, 31 May 2019 13:23:05 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id j1sm2411440iop.14.2019.05.31.13.23.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 13:23:05 -0700 (PDT)
Date:   Fri, 31 May 2019 16:23:03 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] config/alias.txt: change " and ' to `
Message-ID: <6f3c18424e7199716d6128aad1dc0da9388d3cb0.1559333840.git.liu.denton@gmail.com>
References: <cover.1559333840.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559333840.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the documentation would mix " and ' for code and config
snippets. Change these instances to ` so that they are marked up in
monospace.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/alias.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 0b14178314..5425449a50 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -1,7 +1,7 @@
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining "alias.last = cat-file commit HEAD", the invocation
-	"git last" is equivalent to "git cat-file commit HEAD". To avoid
+	after defining `alias.last = cat-file commit HEAD`, the invocation
+	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
 	hide existing Git commands are ignored. Arguments are split by
 	spaces, the usual shell quoting and escaping is supported.
@@ -9,10 +9,10 @@ alias.*::
 +
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
-"alias.new = !gitk --all --not ORIG_HEAD", the invocation
-"git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+`alias.new = !gitk --all --not ORIG_HEAD`, the invocation
+`git new` is equivalent to running the shell command
+`gitk --all --not ORIG_HEAD`.  Note that shell commands will be
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
-`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
+`GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
 from the original current directory. See linkgit:git-rev-parse[1].
-- 
2.22.0.rc1.169.g49223abbf8

