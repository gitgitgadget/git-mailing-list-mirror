From: Junio C Hamano <junkio@cox.net>
Subject: Re: ~ and ^
Date: Sun, 13 May 2007 12:07:21 -0700
Message-ID: <7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
References: <20070513144442.b3cba792.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun May 13 21:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJPo-00059c-5g
	for gcvg-git@gmane.org; Sun, 13 May 2007 21:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbXEMTH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757494AbXEMTH1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 15:07:27 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63967 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbXEMTH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 15:07:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513190727.CPQI24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 15:07:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yj7M1W0051kojtg0000000; Sun, 13 May 2007 15:07:26 -0400
In-Reply-To: <20070513144442.b3cba792.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sun, 13 May 2007 14:44:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47170>

Sean <seanlkml@sympatico.ca> writes:

> Would it be possible/reasonable to treat a bare ~3 (or ^) on the git command
> line as equivalent to "<current branch>~3" ?    At least @{3} already works
> this way and it would be nice to do the same for the even more common tilde
> and hat operations.  If so, it would be a small convenience to just type:
> "git show ~3"

Interesting.

At least, "ls ~0" does not seem to get confused by bash to be
the home directory of the root user, so I do not offhand think
of a reason not to have ~$n as a synonym to HEAD~$n.  Would that
be useful?  I dunno.

P.S.

Welcome back to the list ;-)
