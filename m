Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A27D202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdGERDu (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:03:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33922 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751703AbdGERDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:03:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so22148660pfe.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ztdGhwqebkJUGiNHqlT0A6YtLHgiyZpMUVW/vpJZ6gc=;
        b=inCAHroM5HJtgP8wsoyworpdOZTKXzMqXhxZbX9EKku61fYMZ4SJEWidOb3EMOtqNi
         PNvHTwYXd48qic5BdPFAvb598kO4NoctOqakfgfzkMNuFyociVSia7TFcjGL71nG1iEl
         mxlUUo4xGh9a6E9DHCDVeNFH5MEx3UmLGh2tpbevJhyYRUVVIj5baLYEtyo5wIaWemcI
         Ng3phcEp1kuJOb4woXsaP+NOtzi6B8tjM+qasryK0L6ukoA4jMo0MgLRAhchbf+Avms5
         AolrZsmCW8TqCJgjGcSRO6Q7snwyB0BZMvX9wCoYa7KRThP19flcGmS1HBK4d5s4pIgX
         376Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ztdGhwqebkJUGiNHqlT0A6YtLHgiyZpMUVW/vpJZ6gc=;
        b=lsMErgmJ2pwrd/xURK0zYW43mb+TyObqUgIpoS9Xil5TNSKqgZFM6IyMiGDZ4d8u7D
         5wFQo3B8RdUq2M22L3As/Llc1uciC6amz8HZhmqzLWP6Iki+Fz8kmrHpUHN0PUCPBKEZ
         0Sh/mBBTbr/bmo1TWxwwFqP0lFN/b9myj7XGDVTrX7kq+WdqtkXD/SrN2DCnGrmDKmNe
         uwcvedHY1RMO7dEBl1OiIe8waEkBzAGD0WyQCxmfGJ8Um0sRfDfXS9dLBhVxYs0Ojzy5
         upa12bEG3yhPtjKqIwnp9tuNV7eyL5aGf5Zyl5NOmgMqJ1hKRmCHqsOTtO+OB8710RmE
         QhUw==
X-Gm-Message-State: AIVw111MP79GAzbiHtgwVJhM7suW14awqChXsUNh+LaTs1tzvwYWFohE
        /NH/mtAFZYTM6KgKk/g=
X-Received: by 10.84.230.134 with SMTP id e6mr22975019plk.256.1499274228750;
        Wed, 05 Jul 2017 10:03:48 -0700 (PDT)
Received: from localhost.localdomain ([117.209.134.242])
        by smtp.gmail.com with ESMTPSA id v17sm67132095pgn.4.2017.07.05.10.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 10:03:48 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] comment: fix a typo in the comment
Date:   Wed,  5 Jul 2017 22:33:24 +0530
Message-Id: <20170705170324.21026-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.29.g419244dab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Though very trivial, I wanted to correct this as I didn't
 want to ignore it after seeing it.

 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac0..aff6bf7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -984,7 +984,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
 	int i, eol;
 	const char *nl;
 
-	/* Check if the rest is just whitespace and Signed-of-by's. */
+	/* Check if the rest is just whitespace and Signed-off-by's. */
 	for (i = start; i < sb->len; i++) {
 		nl = memchr(sb->buf + i, '\n', sb->len - i);
 		if (nl)
-- 
2.7.4

