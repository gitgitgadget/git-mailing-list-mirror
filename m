From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 22:15:15 -0800
Message-ID: <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061223051210.GA29814@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 07:15:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy0AP-0002u1-NO
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 07:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbWLWGPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 01:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWLWGPS
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 01:15:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37945 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbWLWGPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 01:15:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223061516.GUWV15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 01:15:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 26EZ1W00G1kojtg0000000; Sat, 23 Dec 2006 01:14:34 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20061223051210.GA29814@segfault.peff.net> (Jeff King's message
	of "Sat, 23 Dec 2006 00:12:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35272>

Jeff King <peff@peff.net> writes:

> BTW, is there some explanation why branch.*.merge specifies a _remote_
> head? The following would make much more sense to me:
>
> [branch "master"]
> remote = origin
> merge = refs/remotes/origin/master

Only *if* you store it in that tracking branch.  The name the
other party gives _do_ matter to you anyway, because you have to
_know_ it to fetch.  What it does NOT matter is if you use a
tracking branch, or if you do, which local tracking branch you
use to track it.
