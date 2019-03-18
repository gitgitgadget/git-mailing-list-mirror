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
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFFC20248
	for <e@80x24.org>; Mon, 18 Mar 2019 14:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCROaB (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 10:30:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45823 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfCROaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 10:30:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so7134316edd.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eH/xzQOQm97sZQl4V5WR4sb7cyzUZbDjy/mWJuo07Q8=;
        b=jO7LyAySnDg458jrvNzjAncfOtkk4WBYddxmXYXYETVhUTUAbYncA4O1hRiPFuQ6dg
         HEz8NjbtGs08Ia0oSGASa5WBZT7XwpRruxJ6I32dZbwKi1hREe+SFQtEL8Wad2s/ptv+
         gD1QphRZ+EMvpkIOAoHTxh4sgmO7RURRJMOcOsavdKaf8ZRwsJqcgnn38BJqxJdLXNUS
         6D9HL40p4g5cvFFwTG9sXDBQuedOoVwMGx0oa3g2s0yR2oDGF4TR1KzXDuVjBlVtn5gM
         TlVhd7EwY0gLKRXLKH6PRO1iOM8d/1Hgz/DrjhBBh2U7Pjc5p4MqG09+6j8Q3+0pDwsq
         nAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eH/xzQOQm97sZQl4V5WR4sb7cyzUZbDjy/mWJuo07Q8=;
        b=WxIcFYHe3jd7e2A5BXzicgjy/xvQcw/RtbVhqOIUflKXl84fowXu2ye0bgw3kC0pqz
         yFTmZMYUufW+c4njaN3FJmObYqUc6PmoWXM8s0JTk6MWpjtJI01iKHUjzF5NDgUcifSc
         XHS2lKuzuBLBpxr+IsPt2P0OBp3UzMZ2QGeflvHQZkVeEII08O0zV67uCs59jvgV6rcO
         TjMror3lqGS7zOVvG+TAUskMswyYgN+DChTR/m1Rcm/P9Ld4AZb6rCNZ1+z+Fdfl7mj6
         L8hwulKXQTJt0O+iIjImgHAE7DKM8b0QAxzcJ8US1kWrA6dOvPlwzt/2h6oTDN/rgzRT
         quKA==
X-Gm-Message-State: APjAAAWbgYg4hcgGvEmsI0CIliYu0CNm9NPtJE4loFKnBLNlORJPCnOL
        B1GkPyBbz9/AMOtSbja3hr6fxYNE
X-Google-Smtp-Source: APXvYqyIwHDtg6iJc/X62KTqENUnLo1a+iV7yjhUaT0vQ8UIL0wVuoZ76bw5VkyTbN5unOn5XYGD/A==
X-Received: by 2002:a17:906:1d4c:: with SMTP id o12mr11070167ejh.234.1552919399022;
        Mon, 18 Mar 2019 07:29:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm1226935ejb.24.2019.03.18.07.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:29:58 -0700 (PDT)
Date:   Mon, 18 Mar 2019 07:29:58 -0700 (PDT)
X-Google-Original-Date: Mon, 18 Mar 2019 14:29:54 GMT
Message-Id: <2d23bc24b72f8a196b222a89454bd8c9938207fe.1552919394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] trace2:data: add trace2 data to midx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>,
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
index 0376757390..df1df20a66 100644
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
