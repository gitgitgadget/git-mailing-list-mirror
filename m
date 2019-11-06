Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBB21F454
	for <e@80x24.org>; Wed,  6 Nov 2019 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfKFSvp (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 13:51:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFSvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 13:51:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so509809wrx.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J64/3+RHnkScbf8jA5PLMRJdNIxxRcwTluq8LaMiSss=;
        b=OgJ4AxRInqYGnSQVdZncIVYNqOieinaj/6Z91nQeooh71TGV3jIS9jralcLUYBlgz6
         JZ7Na6ErmKc4hS5EoHgEXO9UQcgMbhgHqgalva3L2XxyIB9E/0arV4TnYyGBpkNH3RB7
         ejuiByv9lbic+jZoizsNiu87haQJCkjwXhuKQIfQNLT0lgzYvCVTNiy3ijEMYHoTgYOK
         PR/ihLQfKqODTVZNUfAwQTtvJ8ZzCjMs2P8Wdn8y/qQWs//ixL0zQFHdW/0rcJXHccwc
         8DKZlWPVHut8k0QS1kWytghbgECcAQC5PQ+7TjKOP9vXuYnUZ9xncCjwLracyTJxasEP
         c7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J64/3+RHnkScbf8jA5PLMRJdNIxxRcwTluq8LaMiSss=;
        b=bsuGNy6h9R1iAKrdr4HvfwZZVX6imiX1kXYq3sYGd3fk8K7BM1J4MtjScwmN1W6R1s
         MmTv7Bal0HxbVl59uoX+k+jkvXzHWFZTSes0IbKr6jvqOXknUsqM5SkEoRFXLwBAn7TZ
         HFXFhzoCpcE/Goq9mb8HBz2sBlCnr/4mtcDRbAgC8Ra6voTlCjqp52qctewtUOtDH5TO
         lHl7BcS/4cvUVLJnEPNQoppigFCDDHvGrJ5G+NyQ+wB9MAI8FmUqCJ8HCXD0evQBwPXh
         UeY4FwY+T8QhZ/HncdIIUsATrk7g1RPu31s5X1vBqEIuINNDPEktivx+xQNcCWJswpOt
         Vn5Q==
X-Gm-Message-State: APjAAAXbIlionrJNasN9mNzbmcxfb11qUsD0IpgHOKWEVd1EaO+iXyMT
        EnkbAKrfJHHEFx0C/bp6IpHMq1Dd
X-Google-Smtp-Source: APXvYqw89pHVaFBchs7TNTyVXRQmPBZn1JW5cMjsgUutsXdCAu8yY5NrVZuh5Lsi2PMsEONTQLv8Uw==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr3960205wrm.240.1573066302431;
        Wed, 06 Nov 2019 10:51:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t24sm37341661wra.55.2019.11.06.10.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:51:42 -0800 (PST)
Message-Id: <4fdbb9f504ee59e508b7df520f7890e29fbca7df.1573066300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
References: <pull.451.git.1572981981.gitgitgadget@gmail.com>
        <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
From:   "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 18:51:39 +0000
Subject: [PATCH v2 1/2] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Erik Chen <erikchen@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Erik Chen <erikchen@chromium.org>

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

    * matching common remote and local refs
    * marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen <erikchen@chromium.org>
---
 fetch-pack.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0130b44112..f2f3365bbe 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -666,9 +666,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	struct ref *ref;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
-
 	save_commit_buffer = 0;
 
+	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
+
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
@@ -690,6 +691,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		}
 	}
 
+	/* This block marks all local refs as COMPLETE, and then recursively marks all
+	 * parents of those refs as COMPLETE.
+	 */
+	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
@@ -697,6 +702,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
+	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
 
 	/*
 	 * Mark all complete remote refs as common refs.
@@ -716,6 +722,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	}
 
 	save_commit_buffer = old_save_commit_buffer;
+	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);
 }
 
 /*
-- 
gitgitgadget

