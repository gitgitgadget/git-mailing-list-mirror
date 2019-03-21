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
	by dcvr.yhbt.net (Postfix) with ESMTP id A19F520248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfCUTgQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:36:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36281 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUTgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:36:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so6033044edi.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oc+oPAD9EOSiyCJy01gBQoIGBxChDK9qFVLy2jiEVkU=;
        b=PN4D+Qixzv5MAThPBhb2OOXmchla8Zvfyb6fjDULr6/bV3hIIOlRtWzFDW1O4G3era
         6gxdoDcmAZg7r/vsYS4CgvsAnHcaIb6x5A7Z6Sj58dX1slYhYEDMv1FxgpyDZv17TSVT
         hF9SNQFDN3c+2UKo8yMYzb0FhPSDot/cLCB+kzedoeEuJvsgUBCdxiGuciKHUVSoNmdp
         WQIRGoeAkUMWgELvsc1pv5Mn+sAC1ajbjAS9j4DhI/TtpeKufeXghPKz5omp9pvP5aF1
         6cSqx7lg0zT+q42ovQxyrQzY1SSb+N1AS/TCTl1hwBv1PDRHTlYxQ5cXZ2q4LKP7mRhj
         88Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Oc+oPAD9EOSiyCJy01gBQoIGBxChDK9qFVLy2jiEVkU=;
        b=euqg5JLtkuPJK58kcqtuYtq6QX2NEg+IqoRwn+mBuOXz7H14CJcdXjWhzGWckrC4hx
         A3Zny8N/QnOiA2xWpL0ZuYrM+7IweHL2/+2lxb4/7hKEnmXuFTowa1JQKL7URSk0l9zy
         bOX5I1yqD87Z+p/jCCYpieoYRPK/qS09d+sp5a+AbneXefB2Qk2IjcCLNmVxzMDrKuuF
         aPpSyAdpO8RXtT23oy2LeKZEsBGgKMRno7MD1H2upDxT9zYeXEYRDe1D8cXqWjJqWJzv
         5rmGTjP9zrtDWDlE2RfYvK1tEdNFXtRjfO8Ms892poMxJrLmfgNA1uEXUrlSh9z8wyVh
         QcdQ==
X-Gm-Message-State: APjAAAUSTezj1r3CxESaKt7IEto0GODXl/6FvcgAvGfBpQbtgcD7T+IN
        SpGdtW8CxMCCxqovcf2iKNiNr2eE
X-Google-Smtp-Source: APXvYqwgJ8nRGhJsCHmWPM2kFFloyoLPhJmgwgYEohQwxrbPNjWEVI6AUWGMZFTPPw9IOgKKkR4aXw==
X-Received: by 2002:a50:aeec:: with SMTP id f41mr3638548edd.279.1553196973744;
        Thu, 21 Mar 2019 12:36:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s49sm2033491edm.34.2019.03.21.12.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:36:13 -0700 (PDT)
Date:   Thu, 21 Mar 2019 12:36:13 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 19:36:08 GMT
Message-Id: <498258b12097acf9dfe6c06f3b256cbd9b0c2e9f.1553196970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v3.git.gitgitgadget@gmail.com>
References: <pull.166.v2.git.gitgitgadget@gmail.com>
        <pull.166.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/4] trace2:data: add trace2 data to midx
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

