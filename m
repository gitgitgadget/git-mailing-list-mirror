Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2470B1F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeK2Lbd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:33 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:53705 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeK2Lbd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:33 -0500
Received: by mail-it1-f201.google.com with SMTP id i12so689369ita.3
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YdgE2YzBF1vjcZzDDRV+FbG8YGc2AgCmNzvdAnXMspQ=;
        b=RCleeREoMTA0WctvGwzErUe1oc7FgtMUhN63zIdCAUyzm3oV7FymkoVHhdtt+fKpMG
         gPf0hLXxscz9eE2oyXnv77gK5D+oSx+a1ZNZZJjOfS3mpgnnBeH0tevuMY6xKTBTfOvi
         unSvjjm1ldYsWoyG49eEivDXcqDm84jc/1WsgRmvc4g/Lc3Qikr7z8ZYZ84D7/v+O7as
         1JKhDfdCPkI3jt0akwrK1nsc4g/cUw4xgzlT1Htv3FTF9HRdDCo33UTQQb0kUVYnPhOg
         xuZODYfhx03MdmDI5yFwUHL5MiBgZ9W4CA8CUlihLBtC7T11jupe6keoOEtkThcDdLmW
         trNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YdgE2YzBF1vjcZzDDRV+FbG8YGc2AgCmNzvdAnXMspQ=;
        b=NRPWuqwKrWeLd9/JAGJ/lo4ZKXkarnKOIuNWl22gANHuJGnaaxrYv0TD1crp3ilBTu
         +EhMgDtM1SR5PUgId1SFWkwkQG5cEZYpYqTKParw4q95WD+nG3q4jjyGc1tjMw6oCeLA
         qEnNo5O5+cuUQMneAa1KuSo4n1yGGT2AhqJb8TiRi7NiAJYcN8r4L98/bhB6XR6zcIU4
         D1whvcrc+dRiysLBzqmmepVq39p/h5lOzJRG5f4TgtMQ2IPxQNSQ2R5ZP6Z9ufesAl1A
         kHhpUbyz98uO1YkUqmvh+Wt/0CcI4vQKogF1Q2YdOHywlSMQ3ylQ0yVV8881Lw1b0nb/
         JCDg==
X-Gm-Message-State: AA+aEWarYSKfA+RCkTx0S50qvrdQCtXYNkbwFkm2ZLrcekjUB5h68JY3
        rbCYHDuxIdxn6e5olfOGDkP23xImjNLgp1zzcHsOCU/htLxYi1rDUinOg9UGQBqskZVq47eJ8g1
        KbnLYR6usiy2HYTswXp/0+aEqW2xvJXziCARXFv66K9KG9vUBr3wjoeSZR9xm
X-Google-Smtp-Source: AFSGD/WsbcY00LHU7SlECIrlMX42vgBtgKSSAb9Az3Jwd0b/EMDYBBRPdXygObToLa9e8Vpcm/tU4bThXZKk
X-Received: by 2002:a24:138f:: with SMTP id 137mr4061043itz.18.1543451285743;
 Wed, 28 Nov 2018 16:28:05 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:49 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 2/9] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6415cc5580..bc48ea3b68 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1271,7 +1271,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1281,8 +1282,10 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule ||
+			    !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.20.0.rc1.387.gf8505762e3-goog

