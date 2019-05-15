Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C303E1F461
	for <e@80x24.org>; Wed, 15 May 2019 05:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfEOF4D (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 01:56:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34039 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOF4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 01:56:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so785895plz.1
        for <git@vger.kernel.org>; Tue, 14 May 2019 22:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LXf5NMZs6hwKPiN3pgvVPpt73fC9rD/QM2QSDOnsdTs=;
        b=ku9DPyR7j/tBsMLs0w/46OT/tmI/un9b+8QrRGmE1Dat00St9yB6p826aoHMmZ1fuc
         /64oGJjo0fiEiQP8e1BM/LhXaphNXWFeVKO2isbp5cp9ZZQqZhIRasMv1BPXu1/rvm1d
         hUwxjhu015fgTUH3Aj47/BGDveshBd5OM9897Nu58QklXnKqZmCLPAGaen3ZoBn1ny9G
         KSzdEzU4HZhiNgSvsxUjcJ21zcqSvfyOFYH4B/2AFWYvCfUgDUD/pC0lte9G3EhLgoDE
         m9lMd8kLjc05punzcnDGuAyyCMPMrf4s2nZPU+eOHuV0iJC9+Ml0L3Z3IwPHCHwlUrcp
         wjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LXf5NMZs6hwKPiN3pgvVPpt73fC9rD/QM2QSDOnsdTs=;
        b=HecE2jg5veI9hCtxhbo3G/jiCFdVVBG8BcgtI2PG8agHQvsUryw+g5fq6dDUbgFoez
         XgRvITD6ZSf1fIZUrYZ4z3QVskq9ewwPAzq/+NBYujmqXLSkSZJDEs7vmspBCeXZVSMn
         qDPCBfUA+P4kOhRDdrTjf4KQK4BKuVPnVwwohcIbB9F78vQEfNVa5Fnv2o/Ov7jhTKtg
         EsAtiyR5yAYrcgvsmt7oYGOAh5IQBmhYk26w9YuZbvzkPFXdelKDj+Ws5gDq+mQIkyNp
         8v2ia/cXJ8t4xrYnk62ENd4lzs8opWs0WGb3JgyziBFaNawM2X9ndrYcY6TexgGK3Sfl
         PoFw==
X-Gm-Message-State: APjAAAUjH2bjmzrR3dl3iL4k8la7cLKR2x9cf75zc599oMDtD9Q8sAs4
        KrW4iOKZffFNS9DYAAEsBNsLebAyX86vYQ==
X-Google-Smtp-Source: APXvYqxA6pRmQat+YuqgWVMGWRQxmSSwxdNfdkC6bnyaYwzOyg8M8hj4lI7fwNSKuUpn9FsGGTY0YQ==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr42899857plr.17.1557899762640;
        Tue, 14 May 2019 22:56:02 -0700 (PDT)
Received: from MBP.local.hk ([202.189.108.96])
        by smtp.gmail.com with ESMTPSA id u123sm1454369pfu.67.2019.05.14.22.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 May 2019 22:56:02 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, philipoakley@iee.org, gitster@pobox.com,
        Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH v4] userdiff.c & doc/gitattributes.txt: add Octave
Date:   Wed, 15 May 2019 13:55:40 +0800
Message-Id: <20190515055540.30558-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
In-Reply-To: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Octave pattern is almost the same as matlab, except
that '%%%' and '##' can also be used to begin code sections,
in addition to '%%' that is understood by both.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
Thanks to all the reviewers above, this is the fourth version:
v1: use matlab pattern for octave
v2: add a new octave pattern
v3: fix indentation problem of v2
v4: improve doc and commit message
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
index 3a78fbf504..1127a4c6b1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -60,6 +60,11 @@ PATTERNS("java",
 PATTERNS("matlab",
 	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
+PATTERNS("octave",
+	 /* Mostly the same as matlab, except that '%%%' and '##' can also be used
+	  * to begin code sections, in addition to '%%' that is understood by both. */
+	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
-- 
2.21.0.777.g83232e3864

