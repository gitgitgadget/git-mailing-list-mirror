Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C501F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935024AbcIFQE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:04:57 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35913 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934895AbcIFQEp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:04:45 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so11132240pab.3
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTmO8Q9xqHbozlLXFGTLX5Y0su2luECAmjaTQf5bLqM=;
        b=PwiGlk9DswMWHY/7mMlpWeXZXXO9ABpGj+bJ3Qw4r0RAFnr4mjRYFICngPcK/5BUvA
         KUe/w85RU3RZxqCWpetEFDH1d8Txr2H0A2g+Zvud/16f2TmWOfC8P3PUtD0+EBNs1337
         5Q/rLTTvdBnWU4SH34pkhCFuDs1MgFbXostldcNG+PkNx/wQRHXiyCgAbi/x45PDIx7W
         pb7Izp00fiHzNygxnfems/vyil4ExEWBYhR1x6kTm0V3Mz28GG0EIp23D6OCg1F6e1dS
         vAvM0rm6kunLWMGwWn3P3aNFsMUZJauqgxSpfdP1FUO4/S7lIY4SkW0EbO382rqoqz54
         KQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTmO8Q9xqHbozlLXFGTLX5Y0su2luECAmjaTQf5bLqM=;
        b=GpYeWelIMeA+JcFh/AFc1ohCA92x7O1AVEnSzP4v10Z449RfCt60oKVdeGeOAVGnlN
         8N4WC8ykV6fCXoTYFy7yW91LyGVbv3UgfuIXx3iFzsIoPQ/ilG3ro9Ea6OcfJ2D2fJxy
         x7wv/kQ8bBp31PQda+mvtuNMbrQUs5I+98lnzENP/G+YY0zbgoYBa7dPjYGyDAliRJYn
         1Jjyjgrvey9Aw5n6Lx6tGzoC1RG+P3a2RKmdkXvrregODqztCgHQzJLjunpf7Apl3h/B
         W0Di/iwu67huSPjV4KPn8eZnSYKWMrAP4DZdVSI995VBrbEx7K9+T1mQMSHJovt9Nt0B
         O4vQ==
X-Gm-Message-State: AE9vXwP2+AAL5HqYfN71bmGGAHyEAxt+HnhIhSZHQqLlha0bfftcTi8cjv4LuxA+pjA7fQ==
X-Received: by 10.66.43.113 with SMTP id v17mr48980940pal.112.1473177884336;
        Tue, 06 Sep 2016 09:04:44 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id tj5sm42207792pab.37.2016.09.06.09.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Sep 2016 09:04:41 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satoshi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH v2 6/6] git-gui: Update Japanese information
Date:   Wed,  7 Sep 2016 01:02:21 +0900
Message-Id: <1473177741-9576-6-git-send-email-s.yasushima@gmail.com>
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
 po/ja.po | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index deaf8e3..208651c 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -1,15 +1,17 @@
 # Translation of git-gui to Japanese
 # Copyright (C) 2007 Shawn Pearce
 # This file is distributed under the same license as the git-gui package.
+#
 # しらいし ななこ <nanako3@bluebottle.com>, 2007.
+# Satoshi Yasushima <s.yasushima@gmail.com>, 2016.
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2016-05-27 17:52+0900\n"
-"PO-Revision-Date: 2010-02-02 19:03+0900\n"
-"Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
+"PO-Revision-Date: 2016-06-22 12:50+0900\n"
+"Last-Translator: Satoshi Yasushima <s.yasushima@gmail.com>\n"
 "Language-Team: Japanese\n"
 "Language: ja\n"
 "MIME-Version: 1.0\n"
-- 
2.8.2.windows.1

