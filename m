From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 20:29:54 +0200
Message-ID: <20060920182953.GT8259@pasky.or.cz>
References: <20060920161407.GQ8259@pasky.or.cz> <20060920162145.GA23260@spearce.org> <7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net> <20060920164912.GD23260@spearce.org> <7vac4uihr3.fsf@assigned-by-dhcp.cox.net> <20060920173126.GG23260@spearce.org> <20060919232851.GA12195@spearce.org> <7vac4ujzf0.fsf@assigned-by-dhcp.cox.net> <20060920161407.GQ8259@pasky.or.cz> <20060920162145.GA23260@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 20:30:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ6pb-00045i-QX
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 20:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWITS34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWITS34
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 14:29:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42135 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932215AbWITS3z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 14:29:55 -0400
Received: (qmail 14809 invoked by uid 2001); 20 Sep 2006 20:29:54 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060920173126.GG23260@spearce.org> <20060920162145.GA23260@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27391>

Dear diary, on Wed, Sep 20, 2006 at 06:21:45PM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> > >      combined with set of packs with staggered spans to help
> > >      commit walkers Pasky talked about quite a while ago).
> > 
> > Yes, this is certainly one of things I would like to implement at
> > repo.or.cz.
> 
> Borrowing your line:
> Hmm, I think I've missed this, I must look that in the archive.
> :-)

I've proposed something long time ago in
<20051112135947.GC30496@pasky.or.cz>.

Dear diary, on Wed, Sep 20, 2006 at 07:31:26PM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> Junio C Hamano <junkio@cox.net> wrote:
> > Shawn Pearce <spearce@spearce.org> writes:
> > > Originally I gave Pasky a one-liner on #git:
> > >
> > >   git fetch --force origin $(git ls-remote origin \
> > >       | awk '{if(!/\^{}$/){print $2":"$2}}')
> > 
> > Which sounds a very sane thing to do, especially given git is
> > designed to be scripted this way.
> 
> Exactly.  So I'm not sure why he was against it.  After all he must
> have some script that's looping over all mirrored repositories and
> invoking git fetch in them.  :-)

Basically, I imagined that what I wanted would be very close or
identical to git fetch --all (or whatever you call it, just doing it
with .git/refs/remotes) which I think should certainly be supported
without funny awk pipes. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
