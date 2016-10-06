Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBCF207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 23:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935110AbcJFXv6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 19:51:58 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36754 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935057AbcJFXv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 19:51:57 -0400
Received: by mail-pf0-f179.google.com with SMTP id i85so15883169pfa.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 16:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VTT8cbezfSYd/w/KT1cTd5+r8WuxYS8xqFzSzHn7Kvs=;
        b=KWZJf23yy4vki5o0ZVA9F1GfAVjrpLUiXEWQ7KeVucll1SZwkvyvSmaEnMnbKM8MQc
         rNQCk+x3VmqMqDxhD4ACi7iKSzWR4W3VrbymXSXHkCvLOCosiHP/bGu1JIbrOe35Y9+M
         xkB6ahWjiHM0lZMrY72vN3ogChWLe0y6Qxsk1Uq4uaWRpYeFpykOIXxQU+5qADULzXv6
         nDQXcYxlh+3MBduMtkOgRobWRwfSmxyk5nEp2MuAv9//GsVAkKK2udjbh8tGI3nHgKJ+
         SXo8GlFqI0UTZh+xq9wBhnsPYBvoieHYUBWofd2ELG3jgUX2PpKgbsiT6nsDRvZkezrg
         k41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTT8cbezfSYd/w/KT1cTd5+r8WuxYS8xqFzSzHn7Kvs=;
        b=b1zUBnISc73TJhT+ySpjyE+pcjsUUzs+EXPavEKTh00oFP+pRWZYbD3nW65eXZ2IlD
         wqCuS4/a2alMFccOgSlCrA+R4jo6S0RB0+DHsru6prNM73AxAgz97NM4DBLLtBfhsdjK
         7XLovXZKof0PXpkekJG8q+66E+ISA1ZskBQBtEMope3iYIbRayh7fHObPsJ6YakCOLnh
         CGyVQoSwKHEV0Vs7N7sYZepMiBl5b6I6BK2CMTIRXMY+nvohbY0dvd7sFEnaRYytUhCm
         jGLu/im8Hf/hf0irg3o34ZhgHuP/5gChT/WMV0egFUVHM/Ua5GefEF3xq3/x1nMXauIr
         7/3w==
X-Gm-Message-State: AA6/9RnNjXRBRhS/Sy7Sk3/FwN5laU7/jiXLC2N83rvPIhDj9LG3J3IfsuzdPzsqJb0pdg+3
X-Received: by 10.98.32.209 with SMTP id m78mr23101044pfj.45.1475797916329;
        Thu, 06 Oct 2016 16:51:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9975:37b1:c0d3:285b])
        by smtp.gmail.com with ESMTPSA id b197sm8506296pfb.52.2016.10.06.16.51.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 16:51:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] documentation: clarify submodule.<name>.[url, path] variables
Date:   Thu,  6 Oct 2016 16:51:49 -0700
Message-Id: <20161006235149.10232-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.353.g1629400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This was raised in the discussion of 
https://public-inbox.org/git/20161006193725.31553-1-sbeller@google.com/raw

However this can go as a separate patch instead of adding it to the series.

Thanks,
Stefan

 Documentation/config.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e78293b..1f68d05 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2812,11 +2812,18 @@ stash.showStat::
 	See description of 'show' command in linkgit:git-stash[1].
 
 submodule.<name>.path::
+	The path within this project for a submodule. This variable is
+	kept in the .gitmodules file. See linkgit:git-submodule[1] and
+	linkgit:gitmodules[5] for details.
+
 submodule.<name>.url::
-	The path within this project and URL for a submodule. These
-	variables are initially populated by 'git submodule init'. See
-	linkgit:git-submodule[1] and linkgit:gitmodules[5] for
-	details.
+	The URL for a submodule. This variable is copied from the .gitmodules
+	file to the git config via 'git submodule init'. The user can change
+	the configured URL before obtaining the submodule via 'git submodule
+	update'. After obtaining the submodule, this variable is kept in the
+	config as a boolean flag to indicate whether the submodule is of
+	interest to git commands.  See linkgit:git-submodule[1] and
+	linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
 	The default update procedure for a submodule. This variable
-- 
2.10.1.353.g1629400

