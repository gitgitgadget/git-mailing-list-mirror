Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA702018A
	for <e@80x24.org>; Mon, 27 Jun 2016 17:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbcF0Rqw (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:46:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51908 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbcF0Rqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 13:46:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5RHkhZe032072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jun 2016 19:46:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5RHkbQe004426;
	Mon, 27 Jun 2016 19:46:45 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/6] doc: typeset -- as litteral
Date:	Mon, 27 Jun 2016 19:46:20 +0200
Message-Id: <20160627174623.11084-3-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 27 Jun 2016 19:46:43 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5RHkhZe032072
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467654404.43805@mlB+twf/yrTMeqH+W1H+bw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This was obtained with

  perl -pi -e "s/'--'/\`--\`/g" *.txt

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-fast-import.txt   | 4 ++--
 Documentation/git-filter-branch.txt | 2 +-
 Documentation/rev-list-options.txt  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 66910aa..c105f21 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1054,7 +1054,7 @@ relative-marks::
 no-relative-marks::
 force::
 	Act as though the corresponding command-line option with
-	a leading '--' was passed on the command line
+	a leading `--` was passed on the command line
 	(see OPTIONS, above).
 
 import-marks::
@@ -1105,7 +1105,7 @@ options the user may specify to git fast-import itself.
 
 The `<option>` part of the command may contain any of the options
 listed in the OPTIONS section that do not change import semantics,
-without the leading '--' and is treated in the same way.
+without the leading `--` and is treated in the same way.
 
 Option commands must be the first commands on the input (not counting
 feature commands), to give an option command after any non-option
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 060ebb3..0a09698 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -197,7 +197,7 @@ to other tags will be rewritten to point to the underlying commit.
 <rev-list options>...::
 	Arguments for 'git rev-list'.  All positive refs included by
 	these options are rewritten.  You may also specify options
-	such as `--all`, but you must use '--' to separate them from
+	such as `--all`, but you must use `--` to separate them from
 	the 'git filter-branch' options. Implies <<Remap_to_ancestor>>.
 
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..c5bd218 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -193,7 +193,7 @@ endif::git-rev-list[]
 
 --stdin::
 	In addition to the '<commit>' listed on the command
-	line, read them from the standard input. If a '--' separator is
+	line, read them from the standard input. If a `--` separator is
 	seen, stop reading commits and start reading paths to limit the
 	result.
 
-- 
2.8.2.397.gbe91ebf.dirty

