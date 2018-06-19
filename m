Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6EA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeGPN1l (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:41 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:35441 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbeGPN1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:41 -0400
Received: by mail-pl0-f47.google.com with SMTP id w3-v6so2102622plq.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vqeYcY4tGX7xPDi2/XP81g24kxAlBTngt3lmVA0+Atk=;
        b=c7OC2zVLm1EqX1XKKdH6rfPd6ZKG799wqO3ZeA4DDQFC/+0ZGABSjtBhugnMziVe+C
         6KmGqk4kGnuaZ3P0QC+qtTXS5G2AGoTXDxuN6NrtMgTxJdQ4tAWlZmZxnpS3LFWJjqKe
         PFFPDKofkInfKV6FOmq8Sm52OVnJtDRq7yw07vGpWFuJU6l8dxlqLWrhKprEAE03ODvZ
         vNBASP3UQD4gi+SKYnYwxmceN5W38J8x1OGOOdRCdjD1TgFeyKeAKgTDfzA3uHADeBzU
         zIV2pEC+EF3qM9X2okonUfQmZyacbZWYs7fufTmr/YhYndRRiq8YWyjh1btXWlbxGL1W
         T5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vqeYcY4tGX7xPDi2/XP81g24kxAlBTngt3lmVA0+Atk=;
        b=SvfDS2ImH8ff+R1eS10uT8aAUhFpUG4Uyxw9zMgon1OOnathjwMNH7KaP/kXhmDm+W
         OWAcujnGL+7mE40jWyMQxs/7TaYUHWD8DMjdoN9oyk+0kkxMJQisZTv0mXQxvz599bgx
         Bv1198H9o+UO9rQqrYXRTMy1DOwAi/W+qnFVKSLb4rTLY5yI1cKRZgroNFv4E7/D+f3p
         HBWe+4LqwigFjeZeS00xfch7AAt2F49KLgPDPEmAv+a11X+/MKnkd7wde9Wq1+KWlELD
         ualoClP/5gnC3H7d72eGRQVqiNEQBUCXL2dKQxVQSV1rKshweLXdb4kUo7SMTRwsn3J3
         jtHw==
X-Gm-Message-State: AOUpUlEh1lH2Mh7Liq7zufLyssrsrJcMQRA4rSHRuPYjRMO2FoXV5lak
        dJQdo3bUIQ2k9YVZ2b7pUGxTNQ==
X-Google-Smtp-Source: AAOMgpflKcCYvX6WNGrT7uPUNRtQ27NINYisJXv6mXVhvNo9lkAFQPE/TmigV7gxKibGy2rX7/pwgA==
X-Received: by 2002:a17:902:a989:: with SMTP id bh9-v6mr16833794plb.245.1531746020694;
        Mon, 16 Jul 2018 06:00:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v6-v6sm93991615pfa.28.2018.07.16.06.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:19 -0700 (PDT)
Message-Id: <a8df7674dff42c2bba2eca2e803b6fd43e7e4606.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jun 2018 16:25:07 -0400
Subject: [PATCH 04/16] upload-pack: make reachable() more generic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of moving the reachable() method to commit-reach.c,
modify the prototype to be more generic to flags known outside of
upload-pack.c. Also rename 'want' to 'from' to make the statement
more clear outside of the context of haves/wants negotiation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4ca052d0b..0ed470713 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -336,17 +336,17 @@ static int got_oid(const char *hex, struct object_id *oid)
 	return 0;
 }
 
-static int reachable(struct commit *want)
+static int reachable(struct commit *from, int with_flag, int assign_flag)
 {
 	struct prio_queue work = { compare_commits_by_commit_date };
 
-	prio_queue_put(&work, want);
+	prio_queue_put(&work, from);
 	while (work.nr) {
 		struct commit_list *list;
 		struct commit *commit = prio_queue_get(&work);
 
-		if (commit->object.flags & THEY_HAVE) {
-			want->object.flags |= COMMON_KNOWN;
+		if (commit->object.flags & with_flag) {
+			from->object.flags |= assign_flag;
 			break;
 		}
 		if (!commit->object.parsed)
@@ -362,10 +362,10 @@ static int reachable(struct commit *want)
 				prio_queue_put(&work, parent);
 		}
 	}
-	want->object.flags |= REACHABLE;
-	clear_commit_marks(want, REACHABLE);
+	from->object.flags |= REACHABLE;
+	clear_commit_marks(from, REACHABLE);
 	clear_prio_queue(&work);
-	return (want->object.flags & COMMON_KNOWN);
+	return (from->object.flags & assign_flag);
 }
 
 static int ok_to_give_up(void)
@@ -390,7 +390,7 @@ static int ok_to_give_up(void)
 			want_obj.objects[i].item->flags |= COMMON_KNOWN;
 			continue;
 		}
-		if (!reachable((struct commit *)want))
+		if (!reachable((struct commit *)want, THEY_HAVE, COMMON_KNOWN))
 			return 0;
 	}
 	return 1;
-- 
gitgitgadget

