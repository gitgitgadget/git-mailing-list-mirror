Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE1F2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbcF0Rq6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:46:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51915 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbcF0Rq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 13:46:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5RHkk72032090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jun 2016 19:46:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5RHkbQg004426;
	Mon, 27 Jun 2016 19:46:48 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/6] CodingGuidelines: formatting HEAD in documentation
Date:	Mon, 27 Jun 2016 19:46:22 +0200
Message-Id: <20160627174623.11084-5-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 27 Jun 2016 19:46:46 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5RHkk72032090
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467654409.68538@U6Vqdm/BCzT26c18121ldA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The current practice is:

git/Documentation$ git grep "'HEAD'" | wc -l
24
git/Documentation$ git grep "\`HEAD\`" | wc -l
66

Let's adopt the majority as a guideline.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/CodingGuidelines | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 7f4769a..4cd95da 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -527,12 +527,13 @@ Writing Documentation:
  or commands:
 
  Literal examples (e.g. use of command-line options, command names,
- configuration and environment variables) must be typeset in monospace (i.e.
- wrapped with backticks):
+ branch names, configuration and environment variables) must be
+ typeset in monospace (i.e. wrapped with backticks):
    `--pretty=oneline`
    `git rev-list`
    `remote.pushDefault`
    `GIT_DIR`
+   `HEAD`
 
  An environment variable must be prefixed with "$" only when referring to its
  value and not when referring to the variable itself, in this case there is
-- 
2.8.2.397.gbe91ebf.dirty

