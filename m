Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A9A21F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfARNY5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:24:57 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45674 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfARNY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:24:57 -0500
Received: by mail-ed1-f41.google.com with SMTP id d39so11063217edb.12
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ysrGNt4wptIdVUX2D1sqj5wCpqMiFh/X/8BFzg3m0ro=;
        b=DqKzYSWJvYrBFwYE90muCMgw1d7LQsfne+TMRggA2Wkcc2RfoR5vRq4nbqPvI7VAjv
         f0rWIIHD+lMeG+d3Cd4+Np0lYM+PIGQtN0/YLtkHrO3DQJU4VBpX5vLu0oBXLpUkCH6f
         50thp3aQb9YaDKwwtu6JwlOWihC4XzRKglsgCUlNFirqZbntRje0ShMZIwx7dndaGJ8E
         oNJe+8IrRaEJfUXGOV6Ehqm9XAJEAGo1CIxp/BeHqfM3Y1fkSTeCJK9IXK8bVYuCxoXG
         ty3Nsy2WVqfRiOFDQ0HqTZeaE0v1+iV8LU37Swf0juHF6PQHtEQPB86NvWXzW94EmsKh
         njNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ysrGNt4wptIdVUX2D1sqj5wCpqMiFh/X/8BFzg3m0ro=;
        b=dvQcdSiG4KpuWVKzQ6ENekxsQvXsmMHNU9FX93ev9imyamJ+wGoY2ZBZDOYhfmSLyp
         K2L5o592l2Os7c+q8U5V/d27ksvY2c/6v2YuP+Bk+2aq//8yVbfZ0IumIYyLw7iQmNJg
         uLJNX2BjFxJjkPqt8LolGHcsJ0IMyaQQzkGRu+Qn47J3Xl2qCF2oyD+TUc4Q7DzBYcNG
         Efljqj2S6bbpVINZNdm549yNXIRxlSKHUeH82hzymeituwdB9vwzkRX5z4ulzg+Q9vZw
         7JoS9wNB4IVD+gXxzRRLIAKzrQDyVZaA1xgNwS5xAi/++vzs6XQ8bNJo8m08f63Hh8mL
         Dwng==
X-Gm-Message-State: AJcUukcoSrIvhUT0NWZBhzfZ/w5EYqBf+fpcy2iTNqdrzcto/zVtzFwn
        qs+nGjuSkRRsvMIRl4iw/1H9i6jd
X-Google-Smtp-Source: ALg8bN6lJ+IPnN4Wr1PtaA9nRDE4Xei9IaAlr8l7CvpV7qiClAuOkel1BS6IhhmWZNFAZU+lFej0ng==
X-Received: by 2002:a50:88a4:: with SMTP id d33mr15834460edd.261.1547817894879;
        Fri, 18 Jan 2019 05:24:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h47sm7332698eda.8.2019.01.18.05.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:24:54 -0800 (PST)
Date:   Fri, 18 Jan 2019 05:24:54 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 13:24:53 GMT
Message-Id: <3fb927fc77232279c1c85db003a5f55de4eabd29.1547817893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.v4.git.gitgitgadget@gmail.com>
References: <pull.104.v3.git.gitgitgadget@gmail.com>
        <pull.104.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/1] abspath_part_inside_repo: respect core.ignoreCase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

If the file system is case-insensitive, we really must be careful to
ignore differences in case only.

This fixes https://github.com/git-for-windows/git/issues/735

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 1be5037f12..291bfb2128 100644
--- a/setup.c
+++ b/setup.c
@@ -39,7 +39,7 @@ static int abspath_part_inside_repo(char *path)
 	off = offset_1st_component(path);
 
 	/* check if work tree is already the prefix */
-	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
+	if (wtlen <= len && !fspathncmp(path, work_tree, wtlen)) {
 		if (path[wtlen] == '/') {
 			memmove(path, path + wtlen + 1, len - wtlen);
 			return 0;
@@ -59,7 +59,7 @@ static int abspath_part_inside_repo(char *path)
 		path++;
 		if (*path == '/') {
 			*path = '\0';
-			if (strcmp(real_path(path0), work_tree) == 0) {
+			if (fspathcmp(real_path(path0), work_tree) == 0) {
 				memmove(path0, path + 1, len - (path - path0));
 				return 0;
 			}
@@ -68,7 +68,7 @@ static int abspath_part_inside_repo(char *path)
 	}
 
 	/* check whole path */
-	if (strcmp(real_path(path0), work_tree) == 0) {
+	if (fspathcmp(real_path(path0), work_tree) == 0) {
 		*path0 = '\0';
 		return 0;
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 37729ba258..be582a513b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -402,4 +402,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
 	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
+	path="$(pwd)/BLUB" &&
+	touch "$path" &&
+	downcased="$(echo "$path" | tr A-Z a-z)" &&
+	git add "$downcased"
+'
+
 test_done
-- 
gitgitgadget
