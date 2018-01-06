Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA891F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeAFSqu (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38737 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeAFSqs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:48 -0500
Received: by mail-pf0-f195.google.com with SMTP id u25so3562749pfg.5
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kWF6XiGilyER5CLdMqQUJXYa2YcUgYtwn/6HrjeMTos=;
        b=haH5YImb1O4VaDoYFk9rI8OUwkHLQUOpNb4rdhogBVqCOSx/iJsuks3MZ0JwH0DN+X
         cwPIDoQfZYQoBT61ybq/Gc3bd0ZmkMnVMZJx7uLZ3bzevpYH+LMVZmNwouN1YIPxLTH8
         GRWeEjW695H9v+pSHl7HU1ZXQGvLhM4mTsA8AvdkGnzn/SqR48e6oq1JpHP3AdnZXCfQ
         zzl+6P24v24332ooOS8UCsP7F9MSE6mgSVxJQeMcGqX3yzulLPQMzom0DyEN6m17bY8V
         KHoXDv9RnLLx85H4fGzTHKYNBgugDlgYA71qdWHZAnOAtshRoSVtaBUr8ExoDqdf5Z0L
         DOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kWF6XiGilyER5CLdMqQUJXYa2YcUgYtwn/6HrjeMTos=;
        b=WUqmjTKE9ufslxN8W4ngc+JhlfQROhn0sL3hXa+OL6bUdTStK0A0a/puAOVdco5o2v
         hfgutfxAnZmBDCCMRXPZ4BRTI0xqBq33+C7OWlv82cn6vdsIW17oCyWDtm9jl+gPvH78
         9ClrxOVY3djxDmys4wdgZJF5XpN7Z3weF5S825cdM6MTZxR8iAzGgSqZaAnrP7EnKtVC
         q5lQlZaER4iwb/jhc+RXac5/7/68bNE2SahG2UV8ZtuzPc542jpApWeasTEioHZyFKmi
         KtUxcWHVh57MvEST6eCLbuQxNf9EuVG/9LLkK/wBIQ3YJft6j5+fLzZTuSsTcByumaa/
         RJlw==
X-Gm-Message-State: AKGB3mJ9J21P0BuiCvTSwYcVlSVDUj803NJrDOF+uunECn61VrwHCFzY
        8pd6aSFhf9mcWeLJn2YaTdMg/Hgz
X-Google-Smtp-Source: ACJfBou8WyJd/AliFV2Rk/ADrUgRxmiL0wzcZZRqILnOe9Pw4jNwZPMB7PtOy4jThcBnDKNEa41QKA==
X-Received: by 10.98.130.73 with SMTP id w70mr6588184pfd.204.1515264407736;
        Sat, 06 Jan 2018 10:46:47 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:46 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] Doc/gitsubmodules: use "Git directory" consistently
Date:   Sun,  7 Jan 2018 00:16:11 +0530
Message-Id: <20180106184614.20115-6-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index e3c798d2a..745a3838e 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -113,7 +113,7 @@ obtain the submodule from is configured here for example.
    of repositories.
 +
 This file mainly serves as the mapping between name and path in
-the superproject, such that the submodule's git directory can be
+the superproject, such that the submodule's Git directory can be
 located.
 +
 If the submodule has never been initialized, this is the only place
-- 
2.16.0.rc0.223.g4a4ac8367

