From: Petr Baudis <pasky@ucw.cz>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 19:11:02 +0200
Message-ID: <20060526171102.GH11941@pasky.or.cz>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060526193325.d2a530a4.tihirvon@gmail.com> <20060526163829.GB10488@pasky.or.cz> <20060526200526.d8a2f776.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: wildfire@progsoc.uts.edu.au, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 19:10:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjfpk-0004bd-OX
	for gcvg-git@gmane.org; Fri, 26 May 2006 19:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWEZRKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 13:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWEZRKm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 13:10:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14258 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751159AbWEZRKl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 13:10:41 -0400
Received: (qmail 7950 invoked by uid 2001); 26 May 2006 19:11:02 +0200
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060526200526.d8a2f776.tihirvon@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20822>

Dear diary, on Fri, May 26, 2006 at 07:05:26PM CEST, I got a letter
where Timo Hirvonen <tihirvon@gmail.com> said that...
> > > I don't think a global config file is really needed but it would be
> > > nice if .git/config would override the environment variables, not the
> > > other way around.
> > 
> > Then you have no other way to override .git/config e.g. when committing
> > patches submitted by other people.
> 
> git commit --author "name <email>"

Except that this just sets the environment variables for you. :-)

Now, you could do some really funny stuff with overriding the
environment variables at git commit's entry point with .git/config
stuff, then possibly setting them again in case --author was passed, but
I seriously think such a confusion is not worth it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
