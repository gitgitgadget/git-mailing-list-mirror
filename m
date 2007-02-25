From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sun, 25 Feb 2007 01:45:44 -0800
Message-ID: <7vlkimtvsn.fsf@assigned-by-dhcp.cox.net>
References: <20070224172037.GA31963@xp.machine.xx>
	<7vvehrw9mz.fsf@assigned-by-dhcp.cox.net>
	<20070224221622.GA3897@xp.machine.xx>
	<7vvehqtzns.fsf@assigned-by-dhcp.cox.net>
	<20070225091302.GB3897@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 25 10:45:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLFx7-0005yj-DV
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 10:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbXBYJpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 04:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbXBYJpp
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 04:45:45 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46619 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbXBYJpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 04:45:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225094544.ZREF3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 04:45:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tllk1W0041kojtg0000000; Sun, 25 Feb 2007 04:45:44 -0500
In-Reply-To: <20070225091302.GB3897@xp.machine.xx> (Peter Baumann's message of
	"Sun, 25 Feb 2007 10:13:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40547>

Peter Baumann <waste.manager@gmx.de> writes:

> ..., but in the same sentence you have to say
> "Oh, did I mention that it doesn't work until you have made a first commit?"

Well, you do not even have to mention that if you are explaining
things correctly.  If something does its thing relative to the
latest commit, then it obviously would not work until you have
that "latest commit".  There is _no_ initial "empty" commit in
git.

I think getting people used to that concept early on would
actually avoid such confusion.  In that sense,...

> The plumbing commands are a diffrent story.

... I do not think the plumbing should be a different story.
Otherwise you would confuse people when they start learning the
plumbing.
