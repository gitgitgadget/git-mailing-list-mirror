From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Thu, 08 Sep 2005 15:00:04 -0700
Message-ID: <7vy867te3f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
	<1126199765.3984.1.camel@localhost.localdomain>
	<Pine.LNX.4.63.0509081727560.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:01:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDURK-00034I-0M
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 00:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVIHWAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVIHWAH
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 18:00:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24995 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965013AbVIHWAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2005 18:00:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050908220005.YKAV3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Sep 2005 18:00:05 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509081727560.23242@iabervon.org> (Daniel
	Barkalow's message of "Thu, 8 Sep 2005 17:39:47 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8222>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I assume that what you want is something to include everything from two 
> commits, which would give conflicts if a name is reused?

My understanding is that Darrin wants to do what Linus did when
he merged gitk into git.git.

Personally I think that is a specialized application and
something like the git-merge-projects script I posted as a
follow-up would be more appropriate than adding it to the
current merge discussion.
