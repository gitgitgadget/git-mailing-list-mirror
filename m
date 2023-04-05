Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03160C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 02:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjDEC3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 22:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjDEC3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 22:29:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA74C3C
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 19:28:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so1434301wms.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 19:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680661710;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uCtYJP5gq5ejrPj/lTUjz5jZzyhLqOufgaWpwPxjIpA=;
        b=V/kFHX4W5IXEa7GwNwUoYnYYGtGUWp0JHno7rnzAcV4XnRykk7bcPF3TAlV90xDVbP
         2xF7Gqq5z6xOfn8nW23KzOGn+0wRj45oXfuSvDMvosTa4wBWk2T2niTdL16eBpsb3KXb
         HZoIpK4VUXAYFf0B+Ogf1iNv81xAUDY7h7++dRJhLKxasjXetywnm2VOZxBYH4Ptxqcb
         Clkf04ES1EN4p534PASTMHOSk+dZb654bGxrLJJBYo8M/+MCxDE22UskZ3MC2LpS3kyy
         zVblCco0e1bHZnJpLfSOYocx7VGVJe24h352KnqcdfQdrXnlMifpnaJSvveYx1I83qtv
         JaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680661710;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCtYJP5gq5ejrPj/lTUjz5jZzyhLqOufgaWpwPxjIpA=;
        b=EP0qve5Fe7FWDD74ciRaMranTLL7GeOxRQJ4ff05UAIvAumptCnnIbB4IDLxGREPhv
         VbiaYD8QOjeWt1jO9UWUXE4q7kVsi+JS4mthAr8+btYO+cHDzUcKDZuiEl91bCiCAZ0v
         WAtrKZeFqmeKdZo6rUv1VZQk7ljQpC/Ym0w4rjTqTvJ3D1+cG7FFO8zkPpG9FxzfirTB
         7InE8mVPR+9uDj0wGulDUqs8KMCO5x24I10llXu5aT1Vmj24jpcmvILdzMp8IL19IDL5
         ldPSrUg61xNQ6PwuCYzcM7VW9VRhB3NCTCP7iQ+C069p2kQdgHmTGPoSbap+GVj2LhNV
         2gSA==
X-Gm-Message-State: AAQBX9fC9NWInoxqCOtm+QQ/lZil37ZNYodizRVN4gjOLD6PgPop/z20
        fcNR8/uy5bGkdi19QkPO/GSfX936qkU=
X-Google-Smtp-Source: AKy350ZbZVKxrDHCOSEBCh4jHg5RZ0fsOX8Lrh2aWnVTtFEuuGZQvodHvOo0t+GED+73jMDEh/S+Xg==
X-Received: by 2002:a05:600c:d9:b0:3ed:b349:e473 with SMTP id u25-20020a05600c00d900b003edb349e473mr3384748wmm.37.1680661710480;
        Tue, 04 Apr 2023 19:28:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003f04f0c5a6fsm604284wmi.26.2023.04.04.19.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 19:28:30 -0700 (PDT)
Message-Id: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Apr 2023 02:28:29 +0000
Subject: [PATCH] MyFirstContribution: render literal *
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Emily Shaffer [ ]" <emilyshaffer@google.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The HTML version of MyFirstContribution [1] does not render the
asterisks (*) meant to be typed in as glob patterns by the user, because
they are being interpreted as bold text delimiters.

[1]: Search for "pattern" in
https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

Signed-off-by: Linus Arver <linusa@google.com>
---
    MyFirstContribution: render literal *
    
    Hello! I'm Linus Arver from Google. I'll be contributing toward the
    libification efforts in the near future. Meanwhile, I noticed a
    formatting error in the HTML output of the MyFirstContribution doc
    (hence this patch).
    
    I am also the author of this old patch series from 2014
    [https://lore.kernel.org/git/1407518960-6203-1-git-send-email-linusarver@gmail.com/]
    and am happy to return to hacking on Git. :)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1510%2Flistx%2Ffix-doc-formatting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1510/listx/fix-doc-formatting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1510

 Documentation/MyFirstContribution.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index ccfd0cb5f3e..9c64bf58757 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1164,7 +1164,7 @@ After you run this command, `format-patch` will output the patches to the `psuh/
 directory, alongside the v1 patches. Using a single directory makes it easy to
 refer to the old v1 patches while proofreading the v2 patches, but you will need
 to be careful to send out only the v2 patches. We will use a pattern like
-"psuh/v2-*.patch" (not "psuh/*.patch", which would match v1 and v2 patches).
+`psuh/v2-*.patch` (not `psuh/*.patch`, which would match v1 and v2 patches).
 
 Edit your cover letter again. Now is a good time to mention what's different
 between your last version and now, if it's something significant. You do not

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
