From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] connect: Fix typo in result string of prot_name()
Date: Thu, 24 Sep 2015 14:44:49 +0200
Message-ID: <1443098689-19433-1-git-send-email-tklauser@distanz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 14:45:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf5te-0007A2-GR
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 14:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbbIXMoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 08:44:55 -0400
Received: from mail.zhinst.com ([212.126.164.98]:37563 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622AbbIXMoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 08:44:55 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Thu, 24 Sep 2015 14:44:49 +0200
X-Mailer: git-send-email 2.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278545>

Replace 'unkown' with 'unknown'.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index c0144d8..777f31c 100644
--- a/connect.c
+++ b/connect.c
@@ -254,7 +254,7 @@ static const char *prot_name(enum protocol protocol)
 		case PROTO_GIT:
 			return "git";
 		default:
-			return "unkown protocol";
+			return "unknown protocol";
 	}
 }
 
-- 
2.5.3
