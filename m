Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84101FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933530AbcLIPw6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:52:58 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34383 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbcLIPw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:52:57 -0500
Received: by mail-lf0-f68.google.com with SMTP id x143so364712lfd.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDLYuTysmbyXyQh3RAjM8VImLB6j3pTyJlZWP0rwnEI=;
        b=T2PVWjkCTmIemf5aO2Mgha6TP33+BLpb0whiLu/1RAR0HNqa31smhOW+KPDDABKQEy
         ApJlrqG6n2VYpRgbzMoXQ4Sk1fkxsXQj93rumL5yjxcui0rH1j1a9SteUPh7k2COw68S
         CxXaA8mVgNbJmotSvaTc+kt/ja6VwBGaV49ya3T/RJX3oaFLTlZh1RquC1EEFhvlZqzx
         4ara7+emIWmQcQ1DhD51DihTzjvIZs3rMUIeAdngFmjCed1EScH1MUileR9u7Sa2eis3
         oCmpGnBZDJKw/77kGFfiwCdyJkuLm8mfeuOuzLF+/JNqZvC+2JiJF0BmxllmbITO/V5G
         rxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDLYuTysmbyXyQh3RAjM8VImLB6j3pTyJlZWP0rwnEI=;
        b=XYHb9VcbE3qoLScKLQAR0ST/RwAaDHmoaUCT9M6y8IjKk86TLdzMzHP6/WsCYRzfUj
         PHt7b3+PKE5y0RTkDkZucy1TqALz6PYL0oAv34qu83s1uniqrro6JMRT59Uc8Y6wE9be
         SBP6jEyv1Wy3PUcprxOJtxStG9A4L9GeQdDM+zm8L2EtWx78MqyvmR/r+ipnWrTkBaHF
         RN6OhifBWPTUNeMruAFPpOtdOpOSiA2sv9iu2As8dNkK6jR3I932a52anCHcSaFcQ5b3
         p15Hwaosn/LsOIRLisIKATcXaB1b5Rv8sCt3UIlVP4fYZqBCG4+EUygRz451jLqA/LhN
         oK/g==
X-Gm-Message-State: AKaTC01ooipJBRLHSIG/1LBSKMpWW6PKUEOea3WD9RhXsqHic7mU+fXPk+WA0EM2KwhDvg==
X-Received: by 10.25.201.129 with SMTP id z123mr1702557lff.6.1481298775260;
        Fri, 09 Dec 2016 07:52:55 -0800 (PST)
Received: from kristoffer-SZ68R2.privnett.uib.no (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id r204sm6646500lfr.19.2016.12.09.07.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 07:52:54 -0800 (PST)
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: [PATCH 1/4] doc: add articles (grammar)
Date:   Fri,  9 Dec 2016 16:51:09 +0100
Message-Id: <20161209155112.2112-2-kristoffer.haugsbakk@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add definite and indefinite articles in three places where they were
missing.

- Use "the" in front of a directory name
- Use "the" in front of "style of cooperation"
- Use an indefinite article in front of "CVS background"

Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
---
 Documentation/gitcore-tutorial.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 4546fa0d7..6c434aff3 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1368,7 +1368,7 @@ $ git repack
 will do it for you. If you followed the tutorial examples, you
 would have accumulated about 17 objects in `.git/objects/??/`
 directories by now. 'git repack' tells you how many objects it
-packed, and stores the packed file in `.git/objects/pack`
+packed, and stores the packed file in the `.git/objects/pack`
 directory.
 
 [NOTE]
@@ -1543,9 +1543,9 @@ like this:
 Working with Others, Shared Repository Style
 --------------------------------------------
 
-If you are coming from CVS background, the style of cooperation
+If you are coming from a CVS background, the style of cooperation
 suggested in the previous section may be new to you. You do not
-have to worry. Git supports "shared public repository" style of
+have to worry. Git supports the "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
 See linkgit:gitcvs-migration[7] for the details.
-- 
2.11.0

