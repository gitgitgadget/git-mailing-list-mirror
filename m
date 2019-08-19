Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF241F461
	for <e@80x24.org>; Mon, 19 Aug 2019 21:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfHSVgc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 17:36:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfHSVgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 17:36:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so1930246pgp.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7UqrF6zcyJbLyw2BZAWKqeCOyIzGrZBKrLx0k1wRDk=;
        b=pQLIFO6tIwNTPGriANtAgXeWbi8jWCpdovjHHRyU35mqJfAtYOge2quS1zKaDbNAFK
         kUbenB5HV4/Y6VN2kcGZcmQwTEyei+gyRA2GoVt0W0N2PIy3Imj+jOeRnA0zghe5GGMq
         BkCc5wdDB5RxTAHLObP0pIdHwuUYuhc0mIyVycUxwfdud94SKFRx5VbTZ9Asea7bWP1v
         3lh7DsnpXreknchNIaAtj6i2u7lr016NrXz3VDY9DW2gH+pD6GOjlzg1PPQmHuEhCrND
         CDbpGELf7FOXpTXNY4drPKfdHZCvp1nwutXygUAFjoAptV+XP6h1czl/yAezoFS/PqqI
         2dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7UqrF6zcyJbLyw2BZAWKqeCOyIzGrZBKrLx0k1wRDk=;
        b=ME1bIPaT1u5osFkkk2e5UphQZJ6p//vtafLv+YZw1w1H3QdXlg0+gtEzZGZsXmufus
         JSOmppLEqNKd657T/MZWe+QII6tqSwpxdrNoCEpQdNrBoRjmdhy6KYFtjkLxgKAoYceA
         bih6L34/TM2m6ria5cDZdXZLWriGOk7FbiuOamz6APJsGGiHUkXvftxYWdMH5wZqhEH7
         W7y0SkMtKfA1Ch/b/m4ySX1PN6nuf9YkG3VvCvLByJMTYK21zMeCDHyOLiPo61GoyUBV
         I6r42sVfgQ2bsShoIguWLCpKYsIxTdl7epG9DPMDPU21YzJ+viQQ9JvXxTnmYmTQpV4n
         DGJw==
X-Gm-Message-State: APjAAAWb+zGyYxOxZfl2VgxM+aeSMzsXOTGTN32/Sht/AcaKEGDLz/U/
        cTup+gHT6kX8O7+AskelK6RuYJU6
X-Google-Smtp-Source: APXvYqw6+DzQuFD28xAVOTeuGUUZ4wzv1oYMVLuVVs9nAxwPQCAHVySqc79HIzUFKRVoBVgOTppLuw==
X-Received: by 2002:a63:b102:: with SMTP id r2mr21523135pgf.370.1566250591321;
        Mon, 19 Aug 2019 14:36:31 -0700 (PDT)
Received: from localhost.localdomain ([76.77.186.180])
        by smtp.gmail.com with ESMTPSA id a6sm17809291pfa.162.2019.08.19.14.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 14:36:30 -0700 (PDT)
From:   Ben Milman <bpmilman@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Milman <bpmilman@gmail.com>
Subject: [PATCH] repository-layout.txt: correct pluralization of 'object'
Date:   Mon, 19 Aug 2019 14:36:18 -0700
Message-Id: <20190819213618.69179-1-bpmilman@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the description of 'objects/pack', 'object' should be
pluralized to match the subject and agree with the
rest of the sentence.

Signed-off-by: Ben Milman <bpmilman@gmail.com>
---
 Documentation/gitrepository-layout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 216b11ee88..d6388f10bb 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -59,7 +59,7 @@ objects/[0-9a-f][0-9a-f]::
 	here are often called 'unpacked' (or 'loose') objects.
 
 objects/pack::
-	Packs (files that store many object in compressed form,
+	Packs (files that store many objects in compressed form,
 	along with index files to allow them to be randomly
 	accessed) are found in this directory.
 
-- 
2.23.0

