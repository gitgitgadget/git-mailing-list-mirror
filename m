From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 02 Jun 2006 09:00:41 -0700
Message-ID: <7vslmnbl92.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	<Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
	<9e4733910606011759t7c828a50gc4a6b45d92d2b344@mail.gmail.com>
	<Pine.LNX.4.64.0606011809401.5498@g5.osdl.org>
	<7vac8wdpr5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606020849390.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 18:01:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmC4s-0007uB-Ui
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 18:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWFBQAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 12:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFBQAn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 12:00:43 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12990 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932488AbWFBQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 12:00:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602160042.CMKO554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 12:00:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606020849390.5498@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 2 Jun 2006 08:53:40 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21166>

Linus Torvalds <torvalds@osdl.org> writes:

> Yeah, I don't think there is any reason to really support it. If you have 
> more than a few heads, you really do need the graphical version to see 
> what is going on, and git-show-branch doesn't buy you anything.

The real reason it uses a bit per given ref is what it wants to
show is different from what gitk shows.  It wants to show which
ones are reachable from which head on each commit -- in gitk the
user has to follow the line to find it out.

However, to track 300 branches, you would need a terminal with
360 columns or so, _and_ you have to count columns to see if a
given commit is reachable from the ref you are interested in, so
it is not useful at all in practice to do more than a handful
refs at a time.
