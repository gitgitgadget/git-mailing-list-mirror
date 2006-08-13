From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 10:07:59 -0700
Message-ID: <7vzme8lg28.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 19:08:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCJRf-0002WT-L4
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 19:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWHMRIC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 13:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHMRIB
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 13:08:01 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17595 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751319AbWHMRIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 13:08:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813170800.HUVJ23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 13:08:00 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0608131158500.9789@iabervon.org> (Daniel
	Barkalow's message of "Sun, 13 Aug 2006 12:34:49 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25286>

Daniel Barkalow <barkalow@iabervon.org> writes:

> My suspicion is that most people who run commit directly and have a 
> default push location tend to want to push after every commit (or, at 
> least, be fine with that, and really want to have pushed after the last of 
> a batch).

I for one would be horrified ;-) but that's probably just me.

Some people seem to like 'commit -o' (which now is the default),
and worse yet (from 'discipline' point of view) there are even
people who want to be able to edit the patch preview in place in
'commit -v' buffer.  Commits by these people are by definition
not even compile tested in isolation.  I suspect those are the
very people who would want to push immediately after they make
commits.

Chilly.

Don't get me wrong -- I am not opposed to "git-commit && git-push".
It may be handy if you are pushing into some alternate (backup)
location.  But "publish" (implying "public consumption") is too
much for my taste, and I am hesitant to endorse such a workflow.
