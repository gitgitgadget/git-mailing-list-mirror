Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 22229 invoked by uid 111); 19 Mar 2008 21:26:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 19 Mar 2008 17:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934200AbYCSV0C (ORCPT <rfc822;peff@peff.net>);
	Wed, 19 Mar 2008 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937116AbYCSVZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:25:59 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:53338 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935430AbYCSVZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:25:55 -0400
Received: from randymail-a9.g.dreamhost.com (sd-green-bigip-177.dreamhost.com [208.97.132.177])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 9228417905F
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 23:19:09 -0700 (PDT)
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 4A2DCEF35A;
	Tue, 18 Mar 2008 23:16:41 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH resend 1/2] Add --reverse to the git-rev-list usage string
Date:	Wed, 19 Mar 2008 02:16:28 -0400
Message-Id: <1205907389-15305-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.rc0.10.g0fd43
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

git-rev-list accepts --reverse, as documented in
the manpage, but the usage string does not list it.

Signed-off-by: Kevin Ballard <kevin@sb.org>
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
1.5.5.rc0.10.g0fd43

