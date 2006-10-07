From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sun, 8 Oct 2006 00:30:23 +0200
Message-ID: <20061007223023.GI20017@pasky.or.cz>
References: <20061006212616.GA5175@lumumba.uhasselt.be> <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE> <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net> <eg82tq$2uq$1@sea.gmane.org> <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 00:30:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWKgk-00034N-21
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 00:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWJGWa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 18:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWJGWa0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 18:30:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25279 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751056AbWJGWaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 18:30:25 -0400
Received: (qmail 17916 invoked by uid 2001); 8 Oct 2006 00:30:23 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28513>

Dear diary, on Sat, Oct 07, 2006 at 07:32:25PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> Hi,
> 
> On Sat, 7 Oct 2006, Jakub Narebski wrote:
> 
> > Perhaps use undocumented (hint, hint! for whoever did code this)
> > per-user ~/.gitconfig?
> 
> A good idea to use this (hint, hint! whoever finds out how it works can 
> document it as well) feature.
> 
> HOWEVER, Junio pointed out that he'd like a finer grain than per-repo, and 
> .gitconfig is a coarser one!

Actually, that doesn't matter. The point is that it is of _different_
shape than this division. It's per remote server, even spanning several
repositories. So you want to be able to set it up per the server, at the
most global place possible for a regular user, so ~/.gitconfig might be
good idea.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
