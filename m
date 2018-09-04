Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7A11F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeIED30 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:26 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:49663 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIED30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:26 -0400
Received: by mail-yb1-f202.google.com with SMTP id c2-v6so1800618ybl.16
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vBHoq0YySA+yjxHkCaP5ju+mlcYCf0/5IaqymiVBKuk=;
        b=eMCXWT5njclO9tYUvIyrY43McsiI1b6y08GJTHa73fDZFhPJEUy4LqTnIuLUubbQBe
         HvwtGTaiIFKzMcEPJ7Hk/M6797gds2svjXX6SDarjB2YD2IKmnt6aKbXS0/6bKJNPfYO
         9xb/RzK0g6kcLw7p3s/mXaFR73FAl7Jaxt+W+drecEYs3s4TVHX3So96JNGhD2OhlS5q
         w/JSHr7G1mDJntOgWUbyO7q7f8hy6WFmZuq3uOUYKF8ExxObpopC7hjokg6OHbkqrS94
         5a9hze3JMuXqnqUPd4qWhQdkHn5hIUAp486fLDFxpljaxqJ4X/rxA0iiXkaarunB5awS
         W5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vBHoq0YySA+yjxHkCaP5ju+mlcYCf0/5IaqymiVBKuk=;
        b=N/hmO40Sxu5ZU6NVj9gcr/N9S3aVO/l2Zl/HeNCtKBCIhTfu74EodH1h/PGxmHzuBt
         SJGXeTtZ7K17Ml325gbe/Noq5MFEw8k26GkBt8WO9/fQM73Ww4kB9gYpS6kqzHv8bKiz
         7oxFDqT68uHAE4l11e7HB6Kq6g+TPvTN2ZicsnG7t2uZw1fUFqmzIqsGd5ca+bGKQAuo
         WkL1mQ8l5kvx6l88na1vDDERQnk5zxf6jmcxi/KWSzmt/BN6drEeabTWfKx9/TGEnC9Q
         xXK+MLBHqffbc52zXsfmZYAnmahaOaAPf6nl6bN8DfFz8UxWG9pFKIIgj9g4rkLLC6RB
         zR7Q==
X-Gm-Message-State: APzg51Bzb64unumnTciZlfsdBvgymV59C0bgjRKZpyEwFLtjbA6FWEc0
        gYOjxt0ZansfRzdcITsgPJFsiQcz8csWv7zEPAd6AeaCUp/NKsBzgFe9O8T5jrwy/YweTgFYqUa
        5++20GdMbxVVMlTfV/MTG0xWGvjFgebt7MVbAm0j5IXO/ILriWEnoQiBtHlv9
X-Google-Smtp-Source: ANB0VdY1CZk5H7oIz/xAyziu1BvhDP0viLVzh7Kr5lTYzg7yirBYotOiy2vQaVjJ7IZAks6iG4wvipmud3N2
X-Received: by 2002:a81:9a45:: with SMTP id r66-v6mr8797994ywg.171.1536102129229;
 Tue, 04 Sep 2018 16:02:09 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:43 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 05/11] submodule.c: fix indentation
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
 submodule.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index da2ed8696f5..8345d423fda 100644
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
@@ -1254,8 +1255,9 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule || !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

