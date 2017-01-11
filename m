Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0333205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 20:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755751AbdAKU7V (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 15:59:21 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33763 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbdAKU7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 15:59:20 -0500
Received: by mail-pf0-f178.google.com with SMTP id y143so4157pfb.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b8+qyG/qgM2mYBlCt61KjctGIPrdPbzs/Jd/cT6AVH8=;
        b=BGd8SBCvUjzL6DN5N5t0gIU951R0IdM7LiCLpjMHjt89H9l4A6PEFsKqqoPZsxPRhw
         LWAoSabxpqKp07oIsdpI/CO+8PdVyvcei2O7TZPmAd8ziU9v8eMiBD+T4nDL2H1FYeGZ
         9DJN5l7XjEDELUrNLaX4Va6RON85TWaDHM7pAIq0U0TeiUwXg8+can8YP9KE/SCdjaOd
         ++xiJqr2KQ6g5ZS/sWn2TT2BkcPcum1edaLS2LlYqcoiTmSU4n2aJVvyXMFgreB9PgmW
         bJQczoYBEG5bTtWewGtUiUUlas2XiDEdKUtaaBI2OPDqJ3uSXpeOPlKRgU0ro/QbmDIU
         Sl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b8+qyG/qgM2mYBlCt61KjctGIPrdPbzs/Jd/cT6AVH8=;
        b=i44WW2bOxsiC/YZ6pLBKHABwYW6cPQs/NQJ/xk136WMRH8l8u5gmxXndwZH8vFoniI
         xlw8fhSJg8educlkg2JISQN75HiWHscH6LMDK1H716UgMPq1yhnai9msDTQSHzHrcags
         rFJwh7XKUtbuLsq3TLBKeyTnfCXo+lcAOvb/MphTU25z0E3MWlqTa5wK8sjGFyH71/0s
         PsBTp3lFHTr469jLuTdIHbhPC8R7oGjXU9rvEwykaWmy3jCou+gekQRtDx63/+3iYiiK
         Ix/SAAf2SfA4aNkptnhpKz3MxqRJcr5u+LYfvEz1kdFIPIMW6GeUfm6QlBtQS7SY9m1j
         TVmw==
X-Gm-Message-State: AIkVDXIVh1Y6B+GmtVoIv/bxhb6eTnCZEQYpvC/AYmtduvT6T3bd23x8zQYZzOs/OUvT31sP
X-Received: by 10.84.191.131 with SMTP id a3mr15931200pld.62.1484168359757;
        Wed, 11 Jan 2017 12:59:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7d8d:4172:e393:5f49])
        by smtp.gmail.com with ESMTPSA id h67sm15902169pfj.34.2017.01.11.12.59.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 12:59:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule absorbgitdirs: mention in docstring help
Date:   Wed, 11 Jan 2017 12:59:17 -0800
Message-Id: <20170111205917.14644-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.g7b30ecf4f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This part was missing in f6f85861 (submodule: add absorb-git-dir function,
2016-12-12).

Noticed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 554bd1c494..b43af1742c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -12,7 +12,8 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
+   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] absorbgitdirs [--] [<path>...]"
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-- 
2.11.0.259.g7b30ecf4f0

