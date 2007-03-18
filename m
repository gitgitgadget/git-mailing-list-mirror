From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-remote to list pushed branches.
Date: Sun, 18 Mar 2007 13:37:54 -0700
Message-ID: <7vzm6ajnj1.fsf@assigned-by-dhcp.cox.net>
References: <200703182134.46450.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Mar 18 21:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT28s-0000WX-Sp
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 21:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbXCRUiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 16:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933231AbXCRUiN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 16:38:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43502 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbXCRUiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 16:38:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318203811.ZKEP24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 16:38:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cLeB1W00i1kojtg0000000; Sun, 18 Mar 2007 16:38:12 -0400
In-Reply-To: <200703182134.46450.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 18 Mar 2007 21:34:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42519>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> The configured refspecs are printed almost verbatim, i.e. both the local
> and the remote branch name separated by a colon are printed; only the
> prefix 'refs/heads/' is removed, like this:
>
>   Local branch(es) pushed with 'git push'
>     master refs/tags/*:refs/tags/* next:next
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  [Resent; I don't see the patch applied nor were there any comments.]
>
>  The hunk that reads the 'Push'es from the .git/remotes file is taken
>  almost verbatim from the corresponding 'Pull' clause and is untested.

Maybe while waiting for application nor comments you could have
tested and removed that comment?
