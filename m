Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2041F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 14:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKROwQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 09:52:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42190 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfKROwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 09:52:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so19832320wrf.9
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ip7aGdiQSJlv8DMallyvFhZMl3mNcDRoxqLPBRE7Wxs=;
        b=L3laqrPFWQbLChHpqcgGAt1yMr8x+o+7CLYOz/pm9OKERUklAbLNVPOPBdEHuJrUAh
         lhtrHljddPI+2FluofCgWFgNpCwpu7QNgbjpHUTjysk2Gso7S4lMZioQBvf6wm3itCkw
         64Omgcl/+2i69In3+eIumPuWsZywdTJDfGjdr45RlJSqzq9iQZCvbZRSqFAIxCgk2aOe
         +KY0Y14WcnnKspc5tTlNyNJtTdI9yPBo0V3OTRxcV4CKItkLCrOo1GwnACPXScYp5Se+
         6HOaNDGHlB1rxy2ny1rUs8ARNwztL4+EighrI7nKaHz0Is4o8pDBjAWWR4zkNSHKG65w
         fvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ip7aGdiQSJlv8DMallyvFhZMl3mNcDRoxqLPBRE7Wxs=;
        b=itKpis2R/Di9ln6JGivExg/eSjwd/ECMZ4leakrdsUsTp6fwsxquXYKpFJnt/FZ/DV
         v2IccIUyPBHC5RTp+SIIh5KgbElXGlTi7lsHwTSoLrrUcQhnrZ1ErODVjuw62mdb0pg6
         ROGvpbhheLz3ZA6PuDJ5HjLP+cGf73iNUBgZeZdteEn19UlBqVMywYp2iRiDT33SLjuZ
         yHKnzml6PNb3/7fEzhluSFZCid/1fMWAFYuDRrCEQH+tGp1rzL1QgAwoSIzt+3TPm5e4
         OtT+73PHRaTxkM+VJt/z8wMbcXVfX2M2MaCC576IQiUj14VouUXwOa05zR6fErZK+8ec
         P2GQ==
X-Gm-Message-State: APjAAAV0z2gbKetk69DY5SirpG59hXGRsBZoGIXj6d6UQRqbVE6+Jt74
        2DiLZLTE/lL8HmMCOQFsPNP9HLlRzxI=
X-Google-Smtp-Source: APXvYqwUVBLhZjvhHVBd+naoZGQO8CE4cdDUj3hFKWtVsk9Enx1ZzLLIDKK4S/BToLcZmcAg6EERDw==
X-Received: by 2002:adf:f987:: with SMTP id f7mr30443708wrr.284.1574088734171;
        Mon, 18 Nov 2019 06:52:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm23043288wrx.15.2019.11.18.06.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 06:52:13 -0800 (PST)
Message-Id: <508d07a3eb035697813af253eaad739a880124da.1574088732.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
References: <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
        <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
From:   "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Nov 2019 14:52:12 +0000
Subject: [PATCH v4 1/1] fetch: add trace2 instrumentation
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
    * parsing remote refs and finding a cutoff
    * marking local refs as complete
    * marking complete remote refs as common

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen <erikchen@chromium.org>
---
 fetch-pack.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f80e2d1149..bca70e65c8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -669,6 +669,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	save_commit_buffer = 0;
 
+	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
+
+	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
@@ -679,7 +682,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (!o)
 			continue;
 
-		/* We already have it -- which may mean that we were
+		/*
+		 * We already have it -- which may mean that we were
 		 * in sync with the other side at some time after
 		 * that (it is OK if we guess wrong here).
 		 */
@@ -689,7 +693,13 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 				cutoff = commit->date;
 		}
 	}
+	trace2_region_leave("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
 
+	/*
+	 * This block marks all local refs as COMPLETE, and then recursively marks all
+	 * parents of those refs as COMPLETE.
+	 */
+	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
@@ -697,11 +707,13 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
+	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
 
 	/*
 	 * Mark all complete remote refs as common refs.
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
+	trace2_region_enter("fetch-pack", "mark_common_remote_refs", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o = deref_tag(the_repository,
 					     lookup_object(the_repository,
@@ -714,8 +726,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		negotiator->known_common(negotiator,
 					 (struct commit *)o);
 	}
+	trace2_region_leave("fetch-pack", "mark_common_remote_refs", NULL);
 
 	save_commit_buffer = old_save_commit_buffer;
+	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);
 }
 
 /*
-- 
gitgitgadget
