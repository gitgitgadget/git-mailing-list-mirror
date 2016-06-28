Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445AB1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbcF1Llp (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:41:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55576 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbcF1Ll1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:41:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeOht020153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 13:40:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeHF7019214;
	Tue, 28 Jun 2016 13:40:25 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 5/7] doc: typeset long options with argument as literal
Date:	Tue, 28 Jun 2016 13:40:13 +0200
Message-Id: <20160628114015.25828-6-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160628114015.25828-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160628114015.25828-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 28 Jun 2016 13:40:24 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SBeOht020153
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467718824.42185@X6lxrwBtBvOCd+VKgCwklg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We previously reformatted '--option' to `--option`. This patch reformats
'--option <arg>' to `--option <arg>`. Obtained with:

  perl -pi -e "s/'(--[a-z][a-z=<>-]* <[^>]*>)'/\`\$1\`/g" *.txt

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 79905fb..f163113 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -47,12 +47,12 @@ checks or transformations are performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-`--system`, `--global`, `--local` and '--file <filename>' can be
+`--system`, `--global`, `--local` and `--file <filename>` can be
 used to tell the command to read from only that location (see <<FILES>>).
 
 When writing, the new value is written to the repository local
 configuration file by default, and options `--system`, `--global`,
-'--file <filename>' can be used to tell the command to write to
+`--file <filename>` can be used to tell the command to write to
 that location (you can say `--local` but that is the default).
 
 This command will fail with non-zero status upon error.  Some exit
-- 
2.8.2.397.gbe91ebf.dirty

