Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6DA1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 04:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbcIHEe0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 00:34:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36655 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcIHEeY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 00:34:24 -0400
Received: by mail-it0-f66.google.com with SMTP id i184so3389041itf.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fSwNrDzaFzChvsuF6dl9V7+I9rj+oGInwZwvXVk4RM4=;
        b=diZgH4PTt/QkYftrmKxwMIOiHIkm4rDGSoFlEpTKpRl+km3vbcoK2SKEey+yEIiVkF
         7YXYCZpKHN+4iYqtBlXMdP0cKzLbjRtEN7Oqplczz4pjjttt8ogZwVy7M8GXoApflKGG
         Kqr4dz5McYTKdkm6JgTp4fzKUCQRRK8bwN8PKCHdsvZbbltXn5lSWb0/27ITwk7BtToe
         VuZhiaxQYKh1kbRHAZKCFu+6txuJ0GZmIs2ZbREc8Si85dL7UCNqd5xmxsq94UeItemd
         Y2A3H6AnMluCdwnaQtF4VcHUdRdYH1kqlXzOQuduIIcFmRrguFrpqwgvKUk4/PoBRnDc
         jxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fSwNrDzaFzChvsuF6dl9V7+I9rj+oGInwZwvXVk4RM4=;
        b=ZKm+k06cVxBvL86L34cvZxNN3GnHF6IIsvf3GZEMDC4AC/s+ZHANO+tACB9KFvc/ww
         m6BiyQ1WJSaqiB8oFV8/0Fp6sooZFfmLcFhCUFJbnQ/CJSae/HyuseampesZUg3nVP8E
         mrChzIGC+8yGcvXW2WZJGgd/fjreytD5MKtigQknKpU/u2BDU8sc3faxmdCFKp478Qfb
         Mj2OeoHavb4Sw0CI3n48/MI38uekU5qXxxYyEpb0p5Ilf+kltFgDtqfEgr8kXHRi/qLg
         9SsTaCzXAAnc9z/oCIwnsjv1buj30B6qec2QTbYgjNHlXgqNo95GOWTXq1RN4CmexJ5B
         nhwA==
X-Gm-Message-State: AE9vXwN9mPqOvOK+DXFn+lX/zQtIbwwvrZcuMJxfR4xh44kXSTT9cfocn5A1P3zUJiAoeQ==
X-Received: by 10.36.204.68 with SMTP id x65mr12361493itf.54.1473309263490;
        Wed, 07 Sep 2016 21:34:23 -0700 (PDT)
Received: from wolverine.localdomain (c-67-182-247-84.hsd1.ut.comcast.net. [67.182.247.84])
        by smtp.gmail.com with ESMTPSA id v69sm5511246itc.1.2016.09.07.21.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 21:34:22 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     Matthieu.Moy@imag.fr, gitster@pobox.com, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 3/5] git-rebase--interactive: fix English grammar
Date:   Wed,  7 Sep 2016 22:34:17 -0600
Message-Id: <20160908043417.5946-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e558b0..6fd6d4e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1082,7 +1082,7 @@ If they are meant to go into a new commit, run:
 
   git commit \$gpg_sign_opt_quoted
 
-In both case, once you're done, continue with:
+In both cases, once you're done, continue with:
 
   git rebase --continue
 ")"
-- 
2.9.3

