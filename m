From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Thu, 21 Dec 2006 16:46:46 -0800
Message-ID: <7vvek492q1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061221182102.906ad046.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:46:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYYl-0002kV-Gi
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423156AbWLVAqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWLVAqs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:46:48 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:53920 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423156AbWLVAqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:46:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222004647.BELK20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:46:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1cmz1W00S1kojtg0000000; Thu, 21 Dec 2006 19:47:00 -0500
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20061221182102.906ad046.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Thu, 21 Dec 2006 18:21:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35098>

Sean <seanlkml@sympatico.ca> writes:

> This seems inconsistent and confusing.  When working with the
> local repository, git-branch doesn't list that as "refs/heads/next"
> it just lists "next".  Why all of a sudden when trying to fetch
> it from a remote repo must a user know about "refs/heads"?

You can always say "git log refs/heads/next" even though you are
allowed to say "git log next".  Maybe we should remove that
shorthand to make it consistent?   I think not.

The remote side can add things without your knowing, so
insisting on the exact match makes sense in a weird sort of
way.

And this is a config file you would set once and then can forget
about it.  I do not see a big deal about having to spell it
fully.
