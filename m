From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Fri, 16 Dec 2005 10:17:07 +0100
Message-ID: <20051216091707.GR22159@pasky.or.cz>
References: <11344712912199-git-send-email-matlads@dsmagic.com> <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net> <20051213170015.GD22159@pasky.or.cz> <7vu0dcalgo.fsf@assigned-by-dhcp.cox.net> <20051215222424.GA3094@steel.home> <7vacf2lyn4.fsf@assigned-by-dhcp.cox.net> <7virtplr9s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 10:18:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnBiG-00016c-4g
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 10:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVLPJRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 04:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLPJRL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 04:17:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46270 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932199AbVLPJRK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 04:17:10 -0500
Received: (qmail 21532 invoked by uid 2001); 16 Dec 2005 10:17:07 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virtplr9s.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13733>

Dear diary, on Fri, Dec 16, 2005 at 03:17:19AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > The wildcard letters like ? and * I understand and sympathetic
> > about somewhat.  Something like this:
> >
> >         name="*.sh" ;# this also comes from the end user
> >         echo $name
> >
> > ends up showing every shell script in the current directory,
> > and not literal '*.sh'.
> 
> So why don't we do this?

I'm all for it, and now I also agree that forbidding \'" is pointless.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
