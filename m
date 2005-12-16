From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why do we need [PATCH]?
Date: Fri, 16 Dec 2005 13:27:33 -0800
Message-ID: <7vpsnwenqy.fsf@assigned-by-dhcp.cox.net>
References: <20051216210145.GA25311@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:30:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnN7Z-0006dP-3T
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVLPV1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVLPV1g
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:27:36 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:25739 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932460AbVLPV1f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:27:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216212647.BZLJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 16:26:47 -0500
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20051216210145.GA25311@mars.ravnborg.org> (Sam Ravnborg's
	message of "Fri, 16 Dec 2005 22:01:45 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13754>

Sam Ravnborg <sam@ravnborg.org> writes:

> I looked at the source and found the -k option, but adding [PATCH]
> should not be default behaviour so this is not the correct solution.

The "correct" solution depends on where you come from.  That
extra [PATCH] is a carryover from BK days, I was told by Linus,
to make e-mailed things stand out --- I've never used BK but I
am guessing that things were not as obvious as our commit
messages, perhaps?  We have "Author/Committer" distinction so
the [PATCH] marker is redundant.

The rewrite, "git-am" does not bother with adding [PATCH], but
the original "git-applymbox", being everyday Linus' tool, was
left as it was, not to disrupt the workflow of Linus.
