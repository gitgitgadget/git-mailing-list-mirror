Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA7520951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbdCQRXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:23:34 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32775 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdCQRXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:23:05 -0400
Received: by mail-pg0-f43.google.com with SMTP id n190so46310684pga.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h16Je9cEBlQg5jirec0BvTuUEzxXgp7pxq3a0de7KcE=;
        b=SnAQtb3aEHIHC6Yw2o8nvkZNTkAU1YP1tKfOhTiqJBXNbgArPTQPQulF0mHiKEcuf8
         Y793q7BIzbTezMBUoyTUc+e8HpqxgRXRUJsssmY0zud1c6bfayBFkgp8OvC36wRfiaVH
         M+sYbTIRHHMiu6iblB9JLRBFlYHLhjZHYtXH03MgED9XgbryYdDJJskiA7V3UYNOLftK
         f3rkRa9KO6SIk8yVlZ/KYJ8A7Hu5jlGz0qXznd5kbHhfRlXuW3FRIjHpWrsHlNZbc+Y2
         l6EmgiYGA2oI9AaHADYE8hde9EEENO1aZobIjqTMx1QENOIkzqCLbMZhh0ehXrS7Retc
         jTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h16Je9cEBlQg5jirec0BvTuUEzxXgp7pxq3a0de7KcE=;
        b=jjIg/LwVg0+1LQa8r/9Dj3Y9gr/1shLSuhbrrF1wtJD0Wyq+jmv5W9UYa6XilwfN+J
         HmE4ocLM7ECrBxM32XLw+yJ+lLe1xY8vHhOYLK9L4Z5HZzEMCNjv3zMCtGkjKm4K/d9y
         SD/GxBpLWuUaDjlY5jZcAz+y9nirM1sarsXumxslKSI2B8XCn5wf/rLyC09RTXDqhWxD
         xd669vhXnoHiqAwPIXIfU3sf3WSJD/XcMg3B2SJq23dh1wZAU60KD4LxkOe3nIUOO+gZ
         mt5YYzW6QqodPBukLH0BrzLMCjLTOx4Ot9VLw3bF/FPgrSqMZzO9UGmDjJg1tQD3NWOD
         LwZQ==
X-Gm-Message-State: AFeK/H19ho74Uoj/Ethdmr72Z1a9G/hlAZ4zM+ecNw7wp17dlHn3JsIkGARsDEDVcRq4E+uJ
X-Received: by 10.99.102.134 with SMTP id a128mr16861391pgc.215.1489771383820;
        Fri, 17 Mar 2017 10:23:03 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 197sm17978861pfv.19.2017.03.17.10.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 10:23:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v3 1/5] grep: fix help text typo
Date:   Fri, 17 Mar 2017 10:22:53 -0700
Message-Id: <20170317172257.4690-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317172257.4690-1-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9304c33e7..4694e68f3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -979,7 +979,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
 			    N_("ignore files specified via '.gitignore'"), 1),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
-			 N_("recursivley search in each submodule")),
+			 N_("recursively search in each submodule")),
 		OPT_STRING(0, "parent-basename", &parent_basename,
 			   N_("basename"),
 			   N_("prepend parent project's basename to output")),
-- 
2.12.0.367.g23dc2f6d3c-goog

