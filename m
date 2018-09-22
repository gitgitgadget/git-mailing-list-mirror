Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC981F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIVX7k (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:40 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:41315 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeIVX7j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:39 -0400
Received: by mail-lf1-f49.google.com with SMTP id l26-v6so13583073lfc.8
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtGCFgJV3U1YsSNHn1/PmQGgDD2BQRUWolgFLXSi10w=;
        b=CZubsme18O0cSr8J1uLAgBtbdm/W0S9BD+6nRzDHh25GbmjS7G4b3Yv+1BEqLVq5wj
         WvdlJxh+O4wfQBkWv9GgVMiTc0m7uFI1tkWGXraGma8tiNX6BTwm9ez3O39OExuL0cp8
         g8425HgHhVo0e1wm30tx+gHism9a6qT787FFa/EuOHnyOoL6iBERIpk+3C6M5kaQzB0C
         rQo5mC847HFMxaLv0d9wpgj77FsjmraaFqywx3S/oVMDX0FDAJQCl9OSsal8SP0ut+o5
         13EsV+6BDHPVv6QaVSTOGvC+QymoCMswoTL9TFKhb6wG3dC0MeL8s8WpRAsQ0pKshPEj
         v+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtGCFgJV3U1YsSNHn1/PmQGgDD2BQRUWolgFLXSi10w=;
        b=Y0w0fwx0CXeec57P3IO49Siwq/HkzoYYeL5VQaARhUrfvqEqg95qFMXsc3BuwUgbgx
         +J5VJ8eWbN5ysnMQs0NAwtpS5UKfM/JAf55/vEG0MtYagTJOIMq97NJoLO/826sOJqOD
         bDLQIWkxQE0ZHS+e8Ay8HqHGlY9Fo9Lz+gP8PaGH/gZir2IOUJsp1F3eNYV4mSZiUW/f
         eWaxP0AGltlnfMuA+tgXtYLjnCsjO1m7Uagu1C0V2Jeqyt9c12+y1h1pLSRefJAu92Bs
         Xh5lZaIi/+HPxFS4JmLSM2QCtXDfT+zzLSBxPAsPzIHzhJTvPdb9Ba8JqlZ2QxMPnLy7
         Fanw==
X-Gm-Message-State: APzg51CfvVAoFlPOq/51O3ixI3TZNUcrDWDQDs83Mr8z/xf8ACurTSO+
        n5cj5IZ6wuKKynQyxgoN0HlPrJsK
X-Google-Smtp-Source: ANB0VdaWlXuyeahHY/z8bpz5KxBzW4SZdeigrfd6VbT9SSa8t6JIrT+4O3rslJOzJbigTLUrLNka2A==
X-Received: by 2002:a19:7112:: with SMTP id m18-v6mr1863067lfc.64.1537639512819;
        Sat, 22 Sep 2018 11:05:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/8] fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
Date:   Sat, 22 Sep 2018 20:04:58 +0200
Message-Id: <20180922180500.4689-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This will make it easier to check the HEAD of other worktrees from fsck.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 63c8578cc1..24f8a09a3c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -36,8 +36,6 @@ static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
 static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
-static struct object_id head_oid;
-static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -484,8 +482,15 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid);
+
 static void get_default_heads(void)
 {
+	const char *head_points_at;
+	struct object_id head_oid;
+
+	fsck_head_link(&head_points_at, &head_oid);
 	if (head_points_at && !is_null_oid(&head_oid))
 		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
@@ -579,33 +584,34 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(void)
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, &head_oid, NULL);
-	if (!head_points_at) {
+	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
 	}
-	if (!strcmp(head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (!starts_with(head_points_at, "refs/heads/")) {
+	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
 		return error("HEAD points to something strange (%s)",
-			     head_points_at);
+			     *head_points_at);
 	}
-	if (is_null_oid(&head_oid)) {
+	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
 			return error("HEAD: detached HEAD points at nothing");
 		}
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			head_points_at + 11);
+			*head_points_at + 11);
 	}
 	return 0;
 }
@@ -720,7 +726,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	git_config(fsck_config, NULL);
 
-	fsck_head_link();
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
-- 
2.19.0.647.gb9a6049235

