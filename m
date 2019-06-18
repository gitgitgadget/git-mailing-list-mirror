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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C591F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfFRMYM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44640 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRMYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so21416976edr.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qUawvVx9e8pcL3sa1O6MgFXtN7nuq0z+7VUdxlYXMko=;
        b=IRlBJQgS3IUmE046w8rC+/vsoVUIoB9JUXam9/zVGOUYbP+K7Wz9M2y8g+qstfzZa4
         nfRJRksZVZrPzbdJ7vgb9FII7pzfY1Cm4qsp/tZeMvYzYCmjbmnnM7nF5Kr0UV05NsY1
         XDBITn7mg5m5+NSDdEAO356ThimuhosUH21EfVx5Crh8Utdt+NnlWSvq3aTeFF4SVYXP
         TEnsdqqh70bBPfGtwPhBxrwTypPhmZxy+ACMwuj4kozvl6jL9yJDPR1Y5FZ2uCW1wCFp
         6R3Z/q4NO7Kz2seGRPqHqUpqHaRClTKOFwdYgisEX5KIw9HcpNR/4/CLxTkad4yMc4EN
         fCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qUawvVx9e8pcL3sa1O6MgFXtN7nuq0z+7VUdxlYXMko=;
        b=pLEmLX1AuMAw3j0qTbFrUw2SWnN7bL/iLWTOVKCY2e5egWKzoz29QBakvSEd03EuPH
         d6aPpOTs5LAnVyN1GFXJXBALk9qqtDADHtfnGcKwLd6k/T+W5SBwN4KdJGO1DqT7gMyK
         QdgLEM2E6kVyeEO+/99RVtmmbWQS+STrpD70nNrCdoYVxrp/mRWyv8SY7kt3jW83xf5D
         rV5/O5qMMmIskYrOAQVYkQW9RMxiv+6Smu1AuLgWKc4uWMd8B42OW9tYqNq+FMtMgkKB
         Z7bK/DISJKilpnEKDEkPDE3BUMIhbcjH0eeWM0hy8kllpeTj3uiVkXsJljLvSka3CnfM
         P7xw==
X-Gm-Message-State: APjAAAW8W4RuLwYMsWFiYFffrpTbJO0JGEZDU+i6e+eEUzcC2jgzidN6
        nSaz6CEn0Jnq0oGRqMEeYG3q5nVz
X-Google-Smtp-Source: APXvYqy+CyGwehayGqLcNdgy8ZAWnbri+GrsDe8M2o/SfEr/JiQY7hnencJs3Nj0LkLn9PZx43anAw==
X-Received: by 2002:aa7:c619:: with SMTP id h25mr62973714edq.295.1560860643744;
        Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm679631eja.56.2019.06.18.05.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:48 GMT
Message-Id: <e6cd0028061d13c6ad03178e900085cb752f0603.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/17] msvc: define ftello()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

It is just called differently in MSVC's headers.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index d336d80670..d7525cf61d 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -18,6 +18,8 @@
 
 #undef ERROR
 
+#define ftello _ftelli64
+
 typedef int sigset_t;
 /* open for reading, writing, or both (not in fcntl.h) */
 #define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
-- 
gitgitgadget

