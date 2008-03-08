Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 10723 invoked by uid 111); 8 Mar 2008 11:50:22 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Mar 2008 06:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbYCHLuP (ORCPT <rfc822;peff@peff.net>);
	Sat, 8 Mar 2008 06:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbYCHLuL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 06:50:11 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:38240 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752738AbYCHLuK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 06:50:10 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 0186B18DABC;
	Sat,  8 Mar 2008 03:50:08 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Document the sendemail.smtpserverport config variable
Date:	Sat,  8 Mar 2008 06:50:06 -0500
Message-Id: <1204977007-7267-2-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.487.g5a92
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add sendemail.smtpserverport to the Configuration section
of the git-send-email manpage. It should probably be
referenced in the --smtp-server-port option as well.
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
1.5.4.3.487.g5a92

