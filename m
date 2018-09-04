Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21BC1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeIEByJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:09 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45281 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:08 -0400
Received: by mail-pg1-f180.google.com with SMTP id x26-v6so2272184pge.12
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4NpIC5ough2yOT82nBvZbBTyOAZlY5Iq0BUFKyT00Z4=;
        b=iwwQtfIj0Cdh1kXc8Hfh4pCjUWSSlyTqmWo+uhGmRUllfm7Zj45yI4IM54CX0rxPO/
         xuNZx/kSKUXS89mKkJVej9liAX/L+vfXe0aiXZDVwM5eOV2nWE3hHE4UJRnTS1BGkaEg
         voR26FM9AKAYCU7krnCKa4NGbe+kYqV87Cmv/S8cYKU69caVuom8DvJByMX15AmoS+CN
         1XNMHXn5LuSXWIA9BaYoUy6nij/EG90Ypff5swGc7gZkkx0SWz/hG0gUOXhRM0qG3ZOP
         3AZbgNvLQWConUfUmMoycPbLHck8735iRg+cEVxf0EzSxSOf8cJy2HpHZN8dDsaJtgOI
         gEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4NpIC5ough2yOT82nBvZbBTyOAZlY5Iq0BUFKyT00Z4=;
        b=ha0OCXbGUTKeHUhjEMHLNqRUdaN6/AO/VLO2orJ27raduaujHukMS0mcbzzKXJWUzB
         aVU6dHZwsw7qkCbZciPFwP8Na6gzq4wMO/JVnb/XbP4hNnRtTZT5onslZAmfNJIVDmdo
         DY2OUY7qZLJDnC6/ZsNM9Y4gTxGS4h7e432z03FdsDIgnKpVXJObqVUtn9UEJSIe2/38
         c2sD6V5d/MWAu1lI6UvMZ634Mdn43g69auLABdM7uOmbovaCvBXyjY1m8W0LYmdwV5Xe
         ytPFqq9kAZBvUtgrwcOM6QHNLtOjrazeQjCwKJARKyjEfmnKCm7bZ2g0PonI1ygAv2AU
         WB9g==
X-Gm-Message-State: APzg51AANIuipBZOIt60vzpCRAr8d3p4Io1X63ZefhTB91IIsgFJJS5B
        W8MR21n8xsXrPwMncACxUFTilPPA
X-Google-Smtp-Source: ANB0VdZnRTRPF+swwz/T9VerunBr2+nNGQVhGfpTpbXHhpb17rBNOVe4HkMIcvZT33YyqNxCaQvZEg==
X-Received: by 2002:a63:8543:: with SMTP id u64-v6mr22574960pgd.248.1536096431465;
        Tue, 04 Sep 2018 14:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e26-v6sm27115429pfi.70.2018.09.04.14.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:10 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:10 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:56 GMT
Message-Id: <7100820def2f2805cf4726e0501ca9208bbaffaa.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/11] builtin rebase: handle the pre-rebase hook and
 --no-verify
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

This commit converts the equivalent part of the shell script
`git-legacy-rebase.sh` to run the pre-rebase hook (unless disabled), and
to interrupt the rebase with error if the hook fails.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 38c496dd10..b79f9b0a9f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -70,6 +70,7 @@ struct rebase_options {
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
+	const char *upstream_arg;
 	char *head_name;
 	struct object_id orig_head;
 	struct commit *onto;
@@ -310,6 +311,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	const char *branch_name;
 	int ret, flags;
+	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
 	struct object_id merge_base;
@@ -317,6 +319,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
+			 N_("allow pre-rebase hook to run")),
 		OPT_END(),
 	};
 
@@ -382,6 +386,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.upstream = peel_committish(options.upstream_name);
 		if (!options.upstream)
 			die(_("invalid upstream '%s'"), options.upstream_name);
+		options.upstream_arg = options.upstream_name;
 	} else
 		die("TODO: upstream for --root");
 
@@ -430,6 +435,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Could not resolve HEAD to a revision"));
 	}
 
+	/* If a hook exists, give it a chance to interrupt*/
+	if (!ok_to_skip_pre_rebase &&
+	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
+			argc ? argv[0] : NULL, NULL))
+		die(_("The pre-rebase hook refused to rebase."));
+
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
 		die(_("Could not detach HEAD"));
-- 
gitgitgadget

