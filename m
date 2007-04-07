From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git pull and importers
Date: Sat, 07 Apr 2007 07:21:46 -0700
Message-ID: <7v1wiwfeo5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 16:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaBnq-00012x-Ja
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965864AbXDGOVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965866AbXDGOVs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:21:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62961 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965864AbXDGOVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:21:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407142146.ZNOC1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:21:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEMm1W00A1kojtg0000000; Sat, 07 Apr 2007 10:21:46 -0400
In-Reply-To: <Pine.LNX.4.64.0704062239420.27922@iabervon.org> (Daniel
	Barkalow's message of "Fri, 6 Apr 2007 22:48:51 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43965>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Which would mean that it would use "git svn fetch" instead of "git fetch" 
> for that remote, and "git svn fetch" would use that config section instead 
> of its current config section.
>
> Any reason this couldn't be made to work?

No reason.  Making git-$(scm)import to behave more like
git-fetch-pack backend was one of the longstanding items on my
wishlist.  I think "cvsimport -i" could mostly be usable in the
current shape for that, but I do not know about others.

Especially I do not interoperate with any SVN repositories
myself, so I cannot scratch your itch.

However, I suspect you could help me with a code I've been
struggling with on-and-off lately.  Do you still remember
unpack-trees code?
