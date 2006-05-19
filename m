From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow pickaxe to be used via git log.
Date: Thu, 18 May 2006 19:47:19 -0700
Message-ID: <7v4pzmn32g.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 04:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgv1P-0000w6-U9
	for gcvg-git@gmane.org; Fri, 19 May 2006 04:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWESCrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 22:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWESCrV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 22:47:21 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19092 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932176AbWESCrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 22:47:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519024720.VTKY25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 22:47:20 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 18 May 2006 21:31:24 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20316>

Sean <seanlkml@sympatico.ca> writes:

> Handle the -S option when passed to git log such that only the appropriate
> commits are displayed.  Unlike "whatchanged", by default no diff output
> is produced.

If that (specifically, "when passed to git log") is what you
want, do all of that in "git log" please.  I haven't checked,
but I suspect your changes would break git-rev-list and makes it
disobey the options the user gives it.
