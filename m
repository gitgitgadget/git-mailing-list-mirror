From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 23:11:18 -0800
Message-ID: <7vy7ozt7c9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061223051210.GA29814@segfault.peff.net>
	<7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
	<20061223062801.GA5415@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:16:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy17C-0000OZ-Q2
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWLWHQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbWLWHQE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:16:04 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:53976 "EHLO
	fed1rmmtai15.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbWLWHQB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:16:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223071119.NSHL20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 02:11:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 27Ac1W0011kojtg0000000; Sat, 23 Dec 2006 02:10:36 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20061223062801.GA5415@segfault.peff.net> (Jeff King's message of
	"Sat, 23 Dec 2006 01:28:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35278>

Jeff King <peff@peff.net> writes:

> Yes, my proposed syntax means you have to have a tracking branch. But
> does it really make sense for people to put entries in their config
> file, but not have a tracking branch? What do people use non-tracking
> branch pulls for, anyway? I would assume for one-off pulls of
> infrequently used repositories, in which case they're always saying
> "git-pull git://path/to/repo foo:bar".

Not at all.  I pull from gitk repository and I do not have
tracking branch, but I still have a remote defined for it.
