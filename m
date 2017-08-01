Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623112047F
	for <e@80x24.org>; Tue,  1 Aug 2017 16:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbdHAQGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 12:06:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36270 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdHAQFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 12:05:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id y129so3291041pgy.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r50foqqRWma3ls3/o2FFNXp/tSgPFNIuek6eoTkZb1U=;
        b=FambwQTZcdvnq5O4qsEjOaYMoyp1sLwDzsdoZ4clz3293yfpXLIDtB2Dr/rCNp3GrV
         cY0fF6MqqsAx82aBKFDyf7qbEJK5AgSgtYouCWL3RXFcpzN52AXv7HY0cLku/L3Frng0
         6yoUusgjwgK+KvoFqgfxiQyp/67HkBS18jND4tJIZKGDzwMrj3XOM49rdFDdwXn7A79M
         BLzEuo+VNSjOVjg6kCxTzNA9yi5a0U7vXQV0UOCOfw7B8rCxoKn9PclBqLc5SVJOkspk
         +2LrBbqFxaJcaj1BA/uuk14OSV1pKjw3TAlKDAMSFBiMv5W5qfYRxTe3pE5EoK+DhCSl
         li1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r50foqqRWma3ls3/o2FFNXp/tSgPFNIuek6eoTkZb1U=;
        b=kt4jJbc8SQs4dUBy9UMosKb0OyGa21vKhUAjQBDXOWCRqTx669LVw3Gdy35J/lpK2L
         C0AbwH7CamwaM/o0pU9aEHUoVXz8OL/GQF39Pyq8P/q3iTHt/RfxyRFNhIt5f2FnLuDL
         YJy42YN0r4bJdzLEDhW/GTsHoWgU7Yi/KLKLISBv50vPPhVCXrKI8PD1Z0+57L5p78CX
         zgusepbliu5eeSlvbqMyI+4FtV2acYEQxgBxgUglQ1/F/nqLTushUufBpfMZqVj3btFH
         ud9tsanEnLUhOY1rZnyZHw/vtocKqC7i1GU5+uyuAJLGnUFn7l/r/0pOaqzSfukjcDgO
         qM1w==
X-Gm-Message-State: AIVw110ZTO7YV+gFplNgbjBdBH9v4gN5Iye79Vv6V2twewmsz+1XWn2Z
        jeR5wLklOPuWOw==
X-Received: by 10.98.66.136 with SMTP id h8mr19441495pfd.54.1501603544045;
        Tue, 01 Aug 2017 09:05:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.gmail.com with ESMTPSA id 139sm19599028pgh.60.2017.08.01.09.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 09:05:43 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH 2/2] doc: add another way to identify if a patch has been merged
Date:   Tue,  1 Aug 2017 21:35:39 +0530
Message-Id: <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
 <20170801160539.5587-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 886fe3650..7197709ee 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -386,6 +386,10 @@ Know the status of your patch after submission
   tell you if your patch is merged in pu if you rebase on top of
   master).
 
+* If you made your change in a separate branch (<branch>) you can use
+  "git cherry master <branch>" to see if the change has been merged
+  into master.
+
 * Read the Git mailing list, the maintainer regularly posts messages
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
-- 
2.14.0.rc1.434.g6eded367a

