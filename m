From: Junio C Hamano <junkio@cox.net>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 03:48:45 -0700
Message-ID: <7vzmg1v7ci.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<20060625012435.GZ21864@pasky.or.cz>
	<7vfyhtopjm.fsf@assigned-by-dhcp.cox.net>
	<20060625093444.GD21864@pasky.or.cz>
	<Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060625102037.GI29364@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sun Jun 25 12:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSAe-0000os-Aq
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWFYKsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWFYKsr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:48:47 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21995 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932332AbWFYKsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 06:48:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625104846.GOYQ554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 06:48:46 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060625102037.GI29364@pasky.or.cz> (Petr Baudis's message of
	"Sun, 25 Jun 2006 12:20:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22607>

Petr Baudis <pasky@suse.cz> writes:

>> And old ones. If you would require me to upgrade to Perl 5.8.1, I would 
>> rather stop upgrading git.
>
>   please read it again - I'm not requiring you to upgrade to Perl 5.8.1.
> I'm just saying that if you have Perl older than 5.8.1, you might need
> to install some extra modules from CPAN.
>
>   Now, if that's not acceptable either that's fine by me and I can
> adapt, I just need to know at which point we _will_ require you to
> upgrade or install extra modules.

I vaguely recall that last time we discussed the minimum Perl
version requirement somebody perhaps Merlyn said 5.6 is old
enough but in some corporate settings people may still be stuck
with 5.004.

Tentatively let's say our cut-off point is somewhere around 5.6.
If we can get away without relying on extra from CPAN that would
be great.  Otherwise as long as the modules from CPAN we end up
depending on are all compatible with the cut-off version of Perl
that would be acceptable.  We might even try to be nicer and
carry a straight copy of what we require from CPAN in compat/
just like we have subprocess.py there (modulo licensing worries
if any, of course).

Johannes, Linus and the list, would that be a good enough
guideline?
