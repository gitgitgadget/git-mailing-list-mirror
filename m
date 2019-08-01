Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42431F731
	for <e@80x24.org>; Thu,  1 Aug 2019 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfHAOMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 10:12:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45362 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbfHAOMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 10:12:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so69478633lje.12
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbIiirymogEcCEQXH4KKdV2U+1M2TyjSBM27DOyLmIM=;
        b=B1MFUqGfzEKqfTehVZBCSJtvRbsSTYf2qzKC+Na4cokUAW7V9SQ3PgqwoiP5fpVtlu
         igyybH5klzitPeobn0LIxPAoEwThHHBCdD4pw3cEKSBYgjOxZyZNkoi0pQpbFRhG+COc
         46jqomQtiixh8Wzv0nCEP1s11gzF0S9wdKiNYu9glFqpyrZAvVgqprxBcHEzz61+9BeK
         DBlKtaStUifT6x59cTj2p5JvpEfj9PPdAgewc6zet1EDFf7mOzyAXW68HFIXW9EA0dV/
         yekf6imSj7n6Zc0OCmrAuBQ5Ar9optyYNchh016g6V98kSXe9bhahPAfAV2hcqa6a0nS
         xGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbIiirymogEcCEQXH4KKdV2U+1M2TyjSBM27DOyLmIM=;
        b=m7ctZOc0JWdFG9PjeniTLYopfIM6QmMT3IkAzEhxriOFBztkbl56ZWR04NHjkwqC7F
         tmBt/qMldr5XavzHC43PISXNebVH/KkQdINTPEAOFfBtBFLxpF0woWz4sOrP/oe1JmJU
         VWYOsWgN6FQ2yPFMdBbWstkyc48lKuvcaVPMlP5UpgM1mKIVIYx3Dmp647cSQVBWcnKI
         RFuD5lgyuYwnnK0djcpIahgeBqz9bFVMhm783OE/MoEXTlhq0xxDvZruym1F7fa+xey+
         agUQpqFWotiiyswpYOg4478XVKGudSYPTkF/zUHX+rI5cqdWCJJNrpftocdn/cnIDnWm
         6gsw==
X-Gm-Message-State: APjAAAXLKqxTUPySH2hLV8tzJ2k1XiJilIeptzy4lfUMIXaKEX9OxeWY
        oRkbtL1Q5riCeFc3XYRh/e7vuYX9
X-Google-Smtp-Source: APXvYqzs/HJaOoeHMQMdU/wKFQgG0yuglRx+P8zKbOrI/1yCJfSqdrFaCA+iOkbyFgC0KghFyW7y7w==
X-Received: by 2002:a2e:9f57:: with SMTP id v23mr8423922ljk.138.1564668769827;
        Thu, 01 Aug 2019 07:12:49 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k4sm14700520ljj.41.2019.08.01.07.12.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:12:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] RelNotes/2.23.0: fix a few typos and other minor issues
Date:   Thu,  1 Aug 2019 16:12:20 +0200
Message-Id: <20190801141221.3626-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0
In-Reply-To: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the spelling of the new "--no-show-forced-updates" option that "git
fetch/pull" learned. Similarly, spell "--function-context" correctly and
fix a few typos, grammos and minor mistakes.

One of these is also in 2.22.1.txt, so fix it there too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/RelNotes/2.22.1.txt |  2 +-
 Documentation/RelNotes/2.23.0.txt | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RelNotes/2.22.1.txt b/Documentation/RelNotes/2.22.1.txt
index 78b2c5ea8a..76dd8fb578 100644
--- a/Documentation/RelNotes/2.22.1.txt
+++ b/Documentation/RelNotes/2.22.1.txt
@@ -94,7 +94,7 @@ Fixes since v2.22
 
  * The configuration variable rebase.rescheduleFailedExec should be
    effective only while running an interactive rebase and should not
-   affect anything when running an non-interactive one, which was not
+   affect anything when running a non-interactive one, which was not
    the case.  This has been corrected.
 
  * "git submodule foreach" did not protect command line options passed
diff --git a/Documentation/RelNotes/2.23.0.txt b/Documentation/RelNotes/2.23.0.txt
index 19e894a44e..e1b1ce5680 100644
--- a/Documentation/RelNotes/2.23.0.txt
+++ b/Documentation/RelNotes/2.23.0.txt
@@ -52,7 +52,7 @@ UI, Workflows & Features
 
  * "git fetch" and "git pull" reports when a fetch results in
    non-fast-forward updates to let the user notice unusual situation.
-   The commands learned "--no-shown-forced-updates" option to disable
+   The commands learned "--no-show-forced-updates" option to disable
    this safety feature.
 
  * Two new commands "git switch" and "git restore" are introduced to
@@ -68,7 +68,7 @@ UI, Workflows & Features
  * The conditional inclusion mechanism learned to base the choice on
    the branch the HEAD currently is on.
 
- * "git rev-list --objects" learned with "--no-object-names" option to
+ * "git rev-list --objects" learned the "--no-object-names" option to
    squelch the path to the object that is used as a grouping hint for
    pack-objects.
 
@@ -106,7 +106,7 @@ Performance, Internal Implementation, Development Support etc.
    no longer be used.
 
  * Developer support to emulate unsatisfied prerequisites in tests to
-   ensure that the remainer of the tests still succeeds when tests
+   ensure that the remainder of the tests still succeeds when tests
    with prerequisites are skipped.
 
  * "git update-server-info" learned not to rewrite the file with the
@@ -121,7 +121,7 @@ Performance, Internal Implementation, Development Support etc.
  * Prepare use of reachability index in topological walker that works
    on a range (A..B).
 
- * A new tutorial targetting specifically aspiring git-core
+ * A new tutorial targeting specifically aspiring git-core
    developers has been added.
 
  * Auto-detect how to tell HP-UX aCC where to use dynamically linked
@@ -181,7 +181,7 @@ Fixes since v2.22
    the same repository was corrupt, which has been corrected.
 
  * The ownership rule for the file descriptor to fast-import remote
-   backend was mixed up, leading to unrelated file descriptor getting
+   backend was mixed up, leading to an unrelated file descriptor getting
    closed, which has been fixed.
 
  * A "merge -c" instruction during "git rebase --rebase-merges" should
@@ -306,7 +306,7 @@ Fixes since v2.22
 
  * The configuration variable rebase.rescheduleFailedExec should be
    effective only while running an interactive rebase and should not
-   affect anything when running an non-interactive one, which was not
+   affect anything when running a non-interactive one, which was not
    the case.  This has been corrected.
 
  * The "git clone" documentation refers to command line options in its
@@ -339,7 +339,7 @@ Fixes since v2.22
    having to consult the other end, which has been corrected.
 
  * The internal diff machinery can be made to read out of bounds while
-   looking for --funcion-context line in a corner case, which has been
+   looking for --function-context line in a corner case, which has been
    corrected.
    (merge b777f3fd61 jk/xdiff-clamp-funcname-context-index later to maint).
 
-- 
2.23.0.rc0

