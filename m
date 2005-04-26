From: Martin Atukunda <matlads@ds.co.ug>
Subject: [PATCH GIT 0.6.3] Add an uninstall target to Makefile
Date: Tue, 26 Apr 2005 16:48:22 +0300
Message-ID: <200504261648.22814.matlads@ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 15:48:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQQPL-00064S-7D
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 15:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDZNwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 09:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVDZNwc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 09:52:32 -0400
Received: from mail1.imul.com ([217.113.72.31]:57427 "EHLO mail1.starcom.co.ug")
	by vger.kernel.org with ESMTP id S261505AbVDZNw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 09:52:29 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.starcom.co.ug with esmtp; Tue, 26 Apr 2005 16:52:23 +0300
  id 000E5C1E.426E4797.0000630F
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id C38DD500B
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 16:53:23 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.50)
	id 1DQQQI-0004EX-V6
	for git@vger.kernel.org; Tue, 26 Apr 2005 16:48:23 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add an uninstall target to Makefile that removes installed scripts and
programs.

Signed-off-by: Martin Atukunda <matlads@ds.co.ug>

Index: Makefile
===================================================================
--- 0a9ee5a4d947b998a7ce489242800b39f98eeee5/Makefile  (mode:100644 
sha1:2d7e4cf0464c45b7c5b169bff7e5c4e7768c13a1)
+++ uncommitted/Makefile  (mode:100644)
@@ -82,6 +82,9 @@
        install -m755 -d $(DESTDIR)$(bindir)
        install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 
+uninstall:
+       cd $(DESTDIR)$(bindir) && rm $(PROG) $(SCRIPT) $(GEN_SCRIPT)
+
 clean:
        rm -f *.o mozilla-sha1/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
