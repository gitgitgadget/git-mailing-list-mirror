From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] test-delta needs zlib to compile
Date: Wed, 08 Mar 2006 13:19:19 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603081317280.1859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 19:19:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH3G3-0006lp-AW
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 19:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWCHSTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 13:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCHSTU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 13:19:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28267 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750889AbWCHSTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 13:19:20 -0500
Received: from xanadu.home ([66.131.142.204]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVT0096ZMW7O040@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 08 Mar 2006 13:19:19 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17379>


Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/Makefile b/Makefile
index a5eb0c4..89d67d6 100644
--- a/Makefile
+++ b/Makefile
@@ -565,7 +565,7 @@ test-date$X: test-date.c date.o ctype.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
 
 test-delta$X: test-delta.c diff-delta.o patch-delta.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^ -lz
 
 check:
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
