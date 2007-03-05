From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Mon, 5 Mar 2007 15:04:59 +0100
Message-ID: <20070305140459.GA8464@elte.hu>
References: <20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu> <Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org> <20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu> <20070302102018.GA11549@elte.hu> <Pine.LNX.4.64.0703020824580.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 15:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HODwN-0005NT-Ap
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 15:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933426AbXCEONN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933454AbXCEONN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 09:13:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40281 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933426AbXCEONL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 09:13:11 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1HODvt-0005gB-BD
	from <mingo@elte.hu>; Mon, 05 Mar 2007 15:13:07 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 525633E2141; Mon,  5 Mar 2007 15:12:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703020824580.3953@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Received-SPF: softfail (mx2: transitioning domain of elte.hu does not designate 157.181.1.14 as permitted sender) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.1.7
	-2.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41443>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 2 Mar 2007, Ingo Molnar wrote:
> > 
> > but the conclusion is clear: if multiple bugs are present in the 
> > search area then it gets quite difficult to sort it out via 
> > git-bisect - but it's not impossible either. The following 
> > git-bisect enhancement could have made things easier for me:
> > 
> >    git-bisect mark-must-have <tree>
> 
> It's not quite that easy.
> 
> In _your_ case, you always just wanted to try to apply a particular 
> patch if it applied cleanly.

ok, agreed.

Suspend/resume bugs are a bit special anyway because so much stuff 
happens in an 'invisible' way during suspend/resume that any 
problem/hang during that 'looks like' the same bug symtpom: a hung 
resume.

so i'll put more effort into providing more suspend/resume debugging 
facilities - we have way too few tools of directly debugging them.

	Ingo
