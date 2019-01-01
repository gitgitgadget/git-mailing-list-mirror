Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3270D1F770
	for <e@80x24.org>; Tue,  1 Jan 2019 20:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfAAUJH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 15:09:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39369 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAAUJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 15:09:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so27157023qtj.6
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HR2OT7Ks7D0YjN6bq45+d56p1plzOguMY7zN1jv4Vyc=;
        b=MengNh5w9iaWO2aMXm5QVg/dss1xHS9uhJTWS9kMUVO1t55l6Rv3Ge1VxQ7YVvSVt1
         N/usi54EIL7n1g/vwI2f4GUUkhP1Mz4Fx3A7305+GYsYap3CxRiqwSqU/6ehAMGTFzVi
         ctCMuaefjrpxBCeWAmdsGXD0q+KnSoT51j4CTie5DQvXwwH7kkjI4GimcUkIXU5OIn+S
         k3bk/TeYC9jZiAhoUdXq7EC6okKTpgysmygxFT2m2Bfs6bx4kjDFPqleHFCwgGwb4TlJ
         7UbQO9WadqUw7TPpDCWgDdG9tcq4h6vM64PyO02dCu8ixbE8pdOSNo5mCeiAo1Dx9gwG
         nkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HR2OT7Ks7D0YjN6bq45+d56p1plzOguMY7zN1jv4Vyc=;
        b=OIIOScnUUD5UBUyCDcqKM9MT1zIXv1uoZVTOngFp7boJR1IUN1MTcyNDB18sZE8OYs
         45WTdHMvUkQICKCuJF0YLtYM/VcxAmeWssn7yUpcV/rtrPA7LY261be7Lm5jhI8UlOZW
         8qvP8sJ9v2YpGXVXqgKSiJCSGNF7t4o1Gz6bPR+OEeyduc9LQt7Lxyb08++XDK36r81D
         FkQNy7RX7j2dF7RXOD4Cnc/Y7fJoxJBfZqF3kuaO15VIKW3W7XZDflCN6agM54zDWk9x
         tyByK6p7xLNbEGf6i0MW0G5xLi1Nua0c2h90Ld/KbZvMQnj2zPSeTCbZNLOBvz43FSBq
         giHQ==
X-Gm-Message-State: AA+aEWYgOnGC2tPqY52ixQzGLzRt3dkk70sqzmUm69AHpM202GwKIJpK
        XavfSeNLjReBczcyiAeiKFHlA88x
X-Google-Smtp-Source: ALg8bN73KoeGd6XnkP/o7WOSYRMRAAwBZqd3mIWcXXQXpmuvr1F1GMxlGE//IB9xjyzxdybvDqqYYw==
X-Received: by 2002:ac8:2f7a:: with SMTP id k55mr42111214qta.163.1546373344897;
        Tue, 01 Jan 2019 12:09:04 -0800 (PST)
Received: from Alberts-MBP.home (ool-18e4c9f9.dyn.optonline.net. [24.228.201.249])
        by smtp.gmail.com with ESMTPSA id f36sm22259013qtb.67.2019.01.01.12.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jan 2019 12:09:04 -0800 (PST)
From:   Albert Burt <aburthinds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        Albert Burt <aburthinds@gmail.com>
Subject: [PATCH v2] doc: remove unneeded TODO for release_commit_memory
Date:   Tue,  1 Jan 2019 15:08:18 -0500
Message-Id: <20190101200818.81273-1-aburthinds@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <CACsJy8D_gTKWXogPDNW7NQk_a0ChBu28HfGu388hFn3-by_cRw@mail.gmail.com>
References: <CACsJy8D_gTKWXogPDNW7NQk_a0ChBu28HfGu388hFn3-by_cRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove TODO that was left in from:
commit 110240588d (Merge branch 'sb/object-store-alloc' - 2018-06-25)

Todo can be removed as:
9d2c97016f (commit.h: delete 'util' field in struct commit - 2018-05-19)
deletes commit->util.

Signed-off-by: Albert Burt <aburthinds@gmail.com>
---

Thanks for looking at this for me Duy. I updated some of the changes you
suggested. 

Let me know if there's anything else that I would need to clean up, or do better.
:)

 commit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.c b/commit.c
index 2d94e0b199..2ff6dca0bc 100644
--- a/commit.c
+++ b/commit.c
@@ -357,8 +357,6 @@ void release_commit_memory(struct commit *c)
 	c->index = 0;
 	free_commit_buffer(c);
 	free_commit_list(c->parents);
-	/* TODO: what about commit->util? */
-
 	c->object.parsed = 0;
 }
 
-- 
2.17.2 (Apple Git-113)

