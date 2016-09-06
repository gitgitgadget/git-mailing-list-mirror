Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B431F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934024AbcIFQEe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:04:34 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35309 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934398AbcIFQEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:04:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id w87so17808715pfk.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=518sPJzdnpVs7u7ehEkDni6fVFq2o5UoOwDdmBgGeWA=;
        b=wOTxOTP1b1nx2CcYnXvXjKeZ+fLjgh2dH8bmPIfPq5/MH7XXsr+1jhCXzSIx5Shyke
         /eQ6HRXEov4UZFW1SOzW9R/2e5p/Cikv95dVUsnlavpDYKKX8elpiXEi3sk0qcIRsxwW
         L68/PjhGWA7nqSYeLmjYyyLYJSQjhv0krF2XEHZlYt3Zw7EijMhA8xCBnHr9V51uP0Gv
         kMJrAeRcMkhfDNKSEhRxTh++hzU6UJeYmvp1Kwk5bF2NKb2gsXJLaGJX1fEZLjiK3ShO
         emonogKqMSs5u623BU8ReON5fKOGGm4w4TnRlqNvv0YO/1MbjyzD/3JPlG2Om2E3mjQZ
         MXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=518sPJzdnpVs7u7ehEkDni6fVFq2o5UoOwDdmBgGeWA=;
        b=VyFSUdg80VOGlMNveCXOaSRyGS81g4eNg4m2UGuKUxrZswkVKkzxwoieDeyYCpJg2k
         ki5MMdyM+MxWtpKq65sqA9oEg+5VkFLJtPHO+V5iW+b+9IHI0M7o3QdyPSiGsLFCvlh6
         ML9XXMTHYyESuu0J/utqvQelcCVQWlL7MRBbrZdAFRukeDZkDp6HbI7ZoM8EJAcQ6muE
         HkwWSkLFTHXqynoKMfsw49KEGt9L+rMbvfKoAxB8uZOOZH0mraPfM6XEMoTATDVWWOpk
         EFz0jS/5fHLqcTnJhz5Ji+bO8JpMibnFr10hiObJCgTblleL55KpN6fUMkTTYc8H0n0q
         ZfqQ==
X-Gm-Message-State: AE9vXwM7vpyz28OuSaDxd66LFytMI4NIk5WwRvkVjW1OlSuN3ibOy+exb1IyKzQowk3J0A==
X-Received: by 10.98.29.135 with SMTP id d129mr25489042pfd.142.1473177869198;
        Tue, 06 Sep 2016 09:04:29 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id tj5sm42207792pab.37.2016.09.06.09.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Sep 2016 09:04:28 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satoshi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH v2 2/6] git-gui: consistently use the same word for "blame" in Japanese
Date:   Wed,  7 Sep 2016 01:02:17 +0900
Message-Id: <1473177741-9576-2-git-send-email-s.yasushima@gmail.com>
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
 po/ja.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 8a2c16f..b692b5c 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -598,7 +598,7 @@ msgstr "文脈を見せる"
 
 #: lib/blame.tcl:291
 msgid "Blame Parent Commit"
-msgstr "親コミットを註釈"
+msgstr "親コミットを注釈"
 
 #: lib/blame.tcl:450
 #, tcl-format
@@ -2052,7 +2052,7 @@ msgstr "コピーを検知する最少文字数"
 
 #: lib/option.tcl:151
 msgid "Blame History Context Radius (days)"
-msgstr "註釈する履歴半径（日数）"
+msgstr "注釈する履歴半径（日数）"
 
 #: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
-- 
2.8.2.windows.1

