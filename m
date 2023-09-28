Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C5E743C9
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 22:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjI1WAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjI1WAE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 18:00:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD10199
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 15:00:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c73fb50da6so5697285ad.0
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695938400; x=1696543200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aKgsTwVU9j2jTmx+o/u5LBJXh8r7nbPz/xjOr3GbN2w=;
        b=f2le9N7VhqdkUsTvwdvLxGb6AcF8GbY+6GuIOWa8h6k7RO1h3syCaydXHPo+d58TNK
         4mR02nVz3KbZSiTHFvDL1Jkz9Elg16MFhJluQoEXeuuBlChcab0gg+1yNyvSMxW9Xv3F
         ljKjCINowPTnq5C9cTBhnkFqsZaiHX1yc3ANzITvoKQLC28l5btlfC3DrZUUn48wamwD
         CGzIsSsQew6a7roCOfMs04QhHuAE6qU1HxgVBtLtljdPk87iGj36DHJEEjIYFOW0ApV5
         DQ5/MOLUfxE0ybo4VVKhygV3gKEs1hVXrVW1gSjHU4HE4zrNi0tgQ60mIeS3wD9f+SVY
         ypSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695938400; x=1696543200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKgsTwVU9j2jTmx+o/u5LBJXh8r7nbPz/xjOr3GbN2w=;
        b=M83N5PDsVUQvkTlPD/vlnUSWWprVir4xCWlbO+vp9qROu0fKy3fXycXp336IXTwYWO
         kCZ9rWO5sjC0bFNKyI65fkejmGpGlhm9ZaRvVFXGx/nYRketlck2/syHlJ+Ou6zVjZ2N
         wFqipTbGcJRTqYjxyMlaFVWlrappS3yOfJIhtTq1OO2OvrECl1hmCH48ZSZuctjxRqoZ
         3yI68kV6SFKsb3yq23gm1OUNR2tqEgjtwlLXgDkkTkMJ8QSorGY+aHg4HdI+OJfHGJNG
         z7hYd4deNuxAyiJSEQJvJZp7BbkxcJuPFC3KCBi+3fAjLZCj9OdfdXIMzvjyfOz64Ozj
         xZow==
X-Gm-Message-State: AOJu0Yw71ivQ/lf60EBCG9DDaFbFOK0Ok+9FWJoj2H5VlsUKdRc2dnuM
        kTycZr0a5R+4D+ks8X5mkFL5PAW5jqLMYdxySGruOtCnUTDgWcQZgndX0NSgltopX33/IC5Xh86
        jXJbUpcOCSkYe+pOyrTiAkTu3OWSOcjq7DfDv3V9zTJzG1hVEmqI2DJlmuxWhq29uBw==
X-Google-Smtp-Source: AGHT+IEUF3S/msJLgYKWCaLPf0MtwyIZgjKCF2MueLR6QizcfkC3du+vI2gTeoWBGFIEQJZNSXBQI7yzWwqnwSY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:e742:b0:1c3:a4f2:7c85 with SMTP
 id p2-20020a170902e74200b001c3a4f27c85mr30391plf.6.1695938400097; Thu, 28 Sep
 2023 15:00:00 -0700 (PDT)
Date:   Thu, 28 Sep 2023 21:59:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928215956.775786-1-calvinwan@google.com>
Subject: [PATCH] MyFirstContribution: add Discord server link
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Link for new contributors to join the Discord server -- a separate pull
request to add the link to the Community page has also been added.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/MyFirstContribution.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 62d11a5cd7..3751131a00 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -59,6 +59,12 @@ respond to you. It's better to ask your questions in the channel so that you
 can be answered if you disconnect and so that others can learn from the
 conversation.
 
+==== https://discord.gg/GRFVkzgxRd[Git Community Discord Server]
+
+The Git Community Discord Server also has many knowledgeable and helpful
+people. Additionally, it provides a space to be able to voice chat about
+patches, designs, or anything else Git related. 
+
 [[getting-started]]
 == Getting Started
 
-- 
2.42.0.582.g8ccd20d70d-goog

