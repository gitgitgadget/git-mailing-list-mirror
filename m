From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 20:01:41 -0700
Message-ID: <7v3bdmf2p6.fsf@assigned-by-dhcp.cox.net>
References: <7vy7vef52m.fsf@assigned-by-dhcp.cox.net>
	<20060701024309.63001.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 05:01:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwVjx-0002gy-AR
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 05:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWGADBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWGADBq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:01:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50926 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751285AbWGADBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 23:01:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701030144.JBNM27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 23:01:44 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060701024309.63001.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 30 Jun 2006 19:43:09 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23034>

Luben Tuikov <ltuikov@yahoo.com> writes:

> I took a comparative look with and without "--full-history",
> and FWIW, enabling full history just clobbers the output with a lot
> of unnecessary information.  I.e. it shows merges which do not have
> direct consequence or change to the files in the path spec specified
> after the "--".
>...
> FWIW, I think that the original intention (had there been a choice)
> would've been to show only most relevant history, i.e. changes
> directly related to paths and files after the "--".

Sounds sane.  Maybe we should clearly explain this behaviour
change in the commit log and claim it as an improvement.  We
might even want to do --no-merges if we go that route.
