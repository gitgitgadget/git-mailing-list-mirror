Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0D81F45F
	for <e@80x24.org>; Sat, 11 May 2019 04:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfEKEIl (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 00:08:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43730 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfEKEIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 00:08:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so4227701pfa.10
        for <git@vger.kernel.org>; Fri, 10 May 2019 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFo/HaWNO/VwmYBnzEx9WczUGsS7oE/jXdrv+LO24tI=;
        b=JBvUCqdBHjjVIi7XaPHCH4WBnWiYh95+ZB3sSJDmKapAHIyi4MRURlFuji8ZqSQ1xG
         gVvZ7Jr1yzFkfptra493Eu7llbPtRsF0ZxdVmH5HCDg26RL8T1sKelt2NCuTOMbjFcKF
         +rVZot1cvb9JYfEF9LWndQKd86vffm4SsK0PjJlcHpJKAxxHsc/e9lpudVGyLPG+9yFj
         VXLjUK6UrybrOFIY8XRc1XtjfujHD7f/DhZOd2mEKLQdBuvfjSOtsyvlTNsN7IC97hky
         ESBuf3XLKBHD/1+pvZXmnLOHOXGoO1/Mjh6fbVSYrwA6aueBRjaIbxt+5SyKYeI0S8HE
         MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFo/HaWNO/VwmYBnzEx9WczUGsS7oE/jXdrv+LO24tI=;
        b=Q5phjvSFgI/TWh2+I3E+pJi0lhpiLGV5V24cnOrcgTN6MwKqy9HB97AKyIRZ3rNdk3
         cvDvkuIPtXXFLFwSfte8TUz6uG8/2ikefqNfwU62Qx/GlHuVPOXDSmMmbbgtk0ufqMcY
         JIePwoI3NfbZBwQxqq8T/X+z+iKwV2j68slyEllB+o9aTDdZORLJxbHHrn6kflK5OMJu
         lQGzgEMGxySoARMO1HMGPqyzLOyN/X2pte7lAJAmJ07F/7IkRqkILlwVbZVqlCqaH45K
         q95QiCyylF5qUU+/UujEdRra63AGOpLe/8uCcMLj8oYeemXGCkANvMYca4YgCh+UN+c7
         wskw==
X-Gm-Message-State: APjAAAV4Zb8Dk8KcsQ+vs31W2yrw0Uz8Je0Zs1iMnSKxbxgLpB6mqb0i
        EdXuGQHyeeN5QZm3XJROr2ZcShPbkyM=
X-Google-Smtp-Source: APXvYqxyLpYww5wHyK74tlNcMQQeft9zcP1ykFVQFCJEZWr5EN91Urk09DKYL1o15pbHrbGJMbtSRg==
X-Received: by 2002:aa7:8052:: with SMTP id y18mr18910999pfm.36.1557547720269;
        Fri, 10 May 2019 21:08:40 -0700 (PDT)
Received: from MBP.local.hk ([202.189.108.96])
        by smtp.gmail.com with ESMTPSA id k131sm112768pfc.107.2019.05.10.21.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 21:08:39 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, philipoakley@iee.org,
        Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH v2] userdiff.c & doc/gitattributes.txt: add Octave
Date:   Sat, 11 May 2019 12:08:19 +0800
Message-Id: <20190511040819.49985-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
In-Reply-To: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Octave pattern is almost the same as matlab. Besides,
octave also uses '%%%' or '##' to begin code sections.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
v1: use matlab pattern for octave language
---
 Documentation/gitattributes.txt | 2 ++
 userdiff.c                      | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4fb20cd0e9..45374c7dd3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -821,6 +821,8 @@ patterns are available:
 
 - `matlab` suitable for source code in the MATLAB language.
 
+- `octave` suitable for source code in the Octave language.
+
 - `objc` suitable for source code in the Objective-C language.
 
 - `pascal` suitable for source code in the Pascal/Delphi language.
diff --git a/userdiff.c b/userdiff.c
index 3a78fbf504..6e9b56f1d6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -60,6 +60,11 @@ PATTERNS("java",
 PATTERNS("matlab",
 	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
+PATTERNS("octave",
+     /* Mostly the same as matlab. In addition, Octave
+      * supports '##' and '%%%' for code sections */
+     "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
+     "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
-- 
2.21.0.777.g83232e3864

