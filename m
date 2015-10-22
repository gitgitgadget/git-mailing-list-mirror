From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/5] credential-cache--daemon: remove unused #include "sigchain.h"
Date: Thu, 22 Oct 2015 14:43:27 +0200
Message-ID: <1445517810-13998-3-git-send-email-tklauser@distanz.ch>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 14:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFDh-00078L-1d
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 14:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbbJVMnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 08:43:41 -0400
Received: from mail.zhinst.com ([212.126.164.98]:42960 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756864AbbJVMne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 08:43:34 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Thu, 22 Oct 2015 14:43:30 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
In-Reply-To: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280046>

After switching to use the tempfile module in commit 9e903316
(credential-cache--daemon: use tempfile module), no declarations from
sigchain.h are used in credential-cache--daemon.c anymore. Thus, remove
the #include.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 credential-cache--daemon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index eef6fce..82715aa 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -2,7 +2,6 @@
 #include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
-#include "sigchain.h"
 #include "parse-options.h"
 
 static struct tempfile socket_file;
-- 
2.6.1.148.g7927db1
