Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F4AC433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382177AbiD3ES0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357504AbiD3ESA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCEA3AA56
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y21so11075578edo.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z07EZ5wZW6TcHs4qgsCv46FQpUpTOc9rtYErKTAeasc=;
        b=QiFfSpBZm5gSpbQsUOTCHXz9K5SZRlvA/KGYIfDfiaLgrUxWXA6REG3aoMumZw9H+0
         tURG+9kyPAo8il55OTkbAfr+v0vsKI1SGKkujxSBxWIer4YnQSWnAZ3fvOqr32E8Ck3D
         Kzy17amauJGAoB+yVIihMk4xBL7QDBQGuBEAlhI492VgCk0hWT/68CNk9Ht3a1kviMP1
         3OnTLzK7EvGqnAMw1p0kwxALPrCJtwKKjB8JI1GuGFE9SYpO6vlZSDNvy38l3FoUXjaq
         ONKCc27A89Jcp3YIjEYTMyMMAjny5bMKw3oUvQp228hslauXrGgtfEyVw5+bm0XZubXc
         D2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z07EZ5wZW6TcHs4qgsCv46FQpUpTOc9rtYErKTAeasc=;
        b=hRL/nIEmz+ZCuwuYJLBYi5EI09xWZOBTT+5fs87SAhz9KGBSB5a9W7487MWEanR6y4
         KuWRGrqN2RGHzKYEY6XcLe9T/j9adzuRyZYbtnYBcAOSFry3pwAtTHPi8653tVfY9CK3
         jNOMnGnG9HzPemWpLrrBfK56bCdRXycdYkezajK3l26kX7Y64R4cCL2wyv6MG/dzQoMs
         uAd+lTaYqMOsDMBOr8k3waWKO/4m0OOBiXLFMNnNHuGIyJkkZE8V9i2C3OsbZV5U8B0p
         qaEWJ1UzJkj7hVn/dEMEw1b+ULnElxnvyhQ6sF/m5biSu8OHOPqPh+T67mDDVvPVINpj
         LJew==
X-Gm-Message-State: AOAM530luJ4vc7bkSng6uKsFCbODF9wSh+yHj+x+0TlgJkcF+pvQAIFU
        1GZdRRnEEPJ9myimiPqXZjZT7Cs2rho=
X-Google-Smtp-Source: ABdhPJyrrir9Thz9bstlIhr0aEz8MV12xF05YHr96M8pUeoFBMB3ljum3RPH8okhlnBh1JxMwXezzA==
X-Received: by 2002:a05:6402:2806:b0:420:713f:b5e1 with SMTP id h6-20020a056402280600b00420713fb5e1mr2639895ede.93.1651292077952;
        Fri, 29 Apr 2022 21:14:37 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:37 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 16/23] builtin/pack-redundant.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:59 +0000
Message-Id: <20220430041406.164719-17-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430041406.164719-1-gitter.spiros@gmail.com>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adhere to the git coding style which requires "Do not explicitly compute an
integral value with constant 0 or '\ 0', or a pointer value with constant NULL."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/pack-redundant.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 8bf5c0acad..ed9b9013a5 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -101,7 +101,7 @@ static inline struct llist_item *llist_insert(struct llist *list,
 	oidread(&new_item->oid, oid);
 	new_item->next = NULL;
 
-	if (after != NULL) {
+	if (after) {
 		new_item->next = after->next;
 		after->next = new_item;
 		if (after == list->back)
@@ -157,7 +157,7 @@ static inline struct llist_item * llist_sorted_remove(struct llist *list, const
 		if (cmp > 0) /* not in list, since sorted */
 			return prev;
 		if (!cmp) { /* found */
-			if (prev == NULL) {
+			if (!prev) {
 				if (hint != NULL && hint != list->front) {
 					/* we don't know the previous element */
 					hint = NULL;
@@ -219,7 +219,7 @@ static struct pack_list * pack_list_difference(const struct pack_list *A,
 	struct pack_list *ret;
 	const struct pack_list *pl;
 
-	if (A == NULL)
+	if (!A)
 		return NULL;
 
 	pl = B;
@@ -317,7 +317,7 @@ static size_t get_pack_redundancy(struct pack_list *pl)
 	struct pack_list *subset;
 	size_t ret = 0;
 
-	if (pl == NULL)
+	if (!pl)
 		return 0;
 
 	while ((subset = pl->next)) {
@@ -611,7 +611,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 		while (*(argv + i) != NULL)
 			add_pack_file(*(argv + i++));
 
-	if (local_packs == NULL)
+	if (!local_packs)
 		die("Zero packs found!");
 
 	load_all_objects();
-- 
2.35.1

