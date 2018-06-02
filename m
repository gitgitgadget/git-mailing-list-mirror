Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8455E1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeFBEdu (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:50 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:46412 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeFBEdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:10 -0400
Received: by mail-lf0-f51.google.com with SMTP id j13-v6so13160864lfb.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BSZACuIHt71vhDC7FnLnNT4sFBg+4RNugY68KHLXfc=;
        b=RAqDdQAzD3+eEzKFthlZBARO6MvbtD9xt0hto8ubHRq0c/Ku8pq35Zlj2YhNxXsqzK
         zBIwqmvXFHz4w+OQWKrwHp/R+GZuFPpwVZPepc3rXXeDQWNSxg2FFtGeiDxT1Xw1cMnI
         8ogCMNXLS5rl+OndgwkgowmKT5JDqXQuVrT2u86DQRWVVtp7pwqprtTi//NrDEeXLzv/
         MeIXzZyhbCS2nwv4rpMHIPqqltOIz9EWSiRVd4oYb2aM0aRwHQBKJRcj0vCctMThVfWd
         eMqPX2E8iHHG00Pf8lZLZY8MoK7yPo8BA7psfYf4LpMUvCJTGjRXrPmm7N+ot5JNrfTL
         5KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BSZACuIHt71vhDC7FnLnNT4sFBg+4RNugY68KHLXfc=;
        b=U528Mq4H8dKbgL04Z8acZb4PHaR/K0x0yYhx1OM7KSKpATipdC/5MzujeVQ7ux5llA
         Q++Kz0Kn2aKtNkMCdamXr/a1wPRV+vEgbeAQA+3UnSeTuw6OAc3frB8l+v5oGEiAznK2
         5j6E/RfdL2t+Bwcy3iq6SGvdeplbyAm6C9CxehMYVAomVAFiu+7iQYGQi4iyjIT1l6Gu
         oeo5EyBPsxJ58NjQMdijrSm/qYZpCXS8Y0vqi94/E/ln+9/BZigFMgz4NzaHkaiyngeS
         88wyqSEgm20Vt66S2A5GjaLFk2xv0x8WaqIg3tmDrEZjrbQloHQe967WGqtGd/p0nUD3
         duyw==
X-Gm-Message-State: ALKqPweKlrl1iJjYs639hQFaft3ngCv2GDGZwRD8HVXnwr7fu2++jqgG
        lp2mcI9XnZiWZUf5chS8xA6CzQ==
X-Google-Smtp-Source: ADUXVKL7TqpJUlosJMst8fz1x0TbU1uix3v/8JXGt12VfjgR0/YAMbvSyIjzC0RYOvPmDCs06FwFTQ==
X-Received: by 2002:a19:14ca:: with SMTP id 71-v6mr8451639lfu.126.1527913988467;
        Fri, 01 Jun 2018 21:33:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/22] refspec.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:36 +0200
Message-Id: <20180602043241.9941-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index ada7854f7a..1266e509c2 100644
--- a/refspec.c
+++ b/refspec.c
@@ -127,7 +127,7 @@ void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch
 	memset(item, 0, sizeof(*item));
 
 	if (!parse_refspec(item, refspec, fetch))
-		die("Invalid refspec '%s'", refspec);
+		die(_("invalid refspec '%s'"), refspec);
 }
 
 void refspec_item_clear(struct refspec_item *item)
-- 
2.18.0.rc0.309.g77c7720784

