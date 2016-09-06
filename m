Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09321F859
	for <e@80x24.org>; Tue,  6 Sep 2016 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934911AbcIFQEo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:04:44 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35776 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934895AbcIFQEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:04:43 -0400
Received: by mail-pa0-f53.google.com with SMTP id b2so3653455pat.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PA90qJSn3RRJqZ3NcgbeSMfJk2T1nmcF9xgM4XFhV9M=;
        b=uYfMxiZWqh/Np7Yh78yGE/UkiPPOxVvUCVp+Kzi/qRhGo4RY3LPJlvZnj8gJ3JBq9h
         MHY3UyQ+aGyz0n6OYPY6XyI2GgvKaMbNS6ZlUnpRt/HVLVErJ9TqbC+/OayFAlfGAjGM
         cZX40fmDRrqbM0IWG9fkyhsAkng7Ay3OV16EOwisB+MW9Qh07J8cJcsWuu4HaeujBPkl
         dOS80qXIBk/Qc2QYm/rCT/ngvySFCcXIc3HMVfdbn4bBL7X5vNhkpQ9Nu6kxtDsxcpzX
         pWuR/ZzO21x9/3xhhw58Gnq0iAGIsCkAx+bBT4FNeIwzLaWvFOQ84FnKBX1bBLGXVs0a
         jQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PA90qJSn3RRJqZ3NcgbeSMfJk2T1nmcF9xgM4XFhV9M=;
        b=jSyjI5SKUsyx9IvNWCYi1boMqmAiGvaCyP11VXyi5WlwKhksjJIaC2G7Xwtc+YC1BZ
         jvJMMKOhv8ygsnqNUqdfKsYAuKjl25Y06ZDvzMcTMsnbnd2LiIqVUP9SNRWKWtpBcHRn
         F3i+2SELH06O80fSNa1dheHkWvJbzq40J+JmTvEVH/jBcxpdOpiMRhMBHmkAzjbTXi8g
         uA9oML8k2KpegUUrIpevQKQ2Tt0V2Cz8Py1ENsHE9SoJ3apvbmJjyoZHnBUCB6k5TlBl
         l53x7D8csrKj0opUg85K2roD1krNLiX3MZcY3N7As6VI9vRnXlW/7Pgi92NrogmU+1uC
         0y+w==
X-Gm-Message-State: AE9vXwNqQwa8yHEM7b0HG2lkLr/DVIx3OLeJqTh0/v0NYSYfA53Lxvx1iR59likf59OWgA==
X-Received: by 10.66.166.101 with SMTP id zf5mr31579573pab.42.1473177875798;
        Tue, 06 Sep 2016 09:04:35 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id tj5sm42207792pab.37.2016.09.06.09.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Sep 2016 09:04:34 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satoshi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH v2 4/6] git-gui: Add Japanese language code
Date:   Wed,  7 Sep 2016 01:02:19 +0900
Message-Id: <1473177741-9576-4-git-send-email-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
 <1473177741-9576-1-git-send-email-s.yasushima@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Satoshi Yasushima <s.yasushima@gmail.com>
---
 po/ja.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ja.po b/po/ja.po
index b140e8b..23974cc 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -11,7 +11,7 @@ msgstr ""
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
 "Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
 "Language-Team: Japanese\n"
-"Language: \n"
+"Language: ja\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
-- 
2.8.2.windows.1

