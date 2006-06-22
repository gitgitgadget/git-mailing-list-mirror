From: Petr Baudis <pasky@suse.cz>
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Date: Thu, 22 Jun 2006 22:52:17 +0200
Message-ID: <20060622205217.GE21864@pasky.or.cz>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org> <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org> <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com> <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org> <20060622200147.GA10712@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 22:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWA6-0008KZ-2N
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 22:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWFVUwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 16:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWFVUwW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 16:52:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2954 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030397AbWFVUwW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 16:52:22 -0400
Received: (qmail 9098 invoked by uid 2001); 22 Jun 2006 22:52:17 +0200
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20060622200147.GA10712@mars.ravnborg.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22368>

Dear diary, on Thu, Jun 22, 2006 at 10:01:47PM CEST, I got a letter
where Sam Ravnborg <sam@ravnborg.org> said that...
> Personally I'm still missing two things:
> 1) A command to let me see what this Linus guy have applied compared to
> my tree - without touching anything in my tree. bk changes -R

You can cg-fetch / git fetch and then either "cg-log -m" or
"git log -r ..origin".

> 2) A dry-run of a fetch+pull. I can do that if I really study the man
> pages I know. But "git pull --dry-run" would be more convinient.

What would that involve? Isn't git pull --no-commit enough?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
