Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A501F454
	for <e@80x24.org>; Wed,  6 Nov 2019 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfKFTjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 14:39:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44705 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfKFTjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 14:39:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id f2so18570734wrs.11
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 11:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pw+jsBYdoxGPwZq60TK3MIQd3eTs7yI5qtdpt3aZxOs=;
        b=RB5Og67nWrB1XyBk30v2YZpHWZNCpY1IHoZuUcxpZEUBeyd1vETSwUu3gJ9Ti1A2hS
         cRQx/EevXu96NhDhRAdcelkgyifrrr/rlW1TXzxONppAztorECPBVfoMQT9h8R51GduR
         Cc32fPkVr5YqMm8vfUpnYN6/m0103TDfzQ0sxWBG7ltjFibTyxCmS39/kv+wGkHILc0D
         iqQ5oBWgFPnXjOLO9QvSCk0uRdJgkPMRFGcDvp+/N9Gy1XKLoNnFW63M/wA8GUsmynp1
         kZB+0X/Cs9BCLvX0sZFL1fN+0W+XbQUWuTbcJ5LVLBofaALG/Ttkhz5UT9q7Qe0kl+M3
         TzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pw+jsBYdoxGPwZq60TK3MIQd3eTs7yI5qtdpt3aZxOs=;
        b=jOGTNH+LVFjHyC/BVtvDdAsjzHMfV4szzSoR69kYtq9voZbyc49qIWvUF4unrXvFdL
         yn8I5CqCw6AyKJhGhn65IRfnlIondypYHJaoGMkKBtc5tqgwf/nUY7gHGSIVbxtC0Qru
         Wl1VxPX6the8DVDXUW5I7ZjhkiNs9d6UfYAE9luy3fpGOGsV0cFBwqnf6Ul4on/CYdwG
         AwqpLGXuEcrxTzrQDyuTP5VufotAbrUjScBfcV6oLhghFU6fNSKZ+9tSyHh4zYYAbVZf
         GnLxLSnwZJS6fbclX2sOVIZDkpIjAjModYQWkhDxcWMMSUKV8b7T4zgbyirCx/V14BWl
         pKAg==
X-Gm-Message-State: APjAAAXOS7/cGWYmQXUj3k7kCIQDcEC9T+9+UjOqJtAkS/PCvzcvryTH
        2h/dwAyAx6FskOZM8aql9GL+yBRr
X-Google-Smtp-Source: APXvYqws3gKKLcErhwCCd9HFVf11foCqDAyedwdL3xi8JDEUl1G/KqQw/iwe1Hyrjb8NKRqbhpJ8oA==
X-Received: by 2002:adf:e805:: with SMTP id o5mr4602671wrm.223.1573069154140;
        Wed, 06 Nov 2019 11:39:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm26237108wrb.67.2019.11.06.11.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 11:39:13 -0800 (PST)
Message-Id: <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
        <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
From:   "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 19:39:12 +0000
Subject: [PATCH v3 1/1] fetch: add trace2 instrumentation
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
 fetch-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0130b44112..5e3eee0477 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -669,6 +669,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	save_commit_buffer = 0;
 
+	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
+
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
@@ -690,6 +692,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		}
 	}
 
+	/* This block marks all local refs as COMPLETE, and then recursively marks all
+	 * parents of those refs as COMPLETE.
+	 */
+	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
@@ -697,6 +703,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
+	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
 
 	/*
 	 * Mark all complete remote refs as common refs.
@@ -716,6 +723,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	}
 
 	save_commit_buffer = old_save_commit_buffer;
+	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);
 }
 
 /*
-- 
gitgitgadget
