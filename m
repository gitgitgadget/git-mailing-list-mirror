Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9151F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKOOnD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:43:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51771 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOOnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:43:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so9900136wme.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gSvCaLW+fSQ3phRjmePgBbG0fT+fHfGnjuZKAYco1ZQ=;
        b=p43VQI92PYzN5ykZEKjKAHU3OHsQjfpwUkzcqxGbeA5vy8zclwYGVSf0H48y+bqbuR
         Fe69YqOTYpY3oqhG2N9QZ55PaY+A8bj43BcfFtTv0pN9XmWmjY8ShbsS0hVj6Y6BdfuC
         aEjZ34ZW+/c2R+X6IY7cKIl94gAp+/3c92E+ng3pAVLV8Hn6Flq+Hu2CIIJkX6EcAw+3
         ErVsY2Co1smwQ9LgMKlsLqWyHMJmI3NrDW3Zed7lZA0tpvo3vHo2oa9R6mGlwJNt7fPL
         5iQAahQ3n0gbkmN1ezYusE4xzSTY7YM79o+3rcQsa/TTHN/57XxCf5p3sBN9OPgCSvjx
         DrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gSvCaLW+fSQ3phRjmePgBbG0fT+fHfGnjuZKAYco1ZQ=;
        b=cl5SVUsofjGALnu+AZ56YBu782qY1dm3eRNQGnDPTyplvV6IgdffytRziubhASNUIM
         VgbH6QPNEgA2XTbyAP/fhJtemDLXh6W1ZXhFGMnEFfXF2U0cSGv+jeSBz+k72lBMYFP3
         ph0yGUZ7mXOVE/abN17yqLxEJuH+p2FMJ2JbiUqHmW433xzlqbXFDOjHbmlPgGA0X0yv
         bdle1DykHcLssqZKU4Z4cVRrNBOHH49bsQPA0DyTfeGlh8OaZVv5BUuv697upWOCPuqq
         piEXNdPBjE0+1Gzzu6PR2eAUByqvzoVTvucnKV1YYhlYRlHTJS+9ZQD6Llanlw2z0Zii
         6phA==
X-Gm-Message-State: APjAAAXCT7m+VSWoAE/f+3yHoh4eRUYYxTkdVr+06IX9c09Xue2+2dfE
        xyePFARLrJGg9CWYmT85I87Fipbu
X-Google-Smtp-Source: APXvYqwLvd7xyxIx2ZvK1qQR/Y+rAjv8rssGiNBRsHYoWSyfo9BUkMy0GjQIYXrxGoDWd4CbzvcOiw==
X-Received: by 2002:a1c:810d:: with SMTP id c13mr16197695wmd.154.1573828981463;
        Fri, 15 Nov 2019 06:43:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y78sm10547682wmd.32.2019.11.15.06.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:43:01 -0800 (PST)
Message-Id: <dc6817eea3005f3b891506dfd5fb23cec0a9d76c.1573828978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:42:58 +0000
Subject: [PATCH v2 3/3] Changed the name of the parameter from git-p4.binary
 to git-p4.p4program
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt | 2 +-
 git-p4.py                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index e206e69250..21ef100c28 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -547,7 +547,7 @@ git-p4.retries::
 	Set the value to 0 to disable retries or if your p4 version
 	does not support retries (pre 2012.2).
 
-git-p4.binary::
+git-p4.p4program::
 	Specifies the p4 executable used by git-p4 to process commands.
 	The default value for Windows is `p4.exe` and for all other
 	systems the default is `p4`. 
diff --git a/git-p4.py b/git-p4.py
index 160d966ee1..4fbb7344f1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -88,7 +88,7 @@ def p4_build_cmd(cmd):
     can be done more easily.
     """
     # Look for the P4 binary
-    p4bin = gitConfig("git-p4.binary")
+    p4bin = gitConfig("git-p4.p4program")
     real_cmd = []
     if p4bin != "":
         if path.exists(p4bin):
-- 
gitgitgadget
