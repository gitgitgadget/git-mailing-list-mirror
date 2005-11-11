From: Petr Baudis <pasky@suse.cz>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 16:05:30 +0100
Message-ID: <20051111150530.GT30496@pasky.or.cz>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de> <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 16:08:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaaTn-0003Jk-Cu
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 16:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVKKPFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 10:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKKPFe
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 10:05:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60906 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750800AbVKKPFd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 10:05:33 -0500
Received: (qmail 8946 invoked by uid 2001); 11 Nov 2005 16:05:30 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11603>

  Hello,

Dear diary, on Fri, Nov 11, 2005 at 03:14:24PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Fri, 11 Nov 2005, Simon Richter wrote:
> 
> > As someone who carries around git repositories on VFAT formatted USB 
> > sticks, I welcome our symlink-deprived overlords.
> 
> Please note that symlinks are much more performant than symrefs. Working a 
> lot with switching branches, this matters.

  this is interesting. What operations get slowed down noticeably in
particular? Do you have any timing testcases and data at hand?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
