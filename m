Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A488C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 00:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJDAza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 20:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDAz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 20:55:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B8357C5
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 17:55:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t4so7974362wmj.5
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=n5YnYs/Tr+81bgNNQR95XUvRE7vm5uPNaURZ9PSLebM=;
        b=PE1URSEhbBrrVFwxVkwGFU7roY0HRLXazSTV+2T386Oo5qjw4DoQ+Z6PEnBdkp2gsZ
         ef26s1m9o4QKfEsrWXz2GZZsAUCaCi8nhNL1JfWV6fYLqjaZe1ivE7L2csdDMTld/bb7
         eNXpvfhDz7/lTZGQvbgDONr9AINUY8zp9ZQ9CHH9cB3cn+9KHJDs0bb8j73eQBj7Pb3r
         b3CL/SAJhVjrxxOPXMrCxPtZxdqRVpLAzSS8GEKuxskMoBat10YqxV3rvhbJq/0nV0bT
         tZxKciru0dNTjV4s9C45/RWfEwY9qBkJ2uqEvCwv4PSTVIg/WOPtkelvzr9NJcO/Ry5I
         /70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=n5YnYs/Tr+81bgNNQR95XUvRE7vm5uPNaURZ9PSLebM=;
        b=Mtn2QHrCII29eLV1/rtv9bzD8T4wgFWRyrw4BY2C9O2EEfVLad80ugaWTKfbs6V99h
         Fgb/W7e50cLzSqY7DxCemyvjxJMxFLy5Qva25CkHNuO7C0F4WXI6o7wMEIg3plMotvrA
         zFR9a19eeEyisg9Ip3MIZE0dCZ6iR97bQiwssxfUUXP06bL1lVVlHf9HmoUhBGps2csF
         NqpPfl94+UhemS6IYnde63GeqZwQAsmAWQbV2656YrX7T/z7kcXC5LhOQsJeWx9dX17o
         7+rtjC4ru2mUrDBz3fEEpX7OudJ530WHYIhTBpw91534EvHQhYZDyXT9at5P7yQ5QQqD
         pT/g==
X-Gm-Message-State: ACrzQf3SXgAd3NCdts4fewr+RLY9ag3nBhTs58EGS7R9XJU4j2jRfYBk
        PxB9tM6s5G8eyZQLBb/iURQxmSb3u94=
X-Google-Smtp-Source: AMsMyM4P8Gu8JvBnEwcbDsDpOh6lQW1Ip7KIAL9brIx2pVIh25aYkRgYP7eJu01iwx4bNmZmhAEA4w==
X-Received: by 2002:a1c:7415:0:b0:3b4:6198:f71b with SMTP id p21-20020a1c7415000000b003b46198f71bmr8271452wmc.87.1664844925585;
        Mon, 03 Oct 2022 17:55:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b0022b315b4649sm10638911wrz.26.2022.10.03.17.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:55:25 -0700 (PDT)
Message-Id: <pull.1350.git.git.1664844924663.gitgitgadget@gmail.com>
From:   "Noah Betzen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 00:55:24 +0000
Subject: [PATCH] Fix minor typo in mergetool.txt: 'overwriten' ->
 'overwritten'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Noah Betzen <noah@nezteb.net>, Noah Betzen <noah@nezteb.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Noah Betzen <noah@nezteb.net>

Signed-off-by: Noah Betzen <noah@nezteb.net>
---
    Fix minor typo in mergetool.txt
    
    I only learned of mergetool.hideResolved today, and while reading the
    docs I noticed a tiny typo, so I figured I'd fix it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1350%2FNezteb%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1350/Nezteb/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1350

 Documentation/config/mergetool.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 90b38097002..e779a122d8a 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -59,7 +59,7 @@ mergetool.hideResolved::
 	possible and write the 'MERGED' file containing conflict markers around
 	any conflicts that it cannot resolve; 'LOCAL' and 'REMOTE' normally
 	represent the versions of the file from before Git's conflict
-	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwriten so
+	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwritten so
 	that only the unresolved conflicts are presented to the merge tool. Can
 	be configured per-tool via the `mergetool.<tool>.hideResolved`
 	configuration variable. Defaults to `false`.

base-commit: bcd6bc478adc4951d57ec597c44b12ee74bc88fb
-- 
gitgitgadget
