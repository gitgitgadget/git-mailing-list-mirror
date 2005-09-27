From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: shared GIT repos
Date: Tue, 27 Sep 2005 10:45:13 +0200
Message-ID: <20050927084513.GU31276@kiste.smurf.noris.de>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <pan.2005.09.27.06.35.35.834134@smurf.noris.de> <7vu0g70yqg.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 10:48:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKB6E-0004GH-2k
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 10:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVI0IqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 04:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVI0IqC
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 04:46:02 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:36265 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S964868AbVI0IqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 04:46:00 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EKB5O-0007oy-55; Tue, 27 Sep 2005 10:45:50 +0200
Received: (nullmailer pid 12530 invoked by uid 501);
	Tue, 27 Sep 2005 08:45:13 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0g70yqg.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9382>

Hi,

Junio C Hamano:
> Do you want to guard the repository from malicious users?  Or is
> it enough to guard a casual/careless user from making mistakes?
> 
Well, s/malicious users/somebody who wants to cover up an ugly mistake/
would be more accurate.

What I am doing: I'm writing a system management frontend which allows
people to install version-controlled stuff (like, the configuration for
a backup server, or Yet Another PHPBB Installation) on servers -- without
even having a login there.

Some of these contain login scripts that might need root privileges or
similar (like, "restart Apache"). I want people to be unable to simply
remove the commit that included the "rm -rf /" command, move the ref
back, upload a new version, and pretend that nothing happened *la la la*.

> If one has commit privileges, then one can already do enough
> harm to the project without being able to remove objects nor
> updating a ref with non-fast-forward ref.

But in that case it's traceable what happened and whodunit.

> I think most of the pieces are already there and you only need to
> assemble them and write a howto ;-).
> [ list ]

OK, thanks, that helps. I'll write something up.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
When angry, count four; when very angry, swear.
