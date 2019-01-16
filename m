Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC41D1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393261AbfAPNgl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37926 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393229AbfAPNg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so5429305ede.5
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yoiCJ8uETqg+M/HRT251FaAYX3Ug22kI1sfozM0TKsQ=;
        b=mVLTR/2MmONbQcfc0+l1XFR4FPec7cAf1utAOwiD7qfPwmYkjMOrUrzauLsaFBXFyz
         9a6cR2qrnfmGMUN08x4RmEnWaoGc1r7FicRJZNpwq/aXZCcGL7q5nhI1QaO9mCebfwbb
         qbu1NPd+jQjPJsJVc36N45kPGRyRAl2CR6zp23HFljmS9+KzivxRBDgXtpK5LLJvYd7N
         jvTO8gqUirGbo4KAspqsLITD+lbDIsUVN2wB0PCwVg6IAhVidk4soOfpt1V21CEp3bo2
         ytVA0I61X3gSxvxFJoKurhUzZehGdvvQjaSSnAw1m6OHvTOsKz/lVDESYnAWLBmsnEBg
         dWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yoiCJ8uETqg+M/HRT251FaAYX3Ug22kI1sfozM0TKsQ=;
        b=gOhbsVE2QYXtLh4mebwx03Z+HE7lJfKrh59jtHULS6cHW8GO8X7W4yk4EYOb7dqVsr
         2TR8KkFX/B7Q5KwgfQ4piNB1lXcdsEO3mSD6k5+njyJBUjI3QWyl55OmREW5tZWLOy7h
         sONCN0NgPJbvqCZSnYRZBGQzS9kpkL54k4o3ahOY9bzYovVgruPu2fDoFhML1TS8+MPo
         Xws92GznDaC12nKyUgvuF0mgbjdAyWkCgdw049G/Oxkhluko5Qt2VpOxHmIt+6tVOl6S
         Iav2OVx1OWfp7ZUlpnpYwgWgAr0pmrBOvNontuQ4FIaPPgUcAmlTZx6XXWyouRXVEeda
         D2IQ==
X-Gm-Message-State: AJcUukcYg4zErankcbANLVMJ64bPut4903pXBOXWDV7YF4i+BqfmeYby
        Di6nN1BuLZ1r/+Ywo/gLSi+cfeSw
X-Google-Smtp-Source: ALg8bN55z3/8jArMbrIKiAA/vtMWvXc1UATlBCF4GT8fv427YEyXB11eIcezUCeGBn8e6bgH/WqO1A==
X-Received: by 2002:a50:cd5c:: with SMTP id d28mr7189540edj.176.1547645786088;
        Wed, 16 Jan 2019 05:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2980964ejx.57.2019.01.16.05.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:25 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:25 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:04 GMT
Message-Id: <8ef674a2364a624eeb0b6f279a088d4c4bc78d44.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 16/21] mingw: try to work around issues with the test
 cleanup
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

It seems that every once in a while in the Git for Windows SDK, there
are some transient file locking issues preventing the test clean up to
delete the trash directory. Let's be gentle and try again five seconds
later, and only error out if it still fails the second time.

This change helps Windows, and does not hurt any other platform
(normally, it is highly unlikely that said deletion fails, and if it
does, normally it will fail again even 5 seconds later).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f5371f505a..531170011e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -970,7 +970,11 @@ test_done () {
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
 			cd "$TRASH_DIRECTORY/.." &&
-			rm -fr "$TRASH_DIRECTORY" ||
+			rm -fr "$TRASH_DIRECTORY" || {
+				# try again in a bit
+				sleep 5;
+				rm -fr "$TRASH_DIRECTORY"
+			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
 		test_at_end_hook_
-- 
gitgitgadget

