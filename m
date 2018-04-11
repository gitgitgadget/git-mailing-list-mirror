Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98C291F404
	for <e@80x24.org>; Wed, 11 Apr 2018 21:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755186AbeDKVJd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 17:09:33 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34176 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755413AbeDKVJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 17:09:30 -0400
Received: by mail-wr0-f174.google.com with SMTP id d19so3082312wre.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xfgJDFalqxmy/xU+Isw+TWqLnnHV9+8H7RY1fm3gzKo=;
        b=JMyj0g98eF9jQmIyPOOw6dW1DZTHjKmizM4ssjcCg7srB+YoIkrO87oShQZGXrRHkI
         WWfa+cPz5Yg9KExUOP7Vqho1irmJIeASrk1rBd4u0xAmF3twR844Pehfswlam6HJUn9Y
         c+MK9WJCYAltUXMcMAD/s01lV4DapgIZAxIQiKjL3SK4eWkcY6ll3Cnj4auvol5AvvzG
         9yy+1gRj2q49bpQ326/gzu71JuF7TSCE0nM4gEEB6vojsSsqne9dq5jcht8Sjknox7yr
         2O0gkooT/o8LWrOWN1QBYQUOxINNe8r9hiR5BfbDFal5LZqL29i+zO4kgMLO7dHpum+R
         T5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xfgJDFalqxmy/xU+Isw+TWqLnnHV9+8H7RY1fm3gzKo=;
        b=AQbEq+yZRRv85lN9+31vgL1TxOXrYOeMmLiFqUC5Oy71Qvp9dlwhrN6GPT1GVJavA5
         kQfteBOz6hrL1GB8fhNUETf4te07ZAvgqKGXd0UxZ4g1ThA1p/IpZ4N/ZJMJ+JkB/iG+
         SYsYb38ChXiMVfasovee0lsJaZ66RRXkdae4jwx53WVPG0qE9wzq85T6JPYgAYXES/AI
         pK2hHPizJdSSjHUFApf1nEdRnjQ7IwAEKGyDFI9OkZP7H7KnyROE+hhRKA2cwZPzZrDu
         QA0PqGU+o8VKNwoY/+lzeKsEXbrKPCAU8Gv1VLric7PA9O7GjaI9N29MPQrcKXY7MgIH
         omsg==
X-Gm-Message-State: ALQs6tA+Vq40oBrjl1TQtdOkaxoTI7eX/md7KnDpfKN8wG51KCJEwEIf
        d9yLAMX6Umu7Huj6QsyH2NbC6n4X
X-Google-Smtp-Source: AIpwx4+Q7z+eqErBQHi6AJPF3nuqGwR8vLVb+hdmZdCWU+WaI2YgWtTByKUbjCxAQlm8zk8LEnFTsA==
X-Received: by 10.223.149.68 with SMTP id 62mr4217799wrs.201.1523480968574;
        Wed, 11 Apr 2018 14:09:28 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:2863:8879:6ffd:c5f2])
        by smtp.gmail.com with ESMTPSA id b17sm1506909wrj.32.2018.04.11.14.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Apr 2018 14:09:27 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: fixup! [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
Date:   Wed, 11 Apr 2018 23:08:57 +0200
Message-Id: <20180411210857.22598-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411210857.22598-1-asheiduk@gmail.com>
References: <20180411210857.22598-1-asheiduk@gmail.com>
In-Reply-To: <b227d2b3-dfe8-09cf-2705-da70bfebd268@gmail.com>
References: <b227d2b3-dfe8-09cf-2705-da70bfebd268@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- reflow some paragraphs
---
 Documentation/githooks.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index be31376767..ab5ce80e13 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -194,10 +194,10 @@ for an example of how to do this.
 pre-push
 ~~~~~~~~
 
-This hook is called by linkgit:git-push[1] and can be used to prevent a push from taking
-place.  The hook is called with two parameters which provide the name and
-location of the destination remote, if a named remote is not being used both
-values will be the same.
+This hook is called by linkgit:git-push[1] and can be used to prevent
+a push from taking place.  The hook is called with two parameters
+which provide the name and location of the destination remote, if a
+named remote is not being used both values will be the same.
 
 Information about what is to be pushed is provided on the hook's standard
 input with lines of the form:
@@ -410,9 +410,9 @@ with the difference between the branches.
 pre-auto-gc
 ~~~~~~~~~~~
 
-This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It takes no parameter, and
-exiting with non-zero status from this script causes the `git gc --auto`
-to abort.
+This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
+takes no parameter, and exiting with non-zero status from this script
+causes the `git gc --auto` to abort.
 
 post-rewrite
 ~~~~~~~~~~~~
-- 
2.16.2

