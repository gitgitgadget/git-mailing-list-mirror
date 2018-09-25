Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C881F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeIZB5Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:16 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:38039 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:16 -0400
Received: by mail-ot1-f74.google.com with SMTP id j65-v6so28164181otc.5
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Np6Su2BdsDTx+mOYUhDKyUAc/s/nHx2bm7iMRHYO0hI=;
        b=p1+hU03AZu2eriI50o9fi4wgUvzOWJWUG+/l4F64je4vh8o1E6CmGL8MKANPDk0ujn
         /ZP6nDZreEUOqj6M0aELKIQRePm5kc1fK96DE45SHvh/E40WbmaLeVrn/M/Tqt+GXxu0
         kOllBkBqbxvZUTuRQ/7AWXAzT5t2eTLh+3YBwS9Xq/IENSz1YrzcYa6E5lpVALK6WTW5
         Rh7uxWHnA8LyAq3xsOl2gYU6Ztx0Ytcvcl3A1mZRHHeMQunGvXsSFhG1wGMkfgoaN+Up
         7OcuLypkuW4G/5SJDyCM8dZerGex16S01/Jnm8XTFZzGZlJUdTYV5eiA1oEHlaQwBt6m
         8dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Np6Su2BdsDTx+mOYUhDKyUAc/s/nHx2bm7iMRHYO0hI=;
        b=e1nYtruK+Un52eX4nyinsfuVD1zgNYZQ+nkwLnW8jsrEcstuJd1lSYYHLied1JVAEv
         7UC1zeajerighmj0ZYAAbTYpufAMPzUB+SO51sFTzWW+/3LwdrwpJhjGR5DkHcnMGw7Z
         YxWxMl0XWsOXJSlLsYqTmep1Dj4VuYV8+9DXuy5xqfsn83RbDlZjtZcuETy2lhdgJIp+
         4PeDCrDmqHQ9Ygum2LpZtfwuttp4oOmo2uWHK+epgM07M2GgWqPxNbJzphYFO1YlNnL+
         2I1L1yBTThnkOon8jgwhkZ9hd5T5fH/PLiW5DtvZUjLMwzLPIUFKAv4iWF0ZLaXUPfCm
         QfKA==
X-Gm-Message-State: ABuFfoh+NrLQDjl2c1PuGIGSbZxtspw94Waj6zjzB7dQQkNFNCOjpVrr
        R1ZBxxrZwvT8nNkRx1UkZvegu09bqz4/tVrvLHCbFHk9/SytNSE/WYk44B4HyR3JMJ+oG+nWvQW
        DNHaros5GxyhTeUoZ0Iu09sZJI5mjaH3Ci4r8UDhLbJPgsQcexxvDT8HXf6SH
X-Google-Smtp-Source: ACcGV62oDDo/qH5txF3y7itZ0DXVPnEWCs6o+zCtuAbP6fpsS8M8joNJB1yPvC/GiTlia3+JWcgg6LPZwWuz
X-Received: by 2002:a9d:701a:: with SMTP id k26-v6mr3256278otj.65.1537904887651;
 Tue, 25 Sep 2018 12:48:07 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:48 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 2/9] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index b53cb6e9c47..0de9e2800ad 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1254,8 +1255,10 @@ static int get_next_submodule(struct child_process *cp,
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
2.19.0.605.g01d371f741-goog

