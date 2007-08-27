From: Petr Baudis <pasky@suse.cz>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 02:41:53 +0200
Message-ID: <20070827004153.GN1219@pasky.or.cz>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Aug 27 02:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPSgQ-0006MP-U0
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 02:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXH0Alz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 20:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbXH0Alz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 20:41:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60437 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbXH0Aly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 20:41:54 -0400
Received: (qmail 31248 invoked by uid 2001); 27 Aug 2007 02:41:53 +0200
Content-Disposition: inline
In-Reply-To: <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56750>

On Mon, Aug 27, 2007 at 02:16:34AM CEST, Sven Verdoolaege wrote:
> On Mon, Aug 27, 2007 at 01:59:44AM +0200, Petr Baudis wrote:
> >   So now I wonder, what is the thing you miss most there? Any cool stuff
> > repo.or.cz could (preferrably easily) do and doesn't?
> 
> Just a minor nit, but how about dropping the "git+" from the
> Push URL?

I'm a major proponent of the "git+" - it's just the correct thing to
specify. ssh:// by itself means secure _shell_, and that's not what the
URL means - ssh is literaily just a transport layer for the git
protocol. This is not my invention but fairly standard thing which
plenty of people use, and it makes it possible to select proper protocol
handlers and so on, shall something generic crunch on the URL. I've
never actually understood why do some people dislike it.

> Jakub was also talking about support in gitweb for specifying
> the location of submodules.  It would be nice if admins could
> set this information, wherever it ends up getting stored.

Hmm, this shouldn't be very hard to do if the support will get into
gitweb. And adding the support to gitweb shouldn't be that hard either.
:-) OTOH, it's not something that would get me terribly excited, so I
guess I'll wait for the gitweb side.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
