Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4DB1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfENJTS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:19:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34022 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfENJTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:19:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so21870616eda.1
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WlAf67D476pTFObQknE0RCTuMWOp0kUrweF95wkSCRo=;
        b=uq3uvm3VWrAczTKNu34TW5cUqTyol/ZtaMvrKkxdZ+NCkEeW53rMbA1rEvpc4mYTvo
         WjMdhjvxKoJD94v+v4cbXWdR7nNU8zDqnr/9mY33y0Ko37F1HsdUrUggkaH9RMe7kjjG
         mc3sDgPmo2RDunSuFIycTpw5UReyYdIF+OrmLb8VStwN9C70SxUNzBptWF0XGTPIqvAl
         LwHikWK3fwGbHX/YtdKANe6Z5iMjhFA8733ga6tam8r0eqUZFb6cNBoU8vBS5jjvhBJ/
         1QzOx2TPU8+a1orqQjT+3bhSzxdIHO0+W1TuzM2UJ0ySM4eQsDEIbMAEN+UUuXb/265m
         VCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WlAf67D476pTFObQknE0RCTuMWOp0kUrweF95wkSCRo=;
        b=N+jFQh3NRGlikAoi3A4fyGVc973yThije5dSev1eU+c6zmFOrgIUaWg3gR8nmn0zvN
         qvKszO1oL4TjzwHoXJ2+VyqALM97JMXuKWLpKpCWofdTkCIWll4RWDRXM6vGyhb2t0Rh
         J+XIZHz/swwdD/6IlhZpl+uPHg/bq2+RwjidOVkr5gG9N671fktOqrNR1YvIJM1l7DQ3
         DOqK4N4K8EfuUVV8pj4vzlVP0ueOhAX6+Iq4yRzz112Ogl8vxUF94hX3/eRh2X+lNylG
         bSxZZVqXfQPPDAjLfaIrjULzWX3Z0MMPr6vPSsg7EqPp18LV4RntdrsJ1XFY8e5OovUP
         QZeA==
X-Gm-Message-State: APjAAAWbKLTxxcjoM8TztZrdu0jHj79p3rztqA2adTQ4+pSiRNY3ZltL
        9GtDQO/QILpunGYUXFKi6P1NR+nX
X-Google-Smtp-Source: APXvYqzYg5AhZY9q5TMkzZ6oe8eXyKK+KSDU79LG9ORr6S1VzCxvIBpUAMxjlGFUSgJ/8ziK8nITHw==
X-Received: by 2002:a50:abe5:: with SMTP id u92mr29556887edc.164.1557825556302;
        Tue, 14 May 2019 02:19:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay6sm1597847ejb.20.2019.05.14.02.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 02:19:15 -0700 (PDT)
Date:   Tue, 14 May 2019 02:19:15 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 09:19:13 GMT
Message-Id: <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.193.git.gitgitgadget@gmail.com>
References: <pull.193.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] stash: document stash.useBuiltin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The stash.useBuiltin variable introduced in 90a462725e ("stash:
optionally use the scripted version again", 2019-02-25) was turned on by
default, but had no documentation.

Let's document it so that users who run into any stability issues with
the C rewrite know there's an escape hatch, and spell out that the
user should please report the bug when they have to turn off the
built-in stash.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/stash.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index c583d46d6b..d7bf6ec61f 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -1,3 +1,18 @@
+stash.useBuiltin::
+       Set to `false` to use the legacy shell script implementation of
+       linkgit:git-stash[1]. Is `true` by default, which means use
+       the built-in rewrite of it in C.
++
+The C rewrite is first included with Git version 2.22 (and Git for Windows
+version 2.19). This option serves an an escape hatch to re-enable the
+legacy version in case any bugs are found in the rewrite. This option and
+the shell script version of linkgit:git-stash[1] will be removed in some
+future release.
++
+If you find some reason to set this option to `false` other than
+one-off testing you should report the behavior difference as a bug in
+git (see https://git-scm.com/community for details).
+
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
 	option will show the stash entry in patch form.  Defaults to false.
-- 
gitgitgadget
