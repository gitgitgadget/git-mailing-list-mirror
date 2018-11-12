Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032BE1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeKMJVW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:21:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38691 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeKMJVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:21:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so5039688plo.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CKAy8Q9puGlB39m1YCm4E0f1b9uCmhWTchwp6Ha2u1Q=;
        b=irAa9X+/+HmOp5DqVycaGR0FlTv1QS54REIt6c+mptSWaNkqvsJQyyVABEeYXBnG6/
         2tUyCkdcXGrom8AKVBsdwZ+sb/80SU8BKZD8ETNUo5CrxuIqU3D5EmMrAwMwwRrwGUZW
         +XmYS4xKPWwtZ8bhqii76H2F6NGQ4vc6cMj3smPxkLn/IChAt61lHDgO0pSZJyMqp8hn
         DvDmcV/0F8PC008ei1r4j1iN9SN3htsm+d8sb6J08wRNk9tdLL0vhQ/8l7IrIbLZ9qF1
         RksPHRjPdl4nrI7P1yoRPbN+WNOKdRATN26KiM+iMHCyCB9MwtR/7dde12cq8pygjIul
         5ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CKAy8Q9puGlB39m1YCm4E0f1b9uCmhWTchwp6Ha2u1Q=;
        b=hJh6P9pwo22W4EqLF2zIlXdKeCyU9pf7CTwOCJpbn+D8aLDlC5K+T+89kB9Iu6cHg9
         akL55j1biCI7Ec+x83HdTBl8EV3YZNB+V7sE5rAOyPZ8VKWBTDGNIFdRL9B7PLNr/8rs
         aAFWRB3QO/wR4A33+0+gOk2zCOEXkU4AQIjGyK9YizX9s89VQJ/gt+m7UUvImIPj+25D
         ZEII/M1QTDgv9gA3FO//jqg1GRpcRf+WkBIejPvWWWcs27nTi0oNIR63vi873MQfjHVf
         PC17uVsx7VuY5KibWaOeqNGsU9kxY4OH4SWjujVI1un+Z6buzvsOwgWx1/s81lGBWFUu
         6niQ==
X-Gm-Message-State: AGRZ1gL0YFpCl6vD9SyfjySv0favUqFIqMfiaBHQoZXTQ4xYZvDadp36
        wfEqNLBQe3X3R4vCvp7OrQ4b7u7r
X-Google-Smtp-Source: AJdET5fkCED8AXcoRqs+gTr3gfiYODKrGp7kC+qpGoBG/tVqk8lxBsdx2DnZF8g2j0rRN6muDQGOxw==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr2700129plb.168.1542065160501;
        Mon, 12 Nov 2018 15:26:00 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d3-v6sm16581147pgq.16.2018.11.12.15.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:25:59 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:25:59 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 23:25:51 GMT
Message-Id: <65f02628f6ef96e88485b66cd2c6e5e57212b4bb.1542065154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.75.git.gitgitgadget@gmail.com>
References: <pull.75.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] rebase -i: include MERGE_HEAD into files to clean up
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Every once in a while, the interactive rebase makes sure that no stale
files are lying around. These days, we need to include MERGE_HEAD into
that set of files, as the `merge` command will generate them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7a9cd81afb..2f526390ac 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3459,6 +3459,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
+			unlink(git_path_merge_head(the_repository));
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK)
@@ -3829,6 +3830,7 @@ static int commit_staged_changes(struct replay_opts *opts,
 			   opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
+	unlink(git_path_merge_head(the_repository));
 	if (final_fixup) {
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
-- 
gitgitgadget

