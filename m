From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 15:44:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606251537450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
 <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
 <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
 <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <20060625012435.GZ21864@pasky.or.cz>
 <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net> <20060625093444.GD21864@pasky.or.cz>
 <Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060625102037.GI29364@pasky.or.cz> <7vzmg1v7ci.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sun Jun 25 15:44:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuUup-0004hz-0V
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 15:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWFYNoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 09:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWFYNoc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 09:44:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:39060 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750899AbWFYNoc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 09:44:32 -0400
Received: (qmail invoked by alias); 25 Jun 2006 13:44:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 25 Jun 2006 15:44:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmg1v7ci.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22623>

Hi,

On Sun, 25 Jun 2006, Junio C Hamano wrote:

> I vaguely recall that last time we discussed the minimum Perl
> version requirement somebody perhaps Merlyn said 5.6 is old
> enough but in some corporate settings people may still be stuck
> with 5.004.
> 
> Tentatively let's say our cut-off point is somewhere around 5.6.
> If we can get away without relying on extra from CPAN that would
> be great.  Otherwise as long as the modules from CPAN we end up
> depending on are all compatible with the cut-off version of Perl
> that would be acceptable.  We might even try to be nicer and
> carry a straight copy of what we require from CPAN in compat/
> just like we have subprocess.py there (modulo licensing worries
> if any, of course).

I can live with it. Although I still think that it would be a good idea to 
convert (at least the most commonly used) scripts to C.

Perl, Python and sometimes even bash are good for fast prototyping. But 
for serious work, such as profiling, they are not that good.

And you can see different behaviour on different platforms (plus things 
like the SunCC requirement for XS on Solaris), which make the scripts less 
robust.

Ciao,
Dscho
