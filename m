Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A6AE92706
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjJEOiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjJEOfU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:20 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F79ECA
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696496531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd9K0fOXysS/d+/E+0LZm/bHCFNctO6TorMWObD1REw=;
        b=JuXqgIWI2CsvDHr/Naf+pR4qLTkapkYZ7UCurNhYGFAhUYYyY+Z/Dl2recpNbbXz73AJTe
        JL/ITVTkgmIpF7Hs8+cnW6gDEIjQUIDJQbB7JV50eO1AVkWjsCUftuF66FicvVRnSiu11I
        JEY/qdM0tcUT8L+Gl9ZXWCENmhkMGbdw1QpdMph4B9aZ2HjfLtRP4Q0jDZQ0qng+VtR172
        R96ccj3D/zqmPJdIUHX1EhDK37vTOIDJGGLDocKv5aUDoL1p2cCaOVfBeGr1I6Jj9o4sKu
        1jYr1HDvHWvxQqrrGXROgmVVHLA/GoCp41i2861QzO2iHohcn4GY4wFS+fDpuA==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 8d14beb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 11:02:11 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/5] doc/diff-options: improve wording of the log.diffMerges mention
Date:   Thu,  5 Oct 2023 11:00:52 +0200
Message-ID: <20231005090055.3097783-2-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005090055.3097783-1-stepnem@smrk.net>
References: <20231003082107.3002173-1-stepnem@smrk.net>
 <20231005090055.3097783-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the grammar ("which default value is") and reword to match other
similar descriptions (say "configuration variable" instead of
"parameter", link to git-config(1)).

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 Documentation/diff-options.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ee256ec077be..48a5012748dd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -53,9 +53,9 @@ ifdef::git-log[]
 -m:::
 	This option makes diff output for merge commits to be shown in
 	the default format. `-m` will produce the output only if `-p`
-	is given as well. The default format could be changed using
-	`log.diffMerges` configuration parameter, which default value
-	is `separate`.
+	is given as well. The default format can be specified using
+	the configuration variable `log.diffMerges` (see
+	linkgit:git-config[1]). It defaults to `separate`.
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
-- 
2.42.0

