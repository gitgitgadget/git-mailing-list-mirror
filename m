Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840EB20401
	for <e@80x24.org>; Mon, 19 Jun 2017 03:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbdFSDFo (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 23:05:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35440 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbdFSDFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 23:05:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so14651757pfs.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tlt5LD4/4TvjNmQY/2ZsmyP4XUAPFtxKS//rDdzdU0M=;
        b=CNI1RM6kyYQok9bkiVVS4yR0+5OcNWQ9WcKrtaIpdvUny0UtEDPDrQiqlvbfiS+Ruq
         HymdzG1YaKor2W/hjEPqEhIe7HY/BBY32Z9H3LOfB9PUnmuX9sI5R36ARR7mDtNugcBB
         6KZylw0XbzGU3qHGkneg7B6TWg4FWTlXlpD2raWzfMPCI1/kbxRy4wkq1spxK5rkvroA
         ywE17UFxxpy3t5btCjQi6b0baOAY9JISPlXp9qv5d+G3K7FhmqfI6tFBOZeYZKZUTdFk
         5/pOhC/m60/2sR5xYa4VNjPVE+aIxuO1l4ZlMxoqdhLs+TMbS3ifRav6LNxICwSk4TyA
         PhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tlt5LD4/4TvjNmQY/2ZsmyP4XUAPFtxKS//rDdzdU0M=;
        b=VtT1PCdU/oBoGMH4PzKkC0Emjia0n8/LRsagVovf5a1xRuQq9KZJQLz9IUKb3QvWFn
         tfzFE78J7Qqe656gV/HUjgi7Feji73DxuG7pJ4Ce/6OS3kzPXyDCOZGyYYYiV8XgPagZ
         AaxIhqhyqqL97pEHO8MP4NnWLIzJmCi4mUYqMgb7XJI+YyjEZuCO07Z6jhB0uCAx3YIf
         wNkhTakong5mxYWt1EIDxTQbvrOAv37yQmtbj6JopJayrkbDyghvbW9LUDvCUS9ebVPf
         MoCX4F3UZhiWCJsuWuCyLTXVcSTsCmHvr6SAWnlNjWXjbHtA85dBX/jCvG9FvznsBaj1
         Go6w==
X-Gm-Message-State: AKS2vOxLcgk7wb2q9HWZRmcvSMVGsNI7fUhYtbuq7IGa4AWOvQ5NHg2T
        T3D8dowtrF5Hew==
X-Received: by 10.84.228.201 with SMTP id y9mr27049339pli.300.1497841543008;
        Sun, 18 Jun 2017 20:05:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:8284:9daf:c00c:2460:a1a2:73fc])
        by smtp.gmail.com with ESMTPSA id n9sm3000887pgf.50.2017.06.18.20.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 20:05:42 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH/RFC] Cleanup Documentation
Date:   Mon, 19 Jun 2017 08:35:18 +0530
Message-Id: <20170619030518.6712-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Remove redundancy from documentation
2. Remove unclear reference to alternative

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---

The following line seemes unclear and hence was removed for now. Suggest any
changes that could make it clear.

"This second form is provided to ease creating a new submodule from scratch, 
and presumes the user will later push the submodule to the given URL."


 Documentation/git-submodule.txt | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc6200d..9812b0655 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -63,13 +63,7 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-This requires at least one argument: <repository>. The optional
-argument <path> is the relative location for the cloned submodule
-to exist in the superproject. If <path> is not given, the
-"humanish" part of the source repository is used ("repo" for
-"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
-The <path> is also used as the submodule's logical name in its
-configuration entries unless `--name` is used to specify a logical name.
+This requires at least one argument: <repository>.
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
@@ -87,21 +81,22 @@ If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-<path> is the relative location for the cloned submodule to
-exist in the superproject. If <path> does not exist, then the
-submodule is created by cloning from the named URL. If <path> does
-exist and is already a valid Git repository, then this is added
-to the changeset without cloning. This second form is provided
-to ease creating a new submodule from scratch, and presumes
-the user will later push the submodule to the given URL.
+The optional argument <path> is the relative location for the cloned
+submodule to exist in the superproject. If <path> is not given, the
+"humanish" part of the source repository is used ("repo" for
+"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
+exists and is already a valid Git repository, then this is added
+to the changeset without cloning. The <path> is also used as the
+submodule's logical name in its configuration entries unless `--name`
+is used to specify a logical name.
 +
-In either case, the given URL is recorded into .gitmodules for
-use by subsequent users cloning the superproject. If the URL is
-given relative to the superproject's repository, the presumption
-is the superproject and submodule repositories will be kept
-together in the same relative location, and only the
-superproject's URL needs to be provided: git-submodule will correctly
-locate the submodule using the relative URL in .gitmodules.
+The given URL is recorded into .gitmodules for use by subsequent users
+cloning the superproject. If the URL is given relative to the
+superproject's repository, the presumption is the superproject and
+submodule repositories will be kept together in the same relative
+location, and only the superproject's URL needs to be provided.
+git-submodule will correctly locate the submodule using the relative
+URL in .gitmodules.
 
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
-- 
2.11.0

