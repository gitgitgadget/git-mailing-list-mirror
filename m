Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560B920951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdCQRXU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:23:20 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35672 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQRXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:23:10 -0400
Received: by mail-pg0-f51.google.com with SMTP id b129so46208311pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48yqRtROC9LZ7wmXTDesPFUhdfPv5Q8qj7vUk4vN+kk=;
        b=tton6oDh070Xai91uMh7FFdX903KjvPXziJi31P0jrnfbaa3swyt4qqVMNQTDPaG0X
         mCfWGOB7qoCDXizH0hA9J6DzS0MP//K3u5NIC1So/JyrF+bv1ovBesIVEthwII7jKoMH
         xRNmzMc9BCOoUHTvci+r7MuPE/V7QQJq04KJ4IXcNxRpC5XprBJVVWgjCncvHHZ7eK5T
         kzGsf7IB128ow9O6b+JHznJNs8Y8V/jRnEDT3KcgfQQKAURoMLRLsMKuhVcuEVdi+N2D
         0Fo+cyxvafypQYD88cGUpiFjtypetd64ar3atPtBwL6o5Hu8s9/j5bT2W0P1aIj/0Cjg
         4X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48yqRtROC9LZ7wmXTDesPFUhdfPv5Q8qj7vUk4vN+kk=;
        b=ui/Fsq6Ginu9h+k7dAYTbiJRHZMjakwS7VS0KS3QaY4wBS8DMGBLno6wp/g40WLLDb
         RbxdxrKkAMpSLDxBkJ/6/Ivg2y1dnmcMMFV0u0J4GdFrCaGjLiFUscDSr9inwyJMbvhs
         x3Rnx76wE1YK7dbphKUjDBmsYSC7yKX2CQcmeC0FSgOcAlUFJj/7TGwT+4kSziQyr6eA
         mkfuyZbqmAT00Lp2MfvsaV3sSqGO1HQ+5p2zL8YA0h8eqD9J9ClUq5XEz+36vFHyLPXN
         c1MUhmvnomj0tbSyFnUQ9SjhHpwAGbCKkvcJRX3NePw7FVlgKO/sy5yX3hWb/PINM1If
         AgKQ==
X-Gm-Message-State: AFeK/H1dUUXqiPRafRBHyFpkJ7ItxtfQmEINLkSoSAK2/Vf2npslMV25Gbk63cJeg3l3ibSA
X-Received: by 10.99.175.7 with SMTP id w7mr17310901pge.170.1489771388353;
        Fri, 17 Mar 2017 10:23:08 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 197sm17978861pfv.19.2017.03.17.10.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 10:23:07 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v3 4/5] ls-files: fix typo in variable name
Date:   Fri, 17 Mar 2017 10:22:56 -0700
Message-Id: <20170317172257.4690-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317172257.4690-1-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1c0f057d0..ca5b48db0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -30,7 +30,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
-static struct argv_array submodules_options = ARGV_ARRAY_INIT;
+static struct argv_array submodule_options = ARGV_ARRAY_INIT;
 
 static const char *prefix;
 static const char *super_prefix;
@@ -175,17 +175,17 @@ static void show_killed_files(struct dir_struct *dir)
 static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
 {
 	if (line_terminator == '\0')
-		argv_array_push(&submodules_options, "-z");
+		argv_array_push(&submodule_options, "-z");
 	if (show_tag)
-		argv_array_push(&submodules_options, "-t");
+		argv_array_push(&submodule_options, "-t");
 	if (show_valid_bit)
-		argv_array_push(&submodules_options, "-v");
+		argv_array_push(&submodule_options, "-v");
 	if (show_cached)
-		argv_array_push(&submodules_options, "--cached");
+		argv_array_push(&submodule_options, "--cached");
 	if (show_eol)
-		argv_array_push(&submodules_options, "--eol");
+		argv_array_push(&submodule_options, "--eol");
 	if (debug_mode)
-		argv_array_push(&submodules_options, "--debug");
+		argv_array_push(&submodule_options, "--debug");
 }
 
 /**
@@ -204,7 +204,7 @@ static void show_gitlink(const struct cache_entry *ce)
 	argv_array_push(&cp.args, "--recurse-submodules");
 
 	/* add supported options */
-	argv_array_pushv(&cp.args, submodules_options.argv);
+	argv_array_pushv(&cp.args, submodule_options.argv);
 
 	/*
 	 * Pass in the original pathspec args.  The submodule will be
-- 
2.12.0.367.g23dc2f6d3c-goog

