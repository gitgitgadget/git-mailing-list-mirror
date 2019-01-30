Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908661F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfA3Jsn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:48:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46191 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:48:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so10802766ply.13
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBk5a69TGV6LtsCwXdBSZ6V23iSvTPo6GaA6IpkcwYk=;
        b=kvZ4BP5Dd+ZgEPbsaeMc0jWaavvAK0+e5C+WHjSp0aMBzcdOvj71qBmbqYENy+3Azo
         IRjbQzTfYcFMEypIs2qjfQ/EtNlz3zS65MZ7WFHshmAvih9wOdX1LYWjKSG0CBqE+0Jh
         /f78zbJIg7vP2lhRCKrnCjbwJRQtQs+4NUJGbA8yZCHBOhqfBtZrKTbyfiyzJ1FcoZye
         YtqDVs+nQ6+TSyxREZyCgKwPxZFIwcLzpVgXZKEPjV37MRZUq9VUXUzMT5k6AzKVjve7
         m3ip4DbEJyV39Tugtn91fqGOoQWexizBK1lTFdXQGmCj6S5Ei7+bZDLRMW1OtOhL2d9Z
         jWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBk5a69TGV6LtsCwXdBSZ6V23iSvTPo6GaA6IpkcwYk=;
        b=na0Cik9v2uXLJYMoOZy+sdRTavXCIG+vsjcQKYQiH8vzea7cYnLD8bmk7thAEp0hn/
         LGbC3r3MKEE0utng8mT7H2jfKdbp+5xPShk6H7laNnZ0BKQUZAL0IsLt8vH+DsMFAqxk
         S+bXHggAkzsAsBZQJBaVAQhBivNu52QpusDbB59ZQC3CjFEJMJlwEEAPwwkSFqolvGui
         0xx0FQzgh7Nxrmp+EiSbLTkl+iFgDRaIGHP7IEhdkfAp7yOtmgR/EpTDQueQVFRSQrOR
         /Z1jcFu0jwPZCr3RUt0x4qFGHrBdjyNueEjnx21IQKiBk8pb1E/Pvwa8hZ3OVGDBHNs6
         wEzQ==
X-Gm-Message-State: AJcUukeljd8guGtCMEaDwU3aroQA2walYO+Mh24Ef85aKu9vJjYIoFbJ
        79kejnS5Yo9O2crXSrxDTjhxa0QQ
X-Google-Smtp-Source: ALg8bN6zYcmjQ6MTQkSJ8Bqf2tFm9m8QQDcnzz2z3mgfXSbGt249pU8oEp2MKnMdyQbZ6iX7dbZV3Q==
X-Received: by 2002:a17:902:1005:: with SMTP id b5mr29793190pla.310.1548841722577;
        Wed, 30 Jan 2019 01:48:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 22sm5754262pgd.85.2019.01.30.01.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:48:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:48:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/19] git-checkout.txt: fix one syntax line
Date:   Wed, 30 Jan 2019 16:48:13 +0700
Message-Id: <20190130094831.10420-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<branch> can be omitted in this syntax, and it's actually documented a
few paragraphs down:

  You could omit <branch>, in which case the command degenerates to
  "check out the current branch", which is a glorified no-op with
  rather expensive side-effects to show only the tracking information,
  if exists, for the current branch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ce7d38b8b7..bc7fbdb8d2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,7 +23,7 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' <branch>::
+'git checkout' [<branch>]::
 	To prepare for working on <branch>, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	HEAD at the branch. Local modifications to the files in the
-- 
2.20.1.682.gd5861c6d90

