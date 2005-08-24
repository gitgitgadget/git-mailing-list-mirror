From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce "reset type" flag to "git reset"
Date: Tue, 23 Aug 2005 17:22:47 -0700
Message-ID: <7vpss4mbe0.fsf@assigned-by-dhcp.cox.net>
References: <7vu0hhzcj1.fsf@assigned-by-dhcp.cox.net>
	<20050823202637.GA8061@mars.ravnborg.org>
	<7vacj8nw5v.fsf@assigned-by-dhcp.cox.net>
	<87y86s2nvi.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 02:23:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7j2a-0008CC-EZ
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVHXAWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHXAWu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:22:50 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:974 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932506AbVHXAWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 20:22:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824002248.WWMX15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 20:22:48 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87y86s2nvi.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Wed, 24 Aug 2005 09:13:21 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7689>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> for --hard option, what you want to do is to completely revert the
> current state of your index file and work tree to known point.
>
> for that, how about git-revert-script?

"git revert" is to create a commit that reverts a previous
commit, which I think is quite different from what we have been
discussing so far.
