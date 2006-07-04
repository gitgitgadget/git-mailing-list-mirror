From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a custom ./configure script
Date: Tue, 4 Jul 2006 23:57:47 +0200
Message-ID: <20060704215747.GQ29115@pasky.or.cz>
References: <20060704004012.22639.44317.stgit@machine.or.cz> <e8drmq$8ec$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 23:57:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxsu1-0004EU-PF
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 23:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWGDV5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 17:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGDV5v
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 17:57:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40648 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932297AbWGDV5u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 17:57:50 -0400
Received: (qmail 27939 invoked by uid 2001); 4 Jul 2006 23:57:47 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e8drmq$8ec$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23320>

Dear diary, on Tue, Jul 04, 2006 at 03:50:16PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > The patch is on top of pu, that is Jakub Narebski's autoconf patch, because
> > it reuses most of its infrastructure and just replaces the configure script.
> 
> If you named it for example configure.sh, then autoconf generated version, 
> and your by hand created version could coexist.

I'm not opposed to it per se, but I'm just not sure if it makes any
sense to support them both in parallel, since then you have parallel
infrastructure doing the exactly same thing, or worse yet - performing
a subtly different set of tests. The benefit is unclear to me.

Another thing is that it's named *everywhere* ./configure and if I use a
different name now then it will be hard to rename.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
