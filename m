Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70151F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbfA3U4e (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:56:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37697 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387944AbfA3U4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so811882edb.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=Jq0ZYmlzy7n5DIHEjb9KZHBwAmS6KUcChJo56aNIvhGVBkQ3roykQsya4oMNqV9UOM
         Y8nEreYBdgk6sJypXyIj0+t/rYyIoFlZkSsl/mWu+GJbuXkd3woJQPko2emVDrCk+F5z
         ePYFMTWk4YX0UnSHvjxBGfXthLW3hEOZMuwq40IZntxzjoa5HPvY/exO2SncHoveSRA0
         fSXfmEj9Ukms+LYsyyxJmh9oECR1JfXj7FbdhNwAdIhg4juBqt7EgP9M3gNNcpUd73QE
         HbUD4/Uxqo2UvmYYoBoIYh0QOLAc+Z4x9SgeopseAO/1ITkDnorsJKlCRUD1Jujcjrk5
         wCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=717c7OdR6NBnQK3hRwJXlAkwGkauYy96P0xUlww47Sk=;
        b=b/jmolMuwYlHExk062Yt3VND5DpAJmlRuKBaxyghhryQCUAGCLrL1ocDc7K/QtJL7T
         +hEc0xhQlkV7bGJg2u9AEcxh6oyzRpcjim3i9zMp/xybKfjQ93L/emmWz9iY1KkpWCFH
         C4JSehnrFWHyD3d/xywNe5n/yUFiPm1uqqwMvEViJUa0YV/hbCmH+gAYllqpAPozC0tB
         /Sw0dxnshVM6NmUWwBKylTPUCK4QenmWUGeP2J6yRCIl/wY1oTIreGNHqbe6zCyzJR6z
         pCTSVXVnCH4TH2vMSy8EZFevJ97u9hkfd0+5uX8MdNu1S/hG9oTab6holz3OB6A8k4h6
         vbLQ==
X-Gm-Message-State: AHQUAua9A3C9ttWgA3CDeGEqnHUkeBDSuEQodndE1iph/U2tRaWEgwMR
        BSungRuC4IPjrf5h270rFifzYqk1
X-Google-Smtp-Source: AHgI3Ib2OBE40bF/SPDAALNEK7UiB0SQ0UD148KzoHw75HKInAMl4aZPzf7uBY4xmQam6kJNRlmI2A==
X-Received: by 2002:a17:906:1daa:: with SMTP id u10mr3509044ejh.35.1548881791752;
        Wed, 30 Jan 2019 12:56:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm793360edc.28.2019.01.30.12.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:31 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:31 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:16 GMT
Message-Id: <b4c8ff53dd8f9f04bb65ebc942b6319834897971.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 11/14] trace2:data: add subverb to checkout command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/checkout.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6fadf412e8..8939ae99ed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -262,6 +262,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct lock_file lock_file = LOCK_INIT;
 	int nr_checkouts = 0;
 
+	trace2_cmd_subverb(opts->patch_mode ? "patch" : "path");
+
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
 
@@ -952,6 +954,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+
+	trace2_cmd_subverb("branch");
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
@@ -1189,6 +1194,8 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	int status;
 	struct strbuf branch_ref = STRBUF_INIT;
 
+	trace2_cmd_subverb("unborn");
+
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-- 
gitgitgadget

