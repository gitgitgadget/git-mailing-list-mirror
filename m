Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3705B1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfD2UOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:14:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38578 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfD2UOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so3575914edl.5
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=nfjcEHc5MfnlLYuahReqdsTi/b2uupn9vj0JKvv36TuT9rLw3HtzuRRyxTDy/uTZz9
         BW3frrSFdMwIQpmKRhuQ5raWbGAPfliOqUpdhlejDurJgkkR2bcgjwcJEtQy6cGpScGI
         54ufJxG8K80R49c7myi1520LoQaeRZbC426+g9KvXiKal7crPF9M7aRa2fkYlSI4yZXC
         hv+P2IbUGpPqfOFInZNeG58izMbsQ0lphPsvnHBcdOnKKCnw4I3FGlD7u5Rj6N0takhA
         mSyqd4Y+c+PpkIlEU/uLUOlTIaJHJZeIxlrGIHc2WW3GWy1pk3CUcNx4rJJo3FAS5cLT
         khrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=k3vojbGTpWHMGpD0okN3CEOudav20PiYexsntHyMhiX/80Vjbz2gVer7MRbndS/IRs
         R3CEn6bJZc8KBXO9595dC0VMsisWmx3XtL8ZV8KssEbnRC+ZOpNS31EPSNzzNUI9T5Uy
         DAYB7eNykIHvo4CPNBBSPbvwil2TupYbXgVrQgCcuoxS3fBJz7s/ovmwdeeStta4Kz+D
         +UD66OaQqVyGzu/ANkT8akVWFEqjrX93Ahm+l93fF02x4aAtHrRGrdJViIGXzHpxGb45
         kWPdTqdx9m+ykzM4BNbktewhhOc7AEuCJcq3eXRKwXGCQp+5w+aV6mQpR7oaRPIi8m+I
         QU9g==
X-Gm-Message-State: APjAAAWcjpHGvJi+uWcmcWcPYBHZpn1vpsd8L0DQJ+rGRU+v6WQmQEji
        kel0Gygfe5Pzmcl2x+93Fa9ccz9e
X-Google-Smtp-Source: APXvYqxI6kvtaDcRZl9NOUVYR5zXYDLfzQpPdpAZhyaP3Ruj4tbkOW9CrTLC7n4Lre7IuPHySXcMXQ==
X-Received: by 2002:a17:906:c350:: with SMTP id ci16mr3115110ejb.286.1556568857266;
        Mon, 29 Apr 2019 13:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm4917805ejp.26.2019.04.29.13.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:16 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:14:16 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 20:14:04 GMT
Message-Id: <94729b284c4338aa40d4287eea909e835820ff4b.1556568852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v5.git.gitgitgadget@gmail.com>
References: <pull.169.v4.git.gitgitgadget@gmail.com>
        <pull.169.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/11] trace2: find exec-dir before trace2 initialization
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

