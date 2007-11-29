From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 29 Nov 2007 12:47:58 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711291236260.9605@xanadu.home>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site>
 <alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
 <20071127150829.GB3853@fieldses.org>
 <alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
 <20071127153411.GA11731@fieldses.org>
 <alpine.LFD.0.99999.0711271047590.9605@xanadu.home>
 <20071127164243.GE11731@fieldses.org>
 <alpine.LFD.0.99999.0711271155250.9605@xanadu.home>
 <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 18:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxnUw-0002tb-Vx
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 18:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXK2RsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbXK2RsE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 12:48:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55945 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbXK2RsC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 12:48:02 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00IO643Y6BM0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 12:48:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66549>

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
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

Sure.  However the people for whom I produced the cheat-sheet have to 
deal with the repo I maintain, which has multiple branches already, and 
using an explicit "git remote add" allows for better names than the 
default "origin".  Right there they become aware of the easy branching 
possibilities of Git.

And with a constantly rewritten history in that repo, they have to 
rebase after every fetch and there is no released Git version with a 
short-hand for fetch+rebase.


Nicolas
