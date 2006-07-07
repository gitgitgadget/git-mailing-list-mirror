From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Fri, 7 Jul 2006 13:06:55 +0200
Message-ID: <20060707110655.GR29115@pasky.or.cz>
References: <20060706124025.G325584e9@leonov.stosberg.net> <20060706161011.ccc2ea1c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 13:07:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoAq-0003v1-5g
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWGGLHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWGGLHA
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:07:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52899 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751013AbWGGLG7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 07:06:59 -0400
Received: (qmail 17404 invoked by uid 2001); 7 Jul 2006 13:06:55 +0200
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060706161011.ccc2ea1c.tihirvon@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23427>

Dear diary, on Thu, Jul 06, 2006 at 03:10:11PM CEST, I got a letter
where Timo Hirvonen <tihirvon@gmail.com> said that...
> Dennis Stosberg <dennis@stosberg.net> wrote:
> 
> > +	echocheck "for perl"
> > +	if test -z "$_perl" ; then
> > +		_perl=`which perl`
> > +		test "$_perl" || die "cannot find path to perl"
> > +	fi
> > +	echores "$_perl"
> 
> "which" isn't portable. On SunOS 5.9 "which foo" prints error message to
> stdout and returns 0.

Wait, Git runs on SunOS 5.9?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
