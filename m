From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:25:23 +0200
Message-ID: <20061018002523.GJ20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzFR-00056m-0F
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWJRAZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWJRAZ0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:25:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47846 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751323AbWJRAZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:25:25 -0400
Received: (qmail 13041 invoked by uid 2001); 18 Oct 2006 02:25:23 +0200
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Disposition: inline
In-Reply-To: <vpqbqob5euu.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29149>

Dear diary, on Tue, Oct 17, 2006 at 02:03:21PM CEST, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> Sean <seanlkml@sympatico.ca> writes:
> 
> > On Tue, 17 Oct 2006 13:19:08 +0200
> > Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> >
> >> 1) a working tree without any history information, pointing to some
> >>    other location for the history itself (a la svn/CVS/...).
> >>    (this is "light checkout")
> >
> > Git can do this from a local repository, it just can't do it from
> > a remote repo (at least over the git native protocol).  However,
> > over gitweb you can grab and unpack a tarball from a remote repo.
> > In practice this is probably enough support for such a feature.
> 
> Anyway, given the price of disk space today,

(In rich countries. This may still be very different in poorer
countries.  E.g. some actual mplayer developer(s) from Turkey opposed
transition to a distributed version control system simply because they
have trouble affording the required additional diskspace for the full
history.  SVN is already very space-hungry for them.  (It stores
basically two complete checkouts in parallel.))

But the much bigger practical problem is bandwidth, plenty of people
still have internet connections where downloading several tens/hundreds
of megabytes of the complete history is quite a big thing, and the
servers ain't gonna be happy from that either, nor those paying the
bandwidth bills. ;-) And this is one of the big problems the Mozilla
guys have - having everyone download 450M worth of the full CVS-imported
history (and I'll bet no other VCS will beat that size) seems to be not
an option at all.

> this only makes sense if
> you have a fast access to the repository (otherwise, you consider your
> local repository as a cache, and you're ready to pay the disk space
> price to save your bandwidth). In this case, it's often in your
> filesystem (local or NFS).

So how is the light checkout actually implemented? Do you grab the
complete new snapshot each time the remote repository is updated? Do all
the (at least read-only, like "log" and "diff", perhaps "status")
commands work on such a light checkout?

This is something sorely missing in Git but if it's really only "we just
provide bandwidth-expensive way to keep your tree up-to-date and that's
all," that would not be hard at all to implement in Git too, using
git-archive --remote.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
