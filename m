Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5071F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfJCRxg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 13:53:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45412 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJCRxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 13:53:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so3654595wrm.12
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jIBXv3DlHqIsSe/4Rq1VKPbVA4MVYItFN4oZyjG2Qic=;
        b=rqzgliV8bOWw6ra71MDKnkhMpSXjDpViLbiwPWWJT7kMaVn0nCN60tb2CLcKU9l0Zq
         /LlDXGKh7ZSa8zucvXmfQ0mLVwApZ7ZBKHw7HWOd2b99m1XoasDMe4NyLkcvpyWDPMvI
         lxrXeqFloYCHBqTZC82odRAQYDUnKgbVSB8TzMjHhYPgW41QPG/j2Q6XfVhalVf41piv
         bSGtYfBvIFyGbWbuoSfCqfFKWvKo7mn2k6/R5HQd3XA/OHo2FjbrY6DbNYyxMHO0rNPx
         BKD+7X0hpl/gCjysoc/ggGmxhFRmrJbmaQadN0/4fQyvoGHcZNyvlZniLWh8kKJ3DJ1f
         QvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jIBXv3DlHqIsSe/4Rq1VKPbVA4MVYItFN4oZyjG2Qic=;
        b=OgVtZgYJILOVpx8Pwjg43P0t7kX5fWDEZPr3G1N6LuE0yPkF+8YR9TyMMlEAqdSrKV
         PFybsgmFPDPbDjymeEqa64QFRioaT3fCQQyZrNZuFo6MaqbY58kd6Jv6Sfxg8Xoyx6p1
         XY3OM1fqVWotd54GdDZqU03kVEdfnpXEdaKY6gkmd99AxBrFpqgiSlWqlZFueTvhn7Bb
         biOnWdyH6YolWsARnH4rgGrCKYyrg/2Si9GEYOfcVE7ql/B2T3z904BlGVLTQeJnD40E
         UV0e4MC6rIqm0usBkDyYFDj/5i3ACaHUB5Y+88+m1l5nNWzwLk5cT/kQd/+UoTCT/PGX
         Qybg==
X-Gm-Message-State: APjAAAVeQ/k09J4IqQp0PpavW3mmFDUfhglR74kgX7T28ly30bgXrrQD
        kxybDHRlv5UHmqe2sbdQjan3Nb/m
X-Google-Smtp-Source: APXvYqy20z/s6E+x0CQSjeHQaEtFlDrenXOEQ/2c4Ryzk8CrNyojOdNzdbDnpVSiyfaqMGa6q5UZIg==
X-Received: by 2002:adf:f801:: with SMTP id s1mr8296008wrp.293.1570125214121;
        Thu, 03 Oct 2019 10:53:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm4182712wrh.5.2019.10.03.10.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:53:33 -0700 (PDT)
Date:   Thu, 03 Oct 2019 10:53:33 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 17:53:26 GMT
Message-Id: <d741dc60bcd05093894e3a258fc95e9b26592d12.1570125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com>
References: <pull.337.v2.git.gitgitgadget@gmail.com>
        <pull.337.v3.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/6] midx: add progress to expire_midx_packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Add progress to expire_midx_packs.  Progress is
displayed when the MIDX_PROGRESS flag is set.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/midx.c b/midx.c
index 0808a40dd4..f14bebb092 100644
--- a/midx.c
+++ b/midx.c
@@ -1206,18 +1206,29 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct progress *progress = NULL;
 
 	if (!m)
 		return 0;
 
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
+
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Counting referenced objects"), 
+					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
 		count[pack_int_id]++;
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Finding and deleting unreferenced packfiles"),
+					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
+		display_progress(progress, i + 1);
 
 		if (count[i])
 			continue;
@@ -1235,6 +1246,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 		unlink_pack_path(pack_name, 0);
 		free(pack_name);
 	}
+	stop_progress(&progress);
 
 	free(count);
 
-- 
gitgitgadget

