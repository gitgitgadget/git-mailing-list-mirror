Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE99B1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 06:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfDVGMd (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 02:12:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38584 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 02:12:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so5364730pgl.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZyWweYoW5OlOpRdXwrs72aAIwU03cymgayC9EfaBglM=;
        b=hCs9IYo87OIyWaaDsoyTDE6ZIf2FvCIZaVK0HB9NUQjVYU+z1zrRHcPdZSMranYWvr
         eIpzzFaHj/uvHpDdlm5NbomPYNDg1juBmytowqweelXArF4gbmV2edTkZFjwZEjxYdzI
         bzbPnWtFvBhred4LlH7TW6Fz8Wd2a+dZ9cCedDJdtuVicX49DlSacJiTWF/gS8YnKnPt
         Q8Hx2ZtCb0Is3Dkxv6VQ5UGYcrX3sTbP6Fx+hjZ6yeq3+p9TgoCOt5HlFm6XMdtTPZRf
         GMAMWqTFybECVNWf8Kcz8B1FFeuF2SOSJiUijf/AJFiq6uXNvB4w6rVs9iA5Shk2mSQZ
         ZcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZyWweYoW5OlOpRdXwrs72aAIwU03cymgayC9EfaBglM=;
        b=rq1wdQWEWBs2GnV2U4zkbWA5kD4r9wK97DXga1b6pDpNc7BX2NY/DTyVvaD1O0wL5l
         zcPDSil1egmN8RlfdmHiPFJpbZEFEoRNlZf5IusKI9enNJAAlQ12Qu+pxWGDZ7uiKjdA
         PmG0YTX9iu9gcSGVXCEQlOOFxkgdd76RYaHTYLvRdGDYqq4N+MYnt65euLDopY6sf2JT
         LzZeYg/XrawZWOvyyFrqmhDGBMs92SJz1prTBT8b4rdZYU6KeAM4pX9q7u79k9IjMLZc
         z1x75YFmtu59b3vnGr6+2EPwYooU3ORE9mqmvRPWqQgPTHHmWCP08ZvKF1CZ4eZ5Rf+M
         G9RQ==
X-Gm-Message-State: APjAAAX35ImqWAS3TLMEYOSyWRZSRjLarqi8cyAdfp7WQp6kCFSkX3/l
        1Z7ICtX4C/mdWrs5vjwjWOBhCLR4
X-Google-Smtp-Source: APXvYqyvr5pvY/fNprZg8swScJKHzeIMqBvre5HMvuPOqZ2diqk1AEKXVXr63/a87rrokX/P0Qgicw==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr17680840pgk.104.1555913552199;
        Sun, 21 Apr 2019 23:12:32 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 6sm15689862pfj.95.2019.04.21.23.12.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 23:12:31 -0700 (PDT)
Date:   Sun, 21 Apr 2019 23:12:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] revisions.txt: mention <rev>~ form
Message-ID: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In revisions.txt, the '<rev>^' form is mentioned but the '<rev>~' form
is missing. Although both forms are essentially equivalent (they each
get the first parent of the specified revision), we should mention the
latter for completeness. Make this change.

While we're at it, the brief form of '<rev>^' makes it seem as if no
numerical argument is accepted. Update documentation to make it obvious
that an optional numerical argument is accepted.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/revisions.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 2337a995ec..4ba7b4416a 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
 This suffix is also accepted when spelled in uppercase, and means the same
 thing no matter the case.
 
-'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
+'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   '<rev>{caret}'
@@ -139,7 +139,9 @@ thing no matter the case.
   '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
+'<rev>{tilde}[<n>]', e.g. 'HEAD~, master{tilde}3'::
+  A suffix '{tilde}' to a revision parameter means the first parent of
+  that commit object.
   A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation ancestor of the named
   commit object, following only the first parents.  I.e. '<rev>{tilde}3' is
-- 
2.21.0.1000.g11cd861522

