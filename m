Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5490920248
	for <e@80x24.org>; Sat, 23 Mar 2019 15:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCWPZv (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 11:25:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36232 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfCWPZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 11:25:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so3494554pff.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4ZNdZpmmwUoCHPmCpS71WtXGaNzSDoLsluClN+27UQ=;
        b=gYOwBN7epr+NsIMtbTWs9HbzjC3d+mDxHMbA0s0t0ZJstEq4N9MfNlzxnLycFPQJ3t
         3fARsY3xPyg8zEdavEAnD3CF5GxYsfACEKCzGSddsdsyxcyw64j5CXmHjkXHzuO/moOK
         0xbTnaynt+JmqYOcU7+I2gvV63CwFUqeobTx4pptMzuoGGHIpa0dQM5EuBHB+e7D2mhX
         cRsWGCSguMrFu1glnMeuXgm4CWzxZya2MsX85xKLaNAe5aas0CPFWHzsXZG/A2iEpX9N
         IAtboLSpZPEiVsIqqxHcjkxUTtty7A/gxL2V+P5Wm7fIT3+z/Xp+XbiUPgH2GDmp58us
         V//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4ZNdZpmmwUoCHPmCpS71WtXGaNzSDoLsluClN+27UQ=;
        b=Dsr/bYUf8Bz9xq5twnn5BXCTodjs7hefK0mXGxEfSvmKGE1bytwsEjK5hDRI/dSgN/
         QU/C0buAIiIv6kNjPWFhN0Be1BFQO2T/wo4N23APR4KBy28LlCKs1/WBR853oHIW9/3D
         x92PJWmYEgx2BZNFKiIaxfu0/DnumUTnhpr+AyWPoenNT6huWJVn7k/IXspy68fwH/Gy
         Skz4gPgJwxs/BB6Nvo7BUHTVXuclzAPuSuAWmOFxHOqAcWS28vOnulLApOgqAIHnYZVW
         L7p1cxDWpbGXB8tV3LvuwKeTqaVPCbyFeMpWLC8mN3FKqa1aw8NaczN7R1zVJa1lVsVA
         +HKw==
X-Gm-Message-State: APjAAAU+8GPqAbBc7yoom2DnWPVJrDVW+hkOWERB7+O0lZ1kbX5EKiih
        //4He906O6JaK1K+R+G/s9Rb6PPr
X-Google-Smtp-Source: APXvYqwsbMTmFheWWPqT33iIsv3FMTciPfIQ8xiEBgRwBIrDzr1MIHT2fyKLAqW6RURkZIMngbop+w==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr15551394pld.220.1553354750363;
        Sat, 23 Mar 2019 08:25:50 -0700 (PDT)
Received: from archbookpro.localdomain ([172.56.17.211])
        by smtp.gmail.com with ESMTPSA id d5sm12107706pgv.20.2019.03.23.08.25.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 08:25:49 -0700 (PDT)
Date:   Sat, 23 Mar 2019 08:25:43 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] git-rebase.txt: document --keep-base option
Message-ID: <8896a65c2cecfc84c494545e47c918a45cd63602.1553354374.git.liu.denton@gmail.com>
References: <cover.1553354374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553354374.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the --keep-base rebase option.

While we're at it, change an instance of "merge-base" to "merge base",
which is the consistent spelling.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-rebase.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6363d674b7..780d381667 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,8 +8,8 @@ git-rebase - Reapply commits on top of another base tip
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
-	[<upstream> [<branch>]]
+'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
+	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
@@ -217,6 +217,12 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+--keep-base::
+	Set the starting point at which to create the new commits to the
+	merge base of <upstream> <branch>. Running
+	'git rebase --keep-base <upstream> <branch>' is equivalent to
+	running 'git rebase --onto <upstream>... <upstream>'.
+
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
 	not just an existing branch name. Defaults to the configured
@@ -863,7 +869,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       --interactive` will be **resurrected**!
 
 The idea is to manually tell 'git rebase' "where the old 'subsystem'
-ended and your 'topic' began", that is, what the old merge-base
+ended and your 'topic' began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
-- 
2.21.0.512.g57bf1b23e1

