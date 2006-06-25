From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] GIT_TRACE: show which built-in/external commands are executed
Date: Sun, 25 Jun 2006 16:22:03 +0200
Message-ID: <20060625142203.GF21864@pasky.or.cz>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net> <E1FuV62-0004Jd-Ve@moooo.ath.cx> <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 16:22:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuVVD-0000Z6-Gx
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 16:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWFYOWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWFYOWG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 10:22:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49891 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751001AbWFYOWF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 10:22:05 -0400
Received: (qmail 12186 invoked by uid 2001); 25 Jun 2006 16:22:03 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606251607090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22629>

  Hi,

Dear diary, on Sun, Jun 25, 2006 at 04:11:48PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> P.S.: Now we only have to convert all "git-" invocations in the scripts to
> "git " invocations so we can benefit from it. But that would mean two 
> forks instead of one for the non-builtins. Hmm.

  actually this is a myth - not two fork()s since 'git' has no reason to
fork; only two execve()s in line after a single fork().

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
