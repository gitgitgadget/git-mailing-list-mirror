Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEF161F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDJSj7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:39:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51639 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeDJSjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:39:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id u189so28065108wmd.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEtQxrjzcbbqXkoPyTuYzlqTb5V1MzjsSA0h38Qy2Os=;
        b=MucL4shHd/B4kXDwxZdXb0dHj1AFQZZi+bo3qckreHvtBKxSdIrFhelJIeyQb9Zk8y
         mlBrCwlPsN1fHL4udMIIcdeRDEcVs4Oucup7T/iNJyvzPhryxeKKk08J+g5E1F9fz07+
         mq3Y24hM8fhnbghWQ4/WAIP9QTOaSbEI0W8A/HmL+y7Hk44rhOok+CwmEI8Dobi+RwW2
         bf6mcOuxrl26ykHRBgOgMkq2IqtP0DswX7699rkAoUFIjYUq2/8AStq/0pICp7CebT9D
         CNM5ojOeINRapZ5Vh1dRwxcImDfXG0feVrp5vs8ueYRYMvE8aQDuOZ4OzRDmLbFomgr7
         B1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEtQxrjzcbbqXkoPyTuYzlqTb5V1MzjsSA0h38Qy2Os=;
        b=ojsD2DHU8c8/3AEEYrY2g/gG5IOWSM4UCvZfmdp+qsurWOyRf6Zph5iNsrr/FxN6yL
         enAMM7WAoF28Pn1dx2keBy7WcDfSoPh9Aipm5jDnQzpjTp9guYaj8x+YDJQ2siFy1luF
         7YoWX33PotBLLswMiG2ek+8TP4kyOV6+XJN4czIUf51WKLV64Jv1jaMCZBYhd2fH8xRb
         eIGGIf1aVQ2pUZmwunpuMCKtpmkydhyPB4uha4VZeBSbv9bsXOUhKby/ky0n1Qu12aD/
         LedRzHQ1qetjBijkXKpy57CzfSxn2MU/XWOUKOzRShKbkQw88wnCNfzYC3HoYYXE0x9m
         CqlA==
X-Gm-Message-State: ALQs6tDV/Y38XBTbgtKEFKW+D95Tc3QogBu+hvsCxKgPd75mzsdMMEOE
        3+wbbJlqOp52ckk4HjiETDLBLA==
X-Google-Smtp-Source: AIpwx49O5DgwskCKXN88N1UYRe+f+ameAgNHYw8Xpn6+3RZee4jPA+mxLhzlH6seQP4q14bBfsISbA==
X-Received: by 10.28.98.69 with SMTP id w66mr474403wmb.64.1523385587280;
        Tue, 10 Apr 2018 11:39:47 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id h197sm3242710wmd.3.2018.04.10.11.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:39:46 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 6/6] doc: add note about shell quoting to revision.txt
Date:   Tue, 10 Apr 2018 20:39:39 +0200
Message-Id: <20180410183939.12146-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/revisions.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dfcc49c72c..c1d3a40a90 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -7,6 +7,10 @@ syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list name trees and
 blobs contained in a commit.
 
+NOTE: This document shows the "raw" syntax as seen by git. The shell
+and other UIs might require additional quoting to protect special
+characters and to avoid word splitting.
+
 '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
   The full SHA-1 object name (40-byte hexadecimal string), or
   a leading substring that is unique within the repository.
@@ -186,6 +190,8 @@ existing tag object.
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
   literal '!' character, followed by 'foo'. Any other sequence beginning with
   ':/!' is reserved for now.
+  Depending on the given text the shell's word splitting rules might
+  require additional quoting.
 
 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
-- 
2.16.2

