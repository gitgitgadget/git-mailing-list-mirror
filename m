Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF671F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbcJKQ5L (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:57:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36732 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753832AbcJKQ5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:57:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id r16so820441pfg.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krGGntcQY8vg7KnRsYtI3ML4EFB4tyZqEmZU0yd1aXk=;
        b=ULt/V6kF+M14aQt3Ox/3E8baYI9VGBfybhNRzfBIpllDYkDDiVUF4td7MXaXwBc8EI
         oOVTEwWzqN379KnFn4XP/piYLw6cwnWHodFKzznSu0wCglLnsWWuinkDTbCGpxblg5SX
         lwcWmm2ZUTpcFOPkcXPf6Z7QY/LjMfGcRAxTxRrTLKs2uyko3uMCN+f8i9h40NhCBIGy
         XAHyAs9xtj3KlC1CqSUysuaqXtX/Spr7TC8/5UwuayJjTVF7WBPzsPOVMjJ6IIpRJK/p
         clai9QUwTnxYBLAVK6i9aZ/QqlIWBbpSRhJO2+pBZLtiNrymiLtbElVCB+KgfZWqVeCB
         k4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=krGGntcQY8vg7KnRsYtI3ML4EFB4tyZqEmZU0yd1aXk=;
        b=cQnKZdAFp4ye/KseRSdcUH/cIFuep+VcU7+MOyBnSFCwxGIcyNOhsTXv9Hr+BMZ0St
         0L9AOtINs7BC0v2//DV84kOlsEpjxiOmRVZMvqacDIOF2ug+IQ7BkBIWzCiOL478xVcD
         Z5cBJrZg+0cVR/4p0UBmQ4aliDANVZimq4I5pmibthG8Vuv2bEy0UOJ274dH84eZumZg
         ysEJcLfqXLLNdnLsx7tqEybKoDEOJfcFgneAwNqmIiKvbPkn+Romng5r25Brs/ZFfPnK
         SuhnEfLgyB2uRGfJpweCyZ2q9BTaNJyJbbAo+PIONqkBe2C11L1mw1ELH+eKRKLan0Zb
         5JWA==
X-Gm-Message-State: AA6/9RmM79b3vW/kCyswHrseXQp2JsQtDn149jXAlashQGrKupmv7/tc7vnXcFE1R6yuWQ==
X-Received: by 10.99.119.72 with SMTP id s69mr2351707pgc.11.1476203870425;
        Tue, 11 Oct 2016 09:37:50 -0700 (PDT)
Received: from localhost.localdomain (i60-35-227-248.s41.a017.ap.plala.or.jp. [60.35.227.248])
        by smtp.gmail.com with ESMTPSA id f82sm5441811pfe.92.2016.10.11.09.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 09:37:45 -0700 (PDT)
From:   Satoshi Yasushima <s.yasushima@gmail.com>
To:     git@vger.kernel.org
Cc:     Satothi Yasushima <s.yasushima@gmail.com>
Subject: [PATCH] gitk: Fix Japanese translation for "marked commit"
Date:   Wed, 12 Oct 2016 01:36:31 +0900
Message-Id: <20161011163631.8560-1-s.yasushima@gmail.com>
X-Mailer: git-send-email 2.10.0.windows.1
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
2.10.0.windows.1

