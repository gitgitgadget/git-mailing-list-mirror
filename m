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
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D161F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 18:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfJVSTl (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 14:19:41 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39097 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJVSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 14:19:41 -0400
Received: by mail-wr1-f49.google.com with SMTP id a11so3072797wra.6
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SpydsUTdlyT3dGF4+a0Ds/TQ2CqVIMtv00tIKMCFNow=;
        b=WIDD3GCcJgDW0qA6gJiRu68FJLRK6VLZudtJdSBVoRn96rVzhxKh+nLVs7NhoR3x08
         qeIMLaNE01pEGVuW9X3Dvvlw4/dbqo07+ZLEEozC3qT4mDG1uO+QLjgU8OF44Cwu/1Zb
         e78GxwjLjUzqBDjJr9RiNkwe7JBTaYPN0RMcDKX5qz/7v2Gwn+asOAyJoewXyeerpVBd
         qxCORBrfdR6AQ0PwUtHyTkcLXCoe0OXyDW2inUlFSsSR56oggL8vZySMt3fVYV1W1r4A
         PZicINejloOZ6CaJal5oJvuYBmK6hgFGEn8YwUc9bh9N/707V8Y+xp8Z8OVbDZC/BE0T
         Raeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SpydsUTdlyT3dGF4+a0Ds/TQ2CqVIMtv00tIKMCFNow=;
        b=bBo+Fjcz3wjSPiTQ1DjLDq63L5jBsigJmNdFXLSCNVFlFFPtnbFmfgLaAooUwyketS
         FVqUiL56hszvusFsjrVTHHVyotZUJYgj5k26wdqC9Dz/OGRT80tA8siiuYS3JwYzxr9T
         e96N4oTK4dfKIKjzfsba9A7Rdt68zSGTQ9+GqxfDTWyx1eWITZ70w0P1IJWTNzZcexb+
         A6dcQb8b93UIP+jB14CGMs2lIZRZWbpvnYgbkqO/ccJWMv0/Pa+6YOGNwufVaoQTQCNn
         kepqWnj9nruaRq9qB8X43dhUVnzRl7jtkVoaEbKFIcWMoDknAHXV2C+0RrrosB0CshHA
         LOhQ==
X-Gm-Message-State: APjAAAVWkShG1j2DBoBPzpGH29k+7VyKCHl6g3evxmgaqze3eGQub0id
        7+5WhiN1+cCtbZ/tdzN1LVKrqz3+
X-Google-Smtp-Source: APXvYqzemUQqSecxkYaPZHle7lvw6XA63n2NmQfvh451iw/76adMr9NLh5RrIa4D4SKsrGlVtlLleQ==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr4696962wrq.381.1571768377784;
        Tue, 22 Oct 2019 11:19:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm19587224wra.82.2019.10.22.11.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 11:19:37 -0700 (PDT)
Message-Id: <ffdde613d8ea2dc57719594aa0f89b6d6177b636.1571768375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.412.git.1571768375.gitgitgadget@gmail.com>
References: <pull.412.git.1571768375.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 18:19:35 +0000
Subject: [PATCH 1/1] documentation: remove empty doc files
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

As part of moving the documentation from Documentation/technical/api-* to
header files, the following files are deleted because they include only
TODO messages with no documentation to be moved:
Documentation/technical/api-grep.txt
Documentation/technical/api-object-access.txt
Documentation/technical/api-quote.txt
Documentation/technical/api-xdiff-interface.txt

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
