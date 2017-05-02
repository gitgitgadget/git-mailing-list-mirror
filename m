Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0092C207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdEBEB3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34857 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdEBEB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:27 -0400
Received: by mail-it0-f66.google.com with SMTP id 131so543885itz.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4rg/d757+FMG4w4jeiArMb/FOnLw3As9bM6GVTLxK30=;
        b=EVN1n1MkkVOXACEchOG/kTI0zOwkpxWHjMg0Vci3hm9xLEhULVOmdGekU9IVrn3yxJ
         9YTrG2DBo+bZz+hfTf0L7URG4iaiukkvm3dwK9q0O86t44FiDMAkshzaNpO0Jbc02heo
         E4/a3FYT2lt3wKUHq9zmlAwOCwtGMTqoa5RSkePdw3CsKGCi9E6JIIoClHPktA1xBNvb
         Yyhv1OYwNNLkkZZidmbOekaYXUEtVjN7rq3gQ2MR1DZS5kfydWlMH/M/QFFuYHnMJxUa
         0nioiXkzoiZpYFauDQoJVw/ilnFPqkhTSJOz3sN4ZNYMUlFBpaJecARM8VxtZOi/Ad7M
         pysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4rg/d757+FMG4w4jeiArMb/FOnLw3As9bM6GVTLxK30=;
        b=SfdTgTFlS5YeAfNtD9ej7Tp6UsdMNZF/bx/KYLnzUrj1y681dNGlkSRxyapgJWFRDz
         na8YKI0PZNOsdC4kcs77ARDAMjJnpomVo5ZnIO/Ij06Rcn7wA3SC0qhumSUMISzIaicw
         toTmtqoQTtC1FBjE0T3S/uAAUDJ5rz7lUB1BAzX8dnTGUjNdj0Gut35zLRb7FUfYYhmN
         bvFhCAPCvKBz73KdYcihmKwQoZwgTo/VM0t17IA5jUShxpzDZ5345iZV1grt25mm0sbm
         kAZfowMj5EAcjJ2MWETBbztV9/IlMeGPgu5EHB5wdBGzBS7lKX8IsUtbOxYgdb3ywBs4
         hyCg==
X-Gm-Message-State: AN3rC/64p6uWWhwWCUiDeri0ZYyAWC+Fdai+tg7owVxpYu4ZgLLBtEHi
        QTsS9Ew1oidM+Q==
X-Received: by 10.36.25.140 with SMTP id b134mr9115049itb.110.1493697686556;
        Mon, 01 May 2017 21:01:26 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:26 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 6/6] Documentation: document the rebase.abbreviateCommands option
Date:   Tue,  2 May 2017 00:00:48 -0400
Message-Id: <20170502040048.9065-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/rebase-config.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index a9b1d496e63a..0f29b7d0b89a 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -28,3 +28,26 @@ rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for
 	the todo list during an interactive rebase.  The format will automatically
 	have the long commit hash prepended to the format.
+
+rebase.abbreviateCommands::
+	If set to true, `git rebase -i` will abbreviate all command-names in the
+	todo list resulting in something like this:
+-------------------------------------------
+	p ae6c43a first commit title
+	f 0694310 fixup! first commit title
+	p bf25ea8 second commit title
+	s e8fbbfd squash! second commit title
+	...
+-------------------------------------------
+	instead of:
+-------------------------------------------
+	pick ae6c43a first commit title
+	fixup 0694310 fixup! first commit title
+	pick bf25ea8 second commit title
+	squash e8fbbfd squash! second commit title
+	...
+-------------------------------------------
+	As shown above, using single-letter command-names better aligns the
+	todo list when full names have different lengths. Additionally, combined
+	with a large enough value of 'core.abbrev' (say 12), the todo list is
+	guaranteed to be fully aligned.
-- 
2.9.3

