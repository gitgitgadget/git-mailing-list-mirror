From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 19:08:48 -0800
Message-ID: <7v4q6yl6wv.fsf@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 04:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWQ2X-0007l9-Ib
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 04:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVJaDIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 22:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVJaDIu
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 22:08:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37004 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751304AbVJaDIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 22:08:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031030826.DNVS9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 22:08:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 30 Oct 2005 18:52:11 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10849>

Linus Torvalds <torvalds@osdl.org> writes:

> I've several times been surprised to see people not realize that
> "git-whatchanged" takes a file list to limit the files it is interested 
> in. I also suspect people don't realize that you can limit it by time and 
> version and file list, all at the same time.

> It would be good to make this more well-known, because a lot of people 
> probably end up using git not as developers, but just to follow what is 
> going on. And then the different limiters are some of the most important 
> parts (the date-one is likely the least important one, but limiting by 
> version and name is _very_ important).

I've somewhat updated git-rev-list documentation and tried to
categorize the options into commit selectors and presentation
modifiers.  The documentation for commands you mentioned in your
message all talk about them describing only frequently used
options, and refer the user to rev-list documentation.  I am not
sure this would be enough.

One good thing to have would be to add a section to Tutorial.
Currently we cover building a small project from scratch and
have the readers graduate when they learn basic commit swapping,
but we do not talk much about archaeology tools.
