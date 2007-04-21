From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] WTF did we change in git-fsck recently?
Date: Fri, 20 Apr 2007 17:30:31 -0700
Message-ID: <7vps5ywouw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 02:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf3Uq-00038s-Ar
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 02:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbXDUAad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 20:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbXDUAad
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 20:30:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56075 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbXDUAac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 20:30:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421003032.ONMP1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 20:30:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pcWX1W0071kojtg0000000; Fri, 20 Apr 2007 20:30:31 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45140>

I noticed that "git-fsck --full" from 'master' takes forever to
fsck the kernel repository (I left it running for 2 hours before
killing it), while the one from 'maint' (or 1.5.1.1 which is
installed on kernel.org) finishes within 2 or 3 minutes.  There
is some serious breakages there.

Rings a bell?
