Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930B9211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeK3JGJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46492 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeK3JGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so3127065ljh.13
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfuE2Exm+TC8r5Ltjuf7nGMB6WGrz3RmuaVGwcYaKQs=;
        b=FMSOmxyx7aCLUnA3HRG6OcvEufM2YoCuQnGFAjOaRY7wm4y4C1KKSGOB6STuZELSaa
         B8JsAU1oQ6M4bFNHZDA6Ao0K6PiidOJwTsD90DLyNcna+mF10otOC1CINihDJM+vD6is
         44bi0nmTm6765b1PtyUQvZpf+XxWnQsgrVwqCAzL+dpqvJSRokFBkNkVbFctta6tNiOs
         6DuL7vwnBJswuh7wjPDbDrwaAkJ7BdFaYRhZ7qQsHTPhMjhNwX0ATmldm7+YDQJwue6O
         rD9kboa9k3SccZHpxlvryeqJO2ndWSjYjZhlydmaxPKgKe+NT9XUtu0H7GunFLGGIZRc
         qTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfuE2Exm+TC8r5Ltjuf7nGMB6WGrz3RmuaVGwcYaKQs=;
        b=TWiEJC8EnBXs+TJTaf4fDT8tfrRq9NyW3jG3XyGWxGsKLmyEa5pMG23rgECUi4xh30
         x5AoELiM5LjhLU/3xHnAttB/gseDaIeb+8xbjzhFIeQxhMaR5yb7TFTQetPN6Ay/Qq+r
         0Zdx76w2hqNyennp+PGvfS6fi7/al38Iy3dvJzJjdy+Ze9Jte1K6Y6Jg3NoswmJqWxF0
         gI3b28SITNzE6cuugH+W2/6k6WFoI5mhL2BZ3cFklZNSiUgP0582xgmmKboOk8+LLc5P
         8IP0MYFRAIv9ysYQZ7KPZmNA1oh7XAD54uD2+w8Y92xYQB6ES8I/eAL/qwgRi2Vnos6C
         MBTg==
X-Gm-Message-State: AA+aEWYtDqpfXfajiRO1vdJchRsdRqKaFIsWWo7i3JGqL00/uFh4VWdO
        G2q9Tw7zyhqHbq0qZl9Ri3A=
X-Google-Smtp-Source: AFSGD/VFZZ5EDcLZyrtxPh3lxYGe8NWW95RGMDDGe2v3jVFE/Myx25D2bSRtZngr/DriyCcDDqKbvA==
X-Received: by 2002:a2e:2b11:: with SMTP id q17-v6mr2176430lje.25.1543528753363;
        Thu, 29 Nov 2018 13:59:13 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:12 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 01/14] git-checkout.txt: fix one syntax line
Date:   Thu, 29 Nov 2018 22:58:36 +0100
Message-Id: <20181129215850.7278-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<branch> can be omitted in this syntax, and it's actually documented a
few paragraphs down:

  You could omit <branch>, in which case the command degenerates to
  "check out the current branch", which is a glorified no-op with
  rather expensive side-effects to show only the tracking information,
  if exists, for the current branch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 801de2f764..65bd1bc50d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,7 +23,7 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' <branch>::
+'git checkout' [<branch>]::
 	To prepare for working on <branch>, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	HEAD at the branch. Local modifications to the files in the
-- 
2.20.0.rc1.380.g3eb999425c.dirty

