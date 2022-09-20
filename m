Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB8C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 02:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiITCqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiITCqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 22:46:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38B5850B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:46:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y11so1565673pjv.4
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=anm2m2VYecmeyONQ1yJxrmVtWndtbCRy2ebNG6aycv0=;
        b=6An6CtwlqW+jvzYoYlsNCCdwRArPGoE2KDMv9Q3V92K/q3VYZMZCJvoGGEKEm9ppuG
         5qfqse9MV4Hc6tPV4IT8VsbJQhuI9FJQ+/mq+jXh7TTb+0di7uZ0jCeFLvNtvhv1lOvI
         tDmPSdXWzIqZgwE0tFLrDbjvfk+kwZ6aQ+Ty/UdgvloKO8o4568yGFii48FxU2iTcY8J
         pWsVEDbocnqrVfkXgZj8Le5bdUUbCLtdU1l0p15UB/CvzC0/G8kIb0/9K/+d23H5UbbS
         hLJBY8aG8BN8F2uaQDHTzbGrv2nQEsSoDLAt+7t56M8v4W3DyeLc/aBk+1U6SzFGwK+c
         673w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=anm2m2VYecmeyONQ1yJxrmVtWndtbCRy2ebNG6aycv0=;
        b=y5XFH/SVLp21x5EB/hktjF6KVVJggPtzfQOhKnxss8eVcOn0atraC+oV7JRJyhkAAD
         e4ZJPvKX9ZC45BdK7vkugSXc8OnW+SIUv22JeXqR7pvPtqWKzHl1z7WhkdaqmPuq57Ns
         v56n2s8Dh+Otb1ndDCFyd0kzKIVw/qDwmSGNO4epQkTqVWO9ioqsEXLsMAI1zp2ncWYL
         CI8zOSsRvB4SpA0/DFyYblscWd037sHqBwq1/31uBpNpA6V0TFUSpPOOcKO1Hywnu3R1
         fgIF60SE1dW/Hj1MRAuU+AHPTnJ1SqGCVUswnxWm2fWCqHlvwnzvd+vwGdAxWvl6zcUJ
         U25w==
X-Gm-Message-State: ACrzQf27rF+81YL9J8xfpis79ACyqbTtPwqnjeVrgU+w2h7tc/rs8ICO
        jiEP7eEZgr8oRwICPJb+QlgHqlVqOMgwlHFk
X-Google-Smtp-Source: AMsMyM5RVtje2rtNttPz8ZBN0j8r3S1mx5iaJOqlKWBnTb561LHug1CwWjfTgzbUk6B0urjWKsDMtw==
X-Received: by 2002:a17:902:e891:b0:178:7b6:92db with SMTP id w17-20020a170902e89100b0017807b692dbmr2802734plg.160.1663641997433;
        Mon, 19 Sep 2022 19:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:a972:1d85:8e93:c538])
        by smtp.gmail.com with ESMTPSA id m14-20020a62a20e000000b00537aa0fbb57sm146471pff.51.2022.09.19.19.46.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:46:36 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH 1/2] Documentation: clean up a few misspelled word typos
Date:   Mon, 19 Sep 2022 19:45:56 -0700
Message-Id: <20220920024557.22889-2-jacob@initialcommit.io>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920024557.22889-1-jacob@initialcommit.io>
References: <20220920024557.22889-1-jacob@initialcommit.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Used GNU "aspell check <filename>" to review various documentation
files with the default aspell dictionary. Ignored false-positives
between american and british english.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Documentation/MyFirstContribution.txt | 2 +-
 Documentation/MyFirstObjectWalk.txt   | 2 +-
 Documentation/git.txt                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 1da15d9ad4..1a4be8ee0a 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1160,7 +1160,7 @@ all named like `v2-000n-my-commit-subject.patch`. `-v2` will also format
 your patches by prefixing them with "[PATCH v2]" instead of "[PATCH]",
 and your range-diff will be prefaced with "Range-diff against v1".
 
-Afer you run this command, `format-patch` will output the patches to the `psuh/`
+After you run this command, `format-patch` will output the patches to the `psuh/`
 directory, alongside the v1 patches. Using a single directory makes it easy to
 refer to the old v1 patches while proofreading the v2 patches, but you will need
 to be careful to send out only the v2 patches. We will use a pattern like
diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 8d9e85566e..eee513e86f 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -534,7 +534,7 @@ the arguments to `traverse_commit_list()`.
 - `void *show_data`: A context buffer which is passed in turn to `show_commit`
   and `show_object`.
 
-In addition, `traverse_commit_list_filtered()` has an additional paramter:
+In addition, `traverse_commit_list_filtered()` has an additional parameter:
 
 - `struct oidset *omitted`: A linked-list of object IDs which the provided
   filter caused to be omitted.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0ef7f5e4ec..0c15ef3a8e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -344,7 +344,7 @@ Repository, command and file interfaces
 
 This documentation discusses repository and command interfaces which
 users are expected to interact with directly. See `--user-formats` in
-linkgit:git-help[1] for more details on the critera.
+linkgit:git-help[1] for more details on the criteria.
 
 include::cmds-userinterfaces.txt[]
 
-- 
2.37.3

