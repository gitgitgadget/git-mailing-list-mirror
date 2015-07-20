From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 1/3] doc: convert send-email option headings to nouns
Date: Mon, 20 Jul 2015 19:26:27 +0100
Message-ID: <1437416790-5792-2-git-send-email-philipoakley@iee.org>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:26:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFls-0006rG-3u
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbbGTS0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:26:30 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:33942 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753300AbbGTS02 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 14:26:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CzCQBiPK1VPHMBFlxcgkFSgT2GUIFZuz0EAgKBLk0BAQEBAQEHAQEBAUABP4QkAQEERw8jEAgaLzkKAwkIBhOIMrdtkG8BAQgij28RAVEHBoQlBZRSpSiBCYMaPTGBBgcXB4EgAQEB
X-IPAS-Result: A2CzCQBiPK1VPHMBFlxcgkFSgT2GUIFZuz0EAgKBLk0BAQEBAQEHAQEBAUABP4QkAQEERw8jEAgaLzkKAwkIBhOIMrdtkG8BAQgij28RAVEHBoQlBZRSpSiBCYMaPTGBBgcXB4EgAQEB
X-IronPort-AV: E=Sophos;i="5.15,509,1432594800"; 
   d="scan'208";a="614509312"
Received: from host-92-22-1-115.as13285.net (HELO localhost) ([92.22.1.115])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 20 Jul 2015 19:26:27 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274341>

... for ease of reference within the text.

Except the 'Sending options' for which there wasn't an
obvious noun phrase.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-send-email.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7ae467b..bc357b8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -41,8 +41,8 @@ and the "Subject:" of the message as the second line.
 OPTIONS
 -------
 
-Composing
-~~~~~~~~~
+Composition options
+~~~~~~~~~~~~~~~~~~~
 
 --annotate::
 	Review and edit each patch you're about to send. Default is the value
@@ -147,8 +147,8 @@ Note that no attempts whatsoever are made to validate the encoding.
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
 
-Sending
-~~~~~~~
+Sending options
+~~~~~~~~~~~~~~~
 
 --envelope-sender=<address>::
 	Specify the envelope sender used to send the emails.
@@ -234,8 +234,8 @@ must be used for each option.
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
 
-Automating
-~~~~~~~~~~
+Automation options
+~~~~~~~~~~~~~~~~~~
 
 --to-cmd=<command>::
 	Specify a command to execute once per patch file which
@@ -326,8 +326,8 @@ Failure to do so may not produce the expected result in the
 recipient's MUA.
 
 
-Administering
-~~~~~~~~~~~~~
+Administration options
+~~~~~~~~~~~~~~~~~~~~~~
 
 --confirm=<mode>::
 	Confirm just before sending:
-- 
2.4.2.windows.1.5.gd32afb6
