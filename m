Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F062B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIEC1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:27:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46420 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeIEC1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so2339424pfn.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kl7mcazCIo1v/eXjDRYCgSVXBadwK7lTIxxKLYdsids=;
        b=iy/5o7TgOsPwgGT2wBKpPIYT/U+LLTj5YgMgq6xMLhVV8fy/9bN+YFJ5KIFVkUAm4Y
         /PzFng3ojF0H4TTNXGP8DZvy5EKoBn+KmOhbQm/0hkEmgjDq5hv2lQC31VDBc9SgUzGA
         zOJifvZW/TtrBDISC2Vdtv4/R7cZDPwvVA44b741RguHP8NTF9vEMjmrKvTgNsgzgb/q
         4PcPjTkS/UFxgsmgMJgNuHa0R6b6FfEVYx3oyFlGrvLzMK0+bG3c5X9aOpqC0PxPy7Y2
         z4YAnxW1yZ4jABGCBNNttS3Xp5XE5NjeBfj1sTJwgkfvNgb5hocW/jYIhjr3r4UW5Rh5
         k0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kl7mcazCIo1v/eXjDRYCgSVXBadwK7lTIxxKLYdsids=;
        b=ZSruyxEWCrewB4xYEyO3BbdEo47DzQjFYP9ezmfaDjTuIf3F1Uf/Hicgz0ia0y+rMI
         MNjxiW7QOJ++4QGs6FSFrVy8LhXTJ1yMxlyW9QcjUVyrGzxPqNKUORq7umQ9GAWcYxRJ
         6SFHBR4TyS+HBtsypsRG/PFGlnU2yIaTcASBsgXTmoLpsHsarPVCsmoLriO8GZCP6U7j
         QwlACIngpIT9KnhobOQXRapkcjrzitxOj9Bl/hCltV0qPEwI74WXI27ae+yUYx0w/GYg
         6VuKrVjdavfrBia32PPC8jr4qq56dAa269Al9wFIYuAGcfKWB6flfNYIkVNYhGK6HHA0
         9FMg==
X-Gm-Message-State: APzg51DTFbSVasjmEgDFg2dYG0xrVBWjW//jIwg3bQway5wfnotNcPZZ
        bEtdbB7FoVjXi1miMZrTTAr17iwo
X-Google-Smtp-Source: ANB0VdZHKWOTid2W8jZlVmNaJM4Wm6i3pVxo/+v+HJJ/6yXSQ9WWga443gp1Eg1I59Daffl9GgM51g==
X-Received: by 2002:a63:5d1f:: with SMTP id r31-v6mr6710405pgb.445.1536098410639;
        Tue, 04 Sep 2018 15:00:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l3-v6sm9560pff.8.2018.09.04.15.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 15:00:09 -0700 (PDT)
Date:   Tue, 04 Sep 2018 15:00:09 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:43 GMT
Message-Id: <25f6771947fd42de2c1373fef2f5043317161c04.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 16/18] builtin rebase: support `fork-point` option
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

This commit adds support for `--fork-point` and `--no-fork-point`.
This is converted as-is from `git-legacy-rebase.sh`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bcacffda33..6c101e1260 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -632,6 +632,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
+	int fork_point = -1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -714,6 +715,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+		OPT_BOOL(0, "fork-point", &fork_point,
+			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_END(),
 	};
 
@@ -1062,6 +1065,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
+	if (fork_point > 0) {
+		struct commit *head =
+			lookup_commit_reference(the_repository,
+						&options.orig_head);
+		options.restrict_revision =
+			get_fork_point(options.upstream_name, head);
+	}
+
 	if (read_index(the_repository->index) < 0)
 		die(_("could not read index"));
 
-- 
gitgitgadget

