From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log --full-history renamed-file
Date: Fri, 09 Mar 2007 16:55:06 -0800
Message-ID: <7v8xe53ok5.fsf@assigned-by-dhcp.cox.net>
References: <87lki6umts.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 01:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPps1-0000GZ-Pu
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 01:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767692AbXCJAzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 19:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767694AbXCJAzL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 19:55:11 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37847 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767692AbXCJAzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 19:55:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310005506.UBUK1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 19:55:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Yov61W0011kojtg0000000; Fri, 09 Mar 2007 19:55:06 -0500
In-Reply-To: <Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 9 Mar 2007 14:20:55 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41828>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> There were patches floating around for an option called "--follow" to "git 
> log", that would actually follow the renames. 
>
> I don't remember what happened to them - I suspect the implementation 
> wasn't up to snuff. But the *concept* is definitely right.

Yes, the concept is good.  It was from Fredrik of
merge-recursive fame.

The patch was not _bad_, but it looked a bit too intrusive back
then and scared me away.
