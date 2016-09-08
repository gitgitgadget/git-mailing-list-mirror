Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE631F859
	for <e@80x24.org>; Thu,  8 Sep 2016 04:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbcIHEds (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 00:33:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33867 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcIHEdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 00:33:45 -0400
Received: by mail-it0-f67.google.com with SMTP id e124so3412394ith.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 21:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pu9vT3STPZFBi4+Uw0hNvByMCYDG/x0yt7kMTt54yVM=;
        b=go1vTiOYaRsRrj+USda0GnXQwbQjRNEKYX/Sr+JFfzfDWsVOkpnNvaTVY5J88KC0Rk
         KyE1YqJxJ8k5Jt9hZzAwAZhXSKBDYv9XZMhAB0meNYDksWpcF4AwNgXwv9knoVoPMrYl
         tFA9EKqFpN3PpVnPbCsURmeHMkSvzEZxkrdtYZblQvOOevW83Pi6tE05PkrrMBafL+eY
         GDt8yU2CYNXOYMxbmJ/7x/8A90BgF/puDi2KD/fpa44Xs7Gb7VJM9HEhEctHzADyj24P
         J8Me1WJO4job/IbFthbgQW2zh4xy2sQGZr6EQzT89fw60e5pdYYtfNdxo0uhMUqXMjnP
         SLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pu9vT3STPZFBi4+Uw0hNvByMCYDG/x0yt7kMTt54yVM=;
        b=j4BRBIOWZ+VsUcWqC7sw2XAs5Mr8DZMjmqT1IDjklCZ+zJoCl8dARrSP/aO53p6S+n
         qcYDh+CxBPXS9/fJlVGQ1a6ecfUcs1q1JYewSyRTbqITk8E/V+6ZObIRrFXQkOF04od9
         IMywy9galM4qNZ5uW46+vaoPEo/U8H0+IHlYRGY5MJVUjxN42gfqzosgi/27sBzzv93G
         DajhMPTCXWobocjdAoPb3/088psZB64ASUGwRb9n2nzswgZm+VszO6/a3JqpLpoPGXcF
         1E+Ji/QhxYUm42wK0+BAVOcUAPG2su2U5Knwuf7628F7RKaBOwn4Olbv44sSQAErK98a
         iaHw==
X-Gm-Message-State: AE9vXwOIJCJUgI7EnYS+816PlUUM9Qph90gYZTRZBw9ouMUfRyz2YP4rAwDMzH/RjX9FgQ==
X-Received: by 10.36.64.142 with SMTP id n136mr11440725ita.16.1473309224430;
        Wed, 07 Sep 2016 21:33:44 -0700 (PDT)
Received: from wolverine.localdomain (c-67-182-247-84.hsd1.ut.comcast.net. [67.182.247.84])
        by smtp.gmail.com with ESMTPSA id j76sm1253199itb.2.2016.09.07.21.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 21:33:43 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     ralf.thielow@gmail.com, pyokagan@gmail.com, gitster@pobox.com,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 1/5] am: put spaces around pipe in usage string
Date:   Wed,  7 Sep 2016 22:33:08 -0600
Message-Id: <20160908043308.5814-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the style a little more consistent with other usage strings,
and will resolve a warning at
https://www.softcatala.org/recursos/quality/git.html

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 739b34d..9e2ae5c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2222,7 +2222,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	int in_progress;
 
 	const char * const usage[] = {
-		N_("git am [<options>] [(<mbox>|<Maildir>)...]"),
+		N_("git am [<options>] [(<mbox> | <Maildir>)...]"),
 		N_("git am [<options>] (--continue | --skip | --abort)"),
 		NULL
 	};
-- 
2.9.3

