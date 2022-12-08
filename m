Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B4AC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLHOsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLHOsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 09:48:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8649532FE
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 06:48:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h10so1888205wrx.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 06:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mELh/8hla644E/FQHrEWAQfJzxxIZ5gpJ9pKHzKp/dU=;
        b=WnGa024bgJa3wMEl1DLWBkFs+zo1kUl1eCuy1Nq0dEKHZ1ykojqaNnFlYkcIchepWL
         DFEtGOLsPCK4r5vFnQBoOtfPSD1EIs+MQP3bzKEQeDqE9xDcs7AoiTSBi2gm9JoFSJAx
         tZsrIIQLV1t+jf6t7yj5NUNKJLrBrzlkOauY4fUCxY/l/IGfIGYnvbj3R6lojtHw2PPO
         ztdddMPRE36r8x9QDxhcBiXdlJ/obehDFmLctUkp/qK/Zic7T6doF5i0uN6+qkEbx6gg
         sq5IpsUMtXqN0LQQ3yaxy4VQxciEdqqi9FL9WPfYxxorXmmIsvk00RaWluRZwaOq70lu
         xoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mELh/8hla644E/FQHrEWAQfJzxxIZ5gpJ9pKHzKp/dU=;
        b=c0Rjn3qtg3FZSaAOswF1N7E8rWjvxpnicRxgFwBgdpMk2NP1Vyar6cnoLtV9ICVt32
         T5pDUlMmvd3g0GPUBT0M2yDxC5VuJGyou7aVku1qfs7noI1ES0b9aGWjDzN0ryJsprYy
         puNEGkxwBjgILN3FuWD5EiO8fYhveX9SU313qtWi/Yx25+EQLUQmbbxDFFyMX007At8y
         m5lA/d2qzIUiXVzCU4TN+fSKouVwfst9jMeRvyLXE0b3R9KS+OdKk0tt/NqH24xmwP8B
         sLejzyvd9RYstfMwpBpD6ZAnCLek6r+bTQyk2UclCK9rg2S5dYgSwKIA9GJ98jFm+KBF
         mrzw==
X-Gm-Message-State: ANoB5pmhsaChMGe1bufG9koo4K1reoijQTwRCD8hlB5i0uPPmJYeB37j
        CKWrOPJ/SGNyOUhdJNgn+a2CUsojzY0=
X-Google-Smtp-Source: AA0mqf5+xlR8wvRSBIr+pJo3gQUisRWgUmy7nq9w+/AxBdC9aHAplWw6gN8jXd+8qQmAx0IOAH1BfQ==
X-Received: by 2002:a05:6000:11cf:b0:242:2e74:7930 with SMTP id i15-20020a05600011cf00b002422e747930mr1673240wrx.10.1670510888425;
        Thu, 08 Dec 2022 06:48:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6acb000000b00241c4bd6c09sm22089421wrw.33.2022.12.08.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:48:07 -0800 (PST)
Message-Id: <pull.1442.git.1670510887255.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Dec 2022 14:48:07 +0000
Subject: [PATCH] Fix a couple of typos in the v2.39.0 release notes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix a couple of typos in the v2.39.0 release notes
    
    I cheated: I used VS Code's "Code Spell Checker" ;-)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1442%2Fdscho%2Frelease-notes-typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1442/dscho/release-notes-typos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1442

 Documentation/RelNotes/2.39.0.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.39.0.txt b/Documentation/RelNotes/2.39.0.txt
index 3b8b0c010f9..1eb16534776 100644
--- a/Documentation/RelNotes/2.39.0.txt
+++ b/Documentation/RelNotes/2.39.0.txt
@@ -194,7 +194,7 @@ Fixes since v2.38
  * Force C locale while running tests around httpd to make sure we can
    find expected error messages in the log.
 
- * Fix a logic in "mailinfo -b" that miscomputed the length of a
+ * Fix a logic in "mailinfo -b" that mis-computed the length of a
    substring, which lead to an out-of-bounds access.
 
  * The codepath to sign learned to report errors when it fails to read
@@ -214,7 +214,7 @@ Fixes since v2.38
  * Clarify that "the sentence after <area>: prefix does not begin with
    a capital letter" rule applies only to the commit title.
 
- * "git branch --edit-description" on an unborh branch misleadingly
+ * "git branch --edit-description" on an unborn branch misleadingly
    said that no such branch exists, which has been corrected.
 
  * Work around older clang that warns against C99 zero initialization
@@ -264,7 +264,7 @@ Fixes since v2.38
 
  * "git diff --stat" etc. were invented back when everything was ASCII
    and strlen() was a way to measure the display width of a string;
-   adjust them to compute the display width assuming UTF-8 pathnames.
+   adjust them to compute the display width assuming UTF-8 path names.
    (merge ce8529b2bb tb/diffstat-with-utf8-strwidth later to maint).
 
  * "git branch --edit-description" can exit with status -1 which is
@@ -289,7 +289,7 @@ Fixes since v2.38
    option now implies --reapply-cherry-picks and --no-fork-point
    options.
 
- * The way "git repack" creared temporary files when it received a
+ * The way "git repack" created temporary files when it received a
    signal was prone to deadlocking, which has been corrected.
 
  * Various tests exercising the transfer.credentialsInUrl

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
