Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB598202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 16:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdGGQC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 12:02:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36690 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGQCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 12:02:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so5143520pfk.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q5ciXaRrLVztyYy+/R790/Bj65ZlFoyQDxsFzYIxwlM=;
        b=eMdJyv11dcdenCnmR9WCUlu14I1sCxwzGgm7tSBnMdiIdJuoXn5aD+Jsvr9bcUUDBB
         uEID85cSxRqA3XMvNgeNCi4vOpv3sZXz55at/C+dhdknXsUWyNRA8JB7209L3vMHc9/A
         aRHDCURWrwgujMPHiHa0VDNNQWza5d1qCg9lj0hDRgRWwK8R/nUpCoa/XjUXhOSW0zwQ
         Jzy7pLuRyExXJv9ShArtoIcRD9VMkHNeUrOvsvPwLdq/yQJCu34MlmBEUiQxocOaFFnr
         vkr4U46nvkXSsBVnlBYxkJQVmYkDsSvfoLoqEhxxK+tnc+M/hrVS34c5b9zReT22GnIp
         LdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q5ciXaRrLVztyYy+/R790/Bj65ZlFoyQDxsFzYIxwlM=;
        b=Q+1ycSOpB+APrRTcT0e5iC8H1ztv93zICRrwExTnOu1lmfQqXKC+eJN+wTKpln2cvr
         r00bYORYCQNOTF32Ja4jNw+itoODgi2oy0KFnmHtQgUjpp5wCfYXL66TlhJEv3YQOS2a
         oAYXbx4jnWO8XpVwVkLuSTBsQ7TbcEJkpKMx8ZcABsnbP02mUJAhlU1HtzE3l3WQL1jX
         mrhg7QPI0YBGGfzxRRc+sI1eikkSIswzdmbeFWM9sJjn+EjdwHaerPX5jfJ+yGdtBoxN
         mtRoQtMNqnkx+oXugP22KK0bkr4gC/uMfN4wwyHLDudWVC/XlJ75HPRG652Gs7S+S98U
         oKew==
X-Gm-Message-State: AIVw1123jEHTTfuMxlHLxaGiu9r8XnR34R83QnZby30a6uAv+YknPcN2
        NPWdy1Utp6ODneD/BXvjUg==
X-Received: by 10.98.193.197 with SMTP id i188mr32090153pfg.215.1499443374516;
        Fri, 07 Jul 2017 09:02:54 -0700 (PDT)
Received: from localhost.localdomain ([117.202.243.248])
        by smtp.gmail.com with ESMTPSA id r63sm6555444pgr.65.2017.07.07.09.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 09:02:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] commit: fix a typo in the comment
Date:   Fri,  7 Jul 2017 21:32:48 +0530
Message-Id: <20170707160248.9611-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.879.g2ab69f31a.dirty
In-Reply-To: <xmqqtw2pft5p.fsf@gitster.mtv.corp.google.com>
References: <xmqqtw2pft5p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..aff6bf7aa 100644
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
2.13.2.879.g2ab69f31a.dirty

