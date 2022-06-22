Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B7C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376885AbiFVTuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355466AbiFVTux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 15:50:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435E40E45
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:50:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so18448970wrd.6
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=py/aihfl9gRz5FNVlLwJZUeDGa//qDo8anbQrM0ULks=;
        b=o/Flsfobz/S9Qt7aQnJYqGNo9vCVAQE4TtQ/DOgz7xDE0293kdP4gwKNMi3IbXH9cG
         jsKwpoAcxR+VW/XLNfkT+QbekTkRSWkmoCIJLIiBr0wspI642YvVdJES71oJK6wsB0/s
         Jzl3IgyUzn49AwKhVhKGeJselWIT+i1aAoz9rlao3Az+ODj41l7znldzGKZTwchseL8C
         9zWy5teE6gT4Ck/zqfOaggckUskinvqFmuiRB5f/QgN1a85FNakOyXqz430s1q7j8Lq7
         HyhIksdhASzrjduAo4NcY2nfO1f5FcxQsS3qoUiKSUnnrydrxXkNJIPtKixpAdJFGkXN
         j4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=py/aihfl9gRz5FNVlLwJZUeDGa//qDo8anbQrM0ULks=;
        b=f+nfvy3zQtXQRZP070BE5tc9XmQEEka0boIB59eCO9BciipQ/VnPv72lBZtpn9DReV
         rYuJTArBqvQLGMC+6jORNQqmHr2nDyEXJ1ZDZmQPEih+rpnEdW5iwNx7GdfUPxTw4zpF
         CYdbX06tY9JVZGfr35Y/fH5jo7R0AZKkd9MeGoMljnxYrl9dA+DTMBCJDruLkpcQEIBp
         VlDPAGK7cVCChtfvC9lbKEjGj0mUMIy6vlWYFqpzK0B5UKnpIf/F58DEEbRs1XIGBk8a
         RtG+4BexG/fwgH2hfyhmafZODndAa8e/h51X4MHSg3OL98c/RmOxl26L1DewJHjuB685
         wUKA==
X-Gm-Message-State: AJIora+r8q6UU1uZd+B/hkKHGzFyAndxMCAxkwt+eVWvmklMh9M/AR75
        qEFNq0+3C4/Tw5C6fH9h1MtAQ4Epdfp/cQ==
X-Google-Smtp-Source: AGRyM1sqIZwzYkCnaKb3X6RH/hPxggiomwVXsQ+Lq4x9rMoIDmA3wtfgzqgGXFTEL0+jAcchGCtLeQ==
X-Received: by 2002:a5d:6ac4:0:b0:21b:a724:1711 with SMTP id u4-20020a5d6ac4000000b0021ba7241711mr276575wrw.80.1655927446306;
        Wed, 22 Jun 2022 12:50:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5-20020adfef05000000b0021b99efceb6sm5502536wro.22.2022.06.22.12.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 12:50:45 -0700 (PDT)
Message-Id: <pull.1280.git.git.1655927444821.gitgitgadget@gmail.com>
From:   "Arthur Milchior via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 19:50:44 +0000
Subject: [PATCH] po typo: l10
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Arthur Milchior <arthur@milchior.fr>,
        Arthur Milchior <arthur@milchior.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arthur Milchior <arthur@milchior.fr>

It should be l10n

Signed-off-by: Arthur Milchior <arthur@milchior.fr>
---
    po typo: l10

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1280%2FArthur-Milchior%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1280/Arthur-Milchior/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1280

 po/README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/README.md b/po/README.md
index 74856ca5bf2..3e4f897d935 100644
--- a/po/README.md
+++ b/po/README.md
@@ -5,7 +5,7 @@ describes how you can contribute to the effort of enhancing the language
 coverage and maintaining the translation.
 
 The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmail.com>,
-coordinates our localization effort in the l10 coordinator repository:
+coordinates our localization effort in the l10n coordinator repository:
 
     https://github.com/git-l10n/git-po/
 

base-commit: ddbc07872e86265dc30aefa5f4d881f762120044
-- 
gitgitgadget
