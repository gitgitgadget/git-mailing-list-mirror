From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert t6022 to use git-merge instead of git-pull
Date: Wed, 25 Apr 2007 14:15:03 -0700
Message-ID: <7vzm4wupew.fsf@assigned-by-dhcp.cox.net>
References: <20070425200718.GB30061@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgopT-0007TQ-Tz
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbXDYVPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 17:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbXDYVPI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 17:15:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35572 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbXDYVPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 17:15:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425211504.IIBQ1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 17:15:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rZF31W0031kojtg0000000; Wed, 25 Apr 2007 17:15:03 -0400
In-Reply-To: <20070425200718.GB30061@steel.home> (Alex Riesen's message of
	"Wed, 25 Apr 2007 22:07:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45580>

Is this really necessary?

I would rather want to leave some tests use "git merge" while
some others use "git pull ." to catch breakage of either form.
