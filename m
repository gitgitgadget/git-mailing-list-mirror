Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DDE8211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLCUWI (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:22:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34420 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCUWI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:22:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so10198193lfc.1
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjvTi0oWLX1zW9GheJ4kkjyRT1AepkXLIsr52vea31Y=;
        b=uCOcPDyRU4DAjJoZme1qi9gWUKzZoruALmJk5O+E4QoqfJIyGFm9moN/aYcwQYW7Qs
         sJjfLxRy0tRwXxoZKC6JsfEtG4iKuD3SGZMEbend3lEVwH1n24eL+rTD3hddswWp0Zr1
         KVdBmGbbVgIieApHtWvrudnLnLmDR4ptj/7s3eukxRqM8AuAbWZamopCj8mkvF0tlz9e
         c4wJiQtZ+Qgr0qJJEeRhYVGYA/vWhu9PN832+h2ATICL+RryyXFhEK1NBKBWQ6ON5fu7
         9ykemNJkS47VFgGrNoc+tchNBLYsefX+uOQ6YnyeAldYJ/ADxVkpZrboPXeXhAIJhN9+
         VR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjvTi0oWLX1zW9GheJ4kkjyRT1AepkXLIsr52vea31Y=;
        b=dim7hplYYTdpnDXWy0C29jfBV2OENC2lvLzrP3xiAErT6eZohe1O5YpZIQiIfs3x4H
         X6f4P5G+bKczuBTfjYi84S0m2V2fDUEf+D5aR3xtoQmFzPocBmGHV1wcRu2IxzkiFt97
         iZT8K2airGAPYTvycwFtCVzbppzlbbRP6mCTCepcFj7myTUD/W+yQYc4LNBruwMYxGSU
         bgKtOvkTS/dtiubRi5AkLb2Ks4P7WWICRCVrmwapPu8PzBNkVkyw3y4y0HSYdRMXHmew
         lUJgKIBYTZme1LHQcWnxcT+DKpy50pZoM4CDdazflIFgoIM5tLba21UkTYkZZH5CqtCa
         ewsw==
X-Gm-Message-State: AA+aEWYeaE9Oi6+yytrpM/LYrj6tyYsyG075Bdvuzf2MFsd+T29133Y/
        WF1qldvRTDt5DReGmcGYooLPerUn
X-Google-Smtp-Source: AFSGD/XIZtfunIkuwJ/+vO/fD7/0APojQmBeyXYE3uEjplrJ7JOl6E81dOhvFoCRC7sVHHpjalEGJw==
X-Received: by 2002:a19:c413:: with SMTP id u19mr9865962lff.100.1543868525634;
        Mon, 03 Dec 2018 12:22:05 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2705104ljh.66.2018.12.03.12.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:22:04 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/3] RelNotes 2.20: move some items between sections
Date:   Mon,  3 Dec 2018 21:21:49 +0100
Message-Id: <d69f63b5f6d2405f455664c936f329e7971ef1cc.1543868120.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gfcc5f94f1e
In-Reply-To: <cover.1543868120.git.martin.agren@gmail.com>
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com> <cover.1543868120.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some items that should be in "Performance, Internal Implementation,
Development Support etc." have ended up in "UI, Workflows & Features"
and "Fixes since v2.19". Move them, and do s/uses/use/ while at it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/RelNotes/2.20.0.txt | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index b1deaf37da..e5ab8cc609 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -137,11 +137,6 @@ UI, Workflows & Features
    command line, or setting sendemail.suppresscc configuration
    variable to "misc-by", can be used to disable this behaviour.
 
- * Developer builds now uses -Wunused-function compilation option.
-
- * One of our CI tests to run with "unusual/experimental/random"
-   settings now also uses commit-graph and midx.
-
  * "git mergetool" learned to take the "--[no-]gui" option, just like
    "git difftool" does.
 
@@ -185,6 +180,11 @@ UI, Workflows & Features
 
 Performance, Internal Implementation, Development Support etc.
 
+ * Developer builds now use -Wunused-function compilation option.
+
+ * One of our CI tests to run with "unusual/experimental/random"
+   settings now also uses commit-graph and midx.
+
  * When there are too many packfiles in a repository (which is not
    recommended), looking up an object in these would require
    consulting many pack .idx files; a new mechanism to have a single
@@ -387,6 +387,14 @@ Performance, Internal Implementation, Development Support etc.
    two classes to ease code migration process has been proposed and
    its support has been added to the Makefile.
 
+ * The "container" mode of TravisCI is going away.  Our .travis.yml
+   file is getting prepared for the transition.
+   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).
+
+ * Our test scripts can now take the '-V' option as a synonym for the
+   '--verbose-log' option.
+   (merge a5f52c6dab sg/test-verbose-log later to maint).
+
 
 Fixes since v2.19
 -----------------
@@ -544,14 +552,6 @@ Fixes since v2.19
    didn't make much sense.  This has been corrected.
    (merge 669b1d2aae md/exclude-promisor-objects-fix later to maint).
 
- * The "container" mode of TravisCI is going away.  Our .travis.yml
-   file is getting prepared for the transition.
-   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).
-
- * Our test scripts can now take the '-V' option as a synonym for the
-   '--verbose-log' option.
-   (merge a5f52c6dab sg/test-verbose-log later to maint).
-
  * A regression in Git 2.12 era made "git fsck" fall into an infinite
    loop while processing truncated loose objects.
    (merge 18ad13e5b2 jk/detect-truncated-zlib-input later to maint).
-- 
2.20.0.rc2.1.gfcc5f94f1e

