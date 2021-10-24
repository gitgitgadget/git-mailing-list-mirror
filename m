Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8978C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B754E60FDA
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhJXRL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhJXRL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:11:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E85C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a26so7926843edy.11
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKf/hcFh4eqosjLbR6Om1WGVF8nPaR2gDbDgmjCuq8o=;
        b=N/rSGzP/203dPSwz4PxxIXGSTEGUYsDTLtRiypwWCmLj4JJSMM3sXVCne9c2Xp8Oo4
         XY42Eplxdr9P+FcQG5zEHYu/xjCecGprmQEhMOC+9n1ExZte9dUnexNaLJaqjQC/+43U
         bzp6ogmNsdLk7RjvwBAo6C6029VD9nRtscQOjnmXqS72S9JtQU0OsmsrY8D7R2j4TOah
         Q8w3DVc97CGaz36SXxmEemQBXAaEItkz84hkbLKsWbCEpehiXIrpKNJGU5gNNmbKc0ny
         ANh6BsSsOUP5kGEpm0HKQG5Ejj1XIcI3iwyoCZLd4S3httB3fQtVPC34eId6p1es3gBs
         7BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKf/hcFh4eqosjLbR6Om1WGVF8nPaR2gDbDgmjCuq8o=;
        b=6IK07dZ1EnI7Tjnfg6ZUcfn5lse9m4NULgDv/eG+jYaXVL/mS5+NGQ0dRHXC4UwfMA
         0XcwKhMMWWte3lhcWN09HEwgG3nC2J7JCYGc42ONG4wREi1Js91b/8eX+MzVyxNu9bws
         bgy8d3hebhdsvcUmGo3b31KdZ4TTKd1xZt9iTgJBf/lqcnObfvZpX16ihed43LD2VwuK
         C8dKbmwzrHtSGX+78u9/W/ICHN+9TyJyj43Eo/5XII+6u8cVt1YSz1Sl0gZxaNTK1dhM
         PsxlJWug/VNai/TlfwOSWSoy3rOsfexHqYG4xgz7mZsnfUm8Jvz+gKDhpWtOUocs2Gt9
         0AUw==
X-Gm-Message-State: AOAM533AkW1hSTUQmON4x8JG4nNnuJGY62uUv55DGM8QdxPrtBrKmGLF
        DnBJDwvGwz/szQOvVHP6akQkxJUK9+EYhg==
X-Google-Smtp-Source: ABdhPJxRutWM5kuRjAZsPZlML4ltzre0kNuplY89CGWnbRS0ybP1DMCxNfgf9oCcgsG+4T4UdJtN1g==
X-Received: by 2002:a17:906:4d97:: with SMTP id s23mr15992009eju.105.1635095343551;
        Sun, 24 Oct 2021 10:09:03 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id v13sm6369378ejo.36.2021.10.24.10.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:09:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] git-bundle.txt: add missing words and punctuation
Date:   Sun, 24 Oct 2021 19:08:21 +0200
Message-Id: <7defb11c1c295550105a47bfdd9f030e0ef7c636.1635093692.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
In-Reply-To: <cover.1635093692.git.martin.agren@gmail.com>
References: <cover.1635093692.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an "and" to separate the two halves of the first sentence of the
paragraph more. Add a comma to similarly separate the two halves of the
second sentence a bit better. Add a period at the end of the paragraph.

Further down in the file, add the missing "be" in "must be accompanied".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-bundle.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index ac0d003835..50ea8c82ca 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -51,10 +51,10 @@ using the `--thin` option to linkgit:git-pack-objects[1], and
 unbundled using the `--fix-thin` option to linkgit:git-index-pack[1].
 
 There is no option to create a "thick pack" when using revision
-exclusions, users should not be concerned about the difference. By
-using "thin packs" bundles created using exclusions are smaller in
+exclusions, and users should not be concerned about the difference. By
+using "thin packs", bundles created using exclusions are smaller in
 size. That they're "thin" under the hood is merely noted here as a
-curiosity, and as a reference to other documentation
+curiosity, and as a reference to other documentation.
 
 See link:technical/bundle-format.html[the `bundle-format`
 documentation] for more details and the discussion of "thin pack" in
@@ -144,7 +144,7 @@ unbundle <file>::
 SPECIFYING REFERENCES
 ---------------------
 
-Revisions must accompanied by reference names to be packaged in a
+Revisions must be accompanied by reference names to be packaged in a
 bundle.
 
 More than one reference may be packaged, and more than one set of prerequisite objects can
-- 
2.33.1.711.g9d530dc002

