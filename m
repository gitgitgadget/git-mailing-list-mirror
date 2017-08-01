Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15E92047F
	for <e@80x24.org>; Tue,  1 Aug 2017 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdHAQFn (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 12:05:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37386 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdHAQFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 12:05:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id 72so3023935pfl.4
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a64Wp4mTsrpZ+23uodljV6oISTZjORtMXHlvQpu2voI=;
        b=aJo814MDn/TnmXV7le7fj95rMc+IW8XQeB422XWYTkLuIKOjS5yJCPltyhtscVniTD
         CiWlnNZPgwINh3sw+8ce9VmDo5jw7iAjZOeqiPzaWjqwZ3U1VtBPinP7qCKGyBu/K36p
         XXSrlE3TgMn5UDwuVls7R+YoM1yYK+Rtiu6biEkxyTf0SF/mHM0Z9OozQKNg+cW+1OmT
         ti8whFNYciVODX/WeaT9r2zowebvqLy2lwjSpAEE/KMnQN7Vzeyoa7VKifKGyxBdnxvs
         EdzhcSgJoGqxGebydDD9aQvtd5SEqX/YzJMT/MgeycaugkAo6PBTO0eIBnCfKYSD/2LG
         amPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a64Wp4mTsrpZ+23uodljV6oISTZjORtMXHlvQpu2voI=;
        b=elq6V3S1KxyP1o/5BBOwWycWSE2iqHpZ9xCIjomzomJgVj/+ItiRMCDSNUeKzPzR1j
         7JpXpLCKX8W5S9h3uXIksxpuf//rnUQQo4gSYb28rgz5RFq9USfDNUCjqDvj0GBLqz2e
         IQvMrMcISh98EM123s6L5Ne3mfZ5l7EboGetTSisKejgrZumG1DfXpsiKcxHz9+PLPJr
         01aDZ+bfTS+qhlE/6BZm/TdcL8oB5DAooagPYJ9X3H5ovhlYBbaW3aqXFGfH5Ov+M4+9
         rRifv9VkuhJ5LsKtqPBcX3ghWnzqCIVxdw5oWQfjB96UEkJKxq0IKp2ZRoWRj55W/S2E
         gvsw==
X-Gm-Message-State: AIVw113fmegbkOGnsBDQw0izYUt1Scy35iaH9vUZG1GevFbA+sDXvTnU
        FK+uHT6eeBGTQg==
X-Received: by 10.99.97.209 with SMTP id v200mr19634684pgb.346.1501603541052;
        Tue, 01 Aug 2017 09:05:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.gmail.com with ESMTPSA id 139sm19599028pgh.60.2017.08.01.09.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 09:05:40 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH 1/2] doc: fix small issues in SubmittingPatches
Date:   Tue,  1 Aug 2017 21:35:38 +0530
Message-Id: <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the dashed version of a command with undashed
version and quote it.

Use double quotes to quote a git command for consistency.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..886fe3650 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -293,7 +293,7 @@ then you just add a line saying
 
         Signed-off-by: Random J Developer <random@developer.example.org>
 
-This line can be automatically added by Git if you run the git-commit
+This line can be automatically added by Git if you run the "git commit"
 command with the -s option.
 
 Notice that you can place your own Signed-off-by: line when
@@ -380,7 +380,7 @@ their trees themselves.
 Know the status of your patch after submission
 
 * You can use Git itself to find out when your patch is merged in
-  master. 'git pull --rebase' will automatically skip already-applied
+  master. "git pull --rebase" will automatically skip already-applied
   patches, and will let you know. This works only if you rebase on top
   of the branch in which your patch has been merged (i.e. it will not
   tell you if your patch is merged in pu if you rebase on top of
-- 
2.14.0.rc1.434.g6eded367a

