From: Theodore Tso <tytso@mit.edu>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 12:15:24 -0400
Message-ID: <20070731161524.GA28645@thunk.org>
References: <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org> <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org> <20070731011707.GA91930@nowhere> <alpine.LFD.0.999.0707301825130.4161@woody.linux-foundation.org> <20070731042347.GG25876@thunk.org> <20070731135332.GA58867@nowhere> <alpine.LFD.0.999.0707310845490.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 18:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFuOO-0001r9-JI
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 18:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765573AbXGaQPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 12:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765557AbXGaQPo
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 12:15:44 -0400
Received: from THUNK.ORG ([69.25.196.29]:55726 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765537AbXGaQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 12:15:43 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IFuW3-0004an-QQ; Tue, 31 Jul 2007 12:24:12 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IFuNY-0001yo-Eu; Tue, 31 Jul 2007 12:15:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707310845490.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54362>

On Tue, Jul 31, 2007 at 08:50:19AM -0700, Linus Torvalds wrote:
> Very interesting. And thanks. The whole "ZFS is great" internet meme seems 
> to be partly due to not a lot of people having used or compared it in real 
> life. I'm sure it's wonderful for some things, but it clearly does have a 
> lot of downsides too. 

I'm pretty sure Sun's marketing machine is also very much part of it;
I'm not convinced all of the blogs pitching ZFS as the most wonderful
thing since sliced bread were all, shall we say, unbiased or
uninfluenced by Sun.  Add to that the fact that the Solaris 10 License
Agreement prohibits you from publishing benchmark numbers without
Sun's permisison, and it's not at all surprising that most of what
people have heard of ZFS has all been the positive stuff.  But with
more people playing with ZFS in the FreeBSD and OpenSolaris camps, I'm
sure a more balanced view that shows its advantages *and*
disadvantages will start showing up.

            	    	     	       - Ted
