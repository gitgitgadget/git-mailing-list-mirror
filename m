Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0C31F462
	for <e@80x24.org>; Fri, 24 May 2019 12:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391500AbfEXMXu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:23:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42163 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391289AbfEXMXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:23:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so14108489eda.9
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CgOZPV9l5cjUckmd1qbMi96Bug1liWqGmAlp/eN3OUc=;
        b=AlJcDyoyzNq3BaMyj5e8H4vQiaps2vEy8IVW/+4sbzXsPfKOcAHKakrprfl8Qp1D32
         S0PTnct6G84ioOdBJ64EvPk2lYnu4bENqFvDdJc1FM1vi0WKNtRDBNlWoKfeOdC4c6S4
         0DWlc+Qvgq2Icw69rUqbr6ryH1tk1oRpYd4rbwOePrO2GPua1NteusUoja3KvjXCSjO3
         M6KslBEDzGN6+mfhM2Q5zLoMgg8LeBkcCpairv+spD/Uzecs7pkMHnp8b0OysJTOtVsz
         ep6n2YcdG+DTAd7+ASjngeVV+8o2Ao5eXgOmXn5ejrcQ8nE/85EyVvYmWyLiCxQ/jyXe
         RjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CgOZPV9l5cjUckmd1qbMi96Bug1liWqGmAlp/eN3OUc=;
        b=qjPE5hT3ylI5amkw2AG7UaGNTNxYNwUSkbsbDd3MND+P9KxQKByvoHergLRA3uvQJT
         2PYgBzDc9tnSAYwi2cXQyPXH973De1jccgyW4mU3QUPPWDPRpFY8itwVirUiaZSSfRl1
         ymiJgKOe/1pMv0JAca5FdvpbeDanVBuIzOOH3dYFBU7BF8u/yU/x0Ov9iAx4rH4/7aNB
         Rs2p5A4AifJrOqw+9pHIoGBVEzDZPWKis2H2av18WnyjpBbv8fcIHF7LBbdJ9EBZr69p
         sl7tuA1kZ9w+alL/3vzAynrw8IFwIV6LLr5lk/lLC4qq3FwpMkRICWZcWI0lTHxDaUCZ
         f8aw==
X-Gm-Message-State: APjAAAUuOnwZ6ntcgYDpdg8ZKumNlXGf9cWF9yogU2PdCmB3Tll1RaxJ
        ykSFthbiajZLZKMq/DaH+gvQoNiU
X-Google-Smtp-Source: APXvYqyW804Yb4uTN7xLVkepgV08HIr6CxtnwriiartYu1ermiT+UFFMcK6GIHFMPMIm6EEwDFHgsA==
X-Received: by 2002:aa7:c403:: with SMTP id j3mr69026022edq.144.1558700627799;
        Fri, 24 May 2019 05:23:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id mh2sm346604ejb.33.2019.05.24.05.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 05:23:47 -0700 (PDT)
Date:   Fri, 24 May 2019 05:23:47 -0700 (PDT)
X-Google-Original-Date: Fri, 24 May 2019 12:23:44 GMT
Message-Id: <232eb7a33bbb4863a1ae69000186f7338cdcaa63.1558700625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.223.git.gitgitgadget@gmail.com>
References: <pull.223.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] fill_stat_cache_info(): prepare for an fsmonitor fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We will need to pass down the `struct index_state` to
`mark_fsmonitor_valid()` for an upcoming bug fix, and this here function
calls that there function, so we need to extend the signature of
`fill_stat_cache_info()` first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c                | 2 +-
 builtin/update-index.c | 2 +-
 cache.h                | 2 +-
 entry.c                | 2 +-
 read-cache.c           | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index f15afa9f6a..4992eca416 100644
--- a/apply.c
+++ b/apply.c
@@ -4310,7 +4310,7 @@ static int add_index_file(struct apply_state *state,
 						     "created file '%s'"),
 						   path);
 			}
-			fill_stat_cache_info(ce, &st);
+			fill_stat_cache_info(state->repo->index, ce, &st);
 		}
 		if (write_object_file(buf, size, blob_type, &ce->oid) < 0) {
 			discard_cache_entry(ce);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 27db0928bf..3f8cc6ccb4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -280,7 +280,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
-	fill_stat_cache_info(ce, st);
+	fill_stat_cache_info(&the_index, ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
 	if (index_path(&the_index, &ce->oid, path, st,
diff --git a/cache.h b/cache.h
index b4bb2e2c11..bf20337ef4 100644
--- a/cache.h
+++ b/cache.h
@@ -826,7 +826,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st);
 int match_stat_data_racy(const struct index_state *istate,
 			 const struct stat_data *sd, struct stat *st);
 
-void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
+void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
diff --git a/entry.c b/entry.c
index 0e4f2f2910..53380bb614 100644
--- a/entry.c
+++ b/entry.c
@@ -373,7 +373,7 @@ static int write_entry(struct cache_entry *ce,
 			if (lstat(ce->name, &st) < 0)
 				return error_errno("unable to stat just-written file %s",
 						   ce->name);
-		fill_stat_cache_info(ce, &st);
+		fill_stat_cache_info(state->istate, ce, &st);
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		mark_fsmonitor_invalid(state->istate, ce);
 		state->istate->cache_changed |= CE_ENTRY_CHANGED;
diff --git a/read-cache.c b/read-cache.c
index 22e7b9944e..d3b43ae3ba 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -195,7 +195,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
  * cache, ie the parts that aren't tracked by GIT, and only used
  * to validate the cache.
  */
-void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
+void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st)
 {
 	fill_stat_data(&ce->ce_stat_data, st);
 
@@ -728,7 +728,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	memcpy(ce->name, path, namelen);
 	ce->ce_namelen = namelen;
 	if (!intent_only)
-		fill_stat_cache_info(ce, st);
+		fill_stat_cache_info(istate, ce, st);
 	else
 		ce->ce_flags |= CE_INTENT_TO_ADD;
 
@@ -1447,7 +1447,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	updated = make_empty_cache_entry(istate, ce_namelen(ce));
 	copy_cache_entry(updated, ce);
 	memcpy(updated->name, ce->name, ce->ce_namelen + 1);
-	fill_stat_cache_info(updated, &st);
+	fill_stat_cache_info(istate, updated, &st);
 	/*
 	 * If ignore_valid is not set, we should leave CE_VALID bit
 	 * alone.  Otherwise, paths marked with --no-assume-unchanged
-- 
gitgitgadget

