From: Junio C Hamano <junkio@cox.net>
Subject: [1/4] What's not in 1.5.2 (have been cooking in next)
Date: Wed, 16 May 2007 15:47:13 -0700
Message-ID: <11793556371446-git-send-email-junkio@cox.net>
References: <11793556363795-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 00:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoSHE-0005bn-N0
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbXEPWrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXEPWrU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:47:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56508 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbXEPWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:47:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516224718.VCDX22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 16 May 2007 18:47:18 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zynG1W00a1kojtg0000100; Wed, 16 May 2007 18:47:17 -0400
X-Mailer: git-send-email 1.5.2.rc3.50.gfdcb7
In-Reply-To: <11793556363795-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47467>

Here are the first batch that will be in 'master' after 1.5.2
happens.

They all have been cooking in 'next', or were not compelling
enough feature enhancements to be included after -rc1.

*  jb/statcolor (Sat May 5 16:48:54 2007 -0400) 1 commit
 + Add colour support in rebase and merge tree diff stats output.

*  tt/gc (Wed May 9 15:48:39 2007 -0400) 1 commit
 + Add --aggressive option to 'git gc'

*  np/pack (Wed May 9 14:42:42 2007 -0400) 3 commits
 + deprecate the new loose object header format
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused.

*  sv/checkout (Wed May 9 12:33:20 2007 +0200) 1 commit
 + git-update-ref: add --no-deref option for overwriting/detaching
   ref

*  mst/connect (Wed May 16 20:09:41 2007 +0300) 1 commit
 + connect: display connection progress

*  dh/pack (Wed May 9 13:56:50 2007 -0700) 3 commits
 + Custom compression levels for objects and packs
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused
