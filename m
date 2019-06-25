Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156881F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfFYOtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38831 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731906AbfFYOto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so27588899edo.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lh8M4uuq6uxeqs7vyPbvNZQipnmzq/wt454JVAsQ5bo=;
        b=PTEHm1wXOkD1mngbVwhbjVdDovs8ByGbon3OVk2UTUdQlDYafVT2NXJfXnVOU3U6xD
         A4dbXZshl2qL03DRDIUuw0eAXDkxAW6Qxs1T8ZXTWlqMuX56KP+4BoXcKejG6A11F4XV
         0ZV5Y3JGsdN00aGJCO+AfFP+beVNCxnDtOvHqptZiFj2aGxX7xUz9a5itSRskYmdTK/0
         DR/i5nvGG86ZJzM6qsBoizY4cvkQcoFIXgT2BAB2uBLZqOwG1tWE0pnxcYAu345EdaXy
         m9enieLXbm8buQ1Gzia7+lHjjtcqDEjaIZIUVxooC05q58lde6WmWEwjuvyxWxaiCaSj
         BWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lh8M4uuq6uxeqs7vyPbvNZQipnmzq/wt454JVAsQ5bo=;
        b=L8y69APm7xzyn5ThBTOt28vOntik5RfgPrWRZn8ruqvqSCriQku9XH3KXOA/oyc7bg
         PPieWfYjB4UT4lHA2YzxvkVIWUAhU7PERtB0G6xJdD3I9h9lwQbviNWH5nt6aU8+LaSh
         wnPc28dRjfczOTf6OBQONZhjT1wR/JNmIp76/9uEJDF+q3/OUtbUo+9VHkF7GX7eit7K
         O/c9zTCHfLa0QK/LMCZXCCcms1Ijq4Gs8HKfdsH9B/ZBVxi5M7JBOCVzKKKgkdjG6vSQ
         d0pfWq09+18xnB5SWZ2rjMVgXNjTekQ5g7iIDdtA571oKCN4Y3j+0vSYY8ivmUUWfBtM
         yDOg==
X-Gm-Message-State: APjAAAXa9ItLaMu4sjo/mTw1U+uz1oHZ3gfzz2otexbBV8JbUNa2AIuD
        XT0jG7AU4NULl5qefdYYeG5JsA5g
X-Google-Smtp-Source: APXvYqyCQh+yJkp5Xb2jJRi28nATfBWDjy+mByG9SJSx/+fMk71dkkKx1X3/VEnJJvruJ6++DQuunw==
X-Received: by 2002:a17:906:af4f:: with SMTP id ly15mr119055440ejb.126.1561474183191;
        Tue, 25 Jun 2019 07:49:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm4883864edc.37.2019.06.25.07.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:42 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:42 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:26 GMT
Message-Id: <4a7ceb21725f18f48593085ea22decfb6fc153b3.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 20/20] msvc: ignore .dll and incremental compile output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Ignore .dll files copied into the top-level directory.
Ignore MSVC incremental compiler output files.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 2374f77a1a..ba0e52c4d1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -226,6 +226,11 @@
 *.user
 *.idb
 *.pdb
+*.ilk
+*.iobj
+*.ipdb
+*.dll
+.vs/
 /Debug/
 /Release/
 *.dSYM
-- 
gitgitgadget
