Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 22210 invoked by uid 111); 19 Mar 2008 21:26:15 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 19 Mar 2008 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbYCSV0A (ORCPT <rfc822;peff@peff.net>);
	Wed, 19 Mar 2008 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937114AbYCSVZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:25:58 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:59184 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936018AbYCSVZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:25:55 -0400
Received: from randymail-a9.g.dreamhost.com (sd-green-bigip-81.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 8109317920B
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 23:19:19 -0700 (PDT)
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id 041C8EF365;
	Tue, 18 Mar 2008 23:16:41 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH resend 2/2] Document the sendemail.smtpserverport config variable
Date:	Wed, 19 Mar 2008 02:16:29 -0400
Message-Id: <1205907389-15305-2-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.rc0.10.g0fd43
In-Reply-To: <1205907389-15305-1-git-send-email-kevin@sb.org>
References: <1205907389-15305-1-git-send-email-kevin@sb.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add sendemail.smtpserverport to the Configuration section
of the git-send-email manpage. It should probably be
referenced in the --smtp-server-port option as well.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 Documentation/git-send-email.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 336d797..9d0a10c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -216,6 +216,9 @@ sendemail.chainreplyto::
 sendemail.smtpserver::
 	Default SMTP server to use.
 
+sendemail.smtpserverport::
+	Default SMTP server port to use.
+
 sendemail.smtpuser::
 	Default SMTP-AUTH username.
 
-- 
1.5.5.rc0.10.g0fd43

