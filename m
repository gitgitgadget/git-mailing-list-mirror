X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/2] git-send-email: Document support for local sendmail instead of SMTP server
Date: Sun, 29 Oct 2006 22:31:38 +0300
Message-ID: <11621502993406-git-send-email-vsu@altlinux.ru>
NNTP-Posting-Date: Sun, 29 Oct 2006 19:32:11 +0000 (UTC)
Cc: Ryan Anderson <rda@google.com>, git@vger.kernel.org,
	Sergey Vlasov <vsu@altlinux.ru>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.3.ge502
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30443>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGNm-00006V-Ct for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965347AbWJ2Tbm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbWJ2Tbm
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:31:42 -0500
Received: from master.altlinux.org ([62.118.250.235]:30225 "EHLO
 master.altlinux.org") by vger.kernel.org with ESMTP id S965347AbWJ2Tbm (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:31:42 -0500
Received: by master.altlinux.org (Postfix, from userid 584) id A4AF3E3C2B;
 Sun, 29 Oct 2006 22:31:40 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Fix the --smtp-server option description to match reality.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 Documentation/git-send-email.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 481b3f5..ec0e201 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -66,8 +66,11 @@ The options available are:
 	all that is output.
 
 --smtp-server::
-	If set, specifies the outgoing SMTP server to use.  Defaults to
-	localhost.
+	If set, specifies the outgoing SMTP server to use.  A full
+	pathname of a sendmail-like program can be specified instead;
+	the program must support the `-i` option.  Defaults to
+	`/usr/sbin/sendmail` or `/usr/lib/sendmail` if such program is
+	available, or to `localhost` otherwise.
 
 --subject::
    	Specify the initial subject of the email thread.
-- 
1.4.3.3.ge502
