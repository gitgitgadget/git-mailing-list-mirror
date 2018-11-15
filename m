Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C741F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 11:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeKOVaH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 16:30:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeKOVaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 16:30:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so5434059pga.9
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 03:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CENw1BEq4McCBGXdk6LIbEAM3h6cpjoS0fE1Gs4PxUI=;
        b=k5Q+ldKP0keN6ZK9iTFRhrH2ttofV+1TQ6z+YlUmEJmXOSDXHzGqYt/MEUyOGWMVc+
         sRaDS+/a3MHOtk4vAZa2IIqY8h7guxoWyEybv/VOyi2YNrDU6nud1KmWiGdHLJ8/dHTq
         ywKmgaTEztyEglOKLDfYTmtnw/Nh88zbkzUkkQVdcs9yRqvk+P5vT+euG7oEfOcNIZ68
         DqaKeMaPAsHxJ5nZRhjxbuhVb6i3QKHt2YS65LAn8/xoLZ1Y2gHXrDIrAOBtd50tNFGE
         kyLOLbznMwfhbAC/0WTvaGR9Qu3Ihclzmnym5f7CgmYrtavSBLc/fsRzKMZHvdEczMkj
         LieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CENw1BEq4McCBGXdk6LIbEAM3h6cpjoS0fE1Gs4PxUI=;
        b=gTbKfDYCL7L6HnJHu+gv/fkMckJbtAmYyG82GSEzbY7S1kyOGIElnCKIBc/Kcqi398
         4EoB0bMji3dhgCYkiQ0lzg2qjKP4a/Owrtj2P4h0nz+JlOqL596NLSfswgkewGY72kPz
         dVXiBpr7CyKv4edOUmuzprk8zZr/Eu7p6AbVRyRttWwFJxP5P02k/GpdEMWwVpBWmH2y
         WY2Ep9IgzdqkZ26cSMlmJzbjFgjT+M4l1BekS6jr5UhCMjyHOD9G+Vfxw+ZRuZiRFoEE
         95Lfl08fpECe9kePBUxCgfI8+duYYFLKUofqed7f0R5+ToDBq5J8loeZ0G/3hfgMbIEt
         tERQ==
X-Gm-Message-State: AGRZ1gJsSXvnNowv5BoODdZHNI2Q/fIn99LOrv+q6Jv/3UcAD0zSaLQc
        psQYm/4jCKIVZ+SuKZqP+jnuuUIU
X-Google-Smtp-Source: AJdET5cWmkIdZ34LKaZsMa0BQ4BmPRlGuN+l8EgQGP+pGIiskvwnSL5wjbb7YKbHeo3OfXEyiS+VUg==
X-Received: by 2002:a63:5517:: with SMTP id j23-v6mr5337470pgb.208.1542280960733;
        Thu, 15 Nov 2018 03:22:40 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id n87-v6sm33881514pfb.62.2018.11.15.03.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 03:22:40 -0800 (PST)
Date:   Thu, 15 Nov 2018 03:22:40 -0800 (PST)
X-Google-Original-Date: Thu, 15 Nov 2018 11:22:36 GMT
Message-Id: <c78e1b73f0d23657a0723cfcade916097d6abda0.1542280956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.81.git.gitgitgadget@gmail.com>
References: <pull.81.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: replace an obsolete link with the superseding one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The MSDN documentation has been superseded by Microsoft Docs (which is
backed by a repository on GitHub containing many, many files in Markdown
format).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d2f4fabb44..9e42b0ee26 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1028,8 +1028,8 @@ char *mingw_getcwd(char *pointer, int len)
 }
 
 /*
- * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
- * (Parsing C++ Command-Line Arguments)
+ * See "Parsing C++ Command-Line Arguments" at Microsoft's Docs:
+ * https://docs.microsoft.com/en-us/cpp/cpp/parsing-cpp-command-line-arguments
  */
 static const char *quote_arg(const char *arg)
 {
-- 
gitgitgadget
