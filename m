Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580061F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeELIAt (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38991 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeELIAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id j193-v6so11056164lfg.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rab1WhVYyPMAz03helNiPmDp8AhqosrHcVoH2fiNsmQ=;
        b=M+3OiSsbeUitvB75pHhKBfxkt18k2iRck3Lz3pXcLgDbRbR8yI4XQssmTlqgv75+nM
         2a+5gv+8tNUHBWhcACi3UARM7C2oIhBzdc1Dh1e9GtI+whaC9mgUnxRbzkEg3OYGNGio
         Ww/E3MquMtijQSpm5hSQVtUvzXTVd5ljf21hnzLmDnKNrKrmbmf2XKcmejH/4vG6nMrP
         AIIoEM1kloiaE9DkwJMkgCTVaE2NhaFOmd3C4CVxl0uCBt/3cxL5aFYa5cFTOHpzGBZa
         L+tN3yofx96W+JqUn8tzBK2WzIuqbsmnHjRmSuMPvlk8RFxddgg6C7U4Znl1LevwjK5l
         5+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rab1WhVYyPMAz03helNiPmDp8AhqosrHcVoH2fiNsmQ=;
        b=PvVjWaRffARsOJo6i37EOmRu6Z/ZnksQdfNpEQSXYBhjazbpDcQhViSVE6FmvZWd+G
         QC0kE6TPc9g6a1cZhpPfpEHSkp2CWoEQId0NQOVCcmEFm90zwPnoAQ1qhPpUB+yWsGjZ
         HuSpJLK8ffWsz1+xFbBlaVxI6HnSjpw9/senrdxGIKA39cPAc1AqSVnG4JijJ7W8AYst
         OwdKoWkPAQWQhl5kAaBBxyOpyKhDhlGtvDIfXneAb1j/jvIvSzcOrWgYF6WfMFToZALB
         X1GVt+ivU0tSLXLi5dY0Vkug8vqM1VCCIF8Jvca0rM6IHy6eGU1kMn/uMf8Gzeh0vEp3
         5F0A==
X-Gm-Message-State: ALKqPweTdK7i9sZX7xQqLwjfxN4adjHQoyPICw+QVXm9K2Kv34PCujtc
        eFbi+GqqwSxYJj49+hSQy1Aclw==
X-Google-Smtp-Source: AB8JxZrnZfH0hP+a0/kaXX9oVqK+HwUrjT6nozrY3YOq9ZfKglZ4q3z2Vo8hKLODCpLJFUYCnpzh5Q==
X-Received: by 2002:a2e:9d95:: with SMTP id c21-v6mr541071ljj.89.1526112044210;
        Sat, 12 May 2018 01:00:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/12] commit.h: delete 'util' field in struct commit
Date:   Sat, 12 May 2018 10:00:28 +0200
Message-Id: <20180512080028.29611-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have come this far, you probably have seen that this 'util'
pointer is used for many different purposes. Some are not even
contained in a command code, but buried deep in common code with no
clue who will use it and how.

The move to using commit-slab gives us a much better picture of how
some piece of data is associated with a commit and what for. Since
nobody uses 'util' pointer anymore, we can retire so that nobody will
abuse it again. commit-slab will be the way forward for associating
data to a commit.

As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
architecture) which should help reduce memory usage for reachability
test a bit. This is also what commit-slab is invented for [1].

[1] 96c4f4a370 (commit: allow associating auxiliary info on-demand -
2013-04-09)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 838f6a6b26..70371e111e 100644
--- a/commit.h
+++ b/commit.h
@@ -18,12 +18,16 @@ struct commit_list {
 
 struct commit {
 	struct object object;
-	void *util;
 	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
 	uint32_t graph_pos;
+	/*
+	 * Do not add more fields here unless it's _very_ often
+	 * used. Use commit-slab to associate more data with a commit
+	 * instead.
+	 */
 };
 
 extern int save_commit_buffer;
-- 
2.17.0.705.g3525833791

