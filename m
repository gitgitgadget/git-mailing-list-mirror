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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3F11F609
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfFLN3j (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38216 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfFLN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id g13so25762642edu.5
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eSEy4lb7WYgAWpgS/k1w9gk9+9sz/RGuF/mmdJjwxO0=;
        b=X3DGPyQZPZmsD5MTQTkgpOo9n/SkaiiY8zBSFH2c/kbFbLtu5/bmYe1/EbzaiF3WO1
         H3PVYjwzr+ZZqKzFs4Y6+WDrzbyYU6rPSQARjoAeSyjIxPFsPXcjXABV5+PqaOksK2ep
         T6jyfiX4MA5ukVAQC5cQAPo/UZEbaHqjQZ3xjHr9E5ebITiGLU93CSKdBUK4OIikplQZ
         vwfXVbnorAd+bhRgIWOriyv+Nq//MFduRdOPi3dTk3qbOk1mKRCfL7t9lOfyANDJsK7e
         mxRsVTyvcaGnok1rcSefTSkiyz9Dk28L303y23/Y3XfJlUhBxMv4hqWw5SQ3E9gPXPz4
         eOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eSEy4lb7WYgAWpgS/k1w9gk9+9sz/RGuF/mmdJjwxO0=;
        b=r9DsHbaHzUobUxjiEEUHYKOV9VvJOTTcmUNLn6xCZyH8GljMahbEOnQhslINFJHJDl
         QQ0sjvXnRpkKEiaJiQnFKg66x7Lb6dR4l/AhMovRnNqujgnns2B/8p8luaw9q+Q1bif1
         3Ji9+PRVlaIOM2aQOtKU+DoFBsAbDXbrnP+iuuW8GBhtiFJmKgdvr8Xea4bKUyFxTquK
         KRsodCiwmUjGcydqDfCHAfwwEakiAELF4eWIZCSqWSR62gkhBVpTOyKrG6YXDqDuaHc+
         jUHAF8kVZRzXd/UUtOJd3rvoT//fyeIDYZWPZXcklmoXvA2VOrkAodp2XQRjCDauEZdh
         8qvw==
X-Gm-Message-State: APjAAAVaCc0XIW0rpErcOuRdJypLQbUQGXAW6jX+cco+RoPuN09rcLcW
        9KD0Mbq4pPFIQWibD7+dz0ar6Vqg
X-Google-Smtp-Source: APXvYqyUJqgN2aF/0uLK8khl01C9JlCWZ0u0KqyW4c7iLKwOLiDW74kIGcCjYYrVNoidI2XVTlcRmw==
X-Received: by 2002:a17:906:7e4b:: with SMTP id z11mr14632287ejr.214.1560346177077;
        Wed, 12 Jun 2019 06:29:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d28sm2558829edn.31.2019.06.12.06.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:36 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:36 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:23 GMT
Message-Id: <0be7713a255d6f52c51ccb19299d0c9797e9a03f.1560346173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 01/11] commit-graph: fix the_repository reference
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The parse_commit_buffer() method takes a repository pointer, so it
should not refer to the_repository anymore.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..e4d1233226 100644
--- a/commit.c
+++ b/commit.c
@@ -443,7 +443,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	item->date = parse_commit_date(bufptr, tail);
 
 	if (check_graph)
-		load_commit_graph_info(the_repository, item);
+		load_commit_graph_info(r, item);
 
 	return 0;
 }
-- 
gitgitgadget

