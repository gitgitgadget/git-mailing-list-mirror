From: Petr Baudis <pasky@suse.cz>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 16:49:38 +0100
Message-ID: <20051111154938.GU30496@pasky.or.cz>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de> <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de> <20051111150530.GT30496@pasky.or.cz> <Pine.LNX.4.63.0511111636400.16210@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 16:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eab9s-0000fW-Qw
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKKPtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKKPtl
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:49:41 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32205 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750828AbVKKPtl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 10:49:41 -0500
Received: (qmail 12078 invoked by uid 2001); 11 Nov 2005 16:49:38 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511111636400.16210@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11609>

Dear diary, on Fri, Nov 11, 2005 at 04:40:43PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Fri, 11 Nov 2005, Petr Baudis wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > > 
> > > Please note that symlinks are much more performant than symrefs. Working a 
> > > lot with switching branches, this matters.
> > 
> > What operations get slowed down noticeably in particular?
> 
> Well, if you have to read two files instead of one, it is 100% slower ;-)

But you usually don't read the HEAD that often...

Besides, the kernel has to read the symlink file as well in order to
follow the symlink. ;-)

> Note that the only symlink/symref you usually have is .git/HEAD. But it 
> feels wrong to take the worse approach in *all* cases, just because 
> *one* brain-fscked file system/operating system does not support the 
> superior approach.

This is about being consistent, and also to support dumber protocols
better.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
