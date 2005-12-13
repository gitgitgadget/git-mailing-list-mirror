From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] define MAXPATHLEN for hosts that don't support it
Date: Tue, 13 Dec 2005 15:21:34 +0300
Message-ID: <11344764941807-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 13:23:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em9AL-0005z2-8p
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 13:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLMMVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 07:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVLMMVy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 07:21:54 -0500
Received: from mail1.starcom.co.ug ([217.113.72.31]:17974 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP
	id S1750801AbVLMMVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 07:21:54 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 13 Dec 2005 15:21:46 +0300
  id 000F59F7.439EBCDA.000074F8
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id D89475251; Tue, 13 Dec 2005 15:23:28 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1Em99y-00056F-15; Tue, 13 Dec 2005 15:21:34 +0300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13577>

---

 git-compat-util.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

e7aa01129989561dcd069db41a2da4a133dcff61
diff --git a/git-compat-util.h b/git-compat-util.h
index 4185b12..ead0ede 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -110,4 +110,7 @@ static inline int sane_case(int x, int h
 	return x;
 }
 
+#ifndef MAXPATHLEN
+#define MAXPATHLEN 256
+#endif
 #endif
-- 
0.99.9.GIT
