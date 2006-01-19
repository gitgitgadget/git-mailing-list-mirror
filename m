From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Support precise tracking of file modes
Date: Thu, 19 Jan 2006 19:46:14 +0100
Message-ID: <20060119184614.GG28365@pasky.or.cz>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com> <7vlkxckf7o.fsf@assigned-by-dhcp.cox.net> <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com> <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net> <43CF3061.2030504@michonline.com> <7vvewgirlt.fsf@assigned-by-dhcp.cox.net> <20060119094156.GY28365@pasky.or.cz> <7vacdsdqio.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, Adam Hunt <kinema@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 19:46:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezemq-0008MI-Nm
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWASSoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWASSoy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:44:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39298 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161186AbWASSoy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 13:44:54 -0500
Received: (qmail 18132 invoked by uid 2001); 19 Jan 2006 19:46:14 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacdsdqio.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14928>

Dear diary, on Thu, Jan 19, 2006 at 07:25:03PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Taking "quick'n'dirty" to the extreme _and_ combining it with Linus'
> > attitude to testing and documentation... ;-)
> 
> It is premature for us mere mortals to imitate Linus in that
> aspect by at least ten years ;-).  Please don't.

Yes, it was really just kind of proof-of-concept patch.

> About the content of the change, if we were to do this, we need
> to also record owner and group. recording full permissions
> without recording owner and group does not make much sense.

This would require much larger changes to the tree structure while we
can get this essentially for free and I believe it covers most of the
usage scenarios. In my /etc, all but two files are owned by root.root,
and in my ~, all the dot-files are owned by pasky.users, while the
permissions are a lot more varied.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
