Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B451F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeFFUrl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41484 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeFFUrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so3705779pff.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndbqfvxpLlYo3xlg6ZOLBhQgLVaEqe91kufUe0Tq58Q=;
        b=Pl3sPnVkjTRPQ3C6sBOuNa+v6fnI2Au3AwtQXiKrONm058lokkX+qb+JWG2Yf0ZO3H
         zqrZpAE0hsgWWvA6gGDi7IaN3DGo4VvqTS9yJKd4U8mDdt119Vi68qYQK+SRq5mpjX7y
         BtSLQvfiFVZdjp3gy52YaeXCrA/zhPSbSwjqLWDBH1O4g7598fKPTgKFVxIMfijAf9xT
         imYCNEYO6XUkDpt5b143ySe7cpe6CFYQSPXH0sZ25+nTgbFweeS8kR1pTsC78bALFUjr
         sxt2D2YKtCQh4r/fMcHO47lMeVD30CaDNI81rxU1FFZB6wzzCbnc4YWlmWlvYX6KcK0J
         fUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndbqfvxpLlYo3xlg6ZOLBhQgLVaEqe91kufUe0Tq58Q=;
        b=DPKNkunZXM++rrIiyCW1p009PxwnJBJFvnHFAePmsFHoovBDnIJkRedembPzI8xiwz
         qHX4gbEOp+LWcAW6OzYW6N/JerOIF72SZAdQHonSbPh7tfytK5V4E4GIDdShzuSceBJR
         BpWLnwHJqmNYXBMtBLBYcGHHL+32MnNWV13SNYzJoRLNber1uDtlzG07UPJFS+qm/mq1
         MW5Iuxl2relhe2N1vqkYKR9Q5gW0UoQJnaEs8l1y6a9xEu89nWvKN4Wu2VEBfGiL5Sdw
         t7oHEcI0vCLJFTdZEczuTL4Kfs+EFRgUfpeq+35HVzEymtbCO+5/M+Fqbd77bv8x9Mkr
         Efyw==
X-Gm-Message-State: APt69E2lojrXqA34zTK33RyEoxfEbxnIx2P2kVrMGuy2pwyt0B3dgWbL
        LZgF2XEB14ETEHHMkmAaU4JTUNIf4cU=
X-Google-Smtp-Source: ADUXVKI1VeFZ+lOKTC4HIZmDtC3H82qw1azDkc/sMsq1rqU+5N4nOIjnXCRc1We0M23SJn79XrXHZA==
X-Received: by 2002:a65:5c02:: with SMTP id u2-v6mr3821674pgr.304.1528318055696;
        Wed, 06 Jun 2018 13:47:35 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:34 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 8/8] negotiator/default: use better style in comments
Date:   Wed,  6 Jun 2018 13:47:14 -0700
Message-Id: <aa0df5f449c2f5c1f2e6d6edf933aad5f58b2a5e.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 negotiator/default.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/negotiator/default.c b/negotiator/default.c
index b8f45cf78..a9e52c943 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -46,11 +46,10 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 }
 
 /*
-   This function marks a rev and its ancestors as common.
-   In some cases, it is desirable to mark only the ancestors (for example
-   when only the server does not yet know that they are common).
-*/
-
+ * This function marks a rev and its ancestors as common.
+ * In some cases, it is desirable to mark only the ancestors (for example
+ * when only the server does not yet know that they are common).
+ */
 static void mark_common(struct data *data, struct commit *commit,
 		int ancestors_only, int dont_parse)
 {
@@ -80,9 +79,8 @@ static void mark_common(struct data *data, struct commit *commit,
 }
 
 /*
-  Get the next rev to send, ignoring the common.
-*/
-
+ * Get the next rev to send, ignoring the common.
+ */
 static const struct object_id *get_rev(struct data *data)
 {
 	struct commit *commit = NULL;
-- 
2.17.0.768.g1526ddbba1.dirty

