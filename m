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
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B111F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfKOOjW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:39:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36131 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfKOOjV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:39:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so10667198wmd.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3XdRStVC7GQee28lGYUum2xNXeCKAya5rWKL7l3/Bv4=;
        b=H8YVgGFLQweJY2qNwFgHuOV5d1Pw8+9SqJcA8tiFqJSTBaz1Qm4YRpILk8YCJslrye
         McT8SZ1nlow0/4KW01ZdGqLdZvvZ4yPInfiRNepmf6fzJ12c3srOBx6mt0W8qSRK9snX
         z0r/K0aRXMOuE8foBI281Ld3CQkj7JNw86jw9lR4540j37q7mX3iJcrK24Gb7QVfkBz3
         2GUZMZaPwuDh68cnT1EbRJrFkOHNjjSurfuL5mzrENsz2ypGGXi+mYfjybm8CJzLYGAy
         NTxmA+YN8SgUH6BHY8W583jaC78TNNQuMWBzQJz3RtzG6FuQDq5Kq77oXlSYrmhipPdy
         qQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3XdRStVC7GQee28lGYUum2xNXeCKAya5rWKL7l3/Bv4=;
        b=T4q/lfCrwsOid90jOgAJ5zfuw5zpoHLvHFZFihZJXr2X03oBH70arKlzb+MKicsLAD
         PahnPz59JgcNgbAoTdvqbhwH/tIPKckdVELAfpOBQ2olH09Ud4nD8bLGoQD1DfHcgQMm
         Hj3f2CzbJYNJfHslIea4tsg12QDSJ01y/MkzORp+8DO7HE/R1Ff8vnTBrZDqcFARpqg+
         cLVDoVVl7kYu1999zPzrQTFQJvahPqooVi1kIzHSd5JFC2Ml1gZ4zvHXNrHG7IkJSYcp
         VEnVQU1E8jkASFzkPDTrScA/PU3+gO9mhCkyb41OSsZknNpqflLzvVP7iL3JtkddIJ1J
         YwAw==
X-Gm-Message-State: APjAAAW/xBrXJwInHpx1lW/Z3AfgJA+u0RopxjcnGQEJ9zLifVhkiZIH
        sgNJnKKVb8NTpAkYrYSmP7VKq3fA
X-Google-Smtp-Source: APXvYqwx4Jc1xRM0K3XIkB9EH/g8H4iRwsQAPx5vzLbrE9AioAZNzwC0xAy0kSKlpvwtOHNgkx742A==
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr15055260wme.103.1573828759422;
        Fri, 15 Nov 2019 06:39:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128sm11489457wmb.14.2019.11.15.06.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:39:19 -0800 (PST)
Message-Id: <0435d0e2cb4c62ede5f64b396af262d6bf8b5079.1573828756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
References: <pull.463.git.1573679258.gitgitgadget@gmail.com>
        <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:39:15 +0000
Subject: [PATCH v2 2/3] FIX: cast as unicode fails when a value is already
 unicode
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
 git-p4.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 6e8b3a26cd..b088095b15 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -39,6 +39,8 @@
     isunicode = True
     def ustring(text):
         """Returns the byte string as a unicode string"""
+        if isinstance(text, unicode):
+            return text
         if text == '' or text == b'':
             return ''
         return unicode(text, "utf-8")
@@ -813,7 +815,7 @@ def gitConfig(key, typeSpecifier=None):
         cmd += [ key ]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
-    return ustring(_gitConfig[key])
+    return _gitConfig[key]
 
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
-- 
gitgitgadget

