Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC3420248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfDOUjq (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35900 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfDOUjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so15266456edm.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfHH3UDNYOYd6q8G9jtn9kGVoshe/kczU9BC8hWQY7E=;
        b=FpMFZyzusatsip/Iaa9TmL8WaxqgFoMFHYdhVatgpqSQOmn192wtgeh7paVPsvOJl3
         /mzOA6xWzc7J+1ZjKLxEsqjrWA0mAHBLS/Icam+vHDC6jnBMsIKQ2bd8o81ro7gWqt/M
         OIaknGRIWhevz7uH7Uaxfk2ZMCSHPLlB83RSaNLZ59WrYECNyNH5EHLioowwZsBXsdDF
         wUSZAamR1F29nigZOAWaOU3Kh0b4FXU33bMtLOHY91SVvSunHaisbXyrmSiFXKaI1pGS
         oGU0Y2PgFgmCq0YcpyczFkwcq0+z4XlRyF1t+tVZ/s3psjcH7mDoSmfPhQEzQk+B3GUN
         qoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfHH3UDNYOYd6q8G9jtn9kGVoshe/kczU9BC8hWQY7E=;
        b=hr6QW+AlKeAtsQTYX5YEEs60UdQhTbhwSrLEYiLmrVIZ30PkyYRauDu7oCeZex1akD
         h6RVDVNxVJiTSxWvP2rq/ykLJT21PWSiLvH8FSccaNRwd9JqqGTW0C8iky0VxO2Cbz8f
         exEGEJMUXOQPU+MdKFNCPwtLFi4eGUkc7+r7IZMshyfa+Mu6rr8HrDknuV1pKfReP+F4
         u4l5NP5A8TjnaCLTR1Tvj/I/Uct2v6OC9R3ZBDUsMLf8YRxOfO+YEN4QximKl6LMvJLb
         uZ2pVnuHVdznaI0c+X5r7j5Gk3uyDnEhtY3ax4QerpUeVHhq1R2RGFT0xPMBhETK3M7f
         /S/A==
X-Gm-Message-State: APjAAAXKMarNlz0bw3jkQWfAPfVNsbdkDLszSd4Gh5lIceVJuAXzDGKF
        20jBCMqQ+xZCLdHXGhCQgkLDkkL1
X-Google-Smtp-Source: APXvYqwGrgZyc9oExqvbaJhKARQ8LLj+CHjInDxO0ay5ZrBhmN9/sk4Yeb0KiyJYEz+IgwKT9Is2kw==
X-Received: by 2002:a50:f4ef:: with SMTP id v44mr48999592edm.193.1555360783576;
        Mon, 15 Apr 2019 13:39:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm4810775eda.26.2019.04.15.13.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:42 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:42 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:31 GMT
Message-Id: <f6653f1c5914d4ed0edee87a56277a35625135ca.1555360780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
        <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 01/10] config: initialize opts structure in
 repo_read_config()
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

Initialize opts structure in repo_read_config().

This change fixes a crash in later commit after a new field is added
to the structure.

In commit 3b256228a66f8587661481ef3e08259864f3ba2a, repo_read_config()
was added.  It only initializes 3 fields in the opts structure.  It is
passed to config_with_options() and then to do_git_config_sequence().
However, do_git_config_sequence() drops the opts on the floor and calls
git_config_from_file() rather than git_config_from_file_with_options(),
so that may be why this hasn't been a problem in the past.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 0f0cdd8c0f..c809f76219 100644
--- a/config.c
+++ b/config.c
@@ -2011,7 +2011,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts;
+	struct config_options opts = { 0 };
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
-- 
gitgitgadget

