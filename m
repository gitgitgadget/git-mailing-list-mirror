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
	by dcvr.yhbt.net (Postfix) with ESMTP id 39E4E1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 07:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389909AbfJWH0A (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 03:26:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfJWH0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 03:26:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so19983828wmh.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zfq/wq1jvZyPddM5PqBXRplnsqzIaGKOXA5twSKuOEI=;
        b=RCoIuLMe1GP/PUkslgkXtnmFNE+K7IDH7o/8BkQgrG0G0Z2Obh6N+odcLiqQAGF3QN
         UTitM4ydUH/j0oCjzFK8HrgsokTe0I1dIhwT1zLEHycR0xzWmElQ1BPwxPD8PrBkAeQ+
         AsZlRgG1psVnshaRrLBKKcAGbNMOKmVIOiaFcrSww02Afetpxe+vnLyuNgPS8FrLTRjn
         QxNCQdtTiKfCI6ybPb9TaGqVkgic+ZfoCMGYCWuV3hJc5YFTOnHjD0HurOiSDp1pbMdH
         knOSGVEMwqLDKSXSri00sxr457xim8QaMCXcTzFXRKeHebPgWbVdizFdUZlYywgYxe6P
         mjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zfq/wq1jvZyPddM5PqBXRplnsqzIaGKOXA5twSKuOEI=;
        b=T4EG5V8fGzL6ODRnkj7UGJ1ed6mSehcqjxZADALA2G5L9h7iLTSNVEj3JUSqHe9At2
         mnZ8+HOxgeI6NWvEDvfF3rJX00hG5aDo4oevr7pNr+mamNOahJsw792xVuG8ECl1kxD8
         Ab7zbZ+TXTdHQOIHRbjQpdUFpZbyLHdnArW27K+KxHhYspw8l0oyPIhhlDmI4GVmRijD
         AFpnGuZoAk1c284I6My5m/TSmqecshQzoOVBcjdG+ssoplKG2iXUvqHgCGpJnp5OMLMk
         sggWKp5XR/5+tSyYjzH8Ty2uOA5WBfLcO+dtBXpT2pgitXzE9XzKxXkLTuDQ6npnpN4C
         /TGQ==
X-Gm-Message-State: APjAAAWX6/4loxv35avsb4dlhGFoPn6fD0I+6qgm9HU8Hn1T9fAjTb6/
        Wa0rahQ82AawSCVYWpK6HmKK9QCh
X-Google-Smtp-Source: APXvYqxRO2lY56g9aOwB663hmv0UFoX5NiTod1Mmpe1RGfq8sm7HFbp6P/mucLo0CqwXpLKAjb8Hcw==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr6278275wmc.12.1571815558206;
        Wed, 23 Oct 2019 00:25:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm21355158wrm.61.2019.10.23.00.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 00:25:57 -0700 (PDT)
Message-Id: <5cd79e24fe6bde7c5d10e1c2cae660858e3c4051.1571815556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
        <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 07:25:56 +0000
Subject: [PATCH v2 1/1] documentation: remove empty doc files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Remove empty and redundant documentation files from the
Documentation/technical/ directory.

The empty doc files included only TODO messages with no documentation for
years. Instead an approach is being taken to keep all doc beside the code
in the relevant header files.
Having empty doc files is confusing and disappointing to anybody looking
for information, besides having the documentation in header files makes it
easier for developers to find the information they are looking for.

here's a list of the files removed and if the info can be found in the
corresponding header file:
1- Documentation/technical/api-grep.txt -> grep.h does not have enough
documentation at the moment.
2- Documentation/technical/api-object-access.txt -> sha1-file.c and
object.h have some details
3- Documentation/technical/api-quote.txt -> quote.h has some details.
4- Documentation/technical/api-xdiff-interface.txt -> xdiff-interface.h has
some details.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-grep.txt            |  8 --------
 Documentation/technical/api-object-access.txt   | 15 ---------------
 Documentation/technical/api-quote.txt           | 10 ----------
 Documentation/technical/api-xdiff-interface.txt |  7 -------
 4 files changed, 40 deletions(-)
 delete mode 100644 Documentation/technical/api-grep.txt
 delete mode 100644 Documentation/technical/api-object-access.txt
 delete mode 100644 Documentation/technical/api-quote.txt
 delete mode 100644 Documentation/technical/api-xdiff-interface.txt

diff --git a/Documentation/technical/api-grep.txt b/Documentation/technical/api-grep.txt
deleted file mode 100644
index a69cc8964d..0000000000
--- a/Documentation/technical/api-grep.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-grep API
-========
-
-Talk about <grep.h>, things like:
-
-* grep_buffer()
-
-(JC)
diff --git a/Documentation/technical/api-object-access.txt b/Documentation/technical/api-object-access.txt
deleted file mode 100644
index 5b29622d00..0000000000
--- a/Documentation/technical/api-object-access.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-object access API
-=================
-
-Talk about <sha1-file.c> and <object.h> family, things like
-
-* read_sha1_file()
-* read_object_with_reference()
-* has_sha1_file()
-* write_sha1_file()
-* pretend_object_file()
-* lookup_{object,commit,tag,blob,tree}
-* parse_{object,commit,tag,blob,tree}
-* Use of object flags
-
-(JC, Shawn, Daniel, Dscho, Linus)
diff --git a/Documentation/technical/api-quote.txt b/Documentation/technical/api-quote.txt
deleted file mode 100644
index e8a1bce94e..0000000000
--- a/Documentation/technical/api-quote.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-quote API
-=========
-
-Talk about <quote.h>, things like
-
-* sq_quote and unquote
-* c_style quote and unquote
-* quoting for foreign languages
-
-(JC)
diff --git a/Documentation/technical/api-xdiff-interface.txt b/Documentation/technical/api-xdiff-interface.txt
deleted file mode 100644
index 6296ecad1d..0000000000
--- a/Documentation/technical/api-xdiff-interface.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-xdiff interface API
-===================
-
-Talk about our calling convention to xdiff library, including
-xdiff_emit_consume_fn.
-
-(Dscho, JC)
-- 
gitgitgadget
