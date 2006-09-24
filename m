From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Sun, 24 Sep 2006 19:12:46 +0200
Message-ID: <20060924171246.GY13132@pasky.or.cz>
References: <11546624471356-git-send-email-martin@catalyst.net.nz> <20060924165037.GS20017@pasky.or.cz> <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:12:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXXB-0002tZ-A1
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWIXRMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWIXRMs
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:12:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12489 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751193AbWIXRMs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 13:12:48 -0400
Received: (qmail 5703 invoked by uid 2001); 24 Sep 2006 19:12:46 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90609241002i1db98ed6n118077089c9e417f@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27678>

Dear diary, on Sun, Sep 24, 2006 at 07:02:28PM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 9/24/06, Petr Baudis <pasky@suse.cz> wrote:
> >Hmm, I think this would be generally more useful during the actual merge
> >phase - if merge returns error, you fire up
> >git-magic-conflict-resolution-driver and have fun.
> 
> Well, in many cases the conflict markers are just ok and exactly what
> I want. If the two sides of the conflict are clear, the resolution is
> usually clear as well. OTOH, it may be a big mess where xxdiff gives
> more visual cues as to WTF is going on...
> 
> IOW I don't want it to be part of the merge automagically...

In that case I think the most natural way for this tool to interface
would be in part of some kind of cg-resolve swiss-army knife for
resolving conflicts:

	cg-resolve --mine	for taking just the version from _my_
				side of the merge
	cg-resolve --other	dtto for the other side of the merge
	cg-resolve -g		graphically resolve
				(vimdiff/xxdiff/meld/...)
	surely more would be invented over time

> >> +. git-sh-setup
> >
> >Uh-oh. :-)
> 
> Is that bad? <blush> I am not doing anything too cogito-specific, and
> I just don't know what cg-Xlib will do for me...

Well, all the Cogito scripts should have some consistent form. :-)

But I can adjust such details when applying your patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
