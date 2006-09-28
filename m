From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 21:03:14 -0700
Message-ID: <7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
	<Pine.LNX.4.64.0609272232040.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSn7H-0008HX-0W
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbWI1EDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWI1EDQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:03:16 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11146 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965270AbWI1EDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 00:03:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928040314.PNID12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 00:03:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Tg3G1V00v1kojtg0000000
	Thu, 28 Sep 2006 00:03:17 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609272232040.9349@xanadu.home> (Nicolas Pitre's
	message of "Wed, 27 Sep 2006 22:51:55 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27982>

Nicolas Pitre <nico@cam.org> writes:

> What I think you want and what you should talk about is that you're 
> interested into the "local appearance time" for a given commit and not 
> "local commit time".  Using that terminology is probably much less 
> confusing in the GIT world.
>
> To do so you'll need a GIT command that doesn'T exist yet.  Let's call 
> it git-local-arrival.  It could be defined as follows:
>
> SYNOPSIS
>
> 	git-local-arrival <committish>
>
> DESCRIPTION
>
> 	The command displays the time when given commit appeared in the 
> 	local repository.

This should be certainly doable, but local-arrival may not be
interesting if the repository has more than one branches.  Maybe

	git-local-arrival <committish> [<branch>]

which defaults to the current branch?
