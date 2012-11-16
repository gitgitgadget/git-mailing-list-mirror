From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 4/4] RelNotes 1.8.1: Another grammar thinko
Date: Fri, 16 Nov 2012 10:05:53 -0300
Message-ID: <1353071153-1453-4-git-send-email-vonbrand@inf.utfsm.cl>
References: <1353071153-1453-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 16 14:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZLlM-0001il-1N
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 14:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab2KPNOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 08:14:50 -0500
Received: from zimbra.inf.utfsm.cl ([200.1.19.17]:57525 "EHLO
	zimbra.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab2KPNOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 08:14:50 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2012 08:14:50 EST
Received: from localhost (localhost [IPv6:::1])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTP id 5CC66181E91;
	Fri, 16 Nov 2012 10:05:57 -0300 (CLST)
X-Virus-Scanned: amavisd-new at zimbra.inf.utfsm.cl
Received: from zimbra.inf.utfsm.cl ([IPv6:::1])
	by localhost (zimbra.inf.utfsm.cl [IPv6:::1]) (amavisd-new, port 10026)
	with ESMTP id TvL7fq70V9EE; Fri, 16 Nov 2012 10:05:57 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (unknown [IPv6:2800:270:c:0:201:29ff:fefc:bb25])
	by zimbra.inf.utfsm.cl (Postfix) with ESMTPS id 416EC1813B5;
	Fri, 16 Nov 2012 10:05:57 -0300 (CLST)
Received: from quelen.inf.utfsm.cl (localhost [127.0.0.1])
	by quelen.inf.utfsm.cl (8.14.5/8.14.5) with ESMTP id qAGD5vX4001496;
	Fri, 16 Nov 2012 10:05:57 -0300
Received: (from vonbrand@localhost)
	by quelen.inf.utfsm.cl (8.14.5/8.14.5/Submit) id qAGD5un5001495;
	Fri, 16 Nov 2012 10:05:56 -0300
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1353071153-1453-1-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209875>

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/RelNotes/1.8.1.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.txt
index 668f1a3..88179b4 100644
--- a/Documentation/RelNotes/1.8.1.txt
+++ b/Documentation/RelNotes/1.8.1.txt
@@ -136,7 +136,7 @@ details).
    (merge 25dc8da js/format-2047 later to maint).
 
  * Sometimes curl_multi_timeout() function suggested a wrong timeout
-   value when there is no file descriptors to wait on and the http
+   value when there are no file descriptors to wait on and the http
    transport ended up sleeping for minutes in select(2) system call.
    A workaround has been added for this.
    (merge 7202b81 sz/maint-curl-multi-timeout later to maint).
-- 
1.8.0.197.g5a90748
