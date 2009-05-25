From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH 1/3] Documentation/Makefile: add a commented-out ' to unconfuse Emacs
Date: Mon, 25 May 2009 18:07:09 -0400
Message-ID: <1243289231-32500-1-git-send-email-naesten@gmail.com>
Cc: git@vger.kernel.org, Samuel Bronson <naesten@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 26 00:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iKv-0003Kc-9p
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbZEYWHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbZEYWHU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:07:20 -0400
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:52679 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbZEYWHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:07:19 -0400
Received: from mr08.lnh.mail.rcn.net ([207.172.157.28])
  by smtp02.lnh.mail.rcn.net with ESMTP; 25 May 2009 18:07:20 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr08.lnh.mail.rcn.net (MOS 3.10.5-GA)
	with ESMTP id KWP43128;
	Mon, 25 May 2009 18:07:20 -0400 (EDT)
Received: from 207-172-203-39.c3-0.upd-ubr7.trpr-upd.pa.cable.rcn.com (HELO hydrogen) ([207.172.203.39])
  by smtp01.lnh.mail.rcn.net with ESMTP; 25 May 2009 18:07:20 -0400
Received: from naesten by hydrogen with local (Exim 4.69)
	(envelope-from <naesten@gmail.com>)
	id 1M8iKE-0008So-Nr; Mon, 25 May 2009 18:07:18 -0400
X-Mailer: git-send-email 1.6.3.1
X-Junkmail-Whitelist: YES (by domain whitelist at mr08.lnh.mail.rcn.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119966>

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Documentation/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7a8037f..f5d670e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -106,6 +106,7 @@ endif
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+# unconfuse Emacs: '
 
 #
 # Please note that there is a minor bug in asciidoc.
-- 
1.6.3.1
