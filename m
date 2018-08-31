Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43201F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeHaU60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34145 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeHaU60 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so5791301pfi.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pp7noHcnac+lCImKCiMj43QiP+nXEUxdy95IIVpWqT4=;
        b=Vf/RdkBv8oSbrTNiY02mTCQJvyDbhHPFLqOyLWcW7CoJXqRBqYRRLHuChZRzRSpqr3
         YFUsIzl8MGp/bOc2LluBlmJvj2gzRo9ztXdcZKZp6sjxW94V4eb9jlmSgyspK7Mc0+DT
         zED+Uut3RwQTwu6oq2EGTHabTjwJVmJNWS0hqJ0SDkPXtcgm/9na5L0RCrTDXpmxp0Lc
         +O4pYjoOve8MxIJ8LJb0wJ7jD8gdgBaGTMMrcUEWLnJPSrwqLostHPCrIEzuEeIdbmPn
         vJzCBrs/RH1mTuV5svCEh2T2DbXzcQ+BhJ1Jf6Tq+nO8O6+wGCa3X4v99ICkk5E5E8/H
         x0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pp7noHcnac+lCImKCiMj43QiP+nXEUxdy95IIVpWqT4=;
        b=f668VhXuwpe76kKbCPQl0u85Krc2RVkT13UP29iMAG1DiqZ2DkwLo2h3hkqG5HOPFD
         izBoPAk7Vj2KaSXDej7tXoe2TcIkbLgvER54apU6tF0M8lZebAkVf18vspc1RxfDdLxX
         3EiNXQq0cI3emiP3CkbVRKVb7I2nLepTy7QvjtE+MymvuZB29Yi/+VVB37ivip4TRg3A
         u6XQuMxyvqKPIVkma4HfOMaWjs3cylRaQp1uVCkqRBsVGXPS+FTbje6kmezkHl9R153i
         /mxSz/4fX8t8TSF0CXQAvd1XsQ0n9mcWxeqO3wfw7DFEuboxc0/k5zJ6b2rGMSRLHRdZ
         tKsQ==
X-Gm-Message-State: APzg51Co9+zPFaAKCDNP7b0CfnlaGRrgta3zI6P/t63NOfDlp0oFWBNj
        ZRmeCDgdGlc8TbCIxcoImw5N+879
X-Google-Smtp-Source: ANB0Vdb/crDVcoZWsKRF7+3RiclfWVhT1im/O/qdpCndiYW3sMeMabY8r7vEKHsXJjEMLedsbLZXGA==
X-Received: by 2002:aa7:83cd:: with SMTP id j13-v6mr16713432pfn.236.1535734204306;
        Fri, 31 Aug 2018 09:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id b64-v6sm14744936pfg.66.2018.08.31.09.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:50:03 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:50:03 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:50 GMT
Message-Id: <e3bde216b86fcb13da006937c8472823df9aa636.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/8] trace2: demonstrate setting sub-command parameter in
 checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2_param() events in checkout to report whether the command
is switching branches or just checking out a file.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/checkout.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29ef50013d..0934587781 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -251,6 +251,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
 
+	trace2_param("subcommand", (opts->patch_mode ? "patch" : "path"));
+
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
 
@@ -828,6 +830,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+
+	trace2_param("subcommand", "switch");
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
-- 
gitgitgadget

