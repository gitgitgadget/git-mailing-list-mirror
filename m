Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0623207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdEBEBe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:01:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34567 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdEBEBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:01:25 -0400
Received: by mail-it0-f65.google.com with SMTP id c26so544332itd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llPVJFQ0taI/ZQkxFQ6emgbN8BzEbF87r/8g0Rmnt4I=;
        b=lNPsvmHfg143Lke9HPvLYF5OVW5GYtqQKl65VRWSRfj+hrFjsF7MN377X7pP5nbnRp
         XnAnGBW5Bsa2zZQtYTOMjW5k9nPFbr0k6WTKyQRl2+6/lg7gk7z/5r15rE+QKJTlekwP
         V+YXIx2GRdRanzlNeSgZTr9W2Mjv+3QSGwCiUmBsIOREfvi50ewwTiZdcKz5fgMmat4x
         UQ0KQyxPdDv2gWwy0MMoyKszSm05Yy1WZZyOW/JNYcZzK2iFMwvIUBiX70y2/JbEDWXf
         iUG5S7marYwbrZLQGykBop4SXs2ctITf15aUiQ1IekICGxpjKBQp/8T4h0uwiggav/+K
         MPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=llPVJFQ0taI/ZQkxFQ6emgbN8BzEbF87r/8g0Rmnt4I=;
        b=NTDSRgi9Vx2y3ROX/g+irXodLt2Xb6gPf7ohcGxijsky9IVakdeX6ZPHjN7jo7bJV9
         9X/YVLSNfP1CdK17uhXf5n0FH9G5gCnwoyBO+uqklYBYitJKJfUC+TfY5p/nK5DibeNP
         DmxhPMRIIXmdYKtGn4wDKUNj3/MW6QYbW3eHn2B3DkpNjQBsepAepeG5uDs5uaFV9fIw
         IwzQWK/BmEdqbDIZ3LFSjsSwMgK9VxcIBFkS3qRcfZNfET7IG/4gTx9GpXM8d9tHVI5t
         1q75mygQgd/UEu0jFcUMVCfQcIpzxn365C7NxmZOxkg5LN5a7gcgmjR45508RHZ+tvUn
         rhpA==
X-Gm-Message-State: AN3rC/6KAyihUyX1dcLA+xkS/vq1KitPqCQHAP79jj/ZidBT/JGhdmPl
        J+r5tHtPc4sFVg==
X-Received: by 10.36.79.80 with SMTP id c77mr9623149itb.53.1493697685096;
        Mon, 01 May 2017 21:01:25 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id p65sm7211762ioe.3.2017.05.01.21.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 21:01:24 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 5/6] Documentation: use preferred name for the 'todo list' script
Date:   Tue,  2 May 2017 00:00:47 -0400
Message-Id: <20170502040048.9065-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170502040048.9065-1-liambeguin@gmail.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "todo list" instead of "instruction list" or "todo-list" to
reduce further confusion regarding the name of this script.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/rebase-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index 718721000031..a9b1d496e63a 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -21,10 +21,10 @@ rebase.missingCommitsCheck::
 	--edit-todo' can then be used to correct the error. If set to
 	"ignore", no checking is done.
 	To drop a commit without warning or error, use the `drop`
-	command in the todo-list.
+	command in the todo list.
 	Defaults to "ignore".
 
 rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for
-	the instruction list during an interactive rebase.  The format will automatically
+	the todo list during an interactive rebase.  The format will automatically
 	have the long commit hash prepended to the format.
-- 
2.9.3

