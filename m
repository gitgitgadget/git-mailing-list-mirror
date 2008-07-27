From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 28 Jul 2008 01:14:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 01:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNFTT-00065c-I0
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 01:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYG0XO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 19:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbYG0XO5
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 19:14:57 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:1959 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757745AbYG0XO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 19:14:56 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6RNE9Rt081061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 01:14:14 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90373>

Hi,

On Sun, 27 Jul 2008, Linus Torvalds wrote:

> > > > Is there a way to change that default?
> > > 
> > > Use an alias or something.
> > 
> > This doesn't help with the graphical front ends and they only use what git 
> > gives them.
> 
> And the graphical front-ends is exactly why --full-history cannot be the 
> default.

If you mean current gitk style --full-history I agree, the problem is 
still that git is hiding too much history with the simplified history...

> > Let's take a different example.
> 
> No, let's not.
> 
> Unless you can solve that _one_ example efficiently, nothing else matters. 
> 
> The above example is all you ever need. Make that one work right (and 
> efficiently), and everything is fine.
> 
> And no, some random ruby code doesn't make any difference what-so-ever. 
> There are efficiency constraints here that make any ruby solution be 
> unrealistic to begin with.

Why are you dismissing what I wrote without even giving it a second 
thought? I didn't bother with the initial example, because it's so 
simple, that it's no real challenge.
Did I say anywhere it had to be done in ruby? All I tried was to 
demonstrate a possible algorithm to solve the problem. I did time the 
execution and compared to the time it took to extract the history it 
wasn't significant for such a simple script.
What did I do wrong that you rebuff me based on this secondary problem 
(which I'm quite aware of, because it was me who mentioned in first place) 
and giving the primary problem (which is the missing history) no 
attention?

If you had any questions, I'd be happy to answer them. If you think that 
the demonstrated algorithm doesn't work, I'd be glad to know why. If the 
algorithm might work, any hint what could be do done to try it for real, 
would be great. But I don't get any of this. Why?

bye, Roman
