Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F69B1F45F
	for <e@80x24.org>; Sat, 11 May 2019 04:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfEKENl (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 00:13:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42035 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfEKENl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 00:13:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so3701868pln.9
        for <git@vger.kernel.org>; Fri, 10 May 2019 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qARuI1Z2rqBvKASyHxR6uazUDiiZ+tgJyIftVe2+Oxs=;
        b=L7bdBWtEuwYRg/yq3f2YhPTfAdWkZdqyHxM41UgBfsFkC7Fg/ZKqETKPQK5wv6/IyH
         Wb5QWv25GyVhzymkTFdL+O7UjPZGk/R7ebJQLsjZ59A0y/zETc16EhqCN9rqAG27UjWo
         sNsuo/SIYSjwI6N5lcsNv7r2008fjX+hPduPD3j82ndhPVE5FLcE9lgsYCkjtkGf8KJ6
         qcsbVxfQXdFGlyvd2qUJ2SqY8oj9MULxlGsX1JORq/AqSKxC7r+mA9M3pNfBIr/IZR1W
         KZLDgRinOdNgGy2VrE/faqPyD90iotU9iKHts6ZSIQICYUQRIumVLZQr/VGoZK1lashT
         EQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qARuI1Z2rqBvKASyHxR6uazUDiiZ+tgJyIftVe2+Oxs=;
        b=cmtAPZdUPvCBSmnJOobjFFPjbXfnTFcVQbl94lIApdlcj7J9u2bBwjksiY8W/j9O+D
         1Bl/P1Sg3QKW1HSdyvBeBq3cAMlCpE/WhneyNCIObo7GhxOYe/sIymyNlvcM802BUIPL
         tWIQl+jAxAY9Xww374Wny/T7nEmuIkKGKyuufV1i6GoRfbr5ZtbMrLdbwxHNe4U76yGE
         oGoBswyJm6eAECy8XzHsyXzGr6tJdyo+zPjec2q9SJ9ntonO8SQdwKpiUXeuRzpwktW3
         q4dwnM9JWcGJIghhOMT3mIvQ2TzjjQ53DTYMke1/n9ZsE2eXDguveA+on9du7kWsumUn
         rvVQ==
X-Gm-Message-State: APjAAAXvND5SFeqzVb8qgij1Q+/1UdGN9aBTgD3aaONICQEi3vJPX7Uy
        H1lQDNBnC+dSD+M138gMjYqph09iMVc=
X-Google-Smtp-Source: APXvYqzKMYSv3ytxIx9gLYOEae6L+LAOA6M2M1olfE8KOrOBRo9LWqawr6BL5DfDBuYtbk62DfjkuQ==
X-Received: by 2002:a17:902:e48d:: with SMTP id cj13mr17394015plb.156.1557548020516;
        Fri, 10 May 2019 21:13:40 -0700 (PDT)
Received: from MBP.local.hk ([202.189.108.96])
        by smtp.gmail.com with ESMTPSA id g3sm6826525pgh.69.2019.05.10.21.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 21:13:39 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, philipoakley@iee.org,
        Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
Date:   Sat, 11 May 2019 12:13:31 +0800
Message-Id: <20190511041331.51642-1-liboxuan@connect.hku.hk>
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
Update from v2: fix indentation
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
index 3a78fbf504..7d07b82116 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -60,6 +60,11 @@ PATTERNS("java",
 PATTERNS("matlab",
 	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
 	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
+PATTERNS("octave",
+	 /* Mostly the same as matlab. In addition, Octave
+	  * supports '##' and '%%%' for code sections */
+	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
+	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
 PATTERNS("objc",
 	 /* Negate C statements that can look like functions */
 	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
-- 
2.21.0.777.g83232e3864

