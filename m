Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD221F463
	for <e@80x24.org>; Tue, 10 Sep 2019 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfIJTJX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 15:09:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42101 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfIJTJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 15:09:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so12091562pfi.9
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jlnr1yHhqw2O+GRhLuH/CEt/T1tyqPFdaAKNsaapZt4=;
        b=GhuueACcekVliLviiT8wGwPwRQMeq+tTx3cMWlBHqZI4kMCMzsWF7JonZCbUNwv/qQ
         PFLqldtAKqhtPitBpP+ndeW0sB0QL5Pk1L4azUjmd0ddxDnGshjjSk++vq43oslTzzqU
         BQ/FuGToG/MXB6ZbaI4OEP0y/wWKaMVYr11vRgOVSyRUuPY2KZGy/WeWQT3DH+WFCCGx
         FyLlCUYdKp9a2FTkibOYliGjWQ2+tAO5E1yKpGed++J6TDjvGbJzky3oFrvsnIbC271Q
         J5Mu7EYNknjRmtCdMg5GMkXj8y5dTRRtXyZGePC3yK43k9haAwS0/WHWamiz2G+Bl7O0
         feaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jlnr1yHhqw2O+GRhLuH/CEt/T1tyqPFdaAKNsaapZt4=;
        b=NdA69qD+1HdEISTPHFkK9JHoAmaaGM1mrpVS4Oa3zFP0sJpACHlC2bEJpKSPkQjvLc
         jfa3bxLeQfzyMlt4TeSqXSVwt0DAT5MmxQwzKrfYcTTtXq5EU49z9rVAv/OQYeoLLcwF
         l0viokHwaDZ74WbjskUn5Yc/ccXAn1uswTuXvHgAajW04JHzJfgHhm0ZAL8hvlufb/+M
         IHAd5fdKq8VPTqDF4FNQp9pcE/DQjueTRcR/C7EQVnQ0ScZW/icFA6ps0pEnYuLqVHS6
         0PDZnBZfBmlWM1ByOL3YcBB94xD2RYXfD8PmaBqx5uV+icry16geErcTzVIDFF3YM8hy
         2d8Q==
X-Gm-Message-State: APjAAAVq4HFojLBEGxV3NLh0o0qQfvn9/H+FOhAWO8P2eMyrI2X4p1UR
        UJqen0kOAeTOFgReZDYY6/d9B5zrSDQ=
X-Google-Smtp-Source: APXvYqyhtLCVQCE7cpX9bo/4rCP618HTCShLRL+iQBcsEbKnvpV5HFRvTHcuDDUVUCsQlND/Pqey5Q==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr29185119pgq.269.1568142561815;
        Tue, 10 Sep 2019 12:09:21 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 33sm16230983pgy.22.2019.09.10.12.09.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 12:09:20 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:09:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] git-submodule.txt: fix AsciiDoc formatting error
Message-ID: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b57e8119e6 (submodule: teach set-branch subcommand, 2019-02-08), the
`set-branch` subcommand was added for submodules. When the documentation
was written, the syntax for a "index term" in AsciiDoc was
accidentally used. This caused the documentation to be rendered as

	set-branch -d|--default)|(-b|--branch <branch> [--] <path>

instead of

	set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>

Remove surrounding parentheses so that the "index term" syntax is not
triggered (and because it looks nicer without them anyway ;) ).

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..e349442f4c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -173,7 +173,7 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
-set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
+set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
 	`--default` option removes the submodule.<name>.branch configuration
-- 
2.23.0.163.g796a25ee1e

