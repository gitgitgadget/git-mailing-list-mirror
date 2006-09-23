From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 12:35:19 -0700
Message-ID: <7vpsdms7ew.fsf@assigned-by-dhcp.cox.net>
References: <20060923164308.16334.49252.stgit@machine.or.cz>
	<45156780.6070801@gmail.com> <20060923170439.GQ8259@pasky.or.cz>
	<Pine.LNX.4.63.0609231921110.25853@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060923173943.GA20017@pasky.or.cz>
	<Pine.LNX.4.63.0609231947340.25853@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060923180539.GC20017@pasky.or.cz>
	<Pine.LNX.4.63.0609232007550.25853@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:35:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRDHZ-0000si-HM
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWIWTfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWIWTfW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:35:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50320 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751496AbWIWTfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 15:35:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923193520.BEAV6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 15:35:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RvbJ1V00W1kojtg0000000
	Sat, 23 Sep 2006 15:35:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609232007550.25853@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 23 Sep 2006 20:14:28 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27618>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The thing is, your patch optimizes for a very special case, which special 
> case IMHO should be handled differently to begin with.

I share the feeling, and the usual URL while spelling out the
repository name but used only for the site name, because other
special parameters are used to override the repository path
within the site, is just too ugly.
