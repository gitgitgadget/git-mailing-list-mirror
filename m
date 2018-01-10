Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBD01FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 06:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeAJGui (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 01:50:38 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37412 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbeAJGuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 01:50:35 -0500
Received: by mail-pl0-f68.google.com with SMTP id s3so6746988plp.4
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 22:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zeMdDOl6ChD92D5eV5Zc/dWxxmDzVmAGuyXgp4Lso4c=;
        b=bsBt0AwTrjw8jzEc2nfqVBfLjttwzig6WbfeobrHVUn7/YD0576194liefmisa0wZr
         82crg8PbYO0nM0vVvhCfzIp0uMvGzD5t1GeRXq3Ai6dtZEAGt7KIRLcCNGnZahJ2apMz
         AIlYmbu1LJnfQrvJatvgDjtbC2/ETttWXE8ZzS9zJ+XxDF8yn3UY7q8bf3woDrxb2LZK
         478/zhBic8jVV2MHr5fj/Thk9xLt5TQgdNDMWLNRc5SN/odGJABtK2slnAsjWYeefp8b
         Z0gspKzzcqn1fqpONbfiD40K/2j8zwNCzTnETzR5Lpbw0bhzWgKOks07be7ih/xnZv/c
         TiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zeMdDOl6ChD92D5eV5Zc/dWxxmDzVmAGuyXgp4Lso4c=;
        b=cq9KN33f4bgRc/CcTl+RTafGZqNIjzFaqUpHFhf4cz/y5v/LiG3aMonyk8TWZzAdRw
         UQsQNy3+wOXYVgmUdK4nyH2CYAWzJnL0jo7nFYmGvs+ShUNVOyPYUf39Uwc0t4SUgtBM
         FomRbiI5U3RtddpJ8JElZ2VGZ5xQSEIekRqHS277K5ivax3Ae61khyCX7QeEj6E1ckdL
         8XkIxEItyOe9C30SUyQ/veKbRqJIU7ANboUbWrddFBEP4zf627HSCVuvT5BwKPRqA0F8
         XQ41fdM3KDnbcIIfZpYAFTxtBQya+OWYnVHkCay+LSHMfDmXKwEk5x1KXsmsPi4NL64U
         DOSg==
X-Gm-Message-State: AKGB3mL+afuiPrNGofKUfmWwEAVh1lZFKXrvBR/pcFnSLsA4sT6M1PQv
        j49ae/Ie1uO7si4120MABJ/R5BhD
X-Google-Smtp-Source: ACJfBotDzHX6n3W/mGJd/R+u158Z+ghlKvJtGwXtSWGP4c530M9Ef57s2kijO/thDEv0J4PcyRd0nQ==
X-Received: by 10.159.247.7 with SMTP id d7mr18418308pls.224.1515567034627;
        Tue, 09 Jan 2018 22:50:34 -0800 (PST)
Received: from unique-pc.sce.com ([117.209.247.76])
        by smtp.gmail.com with ESMTPSA id b69sm22407237pfk.128.2018.01.09.22.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 22:50:33 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jon Forrest <nobozo@gmail.com>
Subject: [PATCH v2 2/2] Doc/git-submodule: improve readability and grammar of a sentence
Date:   Wed, 10 Jan 2018 12:19:59 +0530
Message-Id: <20180110064959.5491-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it, correctly quote important words.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-submodule.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..801d291ca 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
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
2.16.0.rc0.223.g4a4ac8367

