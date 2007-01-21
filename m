From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show_date(): fix relative dates
Date: Sat, 20 Jan 2007 16:59:14 -0800
Message-ID: <7v3b656vq5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701202203260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jan 21 01:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8R3Y-00050W-3W
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 01:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXAUA7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 19:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXAUA7Q
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 19:59:16 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39414 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXAUA7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 19:59:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121005914.BGEV9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sat, 20 Jan 2007 19:59:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DcyK1W00E1kojtg0000000; Sat, 20 Jan 2007 19:58:20 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701202203260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 Jan 2007 22:21:38 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37299>

I noticed this and have a different solution in the show-branch
--reflog code (it does not pass tz).  I haven't thought about
which solution is the correct one (and do not have time to think
about it now while writing this message, sorry -- will do the
thinking later unless you beat me to it).
