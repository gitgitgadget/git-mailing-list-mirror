From: Junio C Hamano <junkio@cox.net>
Subject: [0/4] What's not in 1.5.2 (overview)
Date: Wed, 16 May 2007 15:47:12 -0700
Message-ID: <11793556363795-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 00:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoSHE-0005bn-6T
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbXEPWrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756641AbXEPWrT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:47:19 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42244 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbXEPWrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:47:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516224717.OWWO24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 16 May 2007 18:47:17 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zynG1W00a1kojtg0000000; Wed, 16 May 2007 18:47:16 -0400
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47466>

Upcoming release 1.5.2 is nearing completion, so let's look at
the issues that are specifically excluded from it.

Before listing topics there is one thing.

*  sp/cvsexport (Thu May 10 01:06:36 2007 +0200) 1 commit
 + Optimized cvsexportcommit: calling 'cvs status' once instead of
   once per touched file.

This should really be 1.5.2.  Real-world users of cvsexport, if
you were burned by this, please NAK as soon as possible.  I'll
merge it to 1.5.2 unless I hear from anybody in a day or two.

The messages that follow this are:

  [1/4] Easy-to-decide ones; what's been cooking in next.
  [2/4] The ones to be cooked in next after 1.5.2
  [3/4] Things we do not have code for yet.
  [4/4] Leftover bits
