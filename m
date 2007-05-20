From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge summaries
Date: Sun, 20 May 2007 01:27:41 -0700
Message-ID: <7vwsz3rjb6.fsf@assigned-by-dhcp.cox.net>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
	<alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
	<7vodki55px.fsf@assigned-by-dhcp.cox.net>
	<73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de>
	<7vy7jkwr96.fsf@assigned-by-dhcp.cox.net>
	<7vy7jkva41.fsf@assigned-by-dhcp.cox.net>
	<0E590255-A3F4-4D36-B798-80364ACD0D06@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 20 10:27:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpgla-0007Ub-G9
	for gcvg-git@gmane.org; Sun, 20 May 2007 10:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335AbXETI1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 04:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757170AbXETI1o
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 04:27:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51136 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbXETI1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 04:27:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520082743.DTTL6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 04:27:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1LTi1X0051kojtg0000000; Sun, 20 May 2007 04:27:43 -0400
In-Reply-To: <0E590255-A3F4-4D36-B798-80364ACD0D06@zib.de> (Steffen Prohaska's
	message of "Sun, 20 May 2007 10:17:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47798>

Steffen Prohaska <prohaska@zib.de> writes:

> But this is true not only for the upstream master but for every branch.
> The first-parent-path of any commit documents (at least in summaries)
> which features were introduced to the branch at which place. If a
> topic pulls from upstream, features already available in the upstream
> are introduced to the topic at this time. Why not summarize this?

Strictly speaking, it is not even correct with the upstream
master.  I believe even my own 'maint' has fast forward merge
that I pulled from other people, and that part of the history if
you follow first-parent, you would not be following the "project's"
history (if there is such a thing, and if you are equating it
with "JC's view of the history").
