From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 15:47:40 +0200
Message-ID: <20061020134740.GI20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <eha9rq$5t7$2@sea.gmane.org> <vpqslhjyxlz.fsf@ecrins.imag.fr> <200610201520.42799.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 15:48:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gauiw-0007EP-7f
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 15:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992613AbWJTNrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 09:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992615AbWJTNrn
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 09:47:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2455 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S2992613AbWJTNrm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 09:47:42 -0400
Received: (qmail 28151 invoked by uid 2001); 20 Oct 2006 15:47:40 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610201520.42799.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29469>

Dear diary, on Fri, Oct 20, 2006 at 03:20:42PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Matthieu Moy wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> > >> If you're interested, it's called "Bugs Everywhere" and it's available here:
> > >> http://panoramicfeedback.com/opensource/
> > >> 
> > >> New VCS backends are welcome :-D
> > >
> > > While SCM can (and should be usually) distributed, I think that bugtracker
> > > has to be centralized.
> > 
> > Well, indeed, I think bug _reporting_ should be somehow centralized,
> > while bug _fixing_ can be decentralized: You fix a bug, you mark it as
> > fixed, and then the main branch gets the information that the bug is
> > fixed when the bugfix is merged.
> 
> But you don't need much infrastructure for branch fixing. Fix it in
> repository, and write bug number (you have to have centralized bugtracker
> for numbers) or bug identifier in commit message. You write (or post-commit
> hook writes) in bugtracker that bug was fixed in commit <commit-id>.
> You tell mainline to pull from you. That's all.

Yes but noone did the infrastructure yet. :-) Also, we need a way to
make it worth smooth, e.g. so that you don't have to download any
special stuff after cloning a branch - thus the post-commit hook needs
to be cloned too, but you also need to deal with the security
implications reasonably. (We would very much like to have "hooks
cloning" in Git in our in-SUSE usage as well; I didn't get to it yet.)

On a somewhat related note, I was on Microsoft's presentation at my
university about their Team Foundation Server. And Microsoft's clearly
aware that SourceSafe was a horrible crap and the version control in TFS
is much more advanced and even shows some signs of distributiveness (but
I don't know how much, the presenter did not know details about how it
works).

But their selling point really is the tight integration with bug
tracking and autobuild system. And it indeed does look pretty nice (when
you watch it, you might get quite a different perspective when actually
*using* it ;).

You can read my brief notes from the presentation at

	http://pasky.or.cz/~pasky/cp/tfs-lecture-notes.txt

It's a bit of bureaucracy for developers but managers will absolutely
*adore* it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
