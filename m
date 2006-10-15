From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Sun, 15 Oct 2006 20:23:03 +0200
Message-ID: <20061015182303.GW20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egrgqe$1i9$1@sea.gmane.org> <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 20:23:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZAdk-0005d5-BY
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWJOSXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWJOSXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:23:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59022 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161081AbWJOSXG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 14:23:06 -0400
Received: (qmail 28295 invoked by uid 2001); 15 Oct 2006 20:23:04 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28924>

Dear diary, on Sun, Oct 15, 2006 at 01:06:10AM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> On 10/14/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >There is work by Jon Smirl and Shawn Pearce on CVS to Git importer which 
> >can
> >manage large and complicated (read: f*cked-up) Mozilla CVS repository.
> >  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#cvs2git
> 
> I am still working with the developers of the cvs2svn import tool to
> fix things so that Mozilla CVS can be correctly imported. There are
> still outstanding bugs in cvs2svn preventing a correct import. MozCVS
> can be imported, but the resulting repository is not entirely correct.
> 
> Once they get the base cvs2svn fixed I'll port my patches to turn it
> into cvs2git again.

So what exactly is the cvs2git status now? AFAIU, there's a tool that
parses the CVS repository and that is then "piped" to git-fastimport?
git-fastimport is available somewhere (perhaps it would be interesting
to publish it at repo.or.cz or something), is the current cvs2git
version available as well?

> >2. Good support for system which most important developers use, and good
> >support for system which most contributors use. If MS Windows is included
> >in those, then Git perhaps wouldn't be the best choice.
> 
> Better Windows support is needed to make git the first choice among
> the various SCMs.

And this is probably not likely to happen soon.

Well, I'm enlisted in a "Programming in Windows" course at my university
now and I had this kind of thoughts, but I really can't promise
anything. :-)

> >4. Good support for _large_ project, with large history. Namely, that
> >developer wouldn't need to download many megabytes and/or wouldn't need
> >megabytes of working area. How that is solved, be it partial checkouts,
> >lazy/shallow/sparse clone, subprojects, splitting into
> >projects/repositories and having some superproject or build-time
> >superproject, splitting repository into current and historical... that of
> >course depends on SCM.
> 
> git has issues here. The smallest Mozilla download we have built so
> far is 450MB for the initial checkout.

(BTW, yes, grafting the old history could help this time, but it is a
hack and not a good long-term solution - it is just putting the real
solution away until the project history will re-grew. Periodical
regrafting is even worse hack, since at that moment you break
fast-forwarding and this kind of "restarting the history" breaks deep
into the Git distributiveness.)

> >5. ....
> >
> >and probably few more
> 
> 
> The three most complex repositories are the kernel, gcc and Mozilla.
> Gcc is in SVN now. Mozilla CVS and the kernel git.

I believe OpenOffice CVS probably beats all three hands down very
easily. KDE is also very big, and I don't think NetBSD is just ISO
images either (if it contains any at all).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
