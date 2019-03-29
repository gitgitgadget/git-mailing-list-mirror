Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6B220248
	for <e@80x24.org>; Fri, 29 Mar 2019 17:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfC2REb (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 13:04:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41879 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfC2RE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 13:04:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so2629168edc.8
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=fcTtks+TjHyVarANa88J19vauZ4xiMMat162uUpAL+UtV4B841vQ7Zqg90/WxghdxB
         IPEdKB7aJ5TbKu7fkCGKF4vQCNL/7MGSb81v7DQiHco8yBh52G+TOaShocMz6VPnunGZ
         jT/wh+CYJgsQ7MnQF/WrNDGgtR8yDH4B85SYxyRH1CXSc7tFCmWn8fXzYHVBxACGZT2R
         KY2S3qmbxGrNkzQ3eO2+3dh090/5dUr5r9uAHQ8qqcYJqpIiE+gKlCfP34CJrWVE0+1B
         CPlq5qvkp6LdmUccwjBOXzc/c3DoFlLTzNB/yNUL1fE9TmmiN42oHw4e0VXVox2jRl5O
         j9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=Bc+3qic0Y0DcdV1oFhgA/hX6/JvojUqfNM5rhdM190L/Zvv9SxJzTKbWDvi29wEgAo
         e5Ze2HICUYmr/5+fEQVgEo3iX2CJIGEOac8eT4nRcAmYSAsrmdtwL1rDi+LFlEsbpU3j
         aFH2hbu1MTybIOedcyN/XDYlRhLsZf5vVGDBrotP4DIm8R1Rc+5fE9Rx66ldQjWW1iZK
         X24b01lVE0s13OJgT50cHAc2ipP1KUPxs0uKsnb97qPNL3iDGNdYv4/DnDow9FrzXaOb
         xIRD1TQwB3HjGlbeoolj8JtfpBmLhx+rdx3f1OcsG9nROuDAY3aly63iH1sniII78++i
         K9qw==
X-Gm-Message-State: APjAAAXzxL6OUsM7eC/UJYZBsDZGctqlmtf3R6aN8gdaqcCP6dnrFXqL
        UqjqxTkL1CHDhpokHTTosuP+2EZ6
X-Google-Smtp-Source: APXvYqzrOTSTYWQtxWQUH4tt0OPEeJlFyj78jGu8SQllyAJ6mTZvdTccpeZvL9GiKSJadXiTM7e7Ow==
X-Received: by 2002:a50:92b2:: with SMTP id k47mr31236957eda.148.1553879067810;
        Fri, 29 Mar 2019 10:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l44sm796437edb.37.2019.03.29.10.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:04:27 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:04:27 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 17:04:19 GMT
Message-Id: <d4023acde7172089615ea5abd4e91ef90c1791a7.1553879063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v2.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
        <pull.169.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/7] trace2: find exec-dir before trace2 initialization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to resolve the executable directory before initializing
Trace2.  This allows the system configuration directory to be
discovered earlier (because it is sometimes relative to the prefix
or runtime-prefix).

This will be used by the next commit to allow trace2 settings to
be loaded from the system config.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common-main.c b/common-main.c
index 6137af0e63..299ca62a72 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,12 +37,12 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 	restore_sigpipe_to_default();
 
+	git_resolve_executable_dir(argv[0]);
+
 	trace2_initialize();
 	trace2_cmd_start(argv);
 	trace2_collect_process_info();
 
-	git_resolve_executable_dir(argv[0]);
-
 	git_setup_gettext();
 
 	initialize_the_repository();
-- 
gitgitgadget

