From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 17:18:59 -0700
Message-ID: <7vodtmey30.fsf@assigned-by-dhcp.cox.net>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
	<20060911142644.32313.qmail@science.horizon.com>
	<7vy7sqic4e.fsf@assigned-by-dhcp.cox.net>
	<17669.55963.930152.564529@cargo.ozlabs.ibm.com>
	<7v1wqige41.fsf@assigned-by-dhcp.cox.net> <ee4tmo$mhm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 02:18:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMvyf-0002RH-58
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 02:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWILASJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWILASJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 20:18:09 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61898 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965195AbWILASH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 20:18:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060912001805.HSNB6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Sep 2006 20:18:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MCHw1V0041kojtg0000000
	Mon, 11 Sep 2006 20:17:56 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee4tmo$mhm$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	12 Sep 2006 02:06:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26872>

Jakub Narebski <jnareb@gmail.com> writes:

> Actually 'git ls-remote .' _is_ useful for gitweb, see the new 
> git_get_references code. 

You are missing the point.

We are not discussing if having foo^{} is useful.  There is no
argument about it.  Without it the user is forced to ask
rev-parse.

The point is if it is Ok to assume foo and foo^{} (and nothing
else) are enough to make Porcelains and visualizers happy, and I
suspected the answer was no (remember show-ref discussion?).
