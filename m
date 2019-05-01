Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A81D1F453
	for <e@80x24.org>; Wed,  1 May 2019 20:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAUdC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 16:33:02 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:42235 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfEAUdB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 16:33:01 -0400
Received: by mail-yw1-f74.google.com with SMTP id q2so560775ywd.9
        for <git@vger.kernel.org>; Wed, 01 May 2019 13:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t8d0PWxCBAEeWfWoKoWqKcITEj23zaLoGzzxelN5S9k=;
        b=at2sRTASeJSvSQ8sgXSnKhnGvtYlZu2EuoPCUeepdhGkE5eXxXH7lK1vb5bNbGnVEM
         XL5/ttO9+uPU2rm6w8Fi6dVlvIoYxuScUdO9xwjH9dZ6OsjBB39g+kthMT3kgZKVh6fr
         XiutErVHYonkGD6J4MFvEAaDO4xCqCrSI7xonHfz4kk/nB3qi5nxdQeai72i0aEQ92uq
         Bk7inSuM2IFie51FVNT/+5aFMmbybBT7xya2XMPKb/FlfPdtWaEBZSpgYjxYlRJC+oVz
         B63OxzWRR3WQnDXmQSj78PHinmgg4lCbIs/iM7v2CdAL11Q2INTDEwUVcuiDPncoF6dN
         c8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t8d0PWxCBAEeWfWoKoWqKcITEj23zaLoGzzxelN5S9k=;
        b=N+ytAZrELH3Lk1ZED7rwgr5SGILmTaxucsM5PSVdv7SqWNZ7ZU0V0Gf0N9ILDAC5cX
         0SgiJfXaP2N4aVhMn/FnPTG4vEFVCYBEjMFDl8aFzFBYmqY/a6x9a2IKJDFqlz+9wcsr
         Sk0Ja/k7i+qRV7BZ3/gp/kS2HXlNoLjHmpEv9Xk6m6KvZCiRKpAGSd4U0KRE+WyXIe0f
         bdqQWpybvR+hRpRMtOLH5y/pwqx+mR6VbyAcLva1sREd8A1M5Y51HuC8COZDpFCAeziw
         n1OG3wbI5YP6DBzl0W7X67+SeMNQu3KE3CMKik5WpkB9LWxpNcS+p8R5BUXGKdJ3fan4
         3tUw==
X-Gm-Message-State: APjAAAUCzZrMPOrdcSXH6tsduuanOIivRws+DOtWVJ/IrpZ3a27ebA0U
        l/3zLs5IXx8flqOnFhSes2bPEB+p8E4KPEil2s9Wf8XZgzQOBd/7yIXI9dN3sDhCU9sYG2FBTBM
        8KoxzIin21wDAD0ZKaCwhTPNpOGadWPeNP4rabOCTJSdz5JaEhea7wS29CF21aRdqWzF/C5hvCA
        ==
X-Google-Smtp-Source: APXvYqz6kPtoJvwMV+pqCNy5Tt6n5/It63wenM3kqJ6GrtNF8TtIc+AiuZdAQ+9nRwbnYngnqWBayOBOVKat12JC2Kc=
X-Received: by 2002:a25:cc87:: with SMTP id l129mr39247839ybf.465.1556742780995;
 Wed, 01 May 2019 13:33:00 -0700 (PDT)
Date:   Wed,  1 May 2019 13:32:17 -0700
Message-Id: <20190501203216.141398-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] gitsubmodules: align html and nroff lists
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There appears to be a bug in the toolchain generating manpages from
lettered lists. When a list is enumerated with letters, the resulting
nroff shows numbers instead. Mostly this is harmless, but in the case of
gitsubmodules, the paragraph following the list refers back to each
bullet by letter. As a result, reading this documentation via `man
gitsubmodules` is hard to parse - readers must infer that a bug exists
and a refers to 1, b refers to 2, and c refers to 3 in the list above.

The problem specifically was introduced in ad47194; previously rather
than generating numerated lists the bulleted area was entirely
monospaced in HTML and shown in plaintext in nroff.

The bug seems to exist in docbook-xml - I've reported it on May 1 via
the docbook-apps mail list - but for now it may make more sense to just
work around the issue.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/gitsubmodules.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 57999e9f36..0a890205b8 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -169,15 +169,15 @@ ACTIVE SUBMODULES
 
 A submodule is considered active,
 
-  a. if `submodule.<name>.active` is set to `true`
+  1. if `submodule.<name>.active` is set to `true`
 +
 or
 
-  b. if the submodule's path matches the pathspec in `submodule.active`
+  2. if the submodule's path matches the pathspec in `submodule.active`
 +
 or
 
-  c. if `submodule.<name>.url` is set.
+  3. if `submodule.<name>.url` is set.
 
 and these are evaluated in this order.
 
@@ -193,11 +193,11 @@ For example:
     url = https://example.org/baz
 
 In the above config only the submodule 'bar' and 'baz' are active,
-'bar' due to (a) and 'baz' due to (c). 'foo' is inactive because
-(a) takes precedence over (c)
+'bar' due to (1) and 'baz' due to (3). 'foo' is inactive because
+(1) takes precedence over (3)
 
-Note that (c) is a historical artefact and will be ignored if the
-(a) and (b) specify that the submodule is not active. In other words,
+Note that (3) is a historical artefact and will be ignored if the
+(1) and (2) specify that the submodule is not active. In other words,
 if we have a `submodule.<name>.active` set to `false` or if the
 submodule's path is excluded in the pathspec in `submodule.active`, the
 url doesn't matter whether it is present or not. This is illustrated in
-- 
2.21.0.1020.gf2820cf01a-goog

