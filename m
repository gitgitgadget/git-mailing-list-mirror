From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] [PARSECVS] add an install target to Makefile
Date: Fri, 19 May 2006 14:34:56 +0300
Message-ID: <47752.6885144927$1148038561@news.gmane.org>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Fri May 19 13:35:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh3Gt-0000aU-Sq
	for gcvg-git@gmane.org; Fri, 19 May 2006 13:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWESLfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 07:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWESLfp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 07:35:45 -0400
Received: from mail1.imul.com ([217.113.72.31]:29217 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S932279AbWESLfp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 07:35:45 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Fri, 19 May 2006 14:35:28 +0300
  id 0010D726.446DAD80.0000623F
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id DC5A05172
	for <git@vger.kernel.org>; Fri, 19 May 2006 14:38:01 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.62)
	(envelope-from <matlads@dsmagic.com>)
	id 1Fh3Fw-00049w-0p
	for git@vger.kernel.org; Fri, 19 May 2006 14:34:56 +0300
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.gff62
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20347>

---

573c3afa5674024df0fd5722404f215c54977699
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

573c3afa5674024df0fd5722404f215c54977699
diff --git a/Makefile b/Makefile
index 4ca6ffd..50fa551 100644
--- a/Makefile
+++ b/Makefile
@@ -24,3 +24,5 @@ y.tab.h: gram.c
 
 clean:
 	rm -f $(OBJS) y.tab.h gram.c lex.c parsecvs
+install:
+	cp parsecvs edit-change-log ${HOME}/bin
-- 
1.3.3.gff62
