From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: Swap positions of 'next' and 'prev' buttons in the
 'Find' section.
Date: Wed, 07 Nov 2007 11:22:03 +0100
Message-ID: <473191CB.8060806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 11:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi3E-0001dF-6v
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbXKGKWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbXKGKWI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:22:08 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51287 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbXKGKWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:22:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ipi2S-0002ps-F0; Wed, 07 Nov 2007 11:21:36 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7288D69F; Wed,  7 Nov 2007 11:22:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63801>

The button order 'prev' left of 'next' feels more natural than the other
way round, in particular, compared to the order of the forward and backward
arrows that are in the line above.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
  gitk |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 01a8541..727f4a0 100755
--- a/gitk
+++ b/gitk
@@ -767,7 +767,7 @@ proc makewindow {} {
      button .tf.lbar.fnext -text "next" -command {dofind 1 1} -font uifont
      button .tf.lbar.fprev -text "prev" -command {dofind -1 1} -font uifont
      label .tf.lbar.flab2 -text " commit " -font uifont
-    pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
+    pack .tf.lbar.flabel .tf.lbar.fprev .tf.lbar.fnext .tf.lbar.flab2 \
  	-side left -fill y
      set gdttype "containing:"
      set gm [tk_optionMenu .tf.lbar.gdttype gdttype \
-- 
1.5.3.5.1298.g228d6-dirty
