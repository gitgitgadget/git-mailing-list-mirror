From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Sun, 24 Sep 2006 19:28:38 +0200
Message-ID: <20060924172838.GZ13132@pasky.or.cz>
References: <11546624471356-git-send-email-martin@catalyst.net.nz> <20060924165037.GS20017@pasky.or.cz> <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com> <20060924171246.GY13132@pasky.or.cz> <46a038f90609241022i6ac11da1o1a1cba199595d036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:28:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXmV-0005xb-Dt
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWIXR2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWIXR2k
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:28:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39320 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751228AbWIXR2j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 13:28:39 -0400
Received: (qmail 8713 invoked by uid 2001); 24 Sep 2006 19:28:38 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90609241022i6ac11da1o1a1cba199595d036@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27680>

Dear diary, on Sun, Sep 24, 2006 at 07:22:35PM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 9/24/06, Petr Baudis <pasky@suse.cz> wrote:
> >In that case I think the most natural way for this tool to interface
> >would be in part of some kind of cg-resolve swiss-army knife for
> >resolving conflicts:
> >
> >       cg-resolve --mine       for taking just the version from _my_
> >                               side of the merge
> >       cg-resolve --other      dtto for the other side of the merge
> >       cg-resolve -g           graphically resolve
> >                               (vimdiff/xxdiff/meld/...)
> >       surely more would be invented over time
> 
> Sounds reasonable. But I think we have to keep in mind that you only
> know if the conflict is nasty after you have a go at fixing it. And I
> sometimes find that I try with cg-xxdiff... and I go back to the plain
> old conflict. That is why it doesn't clobber the file -- to protect a
> manual merge in process.

Oh yes, I wanted to complain about that. ;-)

Yes, sometimes it is useful to go back, but I guess most of the time
probably not (not speaking from the experience though) and I hate tools
which leave random copies of a file I have tracked in a VCS around and I
have to collect their garbage manually.

The tool should just have a way to tell it "cancel" in case of trouble
and restore the original state of the file. And of course

	cg-resolve --remerge	re-run the 3-way merge on the file

would be useful anyway.

> >But I can adjust such details when applying your patch.
> 
> Great! -- I'm travelling and at an airport "free access" computer. It
> should be illegal to run airports without free wifi in this day and
> age.

Heartily agreed.

We should always suggest the locals to build yet another airport right
near the old one to promote free market and competition!

And when one of them bankrupts it could make for a nice paintball arena,
I guess.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
