From: Petr Baudis <pasky@suse.cz>
Subject: Re: Default remote branch for local branch
Date: Fri, 14 Apr 2006 18:16:27 +0200
Message-ID: <20060414161627.GA27689@pasky.or.cz>
References: <1143856098.3555.48.camel@dv> <7vodzmngfp.fsf@assigned-by-dhcp.cox.net> <1143865123.14465.26.camel@dv> <200604021817.30222.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 18:16:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUQxw-00087u-Pe
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 18:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDNQQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 12:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDNQQB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 12:16:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45792 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751248AbWDNQQB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 12:16:01 -0400
Received: (qmail 22732 invoked by uid 2001); 14 Apr 2006 18:16:27 +0200
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200604021817.30222.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18690>

Dear diary, on Sun, Apr 02, 2006 at 06:17:29PM CEST, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > I would write the config like this:
> > 
> > [branch-upstream]
> > master = linus
> > ata-irq-pio = irq-pio
> > ata-pata = pata-drivers
> 
> That is not working, as said above. But with above syntax extension,
> with s/=/for/ it would be fine.

I'm sorry but I'm slow and I don't see it - why wouldn't this work?
(Except that the key name is case insensitive, which isn't too big a
deal IMHO.)

I for one think that the 'for'-syntax is insane - it's unreadable (your
primary query is by far most likely to be "what's the upstream when on
branch X", not "what branches is this upstream for"), would convolute
the configuration file syntax unnecessarily and would possibly also
complicate the git-repo-config interface. Pavel's syntax is much nicer.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
