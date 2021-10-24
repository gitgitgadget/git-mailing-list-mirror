Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE45C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F046103D
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhJXRKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJXRKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:10:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD33C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:08:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s1so6586995edd.3
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EbYMWedFbPPGNcfkO6xamvDsjGDJkRAcxqsuIAsw4c=;
        b=UtHiOO9UfXrueiSooTul0QRiugJzkTST/yeCbJjU3ogb7d91tqBDxR3P2+wS7g0EWE
         p7OegZkRstMreYew3H9uT+k4YN+l2ThcGn7Yyc3y+SkI3SfRfeww5ivk/BKnbLxT2RAP
         v6KQUIKixjgJuogxU/Nic2lThEUU+op3Mlj/DOTvMeDBsGbLJ0doESom8/ZOy0/JyCi+
         Jv535s49qSiH/JTVm5JnUsDhaaPTe6nQgXgIMFZwCUP+FVx3yP/Qw9YVf4Fh1VNYLQZ7
         T0ASzTx/Wl4tG4eZLK7I4cUr5Wl9W/9VkyV5EJdr+dCuxTgg+ZmYVu81zs47lnaOp/2H
         2vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1EbYMWedFbPPGNcfkO6xamvDsjGDJkRAcxqsuIAsw4c=;
        b=eeGWELmQ7kRzxoypgdn/pg7nIm9Kceyyq8Ayv9Lwkk4uy/fFz31z4w2HnFkictLULf
         2aIkoZIrqI/S2eyFZzh/KSXYQdVS4lPKCSLGQe6iSpr8ceH5Fk+EqoLoX0UWO2oukjV0
         bfXrYjFWRMvp7G25H3EhQJNDPKNp20TDIsNd99sIzwMbiGzjAXVqOwUwDThoTkiHvQxy
         konYc/MFW49IJzZBH+d7Toej7tKYxjNnX2dCyYJs4/vRt1tAoEfF0rM9jfx7OTqSxZNz
         Ka0NdFcL7ZbbG5UjXZncRJrUchvAiYTmIglw6+27ec0dgMHWSVMZIKzx69XGOUqTYMUa
         dJ9g==
X-Gm-Message-State: AOAM530o8788PgE5TFp+fOiXPV3vyuaXlakj/+0gYoIGRi39ulkoFbGx
        WYYZYCrS01lAIE0zrnt9gmOYdkYw7VYdmA==
X-Google-Smtp-Source: ABdhPJyBQSlRQi23oJYPqio8NGzadOomHJdnIY6G4dlL34jar8W8mCmsKfBuubxlpn3NiH1pNFwlCQ==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr16377184eje.112.1635095287929;
        Sun, 24 Oct 2021 10:08:07 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id g14sm3669553edp.31.2021.10.24.10.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:08:07 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] config.txt: fix typo
Date:   Sun, 24 Oct 2021 19:07:43 +0200
Message-Id: <20211024170743.9647-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the spelling of "substituted".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I spotted this one going through the doc-diff between v2.33.0 and
 9d530dc002 ("The fourteenth batch", 2021-10-18),

 The original topic is js/expand-runtime-prefix.

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c0e6b859f..1167e88e34 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -304,7 +304,7 @@ path relative to Git's "runtime prefix", i.e. relative to the location
 where Git itself was installed. For example, `%(prefix)/bin/` refers to
 the directory in which the Git executable itself lives. If Git was
 compiled without runtime prefix support, the compiled-in prefix will be
-subsituted instead. In the unlikely event that a literal path needs to
+substituted instead. In the unlikely event that a literal path needs to
 be specified that should _not_ be expanded, it needs to be prefixed by
 `./`, like so: `./%(prefix)/bin`.
 
-- 
2.33.1.711.g9d530dc002

