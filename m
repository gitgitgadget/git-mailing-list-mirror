Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8734C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 09:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbiBBJA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 04:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiBBJAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 04:00:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA16C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 01:00:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k18so37009708wrg.11
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5My0lSFjAIjMBlbKzqRp++UufEU6BqNcaklTLPXy4k4=;
        b=BbXDmlZYMx1YyI+nk91vgGvORRzfMIXIDFv+Z3+YeJjlk42sXx+8BS7lY9lC5sT9ve
         XLUS5URfGsq0sSfbIFDvZ/mc2dUyd0gLUH8wjGVRCItOqTO8fkX8AyvJsGXxETxc737U
         0e0NELWW9URrARKBZmMECeY5KadThldZf1vFeLhoZOCE0kyIp3/DSA0doMAsL+mbn3Cf
         qYTf5vurmRStefiHytDuyCYnhOsXnjYz1yjQeQzaNE/Vuq2rGRSMJwCScqWnbqPzIkeS
         /BrQU3uZmRmMA2nsAjH8JV4Dmf6soJZ1Wwru3gsVtA66C2QT1bsWKfxmvZ4rKlEFBrce
         QlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5My0lSFjAIjMBlbKzqRp++UufEU6BqNcaklTLPXy4k4=;
        b=nlBELtXu/JorxQ4TtLfWFg0SEyYQeDG0w1y/xG7KwQoJJfIORWqMFb4Y/r4GVkr9nq
         0KBFwH8vDP/Uk6KgiQSJxxAWbK5Llpjy/qY51lVTi28AfjvupMkF9S1o/e4A4dowbrx0
         +aC4nKlQ/9QS9X5uYXCgyn0ei0x5agAIgvUWKDgDri4XkJOzK+6TPjAHgdEz/a/LGraE
         KRYyDUM/08z2TYqCW/Iqs+U7FkfSv0lxmCCuO0hrYXDzK9QkLDnQnXyWc2f6elhT7jHy
         An0T7vqWCp2XkKTL09tZjObp1lf1receewwbschPDmP9Z7y6TLLbEaE0AlX0B78Yn0vm
         9JFQ==
X-Gm-Message-State: AOAM533U0Jc80ay+C+OMb2q7csyxq80ojFA0oilvG5LB5Y4KC41l0BZh
        rwOPyjqUavkxCEdcJ3vN1Ynj4AY1ulo=
X-Google-Smtp-Source: ABdhPJyz8NCPOHHUEJf6sSE1mQKQd//ezsficVkKMz+mLEew8VbrsSfp5zLcLSz55eIVAVA/YbLV3g==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr23985644wrr.235.1643792452006;
        Wed, 02 Feb 2022 01:00:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm17382177wrw.92.2022.02.02.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:00:51 -0800 (PST)
Message-Id: <pull.1207.git.git.1643792450866.gitgitgadget@gmail.com>
From:   "lgl via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 09:00:50 +0000
Subject: [PATCH] fix typo in git-mktree.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     lgl <liginity@outlook.com>, liginity <liginity@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: liginity <liginity@outlook.com>

fix a typo: change "as" to "a".

Signed-off-by: Liginity Lee <liginity@outlook.com>
---
    fix typo in git-mktree.txt
    
    fix a typo: change "as" to "a".
    
    Signed-off-by: Liginity Lee liginity@outlook.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1207%2Fliginity%2Fpatch-mktree-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1207/liginity/patch-mktree-documentation-v1
Pull-Request: https://github.com/git/git/pull/1207

 Documentation/git-mktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 27fe2b32e10..76b44f4da10 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -31,7 +31,7 @@ OPTIONS
 
 --batch::
 	Allow building of more than one tree object before exiting.  Each
-	tree is separated by as single blank line. The final new-line is
+	tree is separated by a single blank line. The final new-line is
 	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 

base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
-- 
gitgitgadget
