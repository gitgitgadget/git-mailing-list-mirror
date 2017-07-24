Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F343203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbdGXWat (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 18:30:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38152 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbdGXWas (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 18:30:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so1223353wrd.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MHIYy9g57ndQXd6LfjsNWO8BuMSEkjvE7cd9t5FboKA=;
        b=uwXzMamK92z4QzCzxjGzFZ545dNeK8zcflg+2XOTGZ27mqYueUSDb9phEALiARRifs
         B9Q6Uw1WA8VL9eoSVDHKNdz7p73FmyKaYUEHm9TpywdExvj/YzHpMXqZwA5WT2R1QLpd
         8Hyghr1A0I6wb0DlUAxOG0tJ7aU4aqRmSPKYzJr8wn3KVT6Nlwr2NbLIpZvpYY4fqGs6
         5mDw2o3JGMSKrAMq21DMMoryfTihg/jLzay25MjkRZOmxSd2/nPwWE5Nw6D7CLaX8TOO
         NaehHyLUlkc9sdYA5FKSqK0zuGSJmi2zb4XgD0Bbxeynx11Mf+xjup/JXaMJvqnDQnui
         L2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MHIYy9g57ndQXd6LfjsNWO8BuMSEkjvE7cd9t5FboKA=;
        b=afNMLroyf3nN39pZGFMU0VnRPFeZJ7Fco3w0mtJQ/Kku886ns6lHVS/b2k5NyPdpmQ
         VxjMYS1MiSGQIhRfAr95Ee6ItvL/pwTQz4DkFAyc4b1Hd7Yw5jI+0cSXHNXyZHKRdC8W
         D5AssOK4oKyJ2KnbrwPSppn2ML6LrXUZTxPot/z/6aeEEVGlz9Cx1S96IHikR8JsNrji
         N1hFKsZPqeC2Ya6DcGSUFXDhzQ4ZrdsDEWda/tICLd53IIbk4C9vGX7J9i8/n/I0HczA
         IxiyAx4gu4ymebvCUyKcztkRHh9pLpx+UsZXcDkZNw3TOtH6xsGPyAVp+RBbG2CevSsG
         ob8w==
X-Gm-Message-State: AIVw111apxMlUJV+cgtMktre2cLfnELSn9a2Haq2Zikj6NH4eXghIaVP
        4ixCX3zq0vO+WdxI
X-Received: by 10.223.161.195 with SMTP id v3mr8663876wrv.125.1500935445719;
        Mon, 24 Jul 2017 15:30:45 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:100f:f901:5cb8:8d85:3932:4c4f])
        by smtp.gmail.com with ESMTPSA id w11sm5734856wrc.6.2017.07.24.15.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 15:30:44 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: add missing "none" value for diff.wsErrorHighlight
Date:   Tue, 25 Jul 2017 00:30:21 +0200
Message-Id: <20170724223021.9124-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The value has not eluded documentation so far.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/diff-config.txt  | 2 +-
 Documentation/diff-options.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index cbce8ec63..c84ced8f6 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -200,7 +200,7 @@ diff.algorithm::
 +
 
 diff.wsErrorHighlight::
-	A comma separated list of `old`, `new`, `context`, that
+	A comma separated list of `old`, `new`, `context` and `none`, that
 	specifies how whitespace errors on lines are highlighted
 	with `color.diff.whitespace`.  Can be overridden by the
 	command line option `--ws-error-highlight=<kind>`
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48d..903d68eb7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -302,7 +302,7 @@ ifndef::git-format-patch[]
 --ws-error-highlight=<kind>::
 	Highlight whitespace errors on lines specified by <kind>
 	in the color specified by `color.diff.whitespace`.  <kind>
-	is a comma separated list of `old`, `new`, `context`.  When
+	is a comma separated list of `old`, `new`, `context` and `none`.  When
 	this option is not given, only whitespace errors in `new`
 	lines are highlighted.  E.g. `--ws-error-highlight=new,old`
 	highlights whitespace errors on both deleted and added lines.
-- 
2.13.3

