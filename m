Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3BB202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdIUMoX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 08:44:23 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:49290 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdIUMoW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 08:44:22 -0400
Received: by mail-wm0-f49.google.com with SMTP id r74so1450430wme.4
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Im5CPUex1ja6YY3DXehbM3soIxrO17T6LgkAOK6JXjI=;
        b=CpHR2B6XXol9sgsLdq3AHtxrrxIz60MKTfzbp1cf3HO2Xe0adZzu8p2sRmlth2su3F
         0QFUU9pq200mUAiiZP2OoIi88HTeWhM8yg02eMilyPzu9J6eDm/LAQ4Do/R70L60V8Yt
         1m3hCybQVx4QZTee1xlG6lcdJviwWaXAmQBIp+oX1XWDf9nATz+L1fRkB2SeNQJug0tr
         jQke8zLk6cbkfTUi2Dcb9rcS6gG/BRTJOC3iMthOqKMH2s4CroeCLnIey2I6/53vEd+n
         blQcnYFeV5S5MXP1hA7dDEPtN7x/B2W+AEN9blqs7GajgbPnUSuqMgNUS8wOA65eHfEq
         OgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Im5CPUex1ja6YY3DXehbM3soIxrO17T6LgkAOK6JXjI=;
        b=On6wW0mdHHYGLxRoirp8ZHimJ8CeABUjMTJ7SI7d8lYt5xm8se89UPHjU0fbeoll+8
         KdfzZjRsJP4P9ZsRw1VlPEbSuoD7H8IyIVoh2mHmc51hSUU7jYd1FfjPpf1sLFJ3CzfO
         qT/LJNbAeJAl9TB1NnDH6MJ/ne2jTkk4SxczxH4Dc685SoYuNJGSLWT+IS4SqpIl5fNj
         JzP0UMpKVcHwXSCTIbQLwUi4mk2Bnyqrol0+aQf4dhLS/C/8bMwVZPticYa0iB0w7/U7
         W602aOq8VRIB/dC/pDzYuRtdjFRt3xCGVZP0xFuSDX17qK8r//upl338QbymwwrAhU64
         bC1A==
X-Gm-Message-State: AHPjjUj3e7fTOMU2pJ/mL9lZgivWKySCphms0y880lpjuetYhY8LJov3
        t6ot5xDyJndIOtk0ZQn7887/s+uPguI=
X-Google-Smtp-Source: AOwi7QCatMWXE9z5r7QozVNaHQjQxx6V0uiyhxoxq4SKbVzceT26lQ7WIkkC9yXL1VWemWNJY+d74w==
X-Received: by 10.28.73.133 with SMTP id w127mr840323wma.55.1505997861198;
        Thu, 21 Sep 2017 05:44:21 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id p59sm1494778wrc.75.2017.09.21.05.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 05:44:20 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 1/2] Fix typo in submodule.h
Date:   Thu, 21 Sep 2017 14:43:37 +0200
Message-Id: <20170921124338.26626-2-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170921124338.26626-1-hanwen@google.com>
References: <20170921124338.26626-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 submodule.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.h b/submodule.h
index 6b52133c8..f0da0277a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -120,7 +120,7 @@ extern int submodule_move_head(const char *path,
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
- * a submodule by clearing any repo-specific envirionment variables, but
+ * a submodule by clearing any repo-specific environment variables, but
  * retaining any config in the environment.
  */
 extern void prepare_submodule_repo_env(struct argv_array *out);
-- 
2.14.1.821.g8fa685d3b7-goog

