Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218721F97E
	for <e@80x24.org>; Thu, 15 Nov 2018 12:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeKOWM0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 17:12:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39594 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOWM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 17:12:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so4919173pfc.6
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 04:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKBpiJaGcECo/0icnAMXF11ShGVSADzkbJ61kJM/s0E=;
        b=tAVTrjbhj0mxy6G3RjA8jNLsitwSowSYGBo9oly1tFKkJD1083Wvzix6YnIy4lmzFq
         cnfPbnEf4zwRduvvOaRcOipAZLm3ouzVieze3RYy1QXygukf8ZKMuckCcDlodnhh/r9Z
         VE0SxrSMcDOqXJJRMBab0Hbn1pKcrt7abwEh1wvijWtaabCO+eD65xd4uIbTZdj5HhN6
         YFkSrvv7GCf/V8EnUWhkNKl2eCLl1uXb/cCYsnPlGlqcwkcWaYcWmfdyFfPfP5mslqN2
         xPgHT+A+5GnIXDgFkO01gc0aJGZ5491vS4ecB+d/nUoD2O9ql06Fc5/mMBgLQ1UcRNlV
         2eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKBpiJaGcECo/0icnAMXF11ShGVSADzkbJ61kJM/s0E=;
        b=ltXosOGiITHL75Nt+60toS+IPo4xl0uwdlrZs6z27yZwJcdmjMBh66FHieckSITgXt
         ceqknnLSB0IJjDBD+RJP/jUOidrxgVIZ7WBtrhyPuf5EyxWNqy3dq1gbenX81+XtXaan
         Yox1yPkjRoFnxaV7WiVzM9hvD2+qOcS1Qhe/r4/FQLJ+C6s2usUGjCqswN39m1mAYahr
         7vjTBm6D02M0bKNdk6yxJjh0aCgIyaCl9BLZdW1oLHPRqZcqLWnIe6+m7YUlfUoVNmEU
         eje3wUpIXzZOqUOBj547suQNxfc3yhIlX7I6m0jqFP1AbLyh9n1RHULdOx15ND7LolHq
         dRcg==
X-Gm-Message-State: AGRZ1gJ75Gk+4xFJLjRw2k5tJHQzCmhfhxNPyKLvFlUsG1RubBfAuRRr
        ra0r57PHOkkNVtHJf/K+iR+C8ttHVn19VA==
X-Google-Smtp-Source: AJdET5enyWHA94zHWU2F5nX8l7IQw7zd7HJUaZXahvbyMG+iWj1Q4o5tth57+WxJvVlbreGgCpM0Gg==
X-Received: by 2002:a63:7044:: with SMTP id a4mr5399605pgn.359.1542283491262;
        Thu, 15 Nov 2018 04:04:51 -0800 (PST)
Received: from keyan2.iflytek.com ([60.174.225.151])
        by smtp.gmail.com with ESMTPSA id y10-v6sm10178601pfl.187.2018.11.15.04.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 04:04:50 -0800 (PST)
From:   yanke131415@gmail.com
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     yanke <jiu4majia2@163.com>
Subject: [[PATCH v2] ] INSTALL: add macOS gettext and sdk header explanation to INSTALL
Date:   Thu, 15 Nov 2018 20:04:45 +0800
Message-Id: <20181115120445.46277-1-yanke131415@gmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: out0fmemory <jiu4majia2@163.com>

* add macOS gettext explanation to get the i18n locale translation take effect in macOS, as the most polular way of gettext
  install in macOS, the gettext is not linked by default, this commit give a tip on this thing.

* add macOS Command Line Tool sdk header explanation to get correct build in macOS 10.14+, as the CLT not install
  the header by default, we need install it by self, this commit give a way to install the loss headers.

Signed-off-by: yanke <jiu4majia2@163.com>
---
 INSTALL | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/INSTALL b/INSTALL
index c39006e8e7..ed4bd29f8f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -165,6 +165,13 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
+    In macOS, can install gettext with brew as "brew install gettext"
+    and "brew link --force gettext", the gettext is keg-only so brew not link
+    it to /usr/local by default, so link operation is necessary, or you can
+    follow the brew tips after install gettext. If not link gettext correctly,
+    the git after build will not have correct locale translations, english is the
+    default language.
+
 	- Python version 2.4 or later (but not 3.x, which is not
 	  supported by Perforce) is needed to use the git-p4 interface
 	  to Perforce.
@@ -178,6 +185,19 @@ Issues of note:
    will include them.  Note that config.mak is not distributed;
    the name is reserved for local settings.
 
+  - In macOs 10.14, the Command Line Tool not contains sdk headers as before, so
+    need install Command Line Tool 10.14 and install the headers with command
+    "sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target".
+    If not install the sdk headers correctly, git build will get errors blew, factly is
+    is because of this problem.
+
+    ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
+    clang: error: linker command failed with exit code 1 (use -v to see invocation)
+    make: *** [Makefile:2369: git-fast-import] Error 1
+    ld: archive has no table of contents file 'xdiff/lib.a' for architecture x86_64
+    clang: error: linker command failed with exit code 1 (use -v to see invocation)
+    make: *** [Makefile:2046: git] Error 1
+
  - To build and install documentation suite, you need to have
    the asciidoc/xmlto toolchain.  Because not many people are
    inclined to install the tools, the default build target
-- 
2.19.1.1052.gd166e6afe5

