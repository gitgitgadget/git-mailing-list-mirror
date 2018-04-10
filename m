Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791B21F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeDJSfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:35:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38817 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeDJSc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:32:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id m13so13775980wrj.5
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1sQzTk21EiI+e4I/SsmqsX4dsTcsK0z7Smnhx1lB90=;
        b=VtLZ8NCv//+rY8tbDu7l4xXuIcV66BIGi0sUFyklMxHSNKrmK5lZi4xIDcsyrlUirI
         vUZaMCrWyO4raN21lddtr+oKPoB6lfhytvJsiqycXyHWzKGQQhIMJqciUUD91hzxHaeP
         6SrpjSrdKi2WCE0gJzhjkhnLWRYsjeSAYQ45pylblozSSu8n4jVuSYfpL/Q3SvtMJtRG
         d+esJqxXB5qvTMi/yh4tMEN9AuJDY07itSZqdSoM/2Ud13bjePhix3G3BD3grAJRGPzO
         DoAT+gh6dMWMGBjS89HD9HaMnlpYI0iyVZw+nUG0D9ibkGVTvzDJtlTEbzuGeOfOYfmG
         U5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1sQzTk21EiI+e4I/SsmqsX4dsTcsK0z7Smnhx1lB90=;
        b=AlkkTb/ATO+Pi1zBo9DPbclWxto/i6mrRKODPM5sMdmyton6dHF3V0S+qrdXS6nA0K
         n4R9lum11HhNvBKOytjFj17z/h+9626WBT1yzbhn7oFcNToO2//P5txiDTdgdTJd1Moo
         T1ZUZTYixoR8L+rKuH8oDChTVQx8XJ1rfCIjRv0iz4iVIPS3UCz0eJIa++kb2N/SNQO5
         vve3HVyjAvL3rmimYvHYvmjFYSOwh51UVasDlHoNR4jvv00Qe2+BCdVpfH31kUHUFWWE
         6XxkBzmLx4xjqlqXgA36EmRLwSmNIl81Liyb+HscmeJwRhKDXbGN+FQQtzlEe/niUCy7
         MRZA==
X-Gm-Message-State: ALQs6tCIZ0T7aLt7iMr9nAD21KvHUrQp/L2KpUMhrHf2wP3QiIhGfn0f
        usNtieP7uAhx76IX51AsVVXJpQ==
X-Google-Smtp-Source: AIpwx4/aAj5UiZPK7d7UaRgncSILJ6/+RNWKP9p00b8vmhs2LgmDLFaIHdsTARs8lkojZsmFnB/jgQ==
X-Received: by 10.223.209.194 with SMTP id m2mr1230840wri.214.1523385176740;
        Tue, 10 Apr 2018 11:32:56 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id j21sm4426354wrb.49.2018.04.10.11.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:32:56 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 2/6] doc: align 'diff --no-index' in text with synopsis
Date:   Tue, 10 Apr 2018 20:32:20 +0200
Message-Id: <20180410183224.10780-3-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Comparing
The two '<path>' parameters are not optional but the option
'--no-index' is. Also move the `--options` part to the same
place where the other variants show them.

All three items are already correct in the synopsis.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b0c1bb95c8..ee1c509bd3 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' --no-index [--options] [--] [<path>...]::
+'git diff' [--options] [--no-index] [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
-- 
2.16.2

