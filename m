From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 09:00:30 -0800
Message-ID: <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	<7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601181233460.8678@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGfp-0006Es-Fg
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWARRAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWARRAe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:00:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:16063 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751367AbWARRAd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:00:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118165832.CWUZ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 11:58:32 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14838>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And where does the time lag (required for the test) come from now?

The point of the change is that it avoids to depend on the time
lag.  The test is to make sure we catch dirty index; instead of
timestamp difference it now uses i-num difference for that.
