From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 18:51:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271846390.8976@alpha.polcom.net>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jon Smirl <jonsmirl@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 18:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G695X-0006jj-CH
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWG0Qvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWG0Qvv
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:51:51 -0400
Received: from alpha.polcom.net ([83.143.162.52]:8685 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751754AbWG0Qvu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 12:51:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id 3F9715FF2;
	Thu, 27 Jul 2006 18:51:48 +0200 (CEST)
Received: from alpha.polcom.net ([127.0.0.1])
 by localhost (alpha [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19540-01; Thu, 27 Jul 2006 18:51:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id F198748FA;
	Thu, 27 Jul 2006 18:51:41 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
X-Virus-Scanned: amavisd-new at alpha
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24302>

On Thu, 27 Jul 2006, Linus Torvalds wrote:
> So it's easy enough to just write whatever Java code or something to just
> access the databases yourself. The object model of git may be smart, but
> it's neither proprietary nor patented. I suspect it's often a lot easier
> to integrate git into other projects _that_ way, rather than try to
> actually port the code itself.

But won't it create hell of several buggy, incompatible, not well 
maintained versions of GIT (or at least GIT "client")?

I think that part of the anwser for question "Why do people use GIT?" is 
that they trust you and other maintainers that you do a good and stable 
job. Won't creating several ports/forks/whatever destroy at least part of 
this?

Besides it is a whole lot easier to just create some JNI code around 
libgit and use it from Java than to rewrite GIT (or part of it) in Java or 
in any other language. Also resulting code is likely to be (maybe not very 
much but still) faster.


Thanks,

Grzegorz Kulewski
