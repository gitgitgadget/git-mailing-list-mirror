Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A151FA26
	for <e@80x24.org>; Mon, 17 Apr 2017 22:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757227AbdDQWdK (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:33:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35078 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755207AbdDQWdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:33:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id l44so22246760wrc.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IbE2sxWReGOEYizJZ7hifCa0eLxQTNLyUN9dV5eFf38=;
        b=m0oTwGJjo5Vv5TwRQe7JWBM38Ao4bqIGUSnUKxPzRq7xiRrtg3SfPdoJgdV0ghPEXY
         oiG4ztQOhaoLntxNAQ8tc8nDxMetROX9R+6RWXSXzEqyqWFsQT5Qf2qINDYgIwjlT/ae
         eIUYB4syLVApcO+69lmSyk3/Hfquu4ISvTow594iF00fBlNftr3W1XbydCX3BpWFDhFe
         bQyg1YaEJDYHSe1QLzismOAPt23G2oGEgEFJBx1pecwJRJqrAEZil6vic9YfUBeGIsst
         oGxuWBCDbDsSNZecXGVYccp8RJ1PinmDnKqRH/SMswZO6BLPt5CuwX8YyINS6PFcRqrQ
         9uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IbE2sxWReGOEYizJZ7hifCa0eLxQTNLyUN9dV5eFf38=;
        b=sskCdZUK6TIjszA5w8QcIlHFrnFitWENr38qEfmmm/dVUHu73cr11ehFDm09I5rKIN
         mLDjmcQwgjUu0uiUAyBp4H9bGfNWveJlUnAw1scgO9qVKTiJTrynE2wlHsS49XpAM3Gl
         8B5wNr+iveSm5utrmmLUERGMxLMUZdSS6U4vCeHkhcnVrrLpIpJ9/SRulQ/euHwbZvCT
         m9e+YP6PZrz/WgOifj/+gsBcbFs+Ufjqc9DPvxzUeBR87q69xHo0SksSIa3Wd89mSfxj
         89t2+jPqVoW60/KMRWfW7GfpBqF1oxtgp8579lPTeXN9UCs69Kny55WKY14YMZuGsdOE
         +5KQ==
X-Gm-Message-State: AN3rC/5Ct+3zrdw62ioJk370LFmH4CHaBHgT/lQRstk3Y62sqFGJ8aJv
        aKvyLip3kik8Bw==
X-Received: by 10.223.133.152 with SMTP id 24mr20699586wrt.86.1492468382328;
        Mon, 17 Apr 2017 15:33:02 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id t100sm16094093wrc.24.2017.04.17.15.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Apr 2017 15:33:01 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] doc: trivial typo in git-format-patch.txt
Date:   Tue, 18 Apr 2017 00:32:53 +0200
Message-Id: <20170417223253.2934-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.819.gfd8aacebd5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-format-patch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f7a069bb92..c890328b02 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -557,7 +557,7 @@ series A, B, C, the history would be like:
 ................................................
 
 With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
-`--cover-letter` of using `Z..C` instead of `-3 C` to specify the
+`--cover-letter` or using `Z..C` instead of `-3 C` to specify the
 range), the base tree information block is shown at the end of the
 first message the command outputs (either the first patch, or the
 cover letter), like this:
-- 
2.12.2.819.gfd8aacebd5

