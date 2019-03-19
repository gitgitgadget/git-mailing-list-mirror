Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3524B20248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfCSOhz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:37:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35080 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSOhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:37:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6so16233792eds.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oc+oPAD9EOSiyCJy01gBQoIGBxChDK9qFVLy2jiEVkU=;
        b=vVqR+EsiCKtaMOVofgDSmUhLdL9vdeKmghG9YkDvz/rXiAU8U6jPX2MAWqla250vj1
         qrcGK9mubfJOHzoKI5HbcyMuz6JOlFaVm+5mCTUGLiwQWcMudiUyGpGpkdU3EQcUgWW6
         RsmMhI/3uxKWOBHgOpPEKgsU2hdpWNOAIq3NOPcdU/pRsDwbDxsJqchi7mkOQqDpxrXT
         +3rqXEsFveIUu7YRFeYw2mMe9xsSaBKkk4/P8BRcAkO9HQ90XbxBLUUjxQfwUbAZc4rn
         jkAfT5XVxXrnxgxbSNNWob8o/A+qnR85iGyzeUH3wdZ2Pqbzx35uO6AHZ6sW6R56kiln
         jCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Oc+oPAD9EOSiyCJy01gBQoIGBxChDK9qFVLy2jiEVkU=;
        b=bZksdHDbWQcWVH9jif92levKcE1z+NaF84evTTjP/ldF+MiOInYwarra0voGQzW/5t
         hc/H9OSa/g/xtX7OhB7Z4DnJO9uFUYTEg2umii8gvcscfE+DxLwYC+HJ3/d85Ekrn2nu
         2p4YmwvDGdWV4zpsy8BHgdOEFA4g0qpegSUur8glbE700LVYpzw7KcvjK4W5sOLRwddz
         4q2vKIt67StqCs5Zvxv5bAjtNVpE8cq5j1rAg3od2MButkA3KEV82TYlMlmXnvbUOvaH
         S6eEVJdW3uFj8wMth7ybrSsoIJG9QV+/uwbJ8obYsQguc2hStud3lxhzcNeLn6BNky48
         yubQ==
X-Gm-Message-State: APjAAAWfr1cplGspwhZK49ebpnZeBo91YA45IgBvzrX4zAf+GCveDYRY
        PeXbHau3mmm6YQ/BcFFXBQ52+bxx
X-Google-Smtp-Source: APXvYqyDZuCOeV0+PvK1xiOCG223d4FEzjpegrnkmvRhbRplKFz2dDnOiJw4rLlofbDSIi6MzkwLvA==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr13858292ejb.91.1553006271176;
        Tue, 19 Mar 2019 07:37:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o42sm4434966edc.49.2019.03.19.07.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:37:50 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:37:50 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2019 14:37:45 GMT
Message-Id: <11c88845e7c68990415e3f5d42227ce83a9f8d67.1553006268.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v2.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
        <pull.166.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/4] trace2:data: add trace2 data to midx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Log multi-pack-index command mode.
Log number of objects and packfiles in the midx.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/multi-pack-index.c | 3 +++
 midx.c                     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index fca70f8e4f..ae6e476ad5 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "parse-options.h"
 #include "midx.h"
+#include "trace2.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
 	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
@@ -40,6 +41,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return 1;
 	}
 
+	trace2_cmd_mode(argv[0]);
+
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
diff --git a/midx.c b/midx.c
index 8a505fd423..24141a7c62 100644
--- a/midx.c
+++ b/midx.c
@@ -8,6 +8,7 @@
 #include "sha1-lookup.h"
 #include "midx.h"
 #include "progress.h"
+#include "trace2.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -164,6 +165,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 			      m->pack_names[i]);
 	}
 
+	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_packs);
+	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num_objects);
+
 	return m;
 
 cleanup_fail:
-- 
gitgitgadget

