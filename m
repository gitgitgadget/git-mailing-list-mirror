From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 02:00:26 +0200
Message-ID: <20061018000026.GH20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610171555.56778.jnareb@gmail.com> <vpqr6x711cm.fsf@ecrins.imag.fr> <200610171641.04455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:06:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZyxR-0001Y7-3K
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWJRAA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJRAA3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:00:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3968 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751127AbWJRAA2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:00:28 -0400
Received: (qmail 10319 invoked by uid 2001); 18 Oct 2006 02:00:26 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610171641.04455.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29139>

Dear diary, on Tue, Oct 17, 2006 at 04:41:02PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> "Bundle" equivalent, although binary in nature, would be thin pack.

It should be noted that there's no user interface for sending/receiving
that and I suspect no reasonably usable user interface for creating it.

How frequently are the bundles used in practice?

It's a cultural difference, I suspect. Git comes from an environment
based on intensive exchanges of patches and patch series and an
environment not mandating developers to use any tool besides diff/patch,
so Git is very focused at good support for applying patches and there
simply has been no big conscious demand for bundles support given this.

Another aspect of this is that Git (Linus ;) is very focused on getting
the history right, nice and clean (though it does not _mandate_ it and
you can just wildly do one commit after another; it just provides tools
to easily do it). This means that the downstream maintainers have to
rebase patches, possibly reorder them, and update the changesets with
bugfixes instead of stacking the bugfixes upon them in separate changes
- then Linus merges the patches and only at that point they are "etched"
forever. This means that the history will contain neatly laid out way
of how $FEATURE was achieved, but of course also more work for
downstream maintainers.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
