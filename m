Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE7C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 16:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356684AbiBNQqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:46:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356817AbiBNQqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 11:46:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011660D9E
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:45:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so27856340wrc.6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3PXTkBSf1EmRf5by+kR2eed3qxLM7J4PKkQeF0DSQL8=;
        b=AiyQ4dHkAKS5dlkgN/3OWlaZgog5WfHySauahLOksYTehJfQOgVcKT6BWj5UfUDCXF
         tXJ/fPmTUusSI3eW44IkJ94EbkvTR5HzKBi6xJLIS2G7lyqDlCqWWSY3kG5aTryzTR1w
         ZLstAvVVN/4ZxV9Ue8Aow3TmyyTlgoMZZjBif4+PTOJGzWjAbHLn7hvlQ4kmnj8NzjQt
         1b1cPuYbU0f/ILGBwaB+xonbobcxdzXm83AthpB+GUxKj8utYRRNBmGhCJ8l+dtyoo5N
         +hlTXSXfro0gdBdquKv5jM/IWk9reD9BKO9POPukFK9EQcx+c+yexNu0696wIQ7wy2I8
         aLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PXTkBSf1EmRf5by+kR2eed3qxLM7J4PKkQeF0DSQL8=;
        b=qd34UfmmFCi8S3fta/EivdeouO3ZW3ki+ZfudAlaLIrk7Tg/ZNO3gMfwLZ9eOeS1QB
         jAxOf04XoSB6rhGe9PR0kTKj5nEmAMBVgCpNNgDxKcrDMASiOMjHw9n8b7nN0EFtL9w+
         vK4YITRUTOAdcTNybRkayGVD5KeHzZHeLk4R2abfg/4BlnfIRZPWzc+Zf84o+z1U9LiW
         ild6dUcxfUAMLrGlW6bWIXiHwv6WzCJcTCkuSIt3V1PzguSzzhS2wPzeqaJUHHbLG7dp
         FE8lql1YEiaMD1Tclh/TTqwtd4XooygdrFzp83XmR6R1Dfgsg70W/a7CfSbRo7pmztDq
         nUvQ==
X-Gm-Message-State: AOAM531Fdy7cYl5nBeUl8GuuxXlFSvhwqD8P4+5LcbuiegrjrScnA8sQ
        JaStiZBkeZt3287T0CLBeE1x9XaSLus=
X-Google-Smtp-Source: ABdhPJy0ty66R059cKFV+9BB+hI7rG66fJg/lP3pQHVKjuRC6hYwOkTnxKeczL7J8gmmu45RLM7TeA==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr371556wrr.1.1644857154653;
        Mon, 14 Feb 2022 08:45:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25sm12478691wml.16.2022.02.14.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:45:54 -0800 (PST)
Message-Id: <pull.1142.git.1644857153590.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 16:45:53 +0000
Subject: [PATCH] mailmap: change primary address for Derrick Stolee
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Stolee transitioned from Microsoft to GitHub in July 2020, but continued
to use <dstolee@microsoft.com> because it was a valid address. He also
used <stolee@gmail.com> to communicate with the mailing list since
writing plaintext emails is difficult in Outlook. However, recent issues
with GMail delaying mailing list messages created a need to change his
primary email address.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    mailmap: change primary address for Derrick Stolee
    
    As mentioned, I'm transitioning my email to my @github.com address. I
    might still use stolee@gmail.com for some old threads that aren't
    completely available in my other account.
    
    This also doesn't change any commits that were submitted before this,
    but should affect all commits that I submit afterwards.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1142%2Fderrickstolee%2Fmailmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1142/derrickstolee/mailmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1142

 .mailmap | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 9c6a446bdfb..07db36a9bb9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -59,8 +59,9 @@ David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
 David S. Miller <davem@davemloft.net>
 David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
-Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
-Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
+Derrick Stolee <derrickstolee@github.com> <stolee@gmail.com>
+Derrick Stolee <derrickstolee@github.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
+Derrick Stolee <derrickstolee@github.com> <dstolee@microsoft.com>
 Deskin Miller <deskinm@umich.edu>
 Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh
 Dirk Süsserott <newsletter@dirk.my1.cc>

base-commit: b80121027d1247a0754b3cc46897fee75c050b44
-- 
gitgitgadget
