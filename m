Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7672B20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCHJ6L (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46184 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ6L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id a22so1140533pgg.13
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxuXbtiA46eeBBQWta85tfBdSWTIQI8W9tWpaNA46uc=;
        b=IBp676wQDB2+B7Lyk+liYpT46rrc13HsudnIddjxNpfvr7gMq4+0D/AZXICEJCLS9P
         oSWvjNo2xCBCPAeb0GyfbMSnfrhAnjKmB2+wCuMnxB8RBLeQe0y3TQHSYcnkDbI2u1qx
         FOxgGDm2ujXVSGjF2dE2slFK+m7E2z5zGumRfyK3iIlwtCHGvJ1oHBlILC/33IKp/NjX
         KYTyfD3WSOpgZag75sz5PoiGRMrH0PNeTV5G4JIzWKKICgRASCNBvcvkKSL1toQIAcIq
         Ku7fPLZkgWlyUqzrNeyBjdC9LVVrvsxPEEGDrmq7UdAMrcE0GihDCWuTGx2BLoxCloxL
         v+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxuXbtiA46eeBBQWta85tfBdSWTIQI8W9tWpaNA46uc=;
        b=Z2CcOAeE0KXCietcu2J5PrT1qLwqHvobEb0yV8+DthLwuxk6njVDQBfLefNshP1vzC
         K/JLdi0Fp77K8lY1KIDDvUgchx0b0PTRvYpGAsA+eVYzVXPuS6pX2km6u9MtjPV+2rOJ
         CWs3EBbKiLXmpdUn6fooCDwitenq4kT2+Zg0XrkEDziSFpASkfvxFQnCAmuIrRx6/Vq1
         ZP3qVJWwSc756tTUm7jJK/Jhk0zfvz3WGZ27MGRC9rSg/UtdWAsQ7u2x/qG6z3HVh+uN
         Ck6pgqHHYbqGMgvM2nCl7/wyAzZdKnIIm65lo+STga8kP0RsI23F6ZiGlNyywhby+XsN
         5BHQ==
X-Gm-Message-State: APjAAAUMXkBa0cbfZLMO6N4JgoGHUryV10n90q9vAoksYB8lvtwc775K
        9Y1Z4aOEl1346OELhrJeTLU=
X-Google-Smtp-Source: APXvYqyZYBZRp3+3ga8f2fAwnAMpmVz3LWCoEssvUUYzUi71PRYTsHhIkf/+AzFbb0WonJ8NB4Kv9A==
X-Received: by 2002:aa7:81ce:: with SMTP id c14mr17160613pfn.51.1552039090359;
        Fri, 08 Mar 2019 01:58:10 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id m23sm8892362pgd.20.2019.03.08.01.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 02/21] git-checkout.txt: fix one syntax line
Date:   Fri,  8 Mar 2019 16:57:33 +0700
Message-Id: <20190308095752.8574-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
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
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 99c8c0dc0f..28817cfa41 100644
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
2.21.0.rc1.337.gdf7f8d0522

