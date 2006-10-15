From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Sun, 15 Oct 2006 21:24:58 +0200
Message-ID: <20061015192458.GY18879@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egrgqe$1i9$1@sea.gmane.org> <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com> <20061015182303.GW20017@pasky.or.cz> <20061015143956.86db3a8b.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 21:25:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZBc2-0005gj-DM
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 21:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWJOTZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 15:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWJOTZJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 15:25:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47791 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422817AbWJOTZB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 15:25:01 -0400
Received: (qmail 2352 invoked by uid 2001); 15 Oct 2006 21:24:58 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061015143956.86db3a8b.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28929>

On Sun, Oct 15, 2006 at 08:39:56PM CEST, Sean wrote:
> On Sun, 15 Oct 2006 20:23:03 +0200
> Petr Baudis <pasky@suse.cz> wrote:
> 
> > (BTW, yes, grafting the old history could help this time, but it is a
> > hack and not a good long-term solution - it is just putting the real
> > solution away until the project history will re-grew. Periodical
> > regrafting is even worse hack, since at that moment you break
> > fast-forwarding and this kind of "restarting the history" breaks deep
> > into the Git distributiveness.)
> 
> But is there a better practical solution he can use today?  I don't think
> there is.  And the experience of the Linux kernel has shown that it's not
> really all that big a problem.  You even made a nice script to help people
> do it! ;o)
> 
> It's probably not the solution that should be used _next_ time the repository
> grows too big, but it sure seems like the correct solution this time around.
> Not many people will want all that old history anyway (10+ years as i recall?).

Well I'm not saying it's the incorrect solution today, only that we
won't get around the problem by suggesting grafting forever. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
