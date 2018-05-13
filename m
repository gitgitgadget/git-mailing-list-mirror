Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDB61F52A
	for <e@80x24.org>; Sun, 13 May 2018 05:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeEMFw2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39932 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeEMFwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:25 -0400
Received: by mail-lf0-f66.google.com with SMTP id j193-v6so13376638lfg.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEVUNicisU92Mpr8PicCTpQxDXU/BsBeran034vMCq4=;
        b=avrAGFzefCPH8DRJeMIDlTG1QnJYFiq5Sk+VrXwJENcJNlZz1Gupkp7ggpV08a3sxL
         oNe7STnoaCpqlfIRLiJs0CYBMhpUcmG25Rv7twyI7E9tsLD8/KC3fdTJq+na18EtkZ6A
         9W6BeM//adMHtwb3yKqgz9wJgtHzwFIm4vTbDt1Uh8XURd/cenbfdsQoxNTJB/r0Qdh5
         1O3gWYFNA/udSfG8lUPgmcD6iPR/gpgUhbRQ7jq8/i0aHmhgs3rMt7HkLGcgWjk24nIV
         7eWJYQCp0QmRto3WiojoHR25GF7WpbHonVk9LP8lUhEa53k2bIatHhEDwe8fkESFjD6C
         6TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEVUNicisU92Mpr8PicCTpQxDXU/BsBeran034vMCq4=;
        b=bNAgU6DJXuXpOqfG9bkRcwG6fCi4a1qnWYv6t8aEMVN0qYofwDXbDMxCjKsTf43zjC
         Xywj+RjURYxx2VAIDUuPVuqK4COo3LHvV391PjJ26RdpX2YyBk5GhVVmftP5aEkWEKvP
         pzZ1Kmd3cLKth/1SYiI9SmKWYQWRM9vZ5jc5WY6Bllvxycr5SpSrpluxUMmZdx4eoAb8
         7N37knQFWt9v4+VHMnY+DptdATBHc+yMofveGI7ee4kxxuKnY8cztE6E97dI/7IGFF24
         5qtLpiZQO2NGxSnyLofPQeBz7IhNic7Fm1PQnJPOBVPURqvasbr7znzNtiR12i+M1JQ9
         Yv/A==
X-Gm-Message-State: ALKqPwdKeO+o4YHe8Iu22OrokEXUn2gDYgQA9yeqX89VZUORPh9dHM1+
        PEiXmjUSl/2OjIwWIMMot/D4tg==
X-Google-Smtp-Source: AB8JxZoVEYnRzLlsF2QB6GYzIUEADeuTMp+vqfhbT1uLKBX87AyQRwaUZP4pHOaWERdMaWJEBbd8aQ==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10-v6mr1910206ljj.49.1526190744206;
        Sat, 12 May 2018 22:52:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/14] bisect.c: use commit-slab for commit weight instead of commit->util
Date:   Sun, 13 May 2018 07:52:03 +0200
Message-Id: <20180513055208.17952-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b50884..6de1abd407 100644
--- a/bisect.c
+++ b/bisect.c
@@ -12,6 +12,7 @@
 #include "bisect.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "commit-slab.h"
 
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
@@ -70,16 +71,19 @@ static void clear_distance(struct commit_list *list)
 	}
 }
 
+define_commit_slab(commit_weight, int *);
+static struct commit_weight commit_weight;
+
 #define DEBUG_BISECT 0
 
 static inline int weight(struct commit_list *elem)
 {
-	return *((int*)(elem->item->util));
+	return **commit_weight_at(&commit_weight, elem->item);
 }
 
 static inline void weight_set(struct commit_list *elem, int weight)
 {
-	*((int*)(elem->item->util)) = weight;
+	**commit_weight_at(&commit_weight, elem->item) = weight;
 }
 
 static int count_interesting_parents(struct commit *commit)
@@ -265,7 +269,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
 
-		p->item->util = &weights[n++];
+		*commit_weight_at(&commit_weight, p->item) = &weights[n++];
 		switch (count_interesting_parents(commit)) {
 		case 0:
 			if (!(flags & TREESAME)) {
@@ -372,6 +376,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	int *weights;
 
 	show_list("bisection 2 entry", 0, 0, *commit_list);
+	init_commit_weight(&commit_weight);
 
 	/*
 	 * Count the number of total and tree-changing items on the
@@ -412,6 +417,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	}
 	free(weights);
 	*commit_list = best;
+	clear_commit_weight(&commit_weight);
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-- 
2.17.0.705.g3525833791

