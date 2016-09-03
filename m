Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BFD1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbcICOp3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 10:45:29 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33610 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbcICOp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 10:45:27 -0400
Received: by mail-pa0-f47.google.com with SMTP id cm16so1535063pac.0
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTmO8Q9xqHbozlLXFGTLX5Y0su2luECAmjaTQf5bLqM=;
        b=ks+U4TBb8aQAsuFxDlMuA+gNMy2pso6ufpTr8FbGrChEdBDtFuhy7f0P91lyxgtaG7
         QHbLGnRiWxwpRhh0r9e6zIv1QwONEw+gWRdjs2KgrZh2Iwb3FgaAgnnqZOdSfV4hTgeU
         iwB+FqC/jMD6qC3t1t+nlgIaVpZ7nz8t4H1F4KG61TKDebsyl2Nl/JrEu3K71MnMzvSW
         aW3YmaFYYKufmmu72AePE0y8HSmsTtph0A0AhVLf3KTs3cZElWP0jKAfpZSJVN9ypB63
         SgwAAc2TCdtltDwlhSg0fCsPovKqU1Z4KrnI8B56kZ0ND7rnAJb3+96b4poAcN16NTY+
         NZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTmO8Q9xqHbozlLXFGTLX5Y0su2luECAmjaTQf5bLqM=;
        b=JCYUCURkTIRSzb8gBVyHrqzY+avBD6RTeUM5IOzggWM8trBDWUgcZzUi5Jcsvr8p9f
         PSu3Mu0FcYwwzoOMW8CZgJSVbl10E62zLDDY0lXnwGEu67OMjNf9MeqBkqoP3Y6d06ZQ
         g4/yM1+WCzvdD1aOnEznHw469jWy5fFkYH+oo3+GRYCMorgKJ1vcBoUArySw99FComgM
         BEptPS+IabCvp8nj3pTEnRxPWXl4MYKcUdXRmOg+vdH5lQjmq/sX3hE10nKOmilsxdZf
         vaTVInfwwtemIdd6IOeCjJX4xI/3N+zzhhbYhax+MbGS6CRo5G7jts8IwEODZqE7oEXV
         A8Lw==
X-Gm-Message-State: AE9vXwPeS6Oti9PuVwjsJYphYTVIphjVWXzlFHKpoZM+leQ07KrbrAx6mV03Y7M4pgb+Jg==
X-Received: by 10.66.76.65 with SMTP id i1mr20432paw.51.1472913899267;
        Sat, 03 Sep 2016 07:44:59 -0700 (PDT)
Received: from localhost.localdomain (i60-35-214-133.s41.a017.ap.plala.or.jp. [60.35.214.133])
        by smtp.gmail.com with ESMTPSA id p74sm6755840pfk.68.2016.09.03.07.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Sep 2016 07:44:58 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Satothi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH 6/6] git-gui: Update Japanese information
Date:   Sat,  3 Sep 2016 23:43:42 +0900
Message-Id: <1472913822-9088-6-git-send-email-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
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

