Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7E41F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeAFSqj (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:39 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33743 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeAFSqh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:37 -0500
Received: by mail-pl0-f66.google.com with SMTP id 1so5126571plv.0
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MPjZrtnOz2qf9fujuA7svn6oHcKBu50prpL+ojMpc/Y=;
        b=GbnrAn47zuaVQ9ACso3swL00QyvJWOBCu4X+JV38sQYEX76zNJtRQAkbbVXDNxjMi5
         Kx+erzrC3xRqw8UKVZP5f0UInP9//pbIyLMVBwll4JJMjHGmVWD4ydsTDQUKx8iy3Y7A
         Bue2QUyDpAczEO7KmwP3dbrKIX4dZ1vw0ngdJZ8ETtx5+ZikFb/1upfayJ5yVyRgPsMx
         J6e/fwu/VZsAeLaojSehcEQ67jkYKDAXIAg5mxjCL7NP4Vh+r7s0ueeTZmumVu85LzC+
         37dWUxjulfE+pYgmxa6MVDsQ+qoNnmql579W7FCSsMCKeTcZosnJoqSdwq3cB6vnN2pW
         KwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPjZrtnOz2qf9fujuA7svn6oHcKBu50prpL+ojMpc/Y=;
        b=RbO/BJtamlFKpSGVnbhKS27iB2cZzHscRjqb3p/P5VXa6L1GXDWuDvREARj5cwiVZl
         H8pIv2fEA8iQTq837ZxxgyEehEJR8CPi6lWIEn1qgujI6cCm124Z+zerXDrqbjgyTVEO
         pZZaz+qvbZJpHr37AAuVzAr7i9FpIGiF6iJKNSMiMqOwig0nQB+ReTFV0Bmqtey0SJL4
         dU5A/lwoeOBnt1y2pmgbl69mPTlbxjat3HsW4Gwc8pQ82B9NZxVuVBkV4OdZlKgKplcE
         ibCLTqUhUQAzuMVkLqOJDdNbMjmzsoTy6HM63qRVBsrfz4Uv5tLqqF6cdVbiFeFpJr+k
         DwJQ==
X-Gm-Message-State: AKGB3mLkpkGqVqiLY9Qh4kocfXl1OxJWBPJLo+Uj5wP6smcvYtvztHnZ
        8q2bbCXLHnRZbITqpAgwsCVMmDsA
X-Google-Smtp-Source: ACJfBov+vgYrOVJ6NHuWQe3IsmpVK6Ib6xMu6pkQ2HEzVP46A1wzta3h1kKATSiudDz0vjo2dF9eiQ==
X-Received: by 10.84.235.76 with SMTP id g12mr7073966plt.62.1515264397103;
        Sat, 06 Jan 2018 10:46:37 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:36 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] Doc/gitsubmodules: split a sentence for better readability
Date:   Sun,  7 Jan 2018 00:16:07 +0530
Message-Id: <20180106184614.20115-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 46cf120f6..bf46b0fb5 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -36,8 +36,8 @@ The `gitlink` entry contains the object name of the commit that the
 superproject expects the submodule’s working directory to be at.
 
 The section `submodule.foo.*` in the `.gitmodules` file gives additional
-hints to Gits porcelain layer such as where to obtain the submodule via
-the `submodule.foo.url` setting.
+hints to Gits porcelain layer. For example, the `submodule.foo.url`
+setting specifies where to obtain the submodule.
 
 Submodules can be used for at least two different use cases:
 
-- 
2.16.0.rc0.223.g4a4ac8367

