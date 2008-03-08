Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 10700 invoked by uid 111); 8 Mar 2008 11:50:20 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Mar 2008 06:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbYCHLuL (ORCPT <rfc822;peff@peff.net>);
	Sat, 8 Mar 2008 06:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYCHLuK
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 06:50:10 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:56124 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752702AbYCHLuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 06:50:09 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 51A4D18DABA;
	Sat,  8 Mar 2008 03:50:08 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Add --reverse to the git-rev-list usage string
Date:	Sat,  8 Mar 2008 06:50:05 -0500
Message-Id: <1204977007-7267-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.487.g5a92
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

git-rev-list accepts --reverse, as documented in
the manpage, but the usage string does not list it.
---
 builtin-rev-list.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index d0a1416..edc0bd3 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -33,6 +33,7 @@ static const char rev_list_usage[] =
 "  ordering output:\n"
 "    --topo-order\n"
 "    --date-order\n"
+"    --reverse\n"
 "  formatting output:\n"
 "    --parents\n"
 "    --objects | --objects-edge\n"
-- 
1.5.4.3.487.g5a92

