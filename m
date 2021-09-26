Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A264CC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 03:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D28460F0F
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 03:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhIZDtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 23:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhIZDtx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 23:49:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7996C061570
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 20:48:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w17so40026766wrv.10
        for <git@vger.kernel.org>; Sat, 25 Sep 2021 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=X0u0jo3dmvsK7WGf9NlGO1P/HX3r2n337Luuci9g3vA=;
        b=UGx/67y3v2jC2odr6oAG5iFZb74/RGiHK40BVrAfuG3kY5BWNBhezA26wOvOGBtM9L
         h8RP7JNfO5e1pY63h9qwGQnnbC58rjNP1+NnnqiABZNOLJXWZTqsOw1EzUUi66Oil4SE
         QAvhfDbr3XzxhTjl5mnuWyXJLotQCw/BSx3LOntpBntVYcrIKuDEbZ6HXzuh5XvcjVow
         N+7Q1w5Og73d0KLrgu3a53SxtlVv67tJstOSscqriG/9ehBy/1pOZrATihbTTeIC6Kwb
         uQvY6axXcXCQjf/PUQXqg+M4K033SZsrEc8VUvZ33ypCdQDG4J56c/Ct9PYpCy0VapOy
         2EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X0u0jo3dmvsK7WGf9NlGO1P/HX3r2n337Luuci9g3vA=;
        b=K0m1TTAhpCrEijbsnSwGI2HDSr7PsrQ73vVyz51JRDlsPfh3NzUC+aJEgY+sTPbYKI
         b73cQFX0Ts0fyXX5sIdH/2zOzo40U0C7iT0irQnaOIfy/CnU353kVagQEd9GU93q25C9
         ZpfTNTjtOhyPPVzuqC4LGbRIoc7Xr0ipK3Sv8tzvUADhIDsfD9B4Mm8HUSxzhvAV3i7V
         hFEyE/zscZbEvlPF45nqaDUCN32puZlx3RKsv3FHRVzAWnWExWM3Wn0bA9C5ik49Xg4q
         dIGWUxn8p5rXvfwXlXMBC3NyXnanJFUWxvOwa9zHZ48kYYB/eyAlgBYc9wOr/huH/tJj
         oicA==
X-Gm-Message-State: AOAM5339U8p3F+mJp/2Gbp90ncjj9mbuPK85hP3NhmdxlI18TRvYsJlL
        E/Cv6i+Ibtki/cyUCN6cbT+2+8rrwAA=
X-Google-Smtp-Source: ABdhPJyMlrf61EviOolPqUnarszNmZ3Lb5RK1Ithkcw5WttU1OM60qGPfDhDMGi0OLg7LThy5eK1bg==
X-Received: by 2002:a5d:47ca:: with SMTP id o10mr20754753wrc.326.1632628084312;
        Sat, 25 Sep 2021 20:48:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm15169875wrb.36.2021.09.25.20.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 20:48:03 -0700 (PDT)
Message-Id: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Sep 2021 03:48:02 +0000
Subject: [PATCH] doc: fix capitalization in porcelain v2 section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

The summary line had xy, while the description (and other sub-sections)
has XY.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    doc: fix capitalization in porcelain v2 section
    
    The summary line had xy, while the description (and other sub-sections)
    has XY.
    
    Signed-off-by: Orgad Shaneh orgads@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1095%2Forgads%2Fstatus-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1095/orgads/status-doc-v1
Pull-Request: https://github.com/git/git/pull/1095

 Documentation/git-status.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 83f38e31981..c33a3d8d532 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -363,7 +363,7 @@ Field       Meaning
 Unmerged entries have the following format; the first character is
 a "u" to distinguish from ordinary changed entries.
 
-    u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
+    u <XY> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
 
 ....
 Field       Meaning

base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0
-- 
gitgitgadget
