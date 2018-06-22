Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D231F597
	for <e@80x24.org>; Mon, 16 Jul 2018 10:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPLCj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 07:02:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34640 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPLCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 07:02:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id k19-v6so706677pfi.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=5vcrjL1AzbmOck6gCTmNuw509CiBYlw8ZOR76UzdPao=;
        b=V5ORkEl+mkxB5F/yHoJ6jz40xKHy1Jg33O1nSKOps6Y7AfSNdayq7EsOGtzPFTlH44
         a+oo94turEWbHgEsOsYJ4afpA0hF6mSRSfaxKQ+HlePeSrYLViigPnMZDIaP6p1uXBWM
         YQ2MmDNXsBi4eK0MJdD+aWloo9XWX5dcbraVPTgPuLZXtwNmmEJOoarONF20eXVVFLbd
         2SU3Uw5mz60pIsPxMQioP95CI2OXjKgr7+uW0X9dpKmHOhfSnA0TVEHiCZ6+sqKnp9cU
         PRHhItDlde0Ldh18XHWJyEtDraDivLk5RUjEKAunX6NsOSZwgBdgN3ybKvsfBUXZyANq
         e15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=5vcrjL1AzbmOck6gCTmNuw509CiBYlw8ZOR76UzdPao=;
        b=JqQQxFeudE2x1wpbfXF2R789RNX0Gfn/zUOW5Kg4Gz4FjKbnc1Aj6MvFGD6zGuDMej
         PEutwKFqPtsSRA1a7ou7+BmJNLKFn98m/UaF/rWBh0F6RVFR/zJizZJmwq7USQZoAJSU
         nVC9ZFDZCIGKnHX1StTU5K/dsI3YzW+smdMzJo1iUcH3QqIvviPTAgq+QJiYvZh93UJl
         e+Cwu2MRh7+kRm18dSH/40p15dboErbqRoxdmpKghp2LsjHseIalDgGlGCH5UClNfQSd
         xs9tgMed0OivSpSTQ6epxLXZAlndQ3ZjxH0j2z/1auxl42i8xywcLfGH3Ru1KbJBklb+
         vZcA==
X-Gm-Message-State: AOUpUlHs3AmWal/UoKrDfg6+TcSJ4AxLEVqxEiqzAk9/UL8FW26QD4F3
        dRYTGAxu9BidKAnFrAYPI/GUuA==
X-Google-Smtp-Source: AAOMgpcFnEWDlTWJSZs9tBydbGd0Dctk1EqOyuDohaIAVALLE+EyamdyYYF1qb6NKcY/Wa5lRGcMLg==
X-Received: by 2002:a65:5307:: with SMTP id m7-v6mr15403718pgq.431.1531737350694;
        Mon, 16 Jul 2018 03:35:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c131-v6sm50420128pga.69.2018.07.16.03.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:35:49 -0700 (PDT)
Message-Id: <3da0295aae92ef214781e0acb97ac2aaeabab7ae.1531737346.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.4.git.gitgitgadget@gmail.com>
References: <pull.4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jun 2018 13:09:11 +0200
Subject: [PATCH 1/1] vcbuild/README: update to accommodate for missing
 common-cmds.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 60f487ac0ef (Remove common-cmds.h, 2018-05-10), we forgot to adjust
this README when removing the common-cmds.h file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/vcbuild/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index df8a6574c..60fd873fe 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -30,8 +30,8 @@ The Steps of Build Git with VS2008
    the git operations.
 
 3. Inside Git's directory run the command:
-       make common-cmds.h
-   to generate the common-cmds.h file needed to compile git.
+       make command-list.h
+   to generate the command-list.h file needed to compile git.
 
 4. Then either build Git with the GNU Make Makefile in the Git projects
    root
-- 
gitgitgadget
