Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C851F744
	for <e@80x24.org>; Tue, 19 Jul 2016 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbcGSKJ3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 06:09:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57042 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbcGSKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 06:09:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC2F1F744;
	Tue, 19 Jul 2016 10:09:27 +0000 (UTC)
Date:	Tue, 19 Jul 2016 10:09:27 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] git-svn: document svn.authorsProg in config
Message-ID: <20160719100927.GA19702@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This has always been supported since we read config variables
based on the command-line option parser.  Document it explicitly
since users usually want to maintain the same program across
invocations.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Pushed to master of bogomips.org/git-svn.git, but I might
 have more small git-svn changes coming in over the week as
 I work on them..

 Documentation/git-svn.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 7e17cad..5f9e65b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -625,6 +625,9 @@ config key: svn.authorsfile
 	with the committer name as the first argument.  The program is
 	expected to return a single line of the form "Name <email>",
 	which will be treated as if included in the authors file.
++
+[verse]
+config key: svn.authorsProg
 
 -q::
 --quiet::
-- 
EW
