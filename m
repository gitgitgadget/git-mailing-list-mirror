Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF7E75433
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbjJCI2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjJCI17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:27:59 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 01:27:53 PDT
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4CEAF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696321269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gd9K0fOXysS/d+/E+0LZm/bHCFNctO6TorMWObD1REw=;
        b=bFoTwnVJam3OnXDlzmhrZlPG1xrYjK1/WOY+wG+zjnadVzfZ2R893srP7Aj4FPnk08go5T
        4yED4tUyJZs8x2ayD/dXDP9a/vBCv4CGe6TikiBpr36eCbTnbQssPJD+eZ5EOUTc6cRXNC
        Kcm5amhfC1k8KSLB00c52wvFygDp6uzJE3nsjg6JjR5Ov59QCwkmH6iCj5mvDSJQL8EIsW
        On3aFScCoxWLvJj7mkUhavcF+qObnbf3KaPPSd9KXZv7vG8YdjVMefxi/2B6iI+MkwgCgd
        UsXrPJr96znMBqgGZRMh7enMg5PbM7MYqa6k2TWpLURVIdkLGC69Nhv7B9NABQ==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 2476d054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 10:21:09 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] doc/diff-options: improve wording of the log.diffMerges mention
Date:   Tue,  3 Oct 2023 10:21:04 +0200
Message-ID: <20231003082107.3002173-2-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003082107.3002173-1-stepnem@smrk.net>
References: <20231003082107.3002173-1-stepnem@smrk.net>
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

