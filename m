Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892B820756
	for <e@80x24.org>; Mon,  9 Jan 2017 08:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757417AbdAII4V (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 03:56:21 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33437 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdAII4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 03:56:20 -0500
Received: by mail-pf0-f193.google.com with SMTP id 127so24185937pfg.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 00:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gFn6/3o/VYGgbZ2+wUUXz17hx3kkFoJbxhyHcN/4G7E=;
        b=GjA6a5kFyG/Qc217lsdEbYklG6WGY5GplPtZDG4OxFJkXrqERKah9ht2f+A1djiNWa
         6onBAK+mKxnmrKD3bw1VfXiLdgRK/X4QO68UQSruO8EpOoZZ4SUaORfyl5BOKY0VKSso
         ko/4c2DDeF8qcQ3h87Zf4B8QP9Dp9Yo772YsXX9Zc2M/qiabqcwpmNWJvZPdEUFiglIi
         j6XlmTKYeKZOJOmJ/fSALZfvjp4AXbc3tXd7bIJL4S1hT2kf9nVTZ++F1Hlg2U4g/1Qn
         M8Q17PRTpnjLXuhIdxD23bt/Thvk+sAzwbFsVozEP/vas32yv8HCVcKlHZkJFIrLai0Y
         E2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gFn6/3o/VYGgbZ2+wUUXz17hx3kkFoJbxhyHcN/4G7E=;
        b=Oqc5qaUj1oxpy9wBideY30FsaZRz8ehymbb+61DEZM6DWmO5cqqpXdz98IIzkn3NBB
         87n61Oc4jxD/+Y908C4uYSfN6/nYG/g2954tk2A9prTy0jH4bi+AZloattNJJ3kE5TXz
         p4+9e/w4Nh0cTtjtMLprARSO3SFmUuprxPwWGuZd3eqVWnZUPZ2Ao6CWCrHm4CEhFLXi
         Q6rITq5EngXm5+gCjaIdfVV7t3PJoXkUPP1RQrrbSiN4s2E5hjuwdTq0l8WF2LxOl9PI
         tTPzDI0SBABUeahF1sttsurSq9DvqsJXLFFrjHJJYUNg+46rzbL2qZ4nyNcbl6O04p+L
         T0Gg==
X-Gm-Message-State: AIkVDXJtjcvdpknGjQ4WHXtVuZsBEuFlkW3jI1cx9ssCrXSM1T/m/JjfXgc3TmuOmwDsmw==
X-Received: by 10.84.197.1 with SMTP id m1mr193956993pld.157.1483952180055;
        Mon, 09 Jan 2017 00:56:20 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id n29sm28715172pfg.80.2017.01.09.00.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2017 00:56:19 -0800 (PST)
Date:   Mon, 9 Jan 2017 00:56:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     spearce@spearce.org
Subject: [PATCH 2/2] completion: add bash completion for 'filter-branch'
Message-ID: <20170109085617.GA527@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51832108e..b4cbea5c7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1297,6 +1297,23 @@ _git_fetch ()
 	__git_complete_remote_or_refspec
 }
 
+__git_filter_branch_options="
+	--env-filter --tree-filter --index-filter --parent-filter --msg-filter
+	--commit-filter --tag-name-filter --subdirectory-filter --prune-empty
+	--original --force
+"
+_git_filter_branch ()
+{
+	__git_has_doubledash && __git_complete_rev_list_command && return
+
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_filter_branch_options"
+		return
+		;;
+	esac
+}
+
 __git_format_patch_options="
 	--stdout --attach --no-attach --thread --thread= --no-thread
 	--numbered --start-number --numbered-files --keep-subject --signoff
-- 
2.11.0

