Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 11499 invoked by uid 111); 28 Feb 2008 06:33:21 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 28 Feb 2008 01:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYB1GdT (ORCPT <rfc822;peff@peff.net>);
	Thu, 28 Feb 2008 01:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYB1GdR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 01:33:17 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:55709 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751952AbYB1GdG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 01:33:06 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id C21AD90CC4;
	Wed, 27 Feb 2008 22:33:00 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH 1/3] Add --reverse to the git-rev-list usage string
Date:	Thu, 28 Feb 2008 01:32:57 -0500
Message-Id: <1204180379-21767-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.233.g52eaf
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
I tried to send this a few days ago, but I wasn't subscribed
to the ML at that time and as near as I can tell, the patches
didn't go through.
 builtin-rev-list.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6f7d5f8..d40ecc0 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -30,6 +30,7 @@ static const char rev_list_usage[] =
 "  ordering output:\n"
 "    --topo-order\n"
 "    --date-order\n"
+"    --reverse\n"
 "  formatting output:\n"
 "    --parents\n"
 "    --objects | --objects-edge\n"
-- 
1.5.4.3.233.g52eaf

