Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BECB1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeIVE1W (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:22 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43128 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVE1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:21 -0400
Received: by mail-qk1-f201.google.com with SMTP id u22-v6so14332275qkk.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T2eIYO+W3QXTcdtue+CtselyEgFKQY1rp/XH4muMrNI=;
        b=lKHfUJuhpyZULvbC90NihFiv1/lrg/N4wJ7cuRrdAYWaK8rF1U72A10ZQXB0tXHz/m
         IRw+rKOavMMDEf8AQ6+ZHFPB9JZ6Voygsp81HzxI8L+h06wmESni48DY/Ly0D5vqNQHh
         TIOILJhrQ920WIQettsxpNmDD/IC7YNfnBOYivJnl5Q+tJ/E8tVx5kaZcBY6M+yOvHY7
         XANcwkok173zmTAneNEfXbc7xBiLuQ7RHS/C0h+7eP0T4dsT2gh4tGgiEEhDNvXtdWL/
         gAdIdcBn+fgtrYS/aG/vvxU7DHLWY21yLYB4d1Ajq/HIpTLyI4B9e1r7xk0scXurMTkK
         MLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T2eIYO+W3QXTcdtue+CtselyEgFKQY1rp/XH4muMrNI=;
        b=iCp01D8GhHCxGt7rGTfr0e+oPtrMrdZJq74e7l2RqisUwOq5u9nQZndPVggcFFTqYB
         62zTS7EOPtcSgGKP09mSKSCGPA1u3yYJ4wNo21mzjZAvr61LEL1W5zGkkXx1iD4VutT8
         weCSrZEaaNAxQP/PHkB5nomfGiI9D5GIaFD5oSQfTRA7Uj9EBG4/T1hrFuaIwRqf6sgJ
         diPAulEzD6UA3pcLORbmhgcNdOOexSSsKTZ7uHBmmPUg8b7vEiguG24LltGFisnVXRes
         5EZi1PUrK2O9mAIF+3JCRkdxxI6yRc8bF8HiG+pyYb9+N6msl3bLCaCTNHd3NjbBDlE1
         ezHA==
X-Gm-Message-State: APzg51CvGsEE9i1JV1EClwC5ZLziYwKeSJEHm5BttWPtmkTcgVZTZwjQ
        dfYjbjT+89/dZr8h4kVU4kiFB/KeSUZZEimRkVPNDYW8GTlU+JvZkwULP2Lh/WFipY8IHtw9Ohz
        w6kpuTV9PsSzEETo7drj6dV3C2BpnbC0dw2lcbzTzCwJSyeq9xN+eY5pbEgIE
X-Google-Smtp-Source: ANB0VdbmKp9NnzIVV9GHNTIr1oRPvTXJ/zF5VBJz2hUtib+RdcCdrWvD1daQ5j3dIZwxA7IqAjZWk7xv9ktd
X-Received: by 2002:aed:24ab:: with SMTP id t40-v6mr14844245qtc.25.1537569385598;
 Fri, 21 Sep 2018 15:36:25 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:52 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 2/8] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index ed05339b588..67469a8f513 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1245,7 +1245,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1255,8 +1256,10 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule ||
+			    !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.19.0.444.g18242da7ef-goog

