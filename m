Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE811FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 17:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeANRiX (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 12:38:23 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39512 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeANRiV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 12:38:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id e11so7034761pff.6
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+CWbioIu7GJGGP4dWBSO/l3R+0tzaOv6kt82COnZVE=;
        b=loJjuwmeRrXRd2QyWfYRsLfRNqGvdwqiSgcb/zvJ/+4pUiQOFeuPbJMiODScXuklyw
         dh5axWSOe/EDBGe97zpz4t5Yhk6e7lxN4AcwMygEop0QQfaBY/p+QIODKuoRi1S80jiO
         EgGgmcU8y6pReO2tVtlE6GqCURjmGDYiJjk+xn9Qn3pflt8/VDv9NzxJgXm4JLax8sLI
         tl7I/aNFbqldRKNV6A6lyjn+FAeW/kBLgIpvd8IRoFi0syZ6bdeS2a4a8umuX0VJY6ia
         7esPCqSwetjIKZ6/N7mj/nGQIk/UjloF8W27YvditycGiN99OyuOcBjXveHOnePr5pJ7
         tN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+CWbioIu7GJGGP4dWBSO/l3R+0tzaOv6kt82COnZVE=;
        b=kZJV3uUBZ0z5JWKMy9kOL4ZTtqXgPnf+m198kXQ5FLutC/ltKRKobDRg4b9h9SZnmA
         2FwIiRniSLshEHUKFSHAeT64i4OPbLaUtC0NjZVNRTxXupVwx1O8kbGxqDPm46fmikO/
         0JF2pfaWehWVIspilNPFLsXGxJNC2AGjr25lWkP2Pq5VSZFoZeC1mh15hMUIQmRZxIHO
         PbG522a1BtxgEOB1ZHqr4SQV2orQXwjnCHklywrsptd8ty2BQwXVuTDPxtweRqFXWcJ2
         zVs7/6z24iLNifwYJSPQlnw+DQKGc/RIqBYCPubV1zgQOpikwj9ZG8cDQl97o95Xr9Y7
         FjxQ==
X-Gm-Message-State: AKwxytdDj6TVwzAg6+gKvGr9W30PDiTBoHY50E9/U6SzVl1W9dmo4pjW
        R0C40CXbenvSxk92ILKqrUgyUX7+
X-Google-Smtp-Source: ACJfBovMTfTxWh7EAGkOswIu2j9wzredb/yKPmVvtJNnaMux4T7rmBkahy/ZSrNS+9scQJVZGnibYQ==
X-Received: by 10.98.103.209 with SMTP id t78mr17507489pfj.53.1515951500385;
        Sun, 14 Jan 2018 09:38:20 -0800 (PST)
Received: from localhost.localdomain ([117.246.211.130])
        by smtp.gmail.com with ESMTPSA id k90sm20252054pfk.171.2018.01.14.09.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2018 09:38:18 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jon Forrest <nobozo@gmail.com>
Subject: [PATCH v3 2/2] Doc/git-submodule: improve readability and grammar of a sentence
Date:   Sun, 14 Jan 2018 23:07:37 +0530
Message-Id: <20180114173737.13012-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.281.g969645f98
In-Reply-To: <20180114173737.13012-1-kaartic.sivaraam@gmail.com>
References: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
 <20180114173737.13012-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it, correctly quote important words.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-submodule.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..71c5618e8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -70,8 +70,8 @@ status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of 'git describe' for the
-	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
-	initialized, `+` if the currently checked out submodule commit
+	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
+	not initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
 	repository and `U` if the submodule has merge conflicts.
 +
@@ -132,15 +132,15 @@ expects by cloning missing submodules and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
-the configuration variable. if neither is given, a checkout is performed.
-update procedures supported both from the command line as well as setting
-`submodule.<name>.update`:
+the configuration variable. If neither is given, a 'checkout' is performed.
+The 'update' procedures supported both from the command line as well as
+through the `submodule.<name>.update` configuration are:
 
 	checkout;; the commit recorded in the superproject will be
 	    checked out in the submodule on a detached HEAD.
 +
 If `--force` is specified, the submodule will be checked out (using
-`git checkout --force` if appropriate), even if the commit specified
+`git checkout --force`), even if the commit specified
 in the index of the containing repository already matches the commit
 checked out in the submodule.
 
@@ -150,8 +150,8 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following procedures are only available via the `submodule.<name>.update`
-configuration variable:
+The following 'update' procedures are only available via the
+`submodule.<name>.update` configuration variable:
 
 	custom command;; arbitrary shell command that takes a single
 	    argument (the sha1 of the commit recorded in the
-- 
2.16.0.rc1.281.g969645f98

