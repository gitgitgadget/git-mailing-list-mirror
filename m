Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19E71FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 15:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941168AbcJXPfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 11:35:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35709 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932525AbcJXPfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 11:35:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id s8so16876168pfj.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/3jMEczjPRd2Eotz3oqIqyLvKmq77EXo/IId0DxM5c=;
        b=K3rIc7gw4LjCHmFr0Dfa1k17q67bwCL5ITIHwSIvCpCRabLwhRNoMbwSR5a5DsI8mW
         NLl4uqBVXZP/dmuzDcCxafTD93emDplMYdl3g4EDCxuOEU8/pxS6pS5qSyl/R4PTvPCz
         uCUCcBp7aWDj7e4Dfp2HSsrM2Nh/h3keOJIADxR/OVnO4/kItzM48w5BxChmQLTSsSvS
         3Ayz3JhYTGmr98YThu4zhaPfOpOnaqA4KTrFIdCQRMUbjrTWJxurACIxPZgz68oMwklw
         4tpX1IfjEqIQXDrndZqk5c+SNob4OoZySn920atbCJySXYkkyldBVZzSz9/tNrD574+0
         hnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O/3jMEczjPRd2Eotz3oqIqyLvKmq77EXo/IId0DxM5c=;
        b=AuY8M+gvr89D0He0qk7CVw4osKiuabF/l5zWKKsBJ269n62NC2reCd7d5R2BCCneLU
         61BoFYSDffiTl37/rQdoXgqPutgmh05wTKbV751GYW8Ti5TKgpv8Znn7fXgL5eusbxkO
         1kBvXMMZiUXfyDNtWtDea+cWWJOZRXEpU86KUcwcXCdSkNEEEDcEL5zFNnEocjZIVmCY
         KhrOAkNXep7Dm8D8v77/qdWk/XXrXQIepILQvUYyuoVQk+JildoRDCv5Steb8syf2Obm
         sFcOj8m4YuJf6Dn664ZIFVg4O/LuGzLucKuyLoFqYckotpIh8UMey4VJjklup4I54aLW
         vIqQ==
X-Gm-Message-State: ABUngvcm3ACTIRBbMh1kXdM14Gtc3mkoHpKP0L2t5KblHZk0qvisdhWW0PaReI9zDtN79Q==
X-Received: by 10.98.90.135 with SMTP id o129mr740018pfb.81.1477323340364;
        Mon, 24 Oct 2016 08:35:40 -0700 (PDT)
Received: from localhost.localdomain (i60-35-227-248.s41.a017.ap.plala.or.jp. [60.35.227.248])
        by smtp.gmail.com with ESMTPSA id z6sm26423260pay.31.2016.10.24.08.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 08:35:39 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Satoshi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH] gitk: Fix Japanese translation for "marked commit"
Date:   Tue, 25 Oct 2016 00:35:10 +0900
Message-Id: <20161024153510.9212-1-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.10.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Satoshi Yasushima <s.yasushima@gmail.com>
---
 po/ja.po | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index f143753..510306b 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -2,16 +2,17 @@
 # Copyright (C) 2005-2015 Paul Mackerras
 # This file is distributed under the same license as the gitk package.
 #
-# YOKOTA Hiroshi <yokota@netlab.cs.tsukuba.ac.jp>, 2015.
 # Mizar <mizar.jp@gmail.com>, 2009.
 # Junio C Hamano <gitster@pobox.com>, 2009.
+# YOKOTA Hiroshi <yokota@netlab.cs.tsukuba.ac.jp>, 2015.
+# Satoshi Yasushima <s.yasushima@gmail.com>, 2016.
 msgid ""
 msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2015-05-17 14:32+1000\n"
 "PO-Revision-Date: 2015-11-12 13:00+0900\n"
-"Last-Translator: YOKOTA Hiroshi <yokota@netlab.cs.tsukuba.ac.jp>\n"
+"Last-Translator: Satoshi Yasushima <s.yasushima@gmail.com>\n"
 "Language-Team: Japanese\n"
 "Language: ja\n"
 "MIME-Version: 1.0\n"
@@ -314,11 +315,11 @@ msgstr "マークを付けたコミットと比較する"
 
 #: gitk:2630 gitk:2641
 msgid "Diff this -> marked commit"
-msgstr "これと選択したコミットのdiffを見る"
+msgstr "これとマークを付けたコミットのdiffを見る"
 
 #: gitk:2631 gitk:2642
 msgid "Diff marked commit -> this"
-msgstr "選択したコミットとこれのdiffを見る"
+msgstr "マークを付けたコミットとこれのdiffを見る"
 
 #: gitk:2632
 msgid "Revert this commit"
-- 
2.10.1.windows.1

