Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEC91F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936816AbdLSA3j (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:39 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43050 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934385AbdLSA3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:36 -0500
Received: by mail-pl0-f66.google.com with SMTP id z5so5884141plo.10
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1UcQBBBAkWKREHZFxNIrwR/XIJBGHIJqh3saU6IxT/c=;
        b=gBJOZ89AzE1rHQafIumhjJJXx/ODvBwYZyVObOVJwoLgc4VzFurUfu+4COXfyMZkIC
         O+pDy2J5F+cdJcQ5CnhPgwN6pz3g0pW+MubgIkTD8bwv6nTi8eC9yGpMjsQt5GfsYdZ5
         lmdm9Y/Wgycf5Wd9Wv8b9JQ9W49q2Rcd9JYkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1UcQBBBAkWKREHZFxNIrwR/XIJBGHIJqh3saU6IxT/c=;
        b=BjHlOpBlcpzlyMEDj4Rr/sIrsm+VdIfsQD6Rj3hsTnStpJNB7BVcIFLJtsT/OeVHp5
         +8mzmV6EZFc5QxEHc5Wug6GVwzVZKtv5abg+Gcx7+CwtcU6BcAYOrPrMmZFbap8rA1am
         U1YH9R0QVEqzbhL27STWFUkvRvnX5VmX/x8NX7ZfL7pci0rVhJgWU8hfcAX4QH+hVvkF
         M5JGXRenrx7Q0n+NpZPZTAM44lm+UWwOSZSyz4BTJ6PGGgZOc7CGtNenN/nu819U20l1
         yFv4aNW67AoRM5Hd5D1fbvQCDEYO1ROSpJLXt4gDH8E3EZkks0Fr/p5pVhgPn9Sx+JHJ
         0hTA==
X-Gm-Message-State: AKGB3mLPDiRU06tjdHv6q1rMU+skAJoDTKqoxpCu1E4IyPS1J7mwOR1M
        15UXUCoUwgCGQ79O4qcN2c2fjuHiFfk=
X-Google-Smtp-Source: ACJfBot7llSIDdz48VRYrsS6KqbQ9M6/pfHxvCnSJo+uBmG3sj8Cr719G5a2CaBv818GnbN6uUzjCw==
X-Received: by 10.84.252.140 with SMTP id y12mr1423976pll.13.1513643375042;
        Mon, 18 Dec 2017 16:29:35 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:34 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 1/6] Fix comments to agree with argument name
Date:   Mon, 18 Dec 2017 16:28:53 -0800
Message-Id: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
In-Reply-To: <20171219002858.22214-1-alexmv@dropbox.com>
References: <20171219002858.22214-1-alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30..cf05b1da0 100644
--- a/dir.c
+++ b/dir.c
@@ -790,9 +790,9 @@ static int add_excludes_from_buffer(char *buf, size_t size,
  * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "el".
  *
- * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * If sha1_stat is not NULL, compute SHA-1 of the exclude file and fill
  * stat data from disk (only valid if add_excludes returns zero). If
- * ss_valid is non-zero, "ss" must contain good value as input.
+ * sha1_stat.valid is non-zero, sha1_stat must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
 			struct exclude_list *el,
-- 
2.15.1.626.gc4617b774

