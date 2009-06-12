From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 3/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
Date: Fri, 12 Jun 2009 12:51:39 +0200
Message-ID: <1244803902-8068-3-git-send-email-markus.heidelberg@web.de>
References: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:52:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4N4-0002Bm-99
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764182AbZFLKv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933746AbZFLKv4
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:51:56 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59886 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933517AbZFLKvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:51:46 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id BF493102EB011;
	Fri, 12 Jun 2009 12:51:47 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF4MN-00044V-01; Fri, 12 Jun 2009 12:51:47 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18phOwpuVAylX5bBvnxV/XeBCRT8IhmMo9/xzVs
	7Vu5xQPX0bV2Kh4LUnTKq5O5h3OFtKQ484dQ8/G6o774AeFX9n
	afbScgdUrg43UiBymcyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121405>

Also remove the argument from --[no-]chain-reply-to.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Applies on top of [2/6]

 Documentation/git-send-email.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a282190..0ec5343 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -159,7 +159,7 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to=<identifier>::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -208,7 +208,8 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 --[no-]thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
-	header set. Default is the value of the 'sendemail.thread' configuration
+	header set, unless specified with --in-reply-to.
+	Default is the value of the 'sendemail.thread' configuration
 	value; if that is unspecified, default to --thread.
 
 
-- 
1.6.3.2.236.ge505d
