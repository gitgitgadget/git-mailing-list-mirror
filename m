Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4072F1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 01:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeKOLiV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 06:38:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44671 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOLiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 06:38:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so8193191pgs.11
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 17:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fFD15AxhsOZ2OzGX4xhJNT6p1VLSsGZwclTA2taI7c0=;
        b=PMgymMyGVrLg4zofunC5jnQ9wa64l4YJQxqQZ2AWYVhhWa8is9vqDsyJgk6onjTOgc
         UqNJlMYnmwvYgpRCUcJW1IyK12tmFoj8gUINcASXopYZLCEpMpi9s4UL/3azZHUjQ5pJ
         8mXqtPkZyRIZgAVHJZylKFRGcEwH6jS4+B3mLSwcp3WaCmlVOX/hcv3rK4WNGb0q0GkP
         n0Ohe+EztZaEaE9knn3zWvIvwuFKo38jHD81aHBf4Owc8aYfhZ719Wn8QykMt0kI2CHx
         Y/QxaGc4NDp5KeYqDkU4bIskgEUIwjMo35aAN30vw4jWfZu0Lq+jxB1AtjuYEv3+jA0K
         i7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fFD15AxhsOZ2OzGX4xhJNT6p1VLSsGZwclTA2taI7c0=;
        b=RuA3f0GPwBF9nFOxjGfFiim8EgFXAAO8FqX2THV8w5bfVPRjf6vMxL3vjZPIQ2wuZ8
         naDwRyPfMQbANoaCt1kKyXhfalkLr7vyQxJ8BtvyHbk8+XfDTImPY/im7lGDIN/8ks5J
         //ZhBR7n+mANwKakCaC9JA4kE+6I36PAuuHil/sDcJ4DxDbd/Il8PLZ4pXSn8qLrLwok
         hct9TN6FLwNupu3BXs/Ko6wcUEAgA97JbzyHmAhU1JYtc66P+L2w5Gafkerv1ALFqs9a
         EF9B9+szN5vY0gqoKNB9pn1GcB/jso/MuoClWQKXog8HA063TlkFHu2HFDkN01shxGdm
         6i4g==
X-Gm-Message-State: AGRZ1gLxNi2KGGZcacXl3zlJpoZLLMnx+hrmcB9EvZOdiKW5TTGzkUet
        7sg9Sl6iISOywk0bLGziP8NVSQs6QCgmNg==
X-Google-Smtp-Source: AJdET5dT9k3W6gz3LGTy5k1zEpW4IAhF2TEWc7yynBtHZnT0Rst/Ws/Atb5kGa6WlEv0h6Weo3R9KQ==
X-Received: by 2002:a63:4e15:: with SMTP id c21mr4010487pgb.50.1542245557990;
        Wed, 14 Nov 2018 17:32:37 -0800 (PST)
Received: from keyan2.iflytek.com ([60.174.225.151])
        by smtp.gmail.com with ESMTPSA id 123sm22684883pgd.75.2018.11.14.17.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 17:32:37 -0800 (PST)
From:   yanke131415@gmail.com
To:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH] INSTALL: add macOS gettext and sdk header explanation to INSTALL
Date:   Thu, 15 Nov 2018 09:32:33 +0800
Message-Id: <20181115013233.24685-1-yanke131415@gmail.com>
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

