From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] compat/ has subdirectories: do not omit them in 'make clean'
Date: Thu, 11 Jun 2009 22:56:12 +0200
Message-ID: <4A316F6C.8030409@kdbg.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de> <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302> <7viqjefxcv.fsf@alter.siame se.dyndns.org> <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> <7vprdl9qon.fsf@alter.siames  e.dyndns.org> <alpine.DEB.1.00.0906081645490.4461
 @intel-tinevez-2-302> <7vzlcizn3w.fsf@a! lter.siamese.dyndns.org> <CD46A3E1-A85C-4D03-854C-973B91ACC506@zib.de> <4A2F7C80.1090807@viscovery.net> <4A316EA8.1040203@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MErJr-0007aO-4K
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 22:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbZFKU4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 16:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbZFKU4J
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 16:56:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34269 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbZFKU4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 16:56:09 -0400
Received: from [192.168.1.201] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B13F8CDF88;
	Thu, 11 Jun 2009 22:56:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A316EA8.1040203@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121360>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  Johannes Sixt schrieb:
  >  So, I have the failure on my other system as well, and this is the fix ;)

  And this was quite helpful to find the breakage.

  -- Hannes

  Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a38dcdd..7002688 100644
--- a/Makefile
+++ b/Makefile
@@ -1691,7 +1691,7 @@ distclean: clean
  	$(RM) configure

  clean:
-	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
+	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
  		$(LIB_FILE) $(XDIFF_LIB)
  	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
  	$(RM) $(TEST_PROGRAMS)
-- 
1.6.3.2.1225.g177fa.dirty
