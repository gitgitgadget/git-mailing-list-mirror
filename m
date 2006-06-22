From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used.
Date: Thu, 22 Jun 2006 19:58:15 +0200
Message-ID: <20060622175815.GC21864@pasky.or.cz>
References: <0J1800MC1NKJD2C0@mxout2.netvision.net.il> <7vwtb9veqv.fsf@assigned-by-dhcp.cox.net> <20060622131235.GA21864@pasky.or.cz> <7vodwlp12i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 20:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtTbr-0002p4-42
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWFVSIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWFVSIv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:08:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65155 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932565AbWFVSIv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 14:08:51 -0400
Received: (qmail 17937 invoked by uid 2001); 22 Jun 2006 19:58:15 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodwlp12i.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22351>

Dear diary, on Thu, Jun 22, 2006 at 07:11:49PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Thu, Jun 22, 2006 at 09:19:52AM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> >> For that matter, I do not think tracking prefix_SQ makes much
> >> sense since what matters are bindir, gitexecdir and template_dir
> >> which are already covered, and prefix is merely a convenience to
> >> set these three (four, counting GIT_PYTHON_DIR; we probably
> >> should add it to TRACK_CFLAGS).
> >
> > $(prefix) will be passed to perl/Makefile.PL.
> 
> Then probably it shouldn't; instead we woulld probably want to
> pass the moral equivalent of GIT_PYTHON_DIR.

I'm not sure about what the rationale behind GIT_PYTHON_DIR was, but it
seems to be used only by a library supposedly internal to some Git
commands, while the Git.pm module should be available systemwide even
for non-Git applications, so it's really best to leave it to Perl where
to put it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
