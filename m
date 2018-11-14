Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D311F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbeKNUlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:41:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39696 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeKNUlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:41:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so7599774pla.6
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fFD15AxhsOZ2OzGX4xhJNT6p1VLSsGZwclTA2taI7c0=;
        b=tLvaRSEVL1BPvoYTkqbxWvoSy3vrVKxAz8DJalEdG4ROi8psSdOqHmWX5T3JXnPydl
         GVeTy3ZD3x8AA4cK5hUsW+DJ6wYsv2O6eIGIf6soe1sxD6zCMFQjd7ctaOcz6srwsBHn
         v4032xKsLRC3SHoPZMnq5mxFHfeudjfklSrECGXAF4tFprlM6rBFl0mO7uzMoSzat7u4
         TJq08k1SkNgbuiFyHChsGV2Di0RtJlqtcsGpG0dKCCe0TvU8V1gg7/fBVQ6eFME/I+e5
         2PuKu7kHW+Xd93+yCIgwvrXxfh1nX/6AAZ4GYU/OhE6KPUYMIwCLRwMh96RZuIeoMw1D
         eaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fFD15AxhsOZ2OzGX4xhJNT6p1VLSsGZwclTA2taI7c0=;
        b=gMqrvEpnolDJMUYevTe4xhnDnTUNTBk6q6VH0JlEX/wUFu6KJWfJCohRaRiFWVHPtb
         Ip5kk0FCVN8RXk50NgTAb3urE3Dkuu/KlL6zyQc8emzlo8Iq2GsNcGML7wJXqhecLEXE
         v2tek8y8n0MwDYAbAP0th3ZuaZ/T5XLGRpi4X2D/PW/T+DlhWAMAHE+CAL6E2tfdKeSJ
         OzQXxJ4Lj2hwWmfTw+ANJx+4qeVYq0CxmuPabsdZkXwGYoFBPMKoi1AZ9EFVbOzxfDte
         tf0kJELmC1/0eOOMsiCyhLnpKaNOSq9f9hlw/uxxIm5TbMGGtxtrANf0gd3q8FKC9N65
         bmGQ==
X-Gm-Message-State: AGRZ1gKBbL5/pJa4dHP2vvnCoykl7ttJmaQjJrojxG2v1iLorfKRVdOy
        wcCcBqOaqcsc/DI2Zj3Edm6MPXqeSEU1PQRv
X-Google-Smtp-Source: AJdET5cMqm1tvzolkXH8/rCh+1WAlXxzOa9fEDM43bulaZ6f5yu06wb65vOxZjuPBl1mvzT4IqsR3g==
X-Received: by 2002:a17:902:3341:: with SMTP id a59-v6mr1363455plc.220.1542191916239;
        Wed, 14 Nov 2018 02:38:36 -0800 (PST)
Received: from keyan2.iflytek.com ([60.174.225.151])
        by smtp.gmail.com with ESMTPSA id y71-v6sm28532063pfk.70.2018.11.14.02.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 02:38:35 -0800 (PST)
From:   yanke131415@gmail.com
To:     git@vger.kernel.org
Cc:     out0fmemory <jiu4majia2@163.com>
Subject: [PATCH] INSTALL: add macOS gettext and sdk header explanation to INSTALL
Date:   Wed, 14 Nov 2018 18:38:30 +0800
Message-Id: <20181114103830.20434-1-yanke131415@gmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: out0fmemory <jiu4majia2@163.com>

---
 INSTALL | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/INSTALL b/INSTALL
index c39006e8e7..b7bfb53c12 100644
--- a/INSTALL
+++ b/INSTALL
@@ -165,6 +165,9 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
+    In macOS, can install and link gettext with brew as "brew install gettext"
+    and "brew link --force gettext", the link operation is necessary.
+
 	- Python version 2.4 or later (but not 3.x, which is not
 	  supported by Perforce) is needed to use the git-p4 interface
 	  to Perforce.
@@ -178,6 +181,10 @@ Issues of note:
    will include them.  Note that config.mak is not distributed;
    the name is reserved for local settings.
 
+  - In macOs 10.14, the Command Line Tool not contains the headers as before, so it
+    need install Command Line Tool 10.14 and install the headers which command
+    "sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target".
+
  - To build and install documentation suite, you need to have
    the asciidoc/xmlto toolchain.  Because not many people are
    inclined to install the tools, the default build target
-- 
2.19.1.1052.gd166e6afe5

