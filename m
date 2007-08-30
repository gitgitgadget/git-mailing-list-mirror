From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 1/1] Add basic test for stg status
Date: Thu, 30 Aug 2007 13:11:09 +0200
Message-ID: <11884722703161-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 30 13:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQhwK-00066q-DG
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 13:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbXH3LLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 07:11:32 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbXH3LLb
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 07:11:31 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:46871 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759407AbXH3LLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 07:11:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 067F0200A21C;
	Thu, 30 Aug 2007 13:11:12 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06584-01-10; Thu, 30 Aug 2007 13:11:11 +0200 (CEST)
Received: from morpheus (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 38924200A243;
	Thu, 30 Aug 2007 13:11:11 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id C66BCBFA58; Thu, 30 Aug 2007 13:11:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc6.31.g3c3b
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57023>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

This is very basic, but there was no test at all that ran stg status,
so nothing excercised the code changed in the following patch.

 t/t0002-status.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100755 t/t0002-status.sh

diff --git a/t/t0002-status.sh b/t/t0002-status.sh
new file mode 100755
index 0000000..c088d56
--- /dev/null
+++ b/t/t0002-status.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 David K=E5gedal
+#
+
+test_description=3D'Basic stg status
+
+Test that "stg status" works.'
+
+. ./test-lib.sh
+
+test_expect_success 'Run status on empty' \
+  'stg status'
+
+test_done
--=20
1.5.3.rc6.31.g3c3b
