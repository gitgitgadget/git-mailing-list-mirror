Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FCA1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeKFFIg (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:08:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34877 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeKFFIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:08:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so1421393wmt.0
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfrIPbFkXRsFMyBtvxjQYcwgBLXRFC+wxFrBdXlEKhs=;
        b=bdvNT3vyYI2aKhlOWZilwCETJYRSFtEHImbbBfvBCkMOXhnHGinZ9uGXnR4fCh3Tbl
         XmEkR7/FJt5f/h6+/mbkFjZZVIiEmH8OX+wX1BgHN/D4ambAgMEe3BRVztCVHM7AjdZf
         fobuo/RgU3Hwvl5cOM5gtTnlkrA4iYtbNJAd1UCcXiwO47HABrJqnQ0WVh2NGY9x+S75
         6m9q9SlgJ1TGqw8y6NlGtIMT9meqnIRR0+0c7SwgnYc2SbonuKGrtVRRZ/Ua8teCOXm2
         kwW9KbuO3bGrvP5mHKHzMoodtUglevWmP6T+w2BXqUX3P1Jpue4Adwcvoq0F1bc4PhTD
         fmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfrIPbFkXRsFMyBtvxjQYcwgBLXRFC+wxFrBdXlEKhs=;
        b=rRiYM2jWaJDDHwOaCR6ysES6Q5TQQp4H2e+q/iAP3OmIQhaBJ3i9La5JLCH4biXWtQ
         lgLMlABWw+YNEW/ksNb7SzWfolEyr3gduMTY8AemCOaWVSpzfTtTz4Vx/8HLKs1quWJc
         fsRSun0Hi3C9DuBOonainXPcdpdIyItFaSp7vHFbwAzqwxlcBhBiK8Bi2uAHKoJ9MqWI
         0fGIMUzlRMBVHEWxZN87XqAhfdRm+Y4Ayy7RQA4N2K8FrGE+DeFymgEXAQV9cYmC9ffn
         ejExK2VdaubULxJUcxQylWzzNVpExH3lWqQu+bgMmhKhy66PMmeLTZQPLBWXW/B1UUCR
         alww==
X-Gm-Message-State: AGRZ1gIshmZsp9CksfgBWvE6ArR2UxHQUK1oaU5cbd7Tl7W7rc5OPs3o
        6MgnSnquYHWeWG/EFlhWqj4br3iA
X-Google-Smtp-Source: AJdET5dn9k/2+jlTfZsxn6pSY0YG9WDBw8mCngo2AmmBt7TqWpv1AanVork6UENHenluZ4rDzI8Njw==
X-Received: by 2002:a1c:b60a:: with SMTP id g10-v6mr7776722wmf.138.1541447239792;
        Mon, 05 Nov 2018 11:47:19 -0800 (PST)
Received: from localhost.localdomain ([95.86.114.54])
        by smtp.gmail.com with ESMTPSA id l42-v6sm19255040wre.37.2018.11.05.11.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:47:19 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] doc: fix typos in release notes
Date:   Mon,  5 Nov 2018 21:47:13 +0200
Message-Id: <20181105194713.25383-1-orgads@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 Documentation/RelNotes/2.20.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index 4b546d025f..bc0f4e8237 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -56,7 +56,7 @@ UI, Workflows & Features
 
  * "git format-patch" learned new "--interdiff" and "--range-diff"
    options to explain the difference between this version and the
-   previous attempt in the cover letter (or after the tree-dashes as
+   previous attempt in the cover letter (or after the three-dashes as
    a comment).
 
  * "git mailinfo" used in "git am" learned to make a best-effort
@@ -78,7 +78,7 @@ UI, Workflows & Features
    meaningfully large repository.  The users will now see progress
    output.
 
- * The minimum version of Windows supported by Windows port fo Git is
+ * The minimum version of Windows supported by Windows port of Git is
    now set to Vista.
 
  * The completion script (in contrib/) learned to complete a handful of
-- 
2.19.1

