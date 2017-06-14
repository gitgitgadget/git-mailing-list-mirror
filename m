Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC3C20401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdFNJo6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:44:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33501 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdFNJm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:42:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so37635625wrb.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VysmB7L0FrRV9r9if3InqAhjoUU+YDWl02hk5HzsqLg=;
        b=M9C6jqh7n0nxIG3+tC1WJe5ReJxyHYkxhiYN4MoeTKzjiO1xsoSEV/fd+PQ6ZQsmjS
         XAYwrSS9BZjy6KnAMmXGzv5aNtiYvH4bsPPS7pcnUUCRP3D5oAqFdsysa/00oMS3p/wN
         +CbDnMVh1Jy+3x6GRz9qFZ7e6SJ6kuu6kEEWGAKmbB3Pl0Bu/xUMtWw0477mjmy2jvFo
         VjtqNW30sTqfWvLjqoSXYvPWwKRFl19ddYr0KThAh1Xl8Y/vQ27XFKWl8W7W/agsLC8U
         +qPE6oBRwMfXxhYKgVY8WbyVVbnb9/pSiLBshVQe+kGjXDQJFQiiyjfkblDP8fShgxmX
         ntdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VysmB7L0FrRV9r9if3InqAhjoUU+YDWl02hk5HzsqLg=;
        b=mkKewgCawy4hFdq054k3uXX7QT1d9xSMVEfool3uyyayrkOd6O3iLkRitK+RM3uInd
         cBFrdzCSX8M43jDK18X/6k6TAg4mWA6uz91RjfaAiQcoIRHAav29R4MHUf0saFLLR/S9
         L1QtpqVQXNmF7EJqAgQl6hptyY5jiEHYG5cXr5wa8fomdg58w2p/pXWwmuTJt9gJXQ5A
         pNkZ2SDqQMTN+tCntdrExRRBwNxLiyj0TZ1vIeXieBisqfvtGrN4ju7pLirvPfxn70fC
         gM210dHAdqa/KFJeafNShvfWZKK4v9YXFUZMKR31G5hg0q5vS7MKwB9L4Du+ipdnFueZ
         mSjA==
X-Gm-Message-State: AKS2vOytDfSw6nP3hgIHXnImxURBHnS52PXDlR98eYwdDb3DHoHV3iXP
        exG4hR2dU3h0H3wJ
X-Received: by 10.28.156.197 with SMTP id f188mr368235wme.76.1497433376046;
        Wed, 14 Jun 2017 02:42:56 -0700 (PDT)
Received: from localhost ([185.112.167.114])
        by smtp.gmail.com with ESMTPSA id x126sm772541wme.12.2017.06.14.02.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2017 02:42:55 -0700 (PDT)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com
Subject: [PATCH] doc: git-reset: clarify the --keep usage example
Date:   Wed, 14 Jun 2017 11:35:55 +0200
Message-Id: <1497432955-28525-1-git-send-email-stepnem@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The example doesn't work as provided (you get an error) when the 'edit'
and 'commit' steps affect the same files.
Add a note and reference the DISCUSSION to that effect.

Signed-off-by: Štěpán Němec <stepnem@gmail.com>
---
 Documentation/git-reset.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 70f3753..727ba46 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -290,7 +290,8 @@ $ git reset --keep start                    <3>
     to branch2 (i.e. "git checkout -b branch2 start"), but nobody is
     perfect.
 <3> But you can use "reset --keep" to remove the unwanted commit after
-    you switched to "branch2".
+    you switched to "branch2" (as long as the commit doesn't conflict with your
+    working tree changes, see the "DISCUSSION" below for more details).
 
 Split a commit apart into a sequence of commits::
 +
-- 
2.1.4

