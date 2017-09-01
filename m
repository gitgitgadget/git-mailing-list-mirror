Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A12D1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdIAOul (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 10:50:41 -0400
Received: from ikke.info ([178.21.113.177]:36736 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdIAOul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 10:50:41 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 7B5FD440376; Fri,  1 Sep 2017 16:43:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.0.22])
        by vps892.directvps.nl (Postfix) with ESMTP id 1DAC044036F;
        Fri,  1 Sep 2017 16:43:16 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>
Subject: [PATCH] doc/for-each-ref: explicitly specify option names
Date:   Fri,  1 Sep 2017 16:49:31 +0200
Message-Id: <20170901144931.26114-1-me@ikke.info>
X-Mailer: git-send-email 2.14.1.459.g238e487ea9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For count, sort and format, only the argument names were listed under
OPTIONS, not the option names.

Add the option names to make it clear the options exist

Signed-off-by: Kevin Daudt <me@ikke.info>
---
 Documentation/git-for-each-ref.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index bb370c9c7..0c2032855 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -25,19 +25,25 @@ host language allowing their direct evaluation in that language.
 
 OPTIONS
 -------
-<count>::
+<pattern>...::
+	If one or more patterns are given, only refs are shown that
+	match against at least one pattern, either using fnmatch(3) or
+	literally, in the latter case matching completely or from the
+	beginning up to a slash.
+
+--count <count>::
 	By default the command shows all refs that match
 	`<pattern>`.  This option makes it stop after showing
 	that many refs.
 
-<key>::
+--sort <key>::
 	A field name to sort on.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
 	`refname` is used.  You may use the --sort=<key> option
 	multiple times, in which case the last key becomes the primary
 	key.
 
-<format>::
+--format <format>::
 	A string that interpolates `%(fieldname)` from a ref being shown
 	and the object it points at.  If `fieldname`
 	is prefixed with an asterisk (`*`) and the ref points
@@ -50,12 +56,6 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
-<pattern>...::
-	If one or more patterns are given, only refs are shown that
-	match against at least one pattern, either using fnmatch(3) or
-	literally, in the latter case matching completely or from the
-	beginning up to a slash.
-
 --shell::
 --perl::
 --python::
-- 
2.14.1.459.g238e487ea9

