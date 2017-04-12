Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43531FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 14:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbdDLOCQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 10:02:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33982 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbdDLOCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 10:02:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id o126so5268218pfb.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zi3qhSdC3CVDo4YQrLo81jqCscL9Srxxm/xszpAUa/s=;
        b=kPKBNBERoEsmamOlEsszvPAZNgoV2WJJy2faC5gik5i39Sim5yMAdhcHYLKQLykvFY
         lUZ6G+eZI7w7J+mOhC4dSytyx78n9cum8sRcsSyNzMY9kPjxTnP25Id7hnLMutcyb9MW
         e89JEHjH3NRpi55HqVfX8NAYVd+yoDAazVZjgu8vSnewgHKBgtnjS5ZGV4HO1P6f/7E2
         USN8ejCGK0/ysLlxOpGEh+KPkFkCNs90XhWZPO/SkIketh24+xmCNdL0LswB2+teeElV
         a75ZIHfObggcloC9vPsgsNoqA7vvhLglV8fOirMgTlAvjOT19eD0xWt0RTszhzAfCi4z
         nwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zi3qhSdC3CVDo4YQrLo81jqCscL9Srxxm/xszpAUa/s=;
        b=i/Y/dQ6gHb4nQWLY2o+hKN07MxftsJxQoDwvDWN7dB/0vZXXu6+fhijTIkyrBr8m4b
         cQvBcvY7jRSdPdFx+aHdrVRaDLVezMlA+swyBrM5zfYiUiDuyh+KOVejWWoWs1HIoG5u
         pm8QG9SbcSHIDb7qwIl8/i56e0iXUqyeSKKsHgKP69s/di+Llgyw6fHZQ/uNcmfJVTAU
         YuhR+nF5HNGdcNlenUDQa6D93epYf2Y4SUhWmXayUpoMls8LqKfV4lWUN/7RR/S/Ls8Z
         O3iyNDMROWWhCXXxVtvg4Q40a6ADfjUoCT6mTpM4+YSN42IDL9vr5R6VFMfJvkWWalqY
         4K8w==
X-Gm-Message-State: AFeK/H1AaIh8vytMUTrgPTumT6Y09Lu93m4891MdGMU2q47+kBi0P5ORSkHCDXdWfpuhrw==
X-Received: by 10.98.144.4 with SMTP id a4mr45851834pfe.243.1492005734167;
        Wed, 12 Apr 2017 07:02:14 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id m69sm36953082pfc.33.2017.04.12.07.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Apr 2017 07:02:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 12 Apr 2017 21:02:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] worktree: change 'worktree' to 'working tree' in help text
Date:   Wed, 12 Apr 2017 21:01:53 +0700
Message-Id: <20170412140153.30196-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have been trying to keep the terminology consistent on the
user-facing front. Let's keep sticking to "working tree".

While at there, change 'other' to 'another'. The latter is probably more
correct.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3dab07c829..b8ea1ef966 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -330,7 +330,7 @@ static int add(int ac, const char **av, const char *prefix)
 	char *path;
 	const char *branch;
 	struct option options[] = {
-		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
+		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in another working tree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
-- 
2.11.0.157.gd943d85

