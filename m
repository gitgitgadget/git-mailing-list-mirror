Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDEA420D17
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbdFTTUP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:15 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36528 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:14 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so73607205pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PSvWHaD7RNWo8vRPjwYzD3TGxs8ewBNTu18E8pEjPYo=;
        b=e7/R10Y7i6O/FMKA1zLxjeNMlpHqZ7kZs1u0ZJB2SvyENjlwLhMJToY2idxQ3y9x2R
         IG0QvLm1Cjrni+A8mmUBQcn8MovDwCv0rbpEimaTrO9GP5QMGdb0GkbZPygb3rYG6JRZ
         lYoz59/y8K3UfKStrvC7XVXGMKWXo00P+6pseM/GZIClkscGE1Aye5c2G1UisQs7vAJJ
         R19Qw9O9Kowf/9rDkMuWxrRDLk3Zpxo2SRAMf0m+9wIVlGYVQ3ovmg5mjYY5LVtL1/Wu
         mGjZNTqo8qDKXAa7MdaQ/Eyz8+dKAs2pZRdBRg2EV2lto7yrEEalFDxrtl4bkoUS4cE1
         pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PSvWHaD7RNWo8vRPjwYzD3TGxs8ewBNTu18E8pEjPYo=;
        b=jnrt1QLANFZqo98MZTArNZ6Smrp5iXcEAY94j1ReEwhLjJt8lbgqlt6IerFZsJ6W50
         aXsd7OJR85Ui2un+7tKWj0tBF2nc253ALP/JsV7WAl1c1gU3sVni+YxSoLVX9hohSCP2
         1YuNpumclaeLQkdt/FapcHbUZJVTWLW5Jc4tXVWlIHtO2exNILRHBZnoufmq03fSRTkZ
         2VAz9jeaZw1fjMZFxn01iIqj7JYGfJjbB3VF/qBLGDWeTU8k9dFG5JT2DAMUJaYx19gw
         aHxMHlLF8NGoUG6sXWxE4IKcopccRl8hbQkFpEpWPoy0dNa5Jra0V+O+v1UAX8+L5Ha9
         saIQ==
X-Gm-Message-State: AKS2vOx2cWRwLJoaOdHlQrKlDyLZS7TEA1N8Bsoz26tk9HqrAi8oHC9i
        6TncN94eWWKR5r+WzWY/Uw==
X-Received: by 10.101.88.130 with SMTP id d2mr33537112pgu.58.1497986413051;
        Tue, 20 Jun 2017 12:20:13 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 02/20] setup: add comment indicating a hack
Date:   Tue, 20 Jun 2017 12:19:33 -0700
Message-Id: <20170620191951.84791-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'GIT_TOPLEVEL_PREFIX_ENVIRONMENT' was added in (b58a68c1c setup: allow
for prefix to be passed to git commands) to aid in fixing a bug where
'ls-files' and 'grep' were not able to properly recurse when called from
within a subdirectory.  Add a 'NEEDSWORK' comment indicating that this
envvar should be removed once 'ls-files' and 'grep' can recurse
in-process.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/setup.c b/setup.c
index 24a738b0d..b477faa44 100644
--- a/setup.c
+++ b/setup.c
@@ -1079,6 +1079,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("BUG: unhandled setup_git_directory_1() result");
 	}
 
+	/*
+	 * NEEDSWORK: This was a hack in order to get ls-files and grep to have
+	 * properly formated output when recursing submodules.  Once ls-files
+	 * and grep have been changed to perform this recursing in-process this
+	 * needs to be removed.
+	 */
 	env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
 	if (env_prefix)
 		prefix = env_prefix;
-- 
2.13.1.611.g7e3b11ae1-goog

