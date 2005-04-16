From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 17:11:17 +0200
Message-ID: <20050416151116.GC19099@pasky.ji.cz>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: omb@bluewin.ch, David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:07:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMotZ-0003eJ-Cn
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVDPPLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVDPPLV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:11:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14830 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262680AbVDPPLS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 11:11:18 -0400
Received: (qmail 25863 invoked by uid 2001); 16 Apr 2005 15:11:17 -0000
To: "C. Scott Ananian" <cscott@cscott.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 04:58:15PM CEST, I got a letter
where "C. Scott Ananian" <cscott@cscott.net> told me that...
> On Sat, 16 Apr 2005, Brian O'Mahoney wrote:
> 
> >(1) I _have_ seen real-life collisions with MD5, in the context of
> >   Document management systems containing ~10^6 ms-WORD documents.
> 
> Dude!  You could have been *famous*!  Why the 
> aitch-ee-double-hockey-sticks didn't you publish this when you found it?
> Seriously, man.
> 
> Even given the known weaknesses in MD5, it would take much more than a 
> million documents to find MD5 collisions.  I can only conclude that the 
> hash was being used incorrectly; most likely truncated (my wild-ass guess 
> would be to 32 bits; a collision is likely with > 50% probability in a 
> million document store for a hash of less than 40 bits).
> 
> I know the current state of the art here.  It's going to take more than 
> just hearsay to convince me that full 128-bit MD5 collisions are likely. 
> I believe there are only two or so known to exist so far, and those were 
> found by a research team in China (which, yes, is fairly famous among the 
> cryptographic community now after publishing a paper consisting of little 
> apart from the two collisions themselves).

http://cryptography.hyperlink.cz/MD5_collisions.html

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
