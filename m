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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5547D1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 11:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439000AbfJXL3R (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 07:29:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392504AbfJXL3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 07:29:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so16955528wrv.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TiabJjyOPqctTJctnLqqxaqXcHDcwJePEB1NhQBango=;
        b=FEfdgKAj1/e1BhvqzWaokaCF6ro8IW6j3XnsVjnIrdfe4kOAX5lO4BFmCsIRi9d4m6
         t39NYBp20R+pn0whVPcW1lA19Ljk55NqZ1Mn0+tEEmR6QZaEQAnAW+q/ZVdO3b0YFv2U
         FwLRaVa+Lty2JJtNQJR9wXtQwiwizBUtm8AmQ8f5CR9Rs7UAOGVnoSBiUBQ9ttLZEb/8
         +hc4wtu+9KWGd4nO/AIdnbck1MwDTaXVF7ws9eWbCeJPJeY92zakZL93mEzUrOSo0hNx
         AGTF4ZR9PMX11EUf/vLn+1MsLXIKvhQWDm8fzJLO0cgdlN148bzJrrbrqI/Rebzts0nt
         MUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TiabJjyOPqctTJctnLqqxaqXcHDcwJePEB1NhQBango=;
        b=gDizD7X9JtyCN3bxGerPYf7IypYCHVkp4l/jqafT5qAyywmNCxWC9iwQ4BTQ2WALAz
         q44mCjcOkK5LgY5NAwMkVXlFgP1EZqYwcPrFqntsyBfWjsljqWwqSN/Ol2itVzycPR/8
         7SMfP5c8Iz55mRjmHYzLmAuf5JDdUwRrrEUR19COVez/iulbPtgeDjJiJ0vITGK/Nf/0
         D1gpIEGl4fWRs+S9DwBhc7VR1et5aCbBBarB/3yz8Zj/QTE8UOmoegOzSbRBDQRC7T1T
         oYAd8+jG/bc1ZXISeqw4RUmwVfdNqnt+4+76yFm97RUHLCoMWHCMY+zmARQPw4aLAa8Y
         aCBg==
X-Gm-Message-State: APjAAAXLPnJo4P6m4u2l7vNl4yiUWfZ/bTWMZTZHOI7yrePZEeOrql/h
        HNgCTLq7cE/q+0UjmeIWGsdCgHBO
X-Google-Smtp-Source: APXvYqzKgJw4RMRpOHOZSmlLxtj5au7UD/H09e37wGstKo34EEsgOHYYtggRzC6YSYPw01D0fohg0w==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr3387734wrw.117.1571916553509;
        Thu, 24 Oct 2019 04:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm3402023wmg.48.2019.10.24.04.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 04:29:13 -0700 (PDT)
Message-Id: <ee64a075d3074718a47da4ed369cee6923d0b460.1571916551.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.412.v3.git.1571916551.gitgitgadget@gmail.com>
References: <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
        <pull.412.v3.git.1571916551.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 11:29:11 +0000
Subject: [PATCH v3 1/1] documentation: remove empty doc files
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

Some of the content which could have gone here already exists elsewhere:
- api-object-access.txt -> sha1-file.c and object.h have some details.
- api-quote.txt -> quote.h has some details.
- api-xdiff-interface.txt -> xdiff-interface.h has some details.
- api-grep.txt -> grep.h does not have enough documentation at the moment.

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
