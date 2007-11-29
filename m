From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 29 Nov 2007 09:24:12 +0100
Message-ID: <200711290924.12508.johan@herland.net>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <alpine.LFD.0.99999.0711271155250.9605@xanadu.home>
 <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixehq-00023k-9a
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 09:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbXK2IYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 03:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbXK2IYr
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 03:24:47 -0500
Received: from smtp.getmail.no ([84.208.20.33]:34694 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbXK2IYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 03:24:46 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JS900D0JE18FW00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 29 Nov 2007 09:24:44 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JS900ICOE0DJU40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 29 Nov 2007 09:24:13 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JS900C9RE0D83B0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 29 Nov 2007 09:24:13 +0100 (CET)
In-reply-to: <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66517>

On Thursday 29 November 2007, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > ...  In all the tutorials for $job I've done so 
> > far, I simply never talk about pull nor clone, but rather about init, 
> > "git remote", fetch and merge, with explicit and meaningful branch 
> > names.  I think that basic commands, even if there is a bit more of 
> > them, make Git easier to learn and understand than talking about those 
> > magic meta commands hiding the truth away.
> 
> That's actually a quite interesting approach for teaching.
> 
> The original "tutorial" (now core-tutorial) was similar in spirit; it
> built the user experience by starting at sequence of low level commands,
> and then finally said "since this is so often used combination, there is
> a short-hand for it that does all".  I think the approach would work
> quite well for people who want to use the tool with deep understanding.
> 
> However, I am not so sure about people who just want canned set of
> instructions and follow them blindly to get their work done.  And I do
> not think the latter classes of users are necessarily wrong.
> 
> Such a canned set of instructions would (if the project that supplies
> the cheat-sheet encourages merges instead of rebases) talk about "clone
> then commit then push then pull and repeat", without mentioning what
> pull does is fetch+merge nor what fetch means and what merge means, and
> that would let people get started without deeper understanding.
> 
> But the lack of deeper understanding would hurt them in the longer run
> (e.g. "my push was rejected with something called non-fast-forward ---
> what does that mean and what would I do now?").  

What about ending the cheat-sheet with a big fat link to a FAQ? The FAQ 
answers common questions like the above (resulting from the cheat-sheet 
glossing over the details) with links to appropriate sections in the more 
thorough introduction (core-tutorial), explaining what's _really_ going on.

Just a thought.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
