Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2EF1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 04:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBLEDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 23:03:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36982 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBLEDj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 23:03:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so609002pgq.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 20:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y5aykyG630kSScQcIXC1ZPaKY34QmazU0FJDYrM4X/8=;
        b=FhI3YmDHgT2XolqepQR4ApFl7o0mLJtCSD9wvMAMT2xjueLzkDp+ciMi52XjIvqXhz
         DCsOreh0SeW4/si9ifcHTOc7Bq2MGK5L9Aco81LStmkUbHZnynj6ic2kOQOwqat9FTR+
         TxS7uEUwlHVBYu5WveFe8n/YMS4FZxo//tq1/NUN3LKCpA0E7rbQuY9gygv3n63eWZfx
         x1Ba/B8T90c80v1yy+jCITkbvJ/a4JthcXAv3wGZq8dUXhCKw46UcpAd6sctquYvsfcO
         xZcJEPnzCWMV2G5BNPT7/ICdYfNBRcSJq5AJnrVnDTIgiuvBkbS2DyVgc49Pqekql29Q
         Zeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y5aykyG630kSScQcIXC1ZPaKY34QmazU0FJDYrM4X/8=;
        b=nGV1QtrH6+fqHCMYcvx/0timVlj/+95AXw+pAtzm4oMFacstV+iB1Vcgh+B+18+LsD
         xvmmAj5TqWz0HLMF6LHtU2Vz03bKAA3jOBPGJcME32atHcd5Zw7k+ZyZ+5IcuQSDVG+p
         +Er3q0/HQn5yOeN3rc85erZqUbReiJt0aN4ClrNCRbZzkIuJthBvQsTB8fFz8WDkn3Jn
         R8X8g+TKPFwOTyn4319/Be5/GhQyJa98jHUncmLU1cO+/lyH+awg9V6Shtg00puNc0lj
         BOtrSNDZfwdutIkuhWpOwTcy08ggV1QalUEScmH2MTRnzQBVhjVn1+h6hT1RBD5AUmw1
         FziQ==
X-Gm-Message-State: AHQUAuby79b/7Yf8fNO4yizO2UzMH+Nc54xfjttcP/M7O2otb2/C22zU
        LRL6j2YmHJGuaOgruPjk5tWYnclW
X-Google-Smtp-Source: AHgI3IZiYlERKIlMwoPGtAJiEHonbmmsp6iPpbrjt31c5aXz5/bYzvGFrpuj20fR0UT2Jc3HQTx2nw==
X-Received: by 2002:a63:4858:: with SMTP id x24mr1726134pgk.420.1549944218504;
        Mon, 11 Feb 2019 20:03:38 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b29sm13882934pff.34.2019.02.11.20.03.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 20:03:37 -0800 (PST)
Date:   Mon, 11 Feb 2019 20:03:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-submodule.txt: document default behavior
Message-ID: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch documents the default behavior of git-submodule if no
subcommands are given, similar to how git-remote.txt documents it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..9bc98da154 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -28,6 +28,9 @@ For more information about submodules, see linkgit:gitsubmodules[7].
 
 COMMANDS
 --------
+With no arguments, shows the status of existing submodules.  Several
+subcommands are available to perform operations on the submodules.
+
 add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
-- 
2.20.1.530.g88cfe87ec3

