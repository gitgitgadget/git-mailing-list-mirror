From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix dependencies of parse-options test program
Date: Wed, 14 Nov 2007 00:16:36 +0100
Message-ID: <20071113231636.GJ3268@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 00:17:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is50I-00042t-Mj
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761157AbXKMXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761065AbXKMXQk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:16:40 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45543 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760895AbXKMXQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:16:39 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo59) (RZmta 14.0)
	with ESMTP id g0224cjADM4Pky ; Wed, 14 Nov 2007 00:16:37 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 68684277AE;
	Wed, 14 Nov 2007 00:16:37 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id DD87056D22; Wed, 14 Nov 2007 00:16:36 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64906>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

An old test-parse-options was breaking t0040.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index cd6d469..af827f6 100644
--- a/Makefile
+++ b/Makefile
@@ -999,6 +999,8 @@ test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
 
+test-parse-options$X: parse-options.o
+
 .PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 
 test-%$X: test-%.o $(GITLIBS)
-- 
1.5.3.5.668.g22088
