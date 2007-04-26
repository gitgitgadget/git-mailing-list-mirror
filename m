From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 1/9] Document --dry-run parameter to send-email.
Date: Wed, 25 Apr 2007 19:37:15 -0700
Message-ID: <11775550432104-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgtrS-00071Z-KL
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXDZCha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXDZCha
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:37:30 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:56908 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750897AbXDZCh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:37:28 -0400
Received: (qmail 15754 invoked from network); 26 Apr 2007 02:37:26 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:37:26 +0000
Received: (qmail 18809 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32444 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <1177555043986-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45597>

From: Robin H. Johnson <robbat2@gentoo.org>

Looks like --dry-run was added to the code, but never to the --help output.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d6b1548..604168e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -77,6 +77,8 @@ Options:
    --quiet	  Make git-send-email less verbose.  One line per email
                   should be all that is output.
 
+   --dry-run	  Do everything except actually send the emails.
+
 EOT
 	exit(1);
 }
-- 
1.5.2.rc0.43.g2f4c7
