Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682181FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbcF1Llr (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:41:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55568 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbcF1Ll1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:41:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeHMd020108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 13:40:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeHF3019214;
	Tue, 28 Jun 2016 13:40:18 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/7] Documentation/git-mv.txt: fix whitespace indentation
Date:	Tue, 28 Jun 2016 13:40:09 +0200
Message-Id: <20160628114015.25828-2-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160628114015.25828-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160628114015.25828-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 28 Jun 2016 13:40:18 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SBeHMd020108
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467718819.24644@DjaC2mvPmwvPYDgS4EPZ7w
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Replace spaces with tabs to avoid a warning when further patches change
these lines.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-mv.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index e453132..6dcb8b2 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -32,10 +32,10 @@ OPTIONS
 --force::
 	Force renaming or moving of a file even if the target exists
 -k::
-        Skip move or rename actions which would lead to an error
+	Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
 	controlled by Git, or when it would overwrite an existing
-        file unless '-f' is given.
+	file unless '-f' is given.
 -n::
 --dry-run::
 	Do nothing; only show what would happen
-- 
2.8.2.397.gbe91ebf.dirty

