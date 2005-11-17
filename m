From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] 'make clean' forgot about some files
Date: Thu, 17 Nov 2005 10:40:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511171038290.14287@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 16:49:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecltf-0001jq-Ic
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKQPk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVKQPkZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:40:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12077 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932265AbVKQPkX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 10:40:23 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IQ3005EOVJA23D0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Nov 2005 10:40:22 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12120>

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/Makefile b/Makefile
index ebff990..3bdd059 100644
--- a/Makefile
+++ b/Makefile
@@ -466,7 +466,7 @@ deb: dist
 ### Cleaning rules
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o compat/*.o $(PROGRAMS) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o git $(PROGRAMS) $(LIB_FILE)
 	rm -f $(filter-out gitk,$(SCRIPTS))
 	rm -f *.spec *.pyc *.pyo
 	rm -rf $(GIT_TARNAME)
