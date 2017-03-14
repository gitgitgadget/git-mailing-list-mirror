Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D2020951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdCNWLR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:11:17 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36059 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdCNWLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:11:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id o126so76200984pfb.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwJ23sPe1HzmwPzsrFt5ZUgQUqeNweFgqUHtK5+MMNs=;
        b=Q//LANqdq4dsqGt8F6mdJ+POGRN6KFvuh6invAS+5s5XhWSoR/EpixNbikR+ZWFsLQ
         C9ecdXaKvznLksniBLtkQXyIOnexABW4ha+xQH6vOq6cnpih0FDYez/llWlTmeyB1Wao
         hcVH2pXCGQNJB/ob+5oBuhqhCLaDZ7/YKsfD9ELFlPLc5d++BZrzKM0StwhZBpEz+GNU
         zmD83BeUlneASh+reKSHG7Rs8GhQUM8gHJAtacpRw+z/UWcpqygncxfgPD+/iktoMCmo
         92MoHvp+SqGiXTeVm+5T0SRoV70WzmZoBX49z9x8SVi4XJ9e2uMpgOL/ZRCakmrRHVvd
         sOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwJ23sPe1HzmwPzsrFt5ZUgQUqeNweFgqUHtK5+MMNs=;
        b=lyacJXeOjrCIXbN9XmUMRlijfsmEr1b3xBWFBkNp5G+oFHODNOeBkS2fg7MG9/OukX
         gZAVRK7M4EmW00gNTKHnAF5oE+pnERxB62Y27PSO0jCzdvMLTwuuexz+Gb2xkugwUYwS
         m/JaqQAiCWYcUy4bkh/c8CiC7TG2Wn4SwGKzlKmCRUfOiagc4MOQ5Evu6wnTR61gvNH8
         WkLw1biJkjZn0DUsKelWxBAoclr8VpqNjFk0K7vOQ4NGOqCkfMwLaq0a53U8kACThyjv
         DC+C6sQzt4CR++U1k9wdR5WB/XKLXepHX6OpS78xy2S7TJXkXloHES/Eyo7XcXA8bCt2
         d3oQ==
X-Gm-Message-State: AMke39lgYgYJgRywLYTdmrC6XYf5Ahsgkx3/xc7u456y/59zTbDWKCnrPYAXGYEkQRUrvRZF
X-Received: by 10.84.192.107 with SMTP id b98mr59508270pld.160.1489529474444;
        Tue, 14 Mar 2017 15:11:14 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r12sm40691742pgn.26.2017.03.14.15.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:11:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v2 1/4] grep: fix help text typo
Date:   Tue, 14 Mar 2017 15:10:57 -0700
Message-Id: <20170314221100.24856-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170314221100.24856-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170314221100.24856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9304c33e7..4694e68f3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -979,7 +979,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
 			    N_("ignore files specified via '.gitignore'"), 1),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
-			 N_("recursivley search in each submodule")),
+			 N_("recursively search in each submodule")),
 		OPT_STRING(0, "parent-basename", &parent_basename,
 			   N_("basename"),
 			   N_("prepend parent project's basename to output")),
-- 
2.12.0.367.g23dc2f6d3c-goog

