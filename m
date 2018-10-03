Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606DB1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJDCdd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:33:33 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:38138 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJDCdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:33:31 -0400
Received: by mail-pg1-f173.google.com with SMTP id r77-v6so2025941pgr.5
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qwETXbBpa/3IfIxTJyl7x12RlJkCss0KRrjInvB0RW0=;
        b=LIPrzj2TwZGxfzwvIcvmNJV7x4c5GynlcLF8Ijln9P0qQYf4OwbNC9uu9113P6jt3q
         RlyTx3Js7fwiWvuvvTtyf6z2TclXpqa9v1ZrLJvsxeKqkHN/p72IEDZHnRd/flqe0qW3
         L1AHtHzfUnRswMAL/7+PQPT09P6LLzXvxo/xnTynWrrp4UP+pjD42lS/1kYQ7/kwISn3
         VxdPva0eqTTz2/jhfmga0/zKAVcyVqqn0+0Ky2EbObfRsfPOknbU3js1mm5iTL9spWku
         +76PGD9ptwgybcuU8mzKJCzk54WD4cmllyMIKsai5AQ776vqP423yH+q7Puw9kiUBa6f
         /D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qwETXbBpa/3IfIxTJyl7x12RlJkCss0KRrjInvB0RW0=;
        b=EHcTtUSnU7/K5AKd/VE0kgxXtAWfz0FVsL1TvaY23izh/c1OWsNUEh+pfx/hzygbs2
         rwx4o+VfbFe/ZO9nmYAUTfaOOA7X/hxlEkYdDZJL9/YfaX1xHRysY+XiEOIuYBqSADA/
         PDaHw6DMeMzFtU2PehMuCB4fCOYisN90hCy7uaRw0nS6eUsUEBBYRPesdvB4wOFF6v/j
         90aQWIfB1KfUH7JRLrtzJY6U1l9/fKxTJW0QAtDBMDKyJMI/3ZoQp63rabkID7g9kgG/
         FWL7Q0PiVyPFIrAcvjBXeBW0s0u3AgVy+N7W0zL5FLtCyHtztmqlmLk3lBx5FNiAOuJe
         aigw==
X-Gm-Message-State: ABuFfoh+GBWd5cZdGH0PT3CkJzgf0ARkA8TC/ZnvolPcYVLWDCxT66Hd
        nhqNK6zvlmmFbrU7E3KHg8DlCnJq
X-Google-Smtp-Source: ACcGV62+/fOCOilGP81FXd5VpzosWF7P5Y/ZPfwB9S/kFtiqqiWpKcRb09AXIH670WH4k+A+Vsx2kQ==
X-Received: by 2002:a63:525c:: with SMTP id s28-v6mr2689902pgl.78.1538595823777;
        Wed, 03 Oct 2018 12:43:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l10-v6sm4782297pgs.45.2018.10.03.12.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:43:43 -0700 (PDT)
Date:   Wed, 03 Oct 2018 12:43:43 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 19:43:36 GMT
Message-Id: <47966fb1f55bf3014d93b8aa2d746ef22f8b5a7c.1538595818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.44.git.gitgitgadget@gmail.com>
References: <pull.44.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] mingw: set _WIN32_WINNT explicitly for Git for Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Previously, we only ever declared a target Windows version if compiling
with Visual C.

Which meant that we were relying on the MinGW headers to guess which
Windows version we want to target...

Let's be explicit about it, in particular because we actually want to
bump the target Windows version to Vista (which we will do in the next
commit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5f2e90932f..3ba93d9c15 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -146,7 +146,7 @@
 #define _SGI_SOURCE 1
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
-# if defined (_MSC_VER) && !defined(_WIN32_WINNT)
+# if !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0502
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-- 
gitgitgadget

