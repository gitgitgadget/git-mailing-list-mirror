From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce "reset type" flag to "git reset"
Date: Tue, 23 Aug 2005 15:08:44 -0700
Message-ID: <7vacj8nw5v.fsf@assigned-by-dhcp.cox.net>
References: <7vu0hhzcj1.fsf@assigned-by-dhcp.cox.net>
	<20050823202637.GA8061@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 00:10:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gwt-0006d8-AZ
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVHWWIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVHWWIr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:08:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:3041 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932489AbVHWWIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 18:08:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823220846.UKYM15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 18:08:46 -0400
To: Sam Ravnborg <sam@ravnborg.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7679>

Sam Ravnborg <sam@ravnborg.org> writes:

> But --soft, --hard looks rather confusing to me.
>
> Something like --force or --prune may be a bit more intuitive, and let
> default behaviour be the one you name --soft for now.

I do not have objections to removing --mixed, but I do not find
--force/--prune any less confusing than --soft/--hard.  Its just
a terminology so once people get used to it anything would do.
But I agree that we need to come up with a good name for them.
I do not think --force/--prune is it, though.

> I think it would make sense to be able to specify the topmost SHA1 (or 
> HEAD:5 or HEAD^^^^^) from where the reset should start.

"git reset --hard HEAD~5" should work.  Sorry, the colon ":"
turns out to be confusing to refspec notation <src>:<dst> used
in fetch/push and was replaced with a tilde "~" some time ago.
